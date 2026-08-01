---
type: plan
title: "Comprehensive repo review: program, session ledger, and remaining sections"
description: The cross-session spine of the operator-commissioned code/content/epistemology review — what session 1 covered and found, which sections remain (glossary-scale content sweep, SWE deep-dive, thread-fidelity checks, governance backlog audit), and the decision queue the review surfaced for the operator.
status: in-progress
provenance: "Claude Fable 5, Claude Code session"
tags: [meta, plan, review, program, audit]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T10:40:00Z
  channel: agent-authored
  agent: "Claude Code agent, comprehensive-review session"
  why: "the review spans sessions by construction; this plan is the cross-session build order and status ledger persist-plans requires for deferred work"
  from: [/meta/threads/2026-08-01-comprehensive-repo-review-session-1.md]
---

# Comprehensive repo review — program

The operator commissioned a comprehensive code, content, and epistemological
review of the entire repo (2026-08-01), with per-PR retroactive review
suggested as one possible frame and the structure left to agent judgment.

**Relation to the [comprehension audit](/meta/plans/comprehension-audit.md):**
complementary, not overlapping. That plan is operator-led
(operator-reads-first, retrieval-practice ordering) and produces *operator
understanding*; this program is agent-led and produces a *defect and drift
census with graded evidence*. This program deliberately does not start that
plan's protocol; its findings can seed that audit's per-stage worklists
when the operator runs it.

**Frame decision.** Current-state review over per-PR retroactive reviews:
with 220 PRs in 27 days, most PR-sized review value is superseded by later
changes; the PR history was instead used to derive intent (the arc
analysis), and per-PR audit value is folded into the remaining sections as
*intake-fidelity sampling* (checking filed docs against their cited
sources) rather than PR-by-PR passes.

## Session ledger

### Session 1 — 2026-08-01 (this session): arc, code, epistemology, content sample — done

| Artifact | What it holds |
|---|---|
| [development arc](/meta/analysis/development-arc-read-backwards-from-the-prs.md) | Seven eras from the 2026-02 prehistory to the comprehension pivot; five through-lines; four drift points |
| [tooling implementation review](/meta/analysis/tooling-implementation-review.md) | Full-code review: 2 defects, 5 gaps, 6-item staleness class, strengths, test-gap map |
| [epistemology & governance review](/meta/analysis/epistemology-and-governance-review.md) | Verification-substance audit (all 4 verified docs, 3 live fetches), 7 contract/enforcement desyncs, contract contradictions, the zero-conformance rule, growth pressure |
| [content quality sample](/meta/analysis/content-quality-sample-review.md) | 30 docs graded (18 A / 5 A- / 7 B+); excerpt-log erosion (20.1% of corpus lines), filing inconsistency, correction non-propagation |
| Issues: [route-tag fence loss](/meta/issues/route-tag-regions-lose-fenced-code.md), [index-gate substring masking](/meta/issues/index-coverage-gate-substring-masking.md) | The two confirmed tooling defects, with reproductions and fix shapes |

Method note for successor sessions: delegated fan-out (four bounded audit
passes) with every severe claim re-verified directly before filing —
reproductions run for code defects, greps/fetches named inline for
policy and content claims.

### Decision-queue session — 2026-08-01 (in progress)

The operator-gated ruling session over the queue below. Landed mid-session:
queue row 5 resolved by ratifying **session 5 — the governance backlog
audit** (see Remaining sections) in place of a bare posture ruling; the
[complete docs rewrite](/meta/plans/complete-docs-rewrite.md) plan filed as
`proposed` with its sequencing ratified. Rows 1–4 and the
contract-synchronization sweep are in flight; this entry is completed at the
session's close.

## Remaining sections

### Session 2 — the unsampled corpora

- **Glossary at scale**: 569 term files had zero coverage this session.
  Sample ≥60 across `sense` values: definition fidelity against citing
  docs, description/body dedup quality beyond the mechanical check,
  *Seen in:* accuracy, staleness of nascent-coinage markings.
- **Thread-corpus fidelity**: sample ~10 of 151 thread docs against the
  session-capture drop rule (is retained text actually verbatim? are
  drops actually noise?) — the record layer has had no substance audit.
- **Remaining indexes**: the ~20 knowledge indexes not sampled in
  session 1, same protocol (bidirectional coverage + gloss accuracy).

### Session 3 — the majority domain and cross-doc structure

- **SWE/agentic deep-dive**: 83 docs (51% of knowledge/) — intake-fidelity
  sampling against cited sources, agentic-loop synthesis-gap assessment
  (25 near-thesis captures with no synthesis doc above the index), and
  the BEAM/Jido satellite-cluster consolidation question.
