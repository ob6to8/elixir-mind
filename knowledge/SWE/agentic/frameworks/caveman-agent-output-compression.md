---
id: em:b4e21d
type: reference
title: "Caveman — AI agent output compression"
description: A multi-platform plugin for AI coding agents (Claude Code, Cursor, Copilot, etc.) that reduces output tokens by ~65% through terse communication while preserving technical accuracy and code correctness.
resource: https://github.com/juliusbrussee/caveman
provenance: "Julius Brussee, GitHub repository, 2026"
tags: [token-reduction, agent-efficiency, output-optimization, cost-reduction, prompt-compression, ai-coding-agents, caveman-tool]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: intake
  agent: "Claude Code agent, /intake"
  why: "Tool for optimizing agent communication efficiency; relevant to agentic-loop cost and context management patterns"
---

# Caveman — AI agent output compression

## What It Does

Caveman is a plugin/skill available across 30+ AI coding agents (Claude Code, Cursor, Gemini, Cline, Copilot, and others) that compresses agent responses by removing filler language and adopting terse communication. Its core principle: *"why use many token when few token do trick."*

**Key invariant:** Code, commands, and error messages remain **byte-for-byte identical**—only explanatory prose shrinks.

## Design & Features

**Six compression levels** can be toggled with `/caveman [level]`:
- `lite` — minimal compression
- `full` — standard compression
- `ultra` — aggressive compression
- `wenyan` — specialized mode (name suggests Classical Chinese brevity aesthetic)

**Specialized command variants:**
- `/caveman-commit` — one-line commit messages (token-optimized)
- `/caveman-review` — ultra-concise PR review comments
- `/caveman-stats` — token savings tracking across sessions

**Memory file compression:** `/caveman-compress` rewrites documentation in-place, cutting input tokens by ~46% for all future sessions using that memory.

**Universal installation** auto-detects and configures supported agents; **zero telemetry**, entirely local operation.

## Problem Solved

Addresses two operational constraints in AI-assisted coding:

1. **Token cost & speed:** Longer agent responses consume more tokens and take longer to generate. By cutting output verbosity, caveman reduces API costs and improves latency.

2. **Output quality paradox:** Caveman's premise (backed by the March 2026 arXiv paper `2604.00025`) is that *less prose = better reasoning*. Overly elaborate explanations can introduce errors; concise communication forces clarity and reduces hallucination. The paper reports ~26 percentage point accuracy improvements by constraining output length on benchmarks.

## Relevance to Agentic Loops

In the context of [agentic-loop](/knowledge/SWE/agentic/agentic-loop/index.md) design:
- Reduces context bloat from agent output over multi-turn sequences
- Aligns with the [control-plane principle](/knowledge/SWE/agentic/agentic-loop/unattended-agent-operation-control-plane-patterns.md) of deterministic, efficient dispatch
- Cost ceiling enforcement (per session) benefits from token-reduction at the source rather than just output filtering

## Related

- [Brevity Constraints Reverse Performance Hierarchies](/knowledge/SWE/agentic/prompt-design/brevity-constraints-reverse-performance-hierarchies.md) — the research grounding caveman's brevity hypothesis

## Citations

GitHub: juliusbrussee/caveman
- https://github.com/juliusbrussee/caveman

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:b4e21d">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-31-survey-batch-intakes-and-review-pr-skill-audit (2026-07-31)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:b4e21d`]**  (co-feeds: `em:2f847a`)

Intake complete.

**What I filed**

**Type:** reference  
**Path:** `/knowledge/SWE/agentic/agentic-loop/unattended-agent-operation-control-plane-patterns.md`  
**ID:** em:5a82cf  
**Why this type:** Captures a practitioner's operational playbook from a Reddit discussion — a primary-source reference describing control plane design patterns for running agents at scale unattended.

**Content captured**

The Reddit discussion (Competitive-Bend-143 et al., r/AgentsOfAI) distilled into a reference covering:

**Five core operational principles** the author validated over a year:
1. **Visibility before automation** — seeing session state killed most babysitting
2. **Interruptions must be one tap** — approval workflows must reach a phone, or they don't scale
3. **"Done" has to be machine-checkable** — the repo's own CI/tests decide, not the model's self-report
4. **No-progress is a signal** — treat stalls as symptoms, flag and bounce after minutes
5. **Models never schedule work** — dispatch, retries, merges are deterministic code; the model executes tasks within a control loop, not the loop itself

**Four community-validated extensions** (BatResponsible1106, Intrepid-Ant-2796, SAAGASolve, BorkoBuilds):
- External tool/API failures as first-class architectural concerns
- Cost and wall-clock ceilings enforced by the dispatcher, not watched on dashboards (catches both stalls and wastefulness)
- Structuring logs to capture reasoning, not just actions
- Independent verification: agent logs can't be the sole record of what the agent did

**Distinction from existing content**

Related but distinct from:
- **Supervision consoles** (em:b4bb5e) — visibility *tooling*, not operational patterns
- **Ambient observability** (em:7404fb) — perception layer for trust, not control plane design
- **Scar tissue drift** (em:60242a) — behavioral degradation in long runs, not dispatch/cost/failure governance
- **Control plane** (em:f3e4cb) glossary — architectural term, not operational design patterns

The Reddit content is **new**: it captures the design decisions and tradeoffs at the orchestration layer — how to distribute decision-making between orchestrator and model, how to make unattended operation tractable.

**Index & conformance**

- Updated `/knowledge/SWE/agentic/agentic-loop/index.md` — added to Reliability & long-horizon section
- Regenerated `meta/registry.md`
- All gates pass: format, xref, verify, route_tags, glossary, lineage, tests

**Commit**

Staged, committed, and pushed to `claude/survey-bookmarks-links-fdfn2c`:

---

**[`em:b4e21d`]**  (co-feeds: `em:2f847a`)

**Intake complete ✓**

Both resources have been successfully processed and filed into the knowledge bundle:

| Document | Type | Directory | ID | Description |
|---|---|---|---|---|
| Brevity Constraints Reverse Performance Hierarchies in Language Models | `source` | `/knowledge/SWE/agentic/prompt-design/` | `em:2f847a` | Research on performance degradation in larger LLMs due to verbosity; brevity constraints reverse this hierarchy (+7.7–15.9pp accuracy) |
| Caveman — AI agent output compression | `reference` | `/knowledge/SWE/agentic/frameworks/` | `em:b4e21d` | Multi-platform plugin reducing agent output tokens by ~65% through terse communication while preserving code correctness |

**Actions taken**

- **Created new directory** `/knowledge/SWE/agentic/prompt-design/` for prompt engineering research & patterns (subdirectory under existing `agentic/` domain — autonomous per taxonomy-evolution protocol)
- **Dedup searches** found no duplicates; both concepts are novel to the bundle
- **Cross-linked** caveman reference to the brevity-constraints paper (they share the same research foundation on brevity improving accuracy)
- **Updated indices:**
  - Added prompt-design to `/knowledge/SWE/agentic/index.md`
  - Updated `/knowledge/SWE/agentic/frameworks/index.md` to list caveman
  - Created `/knowledge/SWE/agentic/prompt-design/index.md`
- **Minted IDs** and regenerated registry (`mix brain.registry`)
- **All gates passing:** format, xref, verify, route_tags, glossary

Ready to commit and PR this batch of work when you give the signal.
