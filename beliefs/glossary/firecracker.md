---
id: em:f20db7
type: concept
title: Firecracker
description: AWS's open-source KVM-based virtual machine monitor for microVMs — built for Lambda and Fargate, booting stripped Linux guests in ~125 ms with minimal per-VM overhead and supporting memory snapshot/restore — the de-facto standard substrate for suspendable sandbox, dev-box, and agent-compute services.
provenance: "Agent-distilled glossary definition (Claude Fable 5)"
verified: false
tags: [glossary, firecracker, microvm, virtualization, aws, sandboxing]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T20:45:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 fly/shellbox intake and elixir-deployment thread"
---

# Firecracker

The snapshot capability is what the suspend-on-disconnect economics of
services like [Shellbox](/knowledge/SWE/agentic/execution-environments/shellbox.md)
and [Fly.io](/knowledge/SWE/agentic/execution-environments/fly-io.md)'s
Sprites rest on: a running guest's memory writes to disk, the
[microVM](/beliefs/glossary/microvm.md) stops billing, and the next
connection restores it with processes intact. Its deliberately minimal
device model is also its limit — Shellbox offers Cloud Hypervisor as the
alternative backend when a workload needs nested virtualization.

*Seen in:* [2026-08-02 fly/shellbox intake thread](/meta/threads/2026-08-02-fly-shellbox-intake-and-elixir-deployment-landscape.md), [Shellbox reference](/knowledge/SWE/agentic/execution-environments/shellbox.md)
