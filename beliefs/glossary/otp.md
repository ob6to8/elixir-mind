---
id: sb:5d40bf
type: concept
title: OTP
description: Erlang/Elixir's standard framework of battle-tested abstractions for fault-tolerant systems on the BEAM — supervision trees that restart crashed processes by declared strategy, GenServers as generic stateful server processes, and applications as deployable, supervised units.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, otp, erlang, elixir, supervision, fault-tolerance]
timestamp: 2026-07-12
---

# OTP

Supervision trees are the mechanism behind [let-it-crash](/beliefs/glossary/let-it-crash.md), and GenServers are the behaviour most long-lived state on the [BEAM](/beliefs/glossary/beam.md) lives in. A codebase with no OTP application is Elixir used as a scripting language; adopting OTP is the line where a project becomes a resident system.

*Seen in:* [BEAM/Jido evaluation](/meta/analysis/beam-deployment-and-jido-2-evaluation.md), [dark-factory scenario analysis](/meta/analysis/dark-factory-epistemic-base-beam-jido.md)
