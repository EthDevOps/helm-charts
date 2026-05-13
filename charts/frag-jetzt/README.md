# frag-jetzt

![Version: 0.1.17](https://img.shields.io/badge/Version-0.1.17-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: master](https://img.shields.io/badge/AppVersion-master-informational?style=flat-square)

Frag.jetzt - Anonymous Q&A platform for lectures and events

**Homepage:** <https://frag.jetzt>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| elasticroentgen | markus.keil@ethereum.org |  |

## Source Code

* <https://github.com/thm-projects/frag.jetzt>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://ethdevops.github.io/helm-charts | postgresql | 1.1.8 |
| https://ethdevops.github.io/helm-charts | ai-postgresql(postgresql) | 1.1.8 |
| https://ethdevops.github.io/helm-charts | redis | 1.0.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ai-postgresql.auth.database | string | `"langchain"` |  |
| ai-postgresql.auth.password | string | `"langchain"` |  |
| ai-postgresql.auth.username | string | `"langchain"` |  |
| ai-postgresql.enabled | bool | `true` |  |
| ai-postgresql.image.pullPolicy | string | `"Always"` |  |
| ai-postgresql.image.tag | string | `"16-alpine"` |  |
| ai-postgresql.networkPolicy.enabled | bool | `true` |  |
| ai-postgresql.replication.password | string | `"replication_password"` |  |
| ai-postgresql.replication.user | string | `"replicator"` |  |
| ai-postgresql.resources.limits.cpu | string | `"1"` |  |
| ai-postgresql.resources.limits.ephemeral-storage | string | `"512Mi"` |  |
| ai-postgresql.resources.limits.memory | string | `"1Gi"` |  |
| ai-postgresql.resources.requests.cpu | string | `"100m"` |  |
| ai-postgresql.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| ai-postgresql.resources.requests.memory | string | `"256Mi"` |  |
| ai-postgresql.workloadAnnotations.kube-score/ignore | string | `"container-security-context-user-group-id"` |  |
| aiProvider.chroma.auth.token | string | `"test-token"` |  |
| aiProvider.chroma.image.pullPolicy | string | `"Always"` |  |
| aiProvider.chroma.image.repository | string | `"chromadb/chroma"` |  |
| aiProvider.chroma.image.tag | string | `"0.5.17"` |  |
| aiProvider.chroma.persistence.size | string | `"5Gi"` |  |
| aiProvider.chroma.resources.limits.cpu | string | `"1"` |  |
| aiProvider.chroma.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| aiProvider.chroma.resources.limits.memory | string | `"2Gi"` |  |
| aiProvider.chroma.resources.requests.cpu | string | `"100m"` |  |
| aiProvider.chroma.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| aiProvider.chroma.resources.requests.memory | string | `"512Mi"` |  |
| aiProvider.enabled | bool | `true` |  |
| aiProvider.image.pullPolicy | string | `"Always"` |  |
| aiProvider.image.repository | string | `"rubenbim/fragjetzt-ai-provider"` |  |
| aiProvider.image.tag | string | `"master"` |  |
| aiProvider.initContainer.resources.limits.cpu | string | `"500m"` |  |
| aiProvider.initContainer.resources.limits.ephemeral-storage | string | `"256Mi"` |  |
| aiProvider.initContainer.resources.limits.memory | string | `"256Mi"` |  |
| aiProvider.initContainer.resources.requests.cpu | string | `"50m"` |  |
| aiProvider.initContainer.resources.requests.ephemeral-storage | string | `"64Mi"` |  |
| aiProvider.initContainer.resources.requests.memory | string | `"64Mi"` |  |
| aiProvider.origins | string | `""` |  |
| aiProvider.port | int | `8080` |  |
| aiProvider.resources.limits.cpu | string | `"1"` |  |
| aiProvider.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| aiProvider.resources.limits.memory | string | `"2Gi"` |  |
| aiProvider.resources.requests.cpu | string | `"100m"` |  |
| aiProvider.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| aiProvider.resources.requests.memory | string | `"512Mi"` |  |
| aiProvider.secretAlgorithm | string | `"HS256"` |  |
| appDomain | string | `"fragjetzt.example.com"` |  |
| auth.existingSecret.jwtSecretKey | string | `"jwt-secret"` |  |
| auth.existingSecret.name | string | `""` |  |
| auth.jwtSecret | string | `""` |  |
| backend.image.pullPolicy | string | `"Always"` |  |
| backend.image.repository | string | `"git-registry.arsnova.eu/arsnova/frag.jetzt-backend"` |  |
| backend.image.tag | string | `"master"` |  |
| backend.loggingLevel | string | `"ERROR"` |  |
| backend.port | int | `8888` |  |
| backend.resources.limits.cpu | string | `"1"` |  |
| backend.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| backend.resources.limits.memory | string | `"2Gi"` |  |
| backend.resources.requests.cpu | string | `"200m"` |  |
| backend.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| backend.resources.requests.memory | string | `"1Gi"` |  |
| frontend.image.pullPolicy | string | `"Always"` |  |
| frontend.image.repository | string | `"git-registry.arsnova.eu/arsnova/frag.jetzt"` |  |
| frontend.image.tag | string | `"master"` |  |
| frontend.resources.limits.cpu | string | `"500m"` |  |
| frontend.resources.limits.ephemeral-storage | string | `"512Mi"` |  |
| frontend.resources.limits.memory | string | `"256Mi"` |  |
| frontend.resources.requests.cpu | string | `"50m"` |  |
| frontend.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| frontend.resources.requests.memory | string | `"64Mi"` |  |
| frontend.service.annotations | object | `{}` |  |
| frontend.service.nodePort | string | `""` |  |
| frontend.service.port | int | `80` |  |
| frontend.service.type | string | `"ClusterIP"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `true` |  |
| ingress.tls.secretName | string | `"frag-jetzt-tls"` |  |
| keycloak.eventPassword | string | `""` |  |
| keycloak.existingSecret.eventPasswordKey | string | `"keycloak-event-password"` |  |
| keycloak.existingSecret.name | string | `""` |  |
| keycloak.realm | string | `"fragjetzt"` |  |
| keycloak.url | string | `"https://keycloak.ethquokkaops.io"` |  |
| mail.enabled | bool | `false` |  |
| mail.existingSecret.name | string | `""` |  |
| mail.existingSecret.passwordKey | string | `"SMTP_PASSWORD"` |  |
| mail.existingSecret.usernameKey | string | `"SMTP_USERNAME"` |  |
| mail.host | string | `""` |  |
| mail.port | string | `"587"` |  |
| mail.senderAddress | string | `"noreply@example.com"` |  |
| networkPolicy.egress[0] | object | `{}` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.ingress[0] | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `true` |  |
| podDisruptionBudget.maxUnavailable | int | `1` |  |
| postgresql.auth.database | string | `"fragjetzt"` |  |
| postgresql.auth.password | string | `"fragjetzt"` |  |
| postgresql.auth.username | string | `"fragjetzt"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.pullPolicy | string | `"Always"` |  |
| postgresql.image.tag | string | `"16-alpine"` |  |
| postgresql.networkPolicy.enabled | bool | `true` |  |
| postgresql.resources.limits.cpu | string | `"1"` |  |
| postgresql.resources.limits.ephemeral-storage | string | `"512Mi"` |  |
| postgresql.resources.limits.memory | string | `"1Gi"` |  |
| postgresql.resources.requests.cpu | string | `"100m"` |  |
| postgresql.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| postgresql.resources.requests.memory | string | `"256Mi"` |  |
| postgresql.workloadAnnotations.kube-score/ignore | string | `"container-security-context-user-group-id"` |  |
| rabbitmq.auth.existingSecret.name | string | `""` |  |
| rabbitmq.auth.existingSecret.passwordKey | string | `"rabbitmq-password"` |  |
| rabbitmq.auth.password | string | `""` |  |
| rabbitmq.auth.username | string | `"guest"` |  |
| rabbitmq.image.pullPolicy | string | `"Always"` |  |
| rabbitmq.image.repository | string | `"rabbitmq"` |  |
| rabbitmq.image.tag | string | `"3.8"` |  |
| rabbitmq.persistence.size | string | `"5Gi"` |  |
| rabbitmq.plugins[0] | string | `"rabbitmq_prometheus"` |  |
| rabbitmq.plugins[1] | string | `"rabbitmq_stomp"` |  |
| rabbitmq.resources.limits.cpu | string | `"1"` |  |
| rabbitmq.resources.limits.ephemeral-storage | string | `"512Mi"` |  |
| rabbitmq.resources.limits.memory | string | `"1Gi"` |  |
| rabbitmq.resources.requests.cpu | string | `"100m"` |  |
| rabbitmq.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| rabbitmq.resources.requests.memory | string | `"256Mi"` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.enabled | bool | `true` |  |
| redis.image.pullPolicy | string | `"Always"` |  |
| redis.resources.limits.cpu | string | `"500m"` |  |
| redis.resources.limits.ephemeral-storage | string | `"256Mi"` |  |
| redis.resources.limits.memory | string | `"256Mi"` |  |
| redis.resources.requests.cpu | string | `"50m"` |  |
| redis.resources.requests.ephemeral-storage | string | `"64Mi"` |  |
| redis.resources.requests.memory | string | `"64Mi"` |  |
| replicaCount | int | `1` |  |
| vapid.enabled | bool | `false` |  |
| vapid.existingSecret.name | string | `""` |  |
| vapid.existingSecret.privateKeyKey | string | `"vapid-private-key"` |  |
| vapid.existingSecret.publicKeyKey | string | `"vapid-public-key"` |  |
| vapid.privateKey | string | `""` |  |
| vapid.publicKey | string | `""` |  |
| vapid.subject | string | `""` |  |
| wsGateway.image.pullPolicy | string | `"Always"` |  |
| wsGateway.image.repository | string | `"git-registry.arsnova.eu/arsnova/arsnova-ws-gateway"` |  |
| wsGateway.image.tag | string | `"frag-jetzt"` |  |
| wsGateway.loggingLevel | string | `"ERROR"` |  |
| wsGateway.port | int | `8080` |  |
| wsGateway.resources.limits.cpu | string | `"1"` |  |
| wsGateway.resources.limits.ephemeral-storage | string | `"512Mi"` |  |
| wsGateway.resources.limits.memory | string | `"1Gi"` |  |
| wsGateway.resources.requests.cpu | string | `"100m"` |  |
| wsGateway.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| wsGateway.resources.requests.memory | string | `"256Mi"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
