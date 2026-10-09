# Diagnostic playbook

## 1. Classify the symptom

| Symptom | First hypothesis to test | Next check | Do not conclude yet |
|---|---|---|---|
| `Could not resolve host` / `Temporary failure in name resolution` | Resolver, local DNS, or domain typo | Compare system resolution and a second method; check if unrelated names resolve | Not automatically DNS hijacking or a site block |
| DNS resolves, connection times out | Route, packet loss, port/protocol filtering, unavailable host | Compare TCP connect time, route, another network, and IPv4 vs IPv6 if supported | Not necessarily a domain-level block |
| Connection reset before TLS | Middlebox, route instability, origin reset, protocol/port filtering | Repeat once; compare network, port, destination and timestamp | Not proof of DPI without supporting evidence |
| TLS handshake/certificate error | Wrong clock, interception, hostname mismatch, incomplete chain, proxy | Keep verification on; inspect certificate issuer/SAN and system clock | Never “fix” this by disabling TLS verification by default |
| HTTP 401 | Endpoint is reachable but authentication is missing/invalid | Check token, scope, endpoint, account state | Not a connectivity failure by itself |
| HTTP 403 | Provider policy, region/eligibility, rate/security rule, CDN, auth, or filtering | Read response body/headers safely; check official docs/status and endpoint | Not enough evidence to call it sanctions or censorship |
| HTTP 404 | Wrong path/version/resource, or endpoint not exposing root | Test documented endpoint/version | Host may be reachable even when path is absent |
| HTTP 429 | Quota or rate limiting | Honor `Retry-After` and provider reset windows; reduce concurrency | Do not keep hammering the endpoint |
| HTTP 5xx | Upstream/provider/CDN failure, sometimes intermediary | Official status page, repeated test with bounded backoff | Not automatically local ISP filtering |
| Package manager says package not found | Registry/index/mirror mismatch, stale metadata, wrong package name/version | Test index metadata and exact package path; compare with official index | DNS/HTTP success alone does not validate a mirror's contents |
| Download is slow or stalls | Route/CDN throttling, server load, packet loss, proxy, single-stream limitation | Record DNS/connect/TLS/first-byte/total times; test range/resume if supported | Do not keep restarting a large download from zero |
| AI provider says unsupported location | Actual region eligibility or account/product policy | Check current official supported-country/region documentation and exact product/API | A proxy may not change eligibility, account or contractual requirements |

## 2. Minimal shell checks

Use only when the user permits network diagnostics. Replace `HOST` and `URL` with the actual failing service.

```bash
# DNS through the OS resolver
getent ahosts HOST 2>/dev/null | head
# If available on the system:
dig HOST A +time=2 +tries=1
dig HOST AAAA +time=2 +tries=1

# HTTPS timings with certificate verification left enabled
curl -sS -o /dev/null --connect-timeout 4 --max-time 12 \
  -w 'http=%{http_code} ip=%{remote_ip} dns=%{time_namelookup}s tcp=%{time_connect}s tls=%{time_appconnect}s total=%{time_total}s\n' \
  'https://URL'

# Inspect TLS/certificate details (read-only)
curl -v --connect-timeout 4 --max-time 12 -o /dev/null 'https://URL'

# Show proxy variables without printing embedded credentials
# Inspect variable names, but redact userinfo/tokens before sharing output.
env | grep -iE '^(http|https|all|no)_proxy=' | sed -E 's#(://)[^/@]+:[^/@]+@#\1[REDACTED]@#g'
```

`getent` may be unavailable on macOS; use `dig` or `nslookup`. Do not send full `curl -v` output to a public issue without reviewing it for tokens, cookies, internal hostnames, or proxy credentials.

## 3. DNS mismatch and hijack evidence

- CDN/GeoDNS answers can differ across resolvers and locations. A different IP is not sufficient proof of manipulation.
- Compare query names, record types (A/AAAA/CNAME), TTL, resolver, timestamp, and results from more than one independent path if available.
- Check whether the returned IP serves a valid TLS certificate for the requested hostname. A valid CDN certificate may still be served by many legitimate IPs.
- Record suspected hijack only when evidence supports it; mark it `suspected` and provide the evidence rather than stating it as fact.

## 4. Slow GitHub/release downloads

- Start with the official release asset URL/API and inspect response code/headers and transfer timings.
- Use resuming (`curl -C -`) when the server supports byte ranges; verify the final file size and checksum/signature when published.
- Prefer GitHub CLI or documented API/authentication when rate limits are implicated; obey `Retry-After` and rate-limit reset headers. Avoid repeated blind retries.
- For Git source-only work, consider shallow/filtered clones if appropriate; do not rewrite history or switch remotes without explaining the trade-off.
- A downloader bot or mirror is an untrusted intermediary until the file hash/signature is matched to the publisher's release.

## 5. Timeouts and retries

- Use short connect and overall timeouts for first-pass diagnostics; use resumable, bounded, exponential retries for large downloads.
- Do not retry permanent errors (401, 403, 404, invalid certificates, wrong package name) without changing the relevant input or gathering evidence.
- Respect rate-limit headers. Keep concurrency low on unstable links; aggressive parallel downloads can worsen packet loss and trigger service limits.
- Prefer per-command/per-project overrides and restore the original settings after the task.
