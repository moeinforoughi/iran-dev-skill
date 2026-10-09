# Source, freshness, and confidence policy

Iran-network knowledge decays quickly. Keep long-lived protocol concepts separate from fast-changing observations about hostnames, IP ranges, ISP filters, working tunnel methods, release versions, package mirrors, and API availability.

## Source priority

1. Official provider/project documentation, source repository, signed releases, status/incident pages, and authoritative package index documentation.
2. Reproducible live tests from more than one vantage point, with timestamp, method, ISP/network class, and expected response.
3. Reputable network measurement sources (for example Cloudflare Radar) and independent route/availability measurements.
4. Maintainer/community channel reports with exact timestamp and scope.
5. Unattributed reposts, screenshots, or unverified lists: research leads only.

## Mandatory fields for a dynamic claim

- `claim` and what it affects (host, endpoint, protocol, package ecosystem, app/version).
- `source_url` and whether it is primary, independent telemetry, maintainer/community, or repost.
- `observed_at` with timezone.
- `scope`: ISP/network class/region/ASN when known and voluntarily provided; never generalize a single test to all Iran.
- `method`: DNS query type/resolver, TCP/TLS/HTTP probe, protocol, client version, or measurement source.
- `result`: exact status or error, not just “works/blocked”.
- `confidence`: confirmed, likely, suspected, or unverified, with brief rationale.
- `recheck_after`/expiry. Working IPs, configs, and method-specific claims should expire quickly and be re-tested.

## Suggested expiry defaults (adjust to evidence)

- ISP-specific tunnel/config success: recheck within hours; never treat as generally valid.
- Mirror availability/latency: recheck within 24 hours for an auto-updated status, and immediately before recommending a change.
- Community network incident reports: recheck against independent data as soon as possible; retain as historical once superseded.
- App release/version: verify against the authoritative release page when recommending download/install.
- Long-lived protocol explanation: review on material upstream changes rather than on every daily outage.

These are workflow defaults, not claims about actual update schedules.

## Handling predictions and shutdown rumors

Do not present predictions like “the internet will be fully cut in 24–72 hours” as fact. State the original publisher and uncertainty, compare independent evidence (traffic, BGP/announced address space, reachability from multiple networks, service-specific probes), and distinguish observed symptoms from interpretation. A nationwide disruption may vary by operator, region, protocol, and destination.

## Privacy-preserving reporting

Ask reporters not to publish full subscriber IPs, exact home addresses, account identifiers, VPN subscription strings, or personal credentials. Coarse ISP/network type, province (optional), access technology, test timestamp, test target, and result are usually more useful and less identifying.
