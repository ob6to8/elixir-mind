---
id: em:dc4bb0
type: claim
title: "Long-context use is position-biased (lost in the middle)"
description: "Models use in-context information unevenly by position — performance is highest when relevant information sits at the beginning or end of the context and degrades in the middle, even for explicitly long-context models."
verified: true
verified_by: [em:42f3a0]
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02 — distilled from Liu et al. (TACL) and the attention-mechanics literature"
tags: [agentic, failure-modes, long-context, position-bias, serial-position, attention, architecture]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T03:41:25Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research spike on bias mapping"
  why: "the architectural channel is one of the three evidence legs the bias-mapping cluster stands on and needed to be filed at claim strength"
---

# Long-context use is position-biased (lost in the middle)

Liu et al. measured multi-document QA and key-value retrieval while moving
the relevant information through the context and found that "performance is
often highest when relevant information occurs at the beginning or end of
the input context, and significantly degrades when models must access
relevant information in the middle of long contexts, even for explicitly
long-context models"
([captured abstract](/knowledge/SWE/agentic/failure-modes/sources/liu-2023-lost-in-the-middle.md)).
The curve is U-shaped over position — a primacy and recency profile.

## Why this claim matters

The profile *looks like* the human serial-position curve, and that
resemblance is exactly what makes it the standing cautionary example for
bias-mapping: the best-supported drivers here are mechanical, not
semantic. Softmax attention structurally over-weights early tokens — Xiao
et al. observe "strong attention scores towards initial tokens as a 'sink'
even if they are not semantically important"
(<https://arxiv.org/abs/2309.17453>) — recency falls out of causal masking
and training exposure, and Anthropic's engineering guidance treats the whole
phenomenon as budget arithmetic: "Context, therefore, must be treated as a
finite resource with diminishing marginal returns"
(<https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>).
A behavioral twin of a human memory phenomenon, produced by machinery with
no episodic memory at all — the case examined in
[mapping agent failure modes to cognitive biases](/knowledge/SWE/agentic/failure-modes/mapping-agent-failure-modes-to-cognitive-biases.md).

## Agent consequences

For agents, position bias is not a retrieval curiosity: mid-context
observations silently stop informing behavior, and an early frame enjoys
positional privilege over a mid-session correction — one of the compounding
factors in
[premise-retraction persistence](/knowledge/SWE/agentic/failure-modes/premise-retraction-persistence.md).
Order sensitivity extends to reasoning itself: Chen et al. find "LLMs are
surprisingly brittle to the ordering of the premises" and that "permuting
the premise order can cause a performance drop of over 30%"
(<https://arxiv.org/abs/2402.08939>).

# Citations

- Liu et al. (2023), "Lost in the Middle: How Language Models Use Long
  Contexts" —
  [captured abstract](/knowledge/SWE/agentic/failure-modes/sources/liu-2023-lost-in-the-middle.md),
  <https://arxiv.org/abs/2307.03172>
- Xiao et al. (2023), "Efficient Streaming Language Models with Attention
  Sinks": <https://arxiv.org/abs/2309.17453>
- Anthropic engineering (2025), "Effective context engineering for AI
  agents": <https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>
- Chen et al. (2024), "Premise Order Matters in Reasoning with Large
  Language Models": <https://arxiv.org/abs/2402.08939>
