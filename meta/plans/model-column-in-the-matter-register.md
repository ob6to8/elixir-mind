---
type: plan
title: "The Model column in the matter register"
description: Enable the register's queue table to carry each matter's delivering model as a fifth projected cell — widening ElixirMind.Matters from a four-cell row shape to five with a Model↔model agreement check — preceded by the backfill that gives the column something to show.
status: accepted
provenance: "Claude Opus 5, scope-unit-of-work session"
tags: [meta, plan, matters, register, models, tooling, verifier]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work skill session"
  why: "operator scoped the register Model column as a unit of work after the /scope-unit-of-work build reported the four-cell constraint as a blocker"
  from: [/meta/threads/2026-08-02-scope-unit-of-work-skill-and-model-stamping.md]
---

# The Model column in the matter register

## Problem

Matter docs now carry `model:` — the roster's recommendation for the model that
should *deliver* the matter ([model roster](/meta/model-roster.md),
[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md)).
[The register](/meta/matters.md) does not show it. The queue is the surface the
operator reads to decide what goes out next, and *which model should deliver
this* is decision-relevant at exactly that moment; today it is visible only by
opening each doc, or by asking `/matter list` to join it at render time.

The register cannot simply grow a column: `ElixirMind.Matters` hard-codes a
four-cell row shape, and the failure is not confined to the loud one. Two
distinct things break on a fifth cell:

- `row_shape_errors/1` fails the row outright (`"5 cell(s), expected 4"`) — the
  visible half, and the safe one.
- `parse_row/1`'s four-element head clause stops matching, so every row falls to
  the catch-all with `pos: nil`. `queue_positions/1` drops nil-positioned rows,
  and `ElixirMind.SessionInit` consumes exactly that map to annotate queued
  matters in the session-start digest. A register edited without the parser
  change would leave the digest silently listing every queued matter as
  backlog — no error, no warning, just a quietly wrong digest. **The parser
  clause is the load-bearing change; the shape rule is only its guard.**

The column also needs data. All 30 open matter docs predate the `model:` stamp,
so the column would land showing `-` in all 11 queued rows.

## Current state → desired state

Row parsing (`lib/elixir_mind/matters.ex`):

```diff
  register_rows/1                    # read meta/matters.md, keep "|" lines
  └── split_cells/1                  # → trimmed cell list
      └── header_or_separator?/1     # drop header + separator rows
          └── parse_row/1
-             ([pos, matter, type, order])           # 4-cell head clause
+             ([pos, matter, type, order, model])    # 5-cell head clause
+                 model: parse_model(model)          # :none | {:ok, binary}
              (cells)                                # catch-all → cell_count, nils
```

Checks:

```diff
  run_checks/1
  ├── check_register_shape/1
  │   └── row_shape_errors/1
- │         when cell_count != 4 → "N cell(s), expected 4"
+ │         when cell_count != 5 → "N cell(s), expected 5"
+ │         Model cell must be `-` or a non-empty single-line name
  ├── check_refs_and_doc_shape/2 …   # unchanged
  ├── check_agreement/2
  │   └── agreement_errors/2
  │         status · Type↔plan · Order↔order
+ │         Model↔`model:` — `-` ⇔ absent, else exact string match
  ├── check_inversion/2 …            # unchanged
  └── check_landing/1 …              # unchanged
```

Doc scan (`scan_docs/3`, `lib/elixir_mind/matters.ex:188`):

```diff
  %{path:, parsed:, type:, status:, plan:, order:, pr:}
+ %{…, model: fm["model"]}
```

## File-tree diff

```
lib/elixir_mind/matters.ex                  # MODIFIED — 5-cell clause, shape rule,
                                            #   model in scan_docs, Model agreement,
                                            #   numbered moduledoc rules 1 and 3
meta/matters.md                             # MODIFIED — Model column + its 11 rows,
                                            #   and the header prose describing the cells
meta/code-map.md                            # MODIFIED — regenerated (mix brain.codemap)
test/elixir_mind/matters_test.exs           # MODIFIED — fixtures to 5 cells; new cases:
                                            #   wrong cell count, Model divergence, `-` ⇔ absent
.claude/skills/matter/SKILL.md              # MODIFIED — List reads the register cell
.claude/skills/scope-unit-of-work/SKILL.md  # MODIFIED — §5.3's four-cell rule becomes five
meta/policy/*.md + CLAUDE.md                # MODIFIED — only if policy text names the cell count
```

## Signatures

The touched functions are private; these are the clause heads that change.

```elixir
defp parse_row([pos, matter, type, order, model] = cells)
defp row_shape_errors(%{cell_count: n, raw: raw}) when n != 5
defp parse_model(cell :: String.t()) :: :none | {:ok, String.t()} | :malformed
```

