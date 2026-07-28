---
id: em:8255b8
type: reference
title: "FOL and OWL: fully formal knowledge representation"
description: First-order logic and the W3C Web Ontology Language (OWL 2) — the fully formal end of the knowledge-representation spectrum, with provable semantics, decidability trade-offs, and the authoring cost that motivates semiformal middle layers.
resource: https://www.w3.org/TR/owl2-overview/
provenance: "Distilled from the Wikipedia article on first-order logic and the W3C OWL 2 overview, fetched 2026-07-11; layered breakdown via /summarize-technical"
tags: [knowledge-representation, logic, first-order-logic, owl, description-logic, ontology, semantic-web, formal-methods]
timestamp: 2026-07-11
attribution:
  when: 2026-07-11T09:07:29+00:00
  channel: intake
  agent: "Claude Code agent, /intake"
  why: "operator-directed prior-art capture for the belief-decomposition assessment; body later restructured via /summarize-technical"
---

# FOL and OWL: fully formal knowledge representation

## Summary

These are the two landmark systems for writing statements so precisely that a
machine can *prove* what follows from them — the fully formal end of the
knowledge-representation spectrum, against which any semiformal scheme
defines itself.

The first, developed in the 1880s and mature by 1929, is a general language
of objects, their properties, and the relations between them, with the two
quantities "for all" and "there exists." Its powers and limits are theorems.
Everything that genuinely follows from a set of statements can be found by
mechanical proof search (nothing valid is out of reach); but there is no
procedure that always *terminates* when asked whether something follows — if
the answer is no, the search may run forever. And no set of statements in the
language can pin down an infinite structure like the whole numbers uniquely;
unintended interpretations always sneak in.

The second (a web standard, 2009) is a deliberately weakened descendant built
for publishing machine-readable vocabularies — categories, relationships,
individuals — on the web. By restricting what can be said, it buys what the
general language cannot offer: reasoning that is guaranteed to terminate, and
in its most restricted variants, guaranteed to be *fast*. It comes in graded
strengths, each targeting a workload: huge medical-style vocabularies,
database-backed query answering, or rule engines.

Together they mark the trade the formal pole offers: provable consequence
and mechanical consistency checking, purchased with expressive restriction
and heavy authoring cost — real prose does not compile into either.

## Key terms

- **Term / formula / sentence** — the syntax hierarchy: terms name objects
  (variables, constants, function applications); formulas state propositions
  (predicates over terms, combined by connectives and quantifiers ∀/∃); a
  sentence is a formula with no free variables, so its truth needs no further
  context.
- **Signature** — the non-logical vocabulary a theory chooses: its predicate,
  function, and constant symbols. The formal analogue of "what this document
  is allowed to talk about."
- **Structure (interpretation)** — a domain of objects plus an assignment of
  the signature's symbols to actual relations and functions over it; the
  thing formulas are true *in*.
- **Satisfaction (Tarski truth)** — the inductive definition of "structure M
  makes formula φ true" (M ⊨ φ), the anchor for every other semantic notion.
- **Validity / logical consequence** — true in every structure / true in
  every structure satisfying the premises. Consequence is the formal
  counterpart of the entailment judgments a belief graph asks for per edge.
- **Soundness & completeness (Gödel 1929)** — proof systems for first-order
  logic derive exactly the valid formulas: syntactic derivability and
  semantic consequence coincide.
- **Semidecidability (Church–Turing)** — consequence can be *confirmed* by
  exhaustive proof search but not refuted in general: no algorithm decides
  arbitrary entailment. The fundamental ceiling on formal auditing.
- **Compactness / Löwenheim–Skolem** — a theory is satisfiable if every
  finite part is; and satisfiable theories have countable (hence unintended)
  models — no first-order theory uniquely characterizes an infinite
  structure.
- **Description logic** — decidable FOL fragments engineered for
  concept/role/individual reasoning; **SROIQ** is the one underlying OWL 2.
- **OWL 2 DL vs. OWL 2 Full** — the syntactically restricted species that
  translates into SROIQ (decidable, under *Direct Semantics*) versus the
  unrestricted reading over arbitrary RDF graphs (*RDF-Based Semantics*,
  expressive but undecidable); a correspondence theorem keeps the two
  readings consistent where they overlap.
- **Profiles (EL / QL / RL)** — OWL 2's graded sub-languages with
  computational guarantees: EL gives polynomial-time reasoning for very large
  ontologies; QL answers conjunctive queries inside relational-database
  complexity (AC⁰) over big instance sets; RL supports rule-engine
  implementation directly on RDF triples.
- **Reasoning tasks** — the standard machine services: consistency,
  class satisfiability, subsumption/classification, instance retrieval —
  i.e. mechanical detection of contradiction and hierarchy.

## Technical summary

