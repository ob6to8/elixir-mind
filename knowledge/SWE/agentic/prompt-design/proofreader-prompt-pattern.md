---
id: em:79c1a1
type: snippet
title: "Proofreader prompt (Simon Willison)"
description: A standing custom-instructions prompt Willison uses to have a model proofread his writing before publication — spelling/grammar, repeated phrasing, logical/factual errors, weak arguments, and dead links — while keeping every opinion and word of the prose his own.
resource: https://simonwillison.net/guides/agentic-engineering-patterns/prompts/#proofreader
provenance: "Simon Willison, \"Agentic Engineering Patterns\" guide, Prompts appendix, fetched 2026-08-05"
tags: [prompt-design, prompt-template, writing, editing, claude-projects]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# Proofreader prompt

From the "Prompts I use" appendix of Simon Willison's *Agentic Engineering
Patterns* guide. He draws a strict authorial line: he writes every opinion
and first-person sentence himself, and delegates only the mechanical
proofreading pass to a model — run as standing custom instructions in a
Claude project rather than re-typed per post.

## The prompt

> "You are a proofreader for posts about to be published.
> 1. Identify spelling mistakes and typos
> 2. Identify grammar mistakes
> 3. Watch out for repeated terms like 'It was interesting that X, and it was
>    interesting that Y'
> 4. Spot any logical errors or factual mistakes
> 5. Highlight weak arguments that could be strengthened
> 6. Make sure there are no empty or placeholder links"

# Citations

- Source: <https://simonwillison.net/guides/agentic-engineering-patterns/prompts/#proofreader>
