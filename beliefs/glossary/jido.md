---
id: em:44f899
type: concept
title: Jido
description: An Elixir agent framework (2.x, 2026) that models agents as pure immutable data processed through a single cmd/2 reducer, with schema-validated Actions doubling as LLM tools, CloudEvents-based Signals, runtime-interpreted Directives, and GenServer-backed supervision; its jido_ai layer adds LLM reasoning strategies.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, jido, elixir, agents, multi-agent, beam]
sense: common
timestamp: 2026-07-26
attribution:
  when: 2026-07-12T09:05:38+00:00
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the captured sources cited in Seen in (backfilled)"
---

# Jido

An Elixir framework for autonomous agents and multi-agent systems (2.x stable since early 2026). Its core move is separating the agent from its runtime: an agent is **pure immutable data** — schema-validated state plus signal routes — processed through a single `cmd(agent, {Action, params}) → {updated_agent, directives}` reducer, so decision logic is replayable and testable without an LLM. Around that core: **Actions** (validated functions that double as LLM-callable tools), **Signals** ([CloudEvents](/beliefs/glossary/cloudevents.md)-compliant messages with trie-based routing), **Directives** (structs the runtime interprets for side effects like spawn/schedule/emit), and a GenServer-backed supervised runtime on the [BEAM](/beliefs/glossary/beam.md); the separate `jido_ai` layer adds LLM reasoning strategies ([ReAct](/beliefs/glossary/react.md) by default). Notable gap as of mid-2026: no cross-node distribution story.

*Seen in:* [BEAM/Jido evaluation](/meta/analysis/beam-deployment-and-jido-2-evaluation.md), [dark-factory scenario analysis](/meta/analysis/dark-factory-epistemic-base-beam-jido.md), [2026-07-13 advisor-pattern thread](/meta/threads/2026-07-13-advisor-pattern-and-rolling-your-own-harness.md), [2026-07-14 Elixir AST/macros and Loomkin thread](/meta/threads/2026-07-14-elixir-ast-macros-and-loomkin-evaluation.md) (the Action macro's compile-time validation and `to_tool/0` verified against hexdocs; Loomkin as a production adopter), [2026-07-16 Jido-caveats thread](/meta/threads/2026-07-16-jido-caveats-and-build-agent-linter-loop.md) (the distribution gap and `req_llm` cognition dependency, unpacked), [2026-07-17 vercel-eve comparison thread](/meta/threads/2026-07-17-vercel-eve-comparison-and-jido-host-plan.md) (Jido as the chassis of the proposed [thin brain host](/meta/plans/thin-jido-brain-host.md), contrasted with Vercel eve), [2026-07-21 ECS intake thread](/meta/threads/2026-07-21-ecs-intake-and-agent-entity-substitution.md) (Jido as independent rediscovery of ECS's composition half — composable Actions/Skills/Sensors over role hierarchies — while keeping agents active), [Dynamic Workflows vs. BEAM/Jido 2 analysis](/meta/analysis/dynamic-workflows-vs-beam-jido.md), [2026-07-26 agent-teams intake thread](/meta/threads/2026-07-26-agent-teams-intake-and-beam-jido-comparison.md) (fourth family comparison; `jido_cluster` re-checked still unpublished)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:44f899">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-16-jido-caveats-and-build-agent-linter-loop (2026-07-16)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:44f899`]**

Here's the expansion, which I'll also compile into the analysis doc.

**1. "No distribution story (single-node; `jido_cluster` unpublished)"**

The subtlety: the **BEAM has world-class distribution primitives** (transparent inter-node message passing, `:global`, `:pg`), but a *framework* only becomes distribution-aware if it makes deliberate choices on top of them. Jido makes the single-node choices:

- **Agent identity is node-local.** A Jido agent is a GenServer registered under an instance-scoped supervisor (`{Jido, name: MyApp.Jido}`) via a local Registry. That name resolves on *one* node. There's no cluster-wide registry that lets "agent Foo" be addressed from any node — so you can't transparently route to an agent that happens to live on a different machine.
- **Recovery is single-node crash recovery, not cross-node failover.** Jido's durability model is "rehydrate from persisted state" (Redis adapter since 2.1.0). That handles *a process crashing and its supervisor restarting it on the same node*. It does **not** handle *a node dying and its agents coming back up elsewhere* — there's no handoff/migration orchestrator watching for a dead node and re-spawning its fleet on survivors.
- **The signal bus is in-node.** Signals are trie-routed pub/sub over a per-node bus. Cluster-wide routing would need that bus to span nodes (via `:pg`, `phoenix_pubsub`, or `partisan`) — Jido doesn't ship it.
- **`jido_cluster` is the intended answer, but it's vapor for now.** A repo exists in the agentjido org, but it's *unpublished on hex* — you can't `mix deps.get` it, and the brain flagged its maturity as unconfirmed. So the distribution layer is gestating, not shippable.

