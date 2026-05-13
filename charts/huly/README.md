# huly

![Version: 0.2.3](https://img.shields.io/badge/Version-0.2.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.7.382](https://img.shields.io/badge/AppVersion-0.7.382-informational?style=flat-square)

Huly — open-source project management platform

**Homepage:** <https://huly.io>

## Source Code

* <https://github.com/hcengineering/huly-selfhost>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| account.replicas | int | `1` |  |
| account.resources.limits.memory | string | `"512Mi"` |  |
| account.service | object | `{}` |  |
| aibot.enabled | bool | `false` |  |
| aibot.firstName | string | `"Huly"` |  |
| aibot.lastName | string | `"AI"` |  |
| aibot.openaiEmbeddingModel | string | `""` |  |
| aibot.openaiModel | string | `""` |  |
| aibot.openaiSummaryModel | string | `""` |  |
| aibot.openaiTranslateModel | string | `""` |  |
| aibot.replicas | int | `1` |  |
| aibot.resources.limits.memory | string | `"512Mi"` |  |
| aibot.service | object | `{}` |  |
| appSettings.adminEmails | string | `""` |  |
| appSettings.defaultLanguage | string | `"en"` |  |
| appSettings.desktopChannel | string | `"selfhost"` |  |
| appSettings.lastNameFirst | string | `"true"` |  |
| appSettings.modelEnabled | string | `"*"` |  |
| appSettings.title | string | `"Huly Self Host"` |  |
| auth.disableSignup | bool | `false` |  |
| auth.github.clientId | string | `""` |  |
| auth.github.clientSecret | string | `""` |  |
| auth.google.clientId | string | `""` |  |
| auth.google.clientSecret | string | `""` |  |
| auth.hideLocalLogin | bool | `false` |  |
| auth.oidc.clientId | string | `""` |  |
| auth.oidc.clientSecret | string | `""` |  |
| auth.oidc.issuer | string | `""` |  |
| backup.cockroachdb.enabled | bool | `true` |  |
| backup.cockroachdb.schedule | string | `""` |  |
| backup.enabled | bool | `false` |  |
| backup.existingSecret | string | `""` |  |
| backup.files.enabled | bool | `true` |  |
| backup.files.schedule | string | `""` |  |
| backup.mongodb.enabled | bool | `true` |  |
| backup.mongodb.schedule | string | `""` |  |
| backup.rcloneImage | string | `"rclone/rclone:1.69.1"` |  |
| backup.retentionDays | int | `30` |  |
| backup.s3.accessKey | string | `""` |  |
| backup.s3.activeCredential | string | `"primary"` |  |
| backup.s3.bucket | string | `""` |  |
| backup.s3.endpoint | string | `""` |  |
| backup.s3.pathPrefix | string | `""` |  |
| backup.s3.region | string | `""` |  |
| backup.s3.secondaryAccessKey | string | `""` |  |
| backup.s3.secondarySecretKey | string | `""` |  |
| backup.s3.secretKey | string | `""` |  |
| backup.schedule | string | `"0 2 * * *"` |  |
| cockroach.enabled | bool | `true` |  |
| cockroach.image | string | `"cockroachdb/cockroach:v24.2.6"` |  |
| cockroach.resources | object | `{}` |  |
| cockroach.storage | string | `"10Gi"` |  |
| cockroach.storageClassName | string | `""` |  |
| collaborator.replicas | int | `1` |  |
| collaborator.resources.limits.memory | string | `"512Mi"` |  |
| collaborator.service | object | `{}` |  |
| domain | string | `"huly.example"` |  |
| elastic.enabled | bool | `true` |  |
| elastic.image | string | `"elasticsearch:7.14.2"` |  |
| elastic.javaOpts | string | `"-Xms1024m -Xmx1024m"` |  |
| elastic.resources | object | `{}` |  |
| elastic.storage | string | `"10Gi"` |  |
| elastic.storageClassName | string | `""` |  |
| external.elastic | string | `""` |  |
| external.mongodb | string | `""` |  |
| external.redpanda | string | `""` |  |
| front.replicas | int | `1` |  |
| front.resources | object | `{}` |  |
| front.service | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| fulltext.replicas | int | `1` |  |
| fulltext.resources.limits.memory | string | `"512Mi"` |  |
| fulltext.service | object | `{}` |  |
| githubIntegration.appId | string | `""` |  |
| githubIntegration.appSlug | string | `""` |  |
| githubIntegration.botName | string | `""` |  |
| githubIntegration.clientId | string | `""` |  |
| githubIntegration.clientSecret | string | `""` |  |
| githubIntegration.enabled | bool | `false` |  |
| githubIntegration.privateKey | string | `""` |  |
| githubIntegration.replicas | int | `1` |  |
| githubIntegration.resources.limits.memory | string | `"512Mi"` |  |
| githubIntegration.service | object | `{}` |  |
| githubIntegration.webhookSecret | string | `""` |  |
| global.affinity | object | `{}` |  |
| global.nodeSelector | object | `{}` |  |
| global.tolerations | list | `[]` |  |
| hulyRegistry | string | `"hardcoreeng"` |  |
| hulyVersion | string | `"v0.7.382"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `"nginx"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.tls.clusterIssuer | string | `"letsencrypt-prod"` |  |
| ingress.tls.enabled | bool | `true` |  |
| kvs.enabled | bool | `true` |  |
| kvs.replicas | int | `1` |  |
| kvs.resources | object | `{}` |  |
| kvs.service | object | `{}` |  |
| minio.enabled | bool | `false` |  |
| minio.image | string | `"minio/minio:RELEASE.2025-01-20T14-49-07Z"` |  |
| minio.resources | object | `{}` |  |
| minio.storage | string | `"50Gi"` |  |
| minio.storageClassName | string | `""` |  |
| mongodb.enabled | bool | `true` |  |
| mongodb.image | string | `"mongo:7.0.16"` |  |
| mongodb.resources | object | `{}` |  |
| mongodb.storage | string | `"5Gi"` |  |
| mongodb.storageClassName | string | `""` |  |
| nameOverride | string | `""` |  |
| redpanda.enabled | bool | `true` |  |
| redpanda.image | string | `"docker.redpanda.com/redpandadata/redpanda:v24.3.6"` |  |
| redpanda.resources.limits.memory | string | `"512Mi"` |  |
| redpanda.storage | string | `"5Gi"` |  |
| redpanda.storageClassName | string | `""` |  |
| rekoni.replicas | int | `1` |  |
| rekoni.resources.limits.memory | string | `"500Mi"` |  |
| rekoni.service | object | `{}` |  |
| secrets.aibotPassword | string | `""` |  |
| secrets.crDbUrl | string | `""` |  |
| secrets.existingSecret | string | `""` |  |
| secrets.openaiApiKey | string | `""` |  |
| secrets.openaiBaseUrl | string | `""` |  |
| secrets.redpandaPassword | string | `""` |  |
| secrets.serverSecret | string | `""` |  |
| secrets.storageConfig | string | `""` |  |
| serviceDefaults.annotations | object | `{}` |  |
| serviceDefaults.type | string | `"ClusterIP"` |  |
| stats.replicas | int | `1` |  |
| stats.resources.limits.memory | string | `"500Mi"` |  |
| stats.service | object | `{}` |  |
| storage.s3.accessKey | string | `""` |  |
| storage.s3.bucketPrefix | string | `""` |  |
| storage.s3.endpoint | string | `""` |  |
| storage.s3.region | string | `""` |  |
| storage.s3.rootBucket | string | `""` |  |
| storage.s3.secretKey | string | `""` |  |
| storage.type | string | `"minio"` |  |
| transactor.replicas | int | `1` |  |
| transactor.resources | object | `{}` |  |
| transactor.service | object | `{}` |  |
| workspace.replicas | int | `1` |  |
| workspace.resources.limits.memory | string | `"512Mi"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
