---
id: em:bf754e
type: concept
title: NDJSON
description: Newline-delimited JSON — a stream format in which each line is one complete, self-contained JSON value, so a consumer can parse, filter, and act on records one at a time without holding or closing the whole document.
provenance: "Agent-distilled glossary definition, 2026-07-31 session"
verified: false
sense: common
tags: [glossary, data-formats, json, streaming, cli, terminology]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 todo-surface thread cited in Seen in"
---

# NDJSON

Also written JSON Lines or JSONL. The distinction from a JSON document is
structural rather than cosmetic: a document has one root value and is only
valid once its closing bracket arrives, whereas an NDJSON stream is valid at
every line boundary. That makes it the natural output shape for a command-line
tool whose consumer is a pipeline or a subprocess reader — `grep`, `head`, and
a per-line `decode` all work on it unmodified, and a producer needs no
nesting-aware encoder, only the ability to emit one flat object at a time.

The cost is that it cannot express a single value spanning lines, so pretty
printing is unavailable by construction and any top-level metadata must ride as
its own record.

*Seen in:* [2026-07-31 todo-surface thread](/meta/threads/2026-07-31-todo-surface-cli-and-neovim-plan.md)