First-order logic fixes a signature, builds terms and formulas over it, and
interprets them in structures via Tarskian satisfaction; validity and logical
consequence are quantification over all structures. Gödel completeness makes
consequence provable (sound + complete calculi: Hilbert systems, natural
deduction, sequent calculus, resolution), compactness and Löwenheim–Skolem
bound what theories can pin down, and Church–Turing semidecidability caps
mechanical audit: entailment is confirmable, non-entailment not generally so.
Categorical characterization of infinite structures requires second-order
quantification, which sacrifices the completeness theorem.

OWL 2 packages a description-logic fragment for the web: ontologies of
classes, object/data properties, individuals, and axioms, exchangeable as RDF
(RDF/XML mandatory; Functional, Manchester, Turtle, OWL/XML optional). OWL 2
DL's Direct Semantics is model-theoretically aligned with SROIQ, so
consistency, subsumption, classification, and instance retrieval are
decidable; OWL 2 Full's RDF-Based Semantics drops all syntactic restriction
and decidability, with a correspondence theorem linking the two. The EL/QL/RL
profiles trade expressiveness for complexity guarantees (PTIME / AC⁰ query
answering / PTIME rule-based, respectively).

For a semiformal belief layer the relevant readings are: (1) entailment,
consistency, and
[minimal inconsistent subsets](/beliefs/glossary/minimal-inconsistent-subset.md) are
crisply defined only at this pole — semiformal analogues inherit the *shape*
of these notions while replacing the oracle with LLM judgment; (2) even here,
full generality is undecidable — guaranteed audit always comes from
restriction; (3) the authoring cost of formal ontologies is the standing
argument for keeping belief content in natural language and formalizing only
the *structure* around it.

## Why it is in this brain

FOL/OWL mark the fully formal pole against which a semiformal epistemic
substrate defines itself — what full formalization buys, and the
brittleness/authoring costs that motivate keeping beliefs in natural language
with an LLM as the local entailment oracle. See the
[belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md).

# Citations

- First-order logic — Wikipedia: <https://en.wikipedia.org/wiki/First-order_logic>
- OWL 2 Web Ontology Language Document Overview (Second Edition) — W3C:
  <https://www.w3.org/TR/owl2-overview/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:8255b8">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-ontology-guardrails-intake-and-jido-comparison (2026-07-28)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:8255b8`]**

so, to be fair, jido should be compared to pydantic, not the ledger, which floats above either of them?
does the ledger encode the logic necessary to enforce catch 1 and 2? what exactly is coyle's ledger written in?
Is owl/jido a formal logic? what would adopting it as the level 2/3 enforcement layer offer vs writing a custom one in elixir?

---

**[`em:8255b8`]**  (co-feeds: `em:44f899 em:1df031`)

**1. Yes — and the correction matters**

Your framing is right, with one refinement: Jido spans *more* positions than Pydantic, just not the ledger one. Pydantic occupies only the door. Jido occupies the door (Action `schema:`), the loop (`cmd/2` + Strategies), and the effect boundary (Directives). What floats above all of them is a **domain model** — orthogonal to whichever framework carries the loop. Coyle's own layering says as much: "check your types with Pydantic and then check your results with the ontology." Types are a property of *the call*; the ontology is a property of *the world*. No agent framework can supply the latter, because it's your business's model, not the framework's.

So the fair comparison is: Jido ⊃ Pydantic at the door, Jido = a purity mechanism Coyle only prescribes as discipline, and the ledger is unowned by either.

**2. Does the ledger encode the logic for the two Jido misses? Only one cleanly.**

**Misdirected payout (disjointness) — yes, cleanly.** `owl:disjointWith(Customer, SupportRep)` means no individual can be both; a reasoner reports the graph inconsistent the moment you assert one. That's real logical work.

But there's a hidden precondition: **the payee has to be a typed individual in the graph, not a string in a JSON field.** If your tool returns `{"payee": "desk-07"}`, no ontology on earth helps — you first have to materialize that string as an entity with a class. That materialization step is the actual cost of the ledger, and Coyle skips over it.

**Double refund (once-only) — no, not the way you'd expect, and this is a genuine flaw in the talk.** Two OWL semantics work against you:

- **No unique name assumption.** Declare `hasRefund` an `owl:FunctionalProperty` and assert `order123 hasRefund R1` and `order123 hasRefund R2`. OWL does **not** raise an error. It concludes `R1 owl:sameAs R2` — the two refunds are inferred to be *the same refund*. That's the precise opposite of the guardrail. You only get an inconsistency if you *additionally* assert `R1 owl:differentFrom R2`, or the two carry conflicting values on some other functional property (different amounts).
- **Open world assumption.** Not finding a prior refund never entails there wasn't one. "Has this already been refunded?" is inherently a *closed-world* question, and OWL is built to refuse exactly that inference.

