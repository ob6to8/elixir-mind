---
id: em:9a84c7
type: reference
title: "Scaling long-running autonomous coding (Cursor)"
description: Cursor's account of what let hundreds of concurrent agents genuinely advance month-long codebases — a planner/worker/judge hierarchy replacing lock-based flat coordination, chosen after simplification (dropping an integrator role) beat adding more process, on projects spanning a 1M-line browser and a 3-week framework migration.
resource: https://cursor.com/blog/scaling-agents
provenance: "Cursor blog, \"Scaling agents\", fetched 2026-08-21"
tags: [agent-orchestration, multi-agent, autonomous-coding, cursor, coordination]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Scaling long-running autonomous coding

Cursor's account of scaling from a handful of agents on a task to hundreds of
concurrent agents advancing one codebase over weeks to months — and the
coordination failures that had to be designed away first.

## What failed first

**Flat coordination with locking.** Agents claimed locks on files or regions
before editing; the failure mode was procedural rather than conceptual —
agents held locks too long, or forgot to release them, producing bottlenecks
and brittleness under real concurrency.

**Optimistic concurrency, unlocked.** Dropping locks in favor of
detect-and-resolve conflict handling improved robustness, but changed agent
behavior for the worse: agents turned risk-averse, steering away from
difficult or contested work rather than risking a conflict — a coordination
mechanism shaping what work got attempted, not just how conflicts got
resolved.

## The architecture that worked

A planner/worker/judge hierarchy: **planners** explore the codebase and
generate tasks recursively; **workers** execute assigned tasks without
cross-coordinating with each other; a **judge agent** decides when an
iteration is complete. The team's own simplification finding cuts against the
instinct to add process: an integrator role was tried for quality control and
dropped because it "created more bottlenecks than it solved" — the best
outcome came from removing a coordination layer, not adding one.

## Model selection changed the outcome as much as architecture

"GPT-5.2 models are much better at extended autonomous work: following
instructions, keeping focus, avoiding drift, and implementing things
precisely and completely," while "Opus 4.5 tends to stop earlier and take
shortcuts" — a finding specific to sustained, low-supervision autonomous runs
rather than single-turn coding quality, where the ranking of models can
differ.

## Results

Concurrent agents under this hierarchy managed: a browser project exceeding
1M lines of code across 1,000 files; a 3-week Solid-to-React migration
(+266K/−193K lines edited); and a 25x video-rendering performance
improvement. The stated conclusion is that hundreds of concurrent agents can
genuinely advance ambitious, multi-week projects given hierarchical
coordination and role specialization — genuinely, as distinct from producing
large volumes of code that does not compound into real progress.

## Reading against this bundle

The lock-based-coordination failure and its optimistic-concurrency successor
mirror exactly the design space this bundle's own
[wave-based concurrent delivery](/knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md)
methodology was built to avoid at a much smaller scale: that methodology
partitions write surfaces into disjoint lanes up front (a mechanical
substitute for locking) rather than relying on runtime lock discipline, and
resolves the residual conflict classes (queue serials, generated artifacts)
by regeneration rather than arbitration. The judge-agent role and the
planner-never-implements/worker-never-plans split also appear, at swarm
scale, in the companion post on
[agent swarm model economics](/knowledge/SWE/agentic/orchestration/cursor-agent-swarm-model-economics.md).

# Citations

- Cursor blog, "Scaling agents" — <https://cursor.com/blog/scaling-agents>
