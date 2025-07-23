# Jitsi Recording Uploader Helm Chart

A Helm chart for deploying the Jitsi Recording Uploader, which automatically uploads Jibri recordings to Google Drive.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- Google Drive API credentials
- Jibri recordings stored in a PVC
- (Optional) External Secrets Operator for external secret management

## Installation

### Method 1: Using Regular Kubernetes Secrets

1. **Prepare your values file:**
```yaml
# my-values.yaml
image:
  repository: your-registry/jitsi-recording-uploader
  tag: latest

credentials:
  method: secret
  googleDrive:
    clientId: "your-client-id"
    clientSecret: "your-client-secret"
    refreshToken: "your-refresh-token"

config:
  jibri:
    pvcName: "jibri-recordings-pvc"  # Your actual PVC name
  googleDrive:
    uploadFolderId: "your-folder-id"  # Optional

affinity:
  podAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
    - labelSelector:
        matchExpressions:
        - key: app
          operator: In
          values: ["jibri"]  # Match your Jibri pod labels
      topologyKey: kubernetes.io/hostname
```

2. **Install the chart:**
```bash
helm install jitsi-uploader ./helm/jitsi-recording-uploader -f my-values.yaml
```

### Method 2: Using External Secrets

1. **Ensure External Secrets Operator is installed:**
```bash
helm repo add external-secrets https://charts.external-secrets.io
helm install external-secrets external-secrets/external-secrets -n external-secrets-system --create-namespace
```

2. **Create your SecretStore (example for HashiCorp Vault):**
```yaml
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: vault-secret-store
  namespace: jitsi
spec:
  provider:
    vault:
      server: "https://vault.example.com"
      path: "secret"
      version: "v2"
      auth:
        kubernetes:
          mountPath: "kubernetes"
          role: "jitsi-uploader"
```

3. **Prepare your values file:**
```yaml
# my-values-external.yaml
image:
  repository: your-registry/jitsi-recording-uploader
  tag: latest

credentials:
  method: externalSecret
  externalSecret:
    name: jitsi-uploader-external-secret
    secretName: jitsi-uploader-credentials
    secretStore:
      name: vault-secret-store
      kind: SecretStore
    data:
      - secretKey: GOOGLE_CLIENT_ID
        remoteRef:
          key: google-drive/jitsi-uploader
          property: client-id
      - secretKey: GOOGLE_CLIENT_SECRET
        remoteRef:
          key: google-drive/jitsi-uploader
          property: client-secret
      - secretKey: GOOGLE_REFRESH_TOKEN
        remoteRef:
          key: google-drive/jitsi-uploader
          property: refresh-token

config:
  jibri:
    pvcName: "jibri-recordings-pvc"
```

4. **Install the chart:**
```bash
helm install jitsi-uploader ./helm/jitsi-recording-uploader -f my-values-external.yaml
```

## Configuration

### Key Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.repository` | Container image repository | `jitsi-recording-uploader` |
| `image.tag` | Container image tag | `latest` |
| `replicaCount` | Number of replicas (should be 1) | `1` |
| `credentials.method` | Credential method: `secret` or `externalSecret` | `secret` |
| `config.jibri.pvcName` | Name of the PVC containing recordings | `jibri-recordings-pvc` |
| `config.jibri.recordingsPath` | Mount path for recordings in container | `/recordings` |
| `config.jibri.readOnly` | Mount PVC as read-only | `true` |
| `config.googleDrive.uploadFolderId` | Google Drive folder ID for uploads | `""` |
| `monitoring.enabled` | Enable Prometheus monitoring | `false` |

### Google Drive Configuration

For `credentials.method: secret`:
```yaml
credentials:
  googleDrive:
    clientId: "your-client-id"
    clientSecret: "your-client-secret" 
    refreshToken: "your-refresh-token"
```

For `credentials.method: externalSecret`:
```yaml
credentials:
  externalSecret:
    name: jitsi-uploader-external-secret
    secretName: jitsi-uploader-credentials
    secretStore:
      name: your-secret-store
      kind: SecretStore
    data:
      - secretKey: GOOGLE_CLIENT_ID
        remoteRef:
          key: path/to/your/secret
          property: client-id
      # ... other credentials
```

### Scheduling Configuration

For RWO PVCs, ensure the uploader runs on the same node as Jibri:

**Pod Affinity (Recommended):**
```yaml
affinity:
  podAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
    - labelSelector:
        matchExpressions:
        - key: app
          operator: In
          values: ["jibri"]
      topologyKey: kubernetes.io/hostname
```

**Node Selector:**
```yaml
nodeSelector:
  jibri-node: "true"
```

### Monitoring

Enable Prometheus monitoring:
```yaml
monitoring:
  enabled: true
  labels:
    prometheus: "monitoring"
  interval: 30s
  path: /metrics
```

## Upgrading

```bash
helm upgrade jitsi-uploader ./helm/jitsi-recording-uploader -f my-values.yaml
```

## Uninstalling

```bash
helm uninstall jitsi-uploader
```

## Troubleshooting

### Check Pod Status
```bash
kubectl get pods -l app.kubernetes.io/name=jitsi-recording-uploader
```

### View Logs
```bash
kubectl logs -l app.kubernetes.io/name=jitsi-recording-uploader -f
```

### Test Google Drive Authentication
```bash
kubectl exec deployment/jitsi-uploader-jitsi-recording-uploader -- npm run test-auth
```

### Verify PVC Access
```bash
kubectl exec deployment/jitsi-uploader-jitsi-recording-uploader -- ls -la /recordings
```

### Check External Secret Status
```bash
kubectl get externalsecret
kubectl describe externalsecret jitsi-uploader-external-secret
```

## Examples

### Production Values Example
```yaml
# production-values.yaml
image:
  repository: your-registry.com/jitsi-recording-uploader
  tag: v1.0.0
  pullPolicy: IfNotPresent

imagePullSecrets:
  - name: registry-credentials

resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 200m
    memory: 256Mi

config:
  jibri:
    pvcName: "production-jibri-recordings"
  googleDrive:
    uploadFolderId: "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74mHvn"
  app:
    logLevel: "warn"
    cleanupAfterUpload: true

monitoring:
  enabled: true
  labels:
    prometheus: "production"

podDisruptionBudget:
  enabled: true
  minAvailable: 1

affinity:
  podAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
    - labelSelector:
        matchExpressions:
        - key: app
          operator: In
          values: ["jibri"]
      topologyKey: kubernetes.io/hostname
```

### Development Values Example
```yaml
# dev-values.yaml
image:
  repository: localhost:5000/jitsi-recording-uploader
  tag: dev
  pullPolicy: Always

config:
  jibri:
    pvcName: "dev-jibri-recordings"
  app:
    logLevel: "debug"
    cleanupAfterUpload: false

resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
```

## Contributing

1. Make changes to the chart
2. Update the version in `Chart.yaml`
3. Test the chart: `helm lint ./helm/jitsi-recording-uploader`
4. Package the chart: `helm package ./helm/jitsi-recording-uploader`