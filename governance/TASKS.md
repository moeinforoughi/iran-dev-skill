# Prioritized tasks and acceptance criteria

Status values: `DONE`, `NEXT`, `PLANNED`, `BLOCKED`. Update this file when task state changes; do not create duplicate tasks for work already listed.

## P0 — correctness and efficiency

- [x] **P0-1 — Establish agent governance and project memory** (`DONE`): `AGENTS.md`, charter, architecture, contributor rules, task board, change log, work log and decision log exist.
- [x] **P0-2 — Bound default diagnostics** (`DONE`): `quick-diagnose.sh` requires a target/profile, uses a small explicit set, has bounded timeouts, and has an explicit all-targets profile.
- [ ] **P0-3 — Validate current seed data** (`NEXT`): check mirror landing pages and official endpoint docs without blindly switching package-manager configuration; record only real results with scope and expiry. Acceptance: each changed catalog status has provenance and reproducible evidence.
- [x] **P0-4 — Add automated structural validation** (`DONE`): `scripts/validate-project.sh` checks required files, SKILL frontmatter, local Markdown links, shell syntax and YAML parsing when PyYAML is available; GitHub Actions runs it without deliberate live probes; a separate CI guard requires the work log to change with each non-empty code/docs diff.

## P1 — practical developer continuity

- [ ] **P1-1 — Ecosystem recipes** (`PLANNED`): add focused, reversible instructions for APT, pip/uv, npm/pnpm, Cargo, Go modules, Maven/Gradle, NuGet, Flutter pub and Docker/OCI. Each recipe needs official syntax, backup/rollback, security caveats and one verification command.
- [ ] **P1-2 — Mirror checker** (`PLANNED`): test a user-selected ecosystem and at most 3 candidates by default. Check TLS, expected metadata/artifact, timing, integrity where available, and expiry. No automatic global config edits.
- [ ] **P1-3 — Offline bootstrap** (`PLANNED`): documented prefetch/cache plan and tests for Git bundle, resumable downloads, Python wheels, npm cache, Go/Cargo dependencies and container image export/import.
- [ ] **P1-4 — Tool inventory provenance** (`PLANNED`): resolve the official repository/platform/license/release source for relevant tools, in batches selected by an active task. Do not mass-verify the list without a use case.

## P2 — platform specificity and evidence quality

- [ ] **P2-1 — Platform playbooks** (`PLANNED`): Linux and WSL first; then Windows native, macOS and Android/Termux as demand requires.
- [ ] **P2-2 — Observation schema and TTL** (`PLANNED`): schema for timestamp, network scope, method, confidence, status, content validation and expiry; stale data must not rank as current.
- [ ] **P2-3 — Tests without live network dependence** (`PLANNED`): mocked curl/http responses, failure classification, timeout/retry behavior, and validation of YAML/schema. Live health checks stay opt-in.

## P3 — optional integration

- [ ] **P3-1 — Local CLI/MCP adapter** (`PLANNED`): expose curated data and local diagnostics to agents without requiring a cloud service; verify it reduces total tokens/calls.
- [ ] **P3-2 — Community contribution intake** (`PLANNED`): structured reports, spam controls, review status and privacy-preserving metadata.
- [ ] **P3-3 — Release discipline** (`PLANNED`): CI, versioning, checksum/signing plan, release notes and security review.

## Definition for moving a task to DONE

A task needs implementation/documentation, observable acceptance criteria, local validation, work-log entry, and changelog/decision updates where applicable. A task is not done merely because files were generated or a URL appears in a catalog.
