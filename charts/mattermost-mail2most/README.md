# Mattermost Mail2Most Helm Chart

This Helm chart deploys [Mail2Most](https://github.com/Virtomize/mail2most), a tool that filters emails from mail accounts and sends them to Mattermost.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)
- A Mattermost instance with an API token
- An email account with IMAP access

## Installation

### Add the Helm repository (if applicable)

```bash
helm repo add <repo-name> <repo-url>
helm repo update
```

### Install the chart

```bash
helm install my-mail2most ./mattermost-mail2most \
  --set mail.server=imap.gmail.com \
  --set mail.username=myemail@gmail.com \
  --set mail.password=mypassword \
  --set mattermost.url=https://mattermost.example.com \
  --set mattermost.token=your-mattermost-token \
  --set profiles.default.channel=town-square
```

## Configuration

The following table lists the configurable parameters of the Mail2Most chart and their default values.

### Image Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.repository` | Mail2Most image repository | `virtomize/mail2most` |
| `image.tag` | Mail2Most image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `imagePullSecrets` | Image pull secrets | `[]` |

### Mail Server Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `mail.server` | IMAP server hostname | `""` |
| `mail.port` | IMAP server port | `993` |
| `mail.username` | IMAP username | `""` |
| `mail.password` | IMAP password (stored in secret) | `""` |
| `mail.existingSecret` | Use existing secret for password | `""` |
| `mail.existingSecretKey` | Key in existing secret | `imap-password` |
| `mail.readOnly` | Don't delete emails after processing | `true` |
| `mail.ssl` | Use SSL/TLS | `true` |
| `mail.starttls` | Use StartTLS | `false` |

### Mattermost Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `mattermost.url` | Mattermost server URL | `""` |
| `mattermost.token` | Mattermost API token (stored in secret) | `""` |
| `mattermost.existingSecret` | Use existing secret for token | `""` |
| `mattermost.existingSecretKey` | Key in existing secret | `mattermost-token` |
| `mattermost.team` | Mattermost team name | `""` |
| `mattermost.broadcast` | Enable broadcast mode | `false` |

### Profile Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `profiles.default.enabled` | Enable default profile | `true` |
| `profiles.default.channel` | Mattermost channel to post to | `""` |
| `profiles.default.mailbox` | Mail folder to monitor | `INBOX` |
| `profiles.default.subjectOnly` | Only post subject (not body) | `false` |
| `profiles.default.stripHTML` | Strip HTML from messages | `true` |
| `profiles.default.hideFrom` | Hide sender information | `false` |
| `profiles.default.hideFromEmail` | Hide sender email | `false` |
| `profiles.default.attachment` | Process attachments | `true` |
| `profiles.default.from` | Filter by sender (array) | `[]` |
| `profiles.default.to` | Filter by recipient (array) | `[]` |
| `profiles.default.subject` | Filter by subject (array) | `[]` |
| `profiles.default.timeRange` | Time range in hours | `""` |

### Persistence Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.enabled` | Enable persistent storage | `true` |
| `persistence.storageClassName` | Storage class name | `""` |
| `persistence.accessMode` | PVC access mode | `ReadWriteOnce` |
| `persistence.size` | PVC size | `5Gi` |
| `persistence.existingClaim` | Use existing PVC | `""` |

### Resource Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `resources.limits.cpu` | CPU limit | `500m` |
| `resources.limits.memory` | Memory limit | `512Mi` |
| `resources.requests.cpu` | CPU request | `100m` |
| `resources.requests.memory` | Memory request | `128Mi` |

### Other Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of replicas | `1` |
| `logging.level` | Log level (debug, info, warn, error) | `info` |
| `serviceAccount.create` | Create service account | `true` |
| `podSecurityContext` | Pod security context | See values.yaml |
| `securityContext` | Container security context | See values.yaml |
| `nodeSelector` | Node selector | `{}` |
| `tolerations` | Tolerations | `[]` |
| `affinity` | Affinity | `{}` |

## Examples

### Using Gmail with App Password

```yaml
mail:
  server: imap.gmail.com
  port: 993
  username: myemail@gmail.com
  password: "app-specific-password"
  ssl: true

mattermost:
  url: https://mattermost.example.com
  token: "your-mattermost-token"

profiles:
  default:
    enabled: true
    channel: "email-notifications"
    mailbox: "INBOX"
    stripHTML: true
    from:
      - "important@sender.com"
    subject:
      - "URGENT"
```

### Using Existing Secrets

If you have existing Kubernetes secrets with your credentials:

```yaml
mail:
  server: imap.example.com
  username: user@example.com
  existingSecret: "my-mail-secret"
  existingSecretKey: "password"

mattermost:
  url: https://mattermost.example.com
  existingSecret: "my-mattermost-secret"
  existingSecretKey: "token"
```

### Multiple Profiles

You can configure multiple profiles to route different emails to different channels:

```yaml
profiles:
  default:
    enabled: true
    channel: "general"
    mailbox: "INBOX"
  
  alerts:
    enabled: true
    channel: "alerts"
    mailbox: "INBOX"
    from:
      - "monitoring@example.com"
    subject:
      - "ALERT"
      - "WARNING"
  
  support:
    enabled: true
    channel: "support"
    mailbox: "Support"
    from:
      - "support@"
```

### Custom Configuration

You can provide a completely custom configuration using the `mail.config` field:

```yaml
mail:
  config: |
    [General]
    File = /mail2most/data/data.json
    Loglevel = debug
    
    [Mail]
    ImapServer = custom.imap.server
    ImapPort = 993
    ImapUser = user@example.com
    ImapPass = ${IMAP_PASSWORD}
    ReadOnly = true
    SSL = true
    
    [Mattermost]
    URL = https://mattermost.example.com
    Token = ${MATTERMOST_TOKEN}
    
    [Profile:custom]
    Channel = my-channel
    Mailbox = INBOX
    SubjectOnly = false
```

## Persistence

This chart creates a PersistentVolumeClaim to store:
- `/mail2most/data/` - Mail2Most data file (tracks processed emails)
- `/mail2most/logs/` - Application logs

If persistence is disabled, data will be lost when the pod restarts.

## Security Considerations

1. **Secrets**: Always use Kubernetes secrets for sensitive data (passwords, tokens)
2. **Network Policies**: Consider implementing network policies to restrict traffic
3. **RBAC**: The chart creates a ServiceAccount with minimal permissions
4. **Security Context**: Runs as non-root user by default

## Troubleshooting

### Check Logs

```bash
kubectl logs deployment/my-mail2most
```

### Verify Configuration

```bash
kubectl describe configmap my-mail2most-config
```

### Check Persistent Volume

```bash
kubectl get pvc
kubectl describe pvc my-mail2most-data
```

### Common Issues

1. **Authentication Failed**: Verify your email credentials and ensure IMAP is enabled
2. **Mattermost Connection Error**: Check the Mattermost URL and token
3. **No Emails Processed**: Check the filter configuration and mailbox name
4. **Permission Denied**: Ensure the PVC has the correct permissions

## Uninstallation

```bash
helm uninstall my-mail2most
```

To also delete the persistent volume:

```bash
kubectl delete pvc my-mail2most-data
```

## License

This Helm chart is provided as-is. Mail2Most is licensed under the MIT License.