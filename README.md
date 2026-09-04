# Docker

## Root — opencode dev environment

### `Dockerfile`

Based on `golang:latest`. Installs:

- Go toolchain
- Git, GitHub CLI (`gh`)
- WireGuard tools, iproute2, iptables
- Chromium, ffmpeg, curl, ca-certificates
- [opencode](https://opencode.ai)

Working directory: `/workspace`

### `docker-compose.yml`

Service `dev` builds from the Dockerfile. Mounts the repo at `/workspace` and passes through host SSH keys, git config, GitHub CLI auth, and opencode config.

Requires privileged mode with `NET_ADMIN` / `SYS_MODULE` / `SYS_ADMIN` capabilities for optional WireGuard support. If `/etc/wireguard/wg0.conf` exists, the container brings up `wg0` on start and tears it down on exit.

```bash
docker compose up -d
docker compose exec dev bash
```


