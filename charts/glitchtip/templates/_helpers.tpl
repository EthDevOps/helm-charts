{{/* vim: set filetype=mustache: */}}

{{/*
Validate that removed values are not being used.
Fails with a helpful migration message if old values are detected.
*/}}
{{- define "glitchtip.validateValues" -}}
{{- $removed := list -}}

{{- if .Values.env -}}
  {{- if .Values.env.secret -}}
    {{- $removed = append $removed "env.secret is removed. Use glitchtip.secretKey or glitchtip.existingSecret for SECRET_KEY. Use extraEnvVars for other secrets." -}}
  {{- end -}}
  {{- if .Values.env.normal -}}
    {{- $removed = append $removed "env.normal is removed. Use glitchtip.domain for GLITCHTIP_DOMAIN. Use extraEnvVars on web/worker/migrationJob for other values." -}}
  {{- end -}}
{{- end -}}

{{- if .Values.existingSecret -}}
  {{- $removed = append $removed "existingSecret is removed. Use glitchtip.existingSecret for SECRET_KEY, or extraEnvVars for other values." -}}
{{- end -}}

{{- with .Values.web -}}
  {{- if .database -}}
    {{- if .database.existingSecret -}}
      {{- $removed = append $removed "web.database.existingSecret is removed. Use glitchtip.database.existingSecret." -}}
    {{- end -}}
  {{- end -}}
{{- end -}}



{{- if $removed -}}
  {{- fail (printf "\n\nREMOVED VALUES DETECTED (v8.0.0 breaking changes):\n\n  - %s\n\nSee CHANGELOG for migration guide.\n" (join "\n  - " $removed)) -}}
{{- end -}}

{{/* Validate required database configuration */}}
{{- if and (not .Values.postgresql.enabled) (not .Values.glitchtip.database.existingSecret) -}}
  {{- fail "glitchtip.database.existingSecret is required when postgresql.enabled=false. Provide a secret containing DATABASE_URL." -}}
{{- end -}}

{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "glitchtip.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "glitchtip.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "glitchtip.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "glitchtip.labels" -}}
helm.sh/chart: {{ include "glitchtip.chart" . }}
{{ include "glitchtip.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "glitchtip.selectorLabels" -}}
app.kubernetes.io/name: {{ include "glitchtip.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "glitchtip.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "glitchtip.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "glitchtip.valkey.fullname" -}}
{{- if .Values.valkey.fullnameOverride -}}
{{- .Values.valkey.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "valkey" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Set redis url (only used when valkey.enabled=true)
*/}}
{{- define "glitchtip.valkey.url" -}}
redis://
{{- if .Values.valkey.auth.password -}}
:{{ .Values.valkey.auth.password }}@
{{- end -}}
{{- template "glitchtip.valkey.fullname" . -}}:{{- template "glitchtip.valkey.port" . -}}/0
{{- end -}}

{{/*
Set redis port (only used when valkey.enabled=true)
*/}}
{{- define "glitchtip.valkey.port" -}}
6379
{{- end -}}

{{/*
Glitchtip shared environment variables (SECRET_KEY, GLITCHTIP_DOMAIN)
*/}}
{{- define "glitchtip.shared.env" -}}
- name: SECRET_KEY
  {{- if .Values.glitchtip.secretKey }}
  value: {{ .Values.glitchtip.secretKey | quote }}
  {{- else }}
  valueFrom:
    secretKeyRef:
      name: {{ required "one of glitchtip.existingSecret or glitchtip.secretKey is required" .Values.glitchtip.existingSecret }}
      key: {{ .Values.glitchtip.existingSecretKey }}
  {{- end }}
- name: GLITCHTIP_DOMAIN
  value: {{ .Values.glitchtip.domain | quote }}
{{- end -}}

{{/*
Database environment variables
Usage: {{ include "glitchtip.database.env" (dict "root" $ "component" .Values.path.to.component) }}
*/}}
{{- define "glitchtip.database.env" -}}
{{- $root := .root -}}
{{- $component := .component | default dict -}}
{{- $dbConf := $component.database | default dict -}}
{{- $readOnlyConf := $component.readOnlyDatabase | default dict -}}

{{- /* Resolve DATABASE_URL */ -}}
{{- $dbSecret := "" -}}
{{- $dbKey := "" -}}

{{- if $root.Values.postgresql.enabled -}}
  {{- $dbSecret = printf "%s-pg-app" (include "glitchtip.fullname" $root) -}}
  {{- $dbKey = "uri" -}}
{{- else if $dbConf.existingSecret -}}
  {{- $dbSecret = $dbConf.existingSecret -}}
  {{- $dbKey = $dbConf.existingSecretKey | default "DATABASE_URL" -}}
{{- else -}}
  {{- $dbSecret = $root.Values.glitchtip.database.existingSecret -}}
  {{- $dbKey = $root.Values.glitchtip.database.existingSecretKey | default "DATABASE_URL" -}}
{{- end -}}

- name: DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: {{ $dbSecret }}
      key: {{ $dbKey }}

{{- /* Resolve READ_ONLY_DATABASE_URL */ -}}
{{- $roSecret := "" -}}
{{- $roKey := "" -}}

{{- if $readOnlyConf.existingSecret -}}
  {{- $roSecret = $readOnlyConf.existingSecret -}}
  {{- $roKey = $readOnlyConf.existingSecretKey | default "READ_ONLY_DATABASE_URL" -}}
{{- else if $root.Values.glitchtip.readOnlyDatabase.existingSecret -}}
  {{- $roSecret = $root.Values.glitchtip.readOnlyDatabase.existingSecret -}}
  {{- $roKey = $root.Values.glitchtip.readOnlyDatabase.existingSecretKey | default "READ_ONLY_DATABASE_URL" -}}
{{- end -}}

{{- if $roSecret }}
- name: READ_ONLY_DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: {{ $roSecret }}
      key: {{ $roKey }}
{{- end -}}

{{- /* Resolve MAINTENANCE_DATABASE_URL */ -}}
{{- $maintConf := $component.maintenanceDatabase | default dict -}}
{{- $maintSecret := "" -}}
{{- $maintKey := "" -}}

{{- if $maintConf.existingSecret -}}
  {{- $maintSecret = $maintConf.existingSecret -}}
  {{- $maintKey = $maintConf.existingSecretKey | default "MAINTENANCE_DATABASE_URL" -}}
{{- else if $root.Values.glitchtip.maintenanceDatabase.existingSecret -}}
  {{- $maintSecret = $root.Values.glitchtip.maintenanceDatabase.existingSecret -}}
  {{- $maintKey = $root.Values.glitchtip.maintenanceDatabase.existingSecretKey | default "MAINTENANCE_DATABASE_URL" -}}
{{- end -}}

{{- if $maintSecret }}
- name: MAINTENANCE_DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: {{ $maintSecret }}
      key: {{ $maintKey }}
{{- end -}}
{{- end -}}

{{/*
Valkey environment variables
*/}}
{{- define "glitchtip.valkey.env" -}}
{{- if or .Values.valkey.enabled .Values.glitchtip.valkey.existingSecret }}
- name: REDIS_URL
  valueFrom:
    secretKeyRef:
    {{- if .Values.valkey.enabled }}
      name: {{ include "glitchtip.fullname" . }}
      key: REDIS_URL
    {{- else }}
      name: {{ .Values.glitchtip.valkey.existingSecret }}
      key: {{ .Values.glitchtip.valkey.existingSecretKey }}
    {{- end }}
{{- end -}}
{{- end -}}