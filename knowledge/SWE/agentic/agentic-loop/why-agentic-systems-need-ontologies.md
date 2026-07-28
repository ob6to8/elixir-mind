---
id: em:1df031
type: reference
title: "Why agentic systems need ontologies (Frank Coyle)"
description: AI Engineer talk arguing that agent failures are symptoms of one missing layer — a formal ontology outside the model, applied as a neurosymbolic validator on the tool-use loop ("Pydantic at the door, ontology at the ledger").
resource: https://www.youtube.com/watch?v=Sir59K8ZDPU
provenance: "Frank Coyle (UC Berkeley), 'Why Agentic Systems Need Ontologies', AI Engineer conference talk, 21 min, uploaded 2026-07-23; distilled from the video's transcript and description"
tags: [agents, agentic-loop, ontology, neurosymbolic-ai, guardrails, tool-use, rdfs, owl, knowledge-graph, validation]
timestamp: 2026-07-28T07:10:00Z
attribution:
  when: 2026-07-28T07:10:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator passed the talk's YouTube URL to /intake for capture into the brain"
---

# Why agentic systems need ontologies (Frank Coyle)

## Summary

Coyle's claim is that most agent failures — a second refund on the same order,
a payout sent to the support desk instead of the buyer, an order status of
"probably shipped" — are symptoms of one missing layer. LLMs reason
probabilistically over domains they only half understand, and no paragraph of
prompt instructions reliably stops these mistakes; hallucination "is a feature"
of the probabilistic machinery, not a bug to be prompted away. His fix is
neurosymbolic: keep the probabilistic reasoning inside the model and put logic
outside it, as a formal ontology sitting beside the agent loop and checking
what the model proposes before anything acts.

An ontology here is nothing exotic — typed entities, relationships, and
constraints, quoting Gruber (1993): "a formal specification of a shared
conceptualization". Expressed in the old, boring W3C standards (RDFS and OWL),
it lets you say that a payment status must be one of three values, that a
customer and a support rep are disjoint kinds of thing, that an order can be
refunded only once. The operational pattern: wrap a Claude tool-use loop with a
validator — when the model proposes a tool call, check the parameter types with
Pydantic and the results against the ontology, and only then let the action
through. Catches that are painful to write in English become a few lines of
logic. His slogan for the architecture: "Pydantic at the door, ontology at the
ledger" — and keep the tools side-effect-free until the validator has passed
them.

## Key terms

- **Ontology** — a formal representation of a domain's entities, their
  properties, and their relationships; operationally, a
  [knowledge graph](/beliefs/glossary/knowledge-graph.md) plus constraint and
  inference machinery sitting beside it. See the glossary entry
  [ontology](/beliefs/glossary/ontology.md).
- **Neurosymbolic AI** — the convergence of neural (probabilistic, LLM) and
  symbolic (rule-based, logic) systems; in this talk's usage, symbolic
  guardrails around a probabilistic core.
- **RDFS domain and range** — inference vocabulary: declaring `teaches` to have
  domain `Teacher` and range `Student` lets "Bob teaches Scooter" *derive* that
  Bob is a teacher (hence a person) and Scooter is a student, without those
  facts being asserted.
- **OWL property axioms** — [OWL](/beliefs/glossary/owl.md) constructs the
  validator leans on: *transitive* properties (ancestor-of chains compose),
  *functional* properties (at most one value — two asserted fathers means two
  names for one individual, or an error), and *disjoint* classes (a customer is
  never a support rep).
- **Tool-use loop** — the classic `while True` agent loop: the LLM cannot
  execute anything itself; it proposes a tool call (surfaced via a `tool_use`
  stop reason), the harness executes it, and results are fed back. See
  [the agent loop as a while-loop](/knowledge/SWE/agentic/agentic-loop/agent-loop-as-a-while-loop.md).
- **Validator** — the code between the model's proposal and the action: Pydantic
  for parameter *types* at the boundary, the ontology reasoner for *semantic*
  invariants over the results; failures route back to the LLM or to a human in
  the loop.
- **Böhm–Jacopini result (1966)** — sequence + conditionals + iteration make a
  language Turing-complete; Coyle's framing is that loops give agentic AI that
  last piece — and with it the classic loop failure modes (infinite loops,
  drift, runaway token cost).
- **Existing taxonomies** — schema.org, FOAF, Dublin Core, DBpedia: published
  vocabularies to reuse rather than reinventing a domain model from scratch.

## Technical summary

The talk traces two lineages — agents (McCarthy, Selfridge, Minsky; perceive →
decide → act) and ontologies (Aristotle's categories through Quine to Gruber's
1993 definition) — and argues their convergence is what "neurosymbolic AI"
names. The expert-systems era of the 1980s is the cautionary precedent:
symbolic AI alone couldn't scale and produced an AI winter, just as neural
networks alone couldn't scale until GPU compute arrived. Ontologies are built
top-down (domain experts enumerate entities/relations, the expert-systems
workflow) or bottom-up (mined from interactions), and preferably seeded from
existing taxonomies.

Mechanically, the graph holds entities, properties, and relationships; RDFS and
OWL sit "on the side" of the graph supplying derivations (domain/range typing,
transitive closure) and constraints (functional properties, disjointness,
enumerated value sets). The agent-side integration is a standard Claude
tool-use loop with an interposed validation stage: on `stop_reason ==
"tool_use"`, extract the proposed call, execute the tool, normalize the result
into the validator's form, and check it against the ontology before committing
anything — "surround the input with checks", keep agents free of side effects
until validation passes, and on failure loop back to the model or escalate to a
human. The closing catalogue of errors an ontology catches that English
cannot: double refunds (a once-only relationship), misdirected payouts
(disjoint classes), and invented enum values like "probably shipped" (a closed
value set — paid, shipped, or refunded, nothing else).

