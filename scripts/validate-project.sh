#!/usr/bin/env bash
# Offline structural checks. No DNS lookups, HTTP requests, or configuration changes.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

required=(
  AGENTS.md SKILL.md README.md README.fa.md
  governance/README.md governance/PROJECT_CHARTER.fa.md governance/ARCHITECTURE.md
  governance/CONTRIBUTING.md governance/TOKEN_EFFICIENCY.md governance/TASKS.md
  governance/CHANGELOG.md governance/WORK_LOG.md governance/DECISIONS.md
  references/diagnostic-playbook.md references/mirror-catalog.yaml
  references/tool-inventory.yaml references/service-catalog.yaml
  references/anti-censorship-tools.md references/offline-first.md
  references/security-and-trust.md references/source-policy.md references/sources.md
  scripts/quick-diagnose.sh scripts/validate-project.sh scripts/check-governance-update.sh
  templates/diagnostic-report.md .github/workflows/validate.yml .github/PULL_REQUEST_TEMPLATE.md
)
missing=0
for f in "${required[@]}"; do
  if [ ! -f "$f" ]; then printf 'FAIL\tmissing file: %s\n' "$f"; missing=1; fi
done
[ "$missing" -eq 0 ] || exit 1

bash -n scripts/quick-diagnose.sh scripts/validate-project.sh scripts/check-governance-update.sh
printf 'PASS\tbash syntax: project scripts\n'

help_output=$(scripts/quick-diagnose.sh --help)
printf '%s' "$help_output" | grep -q -- '--profile github|python|node|docker|ai|baseline' || {
  printf 'FAIL\tdiagnostic usage output\n'; exit 1;
}
printf 'PASS\tdiagnostic --help\n'

set +e
scripts/quick-diagnose.sh >/dev/null 2>&1
no_args_rc=$?
scripts/quick-diagnose.sh --profile nope >/dev/null 2>&1
bad_profile_rc=$?
scripts/quick-diagnose.sh --url http://example.org >/dev/null 2>&1
http_url_rc=$?
scripts/quick-diagnose.sh --url https://a.example --url https://b.example --url https://c.example --url https://d.example >/dev/null 2>&1
four_urls_rc=$?
set -e
[ "$no_args_rc" -eq 2 ] || { printf 'FAIL\tno-arg invocation should refuse broad/implicit probing\n'; exit 1; }
[ "$bad_profile_rc" -eq 2 ] || { printf 'FAIL\tunknown profile should fail\n'; exit 1; }
[ "$http_url_rc" -eq 2 ] || { printf 'FAIL\tnon-HTTPS custom URL should fail\n'; exit 1; }
[ "$four_urls_rc" -eq 2 ] || { printf 'FAIL\tmore than 3 custom URLs should fail\n'; exit 1; }
printf 'PASS\tdiagnostic guardrails (no implicit scan, profile validation, HTTPS-only, max 3 custom URLs)\n'

set +e
scripts/check-governance-update.sh >/dev/null 2>&1
guard_usage_rc=$?
set -e
[ "$guard_usage_rc" -eq 2 ] || { printf 'FAIL\twork-log gate argument validation\n'; exit 1; }
printf 'PASS\twork-log gate argument validation\n'

python3 - <<'PY'
from pathlib import Path
import re
import sys
from urllib.parse import unquote

root = Path.cwd()
errors = []
for md in root.rglob('*.md'):
    if '.git' in md.parts:
        continue
    text = md.read_text(encoding='utf-8')
    # Check regular inline Markdown links that point to local paths.
    for target in re.findall(r'\[[^\]]*\]\(([^)]+)\)', text):
        target = target.strip().split()[0].strip('<>')
        target = unquote(target)
        if not target or target.startswith(('#', 'https://', 'http://', 'mailto:', 'tel:')):
            continue
        path = target.split('#', 1)[0]
        if not path:
            continue
        resolved = (md.parent / path).resolve()
        if not resolved.exists():
            errors.append(f'{md.relative_to(root)}: broken local link: {target}')

skill = (root / 'SKILL.md').read_text(encoding='utf-8')
if not skill.startswith('---\n') or '\nname: iran-dev-environment\n' not in skill:
    errors.append('SKILL.md: missing/invalid frontmatter or name')
if '\nmetadata:\n  version: "0.1.1"\n' not in skill:
    errors.append('SKILL.md: expected version metadata was not found')

if errors:
    print('FAIL\tMarkdown links/frontmatter')
    print('\n'.join(errors))
    sys.exit(1)
print('PASS\tMarkdown local links and SKILL.md frontmatter')

try:
    import yaml
except ImportError:
    print('SKIP\tYAML parsing: PyYAML not installed (no network install attempted)')
else:
    yaml_files = list(root.rglob('*.yaml')) + list(root.rglob('*.yml'))
    for file in yaml_files:
        try:
            yaml.safe_load(file.read_text(encoding='utf-8'))
        except Exception as exc:
            print(f'FAIL\tYAML parse: {file.relative_to(root)}: {exc}')
            sys.exit(1)
    print(f'PASS\tYAML syntax ({len(yaml_files)} files)')
PY

printf 'PASS\toffline structural validation complete; no live network probes performed\n'
