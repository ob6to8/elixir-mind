---
id: em:9cec7a
type: concept
title: spec-driven development
description: An AI-assisted coding workflow family that starts from a structured written specification and derives the plan, task breakdown, and implementation from it — the spec, rather than the conversation, is the driving artifact.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, agentic, specs, methodology, workflow]
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T21:10:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 complete-spec-vs-iterative-delivery thread's industry evidence pass"
---

# spec-driven development

The 2025 productizations mark out the pattern's range: GitHub's Spec Kit
stages it as constitution → specify → plan → tasks → implement, AWS Kiro
holds a feature's spec as three files (requirements in
[EARS notation](/beliefs/glossary/ears-notation.md), design, tasks), and
Tessl's stronger form maintains the specification itself as the durable
artifact with code downstream of it. Thoughtworks' Radar placed the technique
at Assess (Nov 2025), warning against a relapse into heavy up-front
specification, while its practitioners argue the written spec *shortens*
feedback loops relative to steering an agent conversationally. How the
pattern reads against this brain — which factors the same content into a
compiled contract, decision-granularity plans, and matter packets — is
worked through in
[the complete-spec-prompting analysis](/meta/analysis/complete-spec-prompting-vs-iterative-delivery.md).

*Seen in:* [2026-08-02 complete-spec vs. iterative delivery thread](/meta/threads/2026-08-02-complete-spec-prompting-vs-iterative-delivery.md),
[complete-spec-prompting-vs-iterative-delivery](/meta/analysis/complete-spec-prompting-vs-iterative-delivery.md);
https://github.com/github/spec-kit; https://kiro.dev/docs/specs/feature-specs/;
https://www.thoughtworks.com/radar/techniques/spec-driven-development