- **Duplication beyond the top-10 pairs**; `deprecated/` triage input
  (33 files — feeds the existing
  [triage todo](/meta/todos/triage-what-remains-in-deprecated.md), not a
  new artifact).

### Session 4 — fixes and decisions (operator-gated)

The execution session(s) for what the review filed, in recommended order:

1. The two issues (fence loss + substring masking), each with its
   regression test.
2. The staleness sweep (tooling review findings 8–13, one commit).
3. The contract synchronization sweep (epistemology review §2) +
   contradiction fixes (§3) + `/render-contract`.
4. The content fixes (kimi-k3 retracted figures; OKF `log.md` line).

### Session 5 — the governance backlog audit

Ratified by the operator 2026-08-01 (decision-queue session), replacing
queue row 5: instead of ruling on backlog *posture* bare, audit the backlog
item by item and ratify dispositions over evidence.

- **Scope**: every active plan (`meta/plans/`, status
  proposed/accepted/in-progress), open issue (`meta/issues/`), and open
  todo (`meta/todos/`) — 39 / 8 / 18 = 65 items at ratification; the audit
  reads live state at run time. Per-item census work no existing plan
  scopes.
- **Per-item disposition**, exactly one, each with a one-line cited
  justification: still valid · already satisfied (name what satisfies it —
  e.g. the
  [ratify-or-reject-provenance todo](/meta/todos/ratify-or-reject-provenance-names-producing-model.md)
  the epistemology review flagged as stale on its face) · superseded by a
  later ratification (name it) · duplicate of another item (name it) ·
  keep with a defer-until condition (state it).
- **Deliverable**: one audit table plus a disposition recommendation per
  item, filed as `type: analysis`, for the operator's ratification pass —
  the audit recommends; it applies nothing.
- **Coordination edges**:
  [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md)
  (in-progress) and
  [matter-disjointness-check-for-parallel-filing](/meta/plans/matter-disjointness-check-for-parallel-filing.md)
  touch adjacent ground (ledger-strand dispositioning; duplicate detection
  at filing time). The audit consumes their state; it does not redo them.
- **Ordering**: after the decision-queue session lands (its ratifications
  are part of the supersession landscape the audit judges against);
  independent of sessions 2–3.

## Questions the review leaves with the operator

| # | Decision | Review's recommendation |
|---|---|---|
| 1 | model-attribution's fate (zero conforming instances) | Enforce warn-only presence+form and backfill the 41 policies, or retract; do not leave standing |
| 2 | Excerpt-log discipline (20.1% of knowledge text and growing) | Ratify a selection/size rule or render-collapsed convention |
| 3 | Verbatim-capture filing pattern (three in use) | Standardize on sibling-`source`; retype the strays |
| 4 | Contract size counterweight (15,153 words, monotonic) | Warn-only word-count trend in CI + relocation pass on the five longest policies |
| 5 | Plan-backlog posture (38 active plans vs ~1 execution/session) | Triage pass: supersede or defer-with-date the stale `accepted` set — **resolved 2026-08-01**: replaced by session 5, the governance backlog audit |

Row 5 was resolved by ratification rather than ruled bare: the operator
commissioned session 5 (2026-08-01, decision-queue session) as its
disposition — a per-item audit-and-ratify pass over the whole governance
backlog instead of a posture call over the plans alone. The live queue is
rows 1–4.

## Execution hand-offs

Ratified sequencing (operator, 2026-08-01): resolve the session-1 thread →
fix thread → operator reading block → decision-queue thread → sessions 2–3.
The operator reads the four analyses before the decision-queue thread (arc
first as the frame, then epistemology and content — they argue the queue —
with the tooling review last, doubling as review context for the fix PR).
Model selection follows
[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md):
strongest tier where the output is unoracled judgment, cheaper tiers where
the gate suite is the oracle. Extended 2026-08-01 (decision-queue session):
session 5, the governance backlog audit, runs after the decision-queue
session lands; it is unordered relative to sessions 2–3.

### Fix thread — Sonnet-tier (fully specified defects; mechanical oracle)

