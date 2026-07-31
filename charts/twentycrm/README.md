# Twenty CRM Helm Chart

High-performance, open-source CRM platform built on a modern stack with GraphQL API, PostgreSQL, and real-time updates.

## Introduction

This chart bootstraps a [Twenty CRM](https://github.com/twentyhq/twenty) deployment on a Kubernetes cluster using the Helm package manager.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

## Installing the Chart

To install the chart with the release name `my-crm`:

```bash
helm install my-crm ./twentycrm
```

The command deploys Twenty CRM on the Kubernetes cluster with default configuration. The [Configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-crm` deployment:

```bash
helm uninstall my-crm
```

## Configuration

The following table lists the configurable parameters of the Twenty CRM chart and their default values.

### Global Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `commonAnnotations` | Annotations to add to all resources | `{}` |
| `podAnnotations` | Annotations to add to pods | `{}` |
| `podLabels` | Labels to add to pods | `{}` |
| `extraInitContainers` | Extra init containers for custom initialization | `[]` |

### Ingress Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.enabled` | Enable ingress controller resource | `false` |
| `ingress.className` | Ingress class name | `""` |
| `ingress.annotations` | Ingress annotations | `{}` |
| `ingress.host` | Hostname for the ingress | `crm.example.com` |
| `ingress.tls` | TLS configuration | `[]` |

### Service Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.type` | Service type | `ClusterIP` |
| `service.annotations` | Service annotations | `{}` |
| `service.sessionAffinity` | Session affinity setting | `ClientIP` |
| `service.sessionAffinityTimeout` | Session affinity timeout in seconds | `10800` |

### Server Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `server.image.repository` | Server image repository | `twentycrm/twenty` |
| `server.image.tag` | Server image tag | `latest` |
| `server.image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `server.replicas` | Number of server replicas | `1` |
| `server.port` | Server port | `3000` |
| `server.serverUrl` | Server URL for CORS and webhooks | `https://crm.example.com` |
| `server.runMigrations` | Enable database migrations on startup | `true` |
| `server.resources` | Resource requests and limits | See values.yaml |
| `server.storage.enabled` | Enable persistent storage | `true` |
| `server.storage.storageSize` | Storage size for application data | `10Gi` |
| `server.storage.dockerDataSize` | Storage size for docker data | `10Gi` |
| `server.storage.storageClassName` | Storage class name | `""` |

### Worker Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `worker.image.repository` | Worker image repository | `twentycrm/twenty` |
| `worker.image.tag` | Worker image tag | `latest` |
| `worker.image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `worker.replicas` | Number of worker replicas | `1` |
| `worker.resources` | Resource requests and limits | See values.yaml |

### PostgreSQL Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `postgres.enabled` | Enable PostgreSQL deployment | `true` |
| `postgres.hostname` | External PostgreSQL hostname (when not enabled) | `""` |
| `postgres.database` | PostgreSQL database name | `twenty` |
| `postgres.user` | PostgreSQL username | `twenty` |
| `postgres.password` | PostgreSQL password | `twenty` |
| `postgres.existingSecret` | Use existing secret for password | `""` |
| `postgres.image.repository` | PostgreSQL image repository | `twentycrm/twenty-postgres-spilo` |
| `postgres.image.tag` | PostgreSQL image tag | `latest` |
| `postgres.resources` | Resource requests and limits | See values.yaml |
| `postgres.storage.size` | Storage size | `10Gi` |
| `postgres.storage.storageClassName` | Storage class name | `""` |

### Redis Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `redis.enabled` | Enable Redis deployment | `true` |
| `redis.url` | External Redis URL (when not enabled) | `""` |
| `redis.image.repository` | Redis image repository | `redis/redis-stack-server` |
| `redis.image.tag` | Redis image tag | `latest` |
| `redis.port` | Redis port | `6379` |
| `redis.resources` | Resource requests and limits | See values.yaml |
| `redis.maxmemoryPolicy` | Redis maxmemory policy | `noeviction` |

### Secrets Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `secrets.existingSecret` | Use existing secret for tokens | `""` |
| `secrets.accessToken` | Access token secret | `changeme-access-token` |
| `secrets.loginToken` | Login token secret | `changeme-login-token` |
| `secrets.refreshToken` | Refresh token secret | `changeme-refresh-token` |

### Token Expiration Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `tokenExpiration.accessToken` | Access token expiration | `7d` |
| `tokenExpiration.loginToken` | Login token expiration | `1h` |
| `tokenExpiration.refreshToken` | Refresh token expiration | `30d` |

## Example Configuration

### Basic Installation with Ingress

```yaml
ingress:
  enabled: true
  className: nginx
  host: crm.mycompany.com
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  tls:
    - secretName: twentycrm-tls
      hosts:
        - crm.mycompany.com

server:
  serverUrl: https://crm.mycompany.com
  replicas: 2

secrets:
  accessToken: "your-secure-access-token"
  loginToken: "your-secure-login-token"
  refreshToken: "your-secure-refresh-token"
```

### Using External Database

```yaml
postgres:
  enabled: false
  hostname: postgres.example.com
  database: twentycrm
  user: twentycrm
  existingSecret: my-postgres-secret
  existingSecretKey: password

redis:
  enabled: false
  url: redis://redis.example.com:6379
```

### High Availability Setup

```yaml
server:
  replicas: 3
  resources:
    requests:
      cpu: 500m
      memory: 512Mi
    limits:
      cpu: 2000m
      memory: 2048Mi

worker:
  replicas: 2
  resources:
    requests:
      cpu: 500m
      memory: 1024Mi
    limits:
      cpu: 2000m
      memory: 4096Mi

postgres:
  storage:
    size: 50Gi
    storageClassName: fast-ssd
  resources:
    requests:
      cpu: 1000m
      memory: 2048Mi
    limits:
      cpu: 4000m
      memory: 8192Mi
```

## Persistence

The chart stores data in PersistentVolumes:
- PostgreSQL data at `/home/postgres/pgdata`
- Server application data at `/app/packages/twenty-server/.local-storage`
- Docker-related data at `/app/docker-data`

By default, a PersistentVolumeClaim is created and mounted for each. If you want to disable persistence:

```yaml
server:
  storage:
    enabled: false

postgres:
  enabled: false
  # Use external database instead
```

## Security Considerations

1. **Change Default Secrets**: Always change the default token secrets before deploying to production
2. **Use Existing Secrets**: For production, use `existingSecret` parameters to reference pre-created Kubernetes secrets
3. **Enable TLS**: Configure ingress TLS for secure HTTPS connections
4. **Network Policies**: Consider implementing network policies to restrict pod-to-pod communication
5. **Resource Limits**: Set appropriate resource limits to prevent resource exhaustion

## Upgrading

To upgrade an existing release:

```bash
helm upgrade my-crm ./twentycrm -f custom-values.yaml
```

## Troubleshooting

### Pods not starting

Check pod status and logs:
```bash
kubectl get pods -l app.kubernetes.io/instance=my-crm
kubectl logs <pod-name>
```

### Database connection issues

Verify PostgreSQL is running and accessible:
```bash
kubectl exec -it <server-pod> -- env | grep PG_DATABASE_URL
```

### Init container waiting

Check init container logs:
```bash
kubectl logs <pod-name> -c wait-for-postgres
```

## Support

For issues and questions:
- Twenty CRM: https://github.com/twentyhq/twenty
- Helm Chart: https://github.com/yourusername/helm-charts

## License

This chart follows the same license as Twenty CRM (AGPL-3.0).
