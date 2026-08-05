---
id: em:d0d15d
type: concept
title: unhobbling
description: Removing scaffolding that constrains a model rather than helping it — instructions and guardrails added to patch a weakness keep binding after the weakness is gone, so deleting them recovers capability the model already had.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [context-engineering, prompting, model-capability, agent-guidance]
timestamp: 2026-08-05
attribution:
  when: 2026-08-05T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the framing Anthropic's context-engineering post uses for its 80% system-prompt removal, intook 2026-08-05"
---

# unhobbling

The observation that a model's usable capability is bounded not only by what it
can do but by what its scaffolding permits. Guidance written to compensate for
a weakness — worked examples, rigid rules, repeated warnings — does not expire
when the weakness does; it keeps constraining a model that no longer needs it,
and the removal is what surfaces the latent capability.

Anthropic applies the term to Claude Code's own system prompt, which it reports
shrinking by over 80% for the Claude 5 generation with no measured regression
(see [the post](/knowledge/SWE/agentic/context-engineering/new-rules-of-context-engineering-claude-5.md)).
The accompanying shifts are all subtractive or relocating: constraints give way
to judgment, upfront loading to
[progressive disclosure](/beliefs/glossary/progressive-disclosure.md),
repetition to concision.

**The claim is harder to establish than it looks.** That a deleted instruction
*was once* load-bearing is a counterfactual about an older model, and a null
[ablation](/beliefs/glossary/ablation.md) on the current one does not supply
it. Unhobbling and *this never worked* predict the same measurement, so the
framing is a hypothesis about why the scaffolding is removable rather than a
finding that follows from the removal.

*Seen in:* [2026-08-05 context-engineering intake and instruction conflict](/meta/threads/2026-08-05-anthropic-context-engineering-intake-and-instruction-conflict.md)
