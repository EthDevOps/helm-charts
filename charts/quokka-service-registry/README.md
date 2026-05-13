# quokka-service-registry

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for QuokkaServiceRegistry - A comprehensive service catalog management application

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| QuokkaServiceRegistry Team |  |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://ethdevops.github.io/helm-charts | postgresql | 1.1.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| config.allowLocalAdminBypass | bool | `true` |  |
| config.allowedHosts | string | `"*"` |  |
| config.logging.logLevel.default | string | `"Information"` |  |
| config.logging.logLevel.microsoftAspNetCore | string | `"Warning"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"docker.ethquokkaops.io/ethquokkaops/ethdevops/service-registry"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.enabled | bool | `false` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `30` |  |
| livenessProbe.tcpSocket.port | string | `"http"` |  |
| nameOverride | string | `""` |  |
| networkPolicy.egress[0] | object | `{}` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.ingress[0].ports[0].port | int | `8080` |  |
| networkPolicy.ingress[0].ports[0].protocol | string | `"TCP"` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `true` |  |
| podDisruptionBudget.maxUnavailable | int | `1` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `2000` |  |
| postgresql.auth.database | string | `"quokka_service_registry"` |  |
| postgresql.auth.existingSecret | string | `""` |  |
| postgresql.auth.secretKeys.adminPasswordKey | string | `"postgres-password"` |  |
| postgresql.auth.secretKeys.userPasswordKey | string | `"password"` |  |
| postgresql.auth.username | string | `"quokka"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.pullPolicy | string | `"Always"` |  |
| postgresql.image.tag | string | `"16-alpine"` |  |
| postgresql.networkPolicy.allowedPods[0]."app.kubernetes.io/name" | string | `"quokka-service-registry"` |  |
| postgresql.networkPolicy.enabled | bool | `true` |  |
| postgresql.podSecurityContext.fsGroup | int | `10001` |  |
| postgresql.primary.persistence.enabled | bool | `true` |  |
| postgresql.primary.persistence.size | string | `"8Gi"` |  |
| postgresql.resources.limits.cpu | string | `"1"` |  |
| postgresql.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| postgresql.resources.limits.memory | string | `"1Gi"` |  |
| postgresql.resources.requests.cpu | string | `"100m"` |  |
| postgresql.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| postgresql.resources.requests.memory | string | `"256Mi"` |  |
| postgresql.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| postgresql.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| postgresql.securityContext.capabilities.drop[1] | string | `"SYS_ADMIN"` |  |
| postgresql.securityContext.capabilities.drop[2] | string | `"NET_ADMIN"` |  |
| postgresql.securityContext.capabilities.drop[3] | string | `"SYS_PTRACE"` |  |
| postgresql.securityContext.readOnlyRootFilesystem | bool | `false` |  |
| postgresql.securityContext.runAsGroup | int | `10001` |  |
| postgresql.securityContext.runAsNonRoot | bool | `true` |  |
| postgresql.securityContext.runAsUser | int | `10001` |  |
| postgresql.service.clusterIP | string | `"None"` |  |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"1"` |  |
| resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| resources.limits.memory | string | `"1Gi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| secrets.auth.existingSecret | string | `""` |  |
| secrets.auth.secretKeys.authorizedUsers | string | `"authorized-users"` |  |
| secrets.auth.secretKeys.googleClientId | string | `"google-client-id"` |  |
| secrets.auth.secretKeys.googleClientSecret | string | `"google-client-secret"` |  |
| secrets.auth.secretKeys.localAdminPassword | string | `"local-admin-password"` |  |
| secrets.auth.secretKeys.localAdminUsername | string | `"local-admin-username"` |  |
| secrets.database.existingSecret | string | `""` |  |
| secrets.database.secretKeys.password | string | `"password"` |  |
| secrets.database.secretKeys.username | string | `"username"` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `80` |  |
| service.targetPort | string | `"http"` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
