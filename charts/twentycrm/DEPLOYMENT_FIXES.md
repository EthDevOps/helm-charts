# Twenty CRM Helm Chart - Deployment Fixes Applied

## Summary
Successfully deployed Twenty CRM with all components running. The following issues were identified and fixed during initial deployment.

## Issues Fixed

### 1. Redis Container Startup Failure
**Problem:** Redis container failed with error:
```
exec: "--maxmemory-policy": executable file not found in $PATH
```

**Root Cause:** Args were passed without specifying the command, causing Kubernetes to try executing the arg as a binary.

**Fix:** Added explicit `command` with `redis-server`:
```yaml
command:
  - redis-server
  - --maxmemory-policy
  - noeviction
  - --protected-mode
  - "no"
```
**File:** `templates/redis-deployment.yaml:37-42`

---

### 2. Redis Protected Mode
**Problem:** Server couldn't connect to Redis:
```
DENIED Redis is running in protected mode
```

**Root Cause:** Redis Stack Server runs in protected mode by default, blocking external connections.

**Fix:** Added `--protected-mode no` to Redis command arguments.
**File:** `templates/redis-deployment.yaml:41-42`

---

### 3. PostgreSQL Spilo Complexity
**Problem:** Spilo (HA PostgreSQL) had permission issues and complex initialization requirements:
```
PermissionError: [Errno 13] Permission denied: '/run/service'
```

**Root Cause:** Spilo requires elevated privileges for initialization and is overly complex for basic deployments.

**Fix:** Switched to standard `postgres:16-alpine` image (matching listmonk pattern):
- Changed image from `twentycrm/twenty-postgres-spilo:latest` to `postgres:16-alpine`
- Simplified environment variables (removed SPILO-specific vars)
- Adjusted PGDATA path to `/var/lib/postgresql/data/pgdata`
- Removed security context restrictions

**Files:**
- `values.yaml:154-156`
- `templates/postgres-statefulset.yaml:34-44,51`

---

### 4. Missing FRONT_BASE_URL
**Problem:** Server and worker crashed with validation error:
```
property FRONT_BASE_URL has failed the following constraints: isUrl
```

**Root Cause:** Twenty CRM requires FRONT_BASE_URL environment variable.

**Fix:** Added FRONT_BASE_URL using the same value as SERVER_URL:
```yaml
- name: FRONT_BASE_URL
  value: https://crm.example.com
```
**Files:**
- `templates/server-deployment.yaml:65-66`
- `templates/worker-deployment.yaml:61-62`

---

### 5. Redis Connection Configuration
**Problem:** Application tried connecting to Redis at `127.0.0.1:6379` instead of the service.

**Root Cause:** Twenty CRM needs explicit REDIS_HOST and REDIS_PORT environment variables, not just REDIS_URL.

**Fix:** Added individual Redis connection environment variables:
```yaml
- name: REDIS_HOST
  value: twent-crm-redis
- name: REDIS_PORT
  value: "6379"
```
**Files:**
- `templates/server-deployment.yaml:83-86`
- `templates/worker-deployment.yaml:79-82`

---

### 6. PostgreSQL Connection String
**Problem:** PG_DATABASE_URL with shell substitution `$(POSTGRES_PASSWORD)` wasn't expanded in Kubernetes, then removing it caused validation error:
```
property PG_DATABASE_URL has failed the following constraints: isDefined, isUrl
```

**Root Cause:**
1. Kubernetes env vars don't support shell substitution
2. PG_DATABASE_URL is a required field in Twenty CRM

**Fix:** Implemented command wrapper to construct PG_DATABASE_URL at runtime from individual env vars:
```yaml
command: ["/bin/sh", "-c"]
args:
- |
  export PG_DATABASE_URL="postgres://${PG_DATABASE_USER}:${PG_DATABASE_PASSWORD}@${PG_DATABASE_HOST}:${PG_DATABASE_PORT}/${PG_DATABASE_NAME}"
  exec node dist/src/main
```

Added individual database connection env vars:
- PG_DATABASE_HOST
- PG_DATABASE_PORT
- PG_DATABASE_USER
- PG_DATABASE_PASSWORD
- PG_DATABASE_NAME

**Files:**
- `templates/server-deployment.yaml:60-64, 74-86`
- `templates/worker-deployment.yaml:57-61, 70-82`

---

### 7. PostgreSQL Secret Cleanup
**Problem:** Secret template referenced superuser password that doesn't exist with standard postgres.

**Fix:** Removed `postgres-superuser-password` from secret, kept only `postgres-password`.
**File:** `templates/secret-postgres.yaml:14`

---

## Final Architecture

### Working Components
✅ **PostgreSQL** (postgres:16-alpine)
- StatefulSet with volumeClaimTemplates
- Headless service (clusterIP: None)
- 10Gi storage
- User: twenty, Database: twenty

✅ **Redis** (redis/redis-stack-server:latest)
- Deployment (1 replica)
- Protected mode disabled
- noeviction memory policy
- ClusterIP service on port 6379

✅ **Server** (twentycrm/twenty:latest)
- Deployment (1 replica)
- Port 3000
- Init container for postgres readiness
- Command wrapper for PG_DATABASE_URL construction
- 2 PVCs: server-storage (10Gi), docker-data (10Gi)

✅ **Worker** (twentycrm/twenty:latest)
- Deployment (1 replica)
- Background job processing
- Command wrapper for PG_DATABASE_URL construction
- No persistent storage

### Services
- `twent-crm-postgres` - Headless service (port 5432)
- `twent-crm-redis` - ClusterIP service (port 6379)
- `twent-crm-server` - ClusterIP service (port 3000)

## Deployment Status
```
NAME                                READY   STATUS    RESTARTS   AGE
twent-crm-postgres-0                1/1     Running   0          9m
twent-crm-redis-54c858b947-6q6c7    1/1     Running   0          5m
twent-crm-server-8cd5f6449-6gnqp    1/1     Running   0          48s
twent-crm-worker-774f44c89c-522p4   1/1     Running   0          48s
```

## Key Learnings

1. **Spilo is overkill** for simple deployments - standard postgres is more reliable
2. **Twenty CRM requires specific env vars** - FRONT_BASE_URL, PG_DATABASE_URL, REDIS_HOST/PORT
3. **Shell substitution doesn't work** in K8s env vars - use command wrappers
4. **Redis Stack Server** needs protected mode disabled for cluster use
5. **Command vs Args** matters in K8s - always specify command explicitly

## Next Steps

### Optional Enhancements
- [ ] Enable ingress for external access
- [ ] Configure proper TLS certificates
- [ ] Set up horizontal pod autoscaling
- [ ] Add monitoring (Prometheus/Grafana)
- [ ] Implement backup strategy for PostgreSQL
- [ ] Configure resource limits for production
- [ ] Add network policies
- [ ] Set up external postgres/redis for HA

### Testing
```bash
# Port forward to access the application
kubectl port-forward svc/twent-crm-server 3000:3000

# Access at http://localhost:3000
```

## Files Modified During Fixes
1. `templates/redis-deployment.yaml` - Command args and protected mode
2. `templates/postgres-statefulset.yaml` - Image, env vars, paths
3. `templates/server-deployment.yaml` - Command wrapper, env vars
4. `templates/worker-deployment.yaml` - Command wrapper, env vars
5. `templates/secret-postgres.yaml` - Removed superuser password
6. `values.yaml` - Changed postgres image to standard

## Total Revisions: 9
All issues resolved in revision 9.
