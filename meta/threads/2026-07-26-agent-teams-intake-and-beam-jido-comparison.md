---
type: reference
title: 2026-07-26-agent-teams-intake-and-beam-jido-comparison
description: "Intake of the official Claude Code agent-teams doc as a filed reference (em:33e0c7) plus the fourth analysis in the Anthropic-vs-BEAM/Jido family — finding agent teams actor-shaped (named peers, mailboxes, lock-guarded shared task queue) but runtime-less, so the BEAM wins every runtime axis while the harness is where agent teams' value lives, and the discriminator is regime (attended session-scoped vs standing/unattended), not architecture."
provenance: "Claude Code session (Claude Fable), 2026-07-26; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, agent-teams, claude-code, beam, jido, multi-agent, analysis]
timestamp: 2026-07-26T00:00:00Z
session: https://claude.ai/code/session_015GhCftsnD7iKM5HMkRVoHW
---

# 2026-07-26-agent-teams-intake-and-beam-jido-comparison

## Where this landed

A single `/intake` of the official Claude Code agent-teams documentation with a
comparative brief attached: evaluate the same architecture on the BEAM using
Jido 2, advantages for each. The docs page was fetched in full and filed as a
bundle reference
([agent-teams](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md),
`em:33e0c7`); the comparison landed as the fourth analysis in the
Anthropic-vs-BEAM/Jido family
([agent-teams-vs-beam-jido](/meta/analysis/agent-teams-vs-beam-jido.md)),
beside the Managed Agents, Dynamic Workflows, and base-evaluation siblings. Its
finding: agent teams is Anthropic's first *actor-shaped* multi-agent surface —
named peers, per-agent mailboxes, direct messaging, a file-lock-guarded shared
task queue — shipped without a runtime, so its documented limitations read as an
inventory of what OTP already solves; yet the harness (full Claude sessions as
members, permission custody, plan approval, hooks, operator steering), not the
coordination fabric, is where its value lives, so the discriminator between it
and a BEAM/Jido build is regime, not architecture: attended session-scoped
deliberative collaboration → agent teams; standing, unattended, event-reactive,
or dense non-LLM fleets → BEAM/Jido. Two Jido facts were spot-checked fresh
(2026-07-26): `jido_cluster` still unpublished on hex, and intra-node signals +
parent-child hierarchies + a DAG planner confirmed as the coordination
primitives; everything else inherits the verified 2026-07-12 baseline. A gold
row ("agent teams" → `em:33e0c7`) was harvested and the dedup baseline
refreshed — plain recall unchanged, no regression. The operator then invoked
`/create-pull-request merge`, which produced this capture and the PR that
anchors it.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Agent-teams official doc intake (architecture, mechanics, limitations) | closed | [agent-teams](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md) | - |
| Comparative analysis: agent teams vs the same architecture on BEAM/Jido 2 | closed | [agent-teams-vs-beam-jido](/meta/analysis/agent-teams-vs-beam-jido.md) | - |
| Dedup gold row harvest + baseline refresh | closed | [dedup-probe gold set](/meta/evals/dedup-probe.md) | - |

## User

/intake https://code.claude.com/docs/en/agent-teams

Evaluate in comparison to the same architecture but on the BEAM using the Jido 2 agent framework. Advantages for each? Provide analysis

## Assistant

<routes ref="em:33e0c7 meta/analysis/agent-teams-vs-beam-jido.md">
Intake complete — two documents filed and pushed to `claude/agent-architecture-comparison-7xwd2o` (branch blob links; Pages URLs go live on merge):

- **[Claude Code agent teams](https://github.com/ob6to8/elixir-mind/blob/claude/agent-architecture-comparison-7xwd2o/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md)** — `reference`, `em:33e0c7`, filed under the existing `claude-code/` directory. Summarized capture of the official docs page (fetched in full), keeping the URL as `resource`.
- **[The actor model without its runtime: agent teams vs. BEAM/Jido 2](https://github.com/ob6to8/elixir-mind/blob/claude/agent-architecture-comparison-7xwd2o/meta/analysis/agent-teams-vs-beam-jido.md)** — `analysis`, joining the existing family (Managed Agents, Dynamic Workflows, the base Jido evaluation, the caveats expansion). Jido facts inherit the verified 2026-07-12 baseline, with two fresh spot-checks today: `jido_cluster` is *still* unpublished on hex (404), and jido.run confirms the coordination primitives are intra-node signals + parent-child hierarchies + a DAG planner.

Both indexes and the registry were regenerated; `mix brain.verify`, `brain.route_tags`, and `brain.contract --check` all pass. A gold row ("agent teams" → `em:33e0c7`) was harvested and the dedup baseline refreshed — no recall regression.
</routes>

<routes ref="meta/analysis/agent-teams-vs-beam-jido.md">
## The analysis

**The key structural finding: agent teams is the first Anthropic multi-agent surface that is actor-shaped.** Unlike Dynamic Workflows (a deterministic spine over calls that never talk to each other), agent teams has named peers, per-agent mailboxes, direct asynchronous messaging, and a shared work queue — the actor model's exact anatomy. But it ships that anatomy *without a runtime*: mailboxes are JSON files under `~/.claude/teams/`, task claiming uses file locking, and there is no supervision. Its own documented limitations list — teammates lost on `/resume`, task status that lags when a teammate silently fails, manual replacement of crashed teammates, slow cooperative shutdown, fixed lead, no nested teams — reads almost line-for-line as an inventory of what OTP solves: monitors make death observable, supervisors make replacement automatic, a GenServer task queue makes the claiming race structurally impossible.

**Advantages of BEAM/Jido 2** for the same architecture: supervised recovery with rehydrated state instead of "spawn a replacement"; ordered in-memory messaging plus real pub/sub broadcast (agent teams has no broadcast at all); a race-free serialized task server; teams that outlive sessions and react to events rather than prompts; composable topologies (teams of teams, promotable leads); deep introspection (Observer, OTel); and unit-testable coordination logic via the pure `cmd/2` reducer. One asterisk: multi-node distribution is a substrate capability, not a Jido feature — that layer would be yours to build.

**Advantages of agent teams**: the members. Each teammate is a full Claude Code session with project context, tools, and skills — on the BEAM you'd drive those over the Agent SDK anyway, per teammate. The security model comes free (permission prompts bubble to the human; agent-relayed consent is structurally distrusted; plan approval is the one designed delegation), the operator can steer any member mid-flight, hooks give working quality gates, and it costs nothing to adopt. Critically, the coordination fabric — files vs. processes — is rounding error against inference cost, so the BEAM's runtime superiority lands on the one component that's effectively free either way.

**The verdict discriminates by regime, not architecture**: attended, session-scoped, deliberative collaboration → agent teams, which is simply the correct tool there. Standing, unattended, event-reactive, or dense non-LLM fleets → BEAM/Jido, which owns every regime agent teams excludes by design. Recreating agent teams like-for-like on the BEAM re-earns the harness at a loss — the same conclusion as the Dynamic Workflows analysis. The most interesting takeaway: Anthropic independently converging on mailboxes-and-named-peers while shipping it runtime-less is *evidence from the opposing camp* that the actor architecture is right for multi-agent work — it strengthens the eventual BEAM case without moving this repo's standing "not now" verdict.

The analysis doc's `attribution.from` will be stamped when you run `/create-pull-request` (the verify gate flags it as an advisory warning until then).
</routes>

## User

/create-pull-request merge

*(The session then ran `/create-pull-request` with the merge opt-in: this capture, the glossary pass over it, the `attribution.from` stamp on the analysis doc, and the PR that anchors this thread.)*
