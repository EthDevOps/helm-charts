{{/*
Database URL constructed from postgresql subchart helpers
*/}}
{{- define "appflowy.databaseUrl" -}}
postgresql://{{ include "postgresql.v1.username" .Subcharts.postgresql }}:{{ .Values.postgresql.auth.password }}@{{ include "postgresql.v1.primary.fullname" .Subcharts.postgresql }}:{{ include "postgresql.v1.service.port" .Subcharts.postgresql }}/{{ include "postgresql.v1.database" .Subcharts.postgresql }}
{{- end -}}

{{/*
Redis URL constructed from redis subchart helpers
*/}}
{{- define "appflowy.redisUrl" -}}
redis://{{ printf "%s-master" (include "common.names.fullname" .Subcharts.redis) }}:{{ .Values.redis.master.service.ports.redis }}
{{- end -}}

{{/*
Internal GoTrue service URL
*/}}
{{- define "appflowy.gotrueInternalUrl" -}}
http://{{ .Release.Name }}-gotrue-app:9999
{{- end -}}

{{/*
Internal Cloud service URL
*/}}
{{- define "appflowy.cloudInternalUrl" -}}
http://{{ .Release.Name }}-cloud-app:8000
{{- end -}}

{{/*
Internal Search service URL
*/}}
{{- define "appflowy.searchInternalUrl" -}}
http://{{ .Release.Name }}-search-app:4002
{{- end -}}

{{/*
Internal AI service URL
*/}}
{{- define "appflowy.aiInternalUrl" -}}
http://{{ .Release.Name }}-ai-app:5001
{{- end -}}

{{/*
External base URL
*/}}
{{- define "appflowy.baseUrl" -}}
https://{{ .Values.appDomain }}
{{- end -}}

{{/*
External WebSocket URL
*/}}
{{- define "appflowy.wsUrl" -}}
wss://{{ .Values.appDomain }}/ws
{{- end -}}
