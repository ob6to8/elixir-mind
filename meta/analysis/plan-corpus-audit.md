---
type: analysis
title: "The plan corpus audited against HEAD and the matter queue (2026-08-02)"
description: Audits all 59 plans against the repo at 4d008ee and the matter register's direction of travel — two accepted plans are verifiably executed and flip to done, 25 active plans need refresh (none retires outright), and the corpus-level defects are structural — the matter system is not wired to the plan backlog, the todo retirement left its vocabulary in eleven active plans, one attribution question has four artifacts giving three answers, and index glosses drift systemically.
provenance: "Claude Fable 5, 12-subagent cluster evaluation with in-session synthesis and spot verification"
tags: [meta, analysis, plans, audit, drift, matters, governance]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T12:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-commissioned plan-corpus audit session"
  why: "the operator commissioned a comprehensive audit of every plan against the repo and the matter list — the review program's decision-queue row 5 (plan-backlog triage), executed"
---

# The plan corpus audited against HEAD and the matter queue

## The question

Operator-raised, verbatim: "go through and do a comprehensive plan audit. many
have drifted as they were authored previous. some may be moot and should be
retired, some may need to be updated and refactored. consider each plan in the
context of 1. the repo and 2. the current matter list, indicating where the
repo is headed."

This executes decision-queue row 5 of the
[comprehensive repo review program](/meta/plans/comprehensive-repo-review-program.md)
(plan-backlog triage). Corpus at baseline `4d008ee` (2026-08-02): **59 plans**
— 24 proposed, 17 accepted/in-progress, 18 done/superseded — audited against
the tree, the git history, the [matter register](/meta/matters.md) (6 queued
rows), the ~25-matter backlog, and the 8 open issues.

## Method and scope

Twelve cluster evaluators (subagent fan-out, plans grouped by subsystem so
cross-plan supersession is visible inside one context) evaluated every plan
against artifacts — file existence, `git log`, register/backlog/issue
cross-reference — with instructions to distrust each plan's own status line
and index gloss. Every record-rewriting recommendation (mark-done,
mark-superseded, fold) was routed to an adversarial verifier instructed to
refute it; the two such verdicts produced (both mark-done) lost their
verifiers to a session usage limit, and both were re-verified in this session
directly against the tree: the survey register and `/bookmarks` skill exist
and carry 714 surveyed rows, and `mix brain.glossary` exists, is wired at
`ci.yml:58` and `.githooks/pre-commit:32`, and runs green.

