{{/*
Expand the name of the chart.
*/}}
{{- define "redis.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "redis.fullname" -}}
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
{{- define "redis.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "redis.labels" -}}
helm.sh/chart: {{ include "redis.chart" . }}
{{ include "redis.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "redis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "redis.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "redis.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "redis.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Redis master service name (for Bitnami compatibility)
*/}}
{{- define "redis.masterService" -}}
{{- printf "%s-master" (include "redis.fullname" .) }}
{{- end }}

{{/*
Redis headless service name (for Bitnami compatibility)
*/}}
{{- define "redis.headlessService" -}}
{{- printf "%s-headless" (include "redis.fullname" .) }}
{{- end }}

{{/*
Bitnami common template compatibility
*/}}
{{- define "common.names.fullname" -}}
{{- include "redis.fullname" . }}
{{- end }}

{{- define "common.names.name" -}}
{{- include "redis.name" . }}
{{- end }}

{{- define "common.labels.standard" -}}
{{- include "redis.labels" . }}
{{- end }}

{{- define "common.labels.matchLabels" -}}
{{- include "redis.selectorLabels" . }}
{{- end }}

{{/*
Bitnami Redis specific templates
*/}}
{{- define "redis.secretName" -}}
{{- if .Values.auth.existingSecret }}
{{- .Values.auth.existingSecret }}
{{- else }}
{{- printf "%s-redis" .Release.Name }}
{{- end }}
{{- end }}

{{- define "redis.secretPasswordKey" -}}
{{- if .Values.auth.existingSecret }}
{{- .Values.auth.existingSecretPasswordKey }}
{{- else }}
redis-password
{{- end }}
{{- end }}

{{/*
Redis service port (for Bitnami compatibility)
*/}}
{{- define "redis.servicePort" -}}
{{- .Values.service.port | default 6379 }}
{{- end }}

{{/*
Additional Bitnami compatibility templates
*/}}
{{- define "common.capabilities.deployment.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end }}

{{- define "common.capabilities.statefulset.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end }}

{{- define "common.capabilities.ingress.apiVersion" -}}
{{- if semverCompare ">=1.19" .Capabilities.KubeVersion.GitVersion -}}
{{- print "networking.k8s.io/v1" -}}
{{- else if semverCompare ">=1.14" .Capabilities.KubeVersion.GitVersion -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "extensions/v1beta1" -}}
{{- end -}}
{{- end }}

{{- define "common.names.namespace" -}}
{{- .Release.Namespace -}}
{{- end }}

{{- define "common.names.chart" -}}
{{- include "redis.chart" . }}
{{- end }}

{{/*
Redis auth templates for Bitnami compatibility
*/}}
{{- define "redis.auth.enabled" -}}
{{- if .Values.auth.enabled }}
{{- true -}}
{{- else -}}
{{- false -}}
{{- end -}}
{{- end }}

{{- define "redis.auth.password" -}}
{{- if .Values.auth.enabled }}
{{- .Values.auth.password | default (randAlphaNum 10) -}}
{{- end -}}
{{- end }}

{{/*
Validate values
*/}}
{{- define "redis.validateValues" -}}
{{- if and .Values.auth.enabled (not .Values.auth.password) }}
redis: {{ printf "A password is required when auth is enabled. Please set auth.password" }}
{{- end }}
{{- end }}

{{/*
Redis command
*/}}
{{- define "redis.command" -}}
{{- if .Values.auth.enabled }}
["redis-server", "/usr/local/etc/redis/redis.conf", "--requirepass", "$(REDIS_PASSWORD)"]
{{- else }}
["redis-server", "/usr/local/etc/redis/redis.conf"]
{{- end }}
{{- end }}