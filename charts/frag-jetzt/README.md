# frag-jetzt

![Version: 0.1.16](https://img.shields.io/badge/Version-0.1.16-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: master](https://img.shields.io/badge/AppVersion-master-informational?style=flat-square)

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
| https://ethdevops.github.io/helm-charts | postgresql | 1.1.6 |
| https://ethdevops.github.io/helm-charts | ai-postgresql(postgresql) | 1.1.6 |
| https://ethdevops.github.io/helm-charts | redis | 1.0.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ai-postgresql.auth.database | string | `"langchain"` |  |
| ai-postgresql.auth.password | string | `"langchain"` |  |
| ai-postgresql.auth.username | string | `"langchain"` |  |
| ai-postgresql.enabled | bool | `true` |  |
| ai-postgresql.image.tag | string | `"16-alpine"` |  |
| ai-postgresql.replication.password | string | `"replication_password"` |  |
| ai-postgresql.replication.user | string | `"replicator"` |  |
| aiProvider.chroma.auth.token | string | `"test-token"` |  |
| aiProvider.chroma.image.pullPolicy | string | `"IfNotPresent"` |  |
| aiProvider.chroma.image.repository | string | `"chromadb/chroma"` |  |
| aiProvider.chroma.image.tag | string | `"0.5.17"` |  |
| aiProvider.chroma.persistence.size | string | `"5Gi"` |  |
| aiProvider.enabled | bool | `true` |  |
| aiProvider.image.pullPolicy | string | `"IfNotPresent"` |  |
| aiProvider.image.repository | string | `"rubenbim/fragjetzt-ai-provider"` |  |
| aiProvider.image.tag | string | `"master"` |  |
| aiProvider.origins | string | `""` |  |
| aiProvider.port | int | `8080` |  |
| aiProvider.secretAlgorithm | string | `"HS256"` |  |
| appDomain | string | `"fragjetzt.example.com"` |  |
| auth.existingSecret.jwtSecretKey | string | `"jwt-secret"` |  |
| auth.existingSecret.name | string | `""` |  |
| auth.jwtSecret | string | `""` |  |
| backend.image.pullPolicy | string | `"IfNotPresent"` |  |
| backend.image.repository | string | `"git-registry.arsnova.eu/arsnova/frag.jetzt-backend"` |  |
| backend.image.tag | string | `"master"` |  |
| backend.loggingLevel | string | `"ERROR"` |  |
| backend.port | int | `8888` |  |
| frontend.image.pullPolicy | string | `"IfNotPresent"` |  |
| frontend.image.repository | string | `"git-registry.arsnova.eu/arsnova/frag.jetzt"` |  |
| frontend.image.tag | string | `"master"` |  |
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
| postgresql.auth.database | string | `"fragjetzt"` |  |
| postgresql.auth.password | string | `"fragjetzt"` |  |
| postgresql.auth.username | string | `"fragjetzt"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.tag | string | `"16-alpine"` |  |
| rabbitmq.auth.existingSecret.name | string | `""` |  |
| rabbitmq.auth.existingSecret.passwordKey | string | `"rabbitmq-password"` |  |
| rabbitmq.auth.password | string | `""` |  |
| rabbitmq.auth.username | string | `"guest"` |  |
| rabbitmq.image.pullPolicy | string | `"IfNotPresent"` |  |
| rabbitmq.image.repository | string | `"rabbitmq"` |  |
| rabbitmq.image.tag | string | `"3.8"` |  |
| rabbitmq.persistence.size | string | `"5Gi"` |  |
| rabbitmq.plugins[0] | string | `"rabbitmq_prometheus"` |  |
| rabbitmq.plugins[1] | string | `"rabbitmq_stomp"` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.enabled | bool | `true` |  |
| replicaCount | int | `1` |  |
| vapid.enabled | bool | `false` |  |
| vapid.existingSecret.name | string | `""` |  |
| vapid.existingSecret.privateKeyKey | string | `"vapid-private-key"` |  |
| vapid.existingSecret.publicKeyKey | string | `"vapid-public-key"` |  |
| vapid.privateKey | string | `""` |  |
| vapid.publicKey | string | `""` |  |
| vapid.subject | string | `""` |  |
| wsGateway.image.pullPolicy | string | `"IfNotPresent"` |  |
| wsGateway.image.repository | string | `"git-registry.arsnova.eu/arsnova/arsnova-ws-gateway"` |  |
| wsGateway.image.tag | string | `"frag-jetzt"` |  |
| wsGateway.loggingLevel | string | `"ERROR"` |  |
| wsGateway.port | int | `8080` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
