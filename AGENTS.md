# Instructions for AI agents working on this repository

## Mission
Keep software development usable on Iranian networks by giving coding agents a fast, evidence-based, low-token decision layer for diagnosing access failures, choosing trusted alternatives, and continuing offline. This is a decision layer, not a collection of every possible VPN or a replacement for existing tools.

## Non-negotiable rules
1. **Diagnose before changing.** Use the user's exact error and context first. Never label a failure censorship, DNS hijacking, or a nationwide outage without supporting evidence.
2. **Optimize for the user's time and tokens.** Use the fast path in `SKILL.md`; read only the relevant reference(s), never every catalog. Default to at most 2 reference files and 3 distinct external target probes per task. Do not repeat an unchanged test or enumerate all 53 tools.
3. **Prefer zero side effects.** Start with read-only checks. Ask before installing software, changing DNS/routes/proxy/TUN/firewall/package-manager configuration, or creating a tunnel. Keep changes scoped, backed up, and reversible.
4. **Security beats convenience.** Keep TLS verification on, check signatures/checksums where available, treat mirrors/configs/bots as untrusted until verified, and never send secrets or private source to third-party relays.
5. **Separate stable facts from expiring observations.** Network claims need source, UTC timestamp, network scope, method, confidence, and expiry/recheck rule. Unknown or stale is not "working".
6. **Respect service eligibility and terms.** Do not fabricate location/account details or bypass authentication, billing, or access controls. Network reachability is not proof of provider eligibility.
7. **Document every task.** Append a record to `governance/WORK_LOG.md`. Update `governance/TASKS.md` when status changes and `governance/CHANGELOG.md` when behavior, interfaces, data schemas, or user-facing instructions change. Add/update a decision record for meaningful architecture changes.
8. **Validate before claiming success.** Run targeted local tests. Do not perform broad live network tests just to validate documentation. State exactly what was tested and what remains unverified.

## What to read
- Always use this file and the relevant section(s) of `governance/CONTRIBUTING.md`.
- For feature/scope decisions, read `governance/PROJECT_CHARTER.fa.md` and `governance/ARCHITECTURE.md`.
- Before choosing new work, inspect `governance/TASKS.md`.
- Read `governance/TOKEN_EFFICIENCY.md` before changing prompting, diagnostics, network probes, or catalogs.
- Open only the reference file related to the current symptom. Do not bulk-read all `references/` files.

## Definition of done
A change is complete only when: scope and risk are clear; implementation/docs are consistent; relevant tests pass; changed behavior and limitations are recorded in the work log; applicable task/changelog entries are updated; and the final handoff says what changed, test evidence, and known gaps.
