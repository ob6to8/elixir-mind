---
id: em:b16a13
type: concept
title: feature flag
description: A configuration switch that enables or disables a shipped capability per deployment or per consumer, without changing the code that implements it.
provenance: "Agent-distilled glossary definition (Claude Fable 5)"
verified: false
tags: [glossary, architecture, configuration, modularity]
sense: dual
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T20:04:58Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-03 modular-features stage amendment thread"
---

# feature flag

Widely used for gradual rollouts, A/B experiments, and per-tenant capability
sets: everyone runs the same artifact, and the flag decides which of its
behaviors are live.

**In this brain:** the spin-out plan's deferred modular-features stage delivers
à la carte adoption this way — a `features` field in the
[bundle manifest](/beliefs/glossary/bundle-manifest.md) (default: all on) keys
the verifier's check sets, so a bundle that skips a feature runs none of its
checks and ratifies none of its policy templates. Chosen over per-feature
packages while the library has one consumer; physical packaging waits for a
second consumer wanting a partial install.

*Seen in:* [2026-08-03 modular-features stage thread](/meta/threads/2026-08-03-modular-features-stage-in-the-spin-out-plan.md), [library spin-out plan](/meta/plans/library-spin-out-and-dependency-distribution.md)
