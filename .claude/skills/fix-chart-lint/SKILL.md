---
name: fix-chart-lint
description: Fix `helm lint` and `kube-score` CRITICAL findings on a single chart under `charts/<name>`. Iterates until `scripts/helm-lint-charts.sh <chart>` and `scripts/kube-score-charts.sh <chart>` both exit zero, then bumps the chart version. Use when the user asks to "fix lint", "fix kube-score", "make this chart pass CI", or names a chart and says "fix the findings".
---

# fix-chart-lint

Given a single chart directory (e.g. `charts/foo`), iteratively resolve every
helm-lint error and kube-score CRITICAL finding while preserving chart
behavior. Stop once both scripts exit zero. Bump the chart `version` in
`Chart.yaml` after the last edit.

## Inputs

The user invokes this skill with a chart path. If they don't supply one, ask:
"Which chart? (e.g. `charts/cryptpad`)". Do not guess — pick the chart only
from explicit user input.

## Workflow

1. **Baseline.** Run both checks and capture findings:
   - `helm lint <chart>`
   - `scripts/kube-score-charts.sh <chart>`
2. **Plan.** For each CRITICAL finding, map it to a fix using the recipe table
   below. Tell the user, in 3–6 lines, what you intend to change and why.
   Don't ask permission for each fix — the user invoked the skill expecting
   edits. Do ask if a change is genuinely destructive (e.g. renaming a
   StatefulSet's immutable `serviceName`, which forces SS recreation).
3. **Apply.** Edit `values.yaml`, templates, or add new templates.
4. **Re-check.** Re-run both scripts. Loop until clean or until you hit a
   finding that requires a judgement call — at which point pause and ask.
5. **Bump version.** Edit `Chart.yaml`:
   - Patch bump (`0.0.X+1`) for additive defaults and new templates.
   - Minor bump (`0.X+1.0`) when introducing a breaking change like a new
     immutable field on an existing workload (StatefulSet `serviceName`).
6. **Report.** Summarize the diff in 5–10 bullets. Mention any kube-score
   *warnings* you intentionally left (e.g. replicas < 2 for stateful apps,
   no podAntiAffinity for single-replica deployments) — these don't fail the
   script (`--exit-one-on-warning=false`) and shouldn't be "fixed" by
   inflating replica counts on apps that can't scale horizontally.

## Constraints

- Defaults in `values.yaml` must make the checks pass. Don't add a new value
  and leave it disabled by default — that defeats the point.
- Don't refactor unrelated code. Touch only what's needed to clear findings.
- Don't disable existing functionality to silence a check. If an image
  genuinely needs root (e.g. `apk add`), use `kube-score/ignore` for the
  uid/gid test rather than gutting the init container.
- Preserve named ports and existing volume mounts — kube-score doesn't care
  about them, but downstream charts may.

## Recipe table

Map each kube-score CRITICAL test to its fix. Test names are the values to
use in `kube-score/ignore: <name>` annotations.

### `container-resources` — missing CPU/memory requests or limits

Add defaults to `values.yaml`:
```yaml
resources:
  requests:
    cpu: 100m
    memory: 512Mi
  limits:
    cpu: "2"
    memory: 2Gi
```
For sidecar/init containers, add a separate resources block under a dedicated
values key (e.g. `initContainer.resources`) and wire it in the template.
Scale defaults to match the app's actual footprint when known.

### `container-ephemeral-storage-request-and-limit`

Add `ephemeral-storage` to the same `resources.requests` and `resources.limits`:
```yaml
resources:
  requests:
    ephemeral-storage: 256Mi
  limits:
    ephemeral-storage: 1Gi
```

### `container-image-pull-policy` — not set to Always

Two cases:
1. **Tagged image** (the usual case): set `image.pullPolicy: Always` in values
   and render it on the container: `imagePullPolicy: {{ .Values.image.pullPolicy }}`.
2. **Untagged image** (`image: alpine`): Kubernetes implicitly sets
   `imagePullPolicy: Always` — kube-score won't flag it. When you pin a tag
   (which you should — see next recipe), add an explicit `imagePullPolicy`.

### `container-image-tag` — image uses `:latest` or no tag

Pin a tag. For utility init containers, add a dedicated values key:
```yaml
initContainer:
  image: alpine:3.20
  imagePullPolicy: Always
```
For helm-test pods, pin a value too (e.g. `testConnection.image: busybox:1.36`).

### `pod-probes` — missing readinessProbe

Add a `readinessProbe`. Prefer a check that actually verifies app readiness:
- `httpGet` on a stable lightweight endpoint (e.g. `/`, `/healthz`, `/http-bind`).
- `tcpSocket` is acceptable when no HTTP endpoint is reliably ready before
  the app accepts traffic.

### `pod-probes-identical` — readiness and liveness probes match

Differentiate by **handler**, not just by timing. Common split:
- `readinessProbe`: `httpGet` on a meaningful path
- `livenessProbe`: `tcpSocket` on the same port

Kube-score compares the handler structurally; just changing
`initialDelaySeconds` doesn't satisfy the check.

### `pod-networkpolicy` — no matching NetworkPolicy

Create `templates/networkpolicy.yaml`:
```yaml
{{- if .Values.networkPolicy.enabled }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ include "<chart>.fullname" . }}
  labels:
    {{- include "<chart>.labels" . | nindent 4 }}
spec:
  podSelector:
    matchLabels:
      {{- include "<chart>.selectorLabels" . | nindent 6 }}
  policyTypes:
    - Ingress
    - Egress
  {{- with .Values.networkPolicy.ingress }}
  ingress:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.networkPolicy.egress }}
  egress:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
```
Adapt the helper names to the chart's `_helpers.tpl`. If the chart lacks
`<chart>.selectorLabels`, use the plain labels that the workload's selector
uses (e.g. `app: {{ .Release.Name }}-foo`).

Default values: enabled, ingress to the app's listening ports, unrestricted
egress (`egress: [{}]`). Kube-score only checks for *existence* of a matching
policy, not strict rules — keep defaults permissive so charts work
out-of-the-box, and let operators tighten them per-environment.

### `deployment-has-poddisruptionbudget`

Create `templates/pdb.yaml`:
```yaml
{{- if .Values.podDisruptionBudget.enabled }}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ include "<chart>.fullname" . }}
spec:
  {{- if .Values.podDisruptionBudget.minAvailable }}
  minAvailable: {{ .Values.podDisruptionBudget.minAvailable }}
  {{- else }}
  maxUnavailable: {{ .Values.podDisruptionBudget.maxUnavailable }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "<chart>.selectorLabels" . | nindent 6 }}
{{- end }}
```
Default to `maxUnavailable: 1` — works for any replica count and doesn't
trap single-replica apps in undrainable nodes.

### `statefulset-has-servicename` — no matching headless Service

Add a separate headless service `<fullname>-headless` and point the
StatefulSet's `serviceName` at it. **Warning:** `serviceName` is immutable;
changing it on an existing chart forces StatefulSet recreation. Bump the
chart minor version and tell the user.

```yaml
# templates/service-headless.yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "<chart>.fullname" . }}-headless
spec:
  type: ClusterIP
  clusterIP: None
  publishNotReadyAddresses: true
  ports: [ ...same as main service... ]
  selector:
    {{- include "<chart>.selectorLabels" . | nindent 4 }}
```

Keep the existing regular service for client traffic — don't replace it.

### `container-security-context-user-group-id` — uid/gid below 10000

Two cases:
1. **You control the image / the image is configurable.** Set
   `runAsUser` / `runAsGroup` > 10000 in `containerSecurityContext` and
   `fsGroup` to match for any mounted PVCs.
2. **Image bakes in a low uid (almost always)**. You cannot satisfy the check
   without rebuilding the image. Add an annotation on the workload metadata:
   ```yaml
   annotations:
     kube-score/ignore: container-security-context-user-group-id
   ```
   Include a comment explaining *which* user the image runs as and why it
   can't be changed.

### Helm test pods (`templates/tests/*.yaml`)

Helm test pods are one-shot. Production hardening is overkill. Annotate the
pod with a comprehensive `kube-score/ignore` list:
```yaml
annotations:
  "helm.sh/hook": test-success
  kube-score/ignore: >-
    container-image-tag,
    container-image-pull-policy,
    pod-probes,
    container-resources,
    pod-networkpolicy,
    container-ephemeral-storage-request-and-limit,
    container-security-context-user-group-id
```
Still pin the image tag in `values.yaml` (don't hardcode `:latest`).

## Warnings to leave alone

These are kube-score warnings (not criticals) and the lint script doesn't
fail on them. Don't auto-"fix":

- **`deployment-replicas`** (< 2): Many apps in this repo are stateful or
  use ReadWriteOnce PVCs and can't safely run multiple replicas.
- **`deployment-has-host-podantiaffinity`**: Anti-affinity is only useful
  at replicas ≥ 2.

If you do change replicas for a chart, verify the app supports horizontal
scaling first (check upstream docs, look for `RWX` storage class hints,
session affinity requirements).

## Verifying

After every batch of edits, run:
```sh
helm lint charts/<name>
scripts/kube-score-charts.sh charts/<name>
helm template release charts/<name> >/dev/null
```
The last command catches template errors that `helm lint` misses (lint does
not fully render templates with default values).

## When to stop and ask

- A fix would change an immutable field (StatefulSet `serviceName`,
  Deployment selector, PVC name): pause, explain, ask.
- A fix requires changing the application image: pause, suggest the change,
  ask whether to ignore the check instead.
- kube-score still reports a CRITICAL after two unsuccessful attempts at the
  same finding: pause and ask — there's probably context you're missing.
