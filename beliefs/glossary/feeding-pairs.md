---
id: sb:c0ed08
type: concept
title: feeding pairs
description: The set of (thread, sink) pairs the current route tags induce — a thread feeds a sink when at least one of its tagged regions lists that sink's stable id; the set is the domain of materialization in both directions.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, routing, route-tagging]
timestamp: 2026-07-12
---

# feeding pairs

Nothing stores the set — it is derived fresh on every run from the current
[route tags](/beliefs/glossary/route-tag.md), matching each region's ref list of
[stable ids](/beliefs/glossary/stable-id.md) against the sinks. "Both directions"
of [materialization](/beliefs/glossary/materialize.md) means: a
[sink](/beliefs/glossary/route-tag-sink.md) inside the set gets its
[excerpt log](/beliefs/glossary/excerpt-log.md) (re)written, a sink outside it
loses the section.

*Seen in:* [code-review toolchain hardening plan](/meta/plans/code-review-toolchain-hardening.md), [session-capture flow](/meta/flows/session-capture.md)
