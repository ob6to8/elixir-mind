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
