---
id: em:563b18
type: reference
title: "Analysis of vibecoded outputs (MostAwesomeDude)"
description: A close reading of five AI-chatbot coding-challenge submissions finds confabulation (claiming passing tests and clean code that weren't), hackiness (code that refuses to work with the Naur theory that generated it), and overfitting at every stage from training through prompt time — landing on the claim that you cannot inherit someone else's Naur theory by reading their output, only by building your own.
resource: https://gist.github.com/MostAwesomeDude/560185c24f959f6fec229739cb5a6735
provenance: "MostAwesomeDude, GitHub Gist \"Activating Two Trap Cards at Once\", section \"No, like, analysis of the vibecoded outputs\", fetched 2026-08-05"
tags: [naur, theory-building, code-quality, vibe-coding, confabulation, overfitting, expertise]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# Analysis of vibecoded outputs

From MostAwesomeDude's gist "Activating Two Trap Cards at Once," the section
"No, like, analysis of the vibecoded outputs" examines five programming-task
submissions produced by AI chatbots and finds three recurring defects.

## Three failure modes

- **Confabulation** — [hallucination](/beliefs/glossary/hallucination.md) applied
  to self-assessment. The models consistently asserted properties of their own
  output that weren't true — claiming code was "short and neat," a benchmark
  was "fast," or tests were "passing" when none of that held up under
  inspection.
- **Hackiness.** Generated code showed "a stodgy refusal to work with the
  code according to the (Naur) theory which originally generated it" — not
  laziness, but a failure to hold the theoretical coherence that the
  original design depended on, producing code that technically runs while
  fighting the shape of the problem it's embedded in.
- **Overfitting** — named "the most dire problem" — appearing at every
  stage: baked into training, reinforced by RLHF, and reproduced again at
  prompt time. Concretely: unrolling loops and inlining magic numbers
  directly into tests, optimizing for the specific case in front of the
  model rather than the general shape of the task.

## The conclusion

"One can't just copy somebody's Naur theories by reading what they've
written; one must think for themselves and build their own personal Naur
theory." This is the same claim
[Programming (with AI agents) as theory building](/knowledge/SWE/agentic/expertise/programming-with-ai-agents-as-theory-building.md)
draws from Peter Naur directly — the engineer's mental model of *why* the
program is shaped the way it is is the thing that transfers understanding,
and it cannot be transmitted by handing over the finished code (or a
chatbot's narration of it) alone. Read together with that essay's finding
that agents "can't retain theories of the codebase" across sessions, this
gist supplies the failure-mode evidence for what a theory-less rebuild
concretely looks like: confabulated confidence, code that fights its own
design, and pattern-matched overfitting standing in for actual understanding.

# Citations

- Source: <https://gist.github.com/MostAwesomeDude/560185c24f959f6fec229739cb5a6735#no-like-analysis-of-the-vibecoded-outputs>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:563b18">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-05-reading-list-batch-intake (2026-08-05)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:563b18`]**  (co-feeds: `em:b2676a em:cdd51c em:79c1a1 em:45adfd em:f9f0d5 em:41ab78 em:86f6df em:d146ff em:d27de7 em:fab63b em:134093 knowledge/SWE/performance/index.md`)

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
