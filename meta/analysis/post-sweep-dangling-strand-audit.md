---
type: analysis
title: "Post-sweep dangling-strand audit: escalation state of the 52 pending strands since 2026-07-28"
description: Audits every pending routing-ledger strand in the 27 threads captured on or after the ratified 2026-07-28 sweep against all tracker surfaces (matters register and docs, todos, issues, plans, project docs), plus a body-level pass for unrowed deferrals; finds 44 of 52 already discharged, tracked, project-held, or decision-closed, and eight orphans recommended for escalation (seven todo candidates, one issue candidate) awaiting operator ratification.
provenance: "Claude Fable 5 (orchestration, verification, synthesis); per-strand disposition research by six Claude Sonnet 5 subagents"
tags: [meta, analysis, routing-ledger, matters, work-queue, audit]
timestamp: 2026-08-02T09:50:00Z
attribution:
  when: 2026-08-02T09:50:00Z
  channel: agent-authored
  agent: "Claude Code agent, dangling-items audit session"
  why: "the operator asked for an audit of all threads and route tags for dangling items surfaced in sessions but never escalated into tracked work"
---

# Post-sweep dangling-strand audit

## The question

Which pending routing-ledger strands — and which deferrals named only in thread
bodies — still lack a durable home (a matter, todo, issue, plan, or project
doc), and which of those should escalate into tracked work?

## Corpus and boundary

`ElixirMind.SessionInit.dangling_strands/1` reports **143 pending strands**
across the 161 captured threads (state `open`/`paused`, or `closed` with a
leftover `Dangling` cell), at the audit's HEAD (the merge of PR #231).

- **91 strands across 57 threads predate 2026-07-28** and are covered by the
  ratified step-1 sweep of the
  [reconcile plan](/meta/plans/reconcile-dangling-ledger-strands.md) (its
  appendix holds the dispositions). This audit re-verified that coverage at the
  artifact level: all 12 artifacts the sweep promoted exist and are live — 11
  `open` todos and the `proposed`
  [spec-to-code-traceability plan](/meta/plans/spec-to-code-traceability.md).
  It did not re-litigate the sweep's per-strand judgments, which the operator
  ratified.
- **In scope: the 52 strands across 27 threads dated 2026-07-28 through
  2026-08-02** — the corpus the sweep predates. The matters layer
  ([register](/meta/matters.md) + [`meta/matters/`](/meta/matters/index.md))
  was stood up 2026-08-02, after the sweep, so no prior pass has read these
  strands against it.
- No thread yet uses the reconcile plan's three-column `Action` schema (checked
  by header grep), so the four-column parser sees every ledger.

## Method

Six parallel subagent batches, one per thread-date cluster, each performing for
every strand in its batch: read the row in situ (with surrounding narrative and
thread frontmatter), open the routed-to document and check its status and
content, search every tracker surface for the matter by name and synonym,
and pull git landing evidence (`git log --first-parent`, `-S`) where the
disposition claims work landed. Register references were resolved by **matter
name against the current register**, never by the row number frozen in the
cell (rows shift as matters are consumed). Each batch also ran a body-level
pass over its threads for deferrals named in prose but never given a ledger
row. The orchestrating session then independently re-searched every orphan's
no-tracker negative (keyword sweeps over `meta/todos/`, `meta/issues/`,
`meta/matters.md`, `meta/matters/`, `meta/plans/`, inspecting every hit), and
re-read the quoted spans behind both verdicts the batches flagged as
needing verification.

**Disposition vocabulary** (one per strand):

- `discharged` — the work landed or the event completed; only the frozen cell
  says otherwise. For a session's own "open/merge the PR" rows, the thread
  doc's presence on `main` plus its `pr:` stamp is the proof.
- `tracked-live` — held by an open todo, open issue, active plan
  (proposed/accepted/in-progress), or an open matter doc.
- `decision-closed` — an explicit recorded decision not to codify
  (trigger-not-fired, operator-personal, or speculative), the `none:` class of
  the reconcile plan's sweep.
- `project-held` — carried by a `type: project` hub's or project doc's own
  open-questions/next-steps body (the carve-out the reconcile plan's own open
  question covers).
- `orphan` — live deferred work with no tracker anywhere: the escalation
  candidates.

## Findings

| Disposition | Strands |
|---|---:|
| tracked-live | 24 |
| discharged | 13 |
| project-held | 5 |
| decision-closed | 2 |
| **orphan** | **8** |
| total | 52 |

