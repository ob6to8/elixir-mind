---
type: analysis
title: "The plan corpus audited against HEAD and the matter queue (2026-08-02)"
description: Audits all 59 plans against the repo at 4d008ee and the matter register's direction of travel — the plans third of the review program's session 5 — finding two accepted plans verifiably executed and due to flip done, 25 active plans needing refresh, and none retiring outright; the corpus-level defects are structural — pre-2026-08 plans are not wired to the matter queue, the todo retirement left its vocabulary in eleven active plans, one attribution question now spans seven artifacts on two axes, and index glosses drift systemically. Corrected at the 684530d merge, which grew the corpus to 64 plans and the register to 21 rows.
provenance: "Claude Fable 5, 12-subagent cluster evaluation with in-session synthesis and spot verification"
tags: [meta, analysis, plans, audit, drift, matters, governance]
timestamp: 2026-08-03
attribution:
  when: 2026-08-02T18:15:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-commissioned plan-corpus audit session"
  why: "the operator commissioned a comprehensive audit of every plan against the repo and the matter list — delivering the plans third of the review program's session 5, the governance backlog audit"
  from: [/meta/threads/2026-08-03-plan-corpus-audit.md]
---

# The plan corpus audited against HEAD and the matter queue

## The question

Operator-raised, verbatim: "go through and do a comprehensive plan audit. many
have drifted as they were authored previous. some may be moot and should be
retired, some may need to be updated and refactored. consider each plan in the
context of 1. the repo and 2. the current matter list, indicating where the
repo is headed."

This delivers the **plans third of session 5** of the
[comprehensive repo review program](/meta/plans/comprehensive-repo-review-program.md)
— the governance backlog audit the operator ratified 2026-08-01 in place of
decision-queue row 5's bare posture ruling. Session 5's full scope is every
active plan, open issue, and open matter (~65 items at ratification); this
analysis covers the plans and leaves the issue and matter halves to a
following pass.

Corpus at baseline `4d008ee` (2026-08-02): **59 plans** — by frontmatter 23
proposed, 18 accepted/in-progress, 18 done/superseded; the plans index shows
24/17/18 because `reconcile-dangling-ledger-strands` (`in-progress`) is listed
under Proposed, which is finding 9's own subject. Audited against the tree,
the git history, the [matter register](/meta/matters.md) (6 queued rows at the
time), the backlog, and the 8 open issues.

**Corrected at the `684530d` merge (2026-08-03).** Everything above is the
audit as run; `origin/main` then advanced by 73 files and this document was
re-checked against `3802572` rather than left standing on a superseded repo.
No verdict changed and no plan's disposition moved — the merge invalidated
counts, overtook three remedies with work that now exists, and corrected the
framing paragraph above. Corpus at HEAD: **64 plans** (24 proposed, 22
accepted/in-progress, 18 done/superseded); register: **21 queued rows**; open
issues: **9**; open matters: **41** (21 queued, 20 backlog). The five plans
that arrived in the merge —
[decision-queue-matter-sequence](/meta/plans/decision-queue-matter-sequence.md),
[separate-the-model-roster-concerns](/meta/plans/separate-the-model-roster-concerns.md),
[model-column-in-the-matter-register](/meta/plans/model-column-in-the-matter-register.md),
[skill-section-vocabulary](/meta/plans/skill-section-vocabulary.md) (all
accepted) and [complete-docs-rewrite](/meta/plans/complete-docs-rewrite.md)
(proposed) — are **not evaluated here**; they postdate the audit and are
structured by construction. Each finding below carries its correction inline.

