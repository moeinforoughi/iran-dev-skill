# Development work log

Append one concise entry for every maintenance task. Record facts and tests, not private reasoning. Do not include credentials, user IPs, private URLs, or secret logs.

## 2026-10-09 — v0.1.0 initial seed

- **Goal:** create a portable Iran-aware coding-agent skill.
- **Changed:** `SKILL.md`, English/Persian READMEs, diagnostic playbook, mirror candidate catalog, community tool inventory, service catalog, offline-first and security guides, source policy, and diagnostic-report template; added `scripts/quick-diagnose.sh`.
- **Data provenance:** mirror/tool list seeds came from user-provided links and community reports; entries were labeled unverified where no independent test was performed.
- **Validation known from initial bundle:** archive was created; comprehensive live mirror validation and ecosystem install tests were not performed.
- **Open gaps:** official repository verification for all tools, live mirror checks, tests/CI, and automatic freshness enforcement.

## 2026-10-09 — v0.1.1 governance and token-efficiency pass

- **Goal:** make purpose, constraints, architecture, priorities and agent handoff rules durable; reduce unnecessary model context and network probes.
- **Changed:** added `AGENTS.md` and `governance/{PROJECT_CHARTER.fa.md,ARCHITECTURE.md,CONTRIBUTING.md,TOKEN_EFFICIENCY.md,TASKS.md,CHANGELOG.md,WORK_LOG.md,DECISIONS.md,README.md}`; updated `SKILL.md` and both READMEs; changed diagnostic script to require explicit target/profile; added offline validator, CI workflow, pull-request template, and CI gate requiring work-log updates.
- **Efficiency policy:** normal diagnosis reads at most 2 references and probes at most 3 distinct external target hosts; broad seven-target baseline requires `--profile all`.
- **Validation results:** `bash scripts/validate-project.sh` passed; shell syntax, CLI help/guardrails, Markdown local links, SKILL frontmatter and YAML syntax (4 files) passed. In an isolated temporary Git repository, `check-governance-update.sh` rejected a change without a work-log update and accepted it after the log was added. Both full-project and standalone governance ZIPs passed `unzip -t`. No live network probes were run for this documentation/script-structure task.
- **Not verified:** current real-world reachability of listed mirrors, tunnels, VPN clients, bot operators, AI provider eligibility and ISP-specific filtering status.
