# discourse

![Version: 16.0.1](https://img.shields.io/badge/Version-16.0.1-informational?style=flat-square) ![AppVersion: 3.4.3](https://img.shields.io/badge/AppVersion-3.4.3-informational?style=flat-square)

Discourse is an open source discussion platform with built-in moderation and governance systems that let discussion communities protect themselves from bad actors even without official moderators.

**Homepage:** <https://bitnami.com>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Broadcom, Inc. All Rights Reserved. |  | https://github.com/bitnami/charts |
| paulczar | username.taken@gmail.com |  |
| lucaprete | preteluca@gmail.com |  |

## Source Code

* <https://github.com/bitnami/charts/tree/main/bitnami/discourse>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://registry-1.docker.io/bitnamicharts | common | 2.x.x |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 16.X.X |
| oci://registry-1.docker.io/bitnamicharts | redis | 21.X.X |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| auth.email | string | `"user@example.com"` |  |
| auth.existingSecret | string | `""` |  |
| auth.password | string | `""` |  |
| auth.username | string | `"user"` |  |
| automountServiceAccountToken | bool | `false` |  |
| clusterDomain | string | `"cluster.local"` |  |
| commonAnnotations | object | `{}` |  |
| commonLabels | object | `{}` |  |
| diagnosticMode.args[0] | string | `"infinity"` |  |
| diagnosticMode.command[0] | string | `"sleep"` |  |
| diagnosticMode.enabled | bool | `false` |  |
| discourse.args | list | `[]` |  |
| discourse.command | list | `[]` |  |
| discourse.compatiblePlugins | bool | `true` |  |
| discourse.containerPorts.http | int | `8080` |  |
| discourse.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| discourse.containerSecurityContext.capabilities.add[0] | string | `"CHOWN"` |  |
| discourse.containerSecurityContext.capabilities.add[1] | string | `"SYS_CHROOT"` |  |
| discourse.containerSecurityContext.capabilities.add[2] | string | `"FOWNER"` |  |
| discourse.containerSecurityContext.capabilities.add[3] | string | `"SETGID"` |  |
| discourse.containerSecurityContext.capabilities.add[4] | string | `"SETUID"` |  |
| discourse.containerSecurityContext.capabilities.add[5] | string | `"DAC_OVERRIDE"` |  |
| discourse.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| discourse.containerSecurityContext.enabled | bool | `true` |  |
| discourse.containerSecurityContext.privileged | bool | `false` |  |
| discourse.containerSecurityContext.readOnlyRootFilesystem | bool | `false` |  |
| discourse.containerSecurityContext.runAsGroup | int | `0` |  |
| discourse.containerSecurityContext.runAsNonRoot | bool | `false` |  |
| discourse.containerSecurityContext.runAsUser | int | `0` |  |
| discourse.containerSecurityContext.seLinuxOptions | object | `{}` |  |
| discourse.containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| discourse.customLivenessProbe | object | `{}` |  |
| discourse.customReadinessProbe | object | `{}` |  |
| discourse.customStartupProbe | object | `{}` |  |
| discourse.extraContainerPorts | list | `[]` |  |
| discourse.extraEnvVars | list | `[]` |  |
| discourse.extraEnvVarsCM | string | `""` |  |
| discourse.extraEnvVarsSecret | string | `""` |  |
| discourse.extraVolumeMounts | list | `[]` |  |
| discourse.lifecycleHooks | object | `{}` |  |
| discourse.livenessProbe.enabled | bool | `true` |  |
| discourse.livenessProbe.failureThreshold | int | `6` |  |
| discourse.livenessProbe.initialDelaySeconds | int | `500` |  |
| discourse.livenessProbe.periodSeconds | int | `10` |  |
| discourse.livenessProbe.successThreshold | int | `1` |  |
| discourse.livenessProbe.timeoutSeconds | int | `5` |  |
| discourse.persistPlugins | bool | `true` |  |
| discourse.plugins | list | `[]` |  |
| discourse.readinessProbe.enabled | bool | `true` |  |
| discourse.readinessProbe.failureThreshold | int | `6` |  |
| discourse.readinessProbe.initialDelaySeconds | int | `180` |  |
| discourse.readinessProbe.periodSeconds | int | `10` |  |
| discourse.readinessProbe.successThreshold | int | `1` |  |
| discourse.readinessProbe.timeoutSeconds | int | `5` |  |
| discourse.resources | object | `{}` |  |
| discourse.resourcesPreset | string | `"2xlarge"` |  |
| discourse.skipInstall | bool | `false` |  |
| discourse.startupProbe.enabled | bool | `false` |  |
| discourse.startupProbe.failureThreshold | int | `15` |  |
| discourse.startupProbe.initialDelaySeconds | int | `60` |  |
| discourse.startupProbe.periodSeconds | int | `10` |  |
| discourse.startupProbe.successThreshold | int | `1` |  |
| discourse.startupProbe.timeoutSeconds | int | `5` |  |
| externalDatabase.create | bool | `true` |  |
| externalDatabase.database | string | `"bitnami_application"` |  |
| externalDatabase.existingSecret | string | `""` |  |
| externalDatabase.existingSecretPasswordKey | string | `"password"` |  |
| externalDatabase.existingSecretPostgresPasswordKey | string | `"postgres-password"` |  |
| externalDatabase.host | string | `"localhost"` |  |
| externalDatabase.password | string | `""` |  |
| externalDatabase.port | int | `5432` |  |
| externalDatabase.postgresPassword | string | `""` |  |
| externalDatabase.postgresUser | string | `""` |  |
| externalDatabase.user | string | `"bn_discourse"` |  |
| externalRedis.existingSecret | string | `""` |  |
| externalRedis.existingSecretPasswordKey | string | `"redis-password"` |  |
| externalRedis.host | string | `"localhost"` |  |
| externalRedis.password | string | `""` |  |
| externalRedis.port | int | `6379` |  |
| extraDeploy | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| global.compatibility.openshift.adaptSecurityContext | string | `"auto"` |  |
| global.defaultStorageClass | string | `""` |  |
| global.imagePullSecrets | list | `[]` |  |
| global.imageRegistry | string | `""` |  |
| global.security.allowInsecureImages | bool | `false` |  |
| global.storageClass | string | `""` |  |
| host | string | `""` |  |
| hostAliases | list | `[]` |  |
| image.debug | bool | `false` |  |
| image.digest | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecrets | list | `[]` |  |
| image.registry | string | `"docker.io"` |  |
| image.repository | string | `"bitnami/discourse"` |  |
| image.tag | string | `"3.4.3-debian-12-r0"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.apiVersion | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.extraHosts | list | `[]` |  |
| ingress.extraPaths | list | `[]` |  |
| ingress.extraRules | list | `[]` |  |
| ingress.extraTls | list | `[]` |  |
| ingress.hostname | string | `"discourse.local"` |  |
| ingress.ingressClassName | string | `""` |  |
| ingress.path | string | `"/"` |  |
| ingress.pathType | string | `"ImplementationSpecific"` |  |
| ingress.secrets | list | `[]` |  |
| ingress.selfSigned | bool | `false` |  |
| ingress.tls | bool | `false` |  |
| initContainers | list | `[]` |  |
| kubeVersion | string | `""` |  |
| nameOverride | string | `""` |  |
| networkPolicy.allowExternal | bool | `true` |  |
| networkPolicy.allowExternalEgress | bool | `true` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.extraEgress | list | `[]` |  |
| networkPolicy.extraIngress | list | `[]` |  |
| networkPolicy.ingressNSMatchLabels | object | `{}` |  |
| networkPolicy.ingressNSPodMatchLabels | object | `{}` |  |
| nodeAffinityPreset.key | string | `""` |  |
| nodeAffinityPreset.type | string | `""` |  |
| nodeAffinityPreset.values | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| pdb.create | bool | `true` |  |
| pdb.maxUnavailable | string | `""` |  |
| pdb.minAvailable | string | `""` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.selector | object | `{}` |  |
| persistence.size | string | `"10Gi"` |  |
| persistence.storageClass | string | `""` |  |
| podAffinityPreset | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podAntiAffinityPreset | string | `"soft"` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.enabled | bool | `true` |  |
| podSecurityContext.fsGroup | int | `0` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"Always"` |  |
| podSecurityContext.supplementalGroups | list | `[]` |  |
| podSecurityContext.sysctls | list | `[]` |  |
| postgresql.architecture | string | `"standalone"` |  |
| postgresql.auth.database | string | `"bitnami_application"` |  |
| postgresql.auth.enablePostgresUser | bool | `true` |  |
| postgresql.auth.existingSecret | string | `""` |  |
| postgresql.auth.password | string | `""` |  |
| postgresql.auth.postgresPassword | string | `"bitnami"` |  |
| postgresql.auth.username | string | `"bn_discourse"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.primary.resources | object | `{}` |  |
| postgresql.primary.resourcesPreset | string | `"nano"` |  |
| priorityClassName | string | `""` |  |
| redis.architecture | string | `"standalone"` |  |
| redis.auth.enabled | bool | `true` |  |
| redis.auth.existingSecret | string | `""` |  |
| redis.auth.password | string | `""` |  |
| redis.enabled | bool | `true` |  |
| redis.master.resources | object | `{}` |  |
| redis.master.resourcesPreset | string | `"nano"` |  |
| replicaCount | int | `1` |  |
| schedulerName | string | `""` |  |
| service.annotations | object | `{}` |  |
| service.clusterIP | string | `""` |  |
| service.externalTrafficPolicy | string | `"Cluster"` |  |
| service.extraPorts | list | `[]` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePorts.http | string | `""` |  |
| service.ports.http | int | `80` |  |
| service.sessionAffinity | string | `"None"` |  |
| service.sessionAffinityConfig | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `false` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| sidecars | list | `[]` |  |
| sidekiq.args[0] | string | `"/opt/bitnami/scripts/discourse-sidekiq/run.sh"` |  |
| sidekiq.command[0] | string | `"/opt/bitnami/scripts/discourse/entrypoint.sh"` |  |
| sidekiq.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| sidekiq.containerSecurityContext.capabilities.add[0] | string | `"CHOWN"` |  |
| sidekiq.containerSecurityContext.capabilities.add[1] | string | `"SYS_CHROOT"` |  |
| sidekiq.containerSecurityContext.capabilities.add[2] | string | `"FOWNER"` |  |
| sidekiq.containerSecurityContext.capabilities.add[3] | string | `"SETGID"` |  |
| sidekiq.containerSecurityContext.capabilities.add[4] | string | `"SETUID"` |  |
| sidekiq.containerSecurityContext.capabilities.add[5] | string | `"DAC_OVERRIDE"` |  |
| sidekiq.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| sidekiq.containerSecurityContext.enabled | bool | `true` |  |
| sidekiq.containerSecurityContext.privileged | bool | `false` |  |
| sidekiq.containerSecurityContext.readOnlyRootFilesystem | bool | `false` |  |
| sidekiq.containerSecurityContext.runAsGroup | int | `0` |  |
| sidekiq.containerSecurityContext.runAsNonRoot | bool | `false` |  |
| sidekiq.containerSecurityContext.runAsUser | int | `0` |  |
| sidekiq.containerSecurityContext.seLinuxOptions | object | `{}` |  |
| sidekiq.containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| sidekiq.customLivenessProbe | object | `{}` |  |
| sidekiq.customReadinessProbe | object | `{}` |  |
| sidekiq.customStartupProbe | object | `{}` |  |
| sidekiq.extraEnvVars | list | `[]` |  |
| sidekiq.extraEnvVarsCM | string | `""` |  |
| sidekiq.extraEnvVarsSecret | string | `""` |  |
| sidekiq.extraVolumeMounts | list | `[]` |  |
| sidekiq.lifecycleHooks | object | `{}` |  |
| sidekiq.livenessProbe.enabled | bool | `true` |  |
| sidekiq.livenessProbe.failureThreshold | int | `6` |  |
| sidekiq.livenessProbe.initialDelaySeconds | int | `500` |  |
| sidekiq.livenessProbe.periodSeconds | int | `10` |  |
| sidekiq.livenessProbe.successThreshold | int | `1` |  |
| sidekiq.livenessProbe.timeoutSeconds | int | `5` |  |
| sidekiq.readinessProbe.enabled | bool | `true` |  |
| sidekiq.readinessProbe.failureThreshold | int | `6` |  |
| sidekiq.readinessProbe.initialDelaySeconds | int | `30` |  |
| sidekiq.readinessProbe.periodSeconds | int | `10` |  |
| sidekiq.readinessProbe.successThreshold | int | `1` |  |
| sidekiq.readinessProbe.timeoutSeconds | int | `5` |  |
| sidekiq.resources | object | `{}` |  |
| sidekiq.resourcesPreset | string | `"small"` |  |
| sidekiq.startupProbe.enabled | bool | `false` |  |
| sidekiq.startupProbe.failureThreshold | int | `15` |  |
| sidekiq.startupProbe.initialDelaySeconds | int | `60` |  |
| sidekiq.startupProbe.periodSeconds | int | `10` |  |
| sidekiq.startupProbe.successThreshold | int | `1` |  |
| sidekiq.startupProbe.timeoutSeconds | int | `5` |  |
| siteName | string | `"My Site!"` |  |
| smtp.auth | string | `""` |  |
| smtp.enabled | bool | `false` |  |
| smtp.existingSecret | string | `""` |  |
| smtp.host | string | `""` |  |
| smtp.password | string | `""` |  |
| smtp.port | string | `""` |  |
| smtp.protocol | string | `""` |  |
| smtp.user | string | `""` |  |
| terminationGracePeriodSeconds | string | `""` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
| updateStrategy.rollingUpdate | object | `{}` |  |
| updateStrategy.type | string | `"RollingUpdate"` |  |
| volumePermissions.containerSecurityContext.runAsUser | int | `0` |  |
| volumePermissions.containerSecurityContext.seLinuxOptions | object | `{}` |  |
| volumePermissions.containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| volumePermissions.enabled | bool | `false` |  |
| volumePermissions.image.digest | string | `""` |  |
| volumePermissions.image.pullPolicy | string | `"IfNotPresent"` |  |
| volumePermissions.image.pullSecrets | list | `[]` |  |
| volumePermissions.image.registry | string | `"docker.io"` |  |
| volumePermissions.image.repository | string | `"bitnami/os-shell"` |  |
| volumePermissions.image.tag | string | `"12-debian-12-r43"` |  |
| volumePermissions.resources | object | `{}` |  |
| volumePermissions.resourcesPreset | string | `"nano"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
