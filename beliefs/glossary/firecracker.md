---
id: em:150277
type: concept
title: Firecracker
description: An open-source (Amazon, 2018) minimal virtual machine monitor built on KVM, purpose-built for launching lightweight "microVMs" in milliseconds with a tiny memory footprint and a reduced attack surface versus a full VM.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, virtualization, microvm, kvm, infrastructure]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-03 herdr-vs-Claude-Code-app thread's CCR-approximation build, naming Firecracker as the virtualization layer underlying Shellbox and (via Fly Sprites) Fly.io's agent-workload VMs"
---

# Firecracker

Originally built to isolate AWS Lambda and Fargate invocations, Firecracker
strips a VMM down to only what a microVM needs (no BIOS, no legacy device
emulation), which is what lets boot times land in the tens-to-low-hundreds of
milliseconds rather than the seconds a general-purpose hypervisor takes.
That speed is what makes "snapshot the whole VM, resume it later" a practical
primitive rather than a slow special case — several agent-sandbox and
dev-box platforms build on exactly that property: Shellbox boots boxes from a
memory snapshot in about three seconds, and Fly.io's Machines/Sprites use
Firecracker for their own fast-start, checkpoint/restore-capable VMs (Cloud
Hypervisor is Shellbox's alternate backend, used for nested virtualization).

*Seen in:* [2026-08-03 herdr vs. Claude Code analysis thread](/meta/threads/2026-08-03-herdr-vs-claude-code-analysis.md), [Herdr vs. the Claude Code app](/meta/analysis/herdr-vs-claude-code-app.md)
