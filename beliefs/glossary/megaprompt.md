---
id: em:6c220e
type: concept
title: megaprompt
description: A single LLM prompt made to perform several logically distinct sub-tasks at once (e.g. extraction, classification, normalization, and validation in one call), so its failure can't be attributed to any one sub-task.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, llm-workflow-design, prompt-design, attribution]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-01 LLM-workflow-decomposition intake thread's r/LLMDevs capture, naming the failure mode a megaprompt's mixed responsibilities produce"
---

# megaprompt

The defining failure mode is attributional, not just architectural: when a
megaprompt's output is wrong, nothing in the response indicates which bundled
sub-task drifted — extraction, normalization, or a business rule could each be
the culprit, and only re-running each stage in isolation (or splitting them
out permanently) resolves the ambiguity. This is the practical argument for
[workflow decomposition](/knowledge/SWE/agentic/workflow-decomposition/index.md):
splitting a megaprompt's stable-shaped stages into separately testable
deterministic code narrows what a wrong output can even mean.

*Seen in:* [2026-08-01 LLM workflow decomposition intake](/meta/threads/2026-08-01-llm-workflow-decomposition-intake.md)
