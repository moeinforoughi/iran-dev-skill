#!/usr/bin/env bash
# CI guard: every non-empty code/docs change must include a work-log entry.
# Usage: check-governance-update.sh <base-ref> [head-ref]
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  printf 'Usage: %s <base-ref> [head-ref]\n' "$0" >&2
  exit 2
fi
base=$1
head_ref=${2:-HEAD}

if ! git rev-parse --verify "$base^{commit}" >/dev/null 2>&1; then
  printf 'SKIP\tbase commit is unavailable; governance-diff check cannot run\n'
  exit 0
fi
if ! git rev-parse --verify "$head_ref^{commit}" >/dev/null 2>&1; then
  printf 'ERROR\thead commit is unavailable: %s\n' "$head_ref" >&2
  exit 2
fi

changed=$(git diff --name-only "$base" "$head_ref")
if [ -z "$changed" ]; then
  printf 'PASS\tno changed files\n'
  exit 0
fi

if printf '%s\n' "$changed" | grep -Fxq 'governance/WORK_LOG.md'; then
  printf 'PASS\tgovernance/WORK_LOG.md included in changed files\n'
  exit 0
fi

printf 'FAIL\tproject changes require an update to governance/WORK_LOG.md\n' >&2
printf '%s\n' "$changed" | sed 's/^/  changed: /' >&2
exit 1
