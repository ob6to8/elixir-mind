---
type: analysis
title: "The actor model without its runtime: Claude Code agent teams vs. BEAM/Jido 2"
description: An architecture comparison finding that agent teams is Anthropic's first actor-shaped multi-agent surface — named peers, mailboxes, direct messaging, a lock-guarded shared task queue — built as a file-based, single-machine, session-scoped coordination fabric with no supervision, so unlike Dynamic Workflows it sits squarely on the BEAM's home turf; the BEAM/Jido equivalent is structurally superior on every runtime axis (supervision, real message semantics, durability, introspection, topology freedom) yet the runtime is not where agent teams' value lives — the harness is (full Claude sessions as members, permission custody, plan approval, hooks, operator steering) — and the documented limitations list reads as an inventory of what OTP already solves, so the surfaces validate each other: use agent teams for attended session-scoped collaboration, and reach for the BEAM exactly where the session boundary breaks (standing, event-reactive, unattended, or dense non-LLM teams).
provenance: "Claude Code session (Claude Fable), 2026-07-26 — operator asked to intake the agent-teams doc and evaluate the same architecture on the BEAM using Jido 2, advantages for each. Agent-teams facts from the official docs fetched 2026-07-26; Jido facts inherit the verified 2026-07-12 baseline from the base evaluation, with two spot-checks 2026-07-26 (jido_cluster still unpublished on hex — 404; jido.run confirms signal bus + parent-child hierarchies + DAG planner as the coordination primitives)"
tags: [meta, analysis, architecture, anthropic, claude-code, agent-teams, multi-agent, beam, otp, jido, actor-model, mailbox, supervision, harness]
timestamp: 2026-07-26T00:00:00Z
attribution:
  when: 2026-07-26T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to intake the agent-teams doc and evaluate it in comparison to the same architecture on the BEAM using the Jido 2 agent framework — advantages for each"
  from: [/meta/threads/2026-07-26-agent-teams-intake-and-beam-jido-comparison.md]
---

# The actor model without its runtime: Claude Code agent teams vs. BEAM/Jido 2

**Question.** Anthropic's experimental
[agent teams](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md) let a
lead Claude Code session spawn teammate sessions that coordinate through a shared
task list and per-agent mailboxes, and message each other directly. Evaluate this
against the same architecture built on the [BEAM](/beliefs/glossary/beam.md) with
[Jido 2](/beliefs/glossary/jido.md): where does each hold the advantage?

**Thesis.** Agent teams is the first Anthropic multi-agent surface that is
**actor-shaped**: named agents, per-agent mailboxes, asynchronous peer messaging,
a shared work queue guarded by locks. Where
[Dynamic Workflows](/meta/analysis/dynamic-workflows-vs-beam-jido.md) sat at a
*different layer* from the BEAM (an ephemeral deterministic spine, no inter-agent
communication), agent teams lands **on the BEAM's home turf** — it is a hand-rolled
[actor](/beliefs/glossary/actor-model.md) system built from JSON files, file
locks, and terminal panes, with no runtime underneath. That cuts both ways. On
every *runtime* axis the BEAM/Jido equivalent is structurally superior:
supervised recovery instead of "spawn a replacement," real mailbox semantics
instead of validated JSON files, a serialized task server instead of file
locking, durable standing teams instead of session-scoped ones, arbitrary
supervision topologies instead of one fixed-lead, no-nesting team. But the
runtime was never the hard part, and it is not where agent teams' value lives:
its value is the **harness** — each teammate is a full Claude Code session with
project context, permission custody that bubbles to a human, a plan-approval
protocol, quality-gate hooks, and an operator UI for steering any member
mid-flight. A BEAM re-creation re-earns all of that at a loss, for a coordination
fabric whose cost is noise next to inference. The two surfaces therefore
*validate* each other: agent teams vindicates the actor architecture for
multi-agent work while demonstrating, in its own limitations list, why that
architecture eventually wants OTP under it.

## 1. What agent teams actually is, structurally

Strip the product layer and the mechanics are these (full capture in
[the reference](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md)):

- **Identity**: named members registered in a config file (`config.json`,
  runtime-owned), discoverable by teammates.
- **Messaging**: per-agent mailboxes as JSON files
  (`~/.claude/teams/{team}/inboxes/{agent}.json`), validated on read, delivered
  automatically; point-to-point by name, no broadcast.
- **Coordination**: a shared task list on disk with pending/in-progress/completed
  states, dependency edges that auto-unblock, and **file locking** around claims.
- **Lifecycle**: teammates notify the lead on idle and on API-error failure;
  shutdown is a cooperative request that can be rejected; teammates that stop on
  errors are replaced manually.
- **Topology**: one team per session, lead fixed for life, no nested teams,
  single machine, session-scoped existence.

