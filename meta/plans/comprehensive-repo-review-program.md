---
type: plan
title: "Comprehensive repo review: program, session ledger, and remaining sections"
description: The cross-session spine of the operator-commissioned code/content/epistemology review — what session 1 covered and found, which sections remain (glossary-scale content sweep, SWE deep-dive, thread-fidelity checks), and the decision queue the review surfaced for the operator.
status: in-progress
provenance: "Claude Fable 5, Claude Code session"
tags: [meta, plan, review, program, audit]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T10:40:00Z
  channel: agent-authored
  agent: "Claude Code agent, comprehensive-review session"
  why: "the review spans sessions by construction; this plan is the cross-session build order and status ledger persist-plans requires for deferred work"
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

## Questions the review leaves with the operator

| # | Decision | Review's recommendation |
|---|---|---|
| 1 | model-attribution's fate (zero conforming instances) | Enforce warn-only presence+form and backfill the 41 policies, or retract; do not leave standing |
| 2 | Excerpt-log discipline (20.1% of knowledge text and growing) | Ratify a selection/size rule or render-collapsed convention |
| 3 | Verbatim-capture filing pattern (three in use) | Standardize on sibling-`source`; retype the strays |
| 4 | Contract size counterweight (15,153 words, monotonic) | Warn-only word-count trend in CI + relocation pass on the five longest policies |
| 5 | Plan-backlog posture (38 active plans vs ~1 execution/session) | Triage pass: supersede or defer-with-date the stale `accepted` set |

## Deferred

- Full per-PR retroactive review remains available as a frame if the
  operator wants provenance-level scrutiny of specific eras (the arc
  analysis's era table is the index for choosing targets).
- `beliefs/` non-glossary docs beyond the 5-doc boundary sample; site
  render QA (visual/link pass over the deployed Pages site); `inbox/`
  digest quality — none currently blocking, all cheap to add to session
  2 or 3 if wanted.
