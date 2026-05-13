# outline

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

OpenSource alternative for Notion

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| elasticroentgen | markus.keil@ethereum.org |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://ethdevops.github.io/helm-charts | postgresql | 1.1.8 |
| https://ethdevops.github.io/helm-charts | redis | 1.0.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| appDomain | string | `"outline.example.com"` |  |
| awsAccessKeyId | string | `"get_a_key_from_aws"` |  |
| awsRegion | string | `"xx-xxxx-x"` |  |
| awsS3AccelerateUrl | string | `""` |  |
| awsS3Acl | string | `"private"` |  |
| awsS3ForcePathStyle | bool | `true` |  |
| awsS3UploadBucketName | string | `"bucket_name_here"` |  |
| awsS3UploadBucketUrl | string | `"http://s3:4569"` |  |
| awsSecretAccessKey | string | `"get_the_secret_of_above_key"` |  |
| azureClientId | string | `""` |  |
| azureClientSecret | string | `""` |  |
| azureResourceAppId | string | `""` |  |
| cdnUrl | string | `""` |  |
| collaborationUrl | string | `""` |  |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| containerSecurityContext.readOnlyRootFilesystem | bool | `false` |  |
| containerSecurityContext.runAsGroup | int | `1000` |  |
| containerSecurityContext.runAsNonRoot | bool | `true` |  |
| containerSecurityContext.runAsUser | int | `1000` |  |
| databaseConnectionPoolMax | string | `""` |  |
| databaseConnectionPoolMin | string | `""` |  |
| databaseUrl | string | `"postgresql://postgres:postgres@db:5432/postgres?schema=public"` |  |
| debug | string | `"http"` |  |
| defaultLanguage | string | `"en_US"` |  |
| discordClientId | string | `""` |  |
| discordClientSecret | string | `""` |  |
| discordServerId | string | `""` |  |
| discordServerRoles | string | `""` |  |
| dropboxAppKey | string | `""` |  |
| enableUpdates | bool | `true` |  |
| existingSecret | string | `""` |  |
| fileStorage | string | `"local"` |  |
| fileStorageImportMaxSize | string | `""` |  |
| fileStorageLocalRootDir | string | `"/var/lib/outline/data"` |  |
| fileStorageUploadMaxSize | int | `262144000` |  |
| fileStorageWorkspaceImportMaxSize | string | `""` |  |
| forceHttps | bool | `true` |  |
| githubAppId | string | `""` |  |
| githubAppName | string | `""` |  |
| githubAppPrivateKey | string | `""` |  |
| githubClientId | string | `""` |  |
| githubClientSecret | string | `""` |  |
| googleClientId | string | `""` |  |
| googleClientSecret | string | `""` |  |
| iframelyApiKey | string | `""` |  |
| iframelyUrl | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"docker.getoutline.com/outlinewiki/outline"` |  |
| image.tag | string | `"latest"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `true` |  |
| ingress.tls.secretName | string | `"outline-tls"` |  |
| initContainer.image | string | `"alpine:3.20"` |  |
| initContainer.imagePullPolicy | string | `"Always"` |  |
| initContainer.resources.limits.cpu | string | `"200m"` |  |
| initContainer.resources.limits.ephemeral-storage | string | `"256Mi"` |  |
| initContainer.resources.limits.memory | string | `"128Mi"` |  |
| initContainer.resources.requests.cpu | string | `"50m"` |  |
| initContainer.resources.requests.ephemeral-storage | string | `"64Mi"` |  |
| initContainer.resources.requests.memory | string | `"64Mi"` |  |
| logLevel | string | `"info"` |  |
| networkPolicy.egress[0] | object | `{}` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.ingress[0].ports[0].port | int | `3000` |  |
| networkPolicy.ingress[0].ports[0].protocol | string | `"TCP"` |  |
| oidcAuthUri | string | `""` |  |
| oidcClientId | string | `""` |  |
| oidcClientSecret | string | `""` |  |
| oidcDisplayName | string | `"OpenID Connect"` |  |
| oidcLogoutUri | string | `""` |  |
| oidcScopes | string | `"openid profile email"` |  |
| oidcTokenUri | string | `""` |  |
| oidcUserinfoUri | string | `""` |  |
| oidcUsernameClaim | string | `"preferred_username"` |  |
| persistence.size | string | `"1Gi"` |  |
| podDisruptionBudget.enabled | bool | `true` |  |
| podDisruptionBudget.maxUnavailable | int | `1` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| port | int | `3000` |  |
| postgresql.auth.password | string | `"outline"` |  |
| postgresql.auth.username | string | `"outline"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.pullPolicy | string | `"Always"` |  |
| postgresql.image.tag | string | `"16-alpine"` |  |
| postgresql.networkPolicy.enabled | bool | `true` |  |
| postgresql.resources.limits.cpu | string | `"1"` |  |
| postgresql.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| postgresql.resources.limits.memory | string | `"1Gi"` |  |
| postgresql.resources.requests.cpu | string | `"250m"` |  |
| postgresql.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| postgresql.resources.requests.memory | string | `"256Mi"` |  |
| rateLimiterDurationWindow | int | `60` |  |
| rateLimiterEnabled | bool | `true` |  |
| rateLimiterRequests | int | `1000` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.enabled | bool | `true` |  |
| redis.image.pullPolicy | string | `"Always"` |  |
| redis.resources.limits.cpu | string | `"500m"` |  |
| redis.resources.limits.ephemeral-storage | string | `"512Mi"` |  |
| redis.resources.limits.memory | string | `"512Mi"` |  |
| redis.resources.requests.cpu | string | `"100m"` |  |
| redis.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| redis.resources.requests.memory | string | `"128Mi"` |  |
| redisUrl | string | `"redis://redis:6379"` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"1"` |  |
| resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| resources.limits.memory | string | `"2Gi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| secretKey | string | `"947f6c8871b9e176bd4cbf90c9b6ef365094781a7b70781afc73d2eaa0b04872"` |  |
| sentryDsn | string | `""` |  |
| sentryTunnel | string | `""` |  |
| service.annotations | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| slackAppId | string | `"A0XXXXXXX"` |  |
| slackClientId | string | `"get_a_key_from_slack"` |  |
| slackClientSecret | string | `"get_the_secret_of_above_key"` |  |
| slackMessageActions | bool | `true` |  |
| slackVerificationToken | string | `"your_token"` |  |
| smtpFromEmail | string | `""` |  |
| smtpHost | string | `""` |  |
| smtpPassword | string | `""` |  |
| smtpPort | string | `""` |  |
| smtpReplyEmail | string | `""` |  |
| smtpSecure | bool | `true` |  |
| smtpTlsCiphers | string | `""` |  |
| smtpUsername | string | `""` |  |
| sslCert | string | `""` |  |
| sslKey | string | `""` |  |
| url | string | `""` |  |
| utilsSecret | string | `"947f6c8871b9e176bd4cbf90c9b6ef365094781a7b70781afc73d2eaa0b04872"` |  |
| webConcurrency | int | `1` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
