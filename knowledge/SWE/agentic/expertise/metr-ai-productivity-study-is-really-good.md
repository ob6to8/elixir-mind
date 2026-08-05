---
id: em:d27de7
type: reference
title: "METR's AI Productivity Study is Really Good (Sean Goedecke)"
description: Goedecke's read of METR's RCT on experienced open-source developers using Cursor Pro and Claude Sonnet on large, familiar codebases — they predicted and believed a ~20-24% speedup but measured 19% slower — and his account of why expert-in-familiar-codebase is close to the worst case for AI acceleration.
resource: https://www.seangoedecke.com/impact-of-ai-study/
provenance: "Sean Goedecke, seangoedecke.com essay, published 2025-07-11"
tags: [developer-productivity, metr-study, ai-assisted-development, expertise, empirical-evaluation]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# METR's AI Productivity Study is Really Good

Sean Goedecke praises METR's randomized controlled trial measuring AI's
effect on experienced open-source developers working with state-of-the-art
tools (Cursor Pro, Claude Sonnet) on large, real-world codebases they already
knew well.

## The counterintuitive result

Participants predicted AI would make them roughly 24% faster, and afterward
*believed* they had been about 20% faster. Objectively measured, they were
19% **slower** — despite having full discretion over when and how to use AI.
The study found "no difference" in the slowdown between participants with
prior AI experience and those without, and "developers didn't get faster
with AI over the course of the experiment" as they gained practice in-study.

## Goedecke's reading

He finds most plausible that highly experienced developers working in
codebases they already know well have little room left for AI to
accelerate — expertise-in-a-familiar-codebase is close to the condition
under which AI assistance has the least to add, not the most. His own
addition: "pure" software projects with high quality bars (compilers,
libraries) resist AI contribution more than most other domains, because
correctness stakes are higher and the tolerance for AI's characteristic
sloppiness is lower.

On the *illusion* of speed specifically — why participants believed they
were faster when they weren't — Goedecke's theory is that AI-assisted coding
lowers cognitive load, and the resulting feeling of ease gets misread as
velocity, rather than actually saving time. He calls this the field's most
rigorous engineering-focused AI productivity study to date, despite (or
because of) the surprising result.

## Relation to the rest of the corpus

This measures the opposite end of the ability distribution from
[AI makes weak engineers less harmful](/knowledge/SWE/agentic/expertise/ai-makes-weak-engineers-less-harmful.md):
where AI raises the floor for weak engineers, this study suggests it may not
raise the ceiling for the strongest ones already working inside familiar,
high-quality-bar code — consistent with
[LLMs reward expertise](/knowledge/SWE/agentic/expertise/llms-reward-expertise.md)'s
claim that the bottleneck is specifying and judging output, which an expert
in a familiar codebase was already doing efficiently without AI.

# Citations

- Source: <https://www.seangoedecke.com/impact-of-ai-study/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:d27de7">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-05-reading-list-batch-intake (2026-08-05)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:d27de7`]**  (co-feeds: `em:b2676a em:cdd51c em:79c1a1 em:45adfd em:f9f0d5 em:41ab78 em:86f6df em:d146ff em:563b18 em:fab63b em:134093 knowledge/SWE/performance/index.md`)

**What I created**

| Doc | Type | Why this type |
|---|---|---|
| [Normalization of Deviance in AI](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/security/normalization-of-deviance-in-ai.md) | reference | captured external analysis |
| [Claude Fable is relentlessly proactive](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/anthropic/claude-code/fable-is-relentlessly-proactive.md) | reference | captured external analysis |
| [Proofreader prompt](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/prompt-design/proofreader-prompt-pattern.md) | snippet | a reusable prompt template, not a distilled argument |
| [LLM — multi-provider CLI/library](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/dev-tools/llm-cli-tool.md) | reference | product docs + its 0.32 release notes, combined |
| [OpenAI's accidental cyberattack against Hugging Face](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/security/openai-cyberattack-huggingface.md) | reference | captured external analysis |
| [Profiling Rust NIFs in Elixir](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/performance/profiling-rust-nifs-in-elixir.md) | reference | captured how-to writeup |
| [Litestream](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/dev-tools/litestream.md) | reference | promoted from the survey/bookmarks tier |
| [Model-Based Agentic Software Engineering (MAGE) — framework overview](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/governance/model-based-agentic-software-engineering-mage.md) | reference | whole-framework granularity beside the existing chapter capture |
| [METR's AI Productivity Study is Really Good](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/expertise/metr-ai-productivity-study-is-really-good.md) | reference | captured external analysis |
| [Analysis of vibecoded outputs (MostAwesomeDude)](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/expertise/vibecoded-outputs-analysis-mostawesomedude.md) | reference | captured external analysis |
| [UML — introduction](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/software-design/unified-modeling-language-introduction.md) | reference | encyclopedia-style capture |
| [Jido Assembly — a Slack clone](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/frameworks/jido-assembly-slack-clone.md) | reference | captured case study |

Plus `knowledge/SWE/performance/index.md` for the new subdirectory, and every touched directory's `index.md` (`security`, `claude-code`, `prompt-design`, `dev-tools`, `governance`, `expertise`, `software-design`, `frameworks`, top-level `SWE`).
