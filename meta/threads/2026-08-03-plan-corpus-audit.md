---
type: reference
title: 2026-08-03-plan-corpus-audit
description: An operator-commissioned audit of every plan against the repo and the matter queue — 59 plans evaluated by a twelve-cluster subagent fan-out with adversarial verification, finding two executed plans still filed accepted, 25 active plans needing refresh, none retiring, and twelve corpus-level findings; then re-checked against a same-day main merge that changed no verdict but falsified the audit's counts, its register-row citations, and its own framing.
provenance: "Claude Code session (Claude Fable 5, then Claude Opus 5 from the merge onward), spanning 2026-08-02 (the audit) and 2026-08-03 (the main merge, the corrections, and this capture); verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped. Render deliberately truncated: at operator direction the transcript following the `merge main into thread` message is omitted; the narrative and ledger below cover that work, and its commits are in the PR."
tags: [thread, plans, audit, drift, matters, governance]
timestamp: 2026-08-03
session: https://claude.ai/code/session_01CTBqPfzgjM4VpE84J679Lv
---

# 2026-08-03-plan-corpus-audit

The operator commissioned a comprehensive audit of the plan corpus — every
plan read against the repo and against the matter list "indicating where the
repo is headed" — with subagent fan-out expected for the evaluations. Fifty-nine
plans were partitioned into twelve subsystem clusters so cross-plan
supersession would be visible inside one context, each evaluator instructed to
distrust a plan's own status line and index gloss and to ground every verdict
in artifacts, git history, and the register; every record-rewriting verdict
(mark-done, mark-superseded, fold) was routed to an adversarial verifier told
to refute it.

