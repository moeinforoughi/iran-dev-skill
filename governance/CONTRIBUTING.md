# Contribution workflow for humans and AI agents

## Mandatory start

1. Read `../AGENTS.md` and this document.
2. Read the relevant task in `TASKS.md`; do not invent duplicate work before checking existing entries.
3. Open only the reference(s) relevant to the task. Read `PROJECT_CHARTER.fa.md`/`ARCHITECTURE.md` only when scope or design is affected.
4. State a tiny internal plan: problem, files likely to change, smallest validation. Avoid exploratory work unrelated to the requested task.

## Mandatory workflow

1. **Define the result.** Use an observable acceptance criterion rather than "improve things".
2. **Inspect before adding.** Search existing files, scripts and candidate tools. Prefer a narrow patch; do not rewrite the repository for style alone.
3. **Use a bounded evidence budget.** Normal task: at most 3 distinct external probe targets, at most 2 reference files, and one targeted external search if live facts truly matter. Use `--profile all` only when the task is broad and the user has approved a broad test. Never repeat an identical probe unless a variable changed.
4. **Protect secrets.** Redact tokens, cookies, auth headers, signed URLs and proxy credentials from logs. Never send private code or credentials to Telegram bots or unknown relays.
5. **Keep changes reversible.** Prefer project-local config; back up files before changing configuration; supply rollback details. Ask before privileged/system-level operations.
6. **Validate locally first.** Check Markdown links/relative paths where practical, YAML syntax if a parser is available, `bash -n` for shell scripts, and archive/package structure when relevant. Live network validation must be targeted and described as time-scoped evidence.
7. **Record the work.** Append to `WORK_LOG.md` on every development task, even if the implementation is documentation-only. `scripts/check-governance-update.sh` is wired into CI and fails a non-empty PR/push diff if the work log was not changed. Mark completed/blocked tasks in `TASKS.md`. Update `CHANGELOG.md` for user-visible behavior, data schema, instructions, or compatibility changes. Add a decision record for meaningful architecture choices.
8. **Finish with a concise handoff.** State files changed, tests actually run, network probe count if any, limitations, and one next step at most. Never claim tests passed if they were not run.

## Catalog entry acceptance

Before changing a `verification` field from `unverified`, a reviewer must see:

- canonical project/provider URL and provenance;
- exact endpoint or repository path and intended ecosystem;
- UTC timestamp and test scope (coarse ISP/network class/region only if volunteered);
- TLS verification result and appropriate metadata/content check;
- checksum/signature verification when artifact integrity matters;
- latency/throughput only when measured;
- confidence and an expiry/recheck rule;
- known limitations and licensing/terms concerns.

A home page opening is not sufficient to mark a package mirror verified. One ISP's result is not a nationwide claim. Do not store personal IP addresses or raw secrets in public records.

## Definition of done

- [ ] Acceptance criterion satisfied or explicitly blocked.
- [ ] Patch is limited to necessary files; no unrelated churn.
- [ ] Targeted validation run and accurately reported.
- [ ] `WORK_LOG.md` appended.
- [ ] `TASKS.md` updated when status changed.
- [ ] `CHANGELOG.md` updated if user-visible behavior/instructions/schema changed.
- [ ] Security, data freshness and rollback considered.
- [ ] Token/network budget was respected or deviation justified.
