---
id: em:1ae179
type: concept
title: logit masking
description: Constraining what a model may generate by altering the raw per-token scores before sampling — typically forcing disallowed tokens to negative infinity — so the restriction is enforced during decoding rather than by changing the prompt.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, llm-inference, tool-use, constrained-generation, agentic-loop]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# logit masking

The advantage over removing an option from the prompt is that the context is left
untouched, so a per-step restriction costs no cache invalidation and leaves prior
turns coherent — the model can still see tools it is currently forbidden to call.
Shared naming prefixes make this cheap at family granularity: constraining an
agent to every `browser_*` tool becomes a match on the first few tokens rather
than an enumeration of names. The same machinery generalizes beyond tool choice
to grammar- and schema-constrained generation, where a validator computes the set
of tokens that could still yield a well-formed result and everything else is
masked. Often layered under the coarser modes a
[function-calling](/beliefs/glossary/function-calling.md) API already exposes,
and combined with
[response prefill](/beliefs/glossary/response-prefill.md).

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