The dominant failure mode matches the 2026-07-28 sweep's finding exactly:
**staleness, not loss**. A quarter of the pending rows describe work that
already landed — every one of the ten "open/merge the PR" session-mechanics
rows is discharged by its thread's own `pr:` stamp — and nearly half sit on
trackers that already carry their open questions verbatim. The eight orphans
are the remainder that nothing holds.

Full table. Threads live under `/meta/threads/` with the date prefix shown;
the eight orphans are detailed in the next section.

| # | Thread | Topic | State | Disposition | Held at / evidence |
|---|---|---|---|---|---|
| 1 | `08-02-deferred-work-policy…` | Matters-vs-plans definition question | open | discharged | [Consumed log](/meta/matters.md), PR #228; [matters-vs-plans](/meta/analysis/matters-vs-plans.md) |
| 2 | `08-02-deferred-work-policy…` | `/matter` consumption skill | open | tracked-live | [matter-skill](/meta/matters/matter-skill.md) (open; register row 2) |
| 3 | `08-01-terse-brain-evaluation…` | Source hashing + drift detection | open | tracked-live | [plan](/meta/plans/source-hash-and-drift-detection.md) (proposed; carries all three questions) |
| 4 | `08-01-terse-brain-evaluation…` | Frontmatter facet query surface | open | tracked-live | [plan](/meta/plans/frontmatter-facet-query.md) (proposed; carries all three questions) |
| 5 | `08-01-terse-brain-evaluation…` | Read-back evidence test vs. fire-and-forget | paused | decision-closed | [terse-brain analysis](/meta/analysis/terse-lang-terse-brain-evaluation.md): sharpens the boundary "without changing the plan's proposed scope" |
| 6 | `08-01-tdd-research-spike…` | Methodology + vendorable block remnant | open | discharged | Consumed log "Methodology finalization", PR #226; ladder live in [`em:cab2c5`](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md) |
| 7 | `08-01-tdd-research-spike…` | Two-level guidance storage pilot | closed | tracked-live | [plan](/meta/plans/two-level-agent-methodology-guidance.md) (accepted); [vendor-block-pilot](/meta/matters/vendor-block-pilot.md) (open; register row 9, blocker recorded) |
| 8 | `08-01-tdd-research-spike…` | Matter queue + `/present-matters` | open | tracked-live | superseded into [matter-docs plan](/meta/plans/matter-docs-architecture.md) (in-progress); [matter-skill](/meta/matters/matter-skill.md) (register row 2) |
| 9 | `08-01-tdd-research-spike…` | Agentic cognitive biases | open | tracked-live | [plan](/meta/plans/two-sided-bias-taxonomy-and-compendium.md) (accepted); [matter](/meta/matters/two-sided-bias-taxonomy-implementation.md) (register row 7) |
| 10 | `08-01-tdd-research-spike…` | Matter register + compaction handoff | closed | discharged | register live and consuming (six deliveries, PRs #226–#231) |
| 11 | `08-01-tdd-research-spike…` | dev-history home decision | open | tracked-live | [matter](/meta/matters/dev-history-recommit-and-regeneration-fold-in.md) (open; register row 5) |
| 12 | `08-01-tdd-research-spike…` | deferred-work-is-filed policy | open | discharged | [policy](/meta/policy/deferred-work-is-filed.md) on `main`, PR #227 |
| 13 | `08-01-tdd-research-spike…` | 19.8% claim weighing | closed | discharged | weighing embedded verbatim in [promotions todo](/meta/todos/promote-the-tdd-survey-bookmarks.md) |
| 14 | `08-01-tdd-research-spike…` | TDD survey-bookmark promotions | open | tracked-live | [todo](/meta/todos/promote-the-tdd-survey-bookmarks.md) (open) + [matter](/meta/matters/tdd-bookmark-promotions.md) (register row 8) |
| 15 | `08-01-schema-formalization…` | `em:712e01`'s own defects | open | tracked-live | [plan](/meta/plans/schema-formalization-and-evaluator-lane.md) (accepted; build step 1 carries the fixes) |
| 16 | `08-01-refile-architecture…` | Link-resolution gate + `mix brain.refile` | open | tracked-live | [plan](/meta/plans/structural-link-integrity.md) (proposed; `--dir` question inside) |
| 17 | `08-01-llm-workflow-decomposition…` | Dedup gold-set harvest skip | closed | discharged | completed non-event; cell records the skill's own rule firing |
| 18 | `08-01-llm-workflow-decomposition…` | Open/merge the PR | open | discharged | `pr: 221`; merge `277d93b` |
| 19 | `08-01-comprehensive-repo-review…` | **alphaXiv connector reauthorization** | open | **orphan** | see § orphans (candidate 8) |
| 20 | `07-31-todo-surface-cli…` | Elixir todo surface (module/task/IEx) | open | tracked-live | [plan](/meta/plans/todo-cli-and-neovim-surface.md) (proposed) |
| 21 | `07-31-todo-surface-cli…` | Neovim picker-plugin dependency | paused | tracked-live | same plan, Q1 verbatim in body |
| 22 | `07-31-todo-surface-cli…` | Editor client worth building at all | paused | tracked-live | same plan, Q2 verbatim in body |
| 23 | `07-31-neovim-pr-tree-view…` | Open/merge the PR | open | discharged | `pr: 203`; merge `15982e7` |
| 24 | `07-31-dvorak-vim-reference…` | Build order for the three follow-ups | paused | tracked-live | [next-steps](/projects/dvorak-vim/next-steps.md) (project-scoped plan, proposed) |
| 25 | `07-31-agent-substrate-talks…` | Open the PR | open | discharged | `pr: 200`; merge `ce25829` |
| 26 | `07-30-sonifying-an-incident-replay…` | **Web Audio prototype build** | open | **orphan** | see § orphans (candidate 6) |
| 27 | `07-30-sonifying-an-incident-replay…` | **Psychoacoustic-threshold sources** | open | **orphan** | see § orphans (candidate 7) |
| 28 | `07-30-neovim-adoption…` | Agent-pairing architecture + build order | open | tracked-live | [architecture-and-build-order](/projects/agent-pairing/architecture-and-build-order.md) (proposed; carries the `PostToolBatch` question) |
| 29 | `07-30-neovim-adoption…` | Real-time sonification layer | paused | project-held | [realtime-sonification-layer](/projects/agent-pairing/realtime-sonification-layer.md) recommendation |
| 30 | `07-30-neovim-adoption…` | BEAM/Jido 2 integration | closed | project-held | [beam-jido-integration](/projects/agent-pairing/beam-jido-integration.md): "deferring the Jido dependency decision to first-code" |
| 31 | `07-30-neovim-adoption…` | Lua/Zig/Elixir/Jido stack question | closed | project-held | [stack doc](/projects/agent-pairing/stack-lua-zig-elixir-jido.md) open questions (all three items) |
| 32 | `07-30-human-writing-attribution…` | System trust model / disclosure frame | open | project-held | [hub](/projects/human-writing-attribution.md) `## Open questions` (all three items) |
| 33 | `07-30-human-writing-attribution…` | Overlap tool | paused | tracked-live | [overlap-tool](/projects/human-writing-attribution/overlap-tool.md) (project-scoped plan, proposed) |
| 34 | `07-29-research-digest-mcp…` | Open/merge the PR | open | discharged | `pr: 187`; merge `8f0418d` |
| 35 | `07-29-repo-evaluation…` | **Dedup-recall CI trend-line split** | open | **orphan** | see § orphans (candidate 2) |
| 36 | `07-29-repo-evaluation…` | **Duplicate artifacts + verification ladder** | paused | **orphan** (half) | duplicate-artifacts half tracked by [open issue](/meta/issues/parallel-sessions-file-duplicate-artifacts.md); ladder half is orphan candidate 3 |
| 37 | `07-29-post-action-readback…` | Wiring read-back into the flow | paused | tracked-live | [plan](/meta/plans/post-action-readback-in-the-development-flow.md) (proposed) |
| 38 | `07-29-isnad-claim-verification…` | Open/merge the PR | open | discharged | `pr: 192`; merge `2d009a2` |
| 39 | `07-29-graphrag-serialization…` | Headless Chromium vs. agent proxy | open | tracked-live | [issue](/meta/issues/headless-chromium-cannot-reach-the-network-through-the-agent-proxy.md) (open; carries the next step) |
| 40 | `07-29-graphrag-serialization…` | Open/merge the PR | open | discharged | `pr: 201`; merge `cfe1c75` |
| 41 | `07-29-elixir-comprehension…` | **Further Elixir idioms tutorials** | open | **orphan** | see § orphans (candidate 4) |
| 42 | `07-29-dopamine-effort…` | **Effort-doctrine filing decision** | open | **orphan** | see § orphans (candidate 5) |
| 43 | `07-29-dopamine-effort…` | Open/merge the PR | open | discharged | `pr: 194`; merge `93af3cb` |
| 44 | `07-28-routing-ledger-orphan-sweep…` | Reconcile steps 2–5 | open | tracked-live | [reconcile plan](/meta/plans/reconcile-dangling-ledger-strands.md) (in-progress) |
| 45 | `07-28-routing-ledger-orphan-sweep…` | Project hubs as `Action` targets | paused | tracked-live | same plan, `## Open questions` verbatim |
| 46 | `07-28-owl-rdf-skos…` | Derived RDF/SKOS export | open | tracked-live | [todo](/meta/todos/evaluate-a-derived-rdf-skos-export.md) (open) |
| 47 | `07-28-operator-methodology-shift…` | Comprehension audit | open | tracked-live | [plan](/meta/plans/comprehension-audit.md) (proposed) |
| 48 | `07-28-ontology-guardrails…` | Ledger post-capture upkeep path | open | tracked-live | [issue](/meta/issues/routing-ledger-has-no-post-capture-upkeep-path.md) (open; stays open until reconcile step 5) |
| 49 | `07-28-kimi-k3-weight-release…` | Pricing-inversion watch | open | decision-closed | watch note lives in [the doc](/knowledge/ai-industry/open-weights-stopped-being-a-price-weapon.md) ("Worth watching the *next* Chinese frontier release's price sheet"); channels-register option offered and not taken |
| 50 | `07-28-kimi-k3-weight-release…` | Fetch fidelity probe | paused | tracked-live | [plan](/meta/plans/build-the-fetch-fidelity-probe.md) (proposed; backlog status itself ratified in-thread) |
| 51 | `07-28-code-driven-av-production…` | Music-DSL commit decision | open | project-held | [hub](/projects/code-driven-av-production.md) "Next decision" span |
| 52 | `07-28-code-driven-av-production…` | **Declared-cadence spike** | open | **orphan** | see § orphans (candidate 1) |

## The eight orphans — escalation candidates

Live deferred work with no tracker. For each: the search space that came up
empty is `meta/matters.md`, `meta/matters/`, `meta/todos/`, `meta/issues/`,
and `meta/plans/` (by keyword and synonym, hits inspected), run independently
twice — once by the batch, once by the orchestrating session — plus the
specific extra checks noted per item. Filing awaits operator ratification:
the reconcile plan's scope boundary ("The sweep reports; the agent and
operator disposition") governs this audit too.

1. **Run the declared-cadence spike** — from
   [declared-cadence-swarm-auditability](/meta/analysis/declared-cadence-swarm-auditability.md),
   whose own judgment specifies it: "take one real workflow journal (or this
   session's own event timeline), declare the cadence it nominally ran at,
   compute the parameter table, and render the sonification with the verified
   NRT path". The analysis is hypothesis-status until it runs; the
   [swarm-eval harness plan](/meta/plans/inkling-beam-swarm-eval-harness.md)
   never mentions it (checked in full). **Recommend: todo** — the approach is
   fully specified; only the doing remains.
2. **Split plain vs. expanded dedup-recall into separate CI trend lines** —
   recommendation 3 of
   [the 615-document re-evaluation](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md);
   `.github/workflows/ci.yml` runs only the plain probe, and the
   [dedup-recall-probe plan](/meta/plans/dedup-recall-probe.md) (`done`)
   shipped `--expanded` but no split reporting. **Recommend: todo.**
3. **The unclimbed verification ladder** — the same re-evaluation grades
   verification practice C-range (single-digit `verified: true` coverage of
   ~492 agent-authored statements); every existing mention of the ladder in
   `meta/plans/` is context for a different change, and no tracker proposes
   growing coverage. The duplicate-artifacts half of the same paused strand is
   already held by
   [parallel-sessions-file-duplicate-artifacts](/meta/issues/parallel-sessions-file-duplicate-artifacts.md),
   filed a day before the strand froze — the cell's "neither is tracked" was
   already half false at capture. **Recommend: issue** — a live concern about
   how the brain behaves, not yet a scoped task.
4. **Continue the Elixir-idioms tutorial series** — candidates named in-thread
   (`Frontmatter.parse/1`'s tuple contract, the `~s()` sigil style in
   `site.ex`, pipeline-vs-comprehension generalized);
   [the tutorials index](/meta/tutorials/elixir/index.md) lists only the one
   existing tutorial, and the
   [code-tutorial plan](/meta/plans/code-tutorial-and-code-map.md) is `done`
   with no successor. **Recommend: todo.**
5. **Decide the effort-doctrine filing** — whether to distill the 07-25/07-26/
   07-29 journal entries (operator effort at the intention layer) into a
   standing `doctrine`; `meta/doctrine/` holds nothing on the theme
   (`intent-is-the-source` is adjacent, not this). The thread's follow-up
   prose pre-synthesizes the content. **Recommend: todo** (a decide-\* todo,
   the shape the 07-28 sweep used for operator decisions).
6. **Build the incident-replay sonification prototype** — the
   [sonification analysis](/meta/analysis/sonifying-an-incident-replay.md)
   carries the full six-layer design and its own live-vs-NRT fork; no `.html`
   sibling exists and no build commit followed the authoring commit.
   **Recommend: todo**, with the live-vs-rendered decision as its first step.
7. **Ground the psychoacoustic thresholds as `type: source` captures** — zero
   `type: source` docs on stream ceiling / fusion threshold / interval
   discrimination bundle-wide; the SoNSTAR bookmark in
   [the survey register](/survey/bookmarks.md) is still `surveyed`, never
   promoted. **Recommend: todo** (promotion + one or two primary refs,
   `verified_by`-linked into the analysis's claims).
8. **Reauthorize the alphaXiv MCP connector** — named in the
   repo-review thread as needed "before its tools work in future sessions";
   inherently outside the repo's git surface (a claude.ai account setting),
   so nothing in-bundle can discharge it. **Recommend: todo** — small, but
   [deferred-work-is-filed](/meta/policy/deferred-work-is-filed.md) (ratified
   the next day) is exactly the rule that would now catch it.

None of the eight is recommended for the matters register directly: none is
yet committed, review-shaped delivery work — "queued-ness is register
membership" — so the todo/issue tier is the right landing, with a matter
minted later for any the operator commits to delivering as a PR.

## Unrowed deferrals — the body-level pass

Across the 27 in-scope thread bodies (editorial pass; no mechanical oracle
exists for un-rowed matters — the reconcile plan's acknowledged residue):

- **Already tracked**: the TDD thread's `/create-pull-request` scoping gaps
  were named mid-thread without a ledger row, then converted in-thread into
  [create-pull-request-scoping-edit](/meta/matters/create-pull-request-scoping-edit.md)
  (register row 4) — the near-miss that seeded the deferred-work-is-filed
  policy, and nothing was lost.
- **Recorded rationale, no tracker**: the auditable-music market thesis
  ("worth filing someday", 07-28 AV thread) is deliberately unfiled per
  [media-production-domain-synergies](/meta/analysis/media-production-domain-synergies.md):
  "worth files only when acted on". Decision-closed class; no action.
- **Speculative asides**: two in the schema-formalization thread (SKOS as a
  later optional layer; revisiting expository-structure formalization "only if
  span attribution turns out to be genuinely unworkable") — explicit
  trigger-conditioned speculation, not commitments.
- **Options offered, never chosen** (e.g. the second-model GraphRAG benchmark
  run, the dimension-10 knowledge-vs-governance rebalance): per
  deferred-work-is-filed, "Options offered but not chosen are not yet work
  items". Listed for visibility, not escalation.

## The route-tag layer

At audit HEAD, `mix brain.route_tags` is green on all four checks — 534
regions across 130 tagged threads, 367 refs resolving, 221 sink appends
present and matching their re-derivation — with one editorial warning
(`2026-07-13-execute-branch-transplant-ports` routes to a concept its body
never tags; a pre-sweep thread, untouched by this audit). Dangling-ness lives
in ledgers, not tags: the check that would catch a route-tagged matter with
*no ledger row* is the inverted cross-check the reconcile plan's step 4
specifies and nothing has built, so that dimension has no mechanical oracle
today; the body-level pass above is its editorial stand-in for these 27
threads only.

## Structural findings

1. **Register row numbers in ledger cells go stale by construction.** The TDD
   thread's cells cite "row 1/3/5/7"; consumption has since renumbered every
   one. Matter *name* (the doc path) is the stable key — direct support for
   the reconcile plan's pointers-only `Action` column.
2. **A cell's own claim can be false at capture** ("neither is tracked as its
   own issue" — the duplicate-artifacts issue existed a day earlier). A
   backfill or audit must re-derive dispositions from the tracker corpus, not
   trust cell text.
3. **The staleness:loss ratio is stable across both sweeps.** The 07-28 sweep
   found ~24 discharged + ~9 decision-closed against 27 orphans; this pass
   finds 13 discharged + 24 already-tracked against 8 orphans. The ledger's
   defect remains that it cannot say "discharged" — the reconcile plan's
   diagnosis, re-confirmed on fresh data.

## Recommendation

Escalate the eight orphans on ratification — seven todos and one issue, each
with its approach already specified in the source analysis or thread — and
have the reconcile plan's step-2 backfill consume this audit's disposition
table for the 27 post-sweep threads exactly as it consumes the step-1 appendix
for the 109 pre-sweep ones (pointer added to the plan). The audit found no
strand warranting direct entry into the matters register.
