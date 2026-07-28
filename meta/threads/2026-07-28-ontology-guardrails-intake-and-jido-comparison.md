---
type: reference
title: 2026-07-28-ontology-guardrails-intake-and-jido-comparison
description: A YouTube intake of Frank Coyle's "Why Agentic Systems Need Ontologies" opened a comparison against Jido 2's actions/directives, which escalated into an analysis finding that OWL's open-world semantics invert the talk's flagship double-refund catch, that the talk never implements its ledger, and that none of its three examples need inference.
provenance: "Claude Code session (Claude Opus 5), 2026-07-28; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, ontology, owl, shacl, jido, elixir, agents, guardrails, neurosymbolic-ai]
timestamp: 2026-07-28
session: https://claude.ai/code/session_01XJvjudVdVWHdCNdQLFxWap
pr: 163
---

# 2026-07-28-ontology-guardrails-intake-and-jido-comparison

## Where this landed

A single `/intake` of a conference talk that turned into a design evaluation. The
talk — Frank Coyle (UC Berkeley) at AI Engineer, 21 minutes — argues that agent
failures like double refunds and invented order statuses are symptoms of one
missing layer: a formal ontology outside the model, applied as a validator on the
tool-use loop, under the slogan "Pydantic at the door, ontology at the ledger."
YouTube's bot check blocked the ordinary fetch path, so the transcript came via
`yt-dlp` with an alternate player client; the full 3,100-word transcript and the
video description grounded the capture. Filed as `em:1df031` under
`knowledge/SWE/agentic/agentic-loop/`, cross-linked to the existing FOL/OWL
knowledge-representation capture.

