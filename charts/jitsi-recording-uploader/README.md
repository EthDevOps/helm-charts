# jitsi-recording-uploader

![Version: 1.1.1](https://img.shields.io/badge/Version-1.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for Jitsi Recording Uploader - automatically uploads Jibri recordings to Google Drive

**Homepage:** <https://github.com/your-org/jitsi-recording-uploader>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Your Name | your-email@example.com |  |

## Source Code

* <https://github.com/your-org/jitsi-recording-uploader>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchExpressions[0].key | string | `"app.kubernetes.io/component"` |  |
| affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchExpressions[0].operator | string | `"In"` |  |
| affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchExpressions[0].values[0] | string | `"jibri"` |  |
| affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].topologyKey | string | `"kubernetes.io/hostname"` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `1` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| config.app.cleanupAfterUpload | bool | `false` |  |
| config.app.logLevel | string | `"info"` |  |
| config.app.maxRetries | int | `3` |  |
| config.app.watchInterval | int | `5000` |  |
| config.googleDrive.redirectUri | string | `"http://localhost:3000/oauth2callback"` |  |
| config.googleDrive.uploadFolderId | string | `""` |  |
| config.jibri.pvcName | string | `"jibri-recordings-pvc"` |  |
| config.jibri.readOnly | bool | `true` |  |
| config.jibri.recordingsPath | string | `"/recordings"` |  |
| config.mode | string | `"recordings"` |  |
| config.transcriptsPath | string | `"/transcripts"` |  |
| credentials.externalSecret.data[0].remoteRef.key | string | `"google-drive/jitsi-uploader"` |  |
| credentials.externalSecret.data[0].remoteRef.property | string | `"client-id"` |  |
| credentials.externalSecret.data[0].secretKey | string | `"GOOGLE_CLIENT_ID"` |  |
| credentials.externalSecret.data[1].remoteRef.key | string | `"google-drive/jitsi-uploader"` |  |
| credentials.externalSecret.data[1].remoteRef.property | string | `"client-secret"` |  |
| credentials.externalSecret.data[1].secretKey | string | `"GOOGLE_CLIENT_SECRET"` |  |
| credentials.externalSecret.data[2].remoteRef.key | string | `"google-drive/jitsi-uploader"` |  |
| credentials.externalSecret.data[2].remoteRef.property | string | `"refresh-token"` |  |
| credentials.externalSecret.data[2].secretKey | string | `"GOOGLE_REFRESH_TOKEN"` |  |
| credentials.externalSecret.name | string | `"jitsi-uploader-external-secret"` |  |
| credentials.externalSecret.secretName | string | `"jitsi-uploader-credentials"` |  |
| credentials.externalSecret.secretStore.kind | string | `"SecretStore"` |  |
| credentials.externalSecret.secretStore.name | string | `"vault-secret-store"` |  |
| credentials.googleDrive.clientId | string | `""` |  |
| credentials.googleDrive.clientSecret | string | `""` |  |
| credentials.googleDrive.refreshToken | string | `""` |  |
| credentials.method | string | `"secret"` |  |
| extraEnv | list | `[]` |  |
| extraEnvFrom | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"docker.ethquokkaops.io/ethquokkaops/ethdevops/jitsi-recording-uploader"` |  |
| image.tag | string | `"latest"` |  |
| imagePullSecrets | list | `[]` |  |
| monitoring.enabled | bool | `false` |  |
| monitoring.interval | string | `"30s"` |  |
| monitoring.labels | object | `{}` |  |
| monitoring.path | string | `"/metrics"` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `false` |  |
| podDisruptionBudget.minAvailable | int | `1` |  |
| podSecurityContext.fsGroup | int | `1001` |  |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.failureThreshold | int | `3` |  |
| probes.liveness.initialDelaySeconds | int | `30` |  |
| probes.liveness.periodSeconds | int | `30` |  |
| probes.liveness.timeoutSeconds | int | `5` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.failureThreshold | int | `3` |  |
| probes.readiness.initialDelaySeconds | int | `10` |  |
| probes.readiness.periodSeconds | int | `10` |  |
| probes.readiness.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"200m"` |  |
| resources.limits.memory | string | `"256Mi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1001` |  |
| service.port | int | `3000` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
