# postiz-app

![Version: 1.2.0](https://img.shields.io/badge/Version-1.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.3.0](https://img.shields.io/badge/AppVersion-1.3.0-informational?style=flat-square)

A Social Media Scheduling App

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| jonathan-irvin | offendingcommit@gmail.com | https://linktr.ee/offendingcommit |
| jamesread | contact@jread.com | http://jread.com |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://ethdevops.github.io/helm-charts | postgresql | 1.1.8 |
| https://ethdevops.github.io/helm-charts | redis | 1.0.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| env.BACKEND_INTERNAL_URL | string | `"http://backend:3000"` |  |
| env.FRONTEND_URL | string | `"http://localhost:4200"` |  |
| env.IS_GENERAL | string | `"true"` |  |
| env.NEXT_PUBLIC_BACKEND_URL | string | `"http://localhost:3000"` |  |
| env.NEXT_PUBLIC_UPLOAD_STATIC_DIRECTORY | string | `""` |  |
| env.NX_ADD_PLUGINS | string | `"false"` |  |
| env.UPLOAD_DIRECTORY | string | `""` |  |
| extraContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"ghcr.io/gitroomhq/postiz-app"` |  |
| image.tag | string | `"latest"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.extraRules | list | `[]` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.hosts[0].paths[0].port | int | `80` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.initialDelaySeconds | int | `60` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.tcpSocket.port | string | `"http"` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| nameOverride | string | `""` |  |
| networkPolicy.egress[0] | object | `{}` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.ingress[0].ports[0].port | int | `5000` |  |
| networkPolicy.ingress[0].ports[0].protocol | string | `"TCP"` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `true` |  |
| podDisruptionBudget.maxUnavailable | int | `1` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| postgresql.auth.database | string | `"postiz"` |  |
| postgresql.auth.password | string | `"postiz-password"` |  |
| postgresql.auth.username | string | `"postiz"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.pullPolicy | string | `"Always"` |  |
| postgresql.image.tag | string | `"15-alpine"` |  |
| postgresql.networkPolicy.enabled | bool | `true` |  |
| postgresql.resources.limits.cpu | string | `"1"` |  |
| postgresql.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| postgresql.resources.limits.memory | string | `"1Gi"` |  |
| postgresql.resources.requests.cpu | string | `"250m"` |  |
| postgresql.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| postgresql.resources.requests.memory | string | `"256Mi"` |  |
| postgresql.service.ports.postgresql | int | `5432` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `30` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| redis.auth.enabled | bool | `true` |  |
| redis.auth.password | string | `"postiz-redis-password"` |  |
| redis.enabled | bool | `true` |  |
| redis.image.pullPolicy | string | `"Always"` |  |
| redis.master.service.ports.redis | int | `6379` |  |
| redis.resources.limits.cpu | string | `"500m"` |  |
| redis.resources.limits.ephemeral-storage | string | `"512Mi"` |  |
| redis.resources.limits.memory | string | `"512Mi"` |  |
| redis.resources.requests.cpu | string | `"100m"` |  |
| redis.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| redis.resources.requests.memory | string | `"128Mi"` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"1"` |  |
| resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| resources.limits.memory | string | `"2Gi"` |  |
| resources.requests.cpu | string | `"200m"` |  |
| resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| resources.requests.memory | string | `"1Gi"` |  |
| secrets.CLOUDFLARE_ACCESS_KEY | string | `""` |  |
| secrets.CLOUDFLARE_ACCOUNT_ID | string | `""` |  |
| secrets.CLOUDFLARE_BUCKETNAME | string | `""` |  |
| secrets.CLOUDFLARE_BUCKET_URL | string | `""` |  |
| secrets.CLOUDFLARE_SECRET_ACCESS_KEY | string | `""` |  |
| secrets.DATABASE_URL | string | `""` |  |
| secrets.GITHUB_CLIENT_ID | string | `""` |  |
| secrets.GITHUB_CLIENT_SECRET | string | `""` |  |
| secrets.JWT_SECRET | string | `""` |  |
| secrets.LINKEDIN_CLIENT_ID | string | `""` |  |
| secrets.LINKEDIN_CLIENT_SECRET | string | `""` |  |
| secrets.REDDIT_CLIENT_ID | string | `""` |  |
| secrets.REDDIT_CLIENT_SECRET | string | `""` |  |
| secrets.REDIS_URL | string | `""` |  |
| secrets.RESEND_API_KEY | string | `""` |  |
| secrets.X_API_KEY | string | `""` |  |
| secrets.X_API_SECRET | string | `""` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsGroup | int | `1000` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.additionalPorts | list | `[]` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| workloadAnnotations.kube-score/ignore | string | `"container-image-tag, container-security-context-user-group-id"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
