# engelsystem

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: main](https://img.shields.io/badge/AppVersion-main-informational?style=flat-square)

Online tool for coordinating volunteers and shifts on large events

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| elasticroentgen | markus.keil@ethereum.org |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://groundhog2k.github.io/helm-charts | mariadb | 4.5.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.setupAdminPassword | string | `""` |  |
| app.setupAdminPasswordExistingSecret.key | string | `"SETUP_ADMIN_PASSWORD"` |  |
| app.setupAdminPasswordExistingSecret.name | string | `""` |  |
| app.url | string | `"https://engelsystem.example.com"` |  |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| containerSecurityContext.capabilities.add[0] | string | `"NET_BIND_SERVICE"` |  |
| containerSecurityContext.capabilities.add[1] | string | `"SETUID"` |  |
| containerSecurityContext.capabilities.add[2] | string | `"SETGID"` |  |
| containerSecurityContext.capabilities.add[3] | string | `"CHOWN"` |  |
| containerSecurityContext.capabilities.add[4] | string | `"FOWNER"` |  |
| containerSecurityContext.capabilities.add[5] | string | `"KILL"` |  |
| containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| containerSecurityContext.readOnlyRootFilesystem | bool | `false` |  |
| databaseExistingSecret.databaseKey | string | `""` |  |
| databaseExistingSecret.name | string | `""` |  |
| databaseExistingSecret.passwordKey | string | `"MYSQL_PASSWORD"` |  |
| databaseExistingSecret.userKey | string | `""` |  |
| externalDatabase.database | string | `"engelsystem"` |  |
| externalDatabase.host | string | `""` |  |
| externalDatabase.password | string | `""` |  |
| externalDatabase.user | string | `"engelsystem"` |  |
| extraEnv | list | `[]` |  |
| extraEnvFrom | list | `[]` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"ghcr.io/ethdevops/engelsystem"` |  |
| image.tag | string | `"main"` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.initialDelaySeconds | int | `30` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.tcpSocket.port | string | `"http"` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| mariadb.customAnnotations.kube-score/ignore | string | `"container-security-context-user-group-id,statefulset-has-servicename"` |  |
| mariadb.customLivenessProbe.failureThreshold | int | `3` |  |
| mariadb.customLivenessProbe.initialDelaySeconds | int | `120` |  |
| mariadb.customLivenessProbe.periodSeconds | int | `10` |  |
| mariadb.customLivenessProbe.tcpSocket.port | int | `3306` |  |
| mariadb.customLivenessProbe.timeoutSeconds | int | `5` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.image.pullPolicy | string | `"Always"` |  |
| mariadb.initResources.limits.cpu | string | `"250m"` |  |
| mariadb.initResources.limits.ephemeral-storage | string | `"128Mi"` |  |
| mariadb.initResources.limits.memory | string | `"128Mi"` |  |
| mariadb.initResources.requests.cpu | string | `"50m"` |  |
| mariadb.initResources.requests.ephemeral-storage | string | `"64Mi"` |  |
| mariadb.initResources.requests.memory | string | `"64Mi"` |  |
| mariadb.resources.limits.cpu | string | `"1"` |  |
| mariadb.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| mariadb.resources.limits.memory | string | `"1Gi"` |  |
| mariadb.resources.requests.cpu | string | `"250m"` |  |
| mariadb.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| mariadb.resources.requests.memory | string | `"256Mi"` |  |
| mariadb.settings.rootPassword.value | string | `"engelsystem-root"` |  |
| mariadb.storage.requestedSize | string | `"2Gi"` |  |
| mariadb.userDatabase.name.value | string | `"engelsystem"` |  |
| mariadb.userDatabase.password.value | string | `"engelsystem"` |  |
| mariadb.userDatabase.user.value | string | `"engelsystem"` |  |
| migrateInitContainer.resources.limits.cpu | string | `"1"` |  |
| migrateInitContainer.resources.limits.ephemeral-storage | string | `"256Mi"` |  |
| migrateInitContainer.resources.limits.memory | string | `"512Mi"` |  |
| migrateInitContainer.resources.requests.cpu | string | `"100m"` |  |
| migrateInitContainer.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| migrateInitContainer.resources.requests.memory | string | `"128Mi"` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.ingress[0].fromEntities[0] | string | `"cluster"` |  |
| networkPolicy.ingress[0].toPorts[0].ports[0].port | string | `"80"` |  |
| networkPolicy.ingress[0].toPorts[0].ports[0].protocol | string | `"TCP"` |  |
| podAnnotations | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `true` |  |
| podDisruptionBudget.maxUnavailable | int | `1` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.httpGet.path | string | `"/health"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `5` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"2"` |  |
| resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| resources.limits.memory | string | `"2Gi"` |  |
| resources.requests.cpu | string | `"250m"` |  |
| resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| service.annotations | object | `{}` |  |
| service.labels | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
