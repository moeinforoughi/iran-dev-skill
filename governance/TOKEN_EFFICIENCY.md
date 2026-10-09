# Token and diagnostic efficiency policy

The product should save more developer time and model tokens than it consumes. Do not turn each connectivity issue into an open-ended research project.

## Fast path (default)

1. Parse the exact error and command already supplied. Do not ask for context the user already gave.
2. Classify the failure from the error before testing.
3. Read **one** relevant reference; read a second only if the first does not answer the next step.
4. Run the single check with the highest information value. If needed, run one comparison and one post-fix verification. Default limit: **3 distinct external target probes per task**.
5. Offer one best next action and at most one fallback. Do not dump every possible tool or protocol.
6. Stop once the acceptance condition is met. Do not test unrelated destinations "for completeness".

## Reference routing (do not bulk-load)

| Symptom/task | Read first | Usually avoid |
|---|---|---|
| DNS/TLS/HTTP/timeout | `references/diagnostic-playbook.md` | Full tool inventory, all mirror entries |
| One package install or registry failure | Relevant section of `references/mirror-catalog.yaml` | Testing every mirror and ecosystem |
| Download/build interrupted | `references/offline-first.md` | Retrying from byte zero without checking resume/cache |
| AI/API call failure | `references/service-access.md`; inspect only target in `service-catalog.yaml` | Reading all provider entries or assuming a VPN fixes policy errors |
| User asks for an anti-censorship client | `references/anti-censorship-tools.md`, then verify one matching official repository | Reading all 53 names and recommending them all |
| Add/update shared knowledge | `references/source-policy.md` plus the target catalog | Re-reading all playbooks |
| Third-party artifact/bot/tunnel | `references/security-and-trust.md` | Uploading private data to test it |

## Network request budget

- No user-visible problem or no need for current network evidence: run **zero** probes.
- Specific host/command failure: test the specific target first; normally one probe, then one changed comparison, then one verification if a change is made.
- Broad baseline request: use an explicit profile. `--profile all` can probe up to seven listed hosts and should not run by default.
- Never loop over every mirror, ISP, IP range, protocol, or tool without explicit user consent and a test plan.
- Respect `Retry-After`; do not retry 401/403/404, invalid TLS, wrong package names, or policy errors without new evidence/input.
- Use connect timeout 3 seconds and total timeout 8 seconds for the lightweight probe unless the target/task needs a justified different value.
- Use cached results only while their scope and expiry match the present environment. Do not label old observations as live.

## Browsing and tool discovery

- Search only if current facts materially affect the answer (release status, endpoint, region policy, current incident or a new tool). Prefer one focused search query and official source.
- Do not web-search every named tool in the inventory during unrelated troubleshooting.
- Resolve the official repository/release once, record it, and reuse it until freshness rules require re-checking.
- Avoid copying large webpages or logs into the model context. Extract the relevant fields and cite/source-link the original.

## Output economy

- Return the observed fact, likely cause/confidence, one proposed action, one verification step, and rollback if applicable.
- Do not repeat the user's complete logs or reproduce catalog rows already in the repository.
- For tool failures, include only the few relevant lines, not entire command output.
- Store reusable findings once in the proper catalog/log; avoid creating near-duplicate reference files.
- Use structured YAML for machine-readable data and concise Markdown for policy. Do not put volatile status claims in the long-lived `SKILL.md` prompt.

## Token-efficiency acceptance criteria for new features

Every new automated feature must explain: (a) which repeated work it removes, (b) how many model/tool/network calls it avoids or adds, (c) its cache/freshness strategy, and (d) its worst-case work budget. Features that make agents scan all entries by default should be rejected or redesigned.
