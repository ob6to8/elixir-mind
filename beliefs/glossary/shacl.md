---
id: em:4d3462
type: concept
title: SHACL (Shapes Constraint Language)
description: The W3C language (Recommendation 2017) for validating RDF graphs against declared shapes — closed-world constraint checking that reports violations, as distinct from OWL's open-world inference.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, knowledge-representation, rdf, shacl, validation, semantic-web]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:30:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-28 ontology-guardrails thread as the formalism that encodes the constraints OWL cannot"
---

# SHACL (Shapes Constraint Language)

A *shape* names a target set of nodes in an RDF graph and the conditions their
properties must meet — cardinality (`sh:minCount`/`sh:maxCount`), datatypes,
value ranges, permitted classes — and validation returns a report of violations
rather than a set of entailments.

The contrast with [OWL](/beliefs/glossary/owl.md) is the point, and the two are
routinely confused because both describe RDF vocabularies. OWL is an inference
logic under the [open world assumption](/beliefs/glossary/open-world-assumption.md):
it derives what must also be true, and a "functional" property yields an identity
inference rather than an error. SHACL is a validator under a closed-world reading
of the data graph: it reports what is missing or excessive. For agent guardrails
this makes SHACL the formalism that expresses the common invariants — at most one
refund per order, a required field, a bounded value set — that an ontology alone
cannot enforce (see the
[ontology-guardrails analysis](/meta/analysis/ontology-guardrails-vs-schema-validation.md)).

*Seen in:* [ontology guardrails vs. schema validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:4d3462">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-ontology-guardrails-intake-and-jido-comparison (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:4d3462`]**  (co-feeds: `em:1df031 em:8255b8 lib/elixir_mind/verifier.ex`)

Yes — and researching them changes the answer to both. I read `lib/elixir_mind/verifier.ex` to check a hunch, and it holds.

**The finding: this repo already *is* the level-3 layer**

The analysis recommended splitting enforcement by world assumption, with a closed-world constraint layer at level 3 — and then filed that recommendation as hypothetical. It isn't. `mix brain.verify` is a closed-world constraint checker over a typed graph, and it already implements every category of catch Coyle uses ontologies to motivate:

| Coyle's catch | His formalism | `brain.verify`'s equivalent | SHACL analogue |
|---|---|---|---|
| `"probably shipped"` — closed value set | `owl:oneOf` | Rule 7: `sense` ∈ {common, repo, dual}; `attribution.channel` controlled | `sh:in` |
| Payout to support desk — **disjointness** | `owl:disjointWith` | Rule 6: `verified` may appear *only* on `claim`/`note`/`concept`; attribution exemptions must carry none | `sh:targetClass` + `sh:not` |
| Second refund — **conditional cardinality** | (fails — needs SHACL) | Rule 5: `verified: true` ⇒ non-empty `verified_by`; Rule 4: `verified: true` ⊕ `resource` | `sh:minCount` under a condition |
| — | — | Rules 3, 8: `verified_by` and `attribution.from` refs must resolve | referential integrity |

The bundle is the typed graph; `em:` ids are the individuals; the verifier is the reasoner. It's ~140 lines of dependency-free Elixir, wired into CI and the pre-commit hook, with the rule set written as a numbered moduledoc that reads exactly like a shapes file.

So the analysis derived a recommendation from first principles and the repo it was filed in is a shipped existence proof of it. That's a stronger result than the analysis claimed, and it resolves both strands.

**Strand 1 — close it. The question was mis-posed.**

"Whether a level-3 closed-world constraint layer is ever wanted here" presupposes there isn't one. There is: `brain.verify` + `brain.route_tags` + `brain.glossary` together. Nothing needs building; what needs correcting is the analysis's framing, which treats its own host as a hypothetical.

The substantive upgrade: the recommendation stops being "here's what you'd do if you built one" and becomes "here's the pattern, validated in production, at a known cost" — roughly 140 lines plus a mix task per rule family, no dependencies, mechanical oracle. That's a far more useful thing for a future session to read.

**Strand 2 — close it as declined, not paused.**

Once strand 1 collapses, strand 2's real question changes from *"is SHACL-over-SPARQL.ex worth a spike if a layer is built?"* to *"should the existing layer's rules be re-expressed as SHACL shapes?"* — and the contract already answers that. The admission rule: a check earns a gate when its "**signal beats its upkeep** *and* it runs offline as a plain `mix` task with no dependencies." SHACL-over-SPARQL.ex would add two deps, require materializing the bundle as an RDF graph on every run, and buy declarativeness the Elixir already has in readable form. It belongs in the contract's named intentional-gaps list beside Credo and Dialyzer, not in a pending-spike queue.

One caveat worth stating: this closes the question *for this repo's rule set*, whose shapes are simple and stable. It does not close it for a hypothetical system with hundreds of churning domain constraints authored by non-programmers — that's where a declarative shapes file earns its dependency. Naming that boundary is what makes the "no" durable rather than merely current.

**How to land it**

Extend the existing analysis rather than filing new (one artifact per matter): add a section — call it *"The host is the existence proof"* — carrying the mapping table above, then flip both ledger rows to `closed`.

One question I'd rather surface than assume: the routing ledger lives in a **frozen** thread doc, and session-capture has `/capture` maintain it "at capture time." A strand that resolves in a *later* session has no documented update path — the `open`/`paused` states imply strands are meant to close eventually, but the policy never says who marks them. I'd resolve it by having *this* session's capture record the closure and updating the prior thread's rows to point at it, but that's a small policy gap worth your ratification rather than my improvisation.

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Extend the analysis + close both strands (Recommended) | New section with the verify↔SHACL mapping; both ledger rows → `closed`; fresh branch off `main`, since #163 is merged |
| 2 | Also add SHACL to the contract's intentional-gaps list | Makes the "no" bind future sessions unprompted, rather than sitting in an analysis they'd have to go looking for — a policy edit, so `/render-contract` after |
| 3 | File the ledger-upkeep gap as an `issue` | The "who closes a strand after capture" question is a real hole in the policy, independent of this matter |
| 4 | Leave both strands as-is | Defensible if you'd rather not spend a PR on a reframing, though the analysis stays weaker than its evidence supports |