> Fix the two open issues filed by the comprehensive review, plus the
> staleness sweep it recommended, on a fresh branch:
>
> 1. `/meta/issues/route-tag-regions-lose-fenced-code.md` — fix
>    `parse_line/2` in `lib/elixir_mind/route_tags.ex` so fence lines and
>    fenced content are appended to an open region's content (fence state
>    still suppresses tag/turn matching inside code), add the round-trip
>    regression test (a region containing a fence materializes whole), then
>    run `mix brain.route_tags --materialize` and include the nine rewritten
>    sink diffs in the PR.
> 2. `/meta/issues/index-coverage-gate-substring-masking.md` — tighten
>    `Links.unlisted_files/3` to link-target or word-boundary matching, with
>    the regression test named in the issue.
> 3. The staleness sweep: findings 8–13 in
>    `/meta/analysis/tooling-implementation-review.md` (two stale
>    comments/exemptions, the capture and render-contract skill corrections,
>    the resource-attribution exemption list + `/render-contract`, the
>    unit-terminology pass over the six skills and task shortdocs +
>    `mix brain.codemap`).
>
> One commit per numbered item. Full gate suite green before closing. Mark
> both issues `status: resolved` with a one-line resolution note, update
> `meta/issues/index.md`, then `/create-pull-request`.

### Decision-queue thread — strongest tier (unoracled judgment ratified into policy)

> Work the operator decision queue from the comprehensive review. The queue
> is the table "Questions the review leaves with the operator" in
> `/meta/plans/comprehensive-repo-review-program.md`; the argued case for
> each row is in the epistemology and content review analyses it links.
>
> For each of the five rows in order: present the recommendation and its
> case in chat text, take my decision inline, and execute what a decision
> unblocks in-session (policy edits + `/render-contract`, the
> model-attribution index-gloss fix, retyping strays, filing a small plan
> where a row needs design rather than a ruling — likely the excerpt-log
> discipline row).
>
> After the queue, present the contract-synchronization sweep (§2–3 of
> `/meta/analysis/epistemology-and-governance-review.md`) as a single
> ratification, and execute it on approval.
>
> Update the program plan's session ledger, then `/create-pull-request`.

### Session 2 — Opus-tier main loop, cheaper subagent readers

> Execute session 2 of `/meta/plans/comprehensive-repo-review-program.md`
> (the glossary-scale, thread-fidelity, and remaining-index sweeps). Read
> the plan's "Remaining sections" for scope and its method note: delegate
> bounded reading passes, and re-verify every severe claim directly before
> filing anything.
>
> Deliverables: one analysis under `meta/analysis/` per the session-1 house
> pattern, issues only for confirmed defects, the program plan's ledger
> updated. Honor the decisions ratified in the decision-queue session
> (check the plan's ledger for them) as the criteria the sweeps judge
> against. Then `/create-pull-request`.

### Session 3 — Opus-tier (strongest tier if the consolidation call should be made at full strength)

> Execute session 3 of `/meta/plans/comprehensive-repo-review-program.md`:
> the SWE/agentic deep-dive (intake-fidelity sampling against cited
> sources, the agentic-loop synthesis-gap assessment, the BEAM/Jido
> satellite-cluster consolidation question), duplication beyond the top-10
> pairs, and the `deprecated/` triage input for
> `/meta/todos/triage-what-remains-in-deprecated.md`.
>
> Same method and deliverable shape as session 2. If this completes the
> program's remaining sections, move the program plan to `status: done`
> with a closing ledger entry. Then `/create-pull-request`.

### Session 5, governance backlog audit — Opus-tier (criterion-guided grading over ~65 items; the operator's ratification pass is the oracle)

> Run session 5 of `/meta/plans/comprehensive-repo-review-program.md` — the
> governance backlog audit. Audit every active plan (`meta/plans/`, status
> proposed/accepted/in-progress), every open issue (`meta/issues/`), and
> every open todo (`meta/todos/`): read each item in full, then assign
> exactly one disposition — still valid · already satisfied (name what
> satisfies it) · superseded by a later ratification (name it) · duplicate
> of another item (name it) · keep with a defer-until condition (state the
> condition) — each with a one-line justification citing evidence, never
> graded from the title alone.
>
> Two in-flight efforts touch adjacent ground:
> `/meta/plans/reconcile-dangling-ledger-strands.md` (in-progress) and
> `/meta/plans/matter-disjointness-check-for-parallel-filing.md`. Consume
> their state as input; do not redo or absorb their work.
>
> Deliverable: one `type: analysis` under `meta/analysis/` per the
> session-1 house pattern — the audit table plus a per-item disposition
> recommendation for the operator's ratification pass; apply no
> dispositions in the audit session itself. Update the program plan's
> session ledger, then `/create-pull-request`.

## Deferred

- Full per-PR retroactive review remains available as a frame if the
  operator wants provenance-level scrutiny of specific eras (the arc
  analysis's era table is the index for choosing targets).
- `beliefs/` non-glossary docs beyond the 5-doc boundary sample; site
  render QA (visual/link pass over the deployed Pages site); `inbox/`
  digest quality — none currently blocking, all cheap to add to session
  2 or 3 if wanted.
