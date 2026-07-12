---
id: sb:3101ef
type: concept
title: excerpt log (route-tagged log)
description: The generated "## Thread excerpts — route-tagged log" section a route-tag sink carries — per-thread, date-stamped blocks lifting each tagged region whole, re-derivable from the tags and never hand-edited.
provenance: "Agent-distilled glossary definition, pointer to the defining policy"
verified: false
tags: [glossary, routing, route-tagging, capture]
timestamp: 2026-07-12
---

# excerpt log (route-tagged log)

Append-only; each block lifts one thread's
[route-tagged](/beliefs/glossary/route-tag.md) regions with ATX headers demoted
to bold. It is the [materialized](/beliefs/glossary/materialize.md) output of the
tags — written into the [sink](/beliefs/glossary/route-tag-sink.md) by
`mix brain.route_tags --materialize` and guarded by the `log fidelity` check
that re-derives each block and fails on divergence.
Canonically defined by the
[route-tagging policy](/meta/policy/route-tagging.md).

*Seen in:* [two-directional materialize elaboration](/meta/elaborations/two-directional-materialize.md), [session-capture flow](/meta/flows/session-capture.md), [code-review toolchain hardening plan](/meta/plans/code-review-toolchain-hardening.md)