The operator's follow-up — whether Jido 2's directives/actions already implement
this pattern — is what made the session more than a capture. The answer split
cleanly: Jido occupies the **door** (Action schemas, where `to_tool/0` derives the
LLM's tool schema from the same declaration that validates at execution, so the
two cannot drift as they can in the talk's Python) and the **effect boundary**
(Directives return effects as data for the runtime to interpret, making Coyle's
"no side effects" prescription structural rather than a discipline). It does not
occupy the ledger, and Directives are the effect-deferral mechanism, not the
checking one.

The operator then pressed on three points that reframed the verdict, and each held
up against the sources. First, Jido is rightly compared to Pydantic, with the
ledger floating above either — correct, because the ledger models the business,
not the loop. Second, OWL does **not** encode the talk's flagship double-refund
catch: under the no-unique-name assumption a functional property infers
`owl:sameAs` between the two refunds rather than raising an error, and the open
world assumption declines the "has this already happened" question entirely.
SHACL's `sh:maxCount` is the formalism that encodes it, and the talk never
mentions SHACL. Third, re-reading the transcript confirmed Coyle **never
implements the ledger** — the code slide carries a red placeholder ("this is where
I think the … ontologies and stuff can come in"), and the working code is a bare
tool-use loop plus Pydantic.

The recommendation that fell out: none of the three motivating catches need
inference. An enum is a schema, disjointness is a type Elixir expresses better at
compile time, once-only is a unique index. Split the enforcement stack by world
assumption — schemas plus the type system at level 2, a closed-world
(SHACL-shaped, often just a DB constraint) layer at level 3 — and reserve OWL for
derived knowledge and vocabulary reuse. The absent BEAM reasoner (RDF.ex ships OWL
as a vocabulary, not inference) lands as the same second-runtime blocker already
standing against Jido's `req_llm` cognition dependency, so nothing here moves the
repo's standing "not now."

The operator ratified filing the comparison as an analysis rather than folding it
into the capture. A container clock skew was caught during capture and the two new
docs' dates corrected from 07-27 to 07-28 before the PR landed. That work merged
as PR #163 (`47e1024`).

**Follow-up, same session (a second PR).** Asked whether the two strands the
ledger left open should be addressed, the session read
`lib/elixir_mind/verifier.ex` and found the analysis had filed its own
recommendation as hypothetical while running inside a shipped instance of it.
`mix brain.verify` *is* a closed-world constraint checker over the bundle's typed
graph — the bundle is the graph, `em:` ids are the individuals, and its numbered
moduledoc reads as a shapes file — implementing every category of catch the talk
motivates: controlled value sets (rule 7), type-disjointness (rule 6), conditional
cardinality (rules 4-5), and referential integrity (rules 3, 8). That collapses
both strands: the level-3 layer is not hypothetical but built, and the SHACL
question changes from "worth a spike?" to "worth porting?", which the coding
standards' admission rule already answers no. The operator ratified all three
follow-up actions — extend the analysis with an existence-proof section and close
both rows, bind the SHACL refusal into the
[coding standards](/meta/policy/elixir-coding-standards.md) so it reaches future
sessions unprompted, and file the ledger-upkeep gap as an
[issue](/meta/issues/routing-ledger-has-no-post-capture-upkeep-path.md). Per the
write-once rule this thread keeps `pr: 163` as its origin anchor; the follow-up
landed in a second PR.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Coyle talk — ontology as neurosymbolic loop guardrails | closed | [why-agentic-systems-need-ontologies](/knowledge/SWE/agentic/agentic-loop/why-agentic-systems-need-ontologies.md) | - |
| Does Jido 2 implement the validator pattern? | closed | [ontology-guardrails-vs-schema-validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md) | - |
| Jido's actions/directives as door + effect boundary | closed | [Jido glossary](/beliefs/glossary/jido.md) | - |
| OWL's OWA/UNA vs. the double-refund catch; SHACL as the right formalism | closed | [first-order-logic-and-owl](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md) | - |
| Coyle never implements the ledger (transcript-verified) | closed | [ontology-guardrails-vs-schema-validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md) | - |
| Split enforcement stack by world assumption | closed | [ontology-guardrails-vs-schema-validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md) | - |
| No mature OWL reasoner on the BEAM | closed | [ontology-guardrails-vs-schema-validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md) | - |
| `mix brain.verify` as a shipped level-3 constraint layer | closed | [ontology-guardrails-vs-schema-validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md) | - |
| Bind the SHACL refusal into the coding standards | closed | [elixir-coding-standards](/meta/policy/elixir-coding-standards.md) | - |
| Routing ledger has no post-capture upkeep path | open | [routing-ledger-has-no-post-capture-upkeep-path](/meta/issues/routing-ledger-has-no-post-capture-upkeep-path.md) | Which of the three fixes to adopt — permit State edits, forward-only, or derive the column |
| YouTube fetch blocked; yt-dlp alternate player client | closed | `unrouted` | Whether the intake skill should document a video-transcript path |

## User

/intake https://www.youtube.com/watch?v=Sir59K8ZDPU

## Assistant

<routes ref="em:1df031">
Intake complete. The video is **"Why Agentic Systems Need Ontologies" — Frank Coyle (UC Berkeley)**, a 21-minute AI Engineer conference talk (uploaded 2026-07-23). I pulled the full transcript and description via yt-dlp, found no existing document on this material (the closest neighbors — the FOL/OWL knowledge-representation capture and the agentic-loop references — cover adjacent but distinct subjects), and filed it as a new `reference` with a layered `/summarize-technical`-style body. The talk's thesis: agent failures like double refunds and invented statuses are symptoms of a missing formal layer — an RDFS/OWL ontology used as a neurosymbolic validator wrapped around the Claude tool-use loop, per his slogan "Pydantic at the door, ontology at the ledger."

**What I created**

| type | doc | why this type |
|---|---|---|
| `reference` | why-agentic-systems-need-ontologies (`em:1df031`), filed in `knowledge/SWE/agentic/agentic-loop/` | external talk, fetched and summarized — the definition of a processed capture; filed with the loop-engineering references since its core move is a validation stage inside the tool-use loop |

**What I modified**

| file | thrust of the change |
|---|---|
| `knowledge/SWE/agentic/agentic-loop/index.md` | added the new reference under "Reliability & long-horizon" |
| `meta/registry.md` | regenerated after minting `em:1df031` |

**Actions I have taken**

| action | result |
|---|---|
| Fetched video metadata + transcript (~3,100 words) + description | captured in full; oversized raw source relegated to `resource` + `# Citations` per the filing rule |
| Synonym-expanded dedup search (ontology, neurosymbolic, RDFS/OWL, knowledge graph, guardrails, Pydantic, tool-use loop) | no duplicate; cross-linked the FOL/OWL capture and the glossary's ontology/OWL/knowledge-graph terms instead |
| `mix brain.id`, `brain.registry`, `brain.verify`, `brain.dedup_probe --update-baseline` | all green; plain recall 6/15, no regression (gold-row harvest skipped — bare URL, no natural phrasing) |
| Commit + push to `claude/intake-video-review-31aiyw` | landed as `2f0f433`, all pre-commit gates passed (183 tests, 0 failures) |

The branch is pushed with the intake complete; say the word if you'd like a PR opened (`/create-pull-request`).
</routes>

## User

re: "The operational pattern: wrap a Claude tool-use loop with a validator — when the model proposes a tool call, check the parameter types with Pydantic and the results against the ontology, and only then let the action through" - is this also how the elixir jido2 library works, specifically with directives/actions?

## Assistant

<routes ref="em:44f899 em:1df031">
Partly — and the way it diverges is the interesting part. Jido 2 matches two of Coyle's three layers, one of them *better* than his Python version, but the layer his entire talk is about is the one Jido doesn't have.

## Where the analogy holds

**"Pydantic at the door" — Jido's Action schema, and it's a stronger design.** A `Jido.Action` declares a schema, and the documented hook order runs "parameters are processed, followed by `on_before_validate_params`, then schema validation, `on_after_validate_params`, and finally the `run` function," with output validation after. That is structurally Coyle's door check.

The improvement over his setup: the *same* schema declaration generates the LLM tool definition. `to_tool()` emits `parameters_schema` as JSON Schema for the model, and `Jido.Action.Tool.execute_action/3` re-validates the model's actual arguments (handling string keys and type coercion) on the way in. In Coyle's Python, the tool schema you send to Claude and the Pydantic model that guards execution are two artifacts that can silently drift apart. In Jido they're one source of truth. That's a real architectural win on the door half.

**"No side effects" — that's what Directives actually are.** Coyle prescribes it as discipline: "your agents should try to have no side effects... they're not running off doing something that they're changing things in the database not yet." Jido makes it structural. An action's `run/1` returns *data describing* effects — `%Directive.Emit{}`, `Spawn`, `Schedule`, `Cron` — and the runtime interprets them. The pure `cmd(agent, {Action, params}) → {updated_agent, directives}` reducer never performs I/O, which is why it's replayable and testable without an LLM ([functional core, imperative shell](/beliefs/glossary/functional-core-imperative-shell.md)).

## Where it breaks — Directives are not the validator

This is the crux: **Directives are the effect-deferral mechanism, not the checking mechanism.** They're the "don't touch the database yet" half. They are not the "and here's what decides whether you may" half. The runtime type-checks them structurally — a malformed instruction yields `%Jido.Agent.Directive.Error{}` — but nothing consults a domain model before interpreting one.

Jido's validation is **structural and local**; Coyle's ontology layer is **semantic and relational**. Run his three closing examples through Jido:

| Coyle's catch | Jido today |
|---|---|
| `"probably shipped"` — invented enum value | **Caught.** `status: [type: :atom, in: [:paid, :shipped, :refunded]]` — the closed value set is free, in both the tool schema and the runtime check |
| Payout to the support desk, not the buyer — disjoint classes | **Not caught.** Both are `:string` or `:map`. Nothing knows `Customer` and `SupportRep` are disjoint kinds |
| A second refund on the same order — once-only relation | **Not caught.** This is a cardinality constraint over a *relation across history*; no per-call schema can see it |

Note what separates row 1 from rows 2–3: row 1 is a constraint on **one field of one call**, which is exactly what NimbleOptions/Zoi express. Rows 2–3 are constraints over **entity classes and relationship histories** — OWL's disjointness and functional-property axioms. Jido's `output_schema` and agent state schema don't reach there either; they're per-record shape checks, just positioned later in the pipeline. There's no reasoner, no derived facts, no RDFS domain/range inference.

## Where the ontology layer would go if you wanted it

The natural seam is a custom **Strategy** — Strategies control how `cmd/2` executes, so that's Jido's analogue of Coyle's validator wrapping the loop, and it sits at the right altitude to see the instruction, the agent's state, and the returned directives together before the runtime interprets them. Per-action, `on_after_validate_output` is the cheaper hook. Either way you'd be writing the domain reasoner yourself; Elixir's RDF/OWL ecosystem is thin compared to Python's, and I haven't verified current options in this session.

**Short answer:** Jido gives you Coyle's door and his purity discipline, both better-engineered than the talk's Python sketch. It does not give you his ledger. If you adopted Jido expecting the guardrails argument to be satisfied, you'd get exactly the class of failure he opens with — the double refund and the misdirected payout both pass every check Jido ships with.

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | File this as an `analysis` under `meta/analysis/` | A queryable comparison doc; fits alongside the existing Jido evaluations, and the thin-jido-brain-host plan would want to cite it if that host ever needs semantic guardrails |
| 2 | Leave it in chat and let `/capture` record it | The comparison lives in the thread render; adequate if this was curiosity rather than a design input |
| 3 | Extend the Coyle reference with a "Jido comparison" section | Keeps it attached to the source, but mixes a capture with derived analysis — I'd recommend option 1 over this |
</routes>

## User

<routes ref="em:8255b8">
so, to be fair, jido should be compared to pydantic, not the ledger, which floats above either of them?
does the ledger encode the logic necessary to enforce catch 1 and 2? what exactly is coyle's ledger written in?
Is owl/jido a formal logic? what would adopting it as the level 2/3 enforcement layer offer vs writing a custom one in elixir?
</routes>

## Assistant

<routes ref="em:8255b8 em:44f899 em:1df031">
## 1. Yes — and the correction matters

Your framing is right, with one refinement: Jido spans *more* positions than Pydantic, just not the ledger one. Pydantic occupies only the door. Jido occupies the door (Action `schema:`), the loop (`cmd/2` + Strategies), and the effect boundary (Directives). What floats above all of them is a **domain model** — orthogonal to whichever framework carries the loop. Coyle's own layering says as much: "check your types with Pydantic and then check your results with the ontology." Types are a property of *the call*; the ontology is a property of *the world*. No agent framework can supply the latter, because it's your business's model, not the framework's.

So the fair comparison is: Jido ⊃ Pydantic at the door, Jido = a purity mechanism Coyle only prescribes as discipline, and the ledger is unowned by either.

## 2. Does the ledger encode the logic for the two Jido misses? Only one cleanly.

**Misdirected payout (disjointness) — yes, cleanly.** `owl:disjointWith(Customer, SupportRep)` means no individual can be both; a reasoner reports the graph inconsistent the moment you assert one. That's real logical work.

But there's a hidden precondition: **the payee has to be a typed individual in the graph, not a string in a JSON field.** If your tool returns `{"payee": "desk-07"}`, no ontology on earth helps — you first have to materialize that string as an entity with a class. That materialization step is the actual cost of the ledger, and Coyle skips over it.

**Double refund (once-only) — no, not the way you'd expect, and this is a genuine flaw in the talk.** Two OWL semantics work against you:

- **No unique name assumption.** Declare `hasRefund` an `owl:FunctionalProperty` and assert `order123 hasRefund R1` and `order123 hasRefund R2`. OWL does **not** raise an error. It concludes `R1 owl:sameAs R2` — the two refunds are inferred to be *the same refund*. That's the precise opposite of the guardrail. You only get an inconsistency if you *additionally* assert `R1 owl:differentFrom R2`, or the two carry conflicting values on some other functional property (different amounts).
- **Open world assumption.** Not finding a prior refund never entails there wasn't one. "Has this already been refunded?" is inherently a *closed-world* question, and OWL is built to refuse exactly that inference.

The formalism that does encode this is **SHACL** (W3C Rec, 2017) — closed-world constraint validation over RDF graphs, where `sh:maxCount 1` means what a programmer expects: a violation report. Coyle names RDFS and OWL and never mentions SHACL. His flagship example is the one his named tools handle worst.

## 3. Coyle's ledger is written in nothing — he never implements it

I went back through the transcript. He names no reasoner, no library, no triplestore. What's on the slide is a placeholder inside a comment block:

> "Now, I have this stuff in red here. This is where I think the … ontologies and stuff can come in. … The tool's going to give us information. We put the information in a form that our validator can use, and **think about the validator as operating with** these ontologies about our domain"

and, at the close, "**you can have** a reasoner built on ontology to check keep the LLM on track." Both are subjunctive. The working code in the talk is the ordinary Claude tool-use loop plus Pydantic; the ledger is a red annotation on a slide marking where a thing would go. Worth knowing before costing out an implementation — you're not adopting his design, you're originating it.

## 4. OWL is a formal logic. Jido is not. That distinction decides the build question.

**OWL: yes, unambiguously.** OWL 2 DL is a syntactic variant of the description logic **SROIQ(D)** — a decidable fragment of first-order logic with model-theoretic semantics and sound-and-complete reasoners (HermiT, ELK, Pellet). The brain already holds this in [FOL and OWL](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md) (`em:8255b8`), including the decidability trade-offs and the profile hierarchy.

**Jido: no.** NimbleOptions/Zoi schemas are runtime predicates over values. There's no entailment relation, no semantics, no reasoner. The categorical difference: **a schema decides membership; a logic derives consequences.** A schema can reject `"probably shipped"` but can never tell you something you didn't assert.

### What adopting OWL buys vs. custom Elixir

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
</routes>

## User

1
then /create-pull-request merge

## Assistant

Merged and the head branch was auto-deleted.

**Actions I have taken**

| action | result |
|---|---|
| `/capture` — thread doc, routing ledger, route tags | `2026-07-28-ontology-guardrails-intake-and-jido-comparison`; excerpt logs materialized into `em:1df031`, `em:44f899`, `em:8255b8` |
| Filed the analysis (option 1) | `ontology-guardrails-vs-schema-validation` |
| `/add-to-glossary` over the thread | 6 new terms: neurosymbolic AI, SHACL, open world assumption, unique name assumption, RDFS, Pydantic; *Seen in* extended on `ontology`, `owl`, `description-logic` |
| Stamped `attribution.from` and `pr: 163` | Analysis back-links to the thread; thread anchored to its origin PR |
| Resolved a mid-flight conflict with `main` | Main had landed a scar-tissue intake; five additive conflicts — both sides kept in the two indexes, the three generated artifacts (registry, glossary index, Jido excerpt log) re-derived from source rather than hand-merged |
| Drove CI green, true-merged | PR #163 → merge commit `47e1024`; head branch auto-deleted |

Two things worth flagging rather than burying. **`mix brain.dev_history` was skipped** — the container has a shallow clone, which is the documented skip condition, so the checked-in dev-history stays one PR further behind than usual; CI's lag-tolerant check passed. And the **GitHub check-runs endpoint served stale data** for about ten minutes, reporting `in_progress` on jobs that had completed successfully at 07:16:07 — I confirmed via the per-job endpoint before merging rather than trusting the aggregate.

The analysis leaves two strands open in the routing ledger, neither blocking: whether a level-3 closed-world constraint layer is ever actually wanted here, and whether SHACL-over-SPARQL.ex would merit a spike if one is built. Both sit behind the repo's standing "not now" on a resident runtime.

## User

should either of these two things be addressed? how could we resolve these two open strands?

## Assistant

<routes ref="em:1df031 em:8255b8 em:4d3462 lib/elixir_mind/verifier.ex">
Yes — and researching them changes the answer to both. I read `lib/elixir_mind/verifier.ex` to check a hunch, and it holds.

## The finding: this repo already *is* the level-3 layer

The analysis recommended splitting enforcement by world assumption, with a closed-world constraint layer at level 3 — and then filed that recommendation as hypothetical. It isn't. `mix brain.verify` is a closed-world constraint checker over a typed graph, and it already implements every category of catch Coyle uses ontologies to motivate:

| Coyle's catch | His formalism | `brain.verify`'s equivalent | SHACL analogue |
|---|---|---|---|
| `"probably shipped"` — closed value set | `owl:oneOf` | Rule 7: `sense` ∈ {common, repo, dual}; `attribution.channel` controlled | `sh:in` |
| Payout to support desk — **disjointness** | `owl:disjointWith` | Rule 6: `verified` may appear *only* on `claim`/`note`/`concept`; attribution exemptions must carry none | `sh:targetClass` + `sh:not` |
| Second refund — **conditional cardinality** | (fails — needs SHACL) | Rule 5: `verified: true` ⇒ non-empty `verified_by`; Rule 4: `verified: true` ⊕ `resource` | `sh:minCount` under a condition |
| — | — | Rules 3, 8: `verified_by` and `attribution.from` refs must resolve | referential integrity |

The bundle is the typed graph; `em:` ids are the individuals; the verifier is the reasoner. It's ~140 lines of dependency-free Elixir, wired into CI and the pre-commit hook, with the rule set written as a numbered moduledoc that reads exactly like a shapes file.

So the analysis derived a recommendation from first principles and the repo it was filed in is a shipped existence proof of it. That's a stronger result than the analysis claimed, and it resolves both strands.

## Strand 1 — close it. The question was mis-posed.

"Whether a level-3 closed-world constraint layer is ever wanted here" presupposes there isn't one. There is: `brain.verify` + `brain.route_tags` + `brain.glossary` together. Nothing needs building; what needs correcting is the analysis's framing, which treats its own host as a hypothetical.

The substantive upgrade: the recommendation stops being "here's what you'd do if you built one" and becomes "here's the pattern, validated in production, at a known cost" — roughly 140 lines plus a mix task per rule family, no dependencies, mechanical oracle. That's a far more useful thing for a future session to read.

## Strand 2 — close it as declined, not paused.

Once strand 1 collapses, strand 2's real question changes from *"is SHACL-over-SPARQL.ex worth a spike if a layer is built?"* to *"should the existing layer's rules be re-expressed as SHACL shapes?"* — and the contract already answers that. The admission rule: a check earns a gate when its "**signal beats its upkeep** *and* it runs offline as a plain `mix` task with no dependencies." SHACL-over-SPARQL.ex would add two deps, require materializing the bundle as an RDF graph on every run, and buy declarativeness the Elixir already has in readable form. It belongs in the contract's named intentional-gaps list beside Credo and Dialyzer, not in a pending-spike queue.

One caveat worth stating: this closes the question *for this repo's rule set*, whose shapes are simple and stable. It does not close it for a hypothetical system with hundreds of churning domain constraints authored by non-programmers — that's where a declarative shapes file earns its dependency. Naming that boundary is what makes the "no" durable rather than merely current.

## How to land it

Extend the existing analysis rather than filing new (one artifact per matter): add a section — call it *"The host is the existence proof"* — carrying the mapping table above, then flip both ledger rows to `closed`.

One question I'd rather surface than assume: the routing ledger lives in a **frozen** thread doc, and session-capture has `/capture` maintain it "at capture time." A strand that resolves in a *later* session has no documented update path — the `open`/`paused` states imply strands are meant to close eventually, but the policy never says who marks them. I'd resolve it by having *this* session's capture record the closure and updating the prior thread's rows to point at it, but that's a small policy gap worth your ratification rather than my improvisation.

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Extend the analysis + close both strands (Recommended) | New section with the verify↔SHACL mapping; both ledger rows → `closed`; fresh branch off `main`, since #163 is merged |
| 2 | Also add SHACL to the contract's intentional-gaps list | Makes the "no" bind future sessions unprompted, rather than sitting in an analysis they'd have to go looking for — a policy edit, so `/render-contract` after |
| 3 | File the ledger-upkeep gap as an `issue` | The "who closes a strand after capture" question is a real hole in the policy, independent of this matter |
| 4 | Leave both strands as-is | Defensible if you'd rather not spend a PR on a reframing, though the analysis stays weaker than its evidence supports |
</routes>

## User

1, 2 and 3
