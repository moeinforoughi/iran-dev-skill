# Security, privacy, and supply-chain rules

## Privileged/network-changing actions

- Ask before installing a client, creating a tunnel, running a daemon, changing DNS, editing `/etc/hosts`, altering routing/firewall rules, enabling TUN mode, or writing global package-manager configuration.
- Prefer per-process or per-project settings. Back up the previous config and supply rollback steps.
- Do not disable TLS verification, use `curl -k` as a solution, install unknown root CAs, or recommend HTTP mirrors for credentialed downloads.
- Avoid `curl | sudo bash` unless the user explicitly approves after reviewing the exact source, script contents, provenance, and expected modifications.
- Never add `--trusted-host` or an equivalent certificate bypass just to make an index download succeed.

## Mirror and registry trust

- A mirror is a transport/cache, not automatically an authority. Validate TLS and package metadata; preserve lockfiles and checksums.
- Treat unknown mirrors as untrusted until their operator, endpoint, update behavior, and package integrity are understood.
- Be cautious with pip `--extra-index-url`: searching both a private index and a public index can enable dependency-confusion attacks. Prefer a single curated index, explicit sources, hashes, or a controlled internal repository when feasible.
- For Docker, prefer registry configuration documented by the registry/provider. Never place registry passwords in source control or shell history.
- Verify official release signatures/checksums after using GitHub mirrors, Telegram bots, download relays, or CDN caches.

## Configs and credentials

- Treat VLESS/WireGuard/OpenVPN profiles, SSH configs, subscription URLs, tokens, API keys, and bot-generated links as secrets. Do not paste them into public issues or AI endpoints without explicit authorization.
- Redact passwords, UUIDs, private keys, bearer tokens, cookies, internal addresses, and subscription query strings in logs and reports.
- Avoid third-party bots/proxies for private repository or proprietary code. A service's name or popularity does not establish confidentiality.
- Do not record the user's public IP by default. Use coarse network metadata only when needed and with consent.

## Legal/provider constraints

- Distinguish technical reachability from the provider's access terms, account requirements, sanctions/export rules, billing, and supported regions.
- Do not fabricate a user's location, identity, organization, or billing details. Offer compliant alternatives when a product is unavailable.
