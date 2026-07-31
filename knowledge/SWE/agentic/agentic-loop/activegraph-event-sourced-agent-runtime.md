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
