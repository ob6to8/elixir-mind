---
id: em:ff4d55
type: concept
title: hallucination
description: A model output asserted fluently and confidently but ungrounded in the model's inputs or in fact.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, llm, model-evaluation, reliability]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the reliability caveat in the Kimi K3 intake turns on how the rate is measured"
---

# hallucination

The measurement convention matters more than the word does. Rates are typically
reported over a model's *non-correct* responses — what fraction of the answers it
got wrong were confidently asserted rather than declined — so accuracy and
hallucination rate can rise together, as they did between Kimi K2.6 (33% accurate,
39% hallucinating) and K3 (46% accurate, 51% hallucinating). A model can become
both more capable and less trustworthy in the same release, and a single
capability score will not show it.

The mechanism behind that drift is an incentive one: benchmarks graded as
correct-or-not score "I don't know" identically to a wrong answer, so confident
guessing is the score-maximizing strategy. Distinct from
[ungrounded inference](/beliefs/glossary/ungrounded-inference.md), which names the
structural defect of a conclusion lacking supporting evidence rather than the
behavior of asserting one.

*Seen in:* [Kimi K3](/knowledge/machine-learning/kimi-k3.md), [Split retrieval and generation evaluation for RAG](/knowledge/SWE/evals/split-retrieval-and-generation-evaluation-for-rag.md) ([groundedness](/beliefs/glossary/groundedness.md) checks catching it without ground truth)

*See also:* [ungrounded inference](/beliefs/glossary/ungrounded-inference.md), [Artificial Analysis Intelligence Index](/beliefs/glossary/artificial-analysis-intelligence-index.md)
