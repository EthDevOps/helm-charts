# appflowy

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

AppFlowy Cloud - Collaborative workspace platform

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| elasticroentgen | markus.keil@ethereum.org |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://ethdevops.github.io/helm-charts | postgresql | 1.1.6 |
| https://ethdevops.github.io/helm-charts | redis | 1.0.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| admin | object | `{"image":{"pullPolicy":"IfNotPresent","repository":"appflowyinc/admin_frontend","tag":"latest"},"replicaCount":1,"resources":{},"service":{"annotations":{},"nodePort":"","port":3000,"type":"NodePort"}}` | Admin frontend dashboard |
| ai | object | `{"enabled":false,"image":{"pullPolicy":"IfNotPresent","repository":"appflowyinc/appflowy_ai","tag":"latest"},"replicaCount":1,"resources":{},"service":{"annotations":{},"nodePort":"","port":5001,"type":"NodePort"}}` | AI service (optional) |
| appDomain | string | `"appflowy.example.com"` | Domain name for the AppFlowy instance |
| cloud | object | `{"databaseMaxConnections":"40","image":{"pullPolicy":"IfNotPresent","repository":"appflowyinc/appflowy_cloud","tag":"latest"},"replicaCount":1,"resources":{},"service":{"annotations":{},"nodePort":"","port":8000,"type":"NodePort"}}` | AppFlowy Cloud core backend |
| cloud.databaseMaxConnections | string | `"40"` | Max database connections |
| existingSecret | object | `{"jwtSecretKey":"GOTRUE_JWT_SECRET","name":""}` | Existing secret containing GOTRUE_JWT_SECRET |
| existingSecret.jwtSecretKey | string | `"GOTRUE_JWT_SECRET"` | Key in the secret containing the JWT secret |
| existingSecret.name | string | `""` | Name of the secret |
| gotrue | object | `{"adminEmail":"","adminPassword":"","disableSignup":false,"existingSecret":{"adminEmailKey":"GOTRUE_ADMIN_EMAIL","adminPasswordKey":"GOTRUE_ADMIN_PASSWORD","name":""},"image":{"pullPolicy":"IfNotPresent","repository":"appflowyinc/gotrue","tag":"latest"},"jwtExp":"7200","mailerAutoconfirm":false,"replicaCount":1,"resources":{},"service":{"annotations":{},"nodePort":"","port":9999,"type":"NodePort"}}` | GoTrue authentication service |
| gotrue.adminEmail | string | `""` | GoTrue admin credentials (ignored if existingSecret is set) |
| gotrue.disableSignup | bool | `false` | Disable new user signups |
| gotrue.existingSecret | object | `{"adminEmailKey":"GOTRUE_ADMIN_EMAIL","adminPasswordKey":"GOTRUE_ADMIN_PASSWORD","name":""}` | Existing secret for admin credentials |
| gotrue.jwtExp | string | `"7200"` | JWT expiry in seconds |
| gotrue.mailerAutoconfirm | bool | `false` | Auto-confirm email addresses |
| oauth | object | `{"discord":{"enabled":false,"existingSecret":{"clientIdKey":"DISCORD_CLIENT_ID","clientSecretKey":"DISCORD_CLIENT_SECRET","name":""},"redirectUri":""},"github":{"enabled":false,"existingSecret":{"clientIdKey":"GITHUB_CLIENT_ID","clientSecretKey":"GITHUB_CLIENT_SECRET","name":""},"redirectUri":""},"google":{"enabled":false,"existingSecret":{"clientIdKey":"GOOGLE_CLIENT_ID","clientSecretKey":"GOOGLE_CLIENT_SECRET","name":""},"redirectUri":""}}` | OAuth provider configuration |
| openai | object | `{"existingSecret":{"apiKeyKey":"OPENAI_API_KEY","name":""}}` | OpenAI configuration (for search and AI services) |
| postgresql | object | `{"auth":{"database":"appflowy","password":"appflowy","username":"appflowy"},"enabled":true,"image":{"repository":"pgvector/pgvector","tag":"pg16"}}` | PostgreSQL subchart configuration (pgvector required for AppFlowy) |
| redis | object | `{"architecture":"standalone","enabled":true,"master":{"service":{"ports":{"redis":6379}}}}` | Redis subchart configuration |
| s3 | object | `{"bucket":"appflowy","createBucket":true,"endpoint":"","existingSecret":{"accessKeyIdKey":"AWS_ACCESS_KEY_ID","name":"","secretAccessKeyKey":"AWS_SECRET_ACCESS_KEY"},"presignedUrlEndpoint":"","region":"us-east-1","useMinio":false}` | S3 storage configuration (uses existing S3, no minio) |
| s3.bucket | string | `"appflowy"` | S3 bucket name |
| s3.createBucket | bool | `true` | Create bucket on startup |
| s3.endpoint | string | `""` | S3 endpoint URL |
| s3.existingSecret | object | `{"accessKeyIdKey":"AWS_ACCESS_KEY_ID","name":"","secretAccessKeyKey":"AWS_SECRET_ACCESS_KEY"}` | Existing secret with S3 credentials |
| s3.presignedUrlEndpoint | string | `""` | Presigned URL endpoint (if different from endpoint) |
| s3.region | string | `"us-east-1"` | S3 region |
| s3.useMinio | bool | `false` | Use minio-compatible endpoint |
| search | object | `{"backgroundIndexerEnabled":true,"databaseIndexerEnabled":false,"enabled":false,"image":{"pullPolicy":"IfNotPresent","repository":"appflowyinc/appflowy_search","tag":"latest"},"keywordIndexMapSizeBytes":"2147483648","keywordSearchEnabled":true,"persistence":{"size":"5Gi"},"replicaCount":1,"resources":{},"service":{"annotations":{},"nodePort":"","port":4002,"type":"NodePort"}}` | Search service (optional) |
| search.backgroundIndexerEnabled | bool | `true` | Enable background indexer |
| search.databaseIndexerEnabled | bool | `false` | Enable database indexer |
| search.keywordIndexMapSizeBytes | string | `"2147483648"` | Keyword index map size in bytes (default 2GB) |
| search.keywordSearchEnabled | bool | `true` | Enable keyword search |
| smtp | object | `{"enabled":false,"existingSecret":{"name":"","passwordKey":"SMTP_PASSWORD"},"fromAddress":"noreply@example.com","fromName":"AppFlowy","host":"","port":"587","tlsKind":"starttls","username":""}` | SMTP mail configuration |
| smtp.tlsKind | string | `"starttls"` | TLS kind: none, starttls, tls |
| web | object | `{"image":{"pullPolicy":"IfNotPresent","repository":"appflowyinc/appflowy_web","tag":"latest"},"replicaCount":1,"resources":{},"service":{"annotations":{},"nodePort":"","port":80,"type":"NodePort"}}` | AppFlowy web frontend |
| worker | object | `{"image":{"pullPolicy":"IfNotPresent","repository":"appflowyinc/appflowy_worker","tag":"latest"},"importTickInterval":"30","replicaCount":1,"resources":{}}` | AppFlowy background worker |
| worker.importTickInterval | string | `"30"` | Import tick interval in seconds |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
