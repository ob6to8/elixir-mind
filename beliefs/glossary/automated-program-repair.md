---
id: em:fb77a7
type: concept
title: automated program repair (APR)
description: Generating source-code fixes for defects without a human writing the patch, validated by executing the project's tests rather than by inspecting the diff.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, program-repair, security, evaluation, automation]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# automated program repair (APR)

Predates language models — search-based and template-based repair systems date to the early 2010s — but the execution-grounded evaluation discipline the field developed is what makes it a useful measuring instrument now. A candidate patch must apply, build, and pass tests; each of those is a mechanical check, so the field never had the option of scoring plausibility.

Its central known hazard is *overfitting to the test suite*: a patch that satisfies every available test while being wrong in general. Vulnerability repair adds a second oracle against this — the [proof-of-vulnerability](/beliefs/glossary/proof-of-vulnerability.md) must flip and the rest of the suite must stay green, so a patch cannot pass by disabling the vulnerable feature outright.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>
