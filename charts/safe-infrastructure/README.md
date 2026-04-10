# safe-infrastructure

![Version: 0.1.19](https://img.shields.io/badge/Version-0.1.19-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for Safe Infrastructure services

**Homepage:** <https://github.com/safe-global>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Safe Team |  |  |

## Source Code

* <https://github.com/safe-global>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| baseUrl | string | `"http://localhost"` |  |
| cfg.env.cgwUrl | string | `"http://nginx:8000/cgw"` |  |
| cfg.env.csrfTrustedOrigins | string | `"http://localhost:8000"` |  |
| cfg.env.debug | string | `"true"` |  |
| cfg.env.defaultFileStorage | string | `"django.core.files.storage.FileSystemStorage"` |  |
| cfg.env.djangoAllowedHosts | string | `"*"` |  |
| cfg.env.djangoOtpAdmin | string | `"false"` |  |
| cfg.env.dockerNginxVolumeRoot | string | `"/nginx"` |  |
| cfg.env.dockerWebVolume | string | `".:/app"` |  |
| cfg.env.forceScriptName | string | `"/cfg/"` |  |
| cfg.env.gunicornBindPort | string | `"8001"` |  |
| cfg.env.gunicornWebReload | string | `"false"` |  |
| cfg.env.mediaUrl | string | `"http://localhost:8000/cfg/media/"` |  |
| cfg.env.nginxEnvsubstOutputDir | string | `"/etc/nginx/"` |  |
| cfg.env.pythonDontWriteBytecode | string | `"true"` |  |
| cfg.env.rootLogLevel | string | `"DEBUG"` |  |
| cfg.image | string | `"safeglobal/safe-config-service"` |  |
| cfg.replicas | int | `1` |  |
| cgw.env.emailApiApplicationCode | string | `""` |  |
| cgw.env.emailApiFromEmail | string | `"changeme@example.com"` |  |
| cgw.env.emailApiKey | string | `""` |  |
| cgw.env.emailTemplateRecoveryTx | string | `""` |  |
| cgw.env.emailTemplateUnknownRecoveryTx | string | `""` |  |
| cgw.env.emailTemplateVerificationCode | string | `""` |  |
| cgw.env.httpClientRequestTimeoutMilliseconds | string | `"60000"` |  |
| cgw.env.infuraApiKey | string | `""` |  |
| cgw.env.logLevel | string | `"info"` |  |
| cgw.env.pushNotificationsApiProject | string | `""` |  |
| cgw.env.pushNotificationsApiServiceAccountClientEmail | string | `"changeme@example.com"` |  |
| cgw.env.pushNotificationsApiServiceAccountPrivateKey | string | `""` |  |
| cgw.env.relayProviderApiKeyArbitrumOne | string | `""` |  |
| cgw.env.relayProviderApiKeyAvalanche | string | `""` |  |
| cgw.env.relayProviderApiKeyBase | string | `""` |  |
| cgw.env.relayProviderApiKeyBlast | string | `""` |  |
| cgw.env.relayProviderApiKeyBsc | string | `""` |  |
| cgw.env.relayProviderApiKeyGnosisChain | string | `""` |  |
| cgw.env.relayProviderApiKeyLinea | string | `""` |  |
| cgw.env.relayProviderApiKeyOptimism | string | `""` |  |
| cgw.env.relayProviderApiKeyPolygon | string | `""` |  |
| cgw.env.relayProviderApiKeyPolygonZkevm | string | `""` |  |
| cgw.env.relayProviderApiKeySepolia | string | `""` |  |
| cgw.env.safeConfigBaseUri | string | `"http://nginx:8000/cfg"` |  |
| cgw.env.stakingApiKey | string | `""` |  |
| cgw.env.stakingTestnetApiKey | string | `""` |  |
| cgw.image | string | `"safeglobal/safe-client-gateway-nest"` |  |
| cgw.replicas | int | `1` |  |
| credentials.cfg.secretKey | string | `"insecure_key_for_dev"` |  |
| credentials.cgw.authToken | string | `"your_privileged_endpoints_token"` |  |
| credentials.cgw.fingerprintEncryptionKey | string | `""` |  |
| credentials.django.secretKey | string | `"Very-secure-secret-string"` |  |
| credentials.django.superuser.email | string | `"test@example.com"` |  |
| credentials.django.superuser.password | string | `"admin"` |  |
| credentials.django.superuser.username | string | `"root"` |  |
| credentials.events.adminEmail | string | `"admin@safe"` |  |
| credentials.events.adminPassword | string | `"password"` |  |
| credentials.jwt.issuer | string | `""` |  |
| credentials.jwt.secret | string | `""` |  |
| credentials.postgres.database | string | `"postgres"` |  |
| credentials.postgres.password | string | `"postgres"` |  |
| credentials.postgres.user | string | `"postgres"` |  |
| databases.postgres.image | string | `"postgres:14-alpine"` |  |
| databases.postgres.maxConnections | int | `250` |  |
| events.env.amqpExchange | string | `"safe-transaction-service-events"` |  |
| events.env.amqpQueue | string | `"safe-events-service"` |  |
| events.env.nodeEnv | string | `"production"` |  |
| events.env.urlBasePath | string | `"/events"` |  |
| events.env.webhooksCacheTtl | string | `"300000"` |  |
| events.image | string | `"safeglobal/safe-events-service"` |  |
| events.replicas | int | `1` |  |
| global.reverseProxyPort | int | `8000` |  |
| global.rpcNodeUrl | string | `""` |  |
| healthCheck.enabled | bool | `true` |  |
| healthCheck.failureThreshold | int | `3` |  |
| healthCheck.initialDelaySeconds | int | `30` |  |
| healthCheck.periodSeconds | int | `30` |  |
| healthCheck.successThreshold | int | `1` |  |
| healthCheck.timeoutSeconds | int | `30` |  |
| images.cfgVersion | string | `"latest"` |  |
| images.cgwVersion | string | `"latest"` |  |
| images.eventsVersion | string | `"latest"` |  |
| images.txsVersion | string | `"latest"` |  |
| images.uiVersion | string | `"latest"` |  |
| nginx.image | string | `"nginx:alpine"` |  |
| nginx.replicas | int | `1` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.enabled | bool | `true` |  |
| persistence.size | string | `"10Gi"` |  |
| persistence.storageClass | string | `""` |  |
| rabbitmq.image | string | `"rabbitmq:alpine"` |  |
| redis.image | string | `"redis:alpine"` |  |
| resources | object | `{}` |  |
| services.cfgWeb.port | int | `8001` |  |
| services.cfgWeb.type | string | `"ClusterIP"` |  |
| services.cgwWeb.port | int | `3000` |  |
| services.cgwWeb.type | string | `"ClusterIP"` |  |
| services.eventsWeb.port | int | `3000` |  |
| services.eventsWeb.type | string | `"ClusterIP"` |  |
| services.nginx.port | int | `8000` |  |
| services.nginx.type | string | `"LoadBalancer"` |  |
| services.txsWeb.port | int | `8000` |  |
| services.txsWeb.type | string | `"ClusterIP"` |  |
| services.ui.port | int | `8080` |  |
| services.ui.type | string | `"ClusterIP"` |  |
| tolerations | list | `[]` |  |
| txs.env.csrfTrustedOrigins | string | `"http://localhost:8000"` |  |
| txs.env.debug | string | `"0"` |  |
| txs.env.djangoAllowedHosts | string | `"*"` |  |
| txs.env.djangoSettingsModule | string | `"config.settings.production"` |  |
| txs.env.ethL2Network | string | `"1"` |  |
| txs.env.eventsQueueAsyncConnection | string | `"True"` |  |
| txs.env.eventsQueueExchangeName | string | `"safe-transaction-service-events"` |  |
| txs.env.forceScriptName | string | `"/txs/"` |  |
| txs.env.pythonPath | string | `"/app/"` |  |
| txs.image | string | `"safeglobal/safe-transaction-service"` |  |
| txs.replicas | int | `1` |  |
| ui.env.nextPublicBeamerId | string | `""` |  |
| ui.env.nextPublicCypressMnemonic | string | `""` |  |
| ui.env.nextPublicFortmaticKey | string | `""` |  |
| ui.env.nextPublicGatewayUrlProduction | string | `"http://localhost:8000/cgw"` |  |
| ui.env.nextPublicInfuraToken | string | `""` |  |
| ui.env.nextPublicIsProduction | string | `"true"` |  |
| ui.env.nextPublicPortisKey | string | `""` |  |
| ui.env.nextPublicSafeAppsInfuraToken | string | `""` |  |
| ui.env.nextPublicSafeVersion | string | `"1.4.1"` |  |
| ui.env.nextPublicSentryDsn | string | `""` |  |
| ui.env.nextPublicTenderlyOrgName | string | `""` |  |
| ui.env.nextPublicTenderlyProjectName | string | `""` |  |
| ui.env.nextPublicTenderlySimulateEndpointUrl | string | `""` |  |
| ui.env.nextPublicWcBridge | string | `""` |  |
| ui.image | string | `"safeglobal/safe-wallet-web"` |  |
| ui.replicas | int | `1` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
