{{/*
Expand the name of the chart.
*/}}
{{- define "quokka-service-registry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "quokka-service-registry.fullname" -}}
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
{{- define "quokka-service-registry.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "quokka-service-registry.labels" -}}
helm.sh/chart: {{ include "quokka-service-registry.chart" . }}
{{ include "quokka-service-registry.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "quokka-service-registry.selectorLabels" -}}
app.kubernetes.io/name: {{ include "quokka-service-registry.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "quokka-service-registry.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "quokka-service-registry.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified postgresql name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "quokka-service-registry.postgresql.fullname" -}}
{{- include "postgresql.v1.primary.fullname" .Subcharts.postgresql }}
{{- end }}

{{/*
Get the PostgreSQL credentials secret.
*/}}
{{- define "quokka-service-registry.postgresql.secretName" -}}
{{- if .Values.postgresql.auth.existingSecret }}
{{- printf "%s" .Values.postgresql.auth.existingSecret }}
{{- else }}
{{- printf "%s" (include "postgresql.v1.secretName" .Subcharts.postgresql) }}
{{- end }}
{{- end }}

{{/*
Get the PostgreSQL password key.
*/}}
{{- define "quokka-service-registry.postgresql.userPasswordKey" -}}
{{- if .Values.postgresql.auth.existingSecret }}
{{- printf "%s" .Values.postgresql.auth.secretKeys.userPasswordKey }}
{{- else }}
{{- printf "password" }}
{{- end }}
{{- end }}