**Why this matters (and why it mostly doesn't, until it does):** one BEAM node holds *millions* of lightweight processes, so "single-node" is a very high ceiling — vertical scaling alone carries a big fleet. What you *give up* is (a) horizontal scale across machines, (b) HA — that one node is a single point of failure for the whole fleet; no HA across machines, and (c) geographic distribution. For a dark factory that "eventually spans nodes," you'd be **building the distribution layer yourself** on raw BEAM primitives: `libcluster` for node discovery, `Horde` (or a hand-rolled `:global`/CRDT registry) for distributed process registration + handoff, and a distributed pubsub for the signal bus. That's exactly the "that layer would be ours to build" caveat — and distribution is genuinely hard (split-brain/netsplit handling, CAP tradeoffs on the registry, state-handoff races), which is *why* a young framework reasonably punts on it.

**2. "Makes `req_llm` load-bearing for all cognition"**

The architecture: Jido deliberately splits core `jido` (zero LLM code — the pure `cmd/2` reducer, agent-as-data) from `jido_ai` (the reasoning layer: ReAct/CoT/ToT strategies, tool-calling loops, structured output). `jido_ai` is built on `req_llm`, Jido's own in-house LLM client (they dropped LangChain). `req_llm` sits on `Req` (HTTP) and owns the provider adapters, the model catalog, streaming, and tool-call encoding.

"Load-bearing for all cognition" means: the reducer core is LLM-free *by design* (that's the replayable-without-a-model auditability win) — but the instant an agent actually **thinks** (any inference, any reasoning strategy, any structured extraction, any tool-selection decision), it goes through `jido_ai` → `req_llm`. There is no first-class alternate cognition path in the framework. Consequences:

- **One throat for every inference.** `req_llm`'s provider coverage, streaming correctness, tool-call encoding, retry/rate-limit semantics, and error handling *become your cognition's reliability envelope*. The single most volatile, most external, most expensive part of the system — model calls — has exactly one library standing under it.
- **Coupling to a young, in-house library.** `req_llm` was written during the ~18-month Jido 2 rewrite; the brain flagged even its "665+ models" claim as unconfirmed. When a new model, param, or feature lands (prompt caching, extended thinking, a changed tool-call format), you wait on `req_llm` to support it or you patch it — versus calling the Anthropic SDK directly, where you own the request shape.
- **It entangles with elixir-mind's zero-dep and duplicate-runtime blockers.** Adopting Jido's cognition pulls `req_llm` *and* a provider credential into the runtime tier — which is exactly why the verifier core must never depend on it and cognition must live in a separate mix project (blocker #2), and why a Jido deployment is "a second agent runtime with its own LLM credentials" (blocker #3).
- **The flip side — it's a reasonable design.** Isolating cognition behind a swappable client is *good* architecture: it's what keeps LLM code out of the reducer and makes decisions testable without a model, and in principle the client is replaceable. "Load-bearing" is a caveat about **concentration of dependency**, not a design flaw.

**Tie-back to the linting loop from earlier:** a Jido lint-fixer calling a cheap model would route that call *through* `req_llm` — so your ability to pin `claude-haiku-4-5`, set `max_tokens`, etc., is bounded by what `req_llm` exposes. And the single-node ceiling is irrelevant to a lint-fixer specifically; it only bites once linting becomes a fleet-scale continuous workload.

### 2026-07-27-secure-financial-agent-and-projects-namespace (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:44f899`]**  (co-feeds: `em:f6de6f em:0d4f26`)

Your brain already concluded Jido was a poor fit *for the brain's own tooling* — see [the BEAM/Jido evaluation](https://ob6to8.github.io/elixir-mind/meta/analysis/beam-deployment-and-jido-2-evaluation.html). But read *why* it said no:

> "the BEAM's distinctive strengths (supervision of long-lived state, massive concurrency, fault-tolerant services) have nothing to grip"

**A financial document pipeline gives them everything to grip.** It's resident, stateful, long-lived, concurrent, and needs an audit trail. This is the workload that analysis said was missing. Every blocker it listed was about *this repo* — the pinned 1.14/OTP 24 floor and the zero-dependency constraint — and none applies to a separate project.

More than that, Jido's primitives map onto the security requirements almost suspiciously well:

**1. The reducer is your audit trail.** A Jido agent is pure immutable data through a single `cmd(agent, {Action, params}) → {updated_agent, directives}`. That means every decision is **replayable without an LLM and without a network call**. For financial work — where "why did it categorize this deduction that way?" is a question you may have to answer to a human — a deterministic replay of the decision sequence is worth a great deal.

**2. Actions are the capability boundary.** Actions are schema-validated functions that double as LLM tools. The model cannot invoke what no Action exposes, and params are validated *before* execution. That's OWASP's privilege minimization enforced in the type system rather than requested in a prompt — which is the whole difference, because a prompt is exactly the thing an injection attack overrides.

**3. Directives make the human-in-the-loop gate a first-class primitive.** This is the one that matters most. Side effects in Jido aren't executed inline — they're returned as **Directives**, structs the runtime interprets. So you can inspect a proposed side effect *as data* and gate it before anything happens. The recommended defense for high-consequence actions is [human confirmation that interposes a break in the automated attack chain](https://www.getmaxim.ai/articles/prompt-injection-defense-for-production-ai-agents-a-complete-2026-guide/) — a break "that cannot be bypassed by manipulating the model alone." Jido hands you the seam for free.

**4. Supervision contains a poisoned agent.** Let-it-crash means an agent whose context got contaminated dies and restarts from clean persisted state. Injection doesn't persist across a restart unless you persisted it.

### 2026-07-28-ontology-guardrails-intake-and-jido-comparison (2026-07-28)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:44f899`]**  (co-feeds: `em:1df031`)

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

**[`em:44f899`]**  (co-feeds: `em:8255b8 em:1df031`)

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
