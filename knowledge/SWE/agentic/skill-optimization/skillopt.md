---
id: em:42648b
type: reference
title: "SkillOpt — training the agent skill file as the trainable parameter of a frozen model (Microsoft)"
description: A text-space optimizer that treats a single markdown skill document as the trainable state of a frozen LLM agent, applying bounded add/delete/replace edits gated on a held-out validation score, and reporting best-or-tied results on all 52 evaluated (model, benchmark, harness) cells.
resource: https://github.com/microsoft/SkillOpt
provenance: "Distilled from the repository README, the versioned docs (docs/index.md, docs/reference/config.md), the arXiv abstract (arXiv:2605.23904), and the Microsoft Research feature post; all fetched 2026-07-29"
tags: [skill-optimization, prompt-optimization, agent-skills, microsoft, frozen-model, validation-gate, text-space-optimization]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "the new microsoft skillopt repo and documentation"
---

# SkillOpt

**arXiv:2605.23904** (submitted 22 May 2026) · [`microsoft/SkillOpt`](https://github.com/microsoft/SkillOpt) · MIT · `pip install skillopt`

## Plain-language summary

An agent "skill" is just a markdown file of instructions the model reads before
it works. Today those files are written by hand, generated in one shot by a
strong model, or left to revise themselves loosely — and none of those methods
reliably makes the file *better* than where it started.

SkillOpt's move is to treat that file the way machine learning treats model
weights: as the thing being **trained**. The model itself never changes — it
stays frozen. What changes is the text. A second model (the *optimizer*) watches
the frozen model attempt scored tasks, works out what went wrong, and proposes
small edits to the skill file. An edit is kept only if it measurably raises the
score on tasks the system has not been tuned against; otherwise it is thrown
away and remembered as a failure so the same bad idea is not re-proposed.

Run that loop over several passes and you get one small file — usually a few
hundred to a couple of thousand words — that you drop in front of an unmodified
model. It costs nothing extra at run time: no additional model calls, no serving
changes, just a better file. Microsoft reports that on GPT-5.5 this is worth
roughly 20–25 accuracy points averaged over six benchmarks, and that a file
trained in one setting keeps most of its value when moved to a different model
size or a different agent harness.

The idea that makes it more than prompt-tuning-with-extra-steps is the
borrowed **discipline**: epochs, batch sizes, a learning rate, a decay schedule,
and above all a validation gate. Those are what turn "the agent rewrites its own
instructions" from a process that drifts into one that is reproducible and
bounded.

## Key terms

| Term | In SkillOpt |
|---|---|
| **skill document** | the trainable state — one markdown file, the analogue of model weights |
| **frozen agent / target** | the model executing tasks; its weights are never touched |
| **optimizer model** | a *separate* model that reads scored rollouts and proposes text edits (the analogue of the gradient computation) |
| **rollout** | the forward pass — the target executes a batch of tasks under the current skill |
| **reflect** | the backward pass — the optimizer analyses trajectories into edit patches |
| **textual learning rate** | `optimizer.learning_rate`: the **maximum number of edit patches per step** — gradient clipping, in text |
| **validation gate** | a candidate skill is accepted only if it strictly improves a [held-out](/beliefs/glossary/held-out-set.md) selection-split score |
| **rejected-edit buffer** | memory of refused edits, fed back as negative signal |
| **slow / meta update** | epoch-boundary longitudinal update and cross-epoch optimizer memory |
| **`best_skill.md`** | the deployed artifact — typically 300–2,000 tokens |
| **harness** | the execution environment: direct chat, Codex CLI, or Claude Code CLI |

## The method

The paper's framing, verbatim:

> "We argue the skill should instead be trained as the external state of a
> frozen agent, with the same discipline that makes weight-space optimization
> reproducible. SkillOpt is, to our knowledge, the first systematic controllable
> text-space optimizer for agent skills: a separate optimizer model turns scored
> rollouts into bounded add/delete/replace edits on a single skill document, and
> an edit is accepted only when it strictly improves a held-out validation
> score."

The loop, as the docs render it:

```
rollout → reflect → aggregate → select → update → gate
                                          ↑
                    (epoch boundary: slow update + meta skill)
```

The docs state the correspondence directly:

| Deep learning | SkillOpt |
|---|---|
| Model weights | Skill document (Markdown) |
| Forward pass | Rollout (target executes tasks) |
| Loss / gradient | Reflect (optimizer produces edit patches) |
| Gradient clipping | Edit selection (`learning_rate` = max edits) |
| SGD step | Patch application to skill |
| Validation set | Gated evaluation on selection split |
| LR schedule | `lr_scheduler`: cosine, linear, constant |
| Epochs | Multi-epoch with slow update & meta skill memory |

Three controls do the stabilizing work — a bounded edit budget per step, the
strict validation gate, and the rejected-edit buffer — "while adding **zero
inference-time model calls** at deployment." The restraint is real rather than
nominal: Microsoft Research reports the deployed file averaged roughly 920 tokens
with only "one to four edits accepted into the final file."

### Shipped defaults

From `docs/reference/config.md`: 4 epochs, batch size 40, reflect minibatch 8,
seed 42; `optimizer.learning_rate` 4 patches per step decaying to a floor of 2
on a `cosine` schedule; `use_slow_update` and `use_meta_skill` on;
`evaluation.use_gate` **on** by default (setting it `false` "records validation
but force-accepts each candidate"). Optimizer and target roles are configured
**separately**, so a strong optimizer can train a skill for a weak target.

Backends: `openai_chat`, `openai_compatible`, `claude_chat`, `qwen_chat`,
`minimax_chat`, `codex_exec` (all usable as optimizer or target), plus
`claude_code_exec` and `cursor_exec` which are **target-only**. The docs flag one
naming trap: "Despite its name, `claude_chat` launches `claude -p`; it is not a
direct Anthropic API client."

## Results

Six benchmarks (SearchQA, SpreadsheetBench, OfficeQA, DocVQA,
LiveMathematicianBench, ALFWorld), seven target models (GPT-5.5 down to
open-weight Qwen3.5-4B), three harnesses:

- **Best or tied on all 52 evaluated (model, benchmark, harness) cells**, beating
  every per-cell competitor "among human, one-shot LLM, Trace2Skill, TextGrad,
  GEPA, and EvoSkill skills."
- On GPT-5.5, average lift over no-skill accuracy: **+23.5 points in direct chat,
  +24.8 inside the Codex agentic loop, +19.1 inside Claude Code** (58.8 → 82.3 in
  direct chat). Largest per-benchmark movements reported: SpreadsheetBench
  41.8 → 80.7, OfficeQA 33.1 → 72.1.
- **Transfer**: artifacts "retain value when moved across model scales, between
  Codex and Claude Code execution environments, and to a nearby math benchmark
  without further optimization." A spreadsheet skill trained under Codex scored
  81.8 versus a 22.1 baseline when moved to Claude Code, which Microsoft reads as
  evidence the skills capture "general workflow logic, not just harness-specific
  recipes."

These are the authors' own reported figures; this document has not independently
reproduced them, and the benchmark suite is the authors' selection.

## Why it matters here

The brain already holds the observation that agents improve by accumulating
*distilled* records rather than raw trajectories — the case made in
[EXG's experience graphs](/knowledge/SWE/agentic/agent-memory/experience-graphs-exg.md).
SkillOpt is the same intuition pushed onto a different artifact: not a memory
store consulted at run time, but a **single instruction file compiled ahead of
time**, so the accumulated lesson costs zero tokens of retrieval and zero extra
calls.

It also puts a measurement discipline under something this repository does by
hand. Every `SKILL.md` under `.claude/skills/` is exactly the artifact SkillOpt
trains — a [skill](/beliefs/glossary/skill.md) file whose wording is currently
revised by judgment, with no held-out score deciding whether a revision helped.
SkillOpt's claim is that the gate is the load-bearing part: without it, an agent
revising its own instructions drifts; with it, the worst case is bounded because
a non-improving edit is simply discarded. That is a transferable lesson
independent of whether the framework itself is ever adopted here.

The mechanism is [in-context learning](/beliefs/glossary/in-context-learning.md)
throughout — no weights move — which also means the results are a large,
systematic demonstration of
[prompt sensitivity](/beliefs/glossary/prompt-sensitivity.md): a 20-point swing
from rewriting one markdown file is a statement about how much of a frozen
model's apparent competence is gated by its instructions.

The deployment-time companion, which applies the same gated-edit discipline to
your own Claude Code and Codex session history, is filed separately as
[SkillOpt-Sleep](/knowledge/SWE/agentic/agent-memory/skillopt-sleep.md).

# Citations

- Repository and README — https://github.com/microsoft/SkillOpt
- Versioned documentation — https://github.com/microsoft/SkillOpt/blob/main/docs/index.md
- Configuration reference — https://github.com/microsoft/SkillOpt/blob/main/docs/reference/config.md
- Paper — Yang et al., "SkillOpt: Executive Strategy for Self-Evolving Agent
  Skills", arXiv:2605.23904 — https://arxiv.org/abs/2605.23904
- Microsoft Research feature — https://www.microsoft.com/en-us/research/blog/skillopt-agent-skills-as-trainable-parameters/
- Project page — https://microsoft.github.io/SkillOpt/