Every line of that is a re-derivation, outside any runtime, of what an actor
system provides natively: registries, mailboxes, monitors, supervisors, and a
serialized state-holder in place of file locks. The docs' own limitations —
in-process teammates lost on `/resume`, task status that lags when a teammate
fails to mark completion, slow cooperative shutdown, no promotion when a lead
must go — are an inventory of the failure modes
[OTP](/beliefs/glossary/otp.md) was built to close: process linking and
monitoring make death *observable* rather than inferable, supervisors make
replacement *automatic* rather than manual, and
[let-it-crash](/beliefs/glossary/let-it-crash.md) makes "teammate stopped on an
error" a restart strategy rather than a troubleshooting section.

## 2. The head-to-head, axis by axis

**Where BEAM/Jido is structurally superior** (Jido facts per the
[verified baseline](/meta/analysis/beam-deployment-and-jido-2-evaluation.md);
spot-checked 2026-07-26):

1. **Failure handling.** A crashed Jido agent is restarted by its supervisor
   with backoff, state rehydrated, siblings untouched; a monitor tells dependents
   *that* it died, not silence. Agent teams' answer is a notification to the lead
   and manual replacement — and a task list that can silently block on a
   completion nobody marked.
2. **Message semantics.** BEAM mailboxes give ordered, in-memory,
   monitored delivery at microsecond cost; [signals](/beliefs/glossary/cloudevents.md)
   add trie-routed pub/sub — real broadcast, which agent teams lacks entirely.
   JSON-file mailboxes polled off disk with validation-and-repair are a
   workaround for not having a runtime (the pre-v2.1.207 poisoned-mailbox bug is
   the shape of the hazard).
3. **The task list as a process, not a file.** A shared queue with dependency
   edges is a few dozen lines of [GenServer](/beliefs/glossary/genserver.md):
   claims serialize through the mailbox, so the file-locking race simply cannot
   exist. Dependency auto-unblocking is a message on completion.
4. **Durability and standing.** A team on the BEAM can outlive any session —
   persist state, react to events at 3 a.m., resume after deploys (Jido's
   rehydration covers node-local recovery). Agent teams is bound to an
   interactive session and does not survive it.
5. **Topology freedom.** Supervision trees compose: teams of teams, promoted
   leads, per-subtree restart policies. Agent teams hard-codes one flat team,
   fixed lead, no nesting.
