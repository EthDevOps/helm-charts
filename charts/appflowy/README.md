# AppFlowy Cloud Helm Chart

Helm chart for [AppFlowy Cloud](https://appflowy.io) - a collaborative workspace platform.

## Prerequisites

- Kubernetes 1.24+
- Helm 3.x
- An external S3-compatible storage endpoint
- A load balancer in front of the cluster for path-based routing

## Required Secrets

The chart does not create any secrets. You must create them before installing.

### 1. JWT Secret (required)

Referenced by `existingSecret.name` in values.yaml.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: appflowy-jwt
type: Opaque
stringData:
  GOTRUE_JWT_SECRET: "<your-jwt-secret>"
```

### 2. S3 Credentials (required)

Referenced by `s3.existingSecret.name` in values.yaml.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: appflowy-s3
type: Opaque
stringData:
  AWS_ACCESS_KEY_ID: "<your-access-key>"
  AWS_SECRET_ACCESS_KEY: "<your-secret-key>"
```

### 3. SMTP Credentials (optional, if `smtp.enabled: true`)

Referenced by `smtp.existingSecret.name` in values.yaml.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: appflowy-smtp
type: Opaque
stringData:
  SMTP_PASSWORD: "<your-smtp-password>"
```

### 4. OAuth Provider Secrets (optional, per provider)

Referenced by `oauth.<provider>.existingSecret.name` in values.yaml.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: appflowy-oauth-google
type: Opaque
stringData:
  GOOGLE_CLIENT_ID: "<client-id>"
  GOOGLE_CLIENT_SECRET: "<client-secret>"
```

Repeat for GitHub (`GITHUB_CLIENT_ID` / `GITHUB_CLIENT_SECRET`) and Discord (`DISCORD_CLIENT_ID` / `DISCORD_CLIENT_SECRET`).

### 5. OpenAI API Key (optional, if `search.enabled` or `ai.enabled`)

Referenced by `openai.existingSecret.name` in values.yaml.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: appflowy-openai
type: Opaque
stringData:
  OPENAI_API_KEY: "<your-openai-api-key>"
```

## Service / Path Mapping

All services are exposed as `NodePort` services. Your external load balancer must route traffic based on path prefixes to the correct service.

| Path | Service Name | Port | Description |
|------|-------------|------|-------------|
| `/gotrue` | `<release>-gotrue-app` | 9999 | Authentication (GoTrue) |
| `/api` | `<release>-cloud-app` | 8000 | Core backend API |
| `/ws` | `<release>-cloud-app` | 8000 | WebSocket connections |
| `/console` | `<release>-admin-app` | 3000 | Admin dashboard |
| `/` | `<release>-web-app` | 80 | Web frontend (catch-all) |
| `/search` | `<release>-search-app` | 4002 | Search service (if enabled) |
| `/ai` | `<release>-ai-app` | 5001 | AI service (if enabled) |

The `/` path is a catch-all and must be configured with the lowest priority. More specific paths (`/gotrue`, `/api`, `/ws`, `/console`) must take precedence.

The `/ws` path requires WebSocket upgrade support on your load balancer.

## Installation

```bash
helm dependency update .
helm install appflowy . \
  --set appDomain=appflowy.example.com \
  --set existingSecret.name=appflowy-jwt \
  --set s3.existingSecret.name=appflowy-s3 \
  --set s3.endpoint=https://s3.example.com \
  --set s3.bucket=appflowy \
  --set s3.region=us-east-1
```

## Components

| Component | Image | Default | Description |
|-----------|-------|---------|-------------|
| GoTrue | `appflowyinc/gotrue` | enabled | Authentication service |
| Cloud | `appflowyinc/appflowy_cloud` | enabled | Core backend |
| Worker | `appflowyinc/appflowy_worker` | enabled | Background job processor |
| Web | `appflowyinc/appflowy_web` | enabled | Web frontend |
| Admin | `appflowyinc/admin_frontend` | enabled | Admin dashboard |
| Search | `appflowyinc/appflowy_search` | disabled | Search indexing (`search.enabled`) |
| AI | `appflowyinc/appflowy_ai` | disabled | AI integration (`ai.enabled`) |

## Dependencies

| Chart | Version | Description |
|-------|---------|-------------|
| postgresql | 1.1.6 | PostgreSQL with pgvector (QuokkaOps) |
| redis | 1.0.5 | Redis standalone (QuokkaOps) |

The PostgreSQL image defaults to `pgvector/pgvector:pg16` since AppFlowy requires the pgvector extension.

## Maintainers

| Name | Email |
|------|-------|
| elasticroentgen | markus.keil@ethereum.org |
