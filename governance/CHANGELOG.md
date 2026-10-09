# Changelog

## 0.1.1 — governance and efficiency pass (2026-10-09)

- Added agent-facing repository rules and project governance documents.
- Made token/network budgets explicit: targeted reading, at most 3 distinct external targets per normal task, and no broad tests by default.
- Changed `quick-diagnose.sh` from an implicit seven-target scan to an explicit profile or URL selection; `all` must be requested explicitly.
- Added `validate-project.sh` for offline structure checks and GitHub Actions validation.
- Added a CI guard that requires `governance/WORK_LOG.md` to be updated with non-empty changes.
- Updated `SKILL.md` and README instructions to route work through the low-cost diagnostic path.

## 0.1.0 — initial skill seed (2026-10-09)

- Added portable `SKILL.md` entry point and English/Persian README files.
- Added diagnostic playbook, candidate mirror catalog, unverified inventory of 53 community-supplied tool/version entries, service catalog, offline-first guidance, security/trust guidance, and source-freshness policy.
- Added a read-only HTTPS snapshot script and diagnostic report template.
- Important limitation: catalog entries and community-supplied versions were not all independently validated; this release is not a live network status service.
