---
name: harden-pss-restricted
description: Make a single chart under `charts/<name>` comply with the Pod Security Standards "restricted" profile. Adds `podSecurityContext` and `containerSecurityContext` defaults to `values.yaml`, wires them into every pod-spec template, and patches in-repo subchart values (postgresql, redis) so their pods also satisfy PSS restricted. Verifies with `helm template`, `scripts/helm-lint-charts.sh <chart>`, and `scripts/kube-score-charts.sh <chart>`, then bumps the chart version. Use when the user asks to "make this chart PSS restricted", "harden the chart", "add restricted pod security", or names a chart and says "make it pass restricted".
---

# harden-pss-restricted

Given a single chart directory (e.g. `charts/foo`), retrofit Pod Security
Standards *restricted*-profile defaults onto every pod template in the chart
(top-level templates and locally-bundled subcharts where the values surface
allows it). Preserve existing behavior — do not change image UIDs, do not
add `readOnlyRootFilesystem`, do not touch init containers that legitimately
need a capability. Bump the chart `version` in `Chart.yaml` after the last
edit.

## Inputs

The user invokes this skill with a chart path. If they don't supply one, ask:
"Which chart? (e.g. `charts/cryptpad`)". Do not guess — pick the chart only
from explicit user input.

## What "PSS restricted" means here

The Kubernetes PSS *restricted* profile (see
<https://kubernetes.io/docs/concepts/security/pod-security-standards/>)
requires every pod and container to set:

- `runAsNonRoot: true` (at pod or container level)
- `allowPrivilegeEscalation: false`
- `capabilities.drop: ["ALL"]` (must include `ALL`; may add more)
- `seccompProfile.type: RuntimeDefault` or `Localhost` (at pod or container level)
- No `hostNetwork`, `hostPID`, `hostIPC`, `hostPath` volumes, privileged containers
- Volume types limited to a safe set (configMap, secret, projected, emptyDir,
  ephemeral, persistentVolumeClaim, etc.)

This skill only adds the four `securityContext` fields. The other constraints
are structural — flag them to the user if you spot a violation in the chart
(don't silently delete a `hostPath` mount or `hostNetwork: true`; pause and
ask).

`readOnlyRootFilesystem` is **not** required by PSS restricted. The repo's
`kube-score-charts.sh` already ignores that test (`--ignore-test
container-security-context-readonlyrootfilesystem`). Don't add it.

## Workflow

1. **Survey.** Read `charts/<name>/values.yaml` and every file under
   `charts/<name>/templates/`. List every workload that owns a pod spec —
   `Deployment`, `StatefulSet`, `DaemonSet`, `Job`, `CronJob`,
   `ReplicaSet`. Note all containers and init containers per workload.
   Also inspect `charts/<name>/Chart.yaml` for `dependencies:` and check
   each subchart's values surface (look at `charts/<name>/charts/*/values.yaml`
   if vendored, or the chart in this repo at `charts/<subchart>/values.yaml`).
2. **Baseline render.** Run `helm template release charts/<name>
   2>&1 | grep -B1 -A 20 "securityContext"` to see what's already set and
   what's missing. Always run this **before** editing — sometimes the chart
   already has a `containerSecurityContext` values key, in which case extend
   it rather than create a parallel one.
3. **Plan.** Tell the user in 3–6 lines what you intend to change. Specifically
   call out:
   - Whether you'll add a chart-wide `podSecurityContext` /
     `containerSecurityContext` or reuse existing per-component ones.
   - Whether you'll set `runAsUser` (only if no `runAsUser` exists AND the
     image is known to accept arbitrary UIDs — otherwise rely on the image's
     `USER` directive and only set `runAsNonRoot: true`).
   - Any init containers that need to keep elevated capabilities (e.g. a
     `fix-permissions` init container that chowns a PVC needs `runAsUser: 0`
     and `capabilities.add: [CHOWN]` — leave it intact and document why).
   - Any in-repo subchart values that need updating.
4. **Apply.** Edit `values.yaml` and pod-spec templates.
5. **Verify.**
   - `helm template release charts/<name> >/dev/null` — catches template
     errors.
   - `helm template release charts/<name> 2>&1 | grep -B1 -A 12
     "^      securityContext:"` — eyeball every pod and confirm
     `runAsNonRoot`, `seccompProfile`, `allowPrivilegeEscalation`,
     `capabilities.drop` are present.
   - `scripts/helm-lint-charts.sh charts/<name>` — must exit 0.
   - `scripts/kube-score-charts.sh charts/<name>` — must exit 0 (warnings OK).