The formalism that does encode this is **SHACL** (W3C Rec, 2017) — closed-world constraint validation over RDF graphs, where `sh:maxCount 1` means what a programmer expects: a violation report. Coyle names RDFS and OWL and never mentions SHACL. His flagship example is the one his named tools handle worst.

**3. Coyle's ledger is written in nothing — he never implements it**

I went back through the transcript. He names no reasoner, no library, no triplestore. What's on the slide is a placeholder inside a comment block:

> "Now, I have this stuff in red here. This is where I think the … ontologies and stuff can come in. … The tool's going to give us information. We put the information in a form that our validator can use, and **think about the validator as operating with** these ontologies about our domain"

and, at the close, "**you can have** a reasoner built on ontology to check keep the LLM on track." Both are subjunctive. The working code in the talk is the ordinary Claude tool-use loop plus Pydantic; the ledger is a red annotation on a slide marking where a thing would go. Worth knowing before costing out an implementation — you're not adopting his design, you're originating it.

**4. OWL is a formal logic. Jido is not. That distinction decides the build question.**

**OWL: yes, unambiguously.** OWL 2 DL is a syntactic variant of the description logic **SROIQ(D)** — a decidable fragment of first-order logic with model-theoretic semantics and sound-and-complete reasoners (HermiT, ELK, Pellet). The brain already holds this in [FOL and OWL](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md) (`em:8255b8`), including the decidability trade-offs and the profile hierarchy.

**Jido: no.** NimbleOptions/Zoi schemas are runtime predicates over values. There's no entailment relation, no semantics, no reasoner. The categorical difference: **a schema decides membership; a logic derives consequences.** A schema can reject `"probably shipped"` but can never tell you something you didn't assert.

**What adopting OWL buys vs. custom Elixir**

| | OWL/RDF ledger | Custom Elixir |
|---|---|---|
| **Derived facts** | Free — transitivity, domain/range typing, subclass closure, all maintained by the reasoner | You hand-code each inference and keep them mutually consistent |
| **Global consistency** | Reasoner checks the *whole* graph, catching constraint interactions you never thought to test | Checks exactly what you wrote a check for |
| **Model as data** | Domain model editable/auditable without redeploying; a domain expert can read it | Model is code |
| **Vocabulary reuse** | schema.org, FOAF, Dublin Core off the shelf | From scratch |
| **"Already happened?"** | Fights you (OWA/UNA) — needs SHACL or closed-world hacks bolted on | Native. A unique index. Trivial |
| **Runtime cost** | **No mature OWL DL reasoner on the BEAM.** RDF.ex and SPARQL.ex are solid for representation and query, and RDF.ex ships OWL only as a *vocabulary* (namespace terms), not inference. You'd run HermiT/openllet (JVM) or owlready2 (Python) out-of-process, or a reasoning triplestore — a second runtime, the exact blocker already flagged against Jido's `req_llm` cognition dependency | None |
| **Authoring cost** | High — the brain's own FOL/OWL capture concludes "the authoring cost of formal ontologies is the standing argument for keeping belief content in natural language and formalizing only the *structure* around it" | Low |

**My recommendation: split the levels rather than adopting one formalism for both.**

The sharpest thing I can tell you is that **none of Coyle's three examples need a reasoner.** The enum is a schema. Disjointness is a type — and Elixir does this *better* than OWL, at compile time, with distinct structs, where OWL does it at runtime over an open world. Once-only is a unique index. He uses these three to motivate ontologies, but they're the weakest possible case for one: all three are *rejected input*, and inference is for *derived knowledge*.

So: level 2 (per-entity shape, closed value sets, entity kinds) → Jido's schemas plus Elixir's type system, which you already have. Level 3 (relational/temporal invariants over history) → a closed-world constraint layer, which if you want it declarative is SHACL-shaped, and SHACL over SPARQL.ex has been demonstrated in Elixir. Reach for OWL proper only if you need derived facts or published-vocabulary reuse — real motivations, but different ones than the talk advertises.

---

This has grown past a chat answer — there's a defensible judgment here (the talk's motivating examples undercut its own thesis; SHACL is the missing formalism; the BEAM has no reasoner) that the existing Jido evaluations would want to cite.

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | File as `analysis` — "ontology guardrails vs. schema validation for agent loops" (Recommended) | Captures the OWA/UNA finding, the level-2/3 split, and the recommendation; joins the Jido evaluation cluster in `meta/analysis/` |
| 2 | Add a "Critique" section to the Coyle reference | Cheaper, but mixes derived judgment into a capture — the routing policy prefers option 1 |
| 3 | Leave it in chat; `/capture` records it in the thread | Fine if this was orientation rather than a design input |

---

**[`em:8255b8`]**  (co-feeds: `em:1df031 em:4d3462 lib/elixir_mind/verifier.ex`)

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
