---
id: em:a924c4
type: concept
title: prompt sensitivity
description: The degree to which a model's output changes under rewordings of a request that leave the task, the input, and the correct answer unchanged — measured as drift in the concrete answer returned, not only as movement in the score.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evaluation, prompting, robustness, metrics]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# prompt sensitivity

Aggregate accuracy hides it almost perfectly: two phrasings can score identically while disagreeing on most individual instances, since the errors merely moved. Measuring it therefore requires comparing answers *per instance* against a reference phrasing — how often the decision flips, how far the predicted set moves, how often the predicted label changes — rather than comparing summary statistics.

What makes it more than an evaluation artifact is that it bounds how much a downstream system can rely on any single measured number: a benchmark result obtained under one phrasing predicts production behavior only to the extent that production phrasing resembles it. High sensitivity in a domain whose practitioners have their own register — where the natural professional wording *is* the unusual wording — means the benchmark and the deployment are quietly running different experiments.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>

*See also:* [Goodhart's law](/beliefs/glossary/goodharts-law.md), [held-out set](/beliefs/glossary/held-out-set.md)
