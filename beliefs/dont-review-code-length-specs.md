---
id: em:0c4913
type: belief
depends_on: [em:1eebdf]
title: Don't review code-length specs
description: The prescriptive consequence of the spec-length belief — an artifact as detailed as the code it generates should not get its own review pass; review the code once, not its transcription twice.
provenance: "Dex Horthy (@dexhorthy), X post — https://x.com/dexhorthy/status/2033980486813684181; filed at operator direction from the 2026-07-26 pseudocode-plans session"
tags: [belief, planning, specs, review, coding-agents]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: intake
  agent: "Claude Code agent, pseudocode-plans session — operator-directed belief filing"
  why: "operator directed filing this as a belief dependent on the spec-length belief, completing the pair that bounds plan-artifact granularity"
---

# Don't review code-length specs

The belief, quoted verbatim from its source (the clause completing the
spec-length thesis):

> "so don't review those things"

— Dex Horthy, [X post](https://x.com/dexhorthy/status/2033980486813684181).

**This belief depends on
[A spec detailed enough to reliably generate quality code is roughly as long as the code](/beliefs/spec-detail-approaches-code-length.md):**
*given* that a reliably-code-generating spec converges on the code's own length
and detail, reviewing it is reviewing the code twice — once in a worse notation.
The review effort belongs on artifacts that are genuinely more compressed than
the code (signatures, trees, boundaries), and then on the code itself.

Acted on in the
[structured-plan-bodies policy](/meta/policy/structured-plan-bodies.md): plan
artifacts are kept at the level where review adds information, and a plan whose
pseudocode has crept to code granularity is over-specified, not thorough.

# Citations

- https://x.com/dexhorthy/status/2033980486813684181 — the source post.
