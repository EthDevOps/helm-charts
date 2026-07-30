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
| `hub.linear.existingSecret` | Secret with `linear-api-key` |
| `hub.database.existingSecret` | Secret with `database-dsn` (postgres:// URL) |

Optional — the Mattermost approval flow (recommended; without it,
approval-gated requests stay pending and are only visible on the Linear
issue):

| Value | Description |
|---|---|
| `hub.mattermost.url` | Mattermost base URL, e.g. `https://chat.example.org` |
| `hub.mattermost.existingSecret` | Secret with `mattermost-bot-token` |

In practice all the `existingSecret`s point at the same ESO-managed secret.

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
