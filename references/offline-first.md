# Offline-first development and interrupted downloads

The objective during severe throttling or an international outage is to **reuse artifacts already obtained** and prepare future work before connectivity deteriorates. No technique can fetch a missing remote artifact when there is no route to any reachable copy.

## Before an expected outage

- Cache language dependencies in CI and on a local machine; pin versions and lockfiles.
- Keep a small, documented set of build-critical dependencies mirrored internally. Record upstream source, version, digest/signature, license, architecture, and fetch time.
- Pull base container images in advance; retain immutable digests rather than relying only on moving tags.
- Keep copies of essential docs, release notes, SBOMs, and installer checksums where licensing permits.
- Bundle Git repositories or selected refs for offline sharing; keep secrets out of bundles.

## Useful ecosystem approaches

| Ecosystem | Options to investigate | Safety/limitations |
|---|---|---|
| Git | `git bundle`, local bare mirror, shallow/filtered clone before outage | A bundle contains only refs/objects included when created; verify branch/tag coverage |
| Docker/OCI | `docker save` / `docker load`, registry cache/mirror under admin control | Confirm target architecture, tags/digests, and image provenance; keep credentials out of exported files |
| Python/pip | Pre-download wheels for target OS/Python/architecture into a wheelhouse; install with `--no-index --find-links` | Wheels are platform-specific; inspect hashes and avoid mixing untrusted public indexes with private package names |
| uv / Python projects | Populate cache and lock dependencies while connected; use documented offline/cache behavior of installed uv version | Verify that all wheels/sdists and build dependencies are actually present |
| Node/npm | Warm npm cache; create an internal registry/cache; save tarballs for exact versions | npm's cache is not a guaranteed full offline mirror; test `--offline` before relying on it |
| Go | Warm module cache or use `go mod vendor` for suitable projects | Vendoring increases repository size; confirm license and modules are complete |
| Rust/Cargo | Vendor dependencies with Cargo's supported vendoring workflow | Verify `.cargo/config.toml` is scoped to the project and vendor directory is reproducible |
| APT/dpkg | Download packages and dependency closure, maintain a local apt repository/snapshot | Package versions and dependency closure must match OS release/architecture |
| Maven/Gradle/Android | Warm Gradle/Maven caches; mirror required artifacts; cache Android SDK components | Build plugins, wrapper distributions, and SDK tools are dependencies too; test offline mode beforehand |
| Hugging Face/ML models | Download exact model revisions and tokenizer/config files ahead of time | Record repository commit/revision and checksums; check model licenses and avoid unsafe remote-code execution |

These are patterns, not commands to run blindly. Consult the package manager's version-specific official documentation and confirm project policy before changing build configuration.

## Resumable downloads

- Prefer the official source and a documented resume feature (for example, `curl -C -` when the origin supports byte ranges).
- Use bounded retries with exponential backoff; reduce parallelism on packet-loss-heavy connections.
- Validate final file length and SHA-256/signature against trusted publisher metadata. If a mirror/bot changes the asset, hashes must match the original.
- Preserve partial downloads; do not delete a cache or restart a multi-gigabyte transfer without checking whether resume is supported.

## True offline mode

When global routing is unavailable, prioritize:

1. Current working tree and local source code.
2. Cached dependency artifacts and existing container images.
3. Local Git mirrors/bundles and internal package registries.
4. Local docs, compiler/toolchain installers, model weights and SDK packages already downloaded.
5. Work that does not require a new upstream artifact.

Do not claim that a VPN, Cloudflare Worker, DNS tunnel, SSH tunnel, or remote API can restore global access without a working path to its endpoint.
