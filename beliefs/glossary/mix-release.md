---
id: em:c11ff0
type: concept
title: mix release
description: Elixir's built-in self-contained deployment artifact — the compiled application bundled with the Erlang runtime system into one relocatable directory, so the target machine needs no Elixir, Erlang, or build toolchain installed.
provenance: "Agent-distilled glossary definition (Claude Fable 5)"
verified: false
tags: [glossary, mix-release, elixir, beam, deployment, releases]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T20:45:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 fly/shellbox intake and elixir-deployment thread"
---

# mix release

Descended from OTP's release machinery (Erlang shipped telecom hardware this
way for decades), it is why BEAM roll-your-own hosting is unusually simple:
CI builds the artifact in a container matching the target distro, the
tarball is copied to a VM, and a systemd unit runs it — rollback is
re-pointing a symlink at the previous build. Hot code upgrades remain
technically part of the same machinery but restart-based deploys are the
community norm.

*Seen in:* [2026-08-02 fly/shellbox intake thread](/meta/threads/2026-08-02-fly-shellbox-intake-and-elixir-deployment-landscape.md)
