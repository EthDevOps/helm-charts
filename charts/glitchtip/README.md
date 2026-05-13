# glitchtip

![Version: 8.1.2](https://img.shields.io/badge/Version-8.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 6.0.10](https://img.shields.io/badge/AppVersion-6.0.10-informational?style=flat-square)

Open source error tracking that is compatible with Sentry

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://valkey.io/valkey-helm/ | valkey | ~0.9.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraEnvFrom | list | `[]` |  |
| extraEnvVars | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| glitchtip.database.existingSecret | string | `nil` | Existing secret containing the DATABASE_URL |
| glitchtip.database.existingSecretKey | string | `"DATABASE_URL"` | Key within the existingSecret that contains the DATABASE_URL |
| glitchtip.domain | string | `nil` | The domain name for the GlitchTip instance, used to generate absolute URLs |
| glitchtip.existingSecret | string | `nil` | Use an existing secret containing the SECRET_KEY (ignores secretKey if set) |
| glitchtip.existingSecretKey | string | `"SECRET_KEY"` | Key within the existingSecret that contains the SECRET_KEY value |
| glitchtip.maintenanceDatabase.existingSecret | string | `nil` | Existing secret containing the MAINTENANCE_DATABASE_URL |
| glitchtip.maintenanceDatabase.existingSecretKey | string | `"MAINTENANCE_DATABASE_URL"` | Key within the existingSecret that contains the MAINTENANCE_DATABASE_URL |
| glitchtip.readOnlyDatabase.existingSecret | string | `nil` | Existing secret containing the READ_ONLY_DATABASE_URL |
| glitchtip.readOnlyDatabase.existingSecretKey | string | `"READ_ONLY_DATABASE_URL"` | Key within the existingSecret that contains the READ_ONLY_DATABASE_URL |
| glitchtip.secretKey | string | `nil` | Secret key of the application. Set here or via existingSecret, not both. |
| glitchtip.valkey.existingSecret | string | `nil` | Existing secret containing the REDIS_URL |
| glitchtip.valkey.existingSecretKey | string | `"REDIS_URL"` | Key within the existingSecret that contains the REDIS_URL |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"glitchtip/glitchtip"` |  |
| image.tag | string | `"6.0.10"` |  |
| imagePullSecrets | list | `[]` |  |
| migrationJob.activeDeadlineSeconds | int | `900` |  |
| migrationJob.command[0] | string | `"bin/run-migrate.sh"` |  |
| migrationJob.database.existingSecret | string | `nil` |  |
| migrationJob.database.existingSecretKey | string | `"DATABASE_URL"` |  |
| migrationJob.enabled | bool | `true` |  |
| migrationJob.extraEnvFrom | list | `[]` |  |
| migrationJob.extraEnvVars | list | `[]` |  |
| migrationJob.podAnnotations | object | `{}` |  |
| migrationJob.resources.limits.cpu | string | `"1000m"` |  |
| migrationJob.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| migrationJob.resources.limits.memory | string | `"512Mi"` |  |
| migrationJob.resources.requests.cpu | string | `"100m"` |  |
| migrationJob.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| migrationJob.resources.requests.memory | string | `"256Mi"` |  |
| monitoring.enabled | bool | `false` |  |
| monitoring.interval | string | `"30s"` |  |
| monitoring.path | string | `"/metrics"` |  |
| monitoring.scrapeTimeout | string | `"10s"` |  |
| nameOverride | string | `""` |  |
| networkPolicy.egress[0] | object | `{}` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.ingress[0].ports[0].port | int | `8000` |  |
| networkPolicy.ingress[0].ports[0].protocol | string | `"TCP"` |  |
| networkPolicy.ingress[0].ports[1].port | int | `9100` |  |
| networkPolicy.ingress[0].ports[1].protocol | string | `"TCP"` |  |
| podSecurityContext | object | `{}` |  |
| postgresql.cluster.instances | int | `1` |  |
| postgresql.cluster.storage.size | string | `"1Gi"` |  |
| postgresql.cluster.storage.storageClass | string | `nil` |  |
| postgresql.enabled | bool | `true` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `nil` |  |
| tests.configuration.enabled | bool | `true` |  |
| tests.connection.image | string | `"busybox:1.36"` |  |
| valkey.dataStorage.enabled | bool | `false` |  |
| valkey.enabled | bool | `false` |  |
| valkey.image.pullPolicy | string | `"Always"` |  |
| valkey.initResources.limits.cpu | string | `"100m"` |  |
| valkey.initResources.limits.ephemeral-storage | string | `"128Mi"` |  |
| valkey.initResources.limits.memory | string | `"128Mi"` |  |
| valkey.initResources.requests.cpu | string | `"50m"` |  |
| valkey.initResources.requests.ephemeral-storage | string | `"64Mi"` |  |
| valkey.initResources.requests.memory | string | `"64Mi"` |  |
| valkey.networkPolicy.egress[0] | object | `{}` |  |
| valkey.networkPolicy.ingress[0].ports[0].port | int | `6379` |  |
| valkey.networkPolicy.ingress[0].ports[0].protocol | string | `"TCP"` |  |
| valkey.podSecurityContext.fsGroup | int | `10001` |  |
| valkey.podSecurityContext.runAsGroup | int | `10001` |  |
| valkey.podSecurityContext.runAsUser | int | `10001` |  |
| valkey.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| valkey.replicaCount | int | `1` |  |
| valkey.resources.limits.cpu | string | `"200m"` |  |
| valkey.resources.limits.ephemeral-storage | string | `"512Mi"` |  |
| valkey.resources.limits.memory | string | `"256Mi"` |  |
| valkey.resources.requests.cpu | string | `"100m"` |  |
| valkey.resources.requests.ephemeral-storage | string | `"128Mi"` |  |
| valkey.resources.requests.memory | string | `"128Mi"` |  |
| valkey.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| valkey.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| valkey.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| valkey.securityContext.runAsNonRoot | bool | `true` |  |
| valkey.securityContext.runAsUser | int | `10001` |  |
| web.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].key | string | `"app.kubernetes.io/component"` |  |
| web.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].operator | string | `"In"` |  |
| web.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].values[0] | string | `"web"` |  |
| web.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"kubernetes.io/hostname"` |  |
| web.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `100` |  |
| web.autoscaling.enabled | bool | `false` |  |
| web.autoscaling.maxReplicas | int | `10` |  |
| web.autoscaling.minReplicas | int | `2` |  |
| web.autoscaling.targetCPU | int | `80` |  |
| web.budget.minAvailable | int | `1` |  |
| web.embedWorker | bool | `false` | Embed the worker process in the web container (all-in-one mode). When true, sets GLITCHTIP_EMBED_WORKER=true so the web process also runs background tasks. Can be used with worker.enabled=false to run everything in a single deployment, or with worker.enabled=true to run both embedded and dedicated workers. |
| web.extraEnvFrom | list | `[]` |  |
| web.extraEnvVars | list | `[]` |  |
| web.ingress.annotations | object | `{}` |  |
| web.ingress.className | string | `""` | Ingress class name (e.g., nginx, traefik) |
| web.ingress.enabled | bool | `false` |  |
| web.ingress.hosts[0].host | string | `"chart-example.local"` |  |
| web.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| web.ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| web.ingress.tls | list | `[]` |  |
| web.lifecycle.preStop.sleep.seconds | int | `5` |  |
| web.livenessProbe.failureThreshold | int | `5` |  |
| web.livenessProbe.initialDelaySeconds | int | `5` |  |
| web.livenessProbe.timeoutSeconds | int | `3` |  |
| web.nodeSelector | object | `{}` |  |
| web.podAnnotations | object | `{}` |  |
| web.port | int | `8000` |  |
| web.readinessProbe.failureThreshold | int | `10` |  |
| web.readinessProbe.initialDelaySeconds | int | `5` |  |
| web.readinessProbe.timeoutSeconds | int | `2` |  |
| web.replicaCount | int | `2` |  |
| web.resources.limits.cpu | string | `"1000m"` |  |
| web.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| web.resources.limits.memory | string | `"512Mi"` |  |
| web.resources.requests.cpu | string | `"100m"` |  |
| web.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| web.resources.requests.memory | string | `"256Mi"` |  |
| web.service.port | int | `80` |  |
| web.service.type | string | `"ClusterIP"` |  |
| web.terminationGracePeriodSeconds | int | `30` |  |
| web.tolerations | list | `[]` |  |
| worker.affinity | object | `{}` |  |
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.maxReplicas | int | `10` |  |
| worker.autoscaling.minReplicas | int | `1` |  |
| worker.autoscaling.targetCPU | int | `100` |  |
| worker.database.existingSecret | string | `nil` |  |
| worker.database.existingSecretKey | string | `"DATABASE_URL"` |  |
| worker.enabled | bool | `true` |  |
| worker.extraEnvFrom | list | `[]` |  |
| worker.extraEnvVars | list | `[]` |  |
| worker.livenessProbe.exec.command[0] | string | `"/bin/sh"` |  |
| worker.livenessProbe.exec.command[1] | string | `"-c"` |  |
| worker.livenessProbe.exec.command[2] | string | `"test -f /tmp/worker_health && [ $(($(date +%s) - $(stat -c %Y /tmp/worker_health))) -lt 15 ]"` |  |
| worker.livenessProbe.initialDelaySeconds | int | `10` |  |
| worker.livenessProbe.periodSeconds | int | `30` |  |
| worker.livenessProbe.timeoutSeconds | int | `10` |  |
| worker.metricsPort | int | `9100` | Port for Prometheus metrics (VTASKS_METRICS_PORT) |
| worker.nodeSelector | object | `{}` |  |
| worker.podAnnotations | object | `{}` |  |
| worker.readinessProbe.exec.command[0] | string | `"/bin/sh"` |  |
| worker.readinessProbe.exec.command[1] | string | `"-c"` |  |
| worker.readinessProbe.exec.command[2] | string | `"test -f /tmp/worker_health"` |  |
| worker.readinessProbe.initialDelaySeconds | int | `10` |  |
| worker.readinessProbe.periodSeconds | int | `30` |  |
| worker.readinessProbe.timeoutSeconds | int | `10` |  |
| worker.replicaCount | int | `1` |  |
| worker.resources.limits.cpu | string | `"900m"` |  |
| worker.resources.limits.ephemeral-storage | string | `"1Gi"` |  |
| worker.resources.limits.memory | string | `"768Mi"` |  |
| worker.resources.requests.cpu | string | `"100m"` |  |
| worker.resources.requests.ephemeral-storage | string | `"256Mi"` |  |
| worker.resources.requests.memory | string | `"350Mi"` |  |
| worker.tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
