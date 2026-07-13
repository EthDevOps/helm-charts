{{/*
Database host: bundled mariadb subchart service or external host.
The groundhog2k/mariadb subchart names its service <release>-mariadb.
*/}}
{{- define "engelsystem.dbHost" -}}
{{- if .Values.mariadb.enabled -}}
{{ .Release.Name }}-mariadb
{{- else -}}
{{ required "externalDatabase.host is required when mariadb.enabled is false" .Values.externalDatabase.host }}
{{- end -}}
{{- end -}}

{{- define "engelsystem.dbDatabase" -}}
{{- if .Values.mariadb.enabled }}{{ .Values.mariadb.userDatabase.name.value }}{{ else }}{{ .Values.externalDatabase.database }}{{ end -}}
{{- end -}}

{{- define "engelsystem.dbUser" -}}
{{- if .Values.mariadb.enabled }}{{ .Values.mariadb.userDatabase.user.value }}{{ else }}{{ .Values.externalDatabase.user }}{{ end -}}
{{- end -}}

{{- define "engelsystem.dbPassword" -}}
{{- if .Values.mariadb.enabled }}{{ .Values.mariadb.userDatabase.password.value }}{{ else }}{{ .Values.externalDatabase.password }}{{ end -}}
{{- end -}}

{{/* Secret holding MYSQL_PASSWORD for the app */}}
{{- define "engelsystem.dbSecretName" -}}
{{- if .Values.databaseExistingSecret.name -}}
{{ .Values.databaseExistingSecret.name }}
{{- else -}}
{{ .Release.Name }}-engelsystem
{{- end -}}
{{- end -}}

{{- define "engelsystem.dbPasswordKey" -}}
{{- if .Values.databaseExistingSecret.name -}}
{{ .Values.databaseExistingSecret.passwordKey }}
{{- else -}}
MYSQL_PASSWORD
{{- end -}}
{{- end -}}

{{/* Environment shared by the app container and the migrate init container */}}
{{- define "engelsystem.databaseEnv" -}}
- name: MYSQL_TYPE
  value: mariadb
- name: MYSQL_HOST
  value: {{ include "engelsystem.dbHost" . | quote }}
- name: MYSQL_DATABASE
  {{- if and .Values.databaseExistingSecret.name .Values.databaseExistingSecret.databaseKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.databaseExistingSecret.name }}
      key: {{ .Values.databaseExistingSecret.databaseKey }}
  {{- else }}
  value: {{ include "engelsystem.dbDatabase" . | quote }}
  {{- end }}
- name: MYSQL_USER
  {{- if and .Values.databaseExistingSecret.name .Values.databaseExistingSecret.userKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.databaseExistingSecret.name }}
      key: {{ .Values.databaseExistingSecret.userKey }}
  {{- else }}
  value: {{ include "engelsystem.dbUser" . | quote }}
  {{- end }}
- name: MYSQL_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "engelsystem.dbSecretName" . }}
      key: {{ include "engelsystem.dbPasswordKey" . }}
{{- end -}}
