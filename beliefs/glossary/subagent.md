---
id: em:d91933
type: concept
title: subagent
description: In Claude Code, a delegated inference task with its own model, effort level, and toolset, spawned via the Agent tool or by a skill marking a step with `context: fork`.
sense: common
provenance: "agent-distilled from Claude Code documentation"
verified: false
tags: [claude-code, delegation, orchestration]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by 2026-08-01-skill-model-selection thread"
---

# Subagent

A subagent is not a continuation of the parent session — it runs with no conversation history (unless explicitly provided), and its model/effort/tools are determined independently per the four-step subagent resolution order: environment variable → per-invocation `model` param → subagent definition's `model` frontmatter → parent session's model.

Two invocation shapes: **Skill delegation** via `context: fork` (the skill's body becomes the subagent's prompt; the `agent:` field determines the execution environment). **Direct agent spawning** via the Agent tool (for a single hard step within a skill's clerical logic, avoiding the cost of forking the entire skill).

*Seen in:* [/meta/threads/2026-08-01-skill-model-selection](/meta/threads/2026-08-01-skill-model-selection.md), [model-selection-and-delegation](/knowledge/SWE/agentic/anthropic/claude-code/model-selection-and-delegation.md)