`run_checks/1` keeps its `[result]` return and its five named checks — the
Model rule is a new error source inside two existing checks, never a sixth
check. A reader counting check names should see no change.

## Boundary decisions

- **The doc authors `model:`; the register projects it.** The register's one
  authored datum stays the global delivery order; the Model cell joins Type and
  Order as a projection whose divergence is a verifier error. Nothing is ever
  read *from* the register cell as truth.
- **`ElixirMind.Matters` owns parsing and agreement; the skills render.**
  `/matter list` continues to render the queue; whether it reads the cell or
  re-joins from the docs is its own call, and either is now consistent because
  the checker forbids divergence.
- **`queue_positions/1` must survive the widening.** It is `SessionInit`'s only
  register read; its tolerance for malformed rows is what turns a half-migration
  into silence rather than an error, so the parser clause and the register edit
  land in one commit.

## The sequence

| Order | Matter | Intent |
|---|---|---|
| 1 | [backfill model stamps on matter docs](/meta/matters/backfill-model-stamps-on-matter-docs.md) | Stamp `model:` + a `## Model` section on the 30 open matter docs, so the column has data |
| 2 | [register Model column and agreement check](/meta/matters/register-model-column-and-agreement-check.md) | Widen the row shape to five cells with a Model↔`model:` agreement check; add the column to the register |

**Sequencing rationale.** The backfill runs first for two reasons. It is
independently useful the day it lands — `/matter list` already joins `model:`
from the docs, so the stamps show up with no tooling change at all. And it
means the column lands populated: a Model column shipped over unstamped docs
renders `-` in all 11 rows, which reviews as a feature that does nothing and
leaves the agreement check with nothing to check. Reversing the order costs a
second pass over the register.

The two matters are separately approvable in both directions — the operator can
take the stamps and decline the column (keeping the render-time join), or take
the column over a partial backfill. Neither breaks the other's green.

## Decision list

**Recommended shape**: a fifth projected cell, agreement-checked at `:fail`
severity like Type and Order, backfill first.

**Alternatives rejected:**

- **Render-time join only** (the status quo): `/matter list` shows the model,
  the register file does not. Rejected because the register is the artifact
  read directly — in a diff, on the site, in a fresh session's first minute —
  and a column visible only through a skill invocation is not visible where the
  sequencing decision is actually made.
- **Authoring `model:` in the register instead of the docs.** Rejected: it
  splits the datum from the handoff packet, so a matter consumed from its doc
  alone would not carry its own model recommendation.
- **Tolerating four *or* five cells.** Rejected: leniency buys nothing when the
  parser change and the register rewrite land in the same commit, and it would
  let a half-migrated register pass green — the exact silent-digest failure this
  plan exists to avoid.
- **Warn instead of fail on Model divergence.** Rejected: advisory *data* does
  not imply an advisory *projection*. A cell that disagrees with its doc is a
  correctness defect regardless of how soft the datum is, and Type/Order set the
  precedent.

**Open questions:**

1. **Absent marker in the register — `-` or `—`?** Recommend `-`, matching the
   Order cell's existing convention and keeping the parser on ASCII; `/matter
   list` may still render an em dash in its own output.
2. **Does the backfill cover the 7 `done` docs?** Recommend no — `model:` is
   prospective, and stamping a recommendation onto already-delivered work is
   retro-fiction. Held in matter 1's packet; deciding it does not gate matter 2,
   since no done matter has a register row.
3. **Should `model:` presence become a warn-level check?** Deliberately out of
   scope here. A stamp-presence warning is a separate admission decision under
   the [coding standards](/meta/policy/elixir-coding-standards.md); this plan
   only makes divergence checkable.

## Anchors

Current as of `HEAD`, 2026-08-02 — re-derive before executing, per
[structured-plan-bodies](/meta/policy/structured-plan-bodies.md):

- `lib/elixir_mind/matters.ex:116` — `parse_row/1`, four-element head clause.
- `lib/elixir_mind/matters.ex:127` — `parse_row/1` catch-all (the silent path).
- `lib/elixir_mind/matters.ex:188` — `scan_docs/3`, the frontmatter map to widen.
- `lib/elixir_mind/matters.ex:244` — `row_shape_errors/1`, the `!= 4` guard.
- `lib/elixir_mind/matters.ex:348` — `agreement_errors/2`, Type and Order pattern
  matches to mirror for Model.
- `lib/elixir_mind/matters.ex:76` — `queue_positions/1`, and its consumer
  `ElixirMind.SessionInit`.
- `test/elixir_mind/matters_test.exs` — every register fixture is four-cell today.
- Reusable: `ElixirMind.Frontmatter.parse/1` already surfaces arbitrary keys, so
  `model` needs no parser work.
