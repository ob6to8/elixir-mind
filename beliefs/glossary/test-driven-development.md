---
id: em:eb851b
type: concept
title: test-driven-development
description: The software methodology of writing a failing test before the code that satisfies it — red (watch it fail), green (implement minimally to pass), refactor — so executable examples specify the behavior before an implementation exists.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, testing, methodology, tdd, agentic]
sense: common
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T23:20:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary over the TDD research-spike thread"
  why: "the spike's central term, used throughout the ranking analysis, methodology doc, and adopted governance"
---

# test-driven-development

Kent Beck's discipline from Extreme Programming, usually abbreviated **TDD**.
Confirming the test fails *before* implementing is load-bearing — a test never
seen red may be vacuous and prove nothing.

**In this brain:** the 2026-08 research spike ranked TDD first among
methodology choices for coding-agent development *in a restated form* — the
tests-as-contract loop, valued for control (regression tripwire, scope-drift
counter, spec-by-example) rather than classic design pressure, and conditional
on protecting the tests from the agent that satisfies them. See
[where TDD ranks for coding-agent development](/meta/analysis/tdd-rank-for-coding-agent-development.md)
for the evidence and the
[agent development methodology](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md)
(`em:cab2c5`) for the prescription; the delivery half is enforced here by
[atomic pull requests](/meta/policy/git-atomic-pull-requests.md) under the
[verified-increments doctrine](/meta/doctrine/verified-increments.md).

*Seen in:* [the TDD research-spike thread](/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md), [Gorman's argument](/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md), [Dzombak's playbook](/knowledge/SWE/agentic/code-quality/getting-good-results-from-claude-code.md)