6. **Bump version.** Patch bump (`0.X.Y+1`) — this is an additive,
   backwards-compatible change. Use a minor bump only if you had to remove or
   rename an existing values key.
7. **Report.** 5–10 bullets summarizing the edits and any caveats (e.g.
   "image runs as baked-in UID 1000 — `runAsUser` deliberately not set").

## Defaults to add

Use these exact defaults in `values.yaml`. They are the minimum required for
PSS restricted and they don't pin a UID, so they work with images that bake
in their own non-root user. The comment is part of the contract — keep it.

```yaml
# Pod- and container-level securityContext applied to every workload pod
# in this chart. Defaults satisfy the Pod Security Standards "restricted"
# profile:
# https://kubernetes.io/docs/concepts/security/pod-security-standards/
#
# Many upstream images bake in their own non-root UID/GID and do not accept
# arbitrary uids, so `runAsUser`/`runAsGroup` are deliberately omitted —
# the container starts as the image's USER. `runAsNonRoot: true` enforces
# non-root at admission time.
podSecurityContext:
  runAsNonRoot: true
  seccompProfile:
    type: RuntimeDefault
containerSecurityContext:
  allowPrivilegeEscalation: false
  runAsNonRoot: true
  capabilities:
    drop:
      - ALL
  seccompProfile:
    type: RuntimeDefault
```

If the chart already has per-component blocks (e.g. `web.securityContext`,
`worker.securityContext`), prefer top-level defaults and have each template
reference the shared keys. Only fall back to per-component blocks if
different components legitimately need different settings — that's rare for
PSS restricted because the fields are not workload-specific.

## Wiring into templates

For each pod-spec template, insert two blocks:

```yaml
    spec:
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
        - name: <container>
          image: <...>
          imagePullPolicy: <...>
          securityContext:
            {{- toYaml .Values.containerSecurityContext | nindent 12 }}
          ...
```

Indentation matters — `nindent 8` for pod-level (under `spec:`), `nindent 12`
for container-level (under `containers[*]`). For a `CronJob`, the pod spec
lives at `spec.jobTemplate.spec.template.spec` — use `nindent 14` for
pod-level there.

If a workload has multiple containers, apply `containerSecurityContext` to
each. If a container has a security-relevant reason to differ (e.g. it
must run as root), apply it anyway and override the offending field
explicitly:

```yaml
          securityContext:
            {{- toYaml .Values.containerSecurityContext | nindent 12 }}
            runAsNonRoot: false
            runAsUser: 0
```

This pattern is rare and should be documented with a comment.

## Init containers

Init containers are not exempt from PSS restricted — they must comply too.
Two common patterns:

1. **Permission-fixing init container** (e.g. `chown -R 1000:1000 /data`):
   needs `runAsUser: 0`, `runAsNonRoot: false`, and a single capability
   (`CHOWN`). PSS restricted *allows* containers that drop ALL and add a
   single named capability, but it requires `runAsNonRoot: true`. So a
   chowning init container **does** violate PSS restricted. Two options:
   - Leave the init container as-is and tell the user the namespace must
     either run as PSS *baseline* or grant a per-pod exception.
   - Replace the chown with `fsGroup` at the pod level (works for many
     PVCs and is PSS-restricted-compliant).

   Prefer the second option when the volume supports `fsGroup` (most CSI
   drivers do). Add to `podSecurityContext`:
   ```yaml
   podSecurityContext:
     runAsNonRoot: true
     fsGroup: <image-uid>
     fsGroupChangePolicy: OnRootMismatch
     seccompProfile:
       type: RuntimeDefault
   ```
   Then delete the `fix-permissions` init container. Mention this clearly
   in the report — it's a behavior change.

2. **Migration / DB-init init container** that runs the app image: apply
   `containerSecurityContext` and call it a day.

## Subcharts

Subcharts have their own pod specs and their own security contexts. You
can't edit subchart templates directly (they're vendored as `.tgz`), but you
can patch their behavior through the parent `values.yaml`.

