---
name: iran-dev-environment
description: Helps AI coding agents keep software development working on Iranian networks. Use when GitHub, package registries, container images, APIs, downloads, DNS, VPNs, or developer services are slow, filtered, geo-restricted, unstable, or unreachable from Iran, and when planning for limited or offline connectivity.
compatibility: Portable Agent Skills format. Network checks require appropriate shell/network tools; configuration changes and privileged operations require explicit user approval.
metadata:
  version: "0.1.1"
  locale: "fa-IR"
---

# Iran Dev Environment

Help a developer diagnose connectivity and continue their development work under Iranian network constraints. Prefer evidence-driven, reversible, per-tool fixes over generic VPN advice or permanent system changes.

## Operating rules

**Efficiency guardrail:** Start from the exact error already given. Read only the most relevant reference, and a second one only if needed. Do not scan every catalog or list every possible workaround. For a normal task, probe at most 3 distinct external target hosts; use the all-target profile only for an explicitly broad, user-approved baseline. Never repeat an identical test unless an input/network variable changed.

1. **Diagnose before changing anything.** Identify the affected hostname, tool, exact error, operating system, ISP/network type if volunteered, and whether other sites work. Never infer a nationwide block from one failed request.
2. **Separate failure classes.** Distinguish DNS resolution, TCP reachability, TLS/certificate validation, HTTP status, authentication, API quota, provider region policy, package-mirror health, and origin outages. HTTP 401/403/429/5xx are not interchangeable.
3. **Treat Iran network knowledge as time-sensitive.** ISP, province, mobile/fixed network, IPv4/IPv6, port, TCP/UDP, route, and time may change the result. Community reports are leads, not ground truth. Prefer live tests and dated sources.
4. **Use progressive fallbacks.** Try the official endpoint; inspect official status/docs; compare another resolver or route only when safe; test a known mirror; use an app-scoped proxy/tunnel; then use a cached/offline artifact. Pick the smallest change that solves the task.
5. **Measure before selecting.** Compare DNS result, HTTP status, TLS success, latency, throughput where relevant, packet loss, freshness, and trust. Do not call a mirror “working” based only on a successful ping or DNS lookup.
6. **Preserve security.** Do not disable TLS verification, install unknown root certificates, run unreviewed scripts as root, expose tokens, or send private source code to bots or third-party gateways. Verify official checksums/signatures where available.
7. **Ask before side effects.** Do not install VPN clients, edit system DNS/routing, alter global package-manager settings, start a tunnel, or change firewall/system-proxy/TUN settings without telling the user what will change and getting approval.
8. **Make changes reversible.** Back up configuration, prefer project/user-level settings, record the prior state, and provide a rollback command. Never silently leave a temporary proxy enabled.
9. **Respect provider access rules.** For region restrictions, check the provider’s current supported-region documentation and account/API requirements. Explain legitimate connectivity alternatives; do not fabricate location/account details or bypass authentication, billing, or access controls.
10. **Match the user’s language.** If the user asks in Persian, explain findings and commands in Persian unless asked otherwise. Keep protocol names, CLI flags, error text, and package names exact.
11. **Be honest about complete shutdowns.** A VPN or remote proxy cannot restore an international path that is unavailable end-to-end. Check local resources/caches and explain what can and cannot work offline.

## Workflow

### A. Triage the task

- Record the exact command, URL/hostname, error text, and time (with timezone).
- Determine OS, package manager/runtime, ISP/network class, and whether the failure affects one app or many. Ask only for missing information that changes the diagnosis.
- Read [diagnostic-playbook.md](references/diagnostic-playbook.md) only if the exact error does not already determine the first check.
- Run `scripts/quick-diagnose.sh` only with user permission and a narrow target/profile, e.g. `--profile python` for PyPI. Do not use `--profile all` for a single-site failure.

### B. Choose a fix

- For package installs, consult [mirror-catalog.yaml](references/mirror-catalog.yaml), then test the exact ecosystem endpoint from the user's current network. All entries are candidates until tested.
- For VPN/censorship issues, consult [anti-censorship-tools.md](references/anti-censorship-tools.md). Verify the project’s official repository/releases and the exact OS/client before recommending an installation or configuration.
- For API/AI provider failures, consult [service-access.md](references/service-access.md) and use [service-catalog.yaml](references/service-catalog.yaml) to choose a target host. Diagnose transport failures separately from geo/policy/account/quota errors.
- For downloads and interrupted builds, consult [offline-first.md](references/offline-first.md) before repeatedly retrying large transfers.

### C. Verify and report

After a change, rerun the smallest test that demonstrates the desired outcome (for example, install one known package, resolve the registry hostname, or make an unauthenticated request to the intended API endpoint). Compare against the original failure.

Give the user a short report with: observed evidence, likely cause and confidence, attempted fix, measured result, rollback, and remaining limitations. Use [diagnostic-report.md](templates/diagnostic-report.md) when useful.

## Token and network budget

- **Reference budget:** 1 relevant reference by default; 2 for ordinary diagnosis; 3 only for a genuinely cross-layer issue. Use targeted search/grep in catalogs rather than printing entire files.
- **Network budget:** zero probes if no live evidence is needed; otherwise one discriminating target check, one comparison only if it changes the diagnosis, and one verification after a fix. Default maximum: 3 distinct target hosts. Broad baseline is opt-in and may test seven curated hosts.
- **Search budget:** search the web only when a current release, endpoint, region policy, or outage materially changes the answer. Prefer one targeted query and an official source. Do not research every inventory item during unrelated troubleshooting.
- **Output budget:** show only the evidence needed for the decision, one recommended action, and at most one fallback. Do not repeat large logs or catalog data already in the repository.
- **Stop rule:** stop once the acceptance condition is met or three probes do not discriminate the cause. Summarize uncertainty and ask before expanding the investigation.
- Full policy: [TOKEN_EFFICIENCY.md](governance/TOKEN_EFFICIENCY.md).

## Default diagnosis sequence

1. Inspect the error, command, hostname, local clock and relevant proxy variables without making network calls.
2. Choose one high-information check against the exact failing target. Prefer a single HTTP/TLS request with timing fields when that can distinguish the likely causes.
3. If the result is ambiguous, run one comparison that changes a meaningful variable (e.g. another known endpoint, IPv4 vs IPv6, or a resolver). Do not repeat the same test unchanged.
4. Propose the narrowest reversible fix. Get approval before configuration changes or privileged operations.
5. Run one verification of the desired result after a change. Default total: no more than 3 distinct target hosts.
6. If the cause still cannot be distinguished within the budget, summarize the evidence and request permission before running a broader investigation.
7. If international connectivity is absent, use pre-cached dependencies, local mirrors, pre-downloaded artifacts, Git bundles and local docs. Do not claim a remote tunnel will work without a working path to its endpoint.

## Data quality

Every dynamic network claim should carry a source, observation time, scope (ISP/network class/region where known), method, confidence, and expiry/recheck rule. Keep current observations separate from historical reports. See [source-policy.md](references/source-policy.md).
