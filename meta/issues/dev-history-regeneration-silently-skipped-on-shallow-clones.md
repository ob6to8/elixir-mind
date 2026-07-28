---
type: issue
title: "The committed dev-history copy drifts freely — and that is the design, not a defect"
description: Investigated as a defect and closed as one; the check is suffix-tolerant without any bound by design, the deploy workflow re-derives the page from full history on every push to main, and the committed copy is a lagging convenience copy. What was real is that three docs overstated the tolerance as one PR.
status: wontfix
provenance: "Claude Code session, 2026-07-28 — opened on a diagnosis, then corrected against the code's actual behavior and the operator's ratification of the existing design"
tags: [meta, issue, dev-history, generated-artifacts, ci, shallow-clone, gates, lag-tolerant-check]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, Kimi K3 weight-release intake session"
  why: "the diagnosis confirmed a defect whose fix is a separate design decision, which the originating todo said should be split into an issue"
  from: [/meta/threads/2026-07-28-kimi-k3-weight-release-implications.md]
---

# The committed dev-history copy drifts freely — and that is the design

This issue was opened asserting a defect. Measured against the code, the defect
is not there. Operator-ratified 2026-07-28: the committed copy is a lagging
convenience copy, the live site is the current one, and no fix is being made.

## What is actually true

**The check is suffix-tolerant without any bound.**
`ElixirMind.DevHistory.lagging_but_consistent?/2` passes whenever the on-disk
copy is a *suffix* of a fresh render — the preamble matches and
`String.ends_with?(fresh, disk_sections)`. Any number of missing newest sections
passes; anything else fails. Measured directly against the live file:

| File state | `--check` |
|---|---|
| untouched (control) | pass |
| 1 newest section removed | pass |
| **6 newest sections removed** | **pass** |
| one middle section removed | fail |
| oldest section removed | fail |

**The live site is always current.** `pages.yml` checks out with
`fetch-depth: 0` and runs `mix brain.dev_history` before building, on every push
to `main`. The published page therefore includes the merge that triggered it,
regardless of the committed copy.

**So the committed copy is a cache.** It is allowed to lag arbitrarily; the check
exists to catch *hand edits and reorderings*, not staleness. That is exactly what
[lag-tolerant check](/beliefs/glossary/lag-tolerant-check.md) describes — and
that entry names the deploy-time re-derivation as "the complementary freshness
mechanism". The glossary had it right the whole time.

## What was wrong — the docs, not the code

Three places overstated the tolerance as a **one-PR** bound the code has never
enforced:

- [`/create-pull-request`](/.claude/skills/create-pull-request/SKILL.md) step 4 —
  "deliberately lag-tolerant by exactly one PR". Corrected; it is a living
  surface.
- [The staleness analysis](/meta/analysis/dev-history-staleness-and-ci-regeneration.md)
  — bolds "lag-tolerant by exactly one PR" with the correct mechanism ("plus zero
  or more *additional* trailing sections") in the parenthetical beside it. Marked
  in place rather than rewritten: an analysis is a point-in-time record.
- This issue's own first draft, which repeated the phrase and built a defect on
  it.

The analysis's "Evidence 2" also attributes a historical CI failure to lag
exceeding one PR. Given the measurement above, lag count alone cannot cause a
failure; some other divergence (a reordering, an out-of-order merge, or a hand
edit) must have broken the suffix relation. What that divergence was is **not
established** — it is not re-derivable from the current tree, and no attempt is
made here to guess it.

## The one real residue, accepted

`mix brain.dev_history` refuses on a shallow clone and exits zero, so step 4 is a
silent no-op in web sessions. Measured across the 18 PRs merged since that step
existed, the outcome clusters perfectly by session rather than by PR — one branch
missed 5/5, two others hit 3/3 and 2/2 — and the one session that flipped
mid-flight did so exactly when it ran `git fetch --unshallow`. That rules out
sporadic agent-skip as the dominant cause: a per-container property fails
uniformly for a session's whole life.

Under the ratified design this is **cosmetic**. Step 4 is best-effort tidiness
that shrinks the cache's lag when it can; when the clone is shallow it does
nothing, the cache lags further, and nothing downstream is wrong. It is closed on
that basis, not because the behavior was disproven.

## Why not "fix" it anyway

Three fixes were weighed and declined:

- **Bound the lag in the check.** Would convert an accepted property into a
  failure. It would fire on exactly the drift the design permits.
- **Unshallow in step 4.** A full fetch per PR to keep a cache tidier than it
  needs to be.
- **Commit the regenerated file back after each merge.** Already rejected on its
  merits by the [staleness analysis](/meta/analysis/dev-history-staleness-and-ci-regeneration.md)
  — it puts bot commits on the default branch with no session to attribute them
  to, against the [merge-strategy](/meta/policy/merge-strategy.md) provenance
  model, and cannot eliminate the self-referential lag anyway.

Reopen if the committed copy is ever treated as authoritative for something —
cited by SHA, read by tooling, or relied on offline — because the cache framing
is what makes the drift acceptable.