**Cite matters by name, never by register row.** Row numbers renumber on every
delivery — the audit's original row citations went stale within a day, and
[derive the register's row numbering](/meta/matters/derive-the-register-row-numbering.md)
exists to make the serial derived for exactly that reason.

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
below were re-counted where a verdict rests on them; at `3802572` they are
**582** glossary files with `verified: false`, exactly **3** bundle
`type: concept` docs with `verified: true`, **169** thread docs, and **19**
remote `claude/*` heads. (The audit's own thread count was wrong when written
— 160 against an actual 163 — which is why the re-count is stated at HEAD
rather than carried forward.)

## Verdicts

No plan retires outright: every active plan still names wanted, unshipped
work or is the load-bearing home of a standing verdict. The corpus's problem
is not mootness — it is that **two finished plans still read as open, and 25
of the 41 active plans describe a repo that has since moved under them**.
(41 active at the audit's baseline; 46 at HEAD, the five additions being the
unevaluated merge arrivals named above.)

### Executed but never flipped — mark `done` (2)

| Plan | Evidence |
|---|---|
| [bookmarks-survey-tier](/meta/plans/bookmarks-survey-tier.md) (`accepted`) | Build order's own heading says "all complete in this session"; `survey/bookmarks.md` (2,936 lines, 714 surveyed rows), `/bookmarks` skill, and the link-processing carve-out all live; only the explicitly Deferred items (sharding, `mix brain.bookmarks`, bulk-promote) are unbuilt, and deferred phases stay inside a done doc per [persist-plans](/meta/policy/persist-plans.md) |
| [glossary-single-overview-and-dedup-check](/meta/plans/glossary-single-overview-and-dedup-check.md) (`accepted`) | Index gloss says "Executed this session"; `ElixirMind.Glossary` + `mix brain.glossary` wired in CI (`ci.yml:58`), pre-commit, and deploy; the verifier has gated glossary growth 234 → 582 terms since; Deferred section says "None" |

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
(coherent with its queued implementation matter in both directions),
[two-level-agent-methodology-guidance](/meta/plans/two-level-agent-methodology-guidance.md)
(fully current; its remaining build step, the vendor-block pilot, was a queued
row at the audit and sits in the backlog after the 2026-08-03 register audit),
[policy-canonical-skill-guidance](/meta/plans/policy-canonical-skill-guidance.md)
(zero `canonical:` markers exist; sweep scope grew ~15 → 18 skills),
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
  issue); the queued
  [dev-history recommit](/meta/matters/dev-history-recommit-and-regeneration-fold-in.md)
  will change the arrangement again, so the gloss fix should ride that
  landing.
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

**1. Pre-2026-08 plans are not wired into the matter system — the audit's
largest structural finding, and the merge sharpened it.** The matter register
is the delivery queue (`/matter` consumes top-down), yet the
operator-designated top priority (compile-skills-registry, `priority: 1`,
pinned by `session_init.ex`) has no register row and no backlog matter — it
surfaces in `meta/matters/` only as a cross-reference inside two unrelated
matters. Neither does any *pre-2026-08* accepted-but-unexecuted plan (the mind
rename, the separation program's Phase 1, tag-governance step 2, span
phase 1, concept-terminology execution).

