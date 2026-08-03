---
type: reference
title: 2026-08-03-matter-list-audit-and-wave-delivery-methodology
description: The operator commissions a full audit of the matter register — order optimality, backlog promotions, drift against main, and concurrency grouping — then ratifies the re-sequencing, the wave-delivery methodology, and the derived-numbering matter; the session delivers all three, answers the waves/GSD terminology question from the framework's own docs, records the Pages-freeze proposal on its matter, and hits the branch-scoped-credential wall on the one ratified branch deletion.
provenance: "Claude Code session (Claude Fable 5), 2026-08-03; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, matters, register, audit, waves, orchestration, concurrency]
timestamp: 2026-08-03
session: https://claude.ai/code/session_01RR5E5wizhvUAXjYNKtf6Gi
pr: 242
---

# 2026-08-03-matter-list-audit-and-wave-delivery-methodology

## Where this landed

A register-maintenance session: the operator asked for a four-part audit of
the matter list (queue-order optimality, backlog promotion candidates, drift
against main, concurrency grouping), then ratified the audit's dispositions.
Delivered on `claude/matter-list-audit-sequence-rt6udk`: the register
re-sequenced to 21 rows (two blocked rows demoted, three backlog matters
queued, the bias-taxonomy and TDD rows lifted above the decision-queue
block), a new queued matter making the register's row numbering derived, and
the wave-based concurrent delivery methodology (`em:bd4cce`) on a new
`knowledge/SWE/agentic/orchestration/` shelf — with the waves/GSD
terminology question answered from the framework's own docs and cited in
that methodology. The one ratified branch deletion could not execute from
the sandbox's branch-scoped credential and stays with the operator; the
operator floated freezing Pages rather than sunsetting it (recorded on the
sunset matter, unconfirmed); Wave 0 execution goes to a fresh thread.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Register audit: order, promotions, drift, concurrency | closed | [meta/matters.md](/meta/matters.md) | - |
| Wave-based concurrent delivery methodology | closed | [wave-based-concurrent-delivery](/knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md) | - |
| Waves terminology and the GSD correspondence | closed | [wave-based-concurrent-delivery](/knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md) | - |
| Derived register numbering (concurrency prerequisite) | closed | [derive-the-register-row-numbering](/meta/matters/derive-the-register-row-numbering.md) | - |
| Branch triage: the last ratified deletion | open | [triage-the-six-kept-unmerged-claude-branches](/meta/matters/triage-the-six-kept-unmerged-claude-branches.md) | operator executes the ratified delete of `git-fetch-merge-skill-ke7adg` (the sandbox credential could not) |
| Pages disposition: freeze floated | paused | [response-resource-links-pages-sunset-revision](/meta/matters/response-resource-links-pages-sunset-revision.md) | does the freeze ruling firm? (agent recommends yes) |
| Wave 0 execution | open | [wave-based-concurrent-delivery](/knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md) | a fresh thread runs the wave program against the re-sequenced register |

## User

evaluate the current matter list. determine whether the current order of sequenced matters is optimal. consider the collection of unsequenced matters, and determine whether any should be prionitized to being sequenced. audit all of them against main - have any drifted? do any require a rewrite? finally, consider how we might group matters in sequence so that several could be run concurrently with minimal merge issues

## Assistant

