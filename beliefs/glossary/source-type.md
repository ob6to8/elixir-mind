---
id: em:c78837
type: concept
title: source (type)
description: Controlled type for a primary-source citation held as evidence — verbatim passages extracted from an authoritative artifact, carrying its `resource` URI, and pointed at by a statement's `verified_by`.
provenance: "Agent-distilled glossary definition, pointer to the defining policy"
verified: false
sense: repo
tags: [glossary, types, vocabulary, verification, evidence]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the grounding pass on em:51aede created the bundle's first real instances of the type"
---

# source (type)

Defined by
[verification-grounding](/meta/policy/verification-grounding.md), which fixes the
asymmetry that makes the type work: a source capture is **trusted evidence, not a
verified statement**, so it never carries
[`verified`](/beliefs/glossary/verification-grounding.md) itself. Verification
flows *from* captures *to* the statement that aggregates them via
[`verified_by`](/beliefs/glossary/verified-by.md) — the capture stores the link
and the text, the claim carries the assertion.

Because a capture holds a `resource`, it is one of the documents the verifier
refuses to mark verified at all; storing a link proves nothing about the
statement built on it. The practical discipline is that writing captures happens
*after* the argument exists, and routinely corrects it: re-reading a source for
quotable text is what catches a figure asserted beyond what the source states.

*Seen in:* [open weights stopped being a price weapon](/knowledge/ai-industry/open-weights-stopped-being-a-price-weapon.md), [the ai-industry source captures](/knowledge/ai-industry/sources/index.md)

*See also:* [verified_by](/beliefs/glossary/verified-by.md), [statement type](/beliefs/glossary/statement-type.md)
