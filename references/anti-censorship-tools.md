# Anti-censorship and tunnel tooling: discovery catalogue

**This is a discovery and verification guide, not an endorsement list or live connectivity guarantee.** Tool names and versions in community posts can be stale, forked, impersonated, or specific to one ISP/protocol. Prefer the publisher's source repository and releases; inspect signature/checksum, license, permissions, update cadence, issues, and reproducible build claims.

## Practical taxonomy

| Category | Typical role | Examples to investigate | Agent behavior |
|---|---|---|---|
| General client apps | Import and manage multiple proxy/tunnel profiles | Hiddify, Karing, v2rayN, v2rayNG, Happ, ZedSecure, DefyxVPN, MahsaNG | Verify OS, official release, supported core/protocol, and whether system-wide TUN needs elevation |
| VPN/tunnel protocols | Carry traffic through a reachable endpoint | WireGuard, OpenVPN, OpenConnect, IKEv2, AmneziaWG, SSH tunnels, Xray/sing-box-based transports | Explain the TCP/UDP and network trade-offs; never assume a protocol is currently reachable on every ISP |
| DNS tools / DNS tunnels | Resolver selection, encrypted DNS, or tunnelling traffic through DNS | finDns, NoizDNS, DnsTunEzpz, DnsTtXyz, vayDNS, MasterDns, whiteDNS, Begzar | Distinguish ordinary DNS, DoH/DoT, anti-sanction resolvers, and DNS tunnelling; test resolution and TLS separately |
| CDN/edge-based methods | Use an edge provider or a user-controlled worker/origin as a transport path | Cloudflare Worker/CDN configurations, WARP/MASQUE-related clients, Aether | Require a current, dated test; a Cloudflare hostname or IP alone does not prove a route will work |
| DPI/network test utilities | Measure candidate IPs, DNS behavior, TLS or route behavior | SenPaiScanner, CFScanner, rangeScout, networkChecker, SniSpoofing, SniSpoofingRust, spoofGUI | Keep probing bounded and user-authorized; use results as network-specific observations, not universal configuration |
| Protocol/relay utilities | Implement or chain a transport, relay, or tunnel | SlipstreamPlus, SlipStreamGUI, slipGate, MasterHttpRelayRust, tunnelForge, tunnelX, SlipNet | Review repository and threat model before suggesting; do not assume function from the project name |
| Privacy/alternative routing tools | Tor, Psiphon, inviZible Pro, onionHop | Tor Browser/project, Psiphon, inviZible Pro | Explain performance and availability limitations; only use official distribution channels |
| Download/relay helpers | Fetch public artifacts through an intermediary | PersianGithubMirror channel; Telegram bots listed below | Public files only unless the destination and operator are trusted; verify artifact hash/signature independently |

## Seed inventory from community reports

The following names were included in a user-provided update roundup dated around 2026-10-08. The supplied versions are **not independently verified here** and must not be treated as current. The first implementation should resolve each item to its authoritative repository, license, platforms, release page, category, and last verified date before providing operational instructions.

- **Client/proxy manager candidates:** OblivionDesktop, IRBox, GNet, Kabootar, Pigeon, Shade, Zemzeme, Loole, ShiroKhorshid, nipoVpn, tunnelX, tunnelForge, SlipNet, v2rayNG, v2rayN, Hiddify, Happ, Karing, ZedSecure, DefyxVPN, MahsaNG, Amnezia, xrayKnife, pyWarp, inviZiblePro.
- **DNS candidates:** finDns, DnsTtXyz, NoizDNS, DnsTunEzpz, vayDNS, stormDNS, MasterDns, vayDnsClient, whiteDNS, Begzar.
- **Scanner/diagnostic candidates:** rangeScout, CFScanner, networkChecker, senPaiScanner, SniSpoofing, SniSpoofingRust, spoofGUI.
- **Relay/tunnel/other candidates needing repository-level classification:** SlipstreamPlus, SlipStreamGUI, slipGate, roundSync, teleMirror, stormDNS, MasterHttpRelayRust, MahsaAlert, theFeed, onionHop.
- **Other names in the original roundup:** Oblivion, GNet, IRBox, Termux. Termux is a general Android terminal environment rather than a censorship-circumvention method by itself.

## Known project pages to verify first

- ZedSecure: https://github.com/CluvexStudio/ZedSecure
- Aether: https://github.com/CluvexStudio/Aether
- DefyxVPN: https://github.com/UnboundTechCo/defyxVPN
- SenPaiScanner: https://github.com/MatinSenPai/SenPaiScanner
- PattN: https://github.com/patterniha/PattN
- PattNG: https://github.com/patterniha/PattNG
- MahsaNG: https://github.com/GFW-knocker/MahsaNG
- Psiphon (official project information): https://psiphon.ca/
- Tor Project downloads and documentation: https://www.torproject.org/
- Community monitoring/aggregation links supplied for investigation, not endorsement:
  - https://t.me/PersianGithubMirror
  - https://t.me/irnetmonitor
  - https://t.me/ircfspace

Repository ownership/naming can change. Confirm links from official project documentation where possible and beware look-alike repositories.

## Telegram bots and file gateways

User-supplied candidates: `@EazySSH_bot`, `@EazyFlare_bot`, `@GithubGitlabDownloader_bot`, `@chatgpt_general_bot`, `@LeecherPro_bot`.

Their current behavior, operator, data handling, and security posture have not been independently verified. Treat them as opaque third-party services until reviewed. Never send private repository URLs, private source code, credentials, API keys, customer data, SSH keys, or proprietary artifacts. For fetched public binaries, compare SHA-256/signatures against the original publisher's release metadata. A bot returning a file is not proof that the file is authentic.

## How to evaluate a tool before recommending it

1. Find the official source from the project website or known maintainer account; check for similarly named forks.
2. Review license, recent release/tag/commit, supported OS and CPU architectures, changelog, open security issues, and documented permissions.
3. Identify protocol/core dependencies and whether those endpoints require the user's own server/account.
4. Check whether the app changes OS proxy, DNS, routes, firewall, certificates, or a TUN interface. Explain and seek consent for elevated operations.
5. Do not distribute or auto-import unknown community configurations as trusted. Treat supplied endpoints/configs as untrusted data.
6. Record test context: date/time, coarse region if voluntarily provided, ISP/network type, transport, IPv4/IPv6, success/failure, and measured result. Avoid collecting exact user IPs by default.
7. Re-test on the user's network; do not translate one ISP's successful setup into a national claim.
