---
id: sb:bb2968
type: concept
title: strand
description: One topic's line of work through a session — the unit a routing ledger tracks, one row per strand, carrying a state (open/paused/closed) orthogonal to where its content was routed.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, routing, capture, session-init]
timestamp: 2026-07-11
---

# strand

One topic's line of work through a working session: a session touches many matters, and each matter's thread of discussion — picked up, paused on an open question, resumed, resolved — is a strand. The [routing ledger](/glossary/routing-ledger.md) tracks exactly one row per strand, giving it a state (`open`/`paused`/`closed`) that is orthogonal to where its content was routed: a strand can be routed yet still open, or closed and unrouted. A **dangling strand** is one whose state or unanswered question leaves work outstanding after the thread is frozen; the [session-init digest](/glossary/session-init-digest.md) harvests these from all captured threads so they surface as open work in later sessions.

*Seen in:* [routing-ledger policy](/meta/policy/routing-ledger.md), [2026-07-11 session-init thread](/meta/threads/2026-07-11-session-init-digest-and-priorities.md)