The gap is a legacy one rather than a design one, which the merge
demonstrates: since 2026-08-01 every plan filed through
[`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md) emits
matters by construction — five plans account for 14 of the register's 21 rows
— while every plan predating the skill still carries a build order that
emitted nothing. So the mechanism works and was simply never applied
backward. A session consuming `/matter` top-down now delivers **21** queued
rows before touching the operator's stated #1; two ranking surfaces, nothing
reconciling them.

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

**3. One attribution question, seven artifacts, and now two axes — the
audit's recommendation is already carried by a queued matter.** The
[model-attribution policy](/meta/policy/model-attribution.md) (ratified
2026-07-31, compiled into the contract) puts the *producing* model in
`provenance`; [span-level-attribution](/meta/plans/span-level-attribution.md)
D5/D6 (ratified 2026-08-01) rules the model's one home is `attribution.agent`
and amends that policy at phase 1; the open backlog matter
[ratify-or-reject-provenance-names-producing-model](/meta/matters/ratify-or-reject-provenance-names-producing-model.md)
still recommends rejecting the policy whose ratification (three days after
the matter's underlying todo was written) it never registered; and the review
program's decision-queue row 1 asked enforce-or-retract over the same ground.

Row 1 has since been broken out as the queued matter
[settle model-attribution](/meta/matters/settle-model-attribution.md), whose
own recommendation is exactly the disposition this audit reached — fold into
the span-level migration, absorb the stale sibling matter, route the
index-gloss fix to the
[contract-synchronization sweep](/meta/matters/contract-synchronization-sweep.md).
The audit's Tier-4 recommendation therefore needs no separate ratification.

What that matter does *not* cover is a second axis that arrived 2026-08-02:
`model:`, the **prospective** stamp naming which model should *deliver* a
matter, distinct from `provenance`'s **retrospective** naming of what wrote
the document. It is currently stated in four places at once (the roster, the
type-vocabulary entry, `/matter`, `/scope-unit-of-work`), with
[the model-stamping policy matter](/meta/matters/model-stamping-policy.md) and
[separate-the-model-roster-concerns](/meta/plans/separate-the-model-roster-concerns.md)
scoped to absorb them. That plan's open question 1 records a coupling neither
side owns: if the settle-matter retracts `model-attribution`, the new policy's
prospective/retrospective clause loses its counterpart. And
[an open issue](/meta/issues/model-determination-is-session-dependent.md)
establishes the stamp is session-dependent precisely on the matters where the
tier choice costs most — four independent scoping runs split 3–1 on both
judgment-weighted matters.

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
pair. And a fourth collision arrived with the merge: `ElixirMind.Matters`'s
row shape now has three claimants —
[derive the register's row numbering](/meta/matters/derive-the-register-row-numbering.md)
takes `parse_row/1` from four cells to three,
[the register Model column](/meta/matters/register-model-column-and-agreement-check.md)
takes it to five, and
[matter-cli-and-neovim-surface](/meta/plans/matter-cli-and-neovim-surface.md)
holds a file-tree diff over the same module. The first two name each other
("whichever lands second refreshes its cell arithmetic"); the plan names
neither.

**9. Index-gloss drift is systemic, not policy-index-specific.** The open
issue
[policy-index-glosses-drift-on-policy-edits](/meta/issues/policy-index-glosses-drift-on-policy-edits.md)
names the policy index; this audit found the same failure on the **plans
index** (derived-dev-history's removed gate; flow-lineage's retired
mechanism; compile-skills' §7 — the Skills section is §8; comprehension-audit's
todos; matter-CLI's "new" module; span's D5 keys; one entry filed under the
wrong status section), the **issues index** (post-capture-upkeep gloss says
"none chosen" while the doc records the ratified answer; "triage todo"), and
the **matters index** (rule 9 vs. rule 10 attribution). Every one of these is
still live at `3802572`. The issue's scope should widen from the policy index
to hand-kept index glosses as a class.

The *placement* half is now covered:
[reconcile the plans index against plan status](/meta/matters/gate-plans-index-status-sections.md)
is queued to move the misfiled entries and add a section↔status agreement
check to `ElixirMind.Links`. It is scoped to the plans index and to placement
only — it explicitly leaves the generalization to other status-sectioned
indexes, and it cannot catch a *gloss* that misdescribes a correctly-placed
plan. The merge also widened the defect set it must handle: three entries are
now misfiled rather than one, and `model-column-in-the-matter-register`'s
gloss ends `status: proposed` while its frontmatter reads `accepted` — a
gloss/frontmatter contradiction that is neither a placement error nor in that
matter's table.

**10. Remote-branch reality has outrun most branch-tracking artifacts.** The
transplant residue is stale in two of its three homes — the
[transplant plan](/meta/plans/transplant-surviving-unmerged-branches.md) and
the [orphaned-branches issue](/meta/issues/orphaned-remote-branches-cleanup.md),
both byte-unchanged and both predating the deletions `ls-remote` shows. The
third home corrected itself independently:
[the triage matter](/meta/matters/triage-the-six-kept-unmerged-claude-branches.md)
was re-verified against the remote on 2026-08-03, the last deletion was
operator-ratified, and it records the `403` credential blocker (a session
push credential scoped to its own branch) that leaves the deletion pending —
converging with this audit from the other direction. Beyond that set: **19**
`claude/*` heads exist and **18** fall outside every triage scope (one being
this audit's own session branch), and one —
`claude/agentic-cognitive-bias-mapping-azr322` — name-overlaps the queued
[bias-taxonomy implementation](/meta/matters/two-sided-bias-taxonomy-implementation.md).
Its executor should inspect that branch before filing, or risk the
duplicate-filing failure already open as an issue.

**11. The Pages disposition gates more than its own matter — and the likely
ruling dissolves most of it.** It touches gate-suite item 2 (site crawl),
decision-extraction's compiled view ("a Pages rendering" is mandated),
derived-index-listings §4, repo-map step 5, the site-only dev-history view
(the recommit matter should land first), collection-view-by-date's deferred
sort toggle, the CCA plan's Pages-exclusion step, the visualization
passthrough, three library-cluster surfaces, and the survey tier's deliberate
site inclusion.

But [the matter](/meta/matters/response-resource-links-pages-sunset-revision.md)
is no longer queued — it moved to the backlog at the 2026-08-03 register
audit — and it now carries a third option beside sunset and keep: **freeze**,
deployed and canonical but not further developed, which the operator floated
and the agent recommended, awaiting confirmation. Under a freeze the site
stays live and canonical and *none* of the dependents above needs a
contingency. The sequencing recommendation therefore reduces to getting the
freeze ruling recorded, after which the enumerated dependents are unblocked
rather than re-planned.

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

**How these get filed changed with the merge.** Under
[revision-enters-through-scoping](/meta/policy/revision-enters-through-scoping.md)
and [`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md), a
tier is not something a session can pick up — only a matter is. So each tier
that carries one coherent intent is filed as a matter doc carrying a `model:`
stamp and a `## Model` section; Tier 3 is several separable intents and is a
plan, not a matter. Filing does **not** queue: absent an explicit `sequence`,
these are backlog matters with an optional `priority:`, which is the right
default for audit follow-up. If any is queued it inserts at the **head** —
"Nothing is appended to the tail" — so an item that cannot be ranked above
row 1 stays backlog rather than being tail-parked. Tier 4 is not
matter-shaped at all: those are operator decisions, and two of them are
already carried by existing artifacts and must not be re-filed.

**Tier 1 — factual corrections (one small matter).** Flip the two executed
plans to `done` and move their index entries to the Done section — but
**coordinate with the queued
[plans-index reconciliation](/meta/matters/gate-plans-index-status-sections.md)**,
whose section↔status gate will fail any status change not accompanied by its
index move. That matter already covers relocating
reconcile-dangling-ledger-strands' entry (plus two later misfilings this
audit predates), so that item drops from this tier; it does **not** cover the
frontmatter flips, because both plans' status and placement currently agree —
they are consistently wrong, so the new gate would pass them. What remains
beside the two flips: the stale glosses of finding 9 across the plans,
issues, and matters indexes, plus the `model-column` gloss's
`proposed`/`accepted` contradiction. The gloss half overlaps
[complete-docs-rewrite](/meta/plans/complete-docs-rewrite.md)'s in-scope
index-gloss pass, which is sequenced behind the decision-queue matters —
these are factual corrections rather than that plan's coherence rewrite, and
making them now does not pre-empt it.

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

1. **Matter-system wiring** (finding 1): emit matters for the *pre-2026-08*
   accepted plans' next build steps — at minimum the operator's priority-1
   compile-skills-registry — or explicitly re-rank. `/scope-unit-of-work`
   already answers this forward for every newly-scoped unit; what is
   unanswered is backward, for the ~20 accepted and in-progress plans that
   predate the skill and emitted nothing.
2. **Model-attribution reconciliation** (finding 3): **already queued** as
   [settle model-attribution](/meta/matters/settle-model-attribution.md),
   carrying this audit's recommendation (span D5/D6 controls; absorb the
   stale sibling matter; route the gloss fix to the sync sweep). No
   ratification needed here — the open item it does not cover is the
   prospective `model:` axis and the coupling flagged in
   separate-the-model-roster-concerns' open question 1.
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
7. **Rule the Pages disposition** (finding 11): the matter is in the backlog,
   not the queue, and the live option is **freeze** (deployed and canonical,
   not further developed) — recommended, since it dissolves every dependent
   contingency rather than resolving them one by one. Record the ruling, then
   land the dev-history recommit before or with it.

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
  (PR #223) and strike its delivered items from session 4 (both still absent
  at HEAD); the surviving `/meta/todos/` path, which the merge moved from
  line 180 to line 238; annotate decision-queue row 1 with the 2026-07-31
  ratification and finding 3. The row-5 item is **superseded** — row 5 was
  resolved 2026-08-01 by ratifying session 5 (the governance backlog audit)
  in its place, and this analysis is that session's plans third.
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
