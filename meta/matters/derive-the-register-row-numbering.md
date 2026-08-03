---
type: matter
title: "Derive the register's row numbering"
description: The queue's `#` cells are authored data that renumber on every delivery, so any two concurrent deliveries conflict on meta/matters.md by construction; make the serial derived — recommend dropping the column — so wave-based concurrent delivery stops colliding on the register.
status: open
model: Claude Opus 5
provenance: "Claude Fable 5, matter-list audit session"
tags: [meta, matter, matters, register, tooling, concurrency]
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T05:10:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-list audit session"
  why: "the audit's concurrency grouping found the register's authored row serials collide on every concurrent delivery pair; the operator ratified filing the structural fix as the wave program's prerequisite"
  from: [/meta/threads/2026-08-03-matter-list-audit-and-wave-delivery-methodology.md]
---

# Derive the register's row numbering

Every delivery drops a row from [the register](/meta/matters.md) and renumbers
the `#` column (observed in history: the roster-separation matters entered as
rows 14–16 and sat at rows 4–6 within a day). Two concurrent deliveries
therefore conflict on `meta/matters.md` even when their content is disjoint —
the serialized-queue conflict class in
[wave-based concurrent delivery](/knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md),
and the one collision no lane partition can design away. This matter is its
structural fix: row serials stop being authored data.

**Deliver — recommend dropping the `#` column.** Position in the table *is*
the ordinal; consumers count. `parse_row/1` in `lib/elixir_mind/matters.ex`
moves to a three-cell head clause deriving `pos` from row index,
`row_shape_errors/1`'s guard follows, the register's prose and
[`/matter`](/.claude/skills/matter/SKILL.md) stop citing row numbers, and
packets cite matters by name — the 2026-08-03 audit found three packets
carrying stale positional cites ("queued row 6", "row 12", "all 11 rows"),
which go stale on every renumber under either shape. Alternative at the
approval gate: keep the column and add a `#`-equals-position `:fail` check
plus a renumbering writer — costs a writer task and keeps a cosmetic serial
that still conflicts textually on concurrent drops.

**Interaction.** [Register Model column](/meta/matters/register-model-column-and-agreement-check.md)
(queued behind this) widens the row by a Model cell and counts cells against
the four-cell shape; whichever lands second refreshes its cell arithmetic —
the plan-refresh rule covers it, flag it at that delivery.

**The hazard** (the class the Model-column packet names): a cell-count change
without its parser clause sends every row to `parse_row/1`'s catch-all with
`pos: nil`, `queue_positions/1` drops them, and `mix brain.session_init`
silently reports the whole queue as backlog. Land the parser clause and the
register rewrite in one commit, update the moduledoc's numbered rules, and
read back `mix brain.session_init` showing every queued matter annotated.

**Verify:** `mix brain.matters`, `mix test --warnings-as-errors`,
`mix brain.codemap --check` after the moduledoc edit, and the session-init
read-back.

## Model

`Claude Opus 5` — a `lib/` shape change whose failure mode is silent queue-view
degradation: tests catch a wrong cell count, but nothing downstream catches the
digest degrading to "everything is backlog", so the model is the last line of
defense on the seam no oracle covers. The drop-vs-verify ruling is the
operator's at the gate; the delivery's hardest motion is the parser/digest
seam. Same determination as the Model-column matter, which changes the same
parser.
