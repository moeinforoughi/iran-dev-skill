# Architecture decision records

## ADR-001 — Skill as a decision layer, not a new VPN client

- **Date:** 2026-10-09
- **Status:** accepted
- **Decision:** keep the core product as portable agent instructions plus reference catalogs and small opt-in scripts. Refer to or integrate existing tools rather than reimplementing clients/protocols.
- **Reason:** the problem is scattered, fast-changing knowledge and poor decision routing; duplicating every project would be expensive and quickly stale.
- **Trade-offs:** the skill depends on external tools for some functions and must verify their source/security before recommendation.

## ADR-002 — Read-on-demand references and bounded probes

- **Date:** 2026-10-09
- **Status:** accepted
- **Decision:** the default agent path should use one or two references and at most three distinct external target probes. Broad baseline testing is explicit, never automatic.
- **Reason:** reduce token, latency and bandwidth use while avoiding test loops that can worsen unstable links.
- **Trade-offs:** broad root-cause investigations may need user-approved additional tests; confidence and scope must be stated.

## ADR-003 — Community data stays unverified until evidence exists

- **Date:** 2026-10-09
- **Status:** accepted
- **Decision:** user-supplied tool versions, Telegram reports and mirror URLs retain unverified/provisional labels until there is provenance and a relevant reproducible check.
- **Reason:** IPs, protocol support, routes and release versions change, and third-party channels may be wrong or stale.
- **Trade-offs:** the catalog is useful as a discovery index but should not present itself as live truth.

## ADR-004 — Local/offline capability remains first-class

- **Date:** 2026-10-09
- **Status:** accepted
- **Decision:** any optional CLI/MCP/status feed must not make core guidance dependent on a reachable cloud service.
- **Reason:** the user problem includes severe outages and international disconnection.
- **Trade-offs:** dynamic data may be missing offline; stale data must be labeled rather than represented as current.
