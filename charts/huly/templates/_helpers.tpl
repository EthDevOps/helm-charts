{{/*
Expand the name of the chart.
*/}}
{{- define "huly.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "huly.fullname" -}}
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
Resolve the chart-managed Secret name, OR the user-provided existingSecret if set.
This is the secret that holds SERVER_SECRET, STORAGE_CONFIG, CR_DB_URL, etc.
*/}}
{{- define "huly.secretName" -}}
{{- if .Values.secrets.existingSecret -}}
{{- .Values.secrets.existingSecret -}}
{{- else -}}
{{- printf "%s-secret" (include "huly.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
The chart-managed Secret name (always), used by secret.yaml itself for
metadata.name. Distinct from huly.secretName, which may resolve to an
externally-provided secret.
*/}}
{{- define "huly.managedSecretName" -}}
{{- printf "%s-secret" (include "huly.fullname" .) -}}
{{- end }}

{{/*
ConfigMap resource name.
*/}}
{{- define "huly.configName" -}}
{{- printf "%s-config" (include "huly.fullname" .) }}
{{- end }}

{{/*
Common labels applied to every resource.
*/}}
{{- define "huly.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: huly
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{/*
Per-component labels. Adds app.kubernetes.io/name + component on top of
huly.labels. Usage:
  {{- include "huly.componentLabels" (dict "component" "front" "root" .) | nindent 4 }}
*/}}
{{- define "huly.componentLabels" -}}
{{ include "huly.labels" .root }}
app.kubernetes.io/name: {{ .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}

{{/*
Global scheduling (nodeSelector, tolerations, affinity).
*/}}
{{- define "huly.scheduling" -}}
{{- with .Values.global.nodeSelector }}
nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.global.tolerations }}
tolerations:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.global.affinity }}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{/*
Effective MinIO enabled (disabled if storage.type == s3).
*/}}
{{- define "huly.minioEnabled" -}}
{{- if and .Values.minio.enabled (eq .Values.storage.type "minio") }}true{{- else }}false{{- end }}
{{- end }}

{{/*
Checksum annotations — triggers pod restart when secret/configmap changes.
Only includes secret checksum when the chart manages the Secret (not when
sourcing from existingSecret — its content is opaque to the chart).
Usage: {{- include "huly.checksumAnnotations" . | nindent 8 }}
*/}}
{{- define "huly.checksumAnnotations" -}}
{{- if not .Values.secrets.existingSecret }}
checksum/secret: {{ include (print $.Template.BasePath "/secret.yaml") . | sha256sum }}
{{- end }}
checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
{{- end }}

{{/*
Common resources block for the small `wait-*` init containers (busybox).
Kept tiny — these just block on a TCP connect — but explicit so kube-score
clears container-resources and container-ephemeral-storage-request-and-limit.
*/}}
{{- define "huly.waitInitResources" -}}
resources:
  requests:
    cpu: 10m
    memory: 16Mi
    ephemeral-storage: 32Mi
  limits:
    cpu: 50m
    memory: 64Mi
    ephemeral-storage: 64Mi
{{- end }}

{{/*
Hardened securityContext for the busybox wait-* init containers.
Runs as a high uid/gid (busybox supports running as any user) so kube-score
clears container-security-context-user-group-id without an ignore annotation.
*/}}
{{- define "huly.waitInitSecurityContext" -}}
securityContext:
  runAsNonRoot: true
  runAsUser: 65532
  runAsGroup: 65532
  allowPrivilegeEscalation: false
  readOnlyRootFilesystem: true
  capabilities:
    drop:
      - ALL
{{- end }}

{{/*
Init container that waits for CockroachDB to accept connections.
*/}}
{{- define "huly.waitForCockroach" -}}
{{- if .Values.cockroach.enabled }}
- name: wait-cockroach
  image: {{ .Values.waitInit.image }}
  imagePullPolicy: {{ .Values.waitInit.imagePullPolicy }}
  command: ['sh', '-c', 'until nc -z cockroach 26257; do echo "waiting for cockroach..."; sleep 2; done']
  {{- include "huly.waitInitSecurityContext" . | nindent 2 }}
  {{- include "huly.waitInitResources" . | nindent 2 }}
{{- end }}
{{- end }}

{{/*
Init container that waits for MongoDB to accept connections.
*/}}
{{- define "huly.waitForMongodb" -}}
{{- if .Values.mongodb.enabled }}
- name: wait-mongodb
  image: {{ .Values.waitInit.image }}
  imagePullPolicy: {{ .Values.waitInit.imagePullPolicy }}
  command: ['sh', '-c', 'until nc -z mongodb 27017; do echo "waiting for mongodb..."; sleep 2; done']
  {{- include "huly.waitInitSecurityContext" . | nindent 2 }}
  {{- include "huly.waitInitResources" . | nindent 2 }}
{{- end }}
{{- end }}

