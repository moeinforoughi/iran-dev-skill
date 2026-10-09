#!/usr/bin/env bash
# Bounded, read-only HTTPS reachability checks. No system configuration is changed.
# One profile/URL means at most one HTTPS request per listed target (redirects are not followed).
set -u

usage() {
  cat <<'USAGE'
Usage:
  quick-diagnose.sh --profile github|python|node|docker|ai|baseline
  quick-diagnose.sh --url https://host/path
  quick-diagnose.sh --help

Profiles:
  github    github.com + api.github.com (2 targets)
  python    PyPI package index (1 target)
  node      npm registry metadata (1 target)
  docker    Docker Hub Registry API (1 target; HTTP 401 can be expected)
  ai        Google AI/Gemini documentation reachability (1 target; not API/account validation)
  baseline  GitHub + PyPI only (2 targets)
  all       All seven curated targets; use only for an explicitly broad diagnostic

Rules:
  - HTTPS URLs only. Do not pass secret, signed, authenticated, or private URLs.
  - At most three custom --url options are allowed per invocation.
  - One request is attempted per target; redirects are not followed.
  - This script does not prove filtering, DNS hijacking, mirror integrity, or provider eligibility.
USAGE
}

if ! command -v curl >/dev/null 2>&1; then
  printf 'ERROR\tcurl is required\n' >&2
  exit 2
fi

profile=''
urls=()
while [ "$#" -gt 0 ]; do
  case "$1" in
    --profile)
      [ "$#" -ge 2 ] || { usage >&2; exit 2; }
      profile=$2; shift 2 ;;
    --url)
      [ "$#" -ge 2 ] || { usage >&2; exit 2; }
      urls+=("$2"); shift 2 ;;
    --help|-h)
      usage; exit 0 ;;
    *)
      printf 'ERROR\tunknown argument: %s\n' "$1" >&2
      usage >&2; exit 2 ;;
  esac
done

if [ -n "$profile" ] && [ "${#urls[@]}" -gt 0 ]; then
  printf 'ERROR\tchoose either --profile or --url, not both\n' >&2; exit 2
fi
if [ -z "$profile" ] && [ "${#urls[@]}" -eq 0 ]; then
  usage >&2
  exit 2
fi
if [ "${#urls[@]}" -gt 3 ]; then
  printf 'ERROR\tmaximum three custom URLs per invocation; use a narrow profile\n' >&2
  exit 2
fi

case "$profile" in
  '') ;;
  github)
    urls=('https://github.com/' 'https://api.github.com/') ;;
  python)
    urls=('https://pypi.org/simple/pip/') ;;
  node)
    urls=('https://registry.npmjs.org/npm') ;;
  docker)
    urls=('https://registry-1.docker.io/v2/') ;;
  ai)
    urls=('https://ai.google.dev/gemini-api/docs/available-regions') ;;
  baseline)
    urls=('https://github.com/' 'https://pypi.org/simple/pip/') ;;
  all)
    urls=('https://github.com/' 'https://api.github.com/' 'https://raw.githubusercontent.com/' 'https://pypi.org/simple/pip/' 'https://registry.npmjs.org/npm' 'https://registry-1.docker.io/v2/' 'https://ai.google.dev/gemini-api/docs/available-regions') ;;
  *)
    printf 'ERROR\tunknown profile: %s\n' "$profile" >&2
    usage >&2; exit 2 ;;
esac

printf 'Iran Dev Environment — bounded HTTPS diagnostic\n'
printf 'timestamp_utc\t%s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ' 2>/dev/null || date)"
printf 'profile\t%s\n' "${profile:-custom}"
printf 'target_count\t%s\n' "${#urls[@]}"
printf 'host\thttp_code\tremote_ip\tdns_s\ttcp_s\ttls_s\ttotal_s\tcurl_exit\n'

for url in "${urls[@]}"; do
  case "$url" in
    https://*) ;;
    *) printf 'ERROR\tcustom URL must use https:// (target skipped)\n' >&2; exit 2 ;;
  esac
  authority=${url#https://}
  host=${authority%%/*}
  host=${host%%\?*}
  host=${host%%#*}
  if [ -z "$host" ] || [[ "$host" == *'@'* ]]; then
    printf 'ERROR\tURL must have a hostname and no embedded credentials (target skipped)\n' >&2
    exit 2
  fi
  result=$(curl --silent --show-error --output /dev/null \
    --range 0-0 --max-filesize 4096 --connect-timeout 3 --max-time 8 \
    --max-redirs 0 \
    --write-out '%{http_code}|%{remote_ip}|%{time_namelookup}|%{time_connect}|%{time_appconnect}|%{time_total}' \
    "$url" 2>/dev/null)
  curl_rc=$?
  [ -n "$result" ] || result='000|||||'
  IFS='|' read -r http_code remote_ip dns_time tcp_time tls_time total_time <<< "$result"
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "$host" "${http_code:-000}" "${remote_ip:-}" \
    "${dns_time:-}" "${tcp_time:-}" "${tls_time:-}" "${total_time:-}" "$curl_rc"
done

printf '\nInterpretation: this is a point-in-time HTTP(S) observation from this machine and route.\n'
printf 'HTTP status is endpoint-specific; e.g. 401 from Docker Hub /v2/ can be expected.\n'
printf 'Different DNS answers alone do not prove hijacking; TLS/HTTP success does not prove content integrity or API eligibility.\n'
