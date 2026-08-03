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

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:0c4913">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-26-structured-plan-bodies-and-belief-layer (2026-07-26)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:0c4913`]**  (co-feeds: `em:1eebdf em:a96688`)

Two boundaries matter. This is **outline-level pseudocode, not full pseudocode**: Dex's adjacent post makes the constraint explicit — "a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself — so don't review those things." The artifacts compress the *decisions* (interfaces, layout, call order) while leaving function bodies to the agent. And it's not prose-free: the artifacts sit inside a narrative doc; they replace the *ambiguous* part of prose, not the rationale.

---

**[`em:0c4913`]**  (co-feeds: `em:1eebdf em:6c7e85 em:a96688`)

add the following to the belief list, with a link to the dex article as provenance:
""a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself" and then a belief that depends on that belief: "so don't review those things.""
also: "every one of them is a decision you'd otherwise be making implicitly during code review" (define "every one")
"The artifacts compress the decisions (interfaces, layout, call order) while leaving function bodies to the agent" - provenance will be this thread (does this mean we should open the pull request now to get the thread doc to tie all these to for provenance?

---

**[`em:0c4913`]**  (co-feeds: `em:1eebdf em:6c7e85 em:a96688`)

- **Belief layer ratified and seeded.** Your "add to the belief list" instruction was the ratification the [belief-layer plan](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/plans/belief-type-and-beliefs-namespace.md) was waiting on, so I executed its build order: `belief` type in the vocabulary (with the epistemic/teleological filing test), [`/beliefs/`](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/beliefs/index.md) rewritten as the layer's home, and a verifier regression test pinning that `verified` on a `belief` is rejected. Four seed beliefs, each quoting its source verbatim: the Dex spec-length thesis (`em:1eebdf`), **"so don't review those things"** (`em:0c4913`, carrying `depends_on: [em:1eebdf]` — the dependency you specified), the wsff quote with **"every one of them" resolved in the body** to its referent (call-stack trees, file-tree diffs, type signatures — `em:6c7e85`), and my synthesis about compressing decisions (`em:a96688`).

### 2026-08-02-complete-spec-prompting-vs-iterative-delivery (2026-08-02)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:0c4913`]**  (co-feeds: `em:1eebdf /meta/analysis/complete-spec-prompting-vs-iterative-delivery.md`)

Cons: the waterfall failure mode amplified (requirements guessed before contact with the implementation, then built wrong at volume); the **spec-detail paradox** your own belief layer captures — "a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself" ([em:1eebdf](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/spec-detail-approaches-code-length.md), quoting Dex Horthy), at which point it loses its review advantage ("so don't review those things," em:0c4913); no ratification channel for mid-run ambiguity, so the executor's interpretations land silently; review arriving end-loaded as one large diff, which is exactly the shape [verified increments](https://github.com/ob6to8/elixir-mind/blob/main/meta/doctrine/verified-increments.md) rejects; and invariants that are attention-enforced — Anthropic's own guidance states the decay: "Claude's context window fills up fast, and performance degrades as it fills."
