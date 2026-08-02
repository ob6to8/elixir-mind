---
type: matter
title: "Backfill model stamps on the open matter docs"
description: Stamp `model:` and a `## Model` determination section onto the 30 open matter docs that predate the stamp, so the delivering-model recommendation is present everywhere /matter list and the register's Model column read it.
status: open
model: Claude Sonnet 5
plan: /meta/plans/model-column-in-the-matter-register.md
order: 1
provenance: "Claude Opus 5, scope-unit-of-work session"
tags: [meta, matter, matters, models, backfill]
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work skill session"
  why: "order 1 of the register Model column plan — the column lands populated only if the docs are stamped first, and the stamps are independently useful to /matter list the day they land"
timestamp: 2026-08-02
---

# Backfill model stamps on the open matter docs

All 30 `status: open` matter docs under [`meta/matters/`](/meta/matters/index.md)
predate the `model:` stamp (measured 2026-08-02: 37 docs, 30 open, 11 of those
queued, 0 stamped). [`/matter list`](/.claude/skills/matter/SKILL.md) already
joins `model:` from the docs at render time, so every stamp is visible the
moment it lands — this matter needs no tooling change and gates nothing.

**Deliver:** for each open matter doc, `model:` in frontmatter and a `## Model`
section at the end of the body carrying the determination in one or two
sentences.

- **The value comes from [the roster](/meta/model-roster.md)**, in its display
  form (`Claude Fable 5`, `Claude Opus 5`, `Claude Sonnet 5`,
  `Claude Haiku 4.5`) — the same form the commit trailer uses, so the two
  records join on one string.
- **The determination is the roster's four questions** applied to the *hardest*
  motion the matter's delivery contains: canonical output · judgment with no
  oracle · oracle-checked execution · derivational or bulk.
- **`model: undetermined` is a legitimate outcome**, stated with its reason
  under `## Model`. A matter whose packet leaves the approach open often cannot
  be tiered until the approval gate settles it; guessing is the failure mode,
  not abstaining.
- **`model:` is prospective and advisory** — the recommendation for whoever
  delivers. Do not touch `provenance`, which retrospectively names the model
  that wrote each doc
  ([model-attribution](/meta/policy/model-attribution.md)).

**Blocker — one decision the packet leaves open:** whether the 7 `status: done`
docs are stamped too. The recommendation is **no** (a prospective stamp on
already-delivered work is retro-fiction, and no done matter carries a register
row); take the operator's ruling at the approval gate and proceed either way in
the same delivery.

**Verify:** `mix brain.verify` and `mix brain.matters` stay green — `model` is
an extra frontmatter key today, checked by nothing, so this delivery is
mechanically invisible and rests on the per-doc judgments themselves.

## Model

`Claude Sonnet 5` — well-specified execution against a decided rubric: the
roster's four questions and the display-form vocabulary leave no approach open,
30 near-identical edits follow, and every stamp is advisory and cheap to
revise. The one real judgment in the matter — whether done docs are in scope —
is settled by the operator at the approval gate before any editing starts.