{{/*
Init container that waits for Redpanda to accept connections.
*/}}
{{- define "huly.waitForRedpanda" -}}
{{- if .Values.redpanda.enabled }}
- name: wait-redpanda
  image: {{ .Values.waitInit.image }}
  imagePullPolicy: {{ .Values.waitInit.imagePullPolicy }}
  command: ['sh', '-c', 'until nc -z redpanda 9092; do echo "waiting for redpanda..."; sleep 2; done']
  {{- include "huly.waitInitSecurityContext" . | nindent 2 }}
  {{- include "huly.waitInitResources" . | nindent 2 }}
{{- end }}
{{- end }}

{{/*
Comma-joined kube-score/ignore list applied to every workload that runs
upstream Huly / third-party images we don't build. The images bake in low
uids and ship a single tag at a time, so we can't satisfy
container-security-context-user-group-id without rebuilding upstream.
*/}}
{{- define "huly.kubeScoreIgnore" -}}
container-security-context-user-group-id
{{- end }}

{{/*
Backup secret — resolves existingSecret if set, else the chart-managed name.
*/}}
{{- define "huly.backupSecretName" -}}
{{- if .Values.backup.existingSecret -}}
{{- .Values.backup.existingSecret -}}
{{- else -}}
{{- printf "%s-backup-secret" (include "huly.fullname" .) -}}
{{- end -}}
{{- end }}

{{- define "huly.managedBackupSecretName" -}}
{{- printf "%s-backup-secret" (include "huly.fullname" .) -}}
{{- end }}

{{/*
Env var from main Secret (resolves existingSecret transparently).
Usage: {{- include "huly.envSecret" (dict "name" "SERVER_SECRET" "key" "SERVER_SECRET" "root" .) }}
*/}}
{{- define "huly.envSecret" -}}
- name: {{ .name }}
  valueFrom:
    secretKeyRef:
      name: {{ include "huly.secretName" .root }}
      key: {{ .key }}
{{- end }}

{{/*
Env var from backup Secret.
*/}}
{{- define "huly.envBackupSecret" -}}
- name: {{ .name }}
  valueFrom:
    secretKeyRef:
      name: {{ include "huly.backupSecretName" .root }}
      key: {{ .key }}
{{- end }}

{{/*
Env var from ConfigMap.
*/}}
{{- define "huly.envConfig" -}}
- name: {{ .name }}
  valueFrom:
    configMapKeyRef:
      name: {{ include "huly.configName" .root }}
      key: {{ .key }}
{{- end }}

{{/*
Render Service spec fields (type, annotations-relevant fields, LB config) from
a per-component .service block, merged over .Values.serviceDefaults.

Note: this does NOT render `selector` or `ports` — the calling template owns
those. It also does NOT render `metadata.annotations` (those go on metadata
in the calling template via huly.serviceAnnotations).

Usage:
  spec:
    {{- include "huly.serviceSpec" (dict "cfg" .Values.front.service "root" .) | nindent 2 }}
    selector:
      ...
*/}}
{{- define "huly.serviceSpec" -}}
{{- $defaults := .root.Values.serviceDefaults | default dict -}}
{{- $cfg := mergeOverwrite (deepCopy $defaults) (.cfg | default dict) -}}
type: {{ default "ClusterIP" $cfg.type }}
{{- with $cfg.clusterIP }}
clusterIP: {{ . | quote }}
{{- end }}
{{- with $cfg.loadBalancerIP }}
loadBalancerIP: {{ . | quote }}
{{- end }}
{{- with $cfg.loadBalancerClass }}
loadBalancerClass: {{ . | quote }}
{{- end }}
{{- with $cfg.loadBalancerSourceRanges }}
loadBalancerSourceRanges:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with $cfg.externalTrafficPolicy }}
externalTrafficPolicy: {{ . }}
{{- end }}
{{- with $cfg.ipFamilyPolicy }}
ipFamilyPolicy: {{ . }}
{{- end }}
{{- with $cfg.ipFamilies }}
ipFamilies:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with $cfg.allocateLoadBalancerNodePorts }}
allocateLoadBalancerNodePorts: {{ . }}
{{- end }}
{{- end }}

{{/*
Render Service metadata.annotations, merging per-component .service.annotations
over .Values.serviceDefaults.annotations.

Emits the full `annotations:` block when there is at least one annotation,
otherwise emits nothing. Usage (inside metadata):

  {{- include "huly.serviceAnnotations" (dict "cfg" .Values.front.service "root" .) | nindent 2 }}
*/}}
{{- define "huly.serviceAnnotations" -}}
{{- $defaults := .root.Values.serviceDefaults.annotations | default dict -}}
{{- $cfgAnn := dict -}}
{{- if .cfg -}}{{- $cfgAnn = .cfg.annotations | default dict -}}{{- end -}}
{{- $merged := mergeOverwrite (deepCopy $defaults) $cfgAnn -}}
{{- if $merged }}
annotations:
  {{- toYaml $merged | nindent 2 }}
{{- end }}
{{- end }}

{{/*
Resolve a per-port nodePort for a service. Used inline on a port entry:

  ports:
    - name: http
      port: 8080
      targetPort: 8080
      {{- include "huly.servicePortNodePort" .Values.front.service | nindent 6 }}
*/}}
{{- define "huly.servicePortNodePort" -}}
{{- if . -}}
{{- with .nodePort }}
nodePort: {{ . }}
{{- end -}}
{{- end -}}
{{- end }}
