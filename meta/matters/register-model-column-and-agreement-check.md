---
type: matter
title: "Register Model column and its agreement check"
description: Widen ElixirMind.Matters from a four-cell to a five-cell queue row — parser clause, shape rule, and a Model↔`model:` agreement error — then add the Model column to the register itself, keeping mix brain.session_init's queue annotation intact through the migration.
status: open
model: Claude Opus 5
plan: /meta/plans/model-column-in-the-matter-register.md
order: 2
provenance: "Claude Opus 5, scope-unit-of-work session"
tags: [meta, matter, matters, register, models, tooling, verifier]
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work skill session"
  why: "order 2 of the register Model column plan — the mechanism half, landing after the backfill so the column ships populated"
timestamp: 2026-08-02
---

# Register Model column and its agreement check

Make [the register](/meta/matters.md)'s queue table carry each matter's
delivering model as a fifth cell, projected from the doc's `model:` and
verified against it. The design, alternatives, and the full current→desired
shape are in
[the plan](/meta/plans/model-column-in-the-matter-register.md) — read it first;
this packet carries the delivery contract.

**Deliver in one commit** (the code change and the register rewrite are not
separable — see the hazard below):

1. **`lib/elixir_mind/matters.ex`** — a five-element `parse_row/1` head clause
   with the Model cell parsed to `:none | {:ok, name}`; `row_shape_errors/1`'s
   guard moved to `!= 5` plus a Model-cell wellformedness error; `model` added
   to `scan_docs/3`'s frontmatter map; a Model↔`model:` case in
   `agreement_errors/2` (`-` ⇔ absent, else exact match, `:fail` severity like
   Type and Order); moduledoc rules 1 and 3 updated in the same edit.
2. **`meta/matters.md`** — the Model column added to the header, the separator,
   and all 11 rows, plus the prose above the table that describes the cells.
3. **`test/elixir_mind/matters_test.exs`** — every register fixture moves to
   five cells; new cases for wrong cell count, Model divergence, and `-` ⇔
   absent.
4. **`mix brain.codemap`** — regenerate `meta/code-map.md` after the moduledoc
   edit (the freshness gate catches the miss).
5. **Skill text** — [`/matter`](/.claude/skills/matter/SKILL.md)'s List section
   and [`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md) §5.3
   both state the four-cell rule today; both become five. Recompile the contract
   if any policy text names the count.

**The hazard that shapes the delivery.** A fifth cell without the parser clause
does not merely fail loudly — every row falls to `parse_row/1`'s catch-all with
`pos: nil`, `queue_positions/1` drops nil-positioned rows, and
`ElixirMind.SessionInit` then reports every queued matter as backlog in the
session-start digest, with no error anywhere. Land the parser clause and the
register edit together, and cover the digest path: `mix brain.session_init`
must still annotate all 11 queued matters with their row positions after the
migration.

**Decisions already made** (from the plan's decision list): the cell is a
projection, never the authored datum; divergence fails rather than warns;
four-cell rows are not tolerated after the migration. **Open at the gate:** the
absent marker — recommend `-`, matching the Order cell and keeping the parser
on ASCII.

**Verify:** `mix brain.matters`, `mix brain.verify`, `mix brain.codemap
--check`, `mix format --check-formatted`, `mix test --warnings-as-errors`, and
a `mix brain.session_init` read-back showing the queue annotations intact.

## Model

`Claude Opus 5` — a `lib/` shape change whose failure mode is silent: the
tests and gates catch a wrong cell count, but nothing catches the digest
degrading to "everything is backlog", so the model is the last line of defense
on exactly the part no oracle covers. Judgment, not derivation.
