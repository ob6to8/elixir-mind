---
id: em:a96688
type: belief
title: Plan artifacts compress the decisions and leave the bodies to the agent
description: Structured plan artifacts encode the decisions — interfaces, layout, call order — exactly, while deliberately leaving function bodies to the implementing agent, where implementation freedom is cheap.
provenance: "Claude Code session (claude-fable-5), 2026-07-26 — synthesized in the pseudocode-plans thread while reconciling the wsff.md program-design method with Dex Horthy's spec-length bound; ratified as a belief by the operator in the same thread"
tags: [belief, planning, program-design, coding-agents, context-transfer]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: agent-authored
  agent: "Claude Code agent, pseudocode-plans session — operator-directed belief filing"
  why: "operator directed filing this session-synthesized statement as a belief, with the session thread as its provenance once captured"
---

# Plan artifacts compress the decisions and leave the bodies to the agent

The belief, stated (synthesized in the originating session, quoted verbatim from
its delivered response):

> "The artifacts compress the *decisions* (interfaces, layout, call order) while
> leaving function bodies to the agent."

It reconciles two priors that would otherwise pull against each other:
[plan artifacts surface decisions otherwise made implicitly at code review](/beliefs/plan-artifacts-surface-implicit-review-decisions.md)
(so encode more structure into the plan) and
[a spec detailed enough to reliably generate quality code is roughly as long as the code](/beliefs/spec-detail-approaches-code-length.md)
(so encoding *everything* is self-defeating). The resolution: a plan's
structured artifacts capture exactly the load-bearing decisions — what the units
are (interfaces/signatures), where they live (layout/file trees), and how they
compose (call order/flow trees) — and stop there, leaving function bodies to
implementation, where the agent's freedom is cheap and review catches what
matters.

Acted on as the granularity rule of the
[structured-plan-bodies policy](/meta/policy/structured-plan-bodies.md).

# Citations

- The originating session's thread doc under `meta/threads/` (captured at PR
  time; the route-tagged excerpt log below aggregates the relevant passages once
  materialized).

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:a96688">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-26-structured-plan-bodies-and-belief-layer (2026-07-26)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:a96688`]**  (co-feeds: `em:1eebdf em:0c4913`)

Two boundaries matter. This is **outline-level pseudocode, not full pseudocode**: Dex's adjacent post makes the constraint explicit — "a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself — so don't review those things." The artifacts compress the *decisions* (interfaces, layout, call order) while leaving function bodies to the agent. And it's not prose-free: the artifacts sit inside a narrative doc; they replace the *ambiguous* part of prose, not the rationale.

---

**[`em:a96688`]**  (co-feeds: `em:1eebdf em:0c4913 em:6c7e85`)

add the following to the belief list, with a link to the dex article as provenance:
""a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself" and then a belief that depends on that belief: "so don't review those things.""
also: "every one of them is a decision you'd otherwise be making implicitly during code review" (define "every one")
"The artifacts compress the decisions (interfaces, layout, call order) while leaving function bodies to the agent" - provenance will be this thread (does this mean we should open the pull request now to get the thread doc to tie all these to for provenance?

---

**[`em:a96688`]**  (co-feeds: `em:1eebdf em:0c4913 em:6c7e85`)

- **Belief layer ratified and seeded.** Your "add to the belief list" instruction was the ratification the [belief-layer plan](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/plans/belief-type-and-beliefs-namespace.md) was waiting on, so I executed its build order: `belief` type in the vocabulary (with the epistemic/teleological filing test), [`/beliefs/`](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/beliefs/index.md) rewritten as the layer's home, and a verifier regression test pinning that `verified` on a `belief` is rejected. Four seed beliefs, each quoting its source verbatim: the Dex spec-length thesis (`em:1eebdf`), **"so don't review those things"** (`em:0c4913`, carrying `depends_on: [em:1eebdf]` — the dependency you specified), the wsff quote with **"every one of them" resolved in the body** to its referent (call-stack trees, file-tree diffs, type signatures — `em:6c7e85`), and my synthesis about compressing decisions (`em:a96688`).
