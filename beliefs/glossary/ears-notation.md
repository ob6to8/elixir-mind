---
id: em:0ec567
type: concept
title: EARS notation
description: EARS (Easy Approach to Requirements Syntax) — a constrained-natural-language convention that fits each requirement into a small set of sentence templates (e.g. "WHEN <condition> THE SYSTEM SHALL <behavior>"), keeping requirements structured and testable.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, requirements, specs, testing, methodology]
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T21:10:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 complete-spec-vs-iterative-delivery thread's industry evidence pass"
---

# EARS notation

The constraint is the point: forcing a requirement into one of a handful of
template shapes (ubiquitous, event-driven `WHEN`, state-driven `WHILE`,
optional-feature `WHERE`, unwanted-behaviour `IF … THEN`) makes the trigger
condition and the observable system response explicit — exactly the two
things an acceptance test needs. AWS Kiro adopted it for the
`requirements.md` file of its feature specs, which is how the notation
entered the [spec-driven development](/beliefs/glossary/spec-driven-development.md)
toolchains.

*Seen in:* [2026-08-02 complete-spec vs. iterative delivery thread](/meta/threads/2026-08-02-complete-spec-prompting-vs-iterative-delivery.md),
[complete-spec-prompting-vs-iterative-delivery](/meta/analysis/complete-spec-prompting-vs-iterative-delivery.md);
https://kiro.dev/docs/specs/feature-specs/
