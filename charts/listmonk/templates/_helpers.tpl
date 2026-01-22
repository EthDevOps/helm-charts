{{/*
Get the postgres secret name
*/}}
{{- define "listmonk.postgresSecretName" -}}
{{- if .Values.postgres.existingSecret -}}
{{- .Values.postgres.existingSecret -}}
{{- else -}}
{{- .Release.Name }}-postgres-secret
{{- end -}}
{{- end -}}

{{/*
Get the postgres secret key
*/}}
{{- define "listmonk.postgresSecretKey" -}}
{{- if .Values.postgres.secretKey -}}
{{- .Values.postgres.secretKey -}}
{{- else -}}
postgres-password
{{- end -}}
{{- end -}}
