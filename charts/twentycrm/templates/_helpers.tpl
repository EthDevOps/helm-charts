{{/*
Expand the name of the chart.
*/}}
{{- define "twentycrm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "twentycrm.fullname" -}}
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
{{- define "twentycrm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "twentycrm.labels" -}}
helm.sh/chart: {{ include "twentycrm.chart" . }}
{{ include "twentycrm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "twentycrm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "twentycrm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
PostgreSQL host
*/}}
{{- define "twentycrm.postgres.host" -}}
{{- if .Values.postgres.enabled -}}
{{ .Release.Name }}-postgres
{{- else -}}
{{ .Values.postgres.hostname }}
{{- end -}}
{{- end }}

{{/*
Redis URL
*/}}
{{- define "twentycrm.redis.url" -}}
{{- if .Values.redis.enabled -}}
redis://{{ .Release.Name }}-redis:{{ .Values.redis.port }}
{{- else -}}
{{ .Values.redis.url }}
{{- end -}}
{{- end }}

{{/*
Server URL
*/}}
{{- define "twentycrm.server.url" -}}
{{- .Values.server.serverUrl }}
{{- end }}

{{/*
PostgreSQL connection string
*/}}
{{- define "twentycrm.postgres.connectionString" -}}
postgres://{{ .Values.postgres.user }}:$(POSTGRES_PASSWORD)@{{ include "twentycrm.postgres.host" . }}:5432/{{ .Values.postgres.database }}
{{- end }}
