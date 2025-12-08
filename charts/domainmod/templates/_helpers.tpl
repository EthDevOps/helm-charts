{{/*
Expand the name of the chart.
*/}}
{{- define "domainmod.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "domainmod.fullname" -}}
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
{{- define "domainmod.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "domainmod.labels" -}}
helm.sh/chart: {{ include "domainmod.chart" . }}
{{ include "domainmod.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "domainmod.selectorLabels" -}}
app.kubernetes.io/name: {{ include "domainmod.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Database labels
*/}}
{{- define "domainmod.db.labels" -}}
helm.sh/chart: {{ include "domainmod.chart" . }}
{{ include "domainmod.db.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Database selector labels
*/}}
{{- define "domainmod.db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "domainmod.name" . }}-db
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: database
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "domainmod.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "domainmod.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Database fullname
*/}}
{{- define "domainmod.db.fullname" -}}
{{- printf "%s-db" (include "domainmod.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Database host
*/}}
{{- define "domainmod.db.host" -}}
{{- if .Values.dbCredentials.host }}
{{- .Values.dbCredentials.host }}
{{- else }}
{{- include "domainmod.db.fullname" . }}
{{- end }}
{{- end }}

{{/*
Secret name for database credentials
*/}}
{{- define "domainmod.secretName" -}}
{{- if .Values.dbCredentials.existingSecret.name }}
{{- .Values.dbCredentials.existingSecret.name }}
{{- else }}
{{- include "domainmod.fullname" . }}
{{- end }}
{{- end }}

{{/*
Password key in secret
*/}}
{{- define "domainmod.secretPasswordKey" -}}
{{- if .Values.dbCredentials.existingSecret.name }}
{{- .Values.dbCredentials.existingSecret.passwordKey }}
{{- else }}
{{- "password" }}
{{- end }}
{{- end }}

{{/*
Root password key in secret
*/}}
{{- define "domainmod.secretRootPasswordKey" -}}
{{- if .Values.dbCredentials.existingSecret.name }}
{{- .Values.dbCredentials.existingSecret.rootPasswordKey }}
{{- else }}
{{- "root-password" }}
{{- end }}
{{- end }}
