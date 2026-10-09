# Architecture and current repository map

## Product shape

A portable Agent Skill with a short instruction entry point, on-demand reference documents, small opt-in diagnostics, and machine-readable candidate catalogs. The model makes a narrow choice; scripts measure a narrow fact; records preserve evidence for future runs.

## Current structure

```text
iran-dev-environment/
├── AGENTS.md                         # mandatory instructions for future agents
├── SKILL.md                          # runtime entry point loaded by a compatible agent
├── README.md / README.fa.md          # English/Persian overview and quick start
├── governance/
│   ├── PROJECT_CHARTER.fa.md         # purpose, scope, principles, success metrics
│   ├── ARCHITECTURE.md               # this file: architecture and current state
│   ├── CONTRIBUTING.md               # required workflow and evidence rules
│   ├── TOKEN_EFFICIENCY.md           # token + network budget policy
│   ├── TASKS.md                      # prioritized work with acceptance criteria
│   ├── CHANGELOG.md                  # user-visible and structural changes
│   ├── WORK_LOG.md                   # one entry per development task
│   └── DECISIONS.md                  # architecture decision records
├── references/
│   ├── diagnostic-playbook.md        # error classification and focused checks
│   ├── mirror-catalog.yaml           # mirror candidates; unverified by default
│   ├── tool-inventory.yaml           # community-supplied tool names/versions
│   ├── anti-censorship-tools.md      # taxonomy and verification guide
│   ├── service-catalog.yaml          # developer/API hosts, docs and statuses
│   ├── service-access.md             # network vs account/region/quota distinction
│   ├── offline-first.md              # cache, bundle, resume and offline methods
│   ├── security-and-trust.md         # supply-chain, privacy and third-party risk
│   ├── source-policy.md              # provenance, freshness, confidence and expiry
│   └── sources.md                   # source links and provenance notes
├── scripts/
│   ├── quick-diagnose.sh             # opt-in, bounded HTTPS probes
│   ├── validate-project.sh           # offline structural validation
│   └── check-governance-update.sh    # CI guard for work-log updates
├── .github/
│   ├── workflows/validate.yml       # offline validation + work-log gate
│   └── PULL_REQUEST_TEMPLATE.md     # contribution evidence checklist
└── templates/
    └── diagnostic-report.md          # structured evidence/report template
```

## Intended decision flow

1. **Input:** exact command/error, failing service/host, OS/tool, and user-provided network context.
2. **Classify:** DNS, route/TCP, TLS, HTTP/auth, quota, service policy, registry metadata/content, slow transfer, or provider incident.
3. **Select knowledge:** read only the one or two references that directly address the category.
4. **Probe:** run the smallest discriminating test, within the task's explicit probe budget.
5. **Choose:** fix the narrowest layer; prefer official route, known mirror, app-scoped proxy, cache, then offline fallback as appropriate.
6. **Verify:** one test of the desired outcome; validate content integrity if retrieving artifacts.
7. **Report:** evidence, confidence, applied/proposed change, verification result, rollback, and expiry of any dynamic observation.
8. **Persist:** update a curated catalog only if the result is useful beyond the single task and meets provenance requirements.

## Catalog meaning

- `references/mirror-catalog.yaml` contains **candidate landing pages or documented candidates**, not automatically safe package-manager endpoints.
- `references/tool-inventory.yaml` preserves names and versions from the original user-supplied community roundup. Its version strings and categories are not independent validation.
- `references/service-catalog.yaml` records important service hostnames and official documentation/status pages; it is not a live status API.
- `scripts/quick-diagnose.sh` is a point-in-time read-only transport probe. HTTP reachability does not prove package integrity, account eligibility, or that a VPN tunnel works.

## Current limitations and known gaps

- No continuously refreshed, multi-ISP measurement backend exists.
- Mirror endpoint paths and ecosystem instructions need direct validation, not only landing-page checks.
- The community anti-censorship inventory needs repository, license, supported-platform, release and security review.
- There is no local cache/TTL engine yet; freshness policy is currently documented rather than enforced programmatically.
- No automated ecosystem-level install tests, CI validation, or signed release process existed in the initial `v0.1.0` seed.
- The script measures HTTP(S) reachability only; it does not test UDP, route paths comprehensively, or prove filtering/DNS hijacking.

## Extension rule

Before implementing a feature, check if an existing tool/repository already provides it. Keep the skill useful without an external server. Any optional CLI/MCP or status feed must preserve the bounded-probe behavior, expiry metadata, privacy protections and a static/offline fallback.
