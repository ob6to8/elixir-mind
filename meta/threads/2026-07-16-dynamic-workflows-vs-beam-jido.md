---
type: reference
title: 2026-07-16-dynamic-workflows-vs-beam-jido
description: Analyzed whether recreating Anthropic's Dynamic Workflows multi-agent architecture on the BEAM with Jido 2 has any advantage, or whether it obviates the BEAM — landing on different-layers-not-competitors — and filed the reasoning as a type:analysis doc.
provenance: "Claude Code session (Claude Opus 4.8), 2026-07-16; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, architecture, anthropic, dynamic-workflows, beam, otp, jido, agents]
timestamp: 2026-07-16
# pr: <N>  ← added later by /create-pull-request once the PR is opened; not set here
---

# 2026-07-16-dynamic-workflows-vs-beam-jido

## Where this landed

An architecture-comparison session. The operator asked whether Anthropic's new
**Dynamic Workflows** feature for Claude Code — Claude writes a JavaScript
orchestration script that a separate runtime fans out to up to ~1,000 subagents —
could be advantageously recreated on the BEAM with **Jido 2** components, or whether
it obviates the BEAM. The execution model was assessed first-hand (the Workflow tool
is in the authoring agent's own toolset) and cross-checked against Anthropic's
announcement/coverage and Jido 2.0's docs. The conclusion: the two occupy
**different layers, not competing tiers** — Dynamic Workflows is a deterministic
spine over an *ephemeral, session-scoped fan-out of stateless, non-communicating
inference calls* (with replay/prefix-caching), while BEAM/Jido is a runtime for
*long-lived, supervised, signal-reactive, distributed stateful agents*. So Dynamic
Workflows does **not** obviate the BEAM; recreating it on the BEAM *as a replacement*
is low-value (OTP's supervision/distribution/durability are wasted on an ephemeral
fan-out); the BEAM's real case is durability across process death, event-reactivity,
distribution, and fault-isolation of standing agents; and the strongest design is
**layered** (BEAM/Jido outer runtime, a workflow-style deterministic combinator as
the inner ephemeral step). The operator asked to file it, and it was intaken as
[a type:analysis doc](/meta/analysis/dynamic-workflows-vs-beam-jido.md), positioned
as a *third* shape beside the existing
[Managed Agents comparison](/meta/analysis/claude-managed-agents-vs-beam-jido.md) —
a deliberative-plane fan-out primitive that never reaches the mechanical plane the
BEAM owns.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Dynamic Workflows vs. BEAM/Jido 2 — advantage to recreating, or does it obviate the BEAM? | closed | [dynamic-workflows-vs-beam-jido](/meta/analysis/dynamic-workflows-vs-beam-jido.md) | - |

---

## User

See anthropic's new multi agent "workflow" feature. Then consider Elixir/BEAM and the Jido 2 agent library. Would there be any advantage to recreating this evolving multi agent architecture on the beam in elixir with Jido 2 components? Or does this obviate the need for the Beam?

## Assistant

Both pieces check out, and the comparison is sharper than it first looks because I can see the Workflow execution model from the inside (it's one of my own tools). Here's the analysis.

## What each thing actually is

**Anthropic's Dynamic Workflows** is a *deterministic orchestrator for a bounded fan-out of stateless inference calls*. Claude writes a JavaScript script; a separate runtime runs it in the background. The primitives are `agent()`, `parallel()`, `pipeline()`, `phase()`. The critical properties:

- **Agents are functions, not entities.** Prompt in → (optionally schema-validated) data out → back to the orchestrator. They hold no identity or state between calls and **never message each other** — everything routes through the one JS control plane on a shared filesystem.
- **The control plane is a single script in a single context.** Deterministic control flow (loops, conditionals, fan-out) wrapped around non-deterministic model calls.
- **Ephemeral and session-scoped.** It spins up, computes an answer (up to ~1,000 subagents, ~16 concurrent), and exits.
- **Its killer feature is replay.** `Date.now`/`Math.random` are banned precisely so a run can be *resumed* — the unchanged prefix of `agent()` calls returns cached results instantly. That's event-sourced determinism aimed at cost/iteration.

<routes ref="em:8f37a6 /meta/analysis/dynamic-workflows-vs-beam-jido.md">
**Jido 2 on the BEAM** is the opposite shape: a runtime for *long-lived, stateful, supervised entities*. "Agents are data" — a struct of state+actions running inside a supervised `GenServer` (`Jido.AgentServer`). Actions are a pure functional core (`cmd/2` → updated agent + a list of **directives** = typed descriptions of side effects the runtime executes). Coordination is **signal-driven** (CloudEvents 1.0.2, trie router, pub/sub bus, parent-child hierarchies), not orchestrated. It inherits OTP: supervision, "let it crash," process isolation, distribution.
</routes>

The one genuine overlap: Jido's `jido_action` *also* ships a DAG-based workflow planner. So Jido can already do the "sequence these steps" part. But that's a component inside a standing system, not the system's reason to exist.

## The core point: these are different layers, not competitors

Dynamic Workflows answers **"compute one hard answer by fanning out inference, then exit."** Jido/BEAM answers **"run a persistent fleet of stateful agents that react to events/signals, survive crashes, and scale across nodes, indefinitely."** Naming both "multi-agent" hides that they sit at different altitudes.

<routes ref="em:d18504 /meta/analysis/dynamic-workflows-vs-beam-jido.md">
So: **recreating Dynamic Workflows on the BEAM as a replacement is low-value.** If all you need is a fan-out DAG runner for LLM calls within a task, you'd be reimplementing the orchestrator *plus* the caching/resume, the structured-output validation, the MCP-tool plumbing, and the whole Claude harness integration — to arrive at roughly the same ephemeral batch executor, in an ecosystem with thinner LLM tooling. OTP's superpowers (supervision, hot reload, distribution, durable state) are **wasted on an ephemeral fan-out** — nothing lives long enough to supervise or recover.
</routes>

## Where the BEAM genuinely wins — things Workflows structurally *can't* do

Dynamic Workflows isn't just "not yet" here; its design forecloses these:

1. **Durability across process/host death.** A Workflow run is a live script. Kill the box and you resume from cache within the session — there's no notion of an agent that *survives* independently. Jido agents are supervised processes with immutable state; a crash restarts one child with backoff, siblings untouched.
2. **Standing, event-reactive agents.** Workflows are *pull/orchestrate* — the script decides everything. Jido is *push/react* — signals arrive and route to actions. For always-on systems (an agent per user/session/device reacting to a stream), the signal-bus model is the right one and Workflows offers nothing.
3. **Distribution.** Workflows is single-node, single-process, concurrency-capped at ~16. The BEAM gives location-transparent messaging across a cluster and millions of cheap processes. (Caveat below.)
4. **Real backpressure & streaming.** GenStage/Flow/Broadway give bounded queues, rate-limit shaping, token streaming. Workflows' concurrency cap is a crude, single-knob approximation.
5. **Live introspection and hot code upgrades.** Change agent behavior without stopping the fleet — irrelevant to a batch job, essential to a 24/7 system.
6. **Native integration into a running Elixir/Phoenix app.** If the agents *are* part of your production system, they belong in-VM, not in an external session-scoped runtime.

## Where Workflows wins / the BEAM adds nothing

- **Deterministic replay + prefix caching, for free.** You'd rebuild this on the BEAM via event sourcing — doable, not free.
- **Bounded one-shot tasks.** For "produce one report/audit/migration and stop," BEAM durability machinery is dead weight; the ephemeral model is *correct*.
- **Harness + ecosystem gravity.** Tight coupling to Claude's agent runtime, MCP tools, and structured output. Elixir's LLM stack (ReqLLM's 665+ models, Jido, Instructor, Nx/Bumblebee for local) is improving fast but still thinner than the JS/Python side.

## Direct answers

**"Would recreating this evolving architecture on the BEAM have an advantage?"** — Only if you need what the BEAM adds: *persistence, fault-recovery, distribution, event-reactivity, and in-app integration for a standing agent system.* For those, yes, decisively. For reproducing Dynamic Workflows *as a fan-out task runner*, no — you'd re-earn its features at a loss.

**"Does the Workflow feature obviate the need for the BEAM?"** — No. It obviates one *narrow* reason someone might reach for the BEAM (using it merely as a concurrent LLM fan-out engine for a within-task computation). It doesn't touch the BEAM's actual mandate: long-lived, fault-tolerant, distributed, stateful concurrency.

## The architecture I'd actually build: layered, not either/or

Treat them as two altitudes of the same stack:

- **BEAM/Jido as the durable outer runtime** — the standing fleet, supervision trees, signal ingress, persistent state, distribution, backpressure. This is your always-on nervous system.
- **A Workflow-style deterministic combinator as the inner, ephemeral step** — when a standing agent needs to *compute one hard answer* (investigate a bug, audit a subsystem, synthesize from N sources), it spawns a bounded, resumable fan-out, gets structured data back, and returns to its supervised life.

You wouldn't recreate Dynamic Workflows to *replace* it. You'd want a Jido-native equivalent (its DAG planner is the seed) *only* so those fan-outs run inside your BEAM system with BEAM's fault and distribution guarantees — i.e., when the orchestration itself must be durable and clustered, not session-scoped.

**One honesty caveat on the concurrency argument:** the BEAM's "millions of processes" edge is largely theoretical for LLM orchestration — the real ceiling is provider rate limits and token cost, not runtime scheduling. Both Anthropic's ~16-concurrent cap and a BEAM fleet bottleneck on the same external API. So don't justify the BEAM on raw fan-out throughput; justify it on **durability, reactivity, distribution, and fault isolation of long-lived agents** — the axes Dynamic Workflows deliberately doesn't play on.

---

Sources:
- [Introducing dynamic workflows — Claude by Anthropic](https://claude.com/blog/introducing-dynamic-workflows-in-claude-code)
- [Claude Code Adds Dynamic Workflows for Parallel Agent Coordination — InfoQ](https://www.infoq.com/news/2026/06/dynamic-workflows-claude-code/)
- [Claude Code Workflows: Deterministic Multi-Agent Orchestration — alexop.dev](https://alexop.dev/posts/claude-code-workflows-deterministic-orchestration/)
- [Jido 2.0 is now available — Agent Jido](https://jido.run/blog/jido-2-0-is-here)
- [jido/README.md — agentjido/jido](https://github.com/agentjido/jido/blob/main/README.md)
- [jido_signal — Agent Communication Envelope — agentjido](https://github.com/agentjido/jido_signal)

Want me to `/intake` this as a `concept`/`analysis` doc (it'd file under something like `knowledge/SWE/ai-agents/` alongside a Jido and a Dynamic-Workflows reference), or capture the session? Either is a quick follow-up.

## User

Intake as an analysis

## Assistant

Filed. The bundle verifies (green) — the one advisory warning on the new doc is the expected missing `attribution.from`, which `/create-pull-request` stamps later once this session is captured (it's an advisory gate, never a failure).

## What I filed

**`meta/analysis/dynamic-workflows-vs-beam-jido.md`** — `type: analysis`
- Title: *"Ephemeral spine vs. standing fleet: Anthropic's Dynamic Workflows vs. BEAM/Jido 2"*
- Distilled the reasoning I delivered: different-layers thesis, the six things the BEAM structurally wins, where Workflows wins, direct answers to both your questions, the honesty caveat on concurrency, and the layered/hybrid recommendation.
- Verified the Dynamic Workflows framing against Anthropic's announcement + coverage and Jido 2.0 against jido.run/GitHub (dated in Citations). The execution-model claims are marked as first-hand — the Workflow tool is in my own toolset.

**`meta/analysis/index.md`** — added the entry (placed among the sibling BEAM/Jido analyses).

## Positioning within the existing cluster

I found a rich pre-existing BEAM/Jido analysis family and deliberately made this a *distinct* node rather than a duplicate. The key differentiator, called out in a "Relation to the prior analyses" section: none of those cover Dynamic Workflows, which is a **third** Anthropic shape — an *ephemeral deterministic spine over the deliberative plane* — distinct from the [Managed Agents comparison](https://ob6to8.github.io/elixir-mind/meta/analysis/claude-managed-agents-vs-beam-jido.html) (hosted long-running sessions) and the [BEAM deployment evaluation](https://ob6to8.github.io/elixir-mind/meta/analysis/beam-deployment-and-jido-2-evaluation.html) (this brain's own runtime). Cross-linked to both, plus the dark-factory and Loomkin analyses and the `actor-model` / `deterministic-spine` / `orchestrator-pattern` / `backpressure` / `two-plane-rule` glossary terms.

I did **not** dedup-gold-set this — that step keys on `em:` ids, and analysis docs are governance (no id).

Nothing awaits ratification (filed into existing `meta/analysis/`, existing `type`). Want me to `/create-pull-request` to capture the session, stamp the `from` back-link, and open the PR?

## User

*(Stop hook feedback: the repository had uncommitted changes; the hook asked for them to be committed and pushed to the remote branch.)*

## Assistant

The stop hook requires the branch to be committed and pushed. I'll commit the intake to the designated branch now (a plain commit — not a PR, since you haven't asked for one; `/create-pull-request` can capture the session and stamp the `from` back-link later).

## Assistant

Committed and pushed to `claude/anthropic-workflows-elixir-jido-7nmogf`.

- **Commit** `c2e60ec` — the new analysis + index update.
- **Pushed** and tracking `origin/claude/anthropic-workflows-elixir-jido-7nmogf`.

No PR opened (you didn't ask for one). When you're ready, `/create-pull-request` will capture this session as a thread doc, run `/add-to-glossary` over it, stamp the `attribution.from` back-link into the new analysis (resolving that advisory warning), and open the PR — all in one motion.
