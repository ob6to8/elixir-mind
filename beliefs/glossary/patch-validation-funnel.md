---
id: em:83c71b
type: concept
title: patch-validation funnel
description: An evaluation shape that scores a generated patch through ordered executable gates — parseable, applies, compiles, blocks the vulnerability, passes full validation — so that where a candidate dies is reported rather than collapsed into one pass/fail number.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evaluation, program-repair, metrics, security]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# patch-validation funnel

Each gate is strictly harder than the last, so the per-gate pass rates form a monotonically shrinking series and the *shape* of the decline is the finding. Two systems with identical final success rates can differ completely in profile — one failing at extraction because it never emits a usable diff, another applying and compiling everywhere but never blocking the trigger — and only staged reporting distinguishes them.

It is the [coverage-times-quality](/beliefs/coverage-and-quality-must-be-measured-jointly.md) decomposition extended past two factors, and it makes the late gates statistically fragile in exchange: by the final stage the surviving counts are often single-digit, so a funnel's robust claims live in its early stages and its final gate is best read as directional.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>
