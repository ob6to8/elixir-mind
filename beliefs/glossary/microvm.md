---
id: em:dbab99
type: concept
title: microVM
description: A minimal virtual machine with hardware-level isolation but a stripped device model and kernel, booting in fractions of a second — the compute unit pairing container-like speed and density with VM-grade security boundaries, and the substrate of serverless platforms and agent execution environments.
provenance: "Agent-distilled glossary definition (Claude Fable 5)"
verified: false
tags: [glossary, microvm, virtualization, isolation, infrastructure, sandboxing]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T20:45:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 fly/shellbox intake and elixir-deployment thread"
---

# microVM

Sits between a container (shared host kernel, weaker boundary) and a
traditional VM (full device emulation, slow boot): each guest runs its own
kernel behind hardware virtualization, but the monitor implements only the
few devices a cloud workload needs. [Firecracker](/beliefs/glossary/firecracker.md)
and Cloud Hypervisor are the implementations this bundle's captures name.
Platforms selling compute to agents build on microVMs for two properties
jointly: untrusted code gets a real isolation boundary, and memory
snapshot/restore lets an idle machine suspend to disk and bill nothing —
the persistent-suspendable-machine category the
[Fly.io](/knowledge/SWE/agentic/execution-environments/fly-io.md) and
[Shellbox](/knowledge/SWE/agentic/execution-environments/shellbox.md)
references converge on.

*Seen in:* [2026-08-02 fly/shellbox intake thread](/meta/threads/2026-08-02-fly-shellbox-intake-and-elixir-deployment-landscape.md), [Fly.io reference](/knowledge/SWE/agentic/execution-environments/fly-io.md), [Shellbox reference](/knowledge/SWE/agentic/execution-environments/shellbox.md)
