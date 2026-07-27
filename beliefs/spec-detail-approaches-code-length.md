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

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:1eebdf">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-26-structured-plan-bodies-and-belief-layer (2026-07-26)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:1eebdf`]**  (co-feeds: `em:0c4913 em:a96688`)

Two boundaries matter. This is **outline-level pseudocode, not full pseudocode**: Dex's adjacent post makes the constraint explicit — "a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself — so don't review those things." The artifacts compress the *decisions* (interfaces, layout, call order) while leaving function bodies to the agent. And it's not prose-free: the artifacts sit inside a narrative doc; they replace the *ambiguous* part of prose, not the rationale.

---

**[`em:1eebdf`]**  (co-feeds: `em:0c4913 em:6c7e85 em:a96688`)

add the following to the belief list, with a link to the dex article as provenance:
""a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself" and then a belief that depends on that belief: "so don't review those things.""
also: "every one of them is a decision you'd otherwise be making implicitly during code review" (define "every one")
"The artifacts compress the decisions (interfaces, layout, call order) while leaving function bodies to the agent" - provenance will be this thread (does this mean we should open the pull request now to get the thread doc to tie all these to for provenance?

---

**[`em:1eebdf`]**  (co-feeds: `em:0c4913 em:6c7e85 em:a96688`)

- **Belief layer ratified and seeded.** Your "add to the belief list" instruction was the ratification the [belief-layer plan](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/plans/belief-type-and-beliefs-namespace.md) was waiting on, so I executed its build order: `belief` type in the vocabulary (with the epistemic/teleological filing test), [`/beliefs/`](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/beliefs/index.md) rewritten as the layer's home, and a verifier regression test pinning that `verified` on a `belief` is rejected. Four seed beliefs, each quoting its source verbatim: the Dex spec-length thesis (`em:1eebdf`), **"so don't review those things"** (`em:0c4913`, carrying `depends_on: [em:1eebdf]` — the dependency you specified), the wsff quote with **"every one of them" resolved in the body** to its referent (call-stack trees, file-tree diffs, type signatures — `em:6c7e85`), and my synthesis about compressing decisions (`em:a96688`).
