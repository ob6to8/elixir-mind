---
id: em:b6cee0
type: concept
title: changelist review
description: Review of a proposed change by a party that did not author it — the judgment-level check on substance that deterministic gates, which can only check form, structurally cannot provide.
provenance: "Agent-distilled glossary definition, from the Google-practice vocabulary weighed in the version-control audit"
verified: false
tags: [glossary, code-review, gates, workflow, quality]
sense: common
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the practice whose absence the version-control audit identified as this repo's main verification gap"
---

# changelist review

The load-bearing property is **independence**: the reviewer has no stake in the
change, so it catches what the author's own assumptions hide. That is precisely the
class automated gates miss — a gate can confirm a document parses and matches its
re-derivation, but not that its claim is true or that it silently contradicts an
existing document. In an agent-operated repo the reviewer need not be human: an
independent model reading the diff in a *fresh* context serves the same role, so
long as it is not the authoring session grading its own work. Designs for adopting
one here are in the
[gate-suite hardening plan](/meta/plans/gate-suite-hardening-review-depth.md).

*Seen in:* [2026-07-26 version-control-audit thread](/meta/threads/2026-07-26-version-control-audit-and-response-format-policies.md)
