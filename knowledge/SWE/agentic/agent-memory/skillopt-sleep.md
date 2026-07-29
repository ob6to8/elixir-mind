---
id: em:a2a391
type: reference
title: "SkillOpt-Sleep — nightly offline consolidation of coding-agent sessions into gated skill updates"
description: A preview deployment-time companion to SkillOpt that harvests local Claude Code, Codex, and Cursor transcripts, mines recurring tasks, replays them, and consolidates the result into a skill update behind a held-out validation gate — staged for human adoption rather than applied automatically.
resource: https://github.com/microsoft/SkillOpt/blob/main/docs/sleep/README.md
provenance: "Distilled from docs/sleep/README.md in microsoft/SkillOpt (tracking main), fetched 2026-07-29"
tags: [agent-memory, skill-optimization, offline-consolidation, claude-code, codex, cursor, validation-gate, privacy]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "the new microsoft skillopt repo and documentation"
---

# SkillOpt-Sleep

Preview companion shipped with [SkillOpt](/knowledge/SWE/agentic/skill-optimization/skillopt.md)
(v0.2.0, `skillopt-sleep` CLI). Where SkillOpt trains a skill against a benchmark
split, Sleep "applies SkillOpt's discipline to your *own daily usage*" — it takes
the sessions you already ran as its training data.

## The cycle

One "night", as the docs give it:

```
harvest Claude Code / Codex / Cursor transcripts → mine recurring tasks
  → replay via the configured backend
  → consolidate (reflect → bounded edit → GATE on real held-out tasks)
  → stage proposal → (you) adopt
```

```bash
skillopt-sleep dry-run   # harvest + mine + replay, report only; stages nothing
skillopt-sleep run       # a full cycle; the proposal is staged for review
skillopt-sleep status    # state + latest staged proposal
skillopt-sleep adopt     # apply the staged proposal
skillopt-sleep schedule  # install a nightly cron entry for this project
```

The engine lives in a top-level `skillopt_sleep/` package with "**zero
dependency** on the paper's `skillopt/` code (the validation gate is vendored)".
Thin per-agent shells wrap it: a Claude Code plugin (`/skillopt-sleep`), a Codex
skill, a Cursor slash command, MCP servers for Copilot and Devin, and an
OpenClaw reference adaptation. Default harvest window is 72 hours.

Two consolidation mechanisms ship **off** by default: `recall_k` (associative
recall of the K most-similar past tasks from a persisted archive) and
`dream_factor` (synthetic task variants); `dream_rollouts` runs each task K times
for contrastive reflection.

The authors position it as a synthesis of three lines: "**SkillOpt**
(validation-gated bounded text edits), **Claude Dreams** (offline consolidation;
review-then-adopt), and the **agent-sleep** idea (short-term experience →
long-term competence)."

## Reported results, and the stated limits

The headline experiments are a controlled recipe (5 nights × 10 new tasks,
optimizer GPT-5.5, single seed 42) — explicitly "**not the shipping CLI
defaults**":

- **End-to-end on real agents** (gbrain-evals `skillopt-v1`): deficient seed
  skills go **0.00 → 1.00** held-out with both Claude Code and Codex as target.
- **SearchQA** (1,400-item held-out test, gated, target GPT-5.5): the gain rises
  monotonically with how much past experience is recalled — `recall_k=10` +3.1
  pts, `recall_k=20` +4.5, full-history replay +5.6.
- **SpreadsheetBench** (280-item held-out): 0.279 → 0.314, +3.6.

The docs bound the claim themselves, under a heading they call "Honest
scope": the gains "hold where tasks recur and have a checkable correctness
signal", and on saturated or noisy benchmarks the effect is "**flat within
run-to-run noise**" — single-seed baseline variance of ±1–2 points, so
sub-~1.5-point differences are noise. Their conclusion on the gate matches the
main paper's: "The validation gate keeps the worst case bounded; keep it **on**
by default."

## The data boundary

This is the part that decides whether the tool is usable on a given project.
Harvesting is local and
read-only, and the `mock` backend makes no provider calls. But with a real
backend selected, Sleep "sends truncated excerpts from harvested sessions and
derived tasks to the provider you select for mining, replay, judging, and
reflection", and — verbatim — "**Outbound prompts are not currently guaranteed to
be secret-free**; review your transcript source and provider policy before
running on sensitive projects."

Mitigations the docs offer: harvest to a task file, inspect and redact it, mark
it `"reviewed": true`, then replay that file. Known secret-shaped strings are
redacted as defense in depth (`redact_secrets`, on by default). A per-night
`evidence.jsonl` records best-effort-redacted copies of miner, replay, judge, and
reflection prompts and replies — "Treat it as sensitive local data and apply an
appropriate retention policy" (`evidence_log: false` disables it).

Also flagged: session and task limits "are not hard call, token, time, or
monetary budgets", and a real-backend `dry-run` still incurs spend.

## Why it matters here

Sleep is the closest external analogue to what this repository does by hand. The
brain's own loop — capture a session, distill it, route the durable lesson into a
document — is a manual harvest-and-consolidate over exactly the transcripts Sleep
reads. The two differences are instructive rather than incidental: Sleep's target
is an executable skill file scored against replayed tasks, so its consolidation
is **gated by measurement**, where this brain's is gated by operator judgment;
and Sleep proposes rather than applies, staging every change for human adoption —
the same review-then-adopt posture the contract's ratification protocol takes
toward changes in the shape of the brain.

Its held-out gate is the mechanism worth carrying independent of the tool: it is
what separates offline self-improvement from
[unstructured self-revision](/knowledge/SWE/agentic/agent-memory/experience-graphs-exg.md),
and the measured `recall_k` scaling is direct evidence that *how much relevant
past experience is retrieved* — not merely that some memory exists — is what
moves the number.

# Citations

- SkillOpt-Sleep overview — https://github.com/microsoft/SkillOpt/blob/main/docs/sleep/README.md
- Fuller results (gate-safety stress test, replay scaling, dream-diversity
  ablation) — https://github.com/microsoft/SkillOpt/blob/main/docs/sleep/RESULTS.md
- Engine package — https://github.com/microsoft/SkillOpt/tree/main/skillopt_sleep
- Per-agent plugin shells — https://github.com/microsoft/SkillOpt/tree/main/plugins
