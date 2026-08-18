---
id: em:1d214a
type: reference
title: "Actual Budget — self-hosting installation options"
description: Actual Budget's client/server split and the officially supported ways to self-host it — Docker, the Server CLI, Fly.io, PikaPods (managed), or building from source — versus the no-server, browser-only mode explicitly discouraged for long-term use.
resource: https://actualbudget.org/docs/install/
provenance: "Actual Budget official docs (actualbudget.org), fetched 2026-08-18"
tags: [self-hosting, personal-finance, budgeting, docker, open-source]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Actual Budget — self-hosting installation options

Actual Budget splits into a client and an optional-but-recommended server. A
server is not required for Actual to function but is strongly recommended, as
it provides increased functionality. Without a server you lose sync between
devices, bank syncing (GoCardless/SimpleFIN), the API, and mobile/web use —
you keep only local budgeting and file import/export.

## Local-browser-only mode (not recommended long-term)

Data lives entirely in the browser, unsynced, with no server. Actual's own
docs flag this directly as not recommended for long-term use due to the
maintenance required and the high probability of data loss — positioned as a
quick-start/trial mode only, requiring the user to manually export/re-import
a save file to move between devices or browsers.

## Server-optional client: desktop apps

Windows/Mac/Linux desktop apps (from GitHub releases) work offline out of the
box, support automated backups, and can optionally connect to a server for
sync — nightly builds are available for previewing upcoming features.

## Running a server — the supported options

| Method | Notes |
|---|---|
| PikaPods | Managed hosting, no command line needed; a small fee, part of which is donated to the project |
| Server CLI | Run the server with one command |
| Fly.io | Comparable cost to PikaPods, self-managed |
| Docker | Official container images |
| Build from source | macOS/Windows/Linux — recommended if contributing to development |

Once running, the server serves a web app usable in-browser or installed as
an offline-capable PWA on mobile.

## Community-maintained alternatives (unofficial)

Google Cloud (free tier and Cloud Run), Home Assistant, Synology NAS, Proxmox
VE, UnRAID, and Arch Linux AUR packages (`actual-appimage`, `actual-bin`,
`actual-server`) all have community guides, not maintained by the Actual
Budget team.

# Citations

- Source: <https://actualbudget.org/docs/install/>
