---
type: matter
title: "Disambiguate `order` from `sequence` in /scope-unit-of-work"
description: The skill uses "sequenced matters" for a plan's internal build order and `sequence` for the operator's ratification to queue into the register, so one word carries two meanings and a fresh agent can read emitting ordered matters as licence to queue them.
status: open
priority: 3
model: Claude Sonnet 5
provenance: "Claude Opus 5, scope-unit-of-work form-evaluation session"
tags: [meta, matter, skills, scoping, matters, terminology]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work form-evaluation session"
  why: "the fix was drafted during the layout A/B and deliberately withheld from the treatment so it could not contaminate the comparison, leaving it decided but unapplied"
  from: [/meta/threads/2026-08-02-skill-body-layout-ab-and-section-vocabulary.md]
---

# Disambiguate `order` from `sequence` in `/scope-unit-of-work`

[The skill](/.claude/skills/scope-unit-of-work/SKILL.md) uses one word for two
things:

- **plan-internal build order** — "a plan whose build order emits **sequenced**
  matters", set at filing whether or not the unit is ever queued, carried in
  each matter's `order` frontmatter;
- **register commitment** — the `sequence` argument, the operator's ratification
  to append rows to [the register](/meta/matters.md).

A fresh agent reading "emits sequenced matters" as a deliverable can take
emitting them as licence to queue them, which the skill elsewhere forbids —
`sequence` is the only thing that authorizes a register row.

**The fix, already decided:** reserve *sequence* and *queue* for the register,
and say **ordered** for the plan-internal relation ("a plan whose build order
emits **ordered** matters, each carrying `plan` and `order`"). Add one short
paragraph under Dispatch stating the two senses explicitly. The frontmatter key
is already `order`, so the prose simply stops fighting it.

**Scope boundary:** this is a wording change to the skill body and must **not**
ride
[the heading migration](/meta/matters/migrate-skills-onto-section-vocabulary.md),
which is a mechanical sweep whose reviewability depends on containing no content
edits. Deliver it separately, before or after, in its own PR.

**Why it is filed rather than done.** The fix was drafted during the
[skill body layout A/B](/meta/evals/skill-body-layout-ab.md) and withheld from
the treatment on purpose: variant B had to hold variant A's rule-set exactly, so
an improvement present in one arm would have measured content rather than
layout.

## Model

`Claude Sonnet 5` — a governance-prose edit to a skill body with the wording
already chosen, which is the roster's governance-prose row. No decision is left
open; the failure mode is visible on sight.
