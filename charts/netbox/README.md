# netbox

![Version: 5.1.12](https://img.shields.io/badge/Version-5.1.12-informational?style=flat-square) ![AppVersion: v3.6.4](https://img.shields.io/badge/AppVersion-v3.6.4-informational?style=flat-square)

IP address management (IPAM) and data center infrastructure management (DCIM) tool

**Homepage:** <https://github.com/bootc/netbox-chart>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Chris Boot | bootc@boo.tc | https://github.com/bootc |

## Requirements

Kubernetes: `>=1.25.0`

| Repository | Name | Version |
|------------|------|---------|
| https://ethdevops.github.io/helm-charts | postgresql | 1.1.3 |
| https://ethdevops.github.io/helm-charts | redis | 1.0.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| admins | list | `[]` |  |
| affinity | object | `{}` |  |
| allowTokenRetrieval | bool | `false` |  |
| allowedHostsIncludesPodIP | bool | `true` |  |
| allowedHosts[0] | string | `"*"` |  |
| allowedUrlSchemes[0] | string | `"file"` |  |
| allowedUrlSchemes[10] | string | `"telnet"` |  |
| allowedUrlSchemes[11] | string | `"tftp"` |  |
| allowedUrlSchemes[12] | string | `"vnc"` |  |
| allowedUrlSchemes[13] | string | `"xmpp"` |  |
| allowedUrlSchemes[1] | string | `"ftp"` |  |
| allowedUrlSchemes[2] | string | `"ftps"` |  |
| allowedUrlSchemes[3] | string | `"http"` |  |
| allowedUrlSchemes[4] | string | `"https"` |  |
| allowedUrlSchemes[5] | string | `"irc"` |  |
| allowedUrlSchemes[6] | string | `"mailto"` |  |
| allowedUrlSchemes[7] | string | `"sftp"` |  |
| allowedUrlSchemes[8] | string | `"ssh"` |  |
| allowedUrlSchemes[9] | string | `"tel"` |  |
| authPasswordValidators | list | `[]` |  |
| automountServiceAccountToken | bool | `false` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| banner.bottom | string | `""` |  |
| banner.login | string | `""` |  |
| banner.top | string | `""` |  |
| basePath | string | `""` |  |
| cachingRedis.caCertPath | string | `""` |  |
| cachingRedis.database | int | `1` |  |
| cachingRedis.existingSecretKey | string | `"redis-password"` |  |
| cachingRedis.existingSecretName | string | `""` |  |
| cachingRedis.host | string | `"netbox-redis"` |  |
| cachingRedis.insecureSkipTlsVerify | bool | `false` |  |
| cachingRedis.password | string | `""` |  |
| cachingRedis.port | int | `6379` |  |
| cachingRedis.sentinelService | string | `"netbox-redis"` |  |
| cachingRedis.sentinelTimeout | int | `300` |  |
| cachingRedis.sentinels | list | `[]` |  |
| cachingRedis.ssl | bool | `false` |  |
| cachingRedis.username | string | `""` |  |
| changelogRetention | int | `90` |  |
| commonAnnotations | object | `{}` |  |
| commonLabels | object | `{}` |  |
| cors.originAllowAll | bool | `false` |  |
| cors.originRegexWhitelist | list | `[]` |  |
| cors.originWhitelist | list | `[]` |  |
| csrf.cookieName | string | `"csrftoken"` |  |
| csrf.trustedOrigins | list | `[]` |  |
| customValidators | object | `{}` |  |
| dateFormat | string | `"N j, Y"` |  |
| dateTimeFormat | string | `"N j, Y g:i a"` |  |
| dbWaitDebug | bool | `false` |  |
| debug | bool | `false` |  |
| defaultLanguage | string | `"en-us"` |  |
| defaultUserPreferences | object | `{}` |  |
| email.from | string | `""` |  |
| email.password | string | `""` |  |
| email.port | int | `25` |  |
| email.server | string | `"localhost"` |  |
| email.sslCertFile | string | `""` |  |
| email.sslKeyFile | string | `""` |  |
| email.timeout | int | `10` |  |
| email.useSSL | bool | `false` |  |
| email.useTLS | bool | `false` |  |
| email.username | string | `""` |  |
| enableLocalization | bool | `false` |  |
| enforceGlobalUnique | bool | `false` |  |
| exemptViewPermissions | list | `[]` |  |
| existingSecret | string | `""` |  |
| externalDatabase.connMaxAge | int | `300` |  |
| externalDatabase.database | string | `"netbox"` |  |
| externalDatabase.disableServerSideCursors | bool | `false` |  |
| externalDatabase.existingSecretKey | string | `"postgresql-password"` |  |
| externalDatabase.existingSecretName | string | `""` |  |
| externalDatabase.host | string | `"localhost"` |  |
| externalDatabase.password | string | `""` |  |
| externalDatabase.port | int | `5432` |  |
| externalDatabase.sslMode | string | `"prefer"` |  |
| externalDatabase.targetSessionAttrs | string | `"read-write"` |  |
| externalDatabase.username | string | `"netbox"` |  |
| extraConfig | list | `[]` |  |
| extraContainers | list | `[]` |  |
| extraEnvs | list | `[]` |  |
| extraInitContainers | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fieldChoices | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| graphQlEnabled | bool | `true` |  |
| hostAliases | list | `[]` |  |
| housekeeping.affinity | object | `{}` |  |
| housekeeping.automountServiceAccountToken | bool | `false` |  |
| housekeeping.concurrencyPolicy | string | `"Forbid"` |  |
| housekeeping.enabled | bool | `true` |  |
| housekeeping.extraContainers | list | `[]` |  |
| housekeeping.extraEnvs | list | `[]` |  |
| housekeeping.extraInitContainers | list | `[]` |  |
| housekeeping.extraVolumeMounts | list | `[]` |  |
| housekeeping.extraVolumes | list | `[]` |  |
| housekeeping.failedJobsHistoryLimit | int | `5` |  |
| housekeeping.nodeSelector | object | `{}` |  |
| housekeeping.podAnnotations | object | `{}` |  |
| housekeeping.podLabels | object | `{}` |  |
| housekeeping.podSecurityContext.fsGroup | int | `1000` |  |
| housekeeping.podSecurityContext.runAsNonRoot | bool | `true` |  |
| housekeeping.resources | object | `{}` |  |
| housekeeping.restartPolicy | string | `"OnFailure"` |  |
| housekeeping.schedule | string | `"0 0 * * *"` |  |
| housekeeping.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| housekeeping.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| housekeeping.securityContext.runAsGroup | int | `1000` |  |
| housekeeping.securityContext.runAsNonRoot | bool | `true` |  |
| housekeeping.securityContext.runAsUser | int | `1000` |  |
| housekeeping.successfulJobsHistoryLimit | int | `5` |  |
| housekeeping.suspend | bool | `false` |  |
| housekeeping.tolerations | list | `[]` |  |
| httpProxies | list | `[]` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"docker.ethquokkaops.io/ethquokkaops/ethdevops/netbox-docker"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0] | string | `"/"` |  |
| ingress.tls | list | `[]` |  |
| init.image.pullPolicy | string | `"IfNotPresent"` |  |
| init.image.repository | string | `"docker.ethquokkaops.io/dh/busybox"` |  |
| init.image.tag | string | `"1.36.1"` |  |
| init.resources | object | `{}` |  |
| init.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| init.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| init.securityContext.runAsGroup | int | `1000` |  |
| init.securityContext.runAsNonRoot | bool | `true` |  |
| init.securityContext.runAsUser | int | `1000` |  |
| internalIPs[0] | string | `"127.0.0.1"` |  |
| internalIPs[1] | string | `"::1"` |  |
| jobRetention | int | `90` |  |
| logging | object | `{}` |  |
| loginPersistence | bool | `false` |  |
| loginRequired | bool | `false` |  |
| loginTimeout | int | `1209600` |  |
| logoutRedirectUrl | string | `"home"` |  |
| maintenanceMode | bool | `false` |  |
| mapsUrl | string | `"https://maps.google.com/?q="` |  |
| maxPageSize | int | `1000` |  |
| metricsEnabled | bool | `false` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| overrideUnitConfig | object | `{}` |  |
| paginateCount | int | `50` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.size | string | `"1Gi"` |  |
| persistence.storageClass | string | `""` |  |
| persistence.subPath | string | `""` |  |
| plugins | list | `[]` |  |
| pluginsConfig | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| postgresql.auth.database | string | `"netbox"` |  |
| postgresql.auth.username | string | `"netbox"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.tag | string | `"13-alpine"` |  |
| powerFeedDefaultAmperage | int | `15` |  |
| powerFeedDefaultVoltage | int | `120` |  |
| powerFeedMaxUtilisation | int | `80` |  |
| preferIPv4 | bool | `false` |  |
| rackElevationDefaultUnitHeight | int | `22` |  |
| rackElevationDefaultUnitWidth | int | `220` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.initialDelaySeconds | int | `0` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `1` |  |
| redis.enabled | bool | `true` |  |
| releaseCheck.url | string | `nil` |  |
| remoteAuth.autoCreateGroups | bool | `false` |  |
| remoteAuth.autoCreateUser | bool | `false` |  |
| remoteAuth.backends[0] | string | `"netbox.authentication.RemoteUserBackend"` |  |
| remoteAuth.defaultGroups | list | `[]` |  |
| remoteAuth.defaultPermissions | object | `{}` |  |
| remoteAuth.enabled | bool | `false` |  |
| remoteAuth.groupHeader | string | `"HTTP_REMOTE_USER_GROUP"` |  |
| remoteAuth.groupSeparator | string | `"|"` |  |
| remoteAuth.groupSyncEnabled | bool | `false` |  |
| remoteAuth.header | string | `"HTTP_REMOTE_USER"` |  |
| remoteAuth.staffGroups | list | `[]` |  |
| remoteAuth.staffUsers | list | `[]` |  |
| remoteAuth.superuserGroups | list | `[]` |  |
| remoteAuth.superusers | list | `[]` |  |
| remoteAuth.userEmail | string | `"HTTP_REMOTE_USER_EMAIL"` |  |
| remoteAuth.userFirstName | string | `"HTTP_REMOTE_USER_FIRST_NAME"` |  |
| remoteAuth.userLastName | string | `"HTTP_REMOTE_USER_LAST_NAME"` |  |
| replicaCount | int | `1` |  |
| reportsPersistence.accessMode | string | `"ReadWriteOnce"` |  |
| reportsPersistence.enabled | bool | `false` |  |
| reportsPersistence.existingClaim | string | `""` |  |
| reportsPersistence.size | string | `"1Gi"` |  |
| reportsPersistence.storageClass | string | `""` |  |
| reportsPersistence.subPath | string | `""` |  |
| resources | object | `{}` |  |
| rqDefaultTimeout | int | `300` |  |
| secretKey | string | `""` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsGroup | int | `1000` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.annotations | object | `{}` |  |
| service.clusterIP | string | `""` |  |
| service.clusterIPs | list | `[]` |  |
| service.externalIPs | list | `[]` |  |
| service.externalTrafficPolicy | string | `""` |  |
| service.ipFamilyPolicy | string | `""` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePort | string | `""` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `false` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.imagePullSecrets | list | `[]` |  |
| serviceAccount.name | string | `""` |  |
| serviceMonitor.additionalLabels | object | `{}` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.interval | string | `"1m"` |  |
| serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| sessionCookieName | string | `"sessionid"` |  |
| shortDateFormat | string | `"Y-m-d"` |  |
| shortDateTimeFormat | string | `"Y-m-d H:i"` |  |
| shortTimeFormat | string | `"H:i:s"` |  |
| skipStartupScripts | bool | `true` |  |
| storageBackend | string | `nil` |  |
| storageConfig | object | `{}` |  |
| superuser.apiToken | string | `"0123456789abcdef0123456789abcdef01234567"` |  |
| superuser.email | string | `"admin@example.com"` |  |
| superuser.name | string | `"admin"` |  |
| superuser.password | string | `"admin"` |  |
| tasksRedis.caCertPath | string | `""` |  |
| tasksRedis.database | int | `0` |  |
| tasksRedis.existingSecretKey | string | `"redis-password"` |  |
| tasksRedis.existingSecretName | string | `""` |  |
| tasksRedis.host | string | `"netbox-redis"` |  |
| tasksRedis.insecureSkipTlsVerify | bool | `false` |  |
| tasksRedis.password | string | `""` |  |
| tasksRedis.port | int | `6379` |  |
| tasksRedis.sentinelService | string | `"netbox-redis"` |  |
| tasksRedis.sentinelTimeout | int | `300` |  |
| tasksRedis.sentinels | list | `[]` |  |
| tasksRedis.ssl | bool | `false` |  |
| tasksRedis.username | string | `""` |  |
| test.image.pullPolicy | string | `"IfNotPresent"` |  |
| test.image.repository | string | `"docker.ethquokkaops.io/dh/busybox"` |  |
| test.image.tag | string | `"1.36.1"` |  |
| test.resources | object | `{}` |  |
| timeFormat | string | `"g:i a"` |  |
| timeZone | string | `"UTC"` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
| updateStrategy | object | `{}` |  |
| worker.affinity | object | `{}` |  |
| worker.automountServiceAccountToken | bool | `false` |  |
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.maxReplicas | int | `100` |  |
| worker.autoscaling.minReplicas | int | `1` |  |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| worker.enabled | bool | `true` |  |
| worker.extraContainers | list | `[]` |  |
| worker.extraEnvs | list | `[]` |  |
| worker.extraInitContainers | list | `[]` |  |
| worker.extraVolumeMounts | list | `[]` |  |
| worker.extraVolumes | list | `[]` |  |
| worker.hostAliases | list | `[]` |  |
| worker.nodeSelector | object | `{}` |  |
| worker.podAnnotations | object | `{}` |  |
| worker.podLabels | object | `{}` |  |
| worker.podSecurityContext.fsGroup | int | `1000` |  |
| worker.podSecurityContext.runAsNonRoot | bool | `true` |  |
| worker.replicaCount | int | `1` |  |
| worker.resources | object | `{}` |  |
| worker.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| worker.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| worker.securityContext.runAsGroup | int | `1000` |  |
| worker.securityContext.runAsNonRoot | bool | `true` |  |
| worker.securityContext.runAsUser | int | `1000` |  |
| worker.tolerations | list | `[]` |  |
| worker.updateStrategy | object | `{}` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
