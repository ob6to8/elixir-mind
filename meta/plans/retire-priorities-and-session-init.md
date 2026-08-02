---
type: plan
title: "Retire the pre-matters appraisal: /priorities and mix brain.session_init"
description: "The matter register made delivery order an authored datum, so the session-init digest's derived appraisal — the cross-artifact scan and its heuristic top-3 — is now a competing shadow of the queue; records the redundancy survey (each digest section against its matters-era surface), the retirement shape (/matter list, /issue, /plan, and the gate suite absorb everything load-bearing; module, task, skill, and tutorial go), the consumer re-point list, and the sequencing behind the strand-reconciliation plan's sweep-before-switch constraint."
status: proposed
provenance: "Claude Fable 5, matters-redundancy research spike, 2026-08-02"
tags: [meta, plan, tooling, matters, priorities, session-init, redundancy]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T19:06:00Z
  channel: agent-authored
  agent: "Claude Code agent, matters-redundancy research spike"
  why: "operator commissioned a survey of how the advent of matters left redundancy across the mix tasks and codebase, to land as a plan emitting the matters that address it"
---

# Retire the pre-matters appraisal: /priorities and mix brain.session_init

## Problem

Before the matter register, "what should a fresh session work on" had no
authored answer, so the brain derived one: `ElixirMind.SessionInit` scans four
surfaces (open issues, open matters, active plans, dangling ledger strands),
ranks them by fixed class weights, and closes with a heuristic top-3 that
[`/priorities`](/.claude/skills/priorities/SKILL.md) relays for the agent to
refine — "the script ranks, the agent judges"
([tutorial](/meta/tutorials/the-session-init-digest.md)).

The [matter register](/meta/matters.md) (seeded 2026-08-02) inverted the
premise. Delivery order is now an **authored datum** — "The register's order is
its one authored datum. Never derive, resort, or 'fix' the queue order"
([`/matter`](/.claude/skills/matter/SKILL.md)) — and queued-ness is register
membership, consumed top-down. A heuristic ranking running beside an authored
queue is a second answer to a question the operator now answers directly: the
class weights place every open issue above every matter, while the register
says rows 1–11 in the operator's order. The digest also fails its own job by
scale: the run at HEAD `6041ad1` renders ~74 KB — 8 issues, 30 matters, 43
active plans, 143 strand rows, 13 freshness warnings — an appraisal too long to
appraise, which is what the top-3 existed to compensate for and what the
register now does by construction. This is the same record/queue straddle the
[strand-reconciliation plan](/meta/plans/reconcile-dangling-ledger-strands.md)
dissolved for ledgers, surfacing one layer up: a derived view competing with
the layer that owns the answer.

The operator commissioned this spike as a "survey and research spike about how
the advent of matters has led to possibly redundancy across mix tasks and the
codebase", with the stated direction that `/priorities`' work and the heuristic
top-3 be removed and `mix brain.session_init` reworked. This plan records the
survey and the retirement it recommends.

## Survey — the digest's sections against their matters-era surfaces

| Digest section | Matters-era surface | Verdict |
|---|---|---|
| Open issues | `/issue` — status-grouped listing, `priority:` flag shown | redundant listing |
| Open matters (queued rows first) | `/matter list` — queue in register order, backlog `priority:`-sorted; `mix brain.matters` verifies register↔doc agreement | redundant, and the poorer copy |
| Active plans | `/plan` — status-grouped listing | redundant listing |
| Dangling strands | none, by design — [deferred-work-is-filed](/meta/policy/deferred-work-is-filed.md) files deferrals at naming, and the [reconcile plan](/meta/plans/reconcile-dangling-ledger-strands.md) (in-progress, ratified 2026-07-28) strips ledger state and already schedules `dangling_strands/1`'s deletion in its step 3 | owned by the reconcile plan; only sequencing binds (build order) |
| Docs-freshness warnings | `mix brain.verify` prints the same `Links.check/1` + attribution warnings at pre-commit and in CI (`lib/mix/tasks/brain.verify.ex:34`) | the one residue needing a decision (boundary decisions) |
| Heuristic top-3 + agent note + `priority:` pinning | the register **is** the ranking; backlog urgency stays on `priority:`, read by `/matter list` | the removal target; no successor needed |

Two adjacent findings, scoped to this checkout (HEAD `6041ad1`):