Scope caveats. The checkout is a shallow clone (history bottoms out around
PRs #126–#127, 2026-07-22): artifact-existence claims are against the full
tree and unaffected; claims about earlier PRs rest on thread `pr:` stamps and
in-tree artifacts rather than reachable merge commits. Census figures quoted
below were re-counted in this session where a verdict rests on them (577
glossary files with `verified: false`; exactly 3 bundle `type: concept` docs
with `verified: true`; 160 thread docs; 14 remote `claude/*` heads).

## Verdicts

No plan retires outright: every active plan still names wanted, unshipped
work or is the load-bearing home of a standing verdict. The corpus's problem
is not mootness — it is that **two finished plans still read as open, and 25
of the 41 active plans describe a repo that has since moved under them**.

### Executed but never flipped — mark `done` (2)

| Plan | Evidence |
|---|---|
| [bookmarks-survey-tier](/meta/plans/bookmarks-survey-tier.md) (`accepted`) | Build order's own heading says "all complete in this session"; `survey/bookmarks.md` (2,936 lines, 714 surveyed rows), `/bookmarks` skill, and the link-processing carve-out all live; only the explicitly Deferred items (sharding, `mix brain.bookmarks`, bulk-promote) are unbuilt, and deferred phases stay inside a done doc per [persist-plans](/meta/policy/persist-plans.md) |
| [glossary-single-overview-and-dedup-check](/meta/plans/glossary-single-overview-and-dedup-check.md) (`accepted`) | Index gloss says "Executed this session"; `ElixirMind.Glossary` + `mix brain.glossary` wired in CI (`ci.yml:58`), pre-commit, and deploy; the verifier has gated glossary growth 234 → 577 terms since; Deferred section says "None" |

Left `accepted`, both count as open work to `/plan` and `/priorities` — the
close-out flow that should flip a status at execution missed both.

### Active and sound — keep as-is (14)

[frontmatter-parser-profile-rewrite](/meta/plans/frontmatter-parser-profile-rewrite.md)
(anchors exact to the line; leverage has *grown* — see finding 5),
[schema-formalization-and-evaluator-lane](/meta/plans/schema-formalization-and-evaluator-lane.md),
[tag-governance](/meta/plans/tag-governance.md) (step 2's preferred
style-fingerprint vehicle stalled; its own standalone-`brain.tags` fallback is
the live path),
[two-sided-bias-taxonomy-and-compendium](/meta/plans/two-sided-bias-taxonomy-and-compendium.md)
(coherent with queue row 4 in both directions),
[two-level-agent-methodology-guidance](/meta/plans/two-level-agent-methodology-guidance.md)
(fully current; remainder queue-tracked as row 6),
[policy-canonical-skill-guidance](/meta/plans/policy-canonical-skill-guidance.md)
(zero `canonical:` markers exist; sweep scope grew ~15 → 17 skills),
[extract-into-belief-skill](/meta/plans/extract-into-belief-skill.md)
(the motion it mechanizes keeps recurring by hand — 16 belief docs now),
[three-level-documentation](/meta/plans/three-level-documentation.md)
(unexecuted while unratified plain-tier variants leak into new docs — three
non-blockquote forms observed; execution urgency rising),
[retrofit-plans-to-structured-bodies](/meta/plans/retrofit-plans-to-structured-bodies.md)
(one target retrofitted since authoring; its own step-1 refresh absorbs the
table staleness),
[post-action-readback-in-the-development-flow](/meta/plans/post-action-readback-in-the-development-flow.md)
(unusually anchor-sound — every quoted premise still holds verbatim),
[build-the-fetch-fidelity-probe](/meta/plans/build-the-fetch-fidelity-probe.md),
[auto-intake-escape-rate-sampling](/meta/plans/auto-intake-escape-rate-sampling.md)
(stake risen: tag-governance rides its rider, and the live
[model-attribution](/meta/policy/model-attribution.md) policy cites it),
[source-hash-and-drift-detection](/meta/plans/source-hash-and-drift-detection.md)
(one day old; one retired-vocabulary word),
[belief-decomposition-analysis-mode](/meta/plans/belief-decomposition-analysis-mode.md)
(intact; the advisory evaluator lane is a new delivery-surface option it
predates).

### Active, needs refresh (25)

Grouped by what the refresh substantively is; per-plan detail in the appendix.

**Invalidated or contradicted by later ratifications — refresh before any
execution:**

- [concept-terminology-and-type-redefinition](/meta/plans/concept-terminology-and-type-redefinition.md)
  — census stale in a scope-affecting way: the ratified sweep says ~234
  glossary `verified: false` fields, the corpus holds 577 (+ ~16 non-glossary
  concepts); "the one graduated doc" is now **three** `verified: true`
  concepts, two of which (`em:d5ca81`, `em:b50c01`) carry `verified_by`
  evidence edges the prescribed retype would silently discard — their
  disposition needs prescribing, not assuming.
- [epistemic-overlay](/meta/plans/epistemic-overlay.md) — Q1's role-derivation
  map derives "inference" from "a `verified` `concept`/`claim`", which the
  concept-terminology ratification makes illegal (`verified` becomes an error
  on `concept`); span-level-attribution D4 adds a second machine-owned edge
  family (`derived_from`) its `mix brain.graph` must read or bound out; the
  `depends_on` census doubled (2 → 4 edges).
- [structural-link-integrity](/meta/plans/structural-link-integrity.md) —
  overtaken four hours after filing: PR #216 split the Links family it models
  and hard-gated half of it (`unlisted_errors/1`, verifier rule 10), so its
  current-state tree names a function that no longer exists and its "Links
  detects, task decides severity" boundary is contradicted by shipped
  precedent.
- [gate-suite-hardening-review-depth](/meta/plans/gate-suite-hardening-review-depth.md)
  — item 1(b)'s "breaks the offline invariant — a real tradeoff" framing was
  adjudicated by the ratified advisory evaluator lane (schema-formalization
  D7); item 2 (site crawl) is contingent on the Pages-sunset ruling; item 3's
  blank banned-word list predates the live banned-phrases register.
- [decision-extraction-and-compiled-decision-graph](/meta/plans/decision-extraction-and-compiled-decision-graph.md)
  — mandates a Pages rendering while the sunset question is open; its scope
  boundary anchors the ledger's four columns while
  reconcile-dangling-ledger-strands is removing two of them; backfill census
  4× stale (~40 → 160 threads).

**Premise moved under them — refresh plus an operator call (finding 6/7):**

- [rename-brain-tasks-to-mind](/meta/plans/rename-brain-tasks-to-mind.md) —
  ratified on "the repo's identity is mind"; the 2026-07-28 naming reversal
  (library takes **elixir-mind**, this repo becomes **knowledge** at
  spin-out) undercut that premise the next day; task surface grew (18
  `brain.*` tasks incl. `brain.matters`); unqueued.
- [thin-jido-brain-host](/meta/plans/thin-jido-brain-host.md) and
  [inkling-beam-swarm-eval-harness](/meta/plans/inkling-beam-swarm-eval-harness.md)
  — both external-system plans now sit where the
  [project-namespace policy](/meta/policy/project-namespace.md) (ratified
  after their filing) says a `projects/<slug>/` hub belongs; neither gating
  trigger has fired (the `/research` issue still has a live cheap-fix path;
  the dedup baseline is flat), and the Jido plan is the load-bearing home of
  a thrice-reaffirmed "not now".
- [raise-elixir-otp-toolchain-floor](/meta/plans/raise-elixir-otp-toolchain-floor.md)
  — its "Nothing currently needs the raise" deferral premise is now false:
  the accepted evaluator lane and the matter-CLI's NDJSON encoder both wait
  on the floor. Effective priority rose without the text changing.
- [matter-cli-and-neovim-surface](/meta/plans/matter-cli-and-neovim-surface.md)
  — its open question 3's name-collision contingency fired as predicted:
  PR #234's verifier claimed `ElixirMind.Matters` and `mix brain.matters`, so
  per the plan's own rule the CLI folds into that task family (subcommands),
  and its "one mechanical reader, private to the digest" problem framing
  predates the public `queue_positions/1` and the `/matter` skill.

**Stale against the matter system or their own delivered work — mechanical
refresh:**

- [reconcile-dangling-ledger-strands](/meta/plans/reconcile-dangling-ledger-strands.md)
  — heaviest todo-vocabulary residue (normative tracker set "plan/todo/issue",
  eleven `[todo]` labels); ledger scope grew 109 → 160+ threads; **misfiled
  in the plans index** (sits under Proposed while `in-progress`).
- [comprehensive-repo-review-program](/meta/plans/comprehensive-repo-review-program.md)
  — under-reports its own delivery: the commissioned fix thread landed
  (PR #223, both issues resolved) but the session ledger, hand-offs, and
  gloss still present it as pending; one `/meta/todos/` path missed by the
  fold's sweep.
- [transplant-surviving-unmerged-branches](/meta/plans/transplant-surviving-unmerged-branches.md)
  — description still says two ports remain; the body records both done, and
  3 of its 4 operator deletions have since happened (sole survivor:
  `claude/git-fetch-merge-skill-ke7adg`, confirmed against `ls-remote`
  2026-08-02). After the truth-refresh this plan is one branch deletion, one
  setting confirmation, and an issue close from `done`.
- [cca-certification-study-program](/meta/plans/cca-certification-study-program.md)
  — hazards specifically for its stated cold-context executor: "still
  unfiled: the exam guide" is false (`em:214aa4` is that capture), and the
  Layer-1 paths as written name new top-level dirs the real tree doesn't have.
- [comprehension-audit](/meta/plans/comprehension-audit.md),
  [council-skill](/meta/plans/council-skill.md),
  [compile-skills-registry-from-skill-frontmatter](/meta/plans/compile-skills-registry-from-skill-frontmatter.md)
  (also: contract §7 → §8 throughout),
  [frontmatter-facet-query](/meta/plans/frontmatter-facet-query.md) (also:
  un-cited overlap with tag-governance's query mode — see finding 8),
  [span-level-attribution](/meta/plans/span-level-attribution.md) (an
  imprecise commit cite; a gloss that misstates ratified D5's keys; the
  contradicting backlog matter unacknowledged),
  [separate-okf-bundle-and-elixir-mind-library](/meta/plans/separate-okf-bundle-and-elixir-mind-library.md),
  [library-spin-out-and-dependency-distribution](/meta/plans/library-spin-out-and-dependency-distribution.md)
  (manifest sketch configures retired `todo`, omits live `matter`/`visualization`),
  [derived-index-listings](/meta/plans/derived-index-listings.md) (PR #70 now
  closed+branch-deleted; the matters index is *deliberately* alphabetical —
  the generator needs a matters-genre rule; index-coverage is now hard-gated),
  [repo-map-and-machinery-reference](/meta/plans/repo-map-and-machinery-reference.md)
  (16 → 18 tasks, rules 1-8 → 1-10, post-plan namespaces),
  [spec-to-code-traceability](/meta/plans/spec-to-code-traceability.md) (nine
  → ten enforcing modules; DevHistory now its own best task-without-gate
  example).

### Historical — done/superseded (18)

All 18 statuses are accurate; the supersession chain matter-queue →
matter-docs reads cleanly in both directions and is the model for future
supersessions. Two carry **stale index glosses** (the doc bodies are correct
historical records and stay untouched):

- [derived-dev-history](/meta/plans/derived-dev-history.md) — gloss still
  advertises "a lag-tolerant `--check` in CI and the pre-commit hook",
  removed 2026-07-28 with the committed copy (per the resolved shallow-clone
  issue); queue row 2 will change the arrangement again, so the gloss fix
  should ride that landing.
- [flow-lineage-index](/meta/plans/flow-lineage-index.md) — gloss still says
  "every flow doc carries a canonical `lineage:` frontmatter block"; that
  mechanism was retired by the resource-attribution plan (derivation now
  reads `attribution.from` + `pr:`), as the plan's own addendum records.
  Adjacent nit: the generated begin-marker text (`lineage.ex:36`) still
  points editors at the retired frontmatter.

The remaining 16:
[matter-docs-architecture](/meta/plans/matter-docs-architecture.md),
[matter-queue-and-present-matters](/meta/plans/matter-queue-and-present-matters.md),
[route-tag-orphan-check-is-dead-code](/meta/plans/route-tag-orphan-check-is-dead-code.md),
[visualization-type-and-local-launch](/meta/plans/visualization-type-and-local-launch.md),
[belief-type-and-beliefs-namespace](/meta/plans/belief-type-and-beliefs-namespace.md),
[code-tutorial-and-code-map](/meta/plans/code-tutorial-and-code-map.md),
[collection-view-by-date](/meta/plans/collection-view-by-date.md),
[resource-attribution-property](/meta/plans/resource-attribution-property.md),
[glossary-sense-disambiguation](/meta/plans/glossary-sense-disambiguation.md),
[derived-dev-history](/meta/plans/derived-dev-history.md) (body),
[rename-second-brain-to-elixir-mind](/meta/plans/rename-second-brain-to-elixir-mind.md),
[auto-intake-featured-research](/meta/plans/auto-intake-featured-research.md),
[code-review-toolchain-hardening](/meta/plans/code-review-toolchain-hardening.md),
[dedup-recall-probe](/meta/plans/dedup-recall-probe.md),
[retire-hand-kept-logs](/meta/plans/retire-hand-kept-logs.md),
[research-daily-read-synthesis](/meta/plans/research-daily-read-synthesis.md),
[flows-genre-and-scenario-testing](/meta/plans/flows-genre-and-scenario-testing.md).

## Corpus-level findings

**1. The plan corpus is not wired into the matter system — the audit's
largest structural finding.** The matter register is now the delivery queue
(`/matter` consumes top-down), yet the operator-designated top priority
(compile-skills-registry, `priority: 1`, pinned by `session_init.ex`) has no
register row and no backlog matter; neither does any accepted-but-unexecuted
plan (the mind rename, the separation program's Phase 1, tag-governance
step 2, span phase 1, concept-terminology execution). Every pre-2026-08 plan
carries a build order that emitted no matter docs. A session consuming
`/matter` top-down delivers all six queued rows before touching the
operator's stated #1 — two ranking surfaces, nothing reconciling them.

**2. The todo retirement left its vocabulary in eleven active plans.** The
fold (PRs #229–#234) repointed links mechanically but left prose: a routing
table that files findings into a retired type
(comprehension-audit), a normative tracker set "plan/todo/issue"
(reconcile-dangling-ledger-strands, five lines plus eleven labels), a
manifest sketch that would configure `todo` and reject `matter`
(library-spin-out), skill-binding and build-order references
(council-skill:58, compile-skills-registry:88, facet-query's open question 3,
separate-okf-bundle's boundary table, source-hash, gate-suite-hardening,
comprehensive-repo-review:180). One mechanical sweep closes the class.

**3. One attribution question, four artifacts, three answers.** The
[model-attribution policy](/meta/policy/model-attribution.md) (ratified
2026-07-31, compiled into the contract) puts the model in `provenance`;
[span-level-attribution](/meta/plans/span-level-attribution.md) D5/D6
(ratified 2026-08-01) rules the model's one home is `attribution.agent` and
amends that policy at phase 1; the open backlog matter
[ratify-or-reject-provenance-names-producing-model](/meta/matters/ratify-or-reject-provenance-names-producing-model.md)
still recommends rejecting the policy whose ratification (three days after
the matter's underlying todo was written) it never registered; and the review
program's decision-queue row 1 asks enforce-or-retract over the same ground.
The most recent operator ratification (span D5/D6) should control: cancel or
repoint the matter, close row 1 by reference, amend the policy at span
phase 1 as planned.

**4. The 2026-08-01 ratification wave is internally consistent but ratified
over stale censuses.** The build-order chain (span phase 1 →
schema-formalization phase 2 → concept-terminology execution; toolchain floor
before the evaluator lane) is stated identically on both sides of every pair
— no ordering contradiction anywhere. But concept-terminology was revised
without re-counting (234 → 577 sweep targets; "one graduated doc" was already
three), and the structured-plan-bodies refresh rule covers *anchors at
execution*, not *censuses at ratification* — a gap worth one sentence in that
policy when next touched.

**5. The frontmatter parser rewrite is the corpus's highest-leverage
unratified plan.** Still `proposed`, yet span-attribution phase 1 prefers its
`Frontmatter.dump/1` for the widest frontmatter sweep since the id migration,
and the matter-CLI's mutate half is hard-blocked on it. Executing the span
sweep via the regex fallback and landing the parser later means the parser's
corpus-normalization pass runs over a corpus the sweep just rewrote —
sequencing argues for ratifying the parser first.

**6. Two plans conflict with the project-namespace policy ratified after
their filing.** Both external-system plans (Jido host, Inkling harness) sit
in `meta/plans/` where the compiled contract now routes external systems to
`projects/<slug>/` hubs. The Inkling case is clean (an experiment instrument,
not brain tooling); the Jido host genuinely straddles the policy's two
clauses (brain-serving, externally built). Refiling is a shape change either
way — one ratification settles both.

**7. The review-gate space is triple-occupied with no boundary doc.**
council-skill (accepted: heavy, disposition-gated review), gate-suite
hardening 1(b) (proposed: second-model changelist review), and the built,
nowhere-installed cross-model PR-review Action (backlog matter) — none
references the others, and the ratified advisory evaluator lane has since
adjudicated the gating-vs-advisory question 1(b) still presents as open. The
tier boundary (routine diff vs. shape change; advisory vs. operator-invoked)
should be drawn once, in whichever executes first.

**8. Adjacent plans double-claim ground without citing each other.** Schema:
the separation plan's Phase 2 metadata profile vs. the ratified per-key
definitions (schema-formalization). Tag queries: facet-query's `tags~`
(stored tags only) vs. tag-governance's ratified `brain.tags` query mode
(tags ∪ path segments) — same query, different result sets, neither plan
names the other. Policy↔code edges, three ways: `@enforces` (spec-to-code,
module→policy), `implemented_by` (three-level-documentation, policy→code),
`canonical:` (policy-canonical, skill→policy) — three half-edge designs that
want one shared decision. Extraction/judging machinery: three artifacts each
specify an extract-statements-and-LLM-judge component (belief-decomposition,
span OQ1, schema tier 3) with a sharing requirement recorded only for one
pair.

**9. Index-gloss drift is systemic, not policy-index-specific.** The open
issue
[policy-index-glosses-drift-on-policy-edits](/meta/issues/policy-index-glosses-drift-on-policy-edits.md)
names the policy index; this audit found the same failure on the **plans
index** (derived-dev-history's removed gate; flow-lineage's retired
mechanism; compile-skills' §7; comprehension-audit's todos; matter-CLI's
"new" module; span's D5 keys; one entry filed under the wrong status
section), the **issues index** (post-capture-upkeep gloss says "none chosen"
while the doc records the ratified answer; "triage todo"), and the **matters
index** (rule 9 vs. rule 10 attribution). The issue's scope should widen from
the policy index to hand-kept index glosses as a class.

**10. Remote-branch reality has outrun every branch-tracking artifact.** The
transplant residue is stale identically in its three homes (plan, triage
matter, orphaned-branches issue — all predate the deletions `ls-remote` now
shows). Beyond them: 14 `claude/*` heads exist, 13 outside every triage
scope, and one — `claude/agentic-cognitive-bias-mapping-azr322` — name-overlaps
queued matter row 4 (bias-taxonomy implementation). The row-4 executor should
inspect that branch before filing, or risk the duplicate-filing failure
already open as an issue.

**11. The Pages-sunset question (queue row 3) gates more than its own
matter.** It touches gate-suite item 2 (site crawl), decision-extraction's
compiled view ("a Pages rendering" is mandated), derived-index-listings §4,
repo-map step 5, the site-only dev-history view (recommit matter, row 2,
should land first), collection-view-by-date's deferred sort toggle, the CCA
plan's Pages-exclusion step, the visualization passthrough, three library-
cluster surfaces, and the survey tier's deliberate site inclusion. The sunset
ruling should precede ratification of the plans that lean on the site.

**12. Sequencing: this triage precedes the retrofit sweep.** The accepted
[retrofit-plans-to-structured-bodies](/meta/plans/retrofit-plans-to-structured-bodies.md)
sweep is the natural vehicle for most body refreshes above — and running it
*after* triage means it formats only the surviving, corrected corpus. Its
target table already needs the step-1 refresh its own design anticipates
(one target since retrofitted; two targets now flipping done).

## The recommended program

Nothing below is executed by this audit; each tier is a separable matter for
ratification, sized to fit review per
[atomic pull requests](/meta/policy/git-atomic-pull-requests.md).

**Tier 1 — factual corrections (one small matter).** Flip the two executed
plans to `done` (move to the index's Done section); move
reconcile-dangling-ledger-strands' index entry to Accepted/In progress; fix
the stale glosses enumerated in finding 9 (plans, issues, and matters
indexes). Nothing here needs design judgment; every item is evidence-backed
above.

**Tier 2 — the de-todo sweep (one mechanical matter).** Replace retired
`todo` vocabulary across the eleven active plans of finding 2 with
`matter`/`meta/matters/` per
[governance-artifact-routing](/meta/policy/governance-artifact-routing.md),
including reconcile's normative tracker set and library-spin-out's manifest
sketch.

**Tier 3 — substantive per-plan refreshes.** Route by vehicle: (a) plans
whose stale text misleads a cold reader *now* — concept-terminology's census
and three-doc disposition, transplant's contradicted description,
comprehensive-repo-review's missing ledger row, the CCA cold-handoff hazards
— warrant small standalone matters; (b) the rest ride either the retrofit
sweep (finding 12) or each plan's own execution-start refresh per
[structured-plan-bodies](/meta/policy/structured-plan-bodies.md). This
audit's appendix carries the per-plan edit lists so any vehicle can execute
without re-deriving.

**Tier 4 — operator decisions surfaced (blocking their plans, not each
other):**

1. **Matter-system wiring** (finding 1): emit matters for the accepted
   plans' next build steps — at minimum the operator's priority-1
   compile-skills-registry — or explicitly re-rank; and decide whether an
   accepted plan's first build step should *always* emit a matter, so
   accepted work is never invisible to `/matter`.
2. **Model-attribution reconciliation** (finding 3): recommended — span
   D5/D6 controls; cancel/repoint the stale matter; close decision-queue
   row 1 by reference.
3. **Parser-first sequencing** (finding 5): recommended — ratify
   frontmatter-parser-profile-rewrite and land `dump/1` before span phase 1's
   corpus sweep.
4. **External-harness address** (finding 6): recommended — refile both under
   `projects/` with `status: incubating` hubs; the plans move beside their
   hubs unchanged.
5. **mind.\* rename** : reconfirm against the 2026-07-28 naming reversal and
   fix sequencing vs. the spin-out (its Q7); recommended — keep, re-anchored
   (`mind.*` aligns with the library keeping the elixir-mind name), executed
   before extraction.
6. **Review-gate boundary** (finding 7): recommended — advisory-lane CI
   review per the ratified precedent; gate-suite 1(b) reframes to advisory
   with the cross-model Action as implementation candidate; `/council`
   scoped to operator-invoked shape-change review.
7. **Pages sunset first** (finding 11): already queue row 3; the
   recommendation here is only sequencing — rule it before ratifying the
   plans that lean on the site, and land the dev-history recommit (row 2)
   before or with it.

## Appendix — per-plan refresh dossiers

Condensed from the evaluator reports; each list is the concrete edit set a
refresh session (or the retrofit sweep) executes. Line references are to the
plan named.

- **matter-cli-and-neovim-surface** — file-tree diff: `matters.ex` becomes
  `# MODIFIED` (gains `list/get/create/to_ndjson` beside the verifier's
  `run_checks/1`, `queue_positions/1`); resolve OQ3 per its own rule: the CLI
  lands as `mix brain.matters` subcommands (`list|show|new`, bare = verify);
  re-anchor the absorbed queue-position parse (`queue_positions/1`, already
  public); recast the problem section around the existing `/matter` skill;
  anchor `create/1` on the skill's Create template + `brain.matters` checks
  2-3; fix the index gloss. Phase-2 (`set_status/2`) stays blocked on
  `Frontmatter.dump/1` — unchanged.
- **matter-disjointness-check-for-parallel-filing** — swap the
  `meta/todos/` worked examples for `meta/matters/` paths; note the matter
  system *raised* its value (deferred-work-is-filed multiplies same-day
  governance filings); cross-reference the fan-out-convention backlog matter
  so step 3 lands in whichever artifact survives that graduation.
- **frontmatter-facet-query** — OQ3: `plan`/`matter`/`issue`/`project` and
  `/plan`, `/matter`, `/issue`; add the boundary decision vs. tag-governance's
  query mode (stored-tags-only vs. tags ∪ path-segments, or scope
  `brain.query` out of tag queries); note `Entry` gained `:launch`; note the
  concept-terminology sweep will hollow the `verified=false` example corpus.
- **span-level-attribution** — worked example: first-add commit is
  `bf91f20`, not `818a885` (recovered model value unaffected); index gloss:
  D5's keys are mode/ref/sources/note (not "model/…" — the gloss misstates
  the exact point the review pass overruled); acknowledge and disposition the
  contradicting backlog matter (finding 3).
- **concept-terminology-and-type-redefinition** — re-census (577 glossary +
  ~16 non-glossary `verified: false` docs; 594 `type: concept` total);
  replace "the one graduated doc retypes" with an enumerated disposition for
  all three `verified: true` concepts — `git-local-branches` retypes as
  ratified; `em:d5ca81` and `em:b50c01` are definition-shaped *with evidence
  edges*: decide retype-to-claim vs. drop-`verified`-keep-prose before the
  sweep discards their `verified_by` silently.
- **separate-okf-bundle / library-spin-out** — boundary table: todos →
  matters; add `survey/`, `journal/`, `projects/` to the namespace rows;
  manifest sketch: drop `todo`, add `matter` + `visualization`; add coupling
  rows for the matters machinery, the `:launch` rule, and the index-coverage
  gate; cross-reference schema-formalization on the Phase-2 profile (compiled
  from the per-key definitions, or superseding them); Pages-sunset
  contingency notes on the site rows; Q5 re-answered against the
  post-concept-terminology statement types.
- **raise-elixir-otp-toolchain-floor** — replace the "nothing needs the
  raise" paragraph with the two named dependents (evaluator lane; NDJSON
  encoder); pages.yml step contingent on the sunset.
- **rename-brain-tasks-to-mind** — re-anchor motivation to the 2026-07-28
  naming outcome; add spin-out Q7's sequencing decision as the pre-execution
  gate; extend the known-surfaces list (`brain.matters` in CI + pre-commit,
  `/matter` skill, `brain.url`, `brain.thread_tail`); note `meta/plans/`
  bodies as a sweep surface or an accepted-stale carve-out.
- **thin-jido-brain-host / inkling-beam-swarm-eval-harness** — record the
  address decision (Tier-4 #4); normalize the Jido seasoning window against
  its source ("another 6–12 months" from 2026-07, not from 2026-02); add the
  accreted related work (declared-cadence instrumentation; the ECS
  fleet-control analysis; the CB eval export as in-bundle prior art).
- **compile-skills-registry-from-skill-frontmatter** — §7 → §8 (or "the
  Skills section — numbering positional from `contract.ex @sections`");
  build-order step 1: issues/matters/plans; present-tense the render-contract
  clause (that instance was fixed by pointing at `@sections`; the live drift
  is the hand-kept registry list).
- **council-skill** — binding 2: deferrals file as `issue` or `matter`;
  binding 4 gains one line (registration follows whatever mechanism is live —
  hand edit today, frontmatter compile once the registry plan lands); add the
  scope-boundary sentence vs. gate-suite 1(b) and the cross-model Action
  (finding 7).
- **comprehension-audit** — routing row "a plain task | `matter`"; the
  description and gloss likewise; refresh the test count if kept.
- **comprehensive-repo-review-program** — add the fix-thread ledger row
  (PR #223) and strike its delivered items from session 4; line 180's
  `/meta/todos/` path; annotate decision-queue row 1 with the 2026-07-31
  ratification and finding 3; row 5 closes by reference to this analysis.
- **gate-suite-hardening-review-depth** — reframe 1(b) onto the advisory
  lane precedent (cite schema-formalization D7; retire the gating variant;
  name the cross-model Action as candidate); item 2 contingent on the sunset,
  with structural-link-integrity covering the source-level half either way;
  item 3 consumes the banned-phrases register as the seed list.
- **derived-index-listings** — §7/step 7: PR #70 is closed, branch deleted;
  port source is its preserved head `67ab3ee`/the PR diff; todos → matters
  *plus* a matters-genre rule respecting the deliberately alphabetical
  matters index (order lives only in the register); state the relationship to
  hard rule 10 (generator subsumes it for generated sections or coexists);
  Pages-contingent nav-sort port.
- **repo-map-and-machinery-reference** — step 1 marked shipped (minus the
  env-var term); 18 tasks, rules 1-10; add `journal/`, `survey/`, the matter
  register + CI gate, and the settings allowlist to the catalog tables;
  step 5's Pages wiring contingent on the sunset.
- **spec-to-code-traceability** — ten enforcing modules (+ Matters);
  DevHistory as the map's own task-without-gate example; Links's hard half
  runs inside verifier rule 10 (schema distinguishes module/task/gate); add a
  gating-vs-advisory lane marker; cross-reference schema-formalization and
  the shared-marker question (finding 8).
- **epistemic-overlay** — dated addendum: re-derive the Q1 role map against
  concept-terminology (inference from verified `claim`/`note`; the
  types-are-pure-content-kinds principle weighs toward an `epistemic:` field
  over overloading `type`); acknowledge `derived_from` (span D4) as a second
  machine-owned edge family; update the `depends_on` census (4 edges, one
  two-hop chain) and note extract-into-belief will mint more while the edge
  key remains ungoverned by any policy, verifier rule, or schema program.
- **decision-extraction-and-compiled-decision-graph** — Pages rendering
  becomes contingent (committed/derived markdown first); re-anchor the ledger
  scope boundary to reconcile's Action-column design and state whether a
  minted decision record is a valid Action target; backfill census 160
  threads; sequence ratification after the sunset ruling.
- **reconcile-dangling-ledger-strands** — the todo sweep (description,
  lines 34/47/97/137/153, eleven labels, both index glosses); step 2's count
  re-derived at execution (160+ at HEAD); move the index entry to the right
  section; state the relationship to decision-extraction's Q4 before either
  advances.
- **structural-link-integrity** — re-derive the current-state tree
  (`link_warnings/2` + `missing_index_warnings/1`; `unlisted_errors/1`
  already gating via rule 10); recast the "rejected: gating index coverage"
  decision (half-overtaken); revisit the detect/decide boundary against the
  shipped precedent; land move 2 with or after the routes-ref-maintenance
  policy sentence (backlog matter).
- **cca-certification-study-program** — move the exam-guide capture into the
  first-pass table (`em:214aa4`, with `em:bdfa05` beside it); rewrite Layer-1
  paths onto the real tree (`knowledge/SWE/agentic/anthropic/…`); check the
  sunset decision before building the Pages-exclusion step; decide whether
  the remainder emits a matter (it is the only active content program with no
  matter representation).
- **transplant-surviving-unmerged-branches** — description rewritten to the
  true state (ports done 2026-07-13; 3 of 4 deletions executed; survivor
  named); body status line fixed to match frontmatter; steps 2-3 updated;
  then drive to done via the one deletion + setting confirmation + issue
  close, sweeping the same stale text in the triage matter and the
  orphaned-branches issue in the same motion (finding 10).
