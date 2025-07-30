{{/*
Expand the name of the chart.
*/}}
{{- define "postgresql.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "postgresql.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "postgresql.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "postgresql.labels" -}}
helm.sh/chart: {{ include "postgresql.chart" . }}
{{ include "postgresql.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "postgresql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "postgresql.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "postgresql.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "postgresql.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper PostgreSQL image name
*/}}
{{- define "postgresql.image" -}}
{{- if .Values.image.registry -}}
{{- include "postgresql.imageRegistry" . }}/{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion -}}
{{- else -}}
{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion -}}
{{- end -}}
{{- end }}

{{/*
Return the proper image registry
*/}}
{{- define "postgresql.imageRegistry" -}}
{{- if .Values.global.imageRegistry }}
{{- .Values.global.imageRegistry }}
{{- else }}
{{- .Values.image.registry }}
{{- end }}
{{- end }}

{{/*
Get the password secret name
*/}}
{{- define "postgresql.secretName" -}}
{{- if .Values.auth.existingSecret }}
{{- .Values.auth.existingSecret }}
{{- else }}
{{- include "postgresql.fullname" . }}
{{- end }}
{{- end }}

{{/*
Get the password key from secret
*/}}
{{- define "postgresql.adminPasswordKey" -}}
{{- if .Values.auth.existingSecret -}}
{{- .Values.auth.secretKeys.adminPasswordKey -}}
{{- else -}}
postgres-password
{{- end -}}
{{- end }}

{{/*
Get the user password key from secret
*/}}
{{- define "postgresql.userPasswordKey" -}}
{{- if .Values.auth.existingSecret -}}
{{- .Values.auth.secretKeys.userPasswordKey -}}
{{- else -}}
password
{{- end -}}
{{- end }}

{{/*
==============================================================================
Bitnami Compatibility Templates for Parent Charts
==============================================================================
*/}}

{{/*
Return the full name of the chart (compatible with common.names.fullname)
*/}}
{{- define "postgresql.v1.chart.fullname" -}}
{{- if .Values.global.postgresql.fullnameOverride -}}
{{- .Values.global.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- include "postgresql.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL primary full name
*/}}
{{- define "postgresql.v1.primary.fullname" -}}
{{- $fullname := include "postgresql.v1.chart.fullname" . -}}
{{- if and (hasKey .Values "architecture") (eq .Values.architecture "replication") -}}
{{- printf "%s-%s" $fullname (.Values.primary.name | default "primary") | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $fullname -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL read replica full name
*/}}
{{- define "postgresql.v1.readReplica.fullname" -}}
{{- $fullname := include "postgresql.v1.chart.fullname" . -}}
{{- printf "%s-%s" $fullname (.Values.readReplicas.name | default "read") | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the PostgreSQL secret name
*/}}
{{- define "postgresql.v1.secretName" -}}
{{- if .Values.global.postgresql.auth.existingSecret -}}
{{- tpl .Values.global.postgresql.auth.existingSecret $ -}}
{{- else if .Values.auth.existingSecret -}}
{{- tpl .Values.auth.existingSecret $ -}}
{{- else -}}
{{- include "postgresql.v1.chart.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL username
*/}}
{{- define "postgresql.v1.username" -}}
{{- if .Values.global.postgresql.auth.username -}}
{{- .Values.global.postgresql.auth.username -}}
{{- else -}}
{{- .Values.auth.username | default "postgres" -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL database name
*/}}
{{- define "postgresql.v1.database" -}}
{{- if .Values.global.postgresql.auth.database -}}
{{- tpl .Values.global.postgresql.auth.database $ -}}
{{- else if .Values.auth.database -}}
{{- tpl .Values.auth.database $ -}}
{{- else -}}
postgres
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL primary service port
*/}}
{{- define "postgresql.v1.service.port" -}}
{{- if .Values.global.postgresql.service.ports.postgresql -}}
{{- .Values.global.postgresql.service.ports.postgresql -}}
{{- else -}}
{{- .Values.service.ports.postgresql | default 5432 -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL primary headless service name
*/}}
{{- define "postgresql.v1.primary.svc.headless" -}}
{{- printf "%s-hl" (include "postgresql.v1.primary.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the PostgreSQL read replica service port
*/}}
{{- define "postgresql.v1.readReplica.service.port" -}}
{{- if .Values.global.postgresql.service.ports.postgresql -}}
{{- .Values.global.postgresql.service.ports.postgresql -}}
{{- else -}}
{{- .Values.readReplicas.service.ports.postgresql | default 5432 -}}
{{- end -}}
{{- end -}}

{{/*
Return the PostgreSQL read replica headless service name
*/}}
{{- define "postgresql.v1.readReplica.svc.headless" -}}
{{- printf "%s-hl" (include "postgresql.v1.readReplica.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the PostgreSQL admin password key (v1 compatibility)
*/}}
{{- define "postgresql.v1.adminPasswordKey" -}}
{{- include "postgresql.adminPasswordKey" . -}}
{{- end -}}

{{/*
Return the PostgreSQL user password key (v1 compatibility)
*/}}
{{- define "postgresql.v1.userPasswordKey" -}}
{{- include "postgresql.userPasswordKey" . -}}
{{- end -}}