- **The digest no longer says "todos"; its living neighbors still do.** `lib/`
  and `test/` have zero `todo` matches and the matters section prints
  `## Open matters` — the strings the todo fold (PR #232) missed sit in
  `README.md` (a "todos" digest description and a `/todo` skill reference,
  lines 51–54; a namespace gloss, line 26),
  `meta/tutorials/index.md`'s digest gloss,
  `meta/tutorials/the-tooling-architecture.md`'s SessionInit bullet, and
  `.claude/skills/create-pull-request/SKILL.md` (lines 53, 109). An "open
  todos" string cannot come from the code at HEAD; those docs are where it
  survives.
- **The interim already contradicts itself.** skills-registry (compiled into
  the contract) frames `/issue` and `/plan` as slices of `/priorities`, and
  `/matter`'s own text calls itself "the matters-only slice" — three slices of
  an aggregate whose ranking the register displaced.

## The shape

Current state — the retiring surface and its consumers:

```
mix brain.session_init (ElixirMind.SessionInit, 410 lines + 240-line test)
├── scans ....... meta/issues · meta/matters (Matters.queue_positions/1) · meta/plans · thread ledgers
├── renders ..... five sections + heuristic top-3 + agent note        (~74 KB today)
└── consumers
    ├── /priorities (sole runner) ........ .claude/skills/priorities/SKILL.md
    ├── SessionStart hook pointer ........ .claude/hooks/session-start.sh:38
    ├── contract, via skills-registry .... /priorities entry + "slice of" glosses
    ├── policies ......................... concerns-block-the-close · governance-artifact-routing
    ├── docs ............................. dedicated tutorial · tooling-architecture · README · meta/index task list
    └── glossary ......................... session-init-digest (em:6f2442) · recitation · sessionstart-hook
```

Desired state — open work in the matters era, each load-bearing function on
exactly one surface:

```
open work
├── committed queue ....... meta/matters.md (authored order) → /matter · /matter list
├── backlog ............... open matter docs without rows → /matter list (priority:-sorted)
├── problems .............. meta/issues/ → /issue
├── decision records ...... meta/plans/ → /plan
├── strand hygiene ........ PR-time Action gate (reconcile plan steps 2–5); the record layer stays frozen
├── docs freshness ........ mix brain.verify advisory output (pre-commit + CI)
└── cold-session entry .... hook pointer → "run /matter list"
```

File-tree diff:

```diff
 lib/elixir_mind
-├── session_init.ex                    # DELETED — scan + class weights + top-3
 lib/mix/tasks
-└── brain.session_init.ex              # DELETED — task wrapper
 test/elixir_mind
-└── session_init_test.exs              # DELETED — rides its module out
 .claude
-├── skills/priorities/SKILL.md         # DELETED — the appraisal skill
~├── hooks/session-start.sh             # MODIFIED — header comment + pointer → /matter list
~├── skills/{issue,plan,matter}/SKILL.md      # MODIFIED — "slice of /priorities" framing dropped
~└── skills/create-pull-request/SKILL.md      # MODIFIED — "where /priorities reads" reworded
 meta
~├── policy/{skills-registry,concerns-block-the-close,governance-artifact-routing}.md
~├── policy/index.md                    # MODIFIED — glosses follow their policies
-├── tutorials/the-session-init-digest.md     # DELETED (open question 1)
~├── tutorials/{index,the-tooling-architecture,sessionstart-hook-and-the-local-gate-in-a-fresh-sandbox}.md
~├── evals/priorities-recitation-vs-harness-reminders.md  # MODIFIED — re-anchor (open question 3)
~├── matters/build-the-two-proposed-eval-instruments.md   # MODIFIED — same re-anchor
~├── index.md                           # MODIFIED — task listing row removed
~└── code-map.md                        # REGENERATED — mix brain.codemap
 beliefs/glossary
~├── session-init-digest.md             # MODIFIED — historical rewrite, id em:6f2442 kept
~├── {recitation,sessionstart-hook}.md  # MODIFIED — mentions re-anchored
~└── index.md                           # MODIFIED — gloss follows its entry
~README.md                              # MODIFIED — usage paragraph → queue surfaces
~CLAUDE.md                              # REGENERATED — mix brain.contract
~meta/threads (6 files)                 # MODIFIED — <routes> path refs only + re-materialize
```

**No new signatures.** The change is subtractive; the one API decision is a
retention: `ElixirMind.Matters.queue_positions/1` keeps its public contract
with its digest caller gone — it is the register's tolerant read and the
[matter-CLI plan](/meta/plans/matter-cli-and-neovim-surface.md)'s `list/1`
anchor.

**Boundary decisions:**

- **Ranking is authored only.** Nothing derives an order across artifact
  types. Backlog urgency stays on integer `priority:` keys, read by
  `/matter list`; `/issue` and `/plan` keep showing the flag on their listings;
  the pinning consumer (the digest's above-every-class override) retires with
  the ranking it overrode.
- **Freshness warnings stay gate-side.** `mix brain.verify` already prints the
  identical advisory set at pre-commit and in CI; the digest's copy dates from
  the era when the digest was auto-injected and gate output "never reach[ed] an
  operator working purely in the app" — with the appraisal gone, the gates are
  the surface, relayed by the agent whenever they fire.
- **The recitation function transfers; the instrument retires.** Open work one
  command from cold — the tutorial's anti-drift rationale, and what
  [recitation](/beliefs/glossary/recitation.md) cites `/priorities` for — is
  served by `/matter list` plus the hook pointer against the register.
- **Route-tag layer.** 8 tagged regions across 6 frozen threads carry
  `lib/elixir_mind/session_init.ex` path refs, and `mix brain.route_tags`
  fails CI on unresolved refs. Per the
  [rename plan](/meta/plans/rename-second-brain-to-elixir-mind.md)'s ratified
  Decision 3, tag attributes are routing-layer machinery applied *over* the
  frozen body: refs to the deleted path are dropped from their ref sets (a
  region whose set empties loses its tag), and sinks re-materialize in the
  same PR.

## Anchors — the consumer re-point list (M2's sweep)

- Delete: `lib/elixir_mind/session_init.ex`,
  `lib/mix/tasks/brain.session_init.ex`,
  `test/elixir_mind/session_init_test.exs`,
  `.claude/skills/priorities/SKILL.md`,
  `meta/tutorials/the-session-init-digest.md` (pending open question 1).
- Hook: `.claude/hooks/session-start.sh` — header comment (lines 4–9) and the
  line-38 pointer become "run /matter list to review the queue" (open
  question 2).
- Skills: `.claude/skills/issue/SKILL.md` and `.claude/skills/plan/SKILL.md`
  drop their "for the cross-cutting appraisal … use /priorities" paragraphs;
  `.claude/skills/matter/SKILL.md` drops the "matters-only slice of
  /priorities" deferral (lines 84–87);
  `.claude/skills/create-pull-request/SKILL.md:162` rewords "already filed
  where `/priorities` reads" to the filed artifacts themselves (the register,
  the backlog, `/issue`, `/plan`).
- Policies, then `mix brain.contract`: `meta/policy/skills-registry.md`
  (remove the `/priorities` entry; recast the `/issue`/`/plan` glosses),
  `meta/policy/concerns-block-the-close.md:50` ("the artifact `/priorities`
  reads" → the filed artifact the listing skills read),
  `meta/policy/governance-artifact-routing.md:55` (drop `/priorities` from the
  discovery list), `meta/policy/index.md` glosses.
- Docs: `README.md:51–54` usage paragraph; `meta/index.md:51–53` task listing;
  `meta/tutorials/index.md` entry removal;
  `meta/tutorials/the-tooling-architecture.md` SessionInit bullet;
  `meta/tutorials/sessionstart-hook-and-the-local-gate-in-a-fresh-sandbox.md:48`.
- Glossary: `beliefs/glossary/session-init-digest.md` rewritten as the
  historical record on the [todo-type](/beliefs/glossary/todo-type.md) pattern
  (id kept; excerpt log untouched); `beliefs/glossary/recitation.md:33–35`
  re-anchored to the queue surfaces;
  `beliefs/glossary/sessionstart-hook.md:20`'s "emit a session-init digest"
  example recast; `beliefs/glossary/index.md` gloss follows its entry.
- Evals: `meta/evals/priorities-recitation-vs-harness-reminders.md` and its
  `meta/evals/index.md` gloss re-anchored per open question 3;
  `meta/matters/build-the-two-proposed-eval-instruments.md`'s "Done when"
  loses its "/priorities source" clause.
- Threads, routing layer only: drop the `lib/elixir_mind/session_init.ex` path
  ref from the tagged regions of
  `2026-07-11-session-init-digest-and-priorities`,
  `2026-07-11-deprecated-directory-triage-and-machinery-deletion`,
  `2026-07-12-priorities-skill-and-persistence-listers`,
  `2026-07-12-docs-audit-wiki-verdict-and-freshness-warnings`,
  `2026-07-13-elixir-mind-rename-plan-and-model-orchestration`,
  `2026-08-02-todo-fold-into-matters`; run
  `mix brain.route_tags --materialize`.
- **Exempt, deliberately:** thread prose, plans and analyses narrating
  session_init historically ([living-text](/meta/policy/living-text-is-present-tense.md)
  exempts records historical by construction), `journal/`, quoted material in
  `beliefs/future-beliefs.md` and excerpt logs, and the generated
  `meta/registry.md` / `meta/dev-history.md`.
- **Done-check:** grepping `session_init|/priorities` over the repo hits only
  the exempt record layers above, and the full gate suite is green — the
  sweep's completeness oracle, so the list here does not have to be trusted.

## Cross-plan amendments (ride M2; accepting this plan ratifies them)

- **[reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md)**
  (in-progress): step 3's "switch" — "Delete `dangling_strands/1` and its
  digest section … update `/priorities` to describe three sources" — transfers
  to M2 and widens to the full retirement; its description and the
  "Not a `/priorities` rewrite" scope line (both pre-register, 2026-07-28) are
  updated to point here. Steps 2, 4, 5 unchanged.
- **[matter-cli-and-neovim-surface](/meta/plans/matter-cli-and-neovim-surface.md)**
  (proposed): the SessionInit delegation step, diff rows, and anchors drop at
  its refresh; `ElixirMind.Matters` now exists (verifier + `queue_positions/1`),
  so its module step starts from the live file.
- **[post-action-readback-in-the-development-flow](/meta/plans/post-action-readback-in-the-development-flow.md)**
  (proposed): its "no digest for N days" line loses its host; an anchor note
  records that the out-of-run freshness check needs a new home when that plan
  refreshes — re-homing it is that plan's decision, not this one's.
- **[complete-docs-rewrite](/meta/plans/complete-docs-rewrite.md)** (proposed):
  no dependency either way — M2's doc edits are corrective re-points that land
  with the retirement; the rewrite later passes over whatever text is current.

## Build order

0. **External gate — the reconcile plan's step 2 lands first.** That plan's
   constraint is verbatim: "The sequencing constraint is absolute: sweep
   before switch" — deleting the scan before the ledger backfill removes the
   only aggregate view of unswept strands. Pending rows have grown 89 → 143
   since its 2026-07-28 sweep, so step 2 includes a top-up disposition of
   post-sweep threads. Not emitted by this plan; M2 records it as a blocker.
1. **[M1 — sweep the todo-fold remnants](/meta/matters/sweep-todo-fold-remnants.md)**
   (independent, unblocked): the enumerated stale strings; mechanical, no
   decisions. Overlaps M2 only at README/tooling-architecture lines M2
   rewrites anyway — either order lands clean.
2. **[M2 — retire /priorities and mix brain.session_init](/meta/matters/retire-priorities-and-session-init.md)**
   (this plan, order 1; blocked on step 0): one PR carrying the deletions, the
   re-point sweep, the cross-plan amendments, contract + code-map
   regeneration, and the route-tag trim + re-materialization.

## Decisions, alternatives, open questions

**Decided (recommended shape):**

1. **Retire wholesale; do not thin.** Rejected: re-weighting the top-3 to be
   register-aware (a derived ranking beside the authored queue is the defect,
   whatever the weights); thinning session_init to an unranked cross-lister
   (three listing skills already cover the slices, and the matter-CLI plan
   already defers exactly this generalization — "generalizing before a second
   consumer exists would be designing against a guess"); keeping the digest as
   a strand-only lister until the reconcile plan's step 2 (an interim stub PR
   that step 2 immediately obsoletes — sequencing M2 behind it costs nothing
   and builds nothing twice).
2. **Freshness warnings stay with the gates**; rejected: appending them to
   `/matter list` (tree hygiene muddying the queue view).
3. **`queue_positions/1` survives** as public API with no live caller, rather
   than deleting and having the matter-CLI plan rebuild it.
4. **The glossary concept is rewritten, not deleted** — em:6f2442 becomes the
   historical record of the surface and its retirement, the todo-type pattern.

**Open questions (operator):**

1. **Tutorial disposition.** Delete `the-session-init-digest.md`
   (recommended — git is the archive, and the todo fold deleted the `/todo`
   skill outright) vs move under `deprecated/`.
2. **Hook pointer text.** "run /matter list to review the queue"
   (recommended) vs dropping the pointer line entirely.
3. **The recitation eval.** Re-anchor
   `priorities-recitation-vs-harness-reminders` to queue recitation — the
   register head and `/matter list` — (recommended: the question outlives the
   instrument) vs marking it superseded with the instrument.
