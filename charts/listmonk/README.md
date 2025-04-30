# Listmonk Helm Chart

This Helm chart installs [Listmonk](https://listmonk.app/), a high performance, self-hosted newsletter and mailing list manager with a modern dashboard.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure (for PostgreSQL persistence)

## Installing the Chart

To install the chart with the release name `my-listmonk`:

```bash
helm install my-listmonk ./charts/listmonk
```

## Uninstalling the Chart

To uninstall/delete the `my-listmonk` deployment:

```bash
helm delete my-listmonk
```

## Configuration

The following table lists the configurable parameters of the Listmonk chart and their default values.

### Common Settings

| Parameter             | Description                          | Default |
| --------------------- | ------------------------------------ | ------- |
| `commonAnnotations`   | Common annotations for all resources | `{}`    |
| `podAnnotations`      | Pod annotations                      | `{}`    |
| `podLabels`           | Pod labels                           | `{}`    |
| `extraInitContainers` | Extra init containers                | `{}`    |

### Listmonk

| Parameter                      | Description                         | Default             |
| ------------------------------ | ----------------------------------- | ------------------- |
| `listmonk.image.repository`    | Listmonk image repository           | `listmonk/listmonk` |
| `listmonk.image.tag`           | Listmonk image tag                  | `v4.1.0`            |
| `listmonk.replicas`            | Number of Listmonk replicas         | `1`                 |
| `listmonk.resources`           | CPU/Memory resource requests/limits | `{}`                |
| `listmonk.storage.uploadsSize` | PVC size for uploads                | `5Gi`               |
| `listmonk.storage.staticSize`  | PVC size for static content         | `1Gi`               |

### PostgreSQL

| Parameter                   | Description                              | Default     |
| --------------------------- | ---------------------------------------- | ----------- |
| `postgres.enabled`          | Enable PostgreSQL deployment             | `true`      |
| `postgres.hostname`         | External PostgreSQL hostname             | `""`        |
| `postgres.existingSecret`   | Existing secret with PostgreSQL password | `""`        |
| `postgres.database`         | PostgreSQL database name                 | `listmonk`  |
| `postgres.user`             | PostgreSQL username                      | `listmonk`  |
| `postgres.password`         | PostgreSQL password                      | `listmonk`  |
| `postgres.image.repository` | PostgreSQL image repository              | `postgres`  |
| `postgres.image.tag`        | PostgreSQL image tag                     | `16-alpine` |
| `postgres.storage.size`     | PVC size for PostgreSQL data             | `10Gi`      |
| `postgres.resources`        | CPU/Memory resource requests/limits      | `{}`        |

### Ingress

| Parameter             | Description         | Default          |
| --------------------- | ------------------- | ---------------- |
| `ingress.enabled`     | Enable ingress      | `false`          |
| `ingress.className`   | Ingress class name  | `""`             |
| `ingress.annotations` | Ingress annotations | `{}`             |
| `ingress.host`        | Ingress host        | `listmonk.local` |
| `ingress.tls`         | TLS configuration   | `[]`             |

## Persistence

Listmonk uses PostgreSQL for database storage. The chart mounts persistent volumes for the PostgreSQL data, as well as for Listmonk's uploads and static content. These volumes will be created through PersistentVolumeClaims which will be created when you deploy the chart.

## Security Considerations

By default, this chart sets up a PostgreSQL instance with a default password. In production environments, you should:

1. Change the default database passwords
2. Consider using an external PostgreSQL database
3. Use `postgres.existingSecret` to provide credentials from a pre-existing secret
4. Enable TLS for ingress if exposing the service externally
