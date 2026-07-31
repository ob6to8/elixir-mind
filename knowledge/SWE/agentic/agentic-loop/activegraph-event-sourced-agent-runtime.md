---
id: em:360ddd
type: reference
title: "ActiveGraph: an event-sourced graph runtime for agents (Yohei Nakajima)"
description: An experimental agent runtime that replaces the LLM-centric message loop with an immutable, typed event log as the single source of truth; the log projects a graph (the agent's state), reactive "behaviors" and change-gating "policies" run on that graph, giving native replay, rollback, and forking, and forming the substrate for controlled self-modification experiments.
resource: https://www.youtube.com/watch?v=khVX_BUnEwU
provenance: "Yohei Nakajima (Untapped Capital; creator of BabyAGI), \"Active Graph Agent Runtime (BabyAGI 4)\", AI Engineer conference talk, ~17 min; distilled from the video's transcript and description"
tags: [agents, agentic-loop, agent-memory, event-sourcing, graph, self-modification, babyagi, blackboard-architecture]
timestamp: 2026-07-31T01:15:00Z
attribution:
  when: 2026-07-31T01:15:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator passed three AI Engineer conference talk URLs to /intake for capture into the brain"
---

# ActiveGraph: an event-sourced graph runtime for agents (Yohei Nakajima)

## Summary

Nakajima frames ActiveGraph — informally "BabyAGI 4," after nine iterations
and three-plus years since the original BabyAGI (March 2023) — around a
single inversion: instead of building an agent around the LLM and bolting on
memory and logging afterward, build around an immutable event log and derive
everything else, including the agent's own state, from it. Every action
*and every change to the agent itself* (a prompt edit, a tool change)
flattens into one typed, append-only log; that log projects a graph, which
*is* the agent's current state. LLMs never talk to each other directly in
this design — they only read and write shared state via the log. Nakajima is
explicit this is a runtime, not a harness: most common agent harnesses (he
demonstrates a ReAct agent) can be rebuilt on top of it. The lineage he cites
is 1970s/80s blackboard architectures and Kafka — many small workers reacting
to shared state rather than to each other.

## Key terms

- **Behaviors** — units that react to graph changes and emit new events; can
  live on nodes or, as "relation behaviors," on edges (e.g. an "unblock"
  relation behavior that permits writing a memo once its blocking research
  task completes). Can be deterministic code or LLM calls, and subscriptions
  can themselves be graph queries (e.g. trigger a contradiction detector when
  a new `claim` object contradicts an existing one).
- **Policies** — rules governing which graph changes an agent may make
  autonomously versus which require a proposed patch and human approval
  (e.g. adding a sourced fact may be autonomous; editing a prompt or a fact
  may require review or a contradiction check).
- **Views** — context management expressed as a graph query: a behavior
  pulls the subgraph relevant to it, instead of context being assembled by
  hand.
- **Pack** — a bundle of object schemas, tools, and behaviors (plus a pack
  policy) that composes into a working harness. ActiveGraph ships packs for
  core, tools, secrets, memory, identity, communication, and chat; packs are
  swappable (e.g. one memory pack for another) and, per Nakajima, load
  cleanly from other repositories without extra integration work.
- **Regimes** — Nakajima's controlled self-modification experiment: the
  agent forks itself, proposes a patch to one classified-failure-specific
  part of itself, gates the patch behind a static check and a sandboxed
  accuracy check on held-out questions, and keeps the patch only if accuracy
  measurably improves.

## Technical summary

Reported experiments, in the order given: (1) using the log itself as agent
memory on LongMemEval — no semantic ingestion, fact extraction, or entity
extraction, just embedding the query, retrieving nearby log messages, and
fitting them into context — scored well, on the reasoning that memory data
and log data substantially overlap and keeping them the same avoids the two
drifting apart; (2) a resumability property surfaced by accident when an API
key ran out mid-run at question 350 of 500 — restarting rolled back exactly
one step and resumed at 353, rather than requiring the whole long run to
restart from scratch, which Nakajima contrasts with his experience of prior
agent frameworks; (3) reference agents (a coding agent, a deep-research
agent) built by asking a coding assistant to "use ActiveGraph," which
acquired a typed event log and evidence/contradiction graph natively, without
that structure being separately requested; (4) "Regimes" self-modification,
run on LongMemEval in batches of ~20 questions with re-validation on ~50,
looping roughly 8–13 times per session and accepting on the order of 4–5
patches per loop, yielding a reported modest but statistically significant
accuracy gain — and, notably, retaining a record of what was *tried and
rejected*, not only what worked; (5) ActiveGraph Lab, an agent that reads
ActiveGraph's own blog posts and repository, proposes and runs experiments
on itself, and — per Nakajima's account — found a bug in its own code,
authored the fix as a pull request, and had it merged by him; and (6) an
80-pass self-improvement loop on a Kaggle Pokémon-trading-card-deck
competition, each pass gated by simulated-game win rate against reference
decks plus a Wilson-score threshold, accepting roughly 20–30 of the 80
proposed changes.

Nakajima's closing hypothesis, offered with the caveat that he does not work
on model training himself: long-running agents may need not just a
predictive world model (priors) but an *experiential* world model — an
immutable event log, analogized to the hippocampus, that feeds outcomes back
into priors via something like replay — i.e. that the harness does not
disappear as models improve, contrary to some framings in the field; harness
and model both matter.

This is a different mechanism from the [EXG paper](/knowledge/SWE/agentic/agent-memory/experience-graphs-exg.md)
already in the bundle — EXG is an offline/online-consolidated success/failure
graph bolted on as a memory module for an otherwise ordinary agent, whereas
ActiveGraph restructures the *entire* runtime (state, memory, and inter-agent
communication together) around one event log — but both land on the same
thesis that structured, linked history outperforms raw trajectories or
ad-hoc memory. See also
[the agent loop as a while-loop](/knowledge/SWE/agentic/agentic-loop/agent-loop-as-a-while-loop.md)
for the message-passing loop architecture ActiveGraph explicitly departs
from.

Why this bundle already holds the log-centric commitment (via the git commit
graph and the no-squash rule) while declining the score-gated self-modification
half on ratified doctrine is worked through in
[three agent-substrate talks read against this brain](/meta/analysis/agent-substrate-talks-read-against-this-brain.md).

**Scope note.** All reported results (LongMemEval scores, the Pokémon win
rate, the Regimes accuracy gain) are the speaker's own account from a
conference talk with no linked benchmark numbers or paper in the video
description; treat as a practitioner report, not independently verified
evidence.

# Citations

- Talk: Yohei Nakajima, "Active Graph Agent Runtime (BabyAGI 4)", AI Engineer
  (YouTube): <https://www.youtube.com/watch?v=khVX_BUnEwU>
- Project: <https://github.com/yoheinakajima/activegraph>
- Speaker: <https://x.com/yoheinakajima>, <https://www.linkedin.com/in/yoheinakajima>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:360ddd">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-31-agent-substrate-talks-intake-analysis-and-ratifications (2026-07-31)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:360ddd`]**  (co-feeds: `em:619132 em:428854`)

All three videos are filed. Plain terms: three AI-engineering conference talks about giving LLM agents a shared, structured layer around them — a Neo4j talk on using an ontology as a shared "data map" so agents don't each re-discover where enterprise data lives, a talk from BabyAGI's creator on building an agent whose entire state is derived from an immutable log instead of chat messages, and a walkthrough of "graph engineering" (running many agents in parallel instead of one looping agent) plus how to catch a single bad agent from silently corrupting the merged result. All three landed in the existing `agentic-loop/` directory, next to a related ontology talk already in the brain, with cross-links added between them. Nothing here required a new directory or type, so everything filed autonomously.

**What I created**

| type | doc | why this type |
|---|---|---|
| `reference` | [thin-agents-on-a-smarter-ontology-based-substrate](/knowledge/SWE/agentic/agentic-loop/thin-agents-on-a-smarter-ontology-based-substrate.md) (`em:619132`) | external talk (Emil Eifrem/Neo4j), fetched and summarized |
| `reference` | [activegraph-event-sourced-agent-runtime](/knowledge/SWE/agentic/agentic-loop/activegraph-event-sourced-agent-runtime.md) (`em:360ddd`) | external talk (Yohei Nakajima), fetched and summarized |
| `reference` | [graph-engineering-and-verification-skills](/knowledge/SWE/agentic/agentic-loop/graph-engineering-and-verification-skills.md) (`em:428854`) | external talk/walkthrough (AI LABS), fetched and summarized |

**What I modified**

| file | thrust of the change |
|---|---|
| `knowledge/SWE/agentic/agentic-loop/index.md` | added bulleted entries for the three new references |
| `knowledge/SWE/agentic/agentic-loop/why-agentic-systems-need-ontologies.md` | added a cross-link distinguishing Coyle's validator-ontology from Eifrem's discovery/routing-ontology |
| `meta/registry.md` | regenerated after minting the three ids |

**Actions I have taken**

| action | result |
|---|---|
| Fetched all three videos (yt-dlp transcripts + descriptions, oembed for titles) | one video hit a transient 429, retried successfully; all three fully captured |
| Synonym-expanded dedup search (ontology, semantic layer, ActiveGraph, event sourcing, blackboard architecture, graph engineering, verification skills, etc.) | no duplicates found; nearest neighbors were a distinct Coyle ontology talk and a distinct EXG memory paper, both now cross-linked |
| Full gate suite: `mix brain.verify`, `route_tags`, `contract --check`, `test --warnings-as-errors`, `format --check-formatted`, `xref` | all green (188 tests) |
| Dedup baseline refresh | plain 8/22, unchanged — no regression. No gold row harvested: all three were bare URLs with no natural operator phrasing to record |

Nothing is committed or pushed yet, and no PR is open — say the word (or `/create-pull-request`) when you want this landed.

---

**[`em:360ddd`]**  (co-feeds: `/meta/analysis/agent-substrate-talks-read-against-this-brain.md em:619132 em:428854`)

I read the three talks against the repo and wrote up what they actually say about it. The short version: the repo is further ahead than the talks are, and in one case has already turned down the thing they're selling — for reasons written down here months ago. So the analysis spends most of its length on the three narrow places where they *do* have something, and the sharpest of those is a warning about a direction the repo is currently planning to take.

The one you'd want to act on: the plan to run work across parallel agents has a safety check that stops two workers from touching the same *file*. The graph-engineering talk's central warning is that the damage in these setups comes from somewhere else — two workers doing different work that turns out to be the same *job*, which no file check sees. This repo already has that exact failure filed as an open issue, from real incidents, and the plan to fan out would multiply it.

**What the talks converge on, and where the brain sits**

All three propose the same three layers: durable state outside the agent, gated change, and outcome feedback. The first two are already here, in stronger form than any of the talks describe:

- Eifrem's business↔technical mapping — the layer connecting "customer's first name" to the Oracle column holding it — is `meta/registry.md`, and it's *compiled* rather than hand-maintained, which is precisely the drift problem his enterprise examples are about.
- Nakajima's immutable-log architecture is the git commit graph, and [merge-strategy](https://github.com/ob6to8/elixir-mind/blob/claude/intake-7gfpj8/meta/policy/merge-strategy.md) forbids squash and rebase for the same reason he forbids editing the log.

His self-modification loop — accept a patch when a score improves — is declined here as a class, by three ratified doctrines. [bound-adaptation](https://github.com/ob6to8/elixir-mind/blob/claude/intake-7gfpj8/meta/doctrine/bound-adaptation.md) makes it definitional: "**change to standing behavior is distinguished from drift by who approved it**, never by whether it looked locally rational." A score substituting for the operator is the silent adaptation channel that doctrine exists to close.

**The three residues**

**Fan-out multiplies a filed failure.** The [fan-out convention](https://github.com/ob6to8/elixir-mind/blob/claude/intake-7gfpj8/meta/analysis/executing-ratified-plans-via-workflow-fan-out.md)'s readiness gate requires "no two parallel workstreams claim the same files or the same derived surface." That partitions files, not matters. [Parallel sessions filing duplicate artifacts](https://github.com/ob6to8/elixir-mind/blob/claude/intake-7gfpj8/meta/issues/parallel-sessions-file-duplicate-artifacts.md) documents three instances in one day — one reaching bundle documents with two permanent minted ids — where "**Git cannot catch this.**" The issue's own preferred fix (reconcile at merge) sits outside the convention's fold-back path. The named pilot is `three-level-documentation`, so this is near-term.

**Model selection has evidence now.** [capability-matched-model-selection](https://github.com/ob6to8/elixir-mind/blob/claude/intake-7gfpj8/meta/doctrine/capability-matched-model-selection.md) rested on reasoning; the weak-vs-strong reviewer comparison is its first outside datum, and it shows the failure is worse than "misses findings" — a weak reviewer emits *false* findings that propagate as fixes to unbroken things. The doctrine names an enforcement gap it can't close ("Selection itself **cannot be enforced**… attribution is the enforceable shadow") and proposes an attribution policy that remains unratified.

**Evidence versus authority.** The doctrine governs *who approves*, not *what the approver sees* — a distinction nothing here has drawn. The contract went from 5,574 to 14,047 words and 24 to 40 policies between 15 and 31 July, every addition ratified, none measured for effect, and it loads in full every session.

**Actions I have taken**

| action | result |
|---|---|
| Filed the analysis | [agent-substrate-talks-read-against-this-brain](https://github.com/ob6to8/elixir-mind/blob/claude/intake-7gfpj8/meta/analysis/agent-substrate-talks-read-against-this-brain.md), cross-linked from all three captures |
| Verified every quote against source | two the survey reported did not match my initial grep; both existed, wrapped across lines — checked directly before quoting |
| Gate suite + push | green (188 tests); `165dc01` on `claude/intake-7gfpj8` |

**A defect I found, not yet fixed**

In [dedup-probe.md](https://github.com/ob6to8/elixir-mind/blob/claude/intake-7gfpj8/meta/evals/dedup-probe.md) the generated table reads plain 8/22, expanded 19/22. Four lines below, prose still reads "**plain 3/10 vs expanded 10/10**" and "7 of the 10 targets." The table regenerates every intake; the sentence interpreting it never did. I left it alone — it's a separate matter from the analysis that noticed it.

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Fix the stale dedup-probe prose (Recommended) | One-line edit; or restate it so no figure is duplicated beside the generated table |
| 2 | Ratify the attribution policy | The doctrine's own proposed path; cheap, and fan-out is what makes it matter |
| 3 | Extend the readiness gate to matter-disjointness before the fan-out pilot | Closes finding 3; likely a plan, since the approach needs deciding |
| 4 | Open a PR for this branch | `/create-pull-request` — nothing is merged yet |
