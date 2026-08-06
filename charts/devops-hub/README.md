# devops-hub Helm chart

Deploys the EF DevOps Hub: a single container serving the Go API and the
built SPA on `:8080`. SAML-authenticated; talks to the Google Admin SDK
(directory profiles), the Linear API (request portal), PostgreSQL (request
store) and a Mattermost bot (approval DMs + yes/no reply listener).

Intended to be published to [ethdevops/helm-charts](https://github.com/ethdevops/helm-charts)
and consumed by the ArgoCD wrapper chart in
`internal-stack-iac/ethquokkaops/devops-hub/`.

## Required values

| Value | Description |
|---|---|
| `hub.rootUrl` | External base URL (SAML SP root) |
| `hub.saml.idpMetadataUrl` | IdP SAML metadata endpoint |
| `hub.saml.existingSecret` | Secret with SP keypair (`saml-sp-cert`, `saml-sp-key`) |
| `hub.google.impersonateAdmin` | Workspace admin for domain-wide delegation |
| `hub.google.existingSecret` | Secret with `google-service-account-key` (JSON) |
| `hub.linear.teamKey` | Linear team short key (e.g. `DEV`) |
| `hub.linear.oauthExistingSecret` | Secret with `linear-client-id` + `linear-client-secret` (Hub-Bot OAuth app, preferred) — or `hub.linear.existingSecret` with `linear-api-key` (legacy personal key, used when the OAuth secret is unset) |
| `hub.database.existingSecret` | Secret with `database-dsn` (postgres:// URL) |

Optional — the Mattermost approval flow (recommended; without it,
approval-gated requests stay pending and are only visible on the Linear
issue):

| Value | Description |
|---|---|
| `hub.mattermost.url` | Mattermost base URL, e.g. `https://chat.example.org` |
| `hub.mattermost.existingSecret` | Secret with `mattermost-bot-token` |

Optional — Linear webhooks (near-real-time issue/comment mirroring instead
of relying on the poll):

| Value | Description |
|---|---|
| `hub.linear.webhookExistingSecret` | Secret with `linear-webhook-secret` (the OAuth app webhook's signing secret); enables `POST /webhooks/linear`, which must be reachable from Linear's cloud (public exposure) |
| `hub.trackerSyncInterval` | Poll cadence (Go duration). With webhooks on, slow it to a reconciliation pass, e.g. `30m` |

In practice all the `existingSecret`s point at the same ESO-managed secret.

## Request templates as config

`hub.requestTemplates` (optional) replaces the request-form catalog compiled
into the image: keys are filenames (one template per file), values are
template YAML in the format documented in the hub repo's `docs/TEMPLATES.md`
(the shipped catalog in `backend/internal/requests/templates/` doubles as
reference copies). When set it renders a ConfigMap mounted at
`/etc/hub/templates` and the catalog **replaces the built-ins entirely**, so
include every template the hub should offer. Pods roll automatically when
the catalog changes (checksum annotation); the backend validates the catalog
at boot and refuses to start on errors, so a broken catalog fails the
rollout while old pods keep serving. Left empty, the image's built-in
catalog applies.

```yaml
hub:
  requestTemplates:
    general.yaml: |
      id: general
      name: General DevOps Request
      ...
```

## Exposure

- `service.teleport.enabled` — internal access via Teleport app access
  (labels `ethquokkaops.io/expose-to-teleport` / `allow-ef-org`).
- `service.public.enabled` + `service.public.domain` — public LB exposure
  (`ethquokkaops.io/expose-public`); SAML still gates every request.

## Notes

- The image runs as distroless nonroot (uid 65532), read-only rootfs, no
  capabilities; passes `pod-security.kubernetes.io: restricted`.
- `hub.authMode` must stay `saml` in clusters — `dev` bypasses auth and is
  for local development only.
- The pods are stateless: requests persist in PostgreSQL (`hub.database`),
  so `replicaCount` > 1 is fine. Every replica listens for approval replies;
  decisions are recorded exactly once (guarded update), though courtesy
  prompts ("reply yes or no") may be sent per replica.
