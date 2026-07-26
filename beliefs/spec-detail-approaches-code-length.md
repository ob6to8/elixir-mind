---
id: em:1eebdf
type: belief
title: A spec detailed enough to reliably generate quality code is roughly as long as the code
description: Dex Horthy's thesis that a spec sufficiently detailed to generate code with reliable quality converges on the length and detail of the code itself — the bound that keeps plan artifacts at outline level.
provenance: "Dex Horthy (@dexhorthy), X post — https://x.com/dexhorthy/status/2033980486813684181; filed at operator direction from the 2026-07-26 pseudocode-plans session"
tags: [belief, planning, specs, coding-agents, context-engineering]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: intake
  agent: "Claude Code agent, pseudocode-plans session — operator-directed belief filing"
  why: "operator ratified the belief layer and directed filing this quote as its seed belief while adopting the structured-plan-bodies policy it bounds"
---

# A spec detailed enough to reliably generate quality code is roughly as long as the code

The belief, quoted verbatim from its source:

> "a spec that is sufficiently detailed to generate code with a reliable degree
> of quality is roughly the same length and detail as the code itself"

— Dex Horthy, [X post](https://x.com/dexhorthy/status/2033980486813684181)
(the thesis of his HumanLayer essay
["Why Software Factories Fail"](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md)).

Held as a prior because it bounds how much detail a plan, spec, or design
artifact should carry: past a certain granularity, the spec *is* the code in a
worse notation, and the effort of writing and reading it stops paying for
itself. This is the upper bound the
[structured-plan-bodies policy](/meta/policy/structured-plan-bodies.md) builds
against — plan artifacts stay at the signature/tree/outline level (interfaces,
layout, call order) precisely because going further crosses this line.

The prescriptive consequence is filed as its own dependent belief:
[Don't review code-length specs](/beliefs/dont-review-code-length-specs.md).

# Citations

- https://x.com/dexhorthy/status/2033980486813684181 — the source post.
- https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md —
  the companion essay elaborating the surrounding planning method.