The finding was that **nothing is moot**: no plan retires, because every active
plan still names wanted unshipped work or is the load-bearing home of a
standing verdict. What is wrong is different — two plans that verifiably ran to
completion still read `accepted`, and 25 of the 41 active plans describe a repo
that has moved under them. Twelve corpus-level findings landed in
[the analysis](/meta/analysis/plan-corpus-audit.md), the largest being that
plans predating [`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md)
emit no matters at all — so the operator's own `priority: 1` plan has no
register row while a top-down `/matter` session would deliver every queued row
before reaching it. Two of the twelve subagents lost their verification pass to
a session usage limit; both were re-verified directly against the tree rather
than reported unverified.

The session then paused overnight and resumed the next day, merging
`origin/main` (73 files, clean) and re-checking the audit against it, which is
where the second half of the work went. The merge
changed **no verdict** — both mark-done plans were byte-unchanged — but it
falsified the audit's censuses, every register-row citation it made, and its
own framing paragraph: the review-program decision-queue row it claimed to
execute had been resolved two days earlier into *session 5, the governance
backlog audit*, of which this analysis is the plans third. Three of its
remedies turned out to already exist as queued matters, the model-attribution
tangle had grown from four artifacts to seven across a new
prospective/retrospective axis, and the Pages question had moved to the backlog
carrying a third option (freeze) that dissolves most of the contingencies the
audit had enumerated. All of it was corrected in place rather than left
standing on a superseded repo.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Plan-corpus audit: 59 plans, verdicts, twelve corpus findings, four-tier program | closed | [plan-corpus-audit](/meta/analysis/plan-corpus-audit.md) | - |
| Audit re-checked and corrected against the `684530d` merge | closed | [plan-corpus-audit](/meta/analysis/plan-corpus-audit.md) | - |
| Tier 1–3 follow-ups (status flips, the de-todo sweep, per-plan refreshes) | open | [plan-corpus-audit](/meta/analysis/plan-corpus-audit.md) | options offered, none chosen — each becomes a backlog matter doc only once the operator ratifies it |
| Seven operator decisions surfaced by the audit | open | [plan-corpus-audit](/meta/analysis/plan-corpus-audit.md) | five need rulings; model-attribution and Pages are already carried by existing artifacts |
| Correcting the analysis's write-once `attribution` fields | closed | [plan-corpus-audit](/meta/analysis/plan-corpus-audit.md) | - |
| Session 5's issue and matter thirds | open | [comprehensive-repo-review-program](/meta/plans/comprehensive-repo-review-program.md) | a following pass audits the open issues and open matters against the same baseline |

## User

go through and do a comprehensive plan audit. many have drifted as they were authored previous. some may be moot and should be retired, some may need to be updated and refactored. consider each plan in the context of 1. the repo and 2. the current matter list, indicating where the repo is headed. i presume that you will run subagents for evaluations. ask if any questions

## User

try again

## Assistant

<routes ref="meta/analysis/plan-corpus-audit.md">

The audit is complete, committed (`4bb0fc6`), and pushed — the full pre-commit gate suite ran green on the way (including the 211-test suite). Here is the result.

---

**Orientation.** I audited all 59 plan documents against the repo as it stands today and against the matter queue that now defines where work goes next. The evaluators — twelve subagents, each owning a cluster of related plans, each required to ground verdicts in files and git history rather than the plans' own status lines — found that **no plan is moot enough to retire outright**. The corpus's actual disease is different: two finished plans still read as open work, 25 of the 41 active plans describe a repo that has moved under them, and a handful of defects are *structural* — properties of how the plan system meets the new matter system, not of any one plan. Everything below is filed in the audit analysis: [meta/analysis/plan-corpus-audit.md](https://github.com/ob6to8/elixir-mind/blob/claude/plan-audit-comprehensive-ui0yfv/meta/analysis/plan-corpus-audit.md), which carries the full verdict tables, twelve corpus-level findings, and a per-plan appendix with the concrete edit list for every refresh, so any future session can execute without re-deriving.

**The verdict distribution** (all 59): **2 mark-done** — the bookmarks survey tier and the glossary single-overview both completed their build orders in their authoring sessions and were never flipped past `accepted`; I re-verified both directly (artifacts exist, `mix brain.glossary` runs green in CI and pre-commit) after their adversarial verifiers died on a session usage limit. **14 active keep-as-is** — sound and still wanted, including several whose stakes *rose* (the frontmatter parser rewrite is now the corpus's highest-leverage unratified plan: span-attribution phase 1 prefers its `dump/1` and the matter-CLI is hard-blocked on it). **25 active refresh-in-place** — five invalidated or contradicted by the 2026-08-01 ratification wave (concept-terminology's sweep census is 2.5× stale and would silently discard evidence edges on two docs; the epistemic overlay's role-derivation is now illegal as written; structural-link-integrity was overtaken by a hard gate four hours after filing), four with premises moved from under them (the `mind.*` rename's motivating premise died in the next day's naming reversal; both external-harness plans now sit where the project-namespace policy says a `projects/` hub belongs), and the rest mechanically stale. **18 historical** — all statuses accurate; two index glosses advertise retired mechanisms.

**The structural findings that matter most:**
1. **The plan backlog is not wired into the matter queue.** The operator-designated priority-1 plan has no register row; no accepted plan's build order has emitted a matter. A session consuming `/matter` top-down delivers all six queued rows before touching your stated #1.
2. **The todo retirement left its vocabulary in eleven active plans** — including a routing table that would file findings into a retired type and a manifest sketch that would configure `todo` and reject `matter`. One mechanical sweep closes it.
3. **Model attribution: one question, four artifacts, three answers** — the ratified policy (model in `provenance`), span-attribution D5/D6 (model's one home is `attribution.agent`, policy amended at phase 1), a stale backlog matter recommending rejection, and the review program's decision-queue row 1. Recommendation: the most recent ratification (span) controls; cancel/repoint the matter.
4. **Index-gloss drift is systemic** — the failure class your open policy-index issue names showed up on the plans, issues, and matters indexes too (including one plan filed under the wrong status section).
5. **13 remote `claude/*` branches sit outside every triage scope** (checked against `ls-remote` today), and one — `agentic-cognitive-bias-mapping-azr322` — name-overlaps **queued matter row 4**. Whoever executes that row should inspect the branch first or risk the duplicate-filing failure already on record.

| What I created | | |
|---|---|---|
| type | doc | why this type |
| `analysis` | `meta/analysis/plan-corpus-audit.md` | a reasoned judgment on a question, against evidence — the review program's decision-queue row 5 executed |

| What I modified | |
|---|---|
| file | thrust |
| `meta/analysis/index.md` | index the new analysis (index coverage is a hard gate) |

| Actions I have taken | |
|---|---|
| action | result |
| 12-cluster evaluator fan-out + adversarial verify pass | all 59 plans evaluated (~2.2M subagent tokens, 499 tool calls, ~59 min); 2 verifiers hit a usage limit |
| Replaced the two dead verifiers in-session | both mark-done verdicts confirmed against the live tree |
| Re-counted load-bearing censuses | 577 glossary `verified: false`; 3 `verified: true` concepts; 160 threads; 14 remote `claude/*` heads |
| Gate suite + commit + push | pre-commit suite green (incl. 211 tests); `4bb0fc6` on `claude/plan-audit-comprehensive-ui0yfv`; no PR opened |

| Questions you need to answer | | |
|---|---|---|
| # | question | my recommendation |
| 1 | Ratify **Tier 1** (flip the two done plans, fix the misfiled entry and stale index glosses)? | Yes — one small follow-up matter after this audit lands; every item is evidence-backed, zero design judgment |
| 2 | Ratify **Tier 2** (the mechanical de-todo sweep across eleven active plans)? | Yes — one matter, closes the whole class |

| Your options from here | | |
|---|---|---|
| # | option | what it entails |
| 1 | Wire plans into the matter system | emit matters for accepted plans' next steps (starting with priority-1 compile-skills-registry), and decide whether acceptance should always emit a first matter |
| 2 | Settle model attribution | adopt span D5/D6 as controlling; cancel the stale matter; close decision-queue row 1 by reference |
| 3 | Ratify the parser rewrite first | land `Frontmatter.dump/1` before span phase 1's corpus sweep, so the sweep and normalization don't run in the wrong order |
| 4 | Re-address the two external-harness plans | refile under `projects/` with incubating hubs (shape change — yours to ratify) |
| 5 | Reconfirm the `mind.*` rename | keep it re-anchored to the naming reversal and sequence it per the spin-out's Q7, or park it |
| 6 | Draw the review-gate boundary once | advisory-lane CI review per the ratified precedent; `/council` scoped to shape-change review |
| 7 | Rule the Pages sunset before dependent ratifications | it gates ten-plus surfaces mapped in finding 11; dev-history recommit (row 2) lands first |

The branch is pushed and holds only the audit; say `/create-pull-request` when you want it landed, and the refresh dossiers in the appendix are written so Tier 1/2 and any per-plan refresh can execute as clean single-matter follow-ups.

</routes>

## User

merge main into thread
