# Huly Helm Chart

Deploy [Huly](https://huly.io) — an open-source project management platform — on Kubernetes.

Chart version: **0.2.0** &nbsp;|&nbsp; App version: **v0.7.382**

## Prerequisites

- Kubernetes 1.25+
- Helm 3.10+
- An Ingress controller (NGINX is the default; any controller works — see [Ingress](#ingress))
- [cert-manager](https://cert-manager.io/) (only if you want chart-managed TLS via the bundled Ingress)
- An S3-compatible object store (rustfs, MinIO operator, AWS S3, R2, B2, etc.) — bundled MinIO is **off by default** and exists only as a testing convenience

## Quick Start

```bash
helm install huly ./charts/huly \
  --set domain=huly.mysite.com \
  --set storage.type=s3 \
  --set storage.s3.endpoint=https://s3.example.com \
  --set storage.s3.region=us-east-1 \
  --set storage.s3.accessKey=YOUR_KEY \
  --set storage.s3.secretKey=YOUR_SECRET \
  --set storage.s3.rootBucket=huly
```

This deploys:

- The Huly application services (front, account, transactor, collaborator, workspace, fulltext, rekoni, stats, kvs)
- Bundled CockroachDB, Redpanda, and Elasticsearch (toggle off to point at external instances)
- An Ingress resource per backend, all under a single hostname

All chart-managed secrets (`SERVER_SECRET`, `COCKROACH_PASSWORD`, `REDPANDA_SUPERUSER_PASSWORD`, etc.) are auto-generated on first install and persist across `helm upgrade` via Kubernetes Secret lookup.

To use a Secret you manage yourself instead, see [Using an external Secret](#using-an-external-secret).

## Service Exposure (LoadBalancer / NodePort)

By default every Service is `ClusterIP` and external traffic flows through the Ingress. To expose a Service directly — for a cloud LoadBalancer, NodePort, or external-dns wiring — set its `service:` block.

Each component (`front`, `account`, `transactor`, `collaborator`, `fulltext`, `rekoni`, `stats`, `kvs`, `aibot`, `githubIntegration`) accepts:

```yaml
<component>:
  service:
    type: ClusterIP            # ClusterIP | NodePort | LoadBalancer | ExternalName
    annotations: {}            # merged with serviceDefaults.annotations
    loadBalancerIP: ""
    loadBalancerClass: ""
    loadBalancerSourceRanges: []
    externalTrafficPolicy: ""  # Local | Cluster
    ipFamilyPolicy: ""         # SingleStack | PreferDualStack | RequireDualStack
    ipFamilies: []
    allocateLoadBalancerNodePorts: null
    nodePort: null             # explicit NodePort number (NodePort/LB only)
    clusterIP: ""              # set "None" for headless
```

Common patterns:

```yaml
# Front behind a cloud LoadBalancer with external-dns + source-IP preservation
front:
  service:
    type: LoadBalancer
    externalTrafficPolicy: Local
    annotations:
      external-dns.alpha.kubernetes.io/hostname: huly.example.com
      service.beta.kubernetes.io/aws-load-balancer-type: nlb
    loadBalancerSourceRanges:
      - 10.0.0.0/8
```

```yaml
# Transactor as NodePort with a fixed port
transactor:
  service:
    type: NodePort
    nodePort: 30333
```

Annotations under `serviceDefaults.annotations` apply to every component's Service and are merged with per-component overrides.

WebSocket services (`transactor`, `collaborator`) need long idle timeouts on the LoadBalancer — most cloud LB annotations support this; the Ingress path already configures 3600s for nginx.

## Authentication

At least one auth provider should be configured. Without one, users cannot sign in.

```bash
# Google
--set auth.google.clientId=YOUR_CLIENT_ID \
--set auth.google.clientSecret=YOUR_CLIENT_SECRET

# GitHub
--set auth.github.clientId=YOUR_CLIENT_ID \
--set auth.github.clientSecret=YOUR_CLIENT_SECRET

# OIDC
--set auth.oidc.clientId=YOUR_CLIENT_ID \
--set auth.oidc.clientSecret=YOUR_CLIENT_SECRET \
--set auth.oidc.issuer=https://accounts.example.com

# Disable public signup
--set auth.disableSignup=true
```

When using `secrets.existingSecret`, the value of `auth.<provider>.clientId` doubles as a feature flag — set it to any non-empty placeholder to wire the env vars on the `account` Deployment; the chart reads the actual values from your external Secret.

## Storage

Production should use external S3-compatible storage:

```bash
--set storage.type=s3 \
--set storage.s3.endpoint=https://s3.example.com \
--set storage.s3.region=us-east-1 \
--set storage.s3.accessKey=KEY \
--set storage.s3.secretKey=SECRET \
--set storage.s3.rootBucket=huly
```

**Bucket modes:**
- `rootBucket` — all workspaces share one bucket, isolated by workspace-ID prefix (recommended)
- `bucketPrefix` — each workspace gets its own bucket, prefixed with this string

`storage.type=s3` automatically disables the bundled MinIO deployment and PVC.

**Bundled MinIO** is OFF by default. Set `minio.enabled=true` and `storage.type=minio` for testing only — `MINIO_ROOT_USER`/`MINIO_ROOT_PASSWORD` are auto-generated alongside `STORAGE_CONFIG` and kept in sync via the chart-managed Secret.

## External Infrastructure

Each built-in infra service can be disabled to use an external instance.

```bash
# External CockroachDB / Postgres-wire compatible
--set cockroach.enabled=false \
--set secrets.crDbUrl='postgres://user:pass@db.example.com:26257/huly'

# External Redpanda / Kafka
--set redpanda.enabled=false \
--set external.redpanda=kafka.example.com:9092

# External Elasticsearch
--set elastic.enabled=false \
--set external.elastic=https://es.example.com:9200

# External MongoDB (only relevant when aibot.enabled=true)
--set mongodb.enabled=false \
--set external.mongodb=mongodb://user:pass@mongo.example.com:27017
```

## Using an External Secret

To manage credentials outside the chart (external-secrets, sealed-secrets, Vault, SOPS, etc.), point `secrets.existingSecret` at a Secret you create yourself. The chart will skip generating its own Secret and reference yours from every Deployment.

```yaml
secrets:
  existingSecret: huly-shared
```

When set:
- The chart-managed Secret is **not** created.
- Every `secretKeyRef` resolves to `huly-shared`.
- Pod restarts triggered by Secret changes are **not** automatic (the chart can't checksum a Secret it doesn't render). Trigger restarts yourself when rotating, e.g. `kubectl rollout restart deployment -l app.kubernetes.io/part-of=huly`.

Backup credentials use a separate Secret. Set `backup.existingSecret` to point at it the same way.

### Required keys in `secrets.existingSecret`

Always required:

| Key | Format / Notes |
|-----|----------------|
| `SERVER_SECRET` | Shared JWT signing secret. 32+ chars of entropy. |
| `STORAGE_CONFIG` | Full storage config string. See [STORAGE_CONFIG format](#storage_config-format) below. |
| `CR_DB_URL` | `postgres://user:pass@host:26257/db` — Cockroach/Postgres-wire URL. |

Required when the corresponding feature is enabled (chart still expects the key to exist):

| Key | Required when | Notes |
|-----|---------------|-------|
| `COCKROACH_PASSWORD` | `cockroach.enabled=true` | Cockroach `--insecure` accepts any value, but the key must be present. |
| `REDPANDA_SUPERUSER_PASSWORD` | `redpanda.enabled=true` | Redpanda superuser password. |
| `AIBOT_PASSWORD` | `aibot.enabled=true` | AI bot account password. |
| `OPENAI_API_KEY` | `aibot.enabled=true` | OpenAI API key. |
| `OPENAI_BASE_URL` | optional, with `aibot.enabled=true` | Override OpenAI base URL (Azure OpenAI, proxy). |
| `MINIO_ROOT_USER` | `minio.enabled=true` + `storage.type=minio` | Must match the `accessKey=` inside `STORAGE_CONFIG`. |
| `MINIO_ROOT_PASSWORD` | `minio.enabled=true` + `storage.type=minio` | Must match the `secretKey=` inside `STORAGE_CONFIG`. |

Auth providers — required when the matching `auth.<provider>.clientId` is set to any non-empty value (the value of `clientId` only acts as a flag; the actual credentials live in the Secret):

| Key | Required when |
|-----|---------------|
| `GOOGLE_CLIENT_ID` | `auth.google.clientId` is set |
| `GOOGLE_CLIENT_SECRET` | `auth.google.clientId` is set |
| `GITHUB_CLIENT_ID` | `auth.github.clientId` is set |
| `GITHUB_CLIENT_SECRET` | `auth.github.clientId` is set |
| `OPENID_CLIENT_ID` | `auth.oidc.clientId` is set |
| `OPENID_CLIENT_SECRET` | `auth.oidc.clientId` is set |
| `OPENID_ISSUER` | `auth.oidc.clientId` is set |

GitHub App integration — required when `githubIntegration.enabled=true`:

| Key | Notes |
|-----|-------|
| `GITHUB_APP_ID` | Numeric App ID. |
| `GITHUB_APP_CLIENT_ID` | App Client ID. |
| `GITHUB_APP_CLIENT_SECRET` | App Client Secret. |
| `GITHUB_APP_PRIVATE_KEY` | PEM-encoded private key (multi-line). |
| `GITHUB_APP_WEBHOOK_SECRET` | Webhook signing secret. |

### `STORAGE_CONFIG` format

External S3 (rustfs, AWS S3, R2, B2, MinIO operator, etc.):

```
s3|<endpoint>?accessKey=<key>&secretKey=<secret>&region=<region>&rootBucket=<bucket>
```

Bundled MinIO (only used when `storage.type=minio`):

```
minio|minio?accessKey=<key>&secretKey=<secret>
```

Examples:

```
s3|https://rustfs.internal:9000?accessKey=AKIA...&secretKey=wJal...&region=us-east-1&rootBucket=huly
s3|https://s3.amazonaws.com?accessKey=AKIA...&secretKey=wJal...&region=us-east-1&bucketPrefix=huly-
```

Either `rootBucket` (single bucket, workspace-ID prefix) or `bucketPrefix` (one bucket per workspace) — not both.

### Required keys in `backup.existingSecret`

When `backup.enabled=true` and `backup.existingSecret` is set, the Secret must contain:

| Key | Notes |
|-----|-------|
| `BACKUP_S3_ENDPOINT` | e.g. `https://nbg1.your-objectstorage.com` |
| `BACKUP_S3_REGION` | S3 region, may be empty for some providers. |
| `BACKUP_S3_BUCKET` | Destination bucket name. |
| `BACKUP_S3_PATH_PREFIX` | Path prefix inside the bucket. |
| `BACKUP_S3_ACCESS_KEY` | Backup S3 access key. |
| `BACKUP_S3_SECRET_KEY` | Backup S3 secret key. |

### Example external Secret

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: huly-shared
  namespace: huly
type: Opaque
stringData:
  SERVER_SECRET: "32-char-random-string"
  STORAGE_CONFIG: "s3|https://rustfs.internal:9000?accessKey=AKIA...&secretKey=wJal...&region=us-east-1&rootBucket=huly"
  CR_DB_URL: "postgres://selfhost:pw@cockroach:26257/defaultdb"
  COCKROACH_PASSWORD: "pw"
  REDPANDA_SUPERUSER_PASSWORD: "rp-superuser-pw"
  AIBOT_PASSWORD: "ignored-when-aibot-disabled"
  GOOGLE_CLIENT_ID: "..."
  GOOGLE_CLIENT_SECRET: "..."
```

Then:

```bash
helm install huly ./charts/huly \
  --set domain=huly.example.com \
  --set secrets.existingSecret=huly-shared \
  --set storage.type=s3 \
  --set storage.s3.endpoint=https://rustfs.internal:9000 \
  --set auth.google.clientId=enabled  # placeholder; actual value comes from the Secret
```

## GitHub Integration

Bidirectional sync of issues, PRs, and comments between Huly and GitHub. Requires a [GitHub App](https://docs.github.com/en/apps/creating-github-apps).

```bash
helm install huly ./charts/huly \
  --set domain=huly.mysite.com \
  --set githubIntegration.enabled=true \
  --set githubIntegration.appId=123456 \
  --set githubIntegration.clientId=Iv1.abc123 \
  --set githubIntegration.clientSecret=YOUR_SECRET \
  --set-file githubIntegration.privateKey=path/to/private-key.pem \
  --set githubIntegration.webhookSecret=YOUR_WEBHOOK_SECRET \
  --set githubIntegration.botName="your-app-name[bot]"
```

**GitHub App settings:**

| Field | Value |
|-------|-------|
| Callback URL | `https://<domain>/github` |
| Setup URL | `https://<domain>/github?op=installation` |
| Webhook URL | `https://<domain>/_github/api/webhook` |
| Permissions | Issues R/W, PRs R/W, Contents R, Metadata R |
| Events | Issues, Issue comment, Pull request, PR review, PR review comment, PR review thread |

## AI Bot

Optional AI assistant powered by OpenAI.

```bash
helm install huly ./charts/huly \
  --set domain=huly.mysite.com \
  --set aibot.enabled=true \
  --set secrets.openaiApiKey=sk-...
```

`aibot.enabled=true` also brings up a bundled MongoDB unless you set `mongodb.enabled=false` and provide `external.mongodb`.

## Backup

Nightly CronJobs that dump CockroachDB, files, and (when aibot is enabled) MongoDB to an S3-compatible store via rclone.

```yaml
backup:
  enabled: true
  schedule: "0 2 * * *"
  retentionDays: 30
  s3:
    endpoint: https://nbg1.your-objectstorage.com
    region: ""
    bucket: my-backups
    pathPrefix: huly-prod
    accessKey: ...
    secretKey: ...
```

Or with an external Secret (see [Required keys in backup.existingSecret](#required-keys-in-backupexistingsecret)):

```yaml
backup:
  enabled: true
  existingSecret: huly-backup-credentials
```

## Ingress

A path-based Ingress for each backend (account, transactor, collaborator, rekoni, stats, plus optional aibot/github) plus a catch-all for `front`, all sharing one hostname and TLS secret.

```yaml
ingress:
  enabled: true
  className: nginx                    # any controller — nginx-specific
                                      # annotations are only emitted when
                                      # className == "nginx"
  annotations: {}                     # merged into every Ingress
  tls:
    enabled: true
    clusterIssuer: letsencrypt-prod
```

Path mapping (under your domain):

- `/` → front
- `/_accounts` → account
- `/_transactor` → transactor (WebSocket)
- `/_collaborator` → collaborator (WebSocket)
- `/_rekoni` → rekoni
- `/_stats` → stats
- `/_github` → github (when enabled)
- `/_aibot` → aibot (when enabled)

To expose a backend directly bypassing the Ingress, see [Service Exposure](#service-exposure-loadbalancer--nodeport).

## Upgrading

### Version bumps

```bash
helm upgrade huly ./charts/huly \
  --reuse-values \
  --set hulyVersion=v0.7.400
```

App service pods restart automatically (via `checksum/secret` and `checksum/config` annotations) when the rendered Secret or ConfigMap changes. Infrastructure services (CockroachDB, Redpanda, Elasticsearch) are **not** restarted on config changes. When using `secrets.existingSecret`, the secret checksum is omitted — restart pods manually after rotating.

### From bundled MinIO to external S3

```bash
helm upgrade huly ./charts/huly \
  --reuse-values \
  --set storage.type=s3 \
  --set storage.s3.endpoint=https://s3.example.com \
  --set storage.s3.region=us-east-1 \
  --set storage.s3.accessKey=KEY \
  --set storage.s3.secretKey=SECRET \
  --set storage.s3.rootBucket=huly-data
```

After confirming S3 works, clean up the orphaned MinIO PVC:

```bash
kubectl delete pvc minio-data -n <namespace>
```

## Troubleshooting

### Services fail to start with connection errors

App services depend on CockroachDB and Redpanda. Init containers wait for them to accept connections, but on a slow first install you may still see `ECONNREFUSED` / `ENOTFOUND` retried for a minute or two. If pods stay in CrashLoopBackOff:

```bash
kubectl rollout restart deployment/account deployment/transactor \
  deployment/workspace deployment/fulltext -n <namespace>
```

### CockroachDB password issues

Built-in CockroachDB runs `--insecure`, so authentication is disabled. The `COCKROACH_PASSWORD` is set during user init but not enforced. To use the `root` user instead:

```bash
--set cockroach.username=root \
--set secrets.crDbUrl='postgres://root@cockroach:26257/defaultdb?sslmode=disable'
```

### Checking pod health

```bash
kubectl get pods -l app.kubernetes.io/part-of=huly -n <namespace>
kubectl logs deployment/<service> -n <namespace> --tail=20
```

## Values Reference

### Required

| Key | Description | Default |
|-----|-------------|---------|
| `domain` | Hostname for the deployment (e.g. `huly.example.com`) | `huly.example` |

### Secrets

| Key | Description | Default |
|-----|-------------|---------|
| `secrets.existingSecret` | Name of an externally-managed Secret. When set, the chart skips its own Secret. See [required keys](#required-keys-in-secretsexistingsecret). | `""` |
| `secrets.serverSecret` | JWT signing secret (auto-generated if empty) | `""` |
| `secrets.storageConfig` | Full `STORAGE_CONFIG` override | `""` |
| `secrets.crDbUrl` | Cockroach/Postgres connection URL | `""` |
| `secrets.cockroachPassword` | Cockroach user password | `""` |
| `secrets.redpandaPassword` | Redpanda superuser password | `""` |
| `secrets.aibotPassword` | AI bot account password | `""` |
| `secrets.openaiApiKey` | OpenAI API key (required with `aibot.enabled=true`) | `""` |
| `secrets.openaiBaseUrl` | OpenAI base URL override | `""` |

### Authentication

| Key | Description | Default |
|-----|-------------|---------|
| `auth.google.clientId` | Google OAuth client ID | `""` |
| `auth.google.clientSecret` | Google OAuth client secret | `""` |
| `auth.github.clientId` | GitHub OAuth client ID | `""` |
| `auth.github.clientSecret` | GitHub OAuth client secret | `""` |
| `auth.oidc.clientId` | OIDC client ID | `""` |
| `auth.oidc.clientSecret` | OIDC client secret | `""` |
| `auth.oidc.issuer` | OIDC issuer URL | `""` |
| `auth.disableSignup` | Prevent new user registration | `false` |

### Storage

| Key | Description | Default |
|-----|-------------|---------|
| `storage.type` | `minio` (bundled — testing only) or `s3` (external) | `minio` |
| `storage.s3.endpoint` | S3 endpoint URL | `""` |
| `storage.s3.region` | S3 region | `""` |
| `storage.s3.accessKey` | S3 access key | `""` |
| `storage.s3.secretKey` | S3 secret key | `""` |
| `storage.s3.rootBucket` | Single shared bucket (workspace-ID prefix) | `""` |
| `storage.s3.bucketPrefix` | Per-workspace bucket name prefix | `""` |

### Ingress

| Key | Description | Default |
|-----|-------------|---------|
| `ingress.enabled` | Render Ingress resources | `true` |
| `ingress.className` | IngressClass name | `nginx` |
| `ingress.annotations` | Annotations merged into every Ingress | `{}` |
| `ingress.tls.enabled` | Enable TLS via cert-manager | `true` |
| `ingress.tls.clusterIssuer` | cert-manager ClusterIssuer name | `letsencrypt-prod` |

### Service Defaults

| Key | Description | Default |
|-----|-------------|---------|
| `serviceDefaults.type` | Default Service type | `ClusterIP` |
| `serviceDefaults.annotations` | Annotations merged into every component Service | `{}` |

Each component (`front`, `account`, `transactor`, `collaborator`, `fulltext`, `rekoni`, `stats`, `kvs`, `aibot`, `githubIntegration`) accepts a `service:` block with the schema documented under [Service Exposure](#service-exposure-loadbalancer--nodeport).

### App Settings

| Key | Description | Default |
|-----|-------------|---------|
| `appSettings.title` | Browser title | `Huly Self Host` |
| `appSettings.defaultLanguage` | Default UI language | `en` |
| `appSettings.lastNameFirst` | Display last name first | `true` |
| `appSettings.modelEnabled` | Enabled platform models | `*` |
| `appSettings.adminEmails` | Comma-separated admin emails | `""` |
| `appSettings.desktopChannel` | Desktop update channel | `selfhost` |

### Infrastructure

| Key | Description | Default |
|-----|-------------|---------|
| `cockroach.enabled` | Deploy bundled CockroachDB | `true` |
| `cockroach.image` | CockroachDB image | `cockroachdb/cockroach:v24.2.6` |
| `cockroach.storage` | Data PVC size | `10Gi` |
| `cockroach.storageClassName` | PVC storage class | `""` |
| `cockroach.database` | Database name | `defaultdb` |
| `cockroach.username` | Database user | `selfhost` |
| `redpanda.enabled` | Deploy bundled Redpanda | `true` |
| `redpanda.image` | Redpanda image | pinned in `values.yaml` |
| `redpanda.storage` | Data PVC size | `5Gi` |
| `elastic.enabled` | Deploy bundled Elasticsearch | `true` |
| `elastic.image` | Elasticsearch image | `elasticsearch:7.14.2` |
| `elastic.storage` | Data PVC size | `10Gi` |
| `elastic.javaOpts` | JVM heap options | `-Xms1024m -Xmx1024m` |
| `minio.enabled` | Deploy bundled MinIO (testing only) | `false` |
| `minio.image` | MinIO image | pinned in `values.yaml` |
| `minio.storage` | Data PVC size | `50Gi` |
| `mongodb.enabled` | Deploy bundled MongoDB (only used by aibot) | `true` |
| `mongodb.image` | MongoDB image | `mongo:7.0.16` |
| `mongodb.storage` | Data PVC size | `5Gi` |

### External Infrastructure

| Key | Description | Default |
|-----|-------------|---------|
| `external.redpanda` | Kafka-compatible broker (when `redpanda.enabled=false`) | `""` |
| `external.elastic` | Elasticsearch URL (when `elastic.enabled=false`) | `""` |
| `external.mongodb` | MongoDB URL (when `mongodb.enabled=false`) | `""` |

### Application Services

All app services accept `<svc>.replicas` and `<svc>.resources`. Components with a Service also accept `<svc>.service`.

| Key | Description | Default |
|-----|-------------|---------|
| `hulyVersion` | Image tag for all Huly services | `v0.7.382` |
| `hulyRegistry` | Image registry prefix | `hardcoreeng` |
| `kvs.enabled` | Deploy KVS service | `true` |

### GitHub Integration

| Key | Description | Default |
|-----|-------------|---------|
| `githubIntegration.enabled` | Deploy GitHub integration service | `false` |
| `githubIntegration.replicas` | Replica count | `1` |
| `githubIntegration.botName` | Bot display name (`<app-slug>[bot]`) | `""` |
| `githubIntegration.appId` | GitHub App ID | `""` |
| `githubIntegration.clientId` | GitHub App Client ID | `""` |
| `githubIntegration.clientSecret` | GitHub App Client Secret | `""` |
| `githubIntegration.privateKey` | GitHub App Private Key (PEM) | `""` |
| `githubIntegration.webhookSecret` | GitHub App Webhook Secret | `""` |

### AI Bot

| Key | Description | Default |
|-----|-------------|---------|
| `aibot.enabled` | Deploy AI bot service | `false` |
| `aibot.replicas` | Replica count | `1` |
| `aibot.firstName` | Bot display first name | `Huly` |
| `aibot.lastName` | Bot display last name | `AI` |
| `aibot.openaiModel` | OpenAI completion model override | `""` |
| `aibot.openaiEmbeddingModel` | OpenAI embedding model override | `""` |
| `aibot.openaiTranslateModel` | OpenAI translate model override | `""` |
| `aibot.openaiSummaryModel` | OpenAI summary model override | `""` |

### Backup

| Key | Description | Default |
|-----|-------------|---------|
| `backup.enabled` | Enable nightly backup CronJobs | `false` |
| `backup.schedule` | Default cron schedule | `0 2 * * *` |
| `backup.retentionDays` | Retention window for uploaded backups | `30` |
| `backup.rcloneImage` | rclone image | pinned in `values.yaml` |
| `backup.existingSecret` | Externally-managed backup Secret name | `""` |
| `backup.s3.endpoint` | Backup S3 endpoint | `""` |
| `backup.s3.region` | Backup S3 region | `""` |
| `backup.s3.bucket` | Backup bucket name | `""` |
| `backup.s3.pathPrefix` | Path prefix inside bucket | `""` |
| `backup.s3.accessKey` | Primary access key | `""` |
| `backup.s3.secretKey` | Primary secret key | `""` |
| `backup.s3.secondaryAccessKey` | Secondary access key (rotation) | `""` |
| `backup.s3.secondarySecretKey` | Secondary secret key (rotation) | `""` |
| `backup.s3.activeCredential` | `primary` or `secondary` | `primary` |
| `backup.cockroachdb.enabled` | Run Cockroach backup CronJob | `true` |
| `backup.files.enabled` | Run file backup CronJob | `true` |
| `backup.mongodb.enabled` | Run MongoDB backup CronJob (only when aibot.enabled=true) | `true` |

### Global Pod Settings

| Key | Description | Default |
|-----|-------------|---------|
| `global.nodeSelector` | Node selector for all pods | `{}` |
| `global.tolerations` | Tolerations for all pods | `[]` |
| `global.affinity` | Affinity rules for all pods | `{}` |

## Architecture

| Service | Port | Description |
|---------|------|-------------|
| **front** | 8080 | Web UI |
| **account** | 3000 | Authentication & user management |
| **transactor** | 3333 | Core transaction engine (WebSocket) |
| **collaborator** | 3078 | Real-time collaboration (WebSocket) |
| **workspace** | — | Workspace lifecycle (background worker, no Service) |
| **fulltext** | 4700 | Search indexing |
| **rekoni** | 4004 | Content intelligence |
| **stats** | 4900 | Metrics collection |
| **kvs** | 8094 | Key-value store |
| **aibot*** | 4010 | AI assistant (requires OpenAI key) |
| **github*** | 3500 | GitHub App integration |
| **cockroach** | 26257 | SQL database (CockroachDB, headless) |
| **redpanda** | 9092 | Message queue (Kafka-compatible) |
| **elastic** | 9200 | Full-text search (Elasticsearch) |
| **minio*** | 9000 | Bundled object storage (testing only) |
| **mongodb*** | 27017 | Document database (only used by aibot, headless) |

(*) optional / off by default.

## Known Limitations

- **One release per namespace.** Service and Deployment names are not release-prefixed. Internal hostnames (`http://account:3000`, `cockroach:26257`, etc.) assume single-release-per-namespace; install multiple releases in the same namespace will collide.
- **Cockroach `--insecure`.** The bundled CockroachDB does not enforce authentication. Set `cockroach.enabled=false` and provide `secrets.crDbUrl` for a secured external database.
- **Bundled MinIO is testing-only.** No HA, no backups, no encryption. Use `storage.type=s3` for anything you'd page on.
