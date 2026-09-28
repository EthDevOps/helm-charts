{{- define "docmost.localStorage" -}}
{{- if eq .Values.storage.driver "local" }}true{{ end -}}
{{- end -}}

{{- define "docmost.appSecretName" -}}
{{- .Values.appSecret.existingSecret | default (printf "%s-docmost" .Release.Name) -}}
{{- end -}}
