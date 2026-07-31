---
type: reference
title: 2026-07-31-microsoft-skillopt-intake
description: Intake of Microsoft's SkillOpt (a text-space optimizer that trains an agent's markdown skill file as a frozen model's trainable state) and its SkillOpt-Sleep companion, filed as two references under a new skill-optimization subdirectory, with the dedup gold set harvested.
provenance: "Claude Code session (Claude Opus 5, Claude Sonnet 5), 2026-07-31; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, skillopt, microsoft, skill-optimization, agent-memory]
timestamp: 2026-07-31
pr: 205
session: https://claude.ai/code/session_01R3FjWHYjveEV39gE3CWWAp
---

# 2026-07-31-microsoft-skillopt-intake

## Where this landed

The operator invoked `/intake` for "the new microsoft skillopt repo and
documentation" with nothing pasted, so the material was located directly:
Microsoft's `microsoft/SkillOpt` repository, its versioned docs, the arXiv
paper (2605.23904), and Microsoft Research's own feature post. Two references
were filed — the core optimizer and its SkillOpt-Sleep deployment-time
companion — under a new `skill-optimization/` subdirectory created
autonomously under the already-established `agentic/` domain. The dedup gold
set was harvested with the operator's own phrasing, the full gate suite ran
clean, and the change was committed and pushed. The operator then switched
models to Claude Sonnet 5 and invoked `/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| SkillOpt — the text-space optimizer, its training loop, and its benchmark results | closed | [skillopt.md](/knowledge/SWE/agentic/skill-optimization/skillopt.md) | - |
| SkillOpt-Sleep — the nightly session-consolidation companion and its data boundary | closed | [skillopt-sleep.md](/knowledge/SWE/agentic/agent-memory/skillopt-sleep.md) | - |

## User

/intake the new microsoft skillopt repo and documentation

## Assistant

Nothing was pasted with the invocation, so I went and found the material myself: Microsoft's SkillOpt repo, its versioned docs, the arXiv paper, and Microsoft Research's own write-up. It's a genuinely interesting one — the idea is that an agent's skill file (a plain markdown file of instructions) can be *trained* the way model weights are trained, while the model itself never changes. A second model watches the frozen model attempt scored tasks and proposes small edits to the file, and an edit is kept only if it measurably improves a score on tasks held back from tuning.

<routes ref="em:42648b">
I split it into two documents because it's really two things: the research engine (paper + repo), and SkillOpt-Sleep, a separate companion that runs nightly over your own Claude Code and Codex session history. The second one is close enough to what this repo does by hand that it earned its own place in agent memory. Both are filed, the toolchain passes clean, and the work is committed and pushed. Nothing is awaiting your ratification — the one new directory sits under the already-established `agentic/` domain, which the taxonomy protocol lets me create autonomously.
</routes>

### What I created

| Type | Doc | Why this type |
|---|---|---|
| `reference` | [skill-optimization/skillopt.md](https://github.com/ob6to8/elixir-mind/blob/claude/microsoft-skillopt-intake-7jwqdg/knowledge/SWE/agentic/skill-optimization/skillopt.md) `em:42648b` | External material captured and summarized; carries a `resource`, so it's a capture, not a statement |
| `reference` | [agent-memory/skillopt-sleep.md](https://github.com/ob6to8/elixir-mind/blob/claude/microsoft-skillopt-intake-7jwqdg/knowledge/SWE/agentic/agent-memory/skillopt-sleep.md) `em:a2a391` | Same — a distinct artifact (deployment-time companion) with its own docs and data boundary |
| — | [skill-optimization/index.md](https://github.com/ob6to8/elixir-mind/blob/claude/microsoft-skillopt-intake-7jwqdg/knowledge/SWE/agentic/skill-optimization/index.md) | Reserved listing for the new subdirectory |

<routes ref="em:42648b">
The main doc uses the layered `/summarize-technical` body the intake procedure calls for on substantial technical sources: plain-language summary → key-terms table → technical detail, cross-linked to the existing [held-out set](/beliefs/glossary/held-out-set.md), [in-context learning](/beliefs/glossary/in-context-learning.md), [prompt sensitivity](/beliefs/glossary/prompt-sensitivity.md), and [skill](/beliefs/glossary/skill.md) glossary terms.
</routes>

### What I modified

| File | Thrust |
|---|---|
| `knowledge/SWE/agentic/index.md` | Lists the new `skill-optimization` subdirectory |
| `knowledge/SWE/agentic/agent-memory/index.md` | Lists SkillOpt-Sleep |
| `meta/evals/dedup-probe.md` | Harvested your phrasing as a gold row; baseline refreshed |
| `meta/registry.md` | Regenerated for the two new ids |

### Actions I have taken

| Action | Result |
|---|---|
| Fetched primary sources | Repo README, `docs/index.md`, `docs/reference/config.md`, `docs/sleep/README.md` (raw, for verbatim quoting), arXiv abstract, MSR blog — all captured as distilled bodies with links persisted |
| Synonym-expanded dedup search | No existing doc on SkillOpt, text-space/prompt optimization, or skill training — searched across `skillopt`, `skill.md`, `trainable`, `text-space`, `TextGrad`, `GEPA`, `self-evolving`, `validation gate`, `held-out`, `Claude Dreams`, `agent sleep` |
| `mix brain.id` / `registry` / `verify` | Ids minted, registry regenerated, bundle verifies clean |
| `mix brain.dedup_probe --update-baseline` | Plain 6/20, expanded 18/20 — **both unchanged, no regression** |
| Full gate suite (pre-commit) | Format, xref, contract, registry, codemap, verify, route-tags, glossary, lineage, 188 tests — all pass |
| Commit + push | `d41d81f` on `claude/microsoft-skillopt-intake-7jwqdg` |

Two things I judged rather than looked up, so you may want to overrule them. The directory name `skill-optimization` is my choice; the field's broader established term is "prompt optimization" (TextGrad, GEPA, DSPy all sit under it), but under `agentic/` the artifact being optimized is specifically a skill document, so the narrower name reads truer. And the verifier caught me adding `verified: false` to both docs — captures carrying a `resource` must omit the field entirely, which is now correct.

<routes ref="em:42648b em:a2a391">
The substantive finding, independent of whether the framework ever gets used here: SkillOpt's authors and the Sleep docs both land on the validation gate as the load-bearing part. Without it, an agent revising its own instructions drifts; with it, the worst case is bounded because a non-improving edit is simply discarded. Every `SKILL.md` in this repo is exactly the artifact they train, currently revised by judgment with no held-out score deciding whether a revision helped. Sleep's measured `recall_k` scaling adds a second one — the gain rose monotonically with how much *relevant past experience* was recalled, which says retrieval depth, not the mere existence of memory, is what moves the number.
</routes>

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Leave as filed | The knowledge is captured; nothing further needed |
| 2 | Rename the directory to `prompt-optimization` | A shape change needing your ratification; cheap now while it holds one doc |
| 3 | File a `todo` or `plan` on gating this repo's own skill edits | Turning the transferable lesson into intended work — currently it lives only as prose in the two docs |
| 4 | `/create-pull-request` | Captures the session, glossaries it, and opens the PR |

Sources: [microsoft/SkillOpt](https://github.com/microsoft/SkillOpt) · [arXiv:2605.23904](https://arxiv.org/abs/2605.23904) · [Microsoft Research](https://www.microsoft.com/en-us/research/blog/skillopt-agent-skills-as-trainable-parameters/)

## User

/model claude-sonnet-5
/create-pull-request

## User

merge
