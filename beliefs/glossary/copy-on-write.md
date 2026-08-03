---
id: em:5bf220
type: concept
title: copy-on-write
description: A storage and memory technique where a copy shares the original's data until one side writes, duplicating only the modified blocks — making clones near-instant and initially free, with the cost of divergence paid incrementally as the copies drift apart.
provenance: "Agent-distilled glossary definition (Claude Fable 5)"
verified: false
tags: [glossary, copy-on-write, storage, filesystems, virtualization]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T20:45:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 fly/shellbox intake and elixir-deployment thread"
---

# copy-on-write

Abbreviated CoW; surfaced here as the mechanism behind instant machine
cloning: btrfs reflinks let
[Shellbox](/knowledge/SWE/agentic/execution-environments/shellbox.md)
duplicate a box without copying its disk, and checkpoint/fork designs on
[Fly.io](/knowledge/SWE/agentic/execution-environments/fly-io.md) Sprites
rest on the same principle. The pattern recurs at every layer of the stack —
filesystem snapshots, fork's memory pages, persistent data structures — 
wherever many mostly-identical copies must be cheap.

*Seen in:* [2026-08-02 fly/shellbox intake thread](/meta/threads/2026-08-02-fly-shellbox-intake-and-elixir-deployment-landscape.md), [Shellbox reference](/knowledge/SWE/agentic/execution-environments/shellbox.md)