6. **Introspection.** A production BEAM node is observably alive (Observer,
   telemetry, Jido's OTel) at any depth; agent teams' observability is the agent
   panel, for the session's duration.

**Where agent teams is superior — and why the above mostly doesn't bite:**

1. **Members are full Claude Code sessions.** Context loading (CLAUDE.md, MCP
   servers, skills), tool execution, subagent definitions reused as teammate
   roles. This is the *deliberative* unit of the
   [two-plane rule](/beliefs/glossary/two-plane-rule.md) — and on the BEAM you
   would drive it over the network via the Agent SDK anyway, per teammate,
   re-implementing spawn, context, and steering.
2. **The security model comes free.** Teammate permission prompts bubble to the
   lead's terminal *for the human*; agent-to-agent messages are marked
   agent-originated so consent cannot be laundered through a teammate; plan
   approval is the one designed delegation. An owned runtime rebuilds all of
   this from credential custody up (cf. the gatekeeper design in the
   [Managed Agents comparison](/meta/analysis/claude-managed-agents-vs-beam-jido.md)).
3. **Human-in-the-loop is the product.** The operator opens any teammate's
   transcript, redirects it, interrupts it. The docs' guidance ("monitor and
   steer," don't run unattended) marks the intended regime: **attended**
   collaboration, where supervision-by-human substitutes for supervision-by-tree.
4. **Hooks as quality gates.** `TeammateIdle`/`TaskCreated`/`TaskCompleted` with
   exit-code-2 feedback is a working enforcement seam (a Jido reducer invariant
   is stronger, but exists only after you build the fleet).
5. **The economics.** Every member is a token-metered Claude instance; the
   coordination fabric — files vs. processes — is rounding error against
   inference cost and latency. The BEAM's efficiency edge lands on the one
   component that is effectively free either way. This is the standing honesty
   caveat: justify the BEAM on durability, reactivity, distribution, and fault
   isolation — never on coordination throughput for LLM-bound work.
6. **Free-riding on velocity.** Agent teams is experimental and moving
   version-by-version; an owned re-creation chases that surface while
   re-earning the harness at a loss — the same conclusion the
   [Dynamic Workflows analysis](/meta/analysis/dynamic-workflows-vs-beam-jido.md)
   reached for its layer.

**The distribution asterisk, still.** The BEAM's cross-machine story is a
substrate capability, not a Jido feature: `jido_cluster` remains unpublished on
hex (404, checked 2026-07-26), so agent identity, recovery, and the signal bus
are node-local and the distribution layer would be
[ours to build](/meta/analysis/jido-distribution-gap-and-req-llm-cognition-dependency.md).
Against agent teams this still wins by default — agent teams is one *process
tree on one machine* — but "distributed fleet" is a build, not a `mix deps.get`.

## 3. The verdict pattern: same architecture, different regime

Put beside its siblings, agent teams completes a four-shape family of
Anthropic multi-agent surfaces:
[CMA](/meta/analysis/claude-managed-agents-vs-beam-jido.md) rents hosted
deliberative sessions; [Dynamic Workflows](/meta/analysis/dynamic-workflows-vs-beam-jido.md)
runs an ephemeral deterministic spine over non-communicating calls; agent teams
adds **session-scoped peer coordination** — the closest of the three to Jido in
*shape* (mailboxes, named peers, shared work) and the farthest in *runtime
guarantees* (no supervision, no durability, no distribution, fixed topology).
The discriminator between it and the BEAM is therefore not architecture — they
agree on the architecture — but **regime**:

- **Attended, session-scoped, deliberative** → agent teams. Parallel review,
  adversarial debugging, cross-layer features: an operator present, a session
  boundary acceptable, every member a mind. The BEAM adds nothing here but
  operational surface.
- **Unattended, standing, event-reactive, or dense** → BEAM/Jido. A team that
  must outlive the session, react to signals rather than prompts, restart its
  own failures at night, or consist mostly of cheap non-LLM workers
  (the mechanical plane) is outside agent teams' design envelope entirely — not
  weakly served, unserved.

The two-plane conclusion survives a third test intact, with one sharpening:
agent teams is **evidence for the actor architecture from the opposing camp**.
Anthropic, building the deliberative plane's native collaboration surface,
independently converged on mailboxes, named peers, and a supervised-ish work
queue — then shipped it without a runtime and documented the consequences as
limitations. The BEAM case for standing agent fleets is strengthened, not
weakened, by that convergence; and the "not now" verdict for *this* repo is
untouched — agent teams is precisely the attended, session-scoped regime this
brain's sessions already live in, available for free when a working session
wants parallel perspectives.

## 4. Direct answers

- **Advantages of agent teams over a BEAM/Jido build of the same design:** the
  members themselves (full Claude sessions with context, tools, skills); the
  permission/consent custody and plan-approval protocol; operator steering UI;
  hook-based gates; zero build cost and free evolution — for the regime it
  targets, attended session-scoped collaboration, it is simply the correct tool.
- **Advantages of BEAM/Jido over agent teams:** supervision and automatic
  recovery; ordered in-memory messaging plus real pub/sub; a race-free
  serialized task server; teams that persist beyond sessions and react to
  events; nested/promotable topologies; deep introspection; unit-testable
  coordination logic (pure reducer, declared directives); and a path — though
  self-built — to multi-node scale. It owns every regime agent teams excludes.
- **Should one recreate agent teams on the BEAM?** As a like-for-like
  replacement, no — same verdict as Dynamic Workflows, for the same reason: the
  harness, not the fabric, is the moat. Build the BEAM version only when the
  *regime* demands it (standing/unattended/dense), at which point it is not a
  recreation of agent teams but the durable outer runtime of the
  [layered architecture](/meta/analysis/dynamic-workflows-vs-beam-jido.md) —
  with rented minds as members where deliberation is needed.

# Citations

- Agent teams — official docs <https://code.claude.com/docs/en/agent-teams>
  (fetched 2026-07-26; experimental, behavior stated as of v2.1.178 with notes
  through v2.1.207); distilled capture in
  [the bundle reference](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md).
- Jido 2 — inherits the verified 2026-07-12 baseline of
  [the base evaluation](/meta/analysis/beam-deployment-and-jido-2-evaluation.md);
  2026-07-26 spot-checks: https://jido.run/blog/jido-2-0-is-here (signal bus,
  parent-child hierarchies, DAG planner as coordination primitives) ·
  https://hex.pm/packages/jido_cluster (404 — still unpublished).
- Sibling analyses — [Dynamic Workflows vs. BEAM/Jido](/meta/analysis/dynamic-workflows-vs-beam-jido.md) ·
  [Claude Managed Agents vs. Jido/BEAM](/meta/analysis/claude-managed-agents-vs-beam-jido.md) ·
  [Jido's two structural caveats](/meta/analysis/jido-distribution-gap-and-req-llm-cognition-dependency.md) ·
  [dark-factory scenario](/meta/analysis/dark-factory-epistemic-base-beam-jido.md).
- Related concepts — [actor model](/beliefs/glossary/actor-model.md) ·
  [OTP](/beliefs/glossary/otp.md) · [GenServer](/beliefs/glossary/genserver.md) ·
  [let-it-crash](/beliefs/glossary/let-it-crash.md) ·
  [two-plane rule](/beliefs/glossary/two-plane-rule.md) ·
  [Jido](/beliefs/glossary/jido.md) · [BEAM](/beliefs/glossary/beam.md).
- Caveats: agent teams is experimental — mechanics (file layouts, hooks,
  limitations) may shift release to release; Jido claims not re-verified beyond
  the two spot-checks; the coordination-cost argument (§2.5) assumes
  LLM-member teams — it inverts for non-LLM mechanical fleets.
