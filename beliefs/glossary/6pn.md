---
id: em:0563fb
type: concept
title: 6PN
description: Fly.io's private networking layer — a mesh of WireGuard tunnels over IPv6 connecting every Machine in an organization by default, with a `.internal` DNS server for app/region/machine discovery, invisible to the public internet.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, networking, fly-io, wireguard, infrastructure]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-03 herdr-vs-Claude-Code-app thread's CCR-approximation build, contrasting Fly.io's private networking with Shellbox's public-IPv6-per-box model"
---

# 6PN

Organizations are isolated from one another by default — Fly won't forward
traffic between two different 6PNs unless explicitly permitted. A Machine
listens on its 6PN address by binding to the alias `fly-local-6pn`; other
Machines in the same app find it by querying the custom internal DNS server
(`fdaa::3`), which resolves `<app>.internal` to every running Machine's 6PN
address, `<region>.<app>.internal` for a regional subset, and `_apps.internal`
for every app name in the organization — critically, only for *started*
Machines, so a stopped one drops out of discovery. An operator outside Fly
reaches the mesh the same way a Machine does: `fly wireguard create` mints a
peer config that, once imported into a local WireGuard client, gives the
laptop its own 6PN address and access to the same `.internal` DNS.

*Seen in:* [2026-08-03 herdr vs. Claude Code analysis thread](/meta/threads/2026-08-03-herdr-vs-claude-code-analysis.md), [Herdr vs. the Claude Code app](/meta/analysis/herdr-vs-claude-code-app.md)
