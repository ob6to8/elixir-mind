---
id: em:45adfd
type: reference
title: "LLM — Simon Willison's multi-provider CLI and Python library"
description: A command-line tool and Python library giving one consistent interface to OpenAI, Claude, Gemini, Llama, Ollama, and any OpenAI-compatible endpoint, with logging to SQLite, embeddings, structured extraction, and a plugin ecosystem.
resource: https://llm.datasette.io/en/stable/index.html
provenance: "LLM documentation (llm.datasette.io), Simon Willison's Datasette project, fetched 2026-08-05; 0.32 release notes from simonwillison.net, published 2026-08-04"
tags: [llm-cli, simon-willison, datasette, developer-tools, command-line, embeddings, multi-provider]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# LLM

`llm` is a command-line tool and Python library, part of Simon Willison's
Datasette ecosystem, giving one consistent interface across LLM providers —
OpenAI, Anthropic's Claude, Google Gemini, Meta Llama, self-hosted models via
Ollama, and any OpenAI-compatible endpoint.

## Core capabilities

- Run prompts directly from the terminal against any configured model.
- Log every conversation and its full history to a local SQLite database
  (`llm logs`).
- Generate and search vector embeddings.
- Extract structured data from text or images against a schema.
- Give a model tool-execution abilities.
- Handle image, audio, and video input.
- Multi-turn interactive chat via `llm chat`.

A plugin architecture lets third parties add models, tools, embedding
providers, and subcommands — the `llm-anthropic` plugin (below) is one such
plugin.

## Install

```
pip install llm        # or: brew install llm / pipx install llm / uv tool install llm
```

## Basic usage

```
llm "Your prompt here"
llm -m model-name "Prompt"
llm chat -m model-name
```

API keys are stored securely; a default model and other settings are
configurable.

## Release notes: LLM 0.32 (2026-08-04)

Per Willison, "the most substantial update to the LLM project since its
inception":

- **Reasoning traces.** Models now write their reasoning/thinking to
  stderr — visible without polluting stdout — toggled off with
  `-R/--hide-reasoning`.
- **GPT-5.6 support.** The GPT-5.6 model family ships out of the box, with
  GPT-5.6 Luna as the new default for the bare `llm` command on a
  cost/capability balance.
- **Server-side tools.** Providers can now run tools on their own
  infrastructure: OpenAI supplies `CodeInterpreter` and `WebSearch`; the
  companion `llm-anthropic` plugin (0.26) adds `WebSearch`, `WebFetch`,
  `CodeExecution`, and `AnthropicMCP`.
- **`model.prompt(messages=[])`.** The Python API accepts a direct
  message-sequence argument, plus streaming events that distinguish
  reasoning content, text output, tool calls, and attachments.
- **Content-addressable logging.** A new content-addressable message store
  — "inspired by Git" — de-duplicates redundant JSON in the log database
  while keeping a full audit trail, surfaced through the upgraded `llm logs`
  commands.

# Citations

- Source (docs): <https://llm.datasette.io/en/stable/index.html>
- Source (0.32 release): <https://simonwillison.net/2026/Aug/4/new-release-of-llm/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:45adfd">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-05-reading-list-batch-intake (2026-08-05)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:45adfd`]**  (co-feeds: `em:b2676a em:cdd51c em:79c1a1 em:f9f0d5 em:41ab78 em:86f6df em:d146ff em:d27de7 em:563b18 em:fab63b em:134093 knowledge/SWE/performance/index.md`)

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
