#!/usr/bin/env bash
# Renders each chart with `helm template` and pipes the result to `kube-score`.
# Fails on kube-score CRITICAL findings (default kube-score behavior).
#
# Usage:
#   kube-score-charts.sh <chart-dir> [<chart-dir>...]
#   kube-score-charts.sh --from-files <file> [<file>...]
#
# Tune which kube-score tests run by editing KUBE_SCORE_FLAGS below, or by
# adding `kube-score/ignore: <test>` annotations to specific manifests. For
# per-chart skips (e.g. unreachable subchart findings), drop a
# `.kubescore-ignore` file in the chart dir with one test name per line.
set -euo pipefail

KUBE_SCORE_FLAGS=(
  # Treat warnings as informational; only CRITICAL findings fail the run.
  --exit-one-on-warning=false
  # PSS-restricted does not require a read-only root FS; cryptpad and others
  # write to the rootfs at startup, so skip that check by default.
  --ignore-test container-security-context-readonlyrootfilesystem
)

derive_chart_dirs() {
  local dirs=()
  for f in "$@"; do
    if [[ "$f" =~ ^charts/([^/]+)/ ]]; then
      dirs+=("charts/${BASH_REMATCH[1]}")
    fi
  done
  if ((${#dirs[@]})); then
    printf "%s\n" "${dirs[@]}" | sort -u
  fi
}

if [[ "${1:-}" == "--from-files" ]]; then
  shift
  mapfile -t chart_dirs < <(derive_chart_dirs "$@")
else
  chart_dirs=("$@")
fi

if ((${#chart_dirs[@]} == 0)); then
  echo "kube-score: no charts to check."
  exit 0
fi

build_deps() {
  local chart="$1"
  # Only run when the chart declares dependencies; otherwise it's a no-op.
  if grep -q '^dependencies:' "${chart}/Chart.yaml" 2>/dev/null; then
    helm dependency build "${chart}" >/dev/null 2>&1 \
      || helm dependency update "${chart}" >/dev/null
  fi
}

failed=0
for chart in "${chart_dirs[@]}"; do
  echo "==> kube-score ${chart}"
  if ! build_deps "${chart}"; then
    echo "kube-score: dependency build failed for ${chart}, skipping" >&2
    failed=1
    continue
  fi
  rendered=$(helm template release "${chart}" 2>&1) || {
    echo "${rendered}"
    echo "kube-score: helm template failed for ${chart}, skipping" >&2
    failed=1
    continue
  }
  chart_flags=()
  if [[ -f "${chart}/.kubescore-ignore" ]]; then
    while IFS= read -r line; do
      line="${line%%#*}"
      line="${line//[[:space:]]/}"
      [[ -z "${line}" ]] && continue
      chart_flags+=(--ignore-test "${line}")
    done < "${chart}/.kubescore-ignore"
  fi
  if ! printf "%s\n" "${rendered}" | kube-score score "${KUBE_SCORE_FLAGS[@]}" "${chart_flags[@]}" -; then
    failed=1
  fi
done
exit "${failed}"