The two recurring subcharts in this repo (`postgresql`, `redis` from
`https://ethdevops.github.io/helm-charts`) accept `securityContext` and
`podSecurityContext` keys. The harden pattern for them:

```yaml
postgresql:
  enabled: true
  # ... existing config ...
  securityContext:
    runAsUser: 10001
    runAsNonRoot: true
    allowPrivilegeEscalation: false
    capabilities:
      drop:
        - ALL
    seccompProfile:
      type: RuntimeDefault
  podSecurityContext:
    fsGroup: 10001
    runAsGroup: 10001
    seccompProfile:
      type: RuntimeDefault

redis:
  enabled: true
  # ... existing config ...
  securityContext:
    allowPrivilegeEscalation: false
    runAsNonRoot: true
    runAsUser: 10001
    capabilities:
      drop:
        - ALL
    seccompProfile:
      type: RuntimeDefault
  podSecurityContext:
    fsGroup: 10001
    seccompProfile:
      type: RuntimeDefault
```

If the subchart has additional dropped capabilities (e.g. `SYS_ADMIN`,
`NET_ADMIN`, `SYS_PTRACE`) keep them — they're stricter than required.

For Bitnami subcharts: keys are usually `primary.podSecurityContext`,
`primary.containerSecurityContext`, `master.podSecurityContext`, etc. —
check the subchart's `values.yaml` for the exact path before patching.

## Constraints

- Defaults must make a fresh `helm install` PSS-restricted compliant — don't
  ship a values key that's off by default.
- Don't change image UIDs unless the user asks. Many upstream images bake in
  a specific non-root UID; setting `runAsUser` to a different value will
  break them at startup.
- Don't add `readOnlyRootFilesystem` — PSS restricted doesn't require it and
  many apps write to `/tmp` or `/var/cache`. The repo's kube-score config
  already ignores this check.
- Don't refactor unrelated code. Touch only what's needed for PSS.
- Don't delete a `hostPath` mount, `hostNetwork: true`, or privileged
  container to "make it pass". Pause and ask — these are intentional and
  the chart genuinely cannot run under PSS restricted as-is.
- Preserve `kube-score/ignore` annotations on workloads. They exist for
  reasons unrelated to PSS.

## Verifying

After edits, run:
```sh
helm template release charts/<name> >/dev/null
helm lint charts/<name>
scripts/kube-score-charts.sh charts/<name>
```

Then spot-check the rendered output — every pod spec in the chart (and the
subchart pods you patched) must show all four restricted fields:

```sh
helm template release charts/<name> 2>&1 \
  | awk '/^kind: (Deployment|StatefulSet|DaemonSet|Job|CronJob)/,/^---$/' \
  | grep -B1 -A 12 "securityContext:"
```

Every container block should include `allowPrivilegeEscalation: false`,
`runAsNonRoot: true`, `capabilities.drop` containing `ALL`, and
`seccompProfile.type: RuntimeDefault`. Every pod spec should include
`runAsNonRoot: true` and `seccompProfile.type: RuntimeDefault`.

If a feature-flagged component is off by default (e.g. `ai.enabled: false`,
`search.enabled: false`), also render with it enabled to confirm:
```sh
helm template release charts/<name> --set ai.enabled=true --set search.enabled=true
```

## When to stop and ask

- The chart contains a `hostPath` volume, `hostNetwork: true`, `hostPID:
  true`, privileged container, or a `securityContext.capabilities.add`
  beyond `NET_BIND_SERVICE`: pause, explain why it's incompatible with PSS
  restricted, ask whether to drop the feature or accept that the chart
  cannot run under restricted.
- The chart has a `fix-permissions` init container that runs as root and
  the user hasn't authorized switching to `fsGroup`: pause, propose the
  swap, ask.
- An image is known to require root (database backup jobs, some monitoring
  agents): pause, ask whether to (a) skip the workload, (b) drop privileges
  and accept that the image will fail at runtime, or (c) declare the chart
  as PSS *baseline* not *restricted*.
- After applying defaults, a pod fails to start in the user's test cluster
  with `container has runAsNonRoot and image will run as root`: the image's
  USER is root or unset. Don't try to "fix" by setting a `runAsUser` —
  surface the finding and let the user pick a UID that the image tolerates.
