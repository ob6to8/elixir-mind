---
id: em:316755
type: reference
title: "Plain-English rewriter sidecars for Claude Code output (claudish-to-english, Vomit)"
description: Two independent community tools — claudish-to-english and Vomit — hook Claude Code's message stream and run a separate (often local) LLM to rewrite dense, jargon-heavy assistant output into plain language, responding to a recurring complaint that AGENTS.md/CLAUDE.md brevity instructions don't reliably hold.
resource: https://github.com/gvzdv/claudish-to-english
provenance: "gvzdv/claudish-to-english (GitHub) and Hacker News item 49375996 (Vomit), fetched 2026-08-21"
tags: [claude-code, agentic-loop, communication-style, tool-sidecar, hooks]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Plain-English rewriter sidecars for Claude Code output

Two independently-built tools address the same complaint from opposite
starting points: Claude Code's assistant output is often dense enough
("far too dense," "odd terminology" obscuring rather than clarifying, per
Hacker News commenters) that a second model is used to translate it back
into plain language after the fact, rather than relying on prompt-level
instructions (CLAUDE.md/AGENTS.md communication-style directives) to hold.

## claudish-to-english

A Claude Code plugin built on two hooks:

- **`MessageDisplay`** — buffers each streamed assistant message chunk and,
  once complete, calls a language model (local via Ollama by default, or a
  configured cloud provider — Anthropic, OpenAI, Codex) to produce a
  plain-English rewrite. Shown either appended after the original
  ("append" mode) or in place of it ("replace" mode); the underlying
  transcript is never altered.
- **`PostToolUse`** (optional) — rewrites `.md` files into plain language on
  create/edit, either as a sibling file or in place.

Style is configurable mid-session (register/tone, e.g. "tldr" or "explain
like I'm five"). Designed to fail open: if the local model is unavailable,
the original output passes through unchanged.

## Vomit

A comparable sidecar tool (surfaced via its Hacker News discussion rather
than fetched directly) built on the same premise — pipe Claude 5's output
through a separate LLM before the human reads it.

## Why this recurs

The Hacker News thread's own speculation: the density may be a side effect
of optimizing the model for agent-to-agent and tool-call communication
rather than for a human reader, which would explain why a static
instructions file doesn't reliably override it — the tendency is closer to a
trained default than a missing instruction. Discussed mitigations besides
a rewriter sidecar: enforced word budgets, technical-English style
standards (ASD-STE100), and explicit "explain simply" prompting per turn.

# Citations

- <https://github.com/gvzdv/claudish-to-english>
- <https://news.ycombinator.com/item?id=49375996> — Vomit, and the wider discussion of Claude's output density
