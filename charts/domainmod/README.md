# domainmod

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

A Helm chart for DomainMod - Open Source Domain and Internet Asset Management

**Homepage:** <https://domainmod.org>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| quokkaops |  |  |

## Source Code

* <https://github.com/domainmod/domainmod>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app | object | `{"affinity":{},"env":{"DOMAINMOD_WEB_ROOT":"","PGID":"1000","PUID":"1000","TZ":"Europe/Berlin"},"image":{"pullPolicy":"IfNotPresent","repository":"domainmod/domainmod","tag":"latest"},"nodeSelector":{},"persistence":{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"existingClaim":"","size":"1Gi","storageClass":""},"podAnnotations":{},"podSecurityContext":{},"replicaCount":1,"resources":{},"securityContext":{},"service":{"annotations":{},"labels":{},"port":80,"targetPort":80,"type":"ClusterIP"},"tolerations":[]}` | App configuration |
| app.affinity | object | `{}` | Affinity |
| app.env | object | `{"DOMAINMOD_WEB_ROOT":"","PGID":"1000","PUID":"1000","TZ":"Europe/Berlin"}` | Environment variables |
| app.nodeSelector | object | `{}` | Node selector |
| app.persistence | object | `{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"existingClaim":"","size":"1Gi","storageClass":""}` | Persistence configuration for application data |
| app.persistence.accessModes | list | `["ReadWriteOnce"]` | Access modes |
| app.persistence.annotations | object | `{}` | Annotations for the PVC |
| app.persistence.existingClaim | string | `""` | Use an existing PVC |
| app.persistence.size | string | `"1Gi"` | Size of the PVC |
| app.persistence.storageClass | string | `""` | Storage class for the PVC |
| app.podAnnotations | object | `{}` | Pod annotations |
| app.podSecurityContext | object | `{}` | Pod security context |
| app.replicaCount | int | `1` | Number of replicas (only 1 supported for stateful app) |
| app.resources | object | `{}` | Resource limits and requests |
| app.securityContext | object | `{}` | Container security context |
| app.service | object | `{"annotations":{},"labels":{},"port":80,"targetPort":80,"type":"ClusterIP"}` | Service configuration |
| app.service.annotations | object | `{}` | Additional annotations for the service |
| app.service.labels | object | `{}` | Additional labels for the service |
| app.tolerations | list | `[]` | Tolerations |
| database | object | `{"affinity":{},"enabled":true,"env":{"PGID":"1000","PUID":"1000","TZ":"America/Vancouver"},"image":{"pullPolicy":"IfNotPresent","repository":"ghcr.io/linuxserver/mariadb","tag":"alpine"},"nodeSelector":{},"persistence":{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"existingClaim":"","size":"5Gi","storageClass":""},"podAnnotations":{},"podSecurityContext":{},"resources":{},"securityContext":{},"service":{"port":3306,"type":"ClusterIP"},"tolerations":[]}` | Database configuration |
| database.affinity | object | `{}` | Affinity |
| database.enabled | bool | `true` | Enable the built-in MariaDB database |
| database.env | object | `{"PGID":"1000","PUID":"1000","TZ":"America/Vancouver"}` | Environment variables |
| database.nodeSelector | object | `{}` | Node selector |
| database.persistence | object | `{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":true,"existingClaim":"","size":"5Gi","storageClass":""}` | Persistence configuration for database |
| database.persistence.accessModes | list | `["ReadWriteOnce"]` | Access modes |
| database.persistence.annotations | object | `{}` | Annotations for the PVC |
| database.persistence.existingClaim | string | `""` | Use an existing PVC |
| database.persistence.size | string | `"5Gi"` | Size of the PVC |
| database.persistence.storageClass | string | `""` | Storage class for the PVC |
| database.podAnnotations | object | `{}` | Pod annotations |
| database.podSecurityContext | object | `{}` | Pod security context |
| database.resources | object | `{}` | Resource limits and requests |
| database.securityContext | object | `{}` | Container security context |
| database.service | object | `{"port":3306,"type":"ClusterIP"}` | Service configuration |
| database.tolerations | list | `[]` | Tolerations |
| dbCredentials | object | `{"database":"domainmod","existingSecret":{"name":"","passwordKey":"password","rootPasswordKey":"root-password"},"host":"","password":"","rootPassword":"","user":"domainmod"}` | Database credentials Used by both app and database |
| dbCredentials.database | string | `"domainmod"` | Database name |
| dbCredentials.existingSecret | object | `{"name":"","passwordKey":"password","rootPasswordKey":"root-password"}` | Use an existing secret for database credentials |
| dbCredentials.existingSecret.name | string | `""` | Name of the existing secret |
| dbCredentials.existingSecret.passwordKey | string | `"password"` | Key in the secret for database password |
| dbCredentials.existingSecret.rootPasswordKey | string | `"root-password"` | Key in the secret for root password |
| dbCredentials.host | string | `""` | Database host (use release-name-db if using built-in db) |
| dbCredentials.password | string | `""` | Database password (ignored if existingSecret is set) |
| dbCredentials.rootPassword | string | `""` | MySQL root password (ignored if existingSecret is set) |
| dbCredentials.user | string | `"domainmod"` | Database user |
| fullnameOverride | string | `""` | Override the full name of the chart |
| imagePullSecrets | list | `[]` | Image pull secrets |
| ingress | object | `{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"domainmod.local","paths":[{"path":"/","pathType":"Prefix"}]}],"tls":[]}` | Ingress configuration |
| nameOverride | string | `""` | Override the name of the chart |
| serviceAccount | object | `{"annotations":{},"create":false,"name":""}` | Service account configuration |
| serviceAccount.annotations | object | `{}` | Annotations for the service account |
| serviceAccount.create | bool | `false` | Create a service account |
| serviceAccount.name | string | `""` | Name of the service account |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
