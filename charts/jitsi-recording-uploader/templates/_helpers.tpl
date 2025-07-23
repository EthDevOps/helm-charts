{{/*
Expand the name of the chart.
*/}}
{{- define "jitsi-recording-uploader.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jitsi-recording-uploader.fullname" -}}
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
{{- define "jitsi-recording-uploader.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "jitsi-recording-uploader.labels" -}}
helm.sh/chart: {{ include "jitsi-recording-uploader.chart" . }}
{{ include "jitsi-recording-uploader.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "jitsi-recording-uploader.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jitsi-recording-uploader.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "jitsi-recording-uploader.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "jitsi-recording-uploader.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret containing Google Drive credentials
*/}}
{{- define "jitsi-recording-uploader.secretName" -}}
{{- if eq .Values.credentials.method "externalSecret" }}
{{- .Values.credentials.externalSecret.secretName }}
{{- else }}
{{- printf "%s-credentials" (include "jitsi-recording-uploader.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Create the name of the config map
*/}}
{{- define "jitsi-recording-uploader.configMapName" -}}
{{- printf "%s-config" (include "jitsi-recording-uploader.fullname" .) }}
{{- end }}

{{/*
Validate required values
*/}}
{{- define "jitsi-recording-uploader.validateValues" -}}
{{- if and (eq .Values.credentials.method "secret") (or (not .Values.credentials.googleDrive.clientId) (not .Values.credentials.googleDrive.clientSecret) (not .Values.credentials.googleDrive.refreshToken)) }}
{{- fail "When credentials.method is 'secret', you must provide credentials.googleDrive.clientId, credentials.googleDrive.clientSecret, and credentials.googleDrive.refreshToken" }}
{{- end }}
{{- if and (eq .Values.credentials.method "externalSecret") (not .Values.credentials.externalSecret.name) }}
{{- fail "When credentials.method is 'externalSecret', you must provide credentials.externalSecret.name" }}
{{- end }}
{{- if not .Values.config.jibri.pvcName }}
{{- fail "config.jibri.pvcName is required" }}
{{- end }}
{{- end }}