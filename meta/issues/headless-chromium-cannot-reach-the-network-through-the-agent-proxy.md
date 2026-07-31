---
type: issue
title: "Headless Chromium cannot reach the network through the agent proxy"
description: The pre-installed Chromium resets on every HTTPS host including example.com when pointed at the session's agent proxy, while curl through the same proxy succeeds — which removes browser rendering as the standard fallback for client-rendered sources.
status: open
provenance: "Observed in-session 2026-07-29 while attempting to fetch a client-rendered page after plain fetches failed"
tags: [meta, issue, source-acquisition, intake, tooling, proxy, playwright, chromium]
timestamp: 2026-07-29T03:00:47Z
attribution:
  when: 2026-07-29T03:00:47Z
  channel: agent-authored
  agent: "Claude Code agent, /intake session"
  why: "operator dispositioned the session's dangling ledger strand into a tracked issue rather than closing it as environment noise"
  from: [/meta/threads/2026-07-29-graphrag-serialization-claim-and-its-critic.md]
---

# Headless Chromium cannot reach the network through the agent proxy

## Summary

The remote execution environment ships Chromium at `/opt/pw-browsers/chromium`
with `PLAYWRIGHT_BROWSERS_PATH` pre-set, and the harness documents it as
available for browser-driven work. In this session it could not load **any**
page: every navigation ended in `net::ERR_CONNECTION_RESET`, with or without the
proxy configured, while `curl` reached the same hosts through the same proxy in
the same shell.

That matters beyond one blocked source. Rendering a page in a real browser is the
standard answer when an ordinary fetch returns only navigation chrome — the
failure mode
[`/intake`](/.claude/skills/intake/SKILL.md)'s link-resolution step names
explicitly. If the browser is unavailable, that fallback does not exist for any
client-rendered host, and each future session will rediscover it one wasted
detour at a time.

## Evidence

Observed 2026-07-29, in order:

| Attempt | Result |
|---|---|
| Playwright `chromium.launch()`, no proxy option, → a real target host | `net::ERR_CONNECTION_RESET` |
| Same, with `proxy: { server: process.env.HTTPS_PROXY }` (`http://127.0.0.1:37377`) | `net::ERR_CONNECTION_RESET` |
| Same, → `https://example.com` | `net::ERR_CONNECTION_RESET` — so the failure is not host-specific |
| `/opt/pw-browsers/chromium --headless=new --no-sandbox --proxy-server=http://127.0.0.1:37377 --dump-dom https://example.com/` | Chromium's own error page: "The connection was reset." |
| `curl` through the same proxy, same shell, same hosts | 200s and ordinary HTTP error codes — the proxy path works for curl |

Context at the time: `curl -sS "$HTTPS_PROXY/__agentproxy/status"` reported
`enabled: true`, `selective: false`, `toolScoped: false`, and an **empty**
`recentRelayFailures` array — so the proxy recorded no rejection of these
connections. `~/.pki/nssdb` existed (`cert9.db`, `key4.db`, `pkcs11.txt`), which
is where the harness README says the browser trust store is installed.

## What is not yet known

- Whether the reset comes from Chromium failing to trust the re-terminated TLS
  and surfacing it as a reset rather than a certificate error, or from the proxy
  refusing Chromium's `CONNECT` before recording it.
- Whether a different launch shape works — `chromium_headless_shell-1194`
  instead of the full browser, `--proxy-server` with an explicit
  `--proxy-bypass-list`, or an explicit `NODE_EXTRA_CA_CERTS` / NSS import of
  `/root/.ccr/agent-proxy-ca.crt`.
- Whether this is specific to this environment's configuration or general to the
  remote-execution image.

Diagnosing it was out of scope for the session that hit it: an alternate route to
the source existed
([getting a Reddit thread when every direct fetch is blocked](/knowledge/knowledge-management/source-acquisition/reddit-thread-when-fetch-is-blocked.md)),
so the browser was abandoned rather than debugged.

## Next step

Reproduce against `https://example.com` — the cheapest possible target, and
enough to tell a configuration problem from a host problem — and try the three
launch variants above before escalating. `curl -sS
"$HTTPS_PROXY/__agentproxy/status"` at the moment of failure is the one piece of
evidence this session did not capture *while a navigation was in flight*; the
`recentRelayFailures` array read empty afterwards, which is consistent with
either explanation. The harness README's own guidance — "If a tool still cannot
work through the proxy, report it to your administrator or Anthropic support" —
is the endpoint if the variants all fail.

Until then, treat browser rendering as **unavailable** in this environment and
reach for host-specific extraction instead; the techniques belong in
[`source-acquisition/`](/knowledge/knowledge-management/source-acquisition/index.md).
