---
id: em:d8a833
type: concept
title: scale-to-zero
description: The capacity and billing model where an idle workload consumes and costs nothing — instances stop or suspend when demand disappears and start again on the next request — natural for stateless request-response services and structurally hostile to runtimes built on long-lived stateful processes.
provenance: "Agent-distilled glossary definition (Claude Fable 5)"
verified: false
tags: [glossary, scale-to-zero, serverless, infrastructure, billing, deployment]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T20:45:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 fly/shellbox intake and elixir-deployment thread"
---

# scale-to-zero

Two implementations with opposite state stories surface in this bundle's
captures: the FaaS form (Lambda, App Runner) tears instances down and cold-
starts fresh ones, which is what makes it a poor fit for the BEAM's
persistent processes; the suspend form
([Fly.io](/knowledge/SWE/agentic/execution-environments/fly-io.md) Sprites,
[Shellbox](/knowledge/SWE/agentic/execution-environments/shellbox.md))
snapshots a [microVM](/beliefs/glossary/microvm.md)'s memory and restores it
intact, keeping the economics while preserving state — the property that
makes it suit agent workloads.

*Seen in:* [2026-08-02 fly/shellbox intake thread](/meta/threads/2026-08-02-fly-shellbox-intake-and-elixir-deployment-landscape.md), [Fly.io reference](/knowledge/SWE/agentic/execution-environments/fly-io.md), [Shellbox reference](/knowledge/SWE/agentic/execution-environments/shellbox.md)
