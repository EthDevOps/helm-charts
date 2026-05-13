#!/usr/bin/env bash
# Runs `helm lint` against each given chart directory.
#
# Usage:
#   helm-lint-charts.sh <chart-dir> [<chart-dir>...]
#   helm-lint-charts.sh --from-files <file> [<file>...]
#
# In --from-files mode, file paths are mapped to their owning chart directory
# (charts/<name>/) and deduplicated. Paths outside charts/ are ignored.
set -euo pipefail

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
  echo "helm-lint: no charts to check."
  exit 0
fi

failed=0
for chart in "${chart_dirs[@]}"; do
  echo "==> helm lint ${chart}"
  if ! helm lint "${chart}"; then
    failed=1
  fi
done
exit "${failed}"