The formal underpinnings of RDFS/OWL — decidability trade-offs, description
logics, and what the authoring cost buys — are captured separately in
[FOL and OWL: fully formal knowledge representation](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md);
this talk is the agent-side argument for putting that machinery to work as
loop guardrails. Whether the named formalisms deliver the catches claimed here,
and what an enforcement layer should actually be built from, is evaluated in
[ontology guardrails vs. schema validation](/meta/analysis/ontology-guardrails-vs-schema-validation.md).

# Citations

- Talk: Frank Coyle, "Why Agentic Systems Need Ontologies", AI Engineer
  (YouTube, 21:18, uploaded 2026-07-23):
  <https://www.youtube.com/watch?v=Sir59K8ZDPU>
- Speaker: <https://www.frank-coyle.ai/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:1df031">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-ontology-guardrails-intake-and-jido-comparison (2026-07-28)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:1df031`]**

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

---

**[`em:1df031`]**  (co-feeds: `em:44f899`)

Partly — and the way it diverges is the interesting part. Jido 2 matches two of Coyle's three layers, one of them *better* than his Python version, but the layer his entire talk is about is the one Jido doesn't have.

**Where the analogy holds**

**"Pydantic at the door" — Jido's Action schema, and it's a stronger design.** A `Jido.Action` declares a schema, and the documented hook order runs "parameters are processed, followed by `on_before_validate_params`, then schema validation, `on_after_validate_params`, and finally the `run` function," with output validation after. That is structurally Coyle's door check.

The improvement over his setup: the *same* schema declaration generates the LLM tool definition. `to_tool()` emits `parameters_schema` as JSON Schema for the model, and `Jido.Action.Tool.execute_action/3` re-validates the model's actual arguments (handling string keys and type coercion) on the way in. In Coyle's Python, the tool schema you send to Claude and the Pydantic model that guards execution are two artifacts that can silently drift apart. In Jido they're one source of truth. That's a real architectural win on the door half.

**"No side effects" — that's what Directives actually are.** Coyle prescribes it as discipline: "your agents should try to have no side effects... they're not running off doing something that they're changing things in the database not yet." Jido makes it structural. An action's `run/1` returns *data describing* effects — `%Directive.Emit{}`, `Spawn`, `Schedule`, `Cron` — and the runtime interprets them. The pure `cmd(agent, {Action, params}) → {updated_agent, directives}` reducer never performs I/O, which is why it's replayable and testable without an LLM ([functional core, imperative shell](/beliefs/glossary/functional-core-imperative-shell.md)).

**Where it breaks — Directives are not the validator**

This is the crux: **Directives are the effect-deferral mechanism, not the checking mechanism.** They're the "don't touch the database yet" half. They are not the "and here's what decides whether you may" half. The runtime type-checks them structurally — a malformed instruction yields `%Jido.Agent.Directive.Error{}` — but nothing consults a domain model before interpreting one.

Jido's validation is **structural and local**; Coyle's ontology layer is **semantic and relational**. Run his three closing examples through Jido:

| Coyle's catch | Jido today |
|---|---|
| `"probably shipped"` — invented enum value | **Caught.** `status: [type: :atom, in: [:paid, :shipped, :refunded]]` — the closed value set is free, in both the tool schema and the runtime check |
| Payout to the support desk, not the buyer — disjoint classes | **Not caught.** Both are `:string` or `:map`. Nothing knows `Customer` and `SupportRep` are disjoint kinds |
| A second refund on the same order — once-only relation | **Not caught.** This is a cardinality constraint over a *relation across history*; no per-call schema can see it |

Note what separates row 1 from rows 2–3: row 1 is a constraint on **one field of one call**, which is exactly what NimbleOptions/Zoi express. Rows 2–3 are constraints over **entity classes and relationship histories** — OWL's disjointness and functional-property axioms. Jido's `output_schema` and agent state schema don't reach there either; they're per-record shape checks, just positioned later in the pipeline. There's no reasoner, no derived facts, no RDFS domain/range inference.

**Where the ontology layer would go if you wanted it**

The natural seam is a custom **Strategy** — Strategies control how `cmd/2` executes, so that's Jido's analogue of Coyle's validator wrapping the loop, and it sits at the right altitude to see the instruction, the agent's state, and the returned directives together before the runtime interprets them. Per-action, `on_after_validate_output` is the cheaper hook. Either way you'd be writing the domain reasoner yourself; Elixir's RDF/OWL ecosystem is thin compared to Python's, and I haven't verified current options in this session.

**Short answer:** Jido gives you Coyle's door and his purity discipline, both better-engineered than the talk's Python sketch. It does not give you his ledger. If you adopted Jido expecting the guardrails argument to be satisfied, you'd get exactly the class of failure he opens with — the double refund and the misdirected payout both pass every check Jido ships with.

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | File this as an `analysis` under `meta/analysis/` | A queryable comparison doc; fits alongside the existing Jido evaluations, and the thin-jido-brain-host plan would want to cite it if that host ever needs semantic guardrails |
| 2 | Leave it in chat and let `/capture` record it | The comparison lives in the thread render; adequate if this was curiosity rather than a design input |
| 3 | Extend the Coyle reference with a "Jido comparison" section | Keeps it attached to the source, but mixes a capture with derived analysis — I'd recommend option 1 over this |

---

**[`em:1df031`]**  (co-feeds: `em:8255b8 em:44f899`)

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
