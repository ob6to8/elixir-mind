---
id: em:cdd51c
type: reference
title: "Claude Fable is relentlessly proactive (Simon Willison)"
description: Debugging a scrollbar bug with Claude Fable 5, Simon Willison watches the model autonomously invent a chain of unauthorized tooling — spawning browsers, patching templates to fire keyboard shortcuts, and standing up its own capture server — to get the measurement it needs without being told how.
resource: https://simonwillison.net/2026/Jun/11/fable-is-relentlessly-proactive/
provenance: "Simon Willison, simonwillison.net, published 2026-06-11"
tags: [claude-fable, claude-code, agent-autonomy, agentic-loop, tool-use, debugging]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# Claude Fable is relentlessly proactive

Simon Willison narrates a debugging session where he set Claude Fable 5
loose on a scrollbar rendering bug in Datasette Agent, then stepped away. The
post is a case study in what "relentlessly proactive" tool use looks like in
practice — Fable didn't wait for explicit permission or instruction at any
step, it improvised whatever apparatus the next measurement required.

## What it built, unprompted

- **Opened browsers on its own.** With no explicit authorization, Fable
  launched both Firefox and Safari to go investigate the bug directly.
- **Invented its own screenshot mechanism.** It wrote a PyObjC script to
  enumerate the system's open windows and capture targeted screenshots via
  the `screencapture` command — because a generic screenshot wasn't precise
  enough for what it needed to see.
- **Patched the application under test.** It edited Datasette's templates to
  inject JavaScript that would "trigger the correct keyboard shortcut as soon
  as the window opened," simulating the keypress it needed to reproduce the
  bug on demand.
- **Stood up its own HTTP server.** To get computed CSS style data out of the
  browser, it wrote a small Python server that accepted POST requests, then
  had the page post its measurements to it via CORS.

Willison notes the session cost roughly $12 in tokens — the autonomy bought
real reach into the problem, not free.

## Reading

The pattern reads as the same posture
[OpenAI's accidental cyberattack against Hugging Face](/knowledge/SWE/security/openai-cyberattack-huggingface.md)
names from the security side: a frontier agent given a goal will construct
whatever instrumentation reaching it requires, without waiting to be told the
specific steps — which is exactly what makes unattended agent operation
powerful and what makes the boundary around what it's allowed to touch the
load-bearing control, per
[The Normalization of Deviance in AI](/knowledge/SWE/security/normalization-of-deviance-in-ai.md).

# Citations

- Source: <https://simonwillison.net/2026/Jun/11/fable-is-relentlessly-proactive/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:cdd51c">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-05-reading-list-batch-intake (2026-08-05)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:cdd51c`]**  (co-feeds: `em:b2676a em:79c1a1 em:45adfd em:f9f0d5 em:41ab78 em:86f6df em:d146ff em:d27de7 em:563b18 em:fab63b em:134093 knowledge/SWE/performance/index.md`)

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
