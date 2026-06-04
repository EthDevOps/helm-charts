# wazuh

![Version: 0.1.11](https://img.shields.io/badge/Version-0.1.11-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.14.5](https://img.shields.io/badge/AppVersion-4.14.5-informational?style=flat-square)

Wazuh is a free and open source security platform that unifies XDR and SIEM protection for endpoints and cloud workloads.

**Homepage:** <https://wazuh.com/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| EthDevOps |  | https://github.com/EthDevOps |

## Source Code

* <https://github.com/EthDevOps/helm-charts>
* <https://github.com/morgoved/wazuh-helm>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.jetstack.io | cert-manager | 1.16.3 |
| https://stakater.github.io/stakater-charts | reloader | 1.2.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cert-manager.enabled | bool | `false` |  |
| dashboard.annotations | object | `{}` |  |
| dashboard.config | string | `"{{- include \"wazuh.dashboard.config\" . | indent 2 -}}\n"` |  |
| dashboard.cred.existingSecret | string | `""` |  |
| dashboard.cred.password | string | `"kibanaserver"` |  |
| dashboard.cred.username | string | `"kibanaserver"` |  |
| dashboard.enable_ssl | bool | `false` |  |
| dashboard.images.pullPolicy | string | `"Always"` |  |
| dashboard.images.repository | string | `"wazuh/wazuh-dashboard"` |  |
| dashboard.images.tag | string | `"4.14.5"` |  |
| dashboard.images.updateStrategy | string | `"OnDelete"` |  |
| dashboard.ingress.annotations | object | `{}` |  |
| dashboard.ingress.enabled | bool | `false` |  |
| dashboard.ingress.host | string | `"wazuh.example.com"` |  |
| dashboard.ingress.tls | list | `[]` |  |
| dashboard.replicas | int | `1` |  |
| dashboard.resources.limits.cpu | string | `"1"` |  |
| dashboard.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| dashboard.resources.limits.memory | string | `"1Gi"` |  |
| dashboard.resources.requests.cpu | string | `"500m"` |  |
| dashboard.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| dashboard.resources.requests.memory | string | `"512Mi"` |  |
| dashboard.service.annotations | object | `{}` |  |
| dashboard.service.httpPort | int | `5601` |  |
| dashboard.service.type | string | `"ClusterIP"` |  |
| fullnameOverride | string | `nil` |  |
| indexer.annotations | object | `{}` |  |
| indexer.config.internalUsers | string | `"{{- include \"wazuh.indexer.internalUsers\" . | indent 2 -}}"` |  |
| indexer.config.opensearch | string | `"{{- include \"wazuh.indexer.opensearchConfig\" . | indent 2 -}}"` |  |
| indexer.cred.existingSecret | string | `""` |  |
| indexer.cred.password | string | `"SecretPassword"` |  |
| indexer.cred.username | string | `"admin"` |  |
| indexer.env.CLUSTER_NAME | string | `"wazuh"` |  |
| indexer.env.DISABLE_INSTALL_DEMO_CONFIG | string | `"true"` |  |
| indexer.env.NETWORK_HOST | string | `"0.0.0.0"` |  |
| indexer.env.OPENSEARCH_JAVA_OPTS | string | `"-Xms1g -Xmx1g -Dlog4j2.formatMsgNoLookups=true"` |  |
| indexer.images.imagePullSecrets.enabled | bool | `false` |  |
| indexer.images.imagePullSecrets.secret | object | `{}` |  |
| indexer.images.pullPolicy | string | `"Always"` |  |
| indexer.images.repository | string | `"wazuh/wazuh-indexer"` |  |
| indexer.images.tag | string | `"4.14.5"` |  |
| indexer.initContainers.increaseTheVmMaxMapCount.resources.limits.cpu | string | `"200m"` |  |
| indexer.initContainers.increaseTheVmMaxMapCount.resources.limits.ephemeral-storage | string | `"256Mi"` |  |
| indexer.initContainers.increaseTheVmMaxMapCount.resources.limits.memory | string | `"256Mi"` |  |
| indexer.initContainers.increaseTheVmMaxMapCount.resources.requests.cpu | string | `"50m"` |  |
| indexer.initContainers.increaseTheVmMaxMapCount.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| indexer.initContainers.increaseTheVmMaxMapCount.resources.requests.memory | string | `"128Mi"` |  |
| indexer.initContainers.volumeMountHack.resources.limits.cpu | string | `"200m"` |  |
| indexer.initContainers.volumeMountHack.resources.limits.ephemeral-storage | string | `"256Mi"` |  |
| indexer.initContainers.volumeMountHack.resources.limits.memory | string | `"256Mi"` |  |
| indexer.initContainers.volumeMountHack.resources.requests.cpu | string | `"50m"` |  |
| indexer.initContainers.volumeMountHack.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| indexer.initContainers.volumeMountHack.resources.requests.memory | string | `"128Mi"` |  |
| indexer.plugins | list | `[]` |  |
| indexer.replicas | int | `3` |  |
| indexer.resources.limits.cpu | string | `"2"` |  |
| indexer.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| indexer.resources.limits.memory | string | `"2Gi"` |  |
| indexer.resources.requests.cpu | string | `"500m"` |  |
| indexer.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| indexer.resources.requests.memory | string | `"1Gi"` |  |
| indexer.service.annotations | object | `{}` |  |
| indexer.service.httpPort | int | `9200` |  |
| indexer.service.metrics | int | `9600` |  |
| indexer.service.nodes | int | `9300` |  |
| indexer.storageClass | string | `nil` |  |
| indexer.storageSize | string | `"50Gi"` |  |
| indexer.updateStrategy | string | `"RollingUpdate"` |  |
| nameOverride | string | `nil` |  |
| networkPolicy.egress[0] | object | `{}` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.ingress[0] | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `true` |  |
| podDisruptionBudget.maxUnavailable | int | `1` |  |
| reloader.enabled | bool | `false` |  |
| utilityImage.alpine | string | `"alpine:3.20"` |  |
| utilityImage.busybox | string | `"busybox:1.36"` |  |
| utilityImage.pullPolicy | string | `"Always"` |  |
| wazuh.apiCred.existingSecret | string | `""` |  |
| wazuh.apiCred.password | string | `"MyS3cr37P450r.*-"` |  |
| wazuh.apiCred.username | string | `"wazuh-wui"` |  |
| wazuh.authd.existingSecret | string | `""` |  |
| wazuh.authd.pass | string | `"password"` |  |
| wazuh.env.FILEBEAT_SSL_VERIFICATION_MODE | string | `"full"` |  |
| wazuh.extraOssConfig | string | `""` |  |
| wazuh.googleWorkspace.existingSecret | string | `""` |  |
| wazuh.images.pullPolicy | string | `"Always"` |  |
| wazuh.images.pullSecret | string | `"regcred"` |  |
| wazuh.images.repository | string | `"wazuh/wazuh-manager"` |  |
| wazuh.images.tag | string | `"4.14.5"` |  |
| wazuh.initContainer.resources.limits.cpu | string | `"200m"` |  |
| wazuh.initContainer.resources.limits.ephemeral-storage | string | `"256Mi"` |  |
| wazuh.initContainer.resources.limits.memory | string | `"256Mi"` |  |
| wazuh.initContainer.resources.requests.cpu | string | `"50m"` |  |
| wazuh.initContainer.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| wazuh.initContainer.resources.requests.memory | string | `"128Mi"` |  |
| wazuh.key | string | `"c98b62a9b6169ac5f67dae55ae4a9088"` |  |
| wazuh.master.annotations | object | `{}` |  |
| wazuh.master.conf | string | `"{{- include \"wazuh.master.conf\" . | indent 2 -}}\n"` |  |
| wazuh.master.extraConf | string | `""` |  |
| wazuh.master.resources.limits.cpu | string | `"2"` |  |
| wazuh.master.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| wazuh.master.resources.limits.memory | string | `"1Gi"` |  |
| wazuh.master.resources.requests.cpu | string | `"500m"` |  |
| wazuh.master.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| wazuh.master.resources.requests.memory | string | `"512Mi"` |  |
| wazuh.master.service.annotations | object | `{}` |  |
| wazuh.master.service.ports.api | int | `55000` |  |
| wazuh.master.service.ports.registration | int | `1515` |  |
| wazuh.master.service.type | string | `"ClusterIP"` |  |
| wazuh.master.storageClass | string | `nil` |  |
| wazuh.master.storageSize | string | `"50Gi"` |  |
| wazuh.service.annotations | object | `{}` |  |
| wazuh.service.port | int | `1516` |  |
| wazuh.syslog_enable | bool | `true` |  |
| wazuh.worker.annotations | object | `{}` |  |
| wazuh.worker.conf | string | `"{{- include \"wazuh.worker.conf\" . | indent 2 -}}\n"` |  |
| wazuh.worker.extraConf | string | `""` |  |
| wazuh.worker.replicas | int | `2` |  |
| wazuh.worker.resources.limits.cpu | string | `"2"` |  |
| wazuh.worker.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| wazuh.worker.resources.limits.memory | string | `"1Gi"` |  |
| wazuh.worker.resources.requests.cpu | string | `"500m"` |  |
| wazuh.worker.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| wazuh.worker.resources.requests.memory | string | `"512Mi"` |  |
| wazuh.worker.service.annotations | object | `{}` |  |
| wazuh.worker.service.ports.agentEvents | int | `1514` |  |
| wazuh.worker.service.type | string | `"ClusterIP"` |  |
| wazuh.worker.storageClass | string | `nil` |  |
| wazuh.worker.storageSize | string | `"50Gi"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
