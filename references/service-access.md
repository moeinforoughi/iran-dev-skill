# Developer service and API availability

## Separate network reachability from provider eligibility

Before proposing a workaround, determine which failure class applies:

1. **DNS/route/TLS failure:** The request cannot reliably reach the service. Follow the network diagnostic playbook.
2. **HTTP/authentication failure:** The endpoint responds, but the token, scope, account, project, or endpoint may be wrong. Check the official docs and status page.
3. **Quota/rate limit:** Respect `Retry-After` and provider reset windows; reduce concurrency and cache safely.
4. **Region/product availability:** Check the provider's current supported-region documentation for the specific product, API, billing account, and account type.
5. **Terms, sanctions, export-control, or account restrictions:** Do not invent eligibility, identity, residency, billing, or organization details. Explain supported alternatives and let the user make the compliance decision.
6. **Service incident:** Check vendor status pages and independent signals before changing local networking.

## Google Gemini / AI APIs

- Google AI Studio and the Gemini API have an official supported-regions page: https://ai.google.dev/gemini-api/docs/available-regions
- Re-check that page when asked; region lists and service eligibility can change. Gemini web app, AI Studio, Gemini API, Vertex AI/Gemini Enterprise, and third-party hosted APIs may have different availability and terms.
- A network tunnel can alter the apparent route or exit IP, but it does not automatically satisfy account eligibility, billing, identity, export-control, or contractual requirements. Do not promise it will.
- If access is unavailable, consider a provider officially available to the user, a locally hosted model, an approved organization endpoint, or an API gateway the user is authorized to use.
- Never paste API keys into a third-party Telegram bot or unknown web proxy. Use environment variables/secret stores and redact secrets from logs.

## General API workflow

- Confirm exact base URL, API version, auth scheme, endpoint, and whether the call is browser-only or server-side.
- Test an unauthenticated documented endpoint where available; otherwise use a minimal request with a low-privilege test key.
- Save only non-sensitive diagnostic evidence: status, response class, latency, request ID (if safe), and timestamp. Never dump auth headers or full response bodies that may contain personal data.
- Handle `401`, `403`, `404`, `429`, and `5xx` explicitly. Do not retry permanent client errors indiscriminately.
- For proxy-configured SDKs, use the SDK's documented proxy mechanism or environment variables, scoped to that process. Confirm TLS verification remains enabled.

## Current-state evidence sources

- Cloudflare Radar Iran overview (traffic trends, protocols, ASNs and outage/anomaly views): https://radar.cloudflare.com/ir
- Vendor status pages and official region docs should take precedence for product eligibility.
- Community telemetry can help identify a hypothesis, but it is not a substitute for a test from the user's ISP.
