---
id: em:f0582b
type: concept
title: model roster
description: The enumerated set of models this repo may spend and the motion each is sent — the run-time binding table that capability-matched-model-selection deliberately declines to hardcode, read when a matter is stamped with the model that should deliver it.
provenance: "Claude Opus 5, agent-distilled glossary definition"
verified: false
tags: [glossary, models, delegation, orchestration, matters, configuration]
sense: repo
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary over the scope-unit-of-work thread"
  why: "coined in the session that built /scope-unit-of-work, and immediately load-bearing — the contract, two skills, and an accepted plan reference it"
---

# model roster

The **instance layer** beneath
[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md).
That doctrine binds no model names on purpose — *"the mapping goes stale with
every model generation, while the principle … survives them all"* — and directs
an agent to *"[apply] the direction against whatever tiers exist at run time"*.
The roster is what "exist at run time" resolves to: each model available to this
repo, the string used as a matter's `model:` value, and a one-line disposition
of what it is and is not sent.

It is **authored, not derived** — operator preference data, edited as model
generations turn over, and read rather than computed. Distinct from
[effort level](/beliefs/glossary/effort-level.md), the orthogonal second lever:
the roster picks *which* reasoner, effort sets *how hard* it thinks, so a hard
but well-specified [matter](/beliefs/glossary/matter.md) is often a lower tier
at high effort rather than a higher tier.

Its home is a settled question with an unsettled implementation: the
[roster-separation plan](/meta/plans/separate-the-model-roster-concerns.md)
(accepted) moves the enumeration into Elixir application config with a single
reader module and a contract token compiled from it — the
[`site_base_url`](/meta/policy/response-resource-links.md) pattern — because a
controlled vocabulary held only in prose can never be checked, and retires the
standalone document. Until that lands the roster is a markdown table no code
reads, which is exactly the defect the plan names.

*Seen in:* [the scope-unit-of-work thread](/meta/threads/2026-08-02-scope-unit-of-work-skill-and-model-stamping.md), [scope-unit-of-work](/.claude/skills/scope-unit-of-work/SKILL.md), [separate-the-model-roster-concerns](/meta/plans/separate-the-model-roster-concerns.md)
