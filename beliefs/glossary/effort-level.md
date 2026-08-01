---
id: em:08334b
type: concept
title: effort level
description: In Claude Code, a control lever for model reasoning depth, independent of model selection—one of `low`, `medium`, `high`, `xhigh`, `max`, with availability and defaults varying by model.
sense: common
provenance: "agent-distilled from Claude Code documentation"
verified: false
tags: [claude-code, model-selection, configuration]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by 2026-08-01-skill-model-selection thread"
---

# Effort level

Distinct from **model tier** (Sonnet, Opus, Fable): where model choice is which reasoner to use, effort level controls how deeply that reasoner thinks through a problem. A Sonnet model running at `high` effort may outthink the same Sonnet at `low` effort on reasoning-heavy tasks.

Effort levels apply to a session (via `/model <alias>`, settings, or environment), a skill (via `effort:` frontmatter), or a subagent (via the subagent's `effort:` field or per-invocation override). The default is `high` on most models; Opus 4.7 defaults to `xhigh`.

**Anthropic's model-selection heuristic:** when output is wrong, ask "did it not try hard enough (raise effort) or not know enough (switch models)?" — the diagnostic shapes which lever to reach for first.

*Seen in:* [/meta/threads/2026-08-01-skill-model-selection](/meta/threads/2026-08-01-skill-model-selection.md)
