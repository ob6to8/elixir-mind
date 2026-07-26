---
id: em:6c7e85
type: belief
title: Plan artifacts surface decisions otherwise made implicitly at code review
description: Each program-design artifact — a call-stack tree, a file-tree diff, a set of type signatures — is a decision that would otherwise be made implicitly during code review, at the most expensive time to change one's mind.
provenance: "Dex Horthy, 'Why Software Factories Fail' (wsff.md), HumanLayer — https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md; filed at operator direction from the 2026-07-26 pseudocode-plans session"
tags: [belief, planning, review, program-design, coding-agents]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: intake
  agent: "Claude Code agent, pseudocode-plans session — operator-directed belief filing"
  why: "operator directed filing this with the quote's referent ('every one') resolved, so the belief stands alone outside its source essay"
---

# Plan artifacts surface decisions otherwise made implicitly at code review

The belief, quoted verbatim from its source:

> "none of these take long to produce (the model drafts them, you argue with
> it), and every one of them is a decision you'd otherwise be making implicitly
> during code review -- at the most expensive possible time to change your mind."

— Dex Horthy,
["Why Software Factories Fail"](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md),
program-design section.

**The referent of "every one of them"**, resolved so this belief stands alone:
the three program-design artifacts the essay prescribes drafting before
implementation —

1. **call-stack trees** (orchestration/control-flow changes, in diff syntax),
2. **file-tree diffs** (where new and modified files live in the codebase), and
3. **types and method signatures** for the key new functions.

Held as a prior because it locates the *value* of structured plan bodies: the
artifacts are not documentation overhead but decisions relocated from the most
expensive point (code review, after implementation) to the cheapest (plan
review, before it). It is the motivating belief behind the
[structured-plan-bodies policy](/meta/policy/structured-plan-bodies.md).

# Citations

- https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md —
  the source essay; the quote and the three artifacts are in its "Program
  design" section.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:6c7e85">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-26-structured-plan-bodies-and-belief-layer (2026-07-26)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:6c7e85`]**

The stated rationale: "none of these take long to produce (the model drafts them, you argue with it), and every one of them is a decision you'd otherwise be making implicitly during code review — at the most expensive possible time to change your mind." Hence the thesis "30 minutes of planning saves hours of review."

---

**[`em:6c7e85`]**  (co-feeds: `em:1eebdf em:0c4913 em:a96688`)

add the following to the belief list, with a link to the dex article as provenance:
""a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself" and then a belief that depends on that belief: "so don't review those things.""
also: "every one of them is a decision you'd otherwise be making implicitly during code review" (define "every one")
"The artifacts compress the decisions (interfaces, layout, call order) while leaving function bodies to the agent" - provenance will be this thread (does this mean we should open the pull request now to get the thread doc to tie all these to for provenance?

---

**[`em:6c7e85`]**  (co-feeds: `em:1eebdf em:0c4913 em:a96688`)

- **Belief layer ratified and seeded.** Your "add to the belief list" instruction was the ratification the [belief-layer plan](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/plans/belief-type-and-beliefs-namespace.md) was waiting on, so I executed its build order: `belief` type in the vocabulary (with the epistemic/teleological filing test), [`/beliefs/`](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/beliefs/index.md) rewritten as the layer's home, and a verifier regression test pinning that `verified` on a `belief` is rejected. Four seed beliefs, each quoting its source verbatim: the Dex spec-length thesis (`em:1eebdf`), **"so don't review those things"** (`em:0c4913`, carrying `depends_on: [em:1eebdf]` — the dependency you specified), the wsff quote with **"every one of them" resolved in the body** to its referent (call-stack trees, file-tree diffs, type signatures — `em:6c7e85`), and my synthesis about compressing decisions (`em:a96688`).