Substantial drift findings already: the branch-triage matter has shrunk from 4 deletions to 1 (three branches already gone), the pre-commit-wiring matter is verified complete pending a doc flip, and the gate-suite tutorial gap has *grown* (5 gates missing now, including `brain.matters`, which didn't exist when it was filed). Let me pin down the plans-index placement, the unstamped-doc count, and read the newest thread doc for direction changes:

## Assistant

The stack-direction session confirms the bias-taxonomy plan is named as the research program the operator's eval trajectory serves — that bears directly on row 17's position. Let me finish the live-state checks: the plan build orders, the register's renumbering behavior on delivery, and a few packet claims.

## Assistant

The audit is complete. Here is the full assessment.

---

In plain terms first: I read every matter in the system — the 19 rows in the delivery queue and the 21 open docs sitting in backlog — plus the six plans behind the queued rows, and checked each packet's claims against today's `main` (through PR #239, merged this morning). The short version: the queue's order is structurally sound and no packet has drifted badly enough to be invalid. But two queued rows are parked behind blockers that may never clear on their own, one backlog matter turns out to be **already done in the wild** and just needs its confirmation flip, another fixes index drift that is live right now, and one queued matter's packet describes cleanup work that is three-quarters finished by events. For running matters in parallel, the main obstacle is the register itself — it renumbers on every delivery, so any two concurrent deliveries collide there by construction — but the *content* of the work splits cleanly into three or four lanes that barely touch.

The technical detail, under each of your four questions.

> **"determine whether the current order of sequenced matters is optimal"**

The order is sound where it is load-bearing, checked against each packet's stated dependencies (`mix brain.matters` is green; no plan's internal order is inverted). The dependency reasoning inside the three front plans holds up well: roster config (row 4) lands before the value gate (row 6), which lands before the backfill (row 7) — so the 30 stamps get written against a ratified vocabulary *and* are machine-checked as they land — and the backfill precedes the register Model column (row 8) so the column ships populated. Rows 9→10→11 also sequence correctly: the contract sweep's sub-item 13 explicitly checks whether the dev-history recommit (row 10) has landed, and in this order it will have.

Three placement findings, in descending weight:

1. **Rows 16 and 19 are indefinitely blocked and their queue positions assert nothing.** Row 16 (Pages-sunset revision) waits on you firming the sunset decision; row 19 (vendor-block pilot) waits on an active consuming repo existing. The register's own rule says a matter that cannot be ranked stays an unsequenced backlog doc, and the skip protocol handles them either way — but as rows they are noise in a list whose order is supposed to carry prioritization. Recommend demoting both to backlog. Better still for row 16: make the sunset decision itself, because row 12 (excerpt-log discipline) has a mechanics lever — render-collapsed on the Pages site — that is moot if Pages dies, and in the current order row 12 delivers *before* that ruling exists.

2. **Rows 17–18 sit behind five contract-hygiene matters, and yesterday's session changed their relative weight.** The 2026-08-03 stack-direction session (PR #239) names the two-sided bias taxonomy plan as "the research program the eval work would serve," and your stated trajectory is toward the swarm-eval work. Rows 11–15 (the decision-queue plan) are internal contract hygiene; nothing downstream depends on them. If research momentum matters more than contract hygiene this week, lift 17 (bias taxonomy) and 18 (TDD promotions) above 11–15 — or run them concurrently, which works even better (see the fourth answer).

3. **Row 5 vs row 14, a small accepted risk.** Row 5 (model-stamping policy) writes a prospective/retrospective clause against the model-attribution policy; row 14 (settle model-attribution) later rules on that policy's fate. Row 5's packet already flags this, and the carried recommendation for row 14 — option (b), policy stands — makes the rewrite risk low. Moving all of rows 11–14 ahead of row 5 would cost more than the risk it removes. Leave as is; row 5's deliverer should read row 14's recommendation before writing the clause, which the packet already instructs.

One adjacent gap: [reconcile-dangling-ledger-strands](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/reconcile-dangling-ledger-strands.md) is `in-progress`, `priority: 2`, with steps 2–5 remaining — and has no presence in the register or backlog (it predates the register seed). It is visible to `/priorities` through the plans scan, so this is a surfacing choice rather than a defect, but if the register is meant to be *the* delivery queue, its remaining steps are the largest committed work not on it.

> **"consider the collection of unsequenced matters, and determine whether any should be prionitized to being sequenced"**

Of the 21 open backlog docs, I recommend queueing three, one of them effectively free:

| Promote | Why now | Placement |
|---|---|---|
| [wire-pre-commit-hook-in-session-start](https://github.com/ob6to8/elixir-mind/blob/main/meta/matters/wire-pre-commit-hook-in-session-start.md) | **Already done in the wild** — I verified today: `session-start.sh:30` contains the guarded `core.hooksPath` block and this fresh sandbox's live git config reads `.githooks`. The doc's own update note says "on pickup: confirm and flip done." | Head; it is a five-minute confirm-and-flip PR |
| [gate-plans-index-status-sections](https://github.com/ob6to8/elixir-mind/blob/main/meta/matters/gate-plans-index-status-sections.md) (`priority: 3`) | The drift it fixes is live right now — I confirmed all three plans sit under `## Proposed` while their frontmatter reads `accepted`/`in-progress`, and the drift has *widened*: the model-column plan's index gloss tail still says "status: proposed" against frontmatter `accepted`. Anyone reading the plans index today gets wrong answers. | Beside row 8 — same row↔doc-agreement family, same lib lane |
| [disambiguate-order-versus-sequence](https://github.com/ob6to8/elixir-mind/blob/main/meta/matters/disambiguate-order-versus-sequence-in-scope-unit-of-work.md) (`priority: 3`) | Tiny, fully decided, and it guards the queue's own semantics (an agent misreading "sequenced" as licence to queue). | **Strictly after row 2** — the heading migration restructures the same file, and concurrent delivery guarantees a conflict |
| [triage-the-six-kept-unmerged-claude-branches](https://github.com/ob6to8/elixir-mind/blob/main/meta/matters/triage-the-six-kept-unmerged-claude-branches.md) | Events shrank it: of the four branches its "remaining" section asks you to delete, **only `claude/git-fetch-merge-skill-ke7adg` still exists on the remote** (checked `git ls-remote` today). One ratification from you closes it. | Either ratify the one deletion in chat and let any session flip it, or queue it as a near-trivial row |

Two explicit non-promotions: [ratify-or-reject-provenance-names-producing-model](https://github.com/ob6to8/elixir-mind/blob/main/meta/matters/ratify-or-reject-provenance-names-producing-model.md) must stay put — row 14 carries a rider that absorbs and dispositions it, so promoting it would create the duplicate the rider exists to prevent. And [refresh-gate-suite-tutorial-gate-table](https://github.com/ob6to8/elixir-mind/blob/main/meta/matters/refresh-gate-suite-tutorial-gate-table.md) should be queued only *after* the gate-adding rows (3, 6, 8, and the plans-index gate if promoted) land — otherwise it re-drifts the week it merges. The rest of the backlog is correctly parked: `brain.staleness` is deferred by an explicit trigger that hasn't fired (3 dated-revision resources today against its ~10 threshold), the decision matters (journal carry-forward, cross-model review target, workflow-fanout graduation, RDF export) wait on your bandwidth rather than an agent's, and the two old intakes from 2026-07-13 are small and undated by anything since.

> **"audit all of them against main - have any drifted? do any require a rewrite?"**

No packet is invalidated — every approach still stands. The drift is concentrated in measurements and enumerations, which is what the structured-plan-bodies refresh rule exists to absorb. The findings, worst first:

| Matter | Drift found (checked against origin/main today) | Verdict |
|---|---|---|
| triage-six-branches (backlog) | 3 of the 4 branch deletions in its "remaining" section already happened; only `git-fetch-merge-skill-ke7adg` survives | **Trim or deliver immediately** — the doc overstates its remaining scope 4× |
| wire-pre-commit-hook (backlog) | The deliverable exists and works; done-when criteria verified in this very sandbox | **Flip done** (with the confirmation recorded) |
| refresh-gate-suite-tutorial (backlog) | The gap it measures grew from 3 missing gates to 5: `brain.matters`, `brain.glossary`, `brain.lineage --check`, `brain.dedup_probe` are absent from the tutorial, and `brain.dev_history` is back in the picture but runs only in `pages.yml` (per the ci.yml comment), which the tutorial's where-it-runs framing must place correctly | Refresh numbers at delivery; schedule after the gate-adders |
| [backfill-model-stamps](https://github.com/ob6to8/elixir-mind/blob/main/meta/matters/backfill-model-stamps-on-matter-docs.md) (row 7) | Packet says "30 open docs, 0 stamped"; today it is 40 open docs, 10 stamped — the unstamped count is coincidentally still exactly 30. Its value-source link (`meta/model-roster.md`) dies when row 4 deletes that doc | Refresh at delivery; the scope rule ("every open doc lacking `model:`") is stable |
| register-model-column (row 8) | "All 11 rows" → 19 rows; the session-init annotation count likewise | Covered by the plan's own refresh rule |
| ratify-or-reject-provenance (backlog) | Its recommendation rests on a pre-ratification world; model-attribution has since been ratified (2026-07-31) | Deliberately superseded — row 14's rider disposes of it; no rewrite |
| gate-plans-index (backlog) | Its premise "each doc's own gloss already ends with its correct status" is now false for one plan (model-column's gloss tail went stale when frontmatter moved to `accepted`) | Scope naturally absorbs it — the fix covers gloss tails too |
| Rows 5, 4, 11 (positional refs) | Packets cite "queued row 6", "row 12" — positions that renumbering has since moved | Cosmetic; a small authoring lesson: packets should cite matters by name, never by row number, because rows renumber |

Confirmed clean against their stated anchors: rows 1–3 (the migration's change-set was surveyed at `075dc82`, which is still the second-to-last merge, and the fence hazard in `capture/SKILL.md` is unchanged), row 17 (the `knowledge/cognitive-science/biases/` stub exists awaiting the refile, as the packet assumes), row 18 (all four TDD items still sit unpromoted in the survey register), and rows 9, 10, 12, 13, 14, 15 (spot-checked their live premises: `/create-pull-request` still says "current working changes"; the contract sweep's rows are self-dating by design). The scope of this negative finding: I checked each packet's *stated* facts and anchors against the working tree and remote at `24a4e8f`; I did not re-derive each plan's full current-state trees, which remains each delivery's own refresh step.

> **"consider how we might group matters in sequence so that several could be run concurrently with minimal merge issues"**

<routes ref="em:bd4cce">

The one collision no grouping avoids: **the register renumbers**. Delivery drops a row and the `#` column re-sequences (observable in history — the roster matters entered as rows 14–16 and are rows 4–6 today), so any two concurrent deliveries conflict on `meta/matters.md`, plus small adjacent-line conflicts in `meta/matters/index.md` (open→done moves). These are mechanical to resolve — drop both rows, renumber once, and the row↔doc agreement check makes a botched resolution loud — but every concurrent pair pays it. If you want real parallelism as standing practice, a small tooling matter would dissolve it: make the `#` column derived (rendered by `mix brain.matters` or dropped in favor of implicit position), so the authored artifact has no per-row serial to conflict on.

Second-class conflicts are the generated artifacts — `CLAUDE.md`, `meta/registry.md`, `meta/code-map.md`, indexes. These always conflict textually when two branches both regenerate, and always resolve the same way: merge the *sources*, re-run the generator. That is a known recipe, not a risk.

The content itself partitions into lanes that barely touch:

| Lane | Surface | Matters | Internal constraint |
|---|---|---|---|
| **A — skills + policy/contract** | `.claude/skills/`, `meta/policy/`, `CLAUDE.md` | 1→2→3ᵃ, 5, 9→10, then disambiguate and (if promoted) handle-hosts | Serialize within the lane — rows 2, 5, 9, 10 overlap on skill files; 9 and 10 edit the *same section* of `/create-pull-request` |
| **B — lib/ tooling** | `lib/`, `test/`, `config/` | 4, 6, 8, gate-plans-index | 6 and 8 both edit `matters.ex` + its test — serialize those two; the rest touch disjoint modules (`model_config.ex`, `links.ex`, `skill_sections.ex`) |
| **C — knowledge tree** | `knowledge/`, `survey/`, `beliefs/glossary/` | 17, 18, both old intakes, broaden-invisible-degradation | Effectively conflict-free with everything — disjoint directories; only registry/index regeneration overlaps |
| **D — wide-touch, run solo** | 30 matter docs at once | 7 (backfill) | It edits every open matter doc, so it conflicts with *any* in-flight delivery that touches a packet or flips a doc — give it a quiet window |

ᵃ Row 3 is lib/ work but plan-locked behind row 2.

A concrete concurrent schedule respecting all plan-internal orders:

- **Wave 1:** row 1 (A) ∥ row 4 (B) ∥ row 17 (C) ∥ the wire-pre-commit flip. Rows 1 and 4 both recompile the contract — first to merge wins, the other runs `/sync-branch-with-main` and regenerates.
- **Wave 2:** row 2 (A) ∥ row 6 (B) ∥ row 18 (C) ∥ gate-plans-index (B — different module than 6).
- **Wave 3:** row 3 (B) ∥ row 5 (A) ∥ — and row 7 solo immediately after this wave clears, since the queue's packets stop changing then.
- **Wave 4:** rows 9→10 serial (A) ∥ row 8 (B) ∥ disambiguate (A — different file than 9/10).
- **Wave 5:** rows 11→15 serial — the decision-queue plan is contract-dense and self-ordered, the one stretch that genuinely resists parallelism ∥ any remaining lane-C work beside it.
- **After:** refresh-gate-suite-tutorial, once the gate roster is stable.

That schedule turns a 19-row serial queue into roughly five sessions of wall-clock depth for the parallelizable stretch, at the cost of one register-renumber resolution per wave.

</routes>

---

**Actions I have taken**

| action | result |
|---|---|
| Read all 47 matter docs (19 queued, 21 open backlog, 7 done) and the 6 plans behind the queue | full packet inventory above |
| `mix brain.matters` | green — register, docs, and delivery order all consistent |
| Verified packet claims against origin/main at `24a4e8f` (PR #239) | drift table above: branch existence via `git ls-remote`, hook wiring via live `git config`, CI gate list vs tutorial, plans-index placement, stamp counts, survey rows, stub dirs, dated-revision count |
| Checked the 2026-08-03 stack-direction thread for direction changes | bias-taxonomy plan named as the research program the eval trajectory serves — feeds the row-17 recommendation; no impact on the two proposed meta-evals |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Ratify the re-sequencing | demote rows 16 and 19 to backlog, queue wire-pre-commit + gate-plans-index + disambiguate at the recommended slots, optionally lift 17–18 above 11–15 — one register-edit PR I can deliver on this branch |
| 2 | Make the two unblocking decisions | the Pages-sunset ruling (unblocks row 16, sharpens row 12) and the one remaining branch deletion (`git-fetch-merge-skill-ke7adg` — closes the triage matter) |
| 3 | Adopt the concurrency scaffolding | file a small matter making the register's `#` column derived, so concurrent deliveries stop colliding on renumbering; then run the wave schedule |
| 4 | Take the audit as-is | no changes; each delivery's refresh step absorbs the packet drift as designed |

## User

1,2,3
and author the concurrency functionality as a general technology that can be referenced as design, and followed, whether with skills or referenced instruction, following a flow like we had here, an audit, followed by an execution of concurrent waves

by the way, where did the terminology for waves come from? is this the same usage from the get-shit-done claude code framework? if you could, answer this before doing the work

## Assistant

All pushed, gates green. Here is the full report.

---

Everything you approved is delivered and pushed on `claude/matter-list-audit-sequence-rt6udk` (commit `0c2804a`, 211 tests green): the register is re-sequenced to 21 rows, the row-numbering fix is filed *and* queued, and the wave methodology now exists as a citable design doc in the knowledge tree. Two loose ends survived contact with reality: the branch deletion you ratified turns out to be impossible from this sandbox's credentials (it's recorded in the doc, one click remains for you), and the Pages-sunset ruling needs you to state a *direction* before anything can act on it. Your terminology question first, as asked.

> **"where did the terminology for waves come from? is this the same usage from the get-shit-done claude code framework? if you could, answer this before doing the work"**

<routes ref="em:bd4cce">

I reached for it as standard parallel-scheduling vocabulary — in compilers and DAG scheduling this is *wavefront* or *level* scheduling: topologically level a dependency graph, run each level in parallel, run the levels in sequence (that provenance is from memory; the term-of-art status is not in doubt). I did not consciously take it from get-shit-done — though GSD's docs are popular enough that I can't rule out training-data influence on which word came to hand; introspection on word choice is not reliable.

Whether it's the *same usage* I checked directly against the framework's own docs today, and yes — semantically identical. GSD's USER-GUIDE, under "Execution Wave Coordination": "GSD groups plans into waves (parallel where independent, sequential where dependent), spawns a fresh 200k-context executor per plan, and commits each task atomically." And its execute-phase workflow: "Execute each selected wave in sequence. Within a wave: parallel if `PARALLELIZATION=true`, sequential if `false`." Parallel within a wave, sequential across waves, grouped by dependency — the same concept I used, both convergent on the standard scheduling idea rather than one borrowing from the other.

One real difference in setting, which shaped the methodology doc: GSD's wave executors work inside one working tree and the framework serializes the commits, so its wave problem is pure scheduling. Our units are separate sessions on separate branches, each landing through its own reviewed merge — so the load-bearing addition here is **merge-surface partitioning** (which units may fly together), which is exactly what your audit request surfaced. The doc quotes and cites GSD as prior art for the term. Incidentally, the brain already knew GSD before today — solely as the case study in the trust-state-inversion capture (the May 2026 governance collapse), which is its own kind of footnote on framework dependence.

Sources: [GSD USER-GUIDE](https://github.com/gsd-build/get-shit-done/blob/main/docs/USER-GUIDE.md), [execute-phase workflow](https://github.com/gsd-build/get-shit-done/blob/main/get-shit-done/workflows/execute-phase.md)

</routes>

> **"1,2,3"**

**Option 1 — re-sequencing: done.** The register is 21 rows: wire-pre-commit at row 1, the new derive-numbering matter at row 2, the three plans in their blocks (rows 3–5, 7–9, 10–11), disambiguate at row 6 (below the migration it must not collide with), gate-plans-index at row 12 (beside the Model column), bias taxonomy and TDD promotions lifted to rows 15–16 ahead of the decision-queue block (rows 17–21), and the two blocked rows (Pages-sunset, vendor-block) demoted to backlog with their docs untouched. `mix brain.matters` confirms every plan's internal order survived the shuffle.

**Option 2 — half done, half blocked.** The branch deletion hit a wall: this sandbox's push credential is scoped to the session branch (the ref deletion returned 403), and the GitHub MCP surface carries no ref-deletion tool. In the middle of that I briefly flipped the triage doc `done` and then reverted it — the committed state is honest: `status: open`, with your 2026-08-03 ratification recorded, the three already-absent branches verified, and the one remaining action named (`git push origin --delete claude/git-fetch-merge-skill-ke7adg` from any credentialed context, or the delete button on the branches page — no further ratification needed). The Pages-sunset ruling I could not execute at all, because approving the option told me you want to *make* the ruling but not which way it goes — that's the blocking question below.

**Option 3 — done, and queued.** [Derive the register's row numbering](https://github.com/ob6to8/elixir-mind/blob/claude/matter-list-audit-sequence-rt6udk/meta/matters/derive-the-register-row-numbering.md) is filed (stamped `Claude Opus 5` — same silent-degradation seam as the Model-column matter, which shares its parser) and queued at row 2, since it's the prerequisite that makes every later concurrent pair stop colliding on the register. Its packet recommends dropping the `#` column outright, records keep-and-verify as the gate alternative, and flags the cell-count interaction with the Model-column matter behind it.

> **"author the concurrency functionality as a general technology that can be referenced as design, and followed … following a flow like we had here, an audit, followed by an execution of concurrent waves"**

<routes ref="em:bd4cce">

Filed as [wave-based concurrent delivery of a serialized work queue](https://github.com/ob6to8/elixir-mind/blob/claude/matter-list-audit-sequence-rt6udk/knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md) (`em:bd4cce`, `type: methodology`) on a new `knowledge/SWE/agentic/orchestration/` shelf — a subdirectory under the established `agentic` domain, created autonomously per the taxonomy protocol with its `index.md` and parent listing. It's written as a general technology, not a register manual: a seven-step procedure (audit against HEAD → classify write surfaces → partition into lanes → cut a wave → launch as one approval batch → merge in sequence → barrier and reconcile), a conflict-class table with the resolution rule for each (authored content is designed away by the partition; queue serials re-derive mechanically; generated artifacts regenerate from merged sources, never hand-merge; listings stay alphabetical so insertions resolve obviously), and a bounds section — the sharpest bound being that a wave of N units is N concurrent review obligations, so width is capped by your attention, not by lane count. The bundle-specific mapping (register, matter docs, `mix brain.matters`, `/sync-branch-with-main`, the generated class) sits in one closing table, so a future orchestration skill can cite the doc as its design and a session told to "run a wave" can follow the Procedure section directly — the skill-vs-referenced-instruction choice stays open, as you framed it.

</routes>

---

**What I created**

| type | doc | why this type |
|---|---|---|
| `methodology` | `knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md` (`em:bd4cce`) | a repeatable, prescriptive playbook — the audit→waves flow as followable design, general beyond this repo |
| `matter` | `meta/matters/derive-the-register-row-numbering.md` | approach decided (derive the serial), only the doing remains; queued row 2 as the wave program's prerequisite |
| index | `knowledge/SWE/agentic/orchestration/index.md` | reserved listing for the new shelf |

**What I modified**

| file | thrust of the change |
|---|---|
| `meta/matters.md` | the ratified 21-row sequence: 2 demotions, 4 additions, 2 lifts; timestamp bumped |
| `meta/matters/index.md` | derive matter added; triage gloss rewritten to the one-deletion-remaining state |
| `meta/matters/triage-the-six-kept-unmerged-claude-branches.md` | stays `open`; ratification, the three verified-absent branches, and the credential block recorded |
| `knowledge/SWE/agentic/index.md` | orchestration shelf listed |
| `meta/registry.md` | regenerated for the new `em:` id |

**Actions I have taken**

| action | result |
|---|---|
| GSD terminology check | verbatim usage confirmed from both GSD docs, quoted above and cited in the methodology |
| Branch deletion attempt | denied — 403 from the branch-scoped credential; no MCP ref-deletion tool; recorded in the matter doc |
| Gate suite + push | full pre-commit suite green (211 tests, 0 failures); `0c2804a` pushed |

**Questions you need to answer**

| # | question | my recommendation |
|---|---|---|
| 1 | Which way does the Pages-sunset ruling go? | Sunset — the dev-history matter already records "Pages is de-prioritized" as settled context; ruling it firms lets the (now-backlog) revision matter re-queue and sharpens row 18's mechanics ruling. Blob-at-`main` becomes the canonical citation form. |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Delete the last branch | one click on the branches page (or the one-line push from any credentialed session) — closes the triage matter |
| 2 | Cut Wave 0/1 per the methodology | rows 1–2 land first (row 2 rewrites the register, so it flies alone), then the first true wave: rows 3, 7, 15, 16 in four lanes as one approval batch |
| 3 | `/create-pull-request` | close this session's unit — capture, glossary, and the PR for the audit + re-sequencing + methodology |

## User

1 - re: pages, actually, i am having second thoughts. what if we just freeze it - don't develop it, but don't delete

1 ok direct me
2 - no should do in a new thread

## Assistant

Three quick answers, no file changes this turn — the freeze idea is sound and I recommend it, the branch deletion is two clicks, and the wave run has a clean one-line handoff for its new thread.

> **"re: pages, actually, i am having second thoughts. what if we just freeze it - don't develop it, but don't delete"**

Freeze works, and I'd adopt it — it is the cheapest coherent disposition of the three. The machinery is already self-running (the deploy fires on every `main` push with no maintenance), every merged doc keeps its live canonical URL so nothing cited externally ever dangles, and it is reversible in both directions later — sunset means turning off one workflow and revising the link policy; revival means just developing again. The sunset path, by contrast, forces the response-resource-links rewrite, `mix brain.url --pages` changes, and dead URLs for anything already cited. A freeze also *simplifies* a queued matter: row 18 (excerpt-log discipline) carries a render-collapsed-on-the-site lever, which "don't develop it" rules out — that delivery reduces to the selection rule, the size cap, and the retro question.

Recording it, once you confirm, is one small unit: flip the Pages-sunset matter `cancelled` with the ruling in its body, and add one sentence to the response-resource-links policy's mechanics paragraph ("the site is frozen: kept deploying, Pages URLs stay canonical, no further site development") so future sessions inherit the rule rather than re-proposing site work — contract recompile riding. That's a policy edit, so it's its own thread's matter, not this one's; say the word and I'll file it to the backlog (or head) now.

> **"1 ok direct me"**

Two ways, either one finishes it:

- **GitHub UI:** open [the branches page filtered to the branch](https://github.com/ob6to8/elixir-mind/branches/all?query=git-fetch-merge-skill) and click the trash icon on `claude/git-fetch-merge-skill-ke7adg`.
- **Any terminal with your credentials:** `git push origin --delete claude/git-fetch-merge-skill-ke7adg`

Its content is fully ported (the `/sync-branch-with-main` skill, PR #82; build thread rescued), so the delete loses nothing. Once it's gone, mention it in any future thread and that session confirms via `ls-remote` and flips the triage matter `done` — the doc already says no further ratification is needed.

> **"2 - no should do in a new thread"**

Agreed — that's also what the one-unit-per-thread rule wants. The handoff is already durable, so the new thread needs only this as its opening prompt:

> Run the wave program per `/knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md`: audit, then cut Wave 0 from the register.

Wave 0 as the register now stands is rows 1–2 in sequence (row 2 rewrites the register table, so it flies alone), and the first parallel wave after that is rows 3, 7, 15, 16 — but the new thread's own audit step re-derives that against whatever has merged by then, which is the point of the procedure.

**Questions you need to answer**

| # | question | my recommendation |
|---|---|---|
| 1 | Confirm the Pages freeze? | Yes — adopt it; I file the small record-the-freeze matter (cancel sunset matter + one policy sentence) for a fresh thread to deliver |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | `/create-pull-request` | close this thread's unit — the pushed re-sequencing + methodology commit becomes its PR |
| 2 | Start the wave thread | paste the one-line prompt above into a fresh session |

## User

/create-pull-request merge

