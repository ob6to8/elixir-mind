---
name: matter
description: Work the matter register — bare /matter consumes the top queued matter under the approval-gated protocol (print the record, propose, wait for approval, deliver, flip the doc done and log it); /matter list renders the queue and backlog; /matter create files a matter doc. Use when the operator says "/matter", "take the top matter", "consume the next matter", "what's queued", "list the matters", or "file a matter".
---

# /matter — consume, list, and file matters

Work the [matter register](/meta/matters.md) and the matter docs under
[`meta/matters/`](/meta/matters/index.md), per the
[matter-docs plan](/meta/plans/matter-docs-architecture.md). A
[matter](/beliefs/glossary/matter.md) is the review-quantized delivery unit —
one coherent intent, one PR
([atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md)). Matter docs
live in the **governance namespace**: no `em:` ids, standard governance
`attribution`. Follow the [operating contract](/CLAUDE.md).

The register's one authored datum is the **global delivery order**; everything
else is a view over the docs. An open matter with a register row is **queued**;
an open matter without one is **backlog**. `status` never encodes queued-ness.

## Dispatch

The first argument selects the operation. With no argument, **consume** the top
queued matter (the common case).

- `/matter` (or `/matter consume`) → **Consume** (below).
- `/matter list [queue|backlog|done|all]` → **List** (below). Default: queue + backlog.
- `/matter create <title / packet>` → **Create** (below).

## Consume

Deliver the top queued matter under the approval-gated protocol. The register
is consumed top-down, each matter in a fresh thread with its doc (plus the refs
it carries) as the entire handoff.

1. **Take the top row.** Read [the register](/meta/matters.md)'s queue table
   and open the top row's matter doc plus the refs it names. **Blocker-skip
   rule:** a matter whose doc records an unmet blocker is skipped — leave its
   row in place, note the skip, and take the next row instead. If the queue is
   empty, say so and point at the backlog (`/matter list`).
2. **Print the record.** Before any work, re-print the row in the thread as
   labeled fields — **Matter / Type / Order** — plus the doc's packet body
   **verbatim**. The row and its position leave the register at consumption;
   the reprint carries the consumed state into the session record.
3. **Propose, then stop.** State the delivery approach — shape, files, riders —
   and put any open decisions the packet leaves as blocking questions with
   recommendations, per
   [response-work-report-format](/meta/policy/response-work-report-format.md).
   Ask **in chat text, never a UI dialog element**
   ([session-capture](/meta/policy/session-capture.md)). **Wait for the
   operator's approval before executing anything.**
4. **Deliver** after approval, as approved. A mid-delivery revision that could
   change the operator's decision — scope, cost, shape — halts as a new
   blocking question; it is never absorbed silently.
5. **Bookkeeping, in the delivery motion** (same edit batch as the delivery,
   so the move ships with the matter's PR):
   - flip the matter doc `status: done` and bump its `timestamp`;
   - drop the row from the queue table and renumber the remaining rows;
   - move the doc's entry in
     [`meta/matters/index.md`](/meta/matters/index.md) from Open to Done,
     updating its gloss to the delivered fact.
6. **Close — deferred to PR time, binding this session.** When
   [`/create-pull-request`](/.claude/skills/create-pull-request/SKILL.md)
   opens the session's PR, stamp `pr: <N>` into the done doc's frontmatter,
   committed into the same PR. The done docs are the delivery history;
   `mix brain.matters` warns on a done doc still awaiting its stamp.

## List

Read-only render of open work: the queue, then the backlog beneath it.

1. **Read** the register's queue table, and every `meta/matters/*.md` (skip
   `index.md`), parsing `title`, `description`, `status`, `model`,
   `plan`/`order`, `priority` (if any), and `timestamp`.
2. **Filter** by the argument. Default (**queue + backlog**): the queue rows in
   register order, then the backlog (open docs with no register row). `done`
   and `all` add delivered/cancelled matters; `queue`/`backlog` slice to one
   section.
3. **Render** compactly — the queue as **# · matter · Type · Order · Model**,
   the backlog beneath as title + one-line gloss, sorted by integer
   `priority:` where present (1 = most urgent), unprioritized after,
   alphabetical within. Note the counts. This changes no files.

**The Model column is read from the docs, not the register.** Each matter's
`model:` frontmatter — the roster's recommendation for the delivering session
([model roster](/meta/model-roster.md)) — is joined onto the row at render
time; a doc with no stamp renders `—`. The register's rows stay exactly four
cells, which `mix brain.matters` enforces, so the model is never stored there.

For the cross-surface appraisal ranking matters against issues, plans, and
dangling strands, use
[`/priorities`](/.claude/skills/priorities/SKILL.md); this is the matters-only
slice.

## Create

File a matter doc — the self-contained handoff packet — under `meta/matters/`.
For a whole unit of work that may need a plan and several sequenced matters,
use [`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md); this
files one matter whose shape is already settled.

1. **Write the doc** at `meta/matters/<kebab-slug>.md` (slug from the title):
   - frontmatter: `type: matter`, `title`, `description` (the packet in one
     sentence), `status: open`, `model` — the [roster](/meta/model-roster.md)
     value for the model that should *deliver* it, distinct from `provenance`
     below — `plan` + `order` **only** when a plan's build
     order emits it (omitted on a standalone matter — absence is omission),
     `provenance` naming the producing model
     ([model-attribution](/meta/policy/model-attribution.md)), `tags`,
     `timestamp`, and governance `attribution`
     (`when`/`channel`/`agent`/`why`).
   - body: the intent plus the decisions already made, refs carrying the
     detail — enough that a fresh thread can deliver it with the doc as the
     entire handoff — then a `## Model` section carrying the determination
     behind the `model:` stamp in one or two sentences.
2. **Index it**: add the entry to
   [`meta/matters/index.md`](/meta/matters/index.md) (Open section,
   alphabetical).
3. **Backlog by default.** A new matter gets a register row **only** when the
   operator explicitly queues it, at a position they state (renumber beneath
   it). A backlog matter may carry an integer `priority:` (1 = most urgent) —
   the coarse urgency signal where exact order would be fake precision.
4. **Verify**: `mix brain.verify`.

## Guardrails

- **Approval is in-chat.** The consume protocol's approval gate, and every
  question this skill raises, is ordinary chat text — never a UI dialog
  ([session-capture](/meta/policy/session-capture.md)).
- **One matter per PR; fresh threads consume sequentially.** Deliver the
  approved matter and stop — the next row belongs to a fresh thread
  ([atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md)). Asked to
  consume a second matter in the same session, say so and hand back.
- **The register's order is its one authored datum.** Never derive, resort, or
  "fix" the queue order; reordering is the operator's edit.
- **Priority never orders the queue.** `priority:` is a backlog signal; a
  queued row's position is its exact order.
- **Governance namespace** — never mint an `em:` id for a matter doc.
- Never touch `deprecated/`.
