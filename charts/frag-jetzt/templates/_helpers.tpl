{{/*
Expand the name of the chart.
*/}}
{{- define "frag-jetzt.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "frag-jetzt.fullname" -}}
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
Common labels
*/}}
{{- define "frag-jetzt.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{ include "frag-jetzt.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "frag-jetzt.selectorLabels" -}}
app.kubernetes.io/name: {{ include "frag-jetzt.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
RabbitMQ host
*/}}
{{- define "frag-jetzt.rabbitmq.fullname" -}}
{{ .Release.Name }}-rabbitmq
{{- end }}

{{/*
Backend service name
*/}}
{{- define "frag-jetzt.backend.fullname" -}}
{{ .Release.Name }}-backend
{{- end }}

{{/*
WebSocket gateway service name
*/}}
{{- define "frag-jetzt.ws-gateway.fullname" -}}
{{ .Release.Name }}-ws-gateway
{{- end }}

{{/*
Frontend service name
*/}}
{{- define "frag-jetzt.frontend.fullname" -}}
{{ .Release.Name }}-frontend
{{- end }}

{{/*
Secret name for app credentials
*/}}
{{- define "frag-jetzt.secretName" -}}
{{- if .Values.auth.existingSecret.name }}
{{- .Values.auth.existingSecret.name }}
{{- else }}
{{- .Release.Name }}-frag-jetzt-secret
{{- end }}
{{- end }}

{{/*
Keycloak base URL
*/}}
{{- define "frag-jetzt.keycloak.url" -}}
{{ .Values.keycloak.url }}
{{- end }}

{{/*
Server root URL
*/}}
{{- define "frag-jetzt.serverRootUrl" -}}
https://{{ .Values.appDomain }}
{{- end }}
