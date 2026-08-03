---
id: em:bd4cce
type: methodology
title: "Wave-based concurrent delivery of a serialized work queue"
description: Run several queued work units in parallel agent sessions against one trunk — audit the queue against HEAD, partition units into disjoint write-surface lanes, cut dependency-leveled waves, and resolve the residual merge classes mechanically.
provenance: "Claude Fable 5, matter-list audit session"
tags: [agents, orchestration, concurrency, waves, work-queue, merge-conflicts, delivery]
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T05:10:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-list audit session"
  why: "the register audit's concurrency grouping, generalized into a followable design so future queue runs execute waves from a referenced procedure instead of re-deriving the partition logic"
---

# Wave-based concurrent delivery of a serialized work queue

A serialized work queue — atomic units consumed top-down, one unit per merge —
is safe but slow: wall-clock time is the sum of every delivery. Most queued
units do not actually contend for the same files, so several can be delivered
concurrently by parallel agent sessions **if** the units that would collide are
kept apart and the collisions that remain are made mechanical. This methodology
is that discipline: an **audit** of the queue, a **partition** of its units
into non-overlapping write surfaces, and execution in **waves**.

A **wave** is a set of units executed concurrently, with a barrier before the
next wave begins: units within a wave are mutually independent, and every
dependency points backward across a barrier. The term is standard
parallel-scheduling vocabulary (wavefront or level scheduling: topologically
level a dependency graph, then run each level in parallel), and the
[get-shit-done](https://github.com/gsd-build/get-shit-done) Claude Code
framework uses it the same way — "GSD groups plans into waves (parallel where
independent, sequential where dependent), spawns a fresh 200k-context executor
per plan, and commits each task atomically"
([USER-GUIDE](https://github.com/gsd-build/get-shit-done/blob/main/docs/USER-GUIDE.md)).
The difference in setting: a framework executor commits its parallel work
inside one working tree, while the units here are separate sessions on
separate branches, each landing through its own reviewed merge into a shared
trunk. Scheduling alone is therefore not enough — the design problem is
**merge-surface partitioning**: deciding which units may fly together so that
every trunk merge stays near-mechanical.

## Preconditions

The queue system must already provide:

- **Atomic units** — one reviewable intent per unit, one unit per merge, so a
  wave's merges are independently approvable.
- **Self-contained packets** — each unit's doc carries the whole handoff, so a
  fresh session can deliver it without the orchestrator's context.
- **A queue↔doc verifier** — a mechanical check that makes a botched queue
  edit loud, since concurrent deliveries edit the queue concurrently.
- **A true-merge trunk and a branch-sync procedure** — sessions must be able
  to pull the trunk mid-flight and resolve against it.
- **Generated artifacts regenerable by command**, with freshness gates — so
  their conflicts resolve by regeneration rather than hand-merging.

Absent any of these, build it first; the procedure leans on every one.

## Procedure

1. **Audit the queue against trunk HEAD.** Verify each packet's stated facts
   and anchors — the files it names, the counts it measured, the blockers it
   records. Mark units whose blockers are unmet and packets whose premises
   moved. An audit is what keeps a wave from launching a unit whose premise
   died three merges ago.
2. **Classify write surfaces.** For each ready unit, list what its delivery
   writes: the authored files it edits, the generated artifacts it
   regenerates, the queue rows it drops. The packet usually states this;
   derive it where it doesn't.
3. **Partition into lanes.** Group units whose authored write surfaces
   overlap into the same lane. Units in one lane serialize; units in
   different lanes may fly together. A unit that touches nearly everything —
   a corpus-wide sweep, a mass backfill — is its own lane and flies solo.
4. **Cut a wave.** Take at most one ready unit per lane whose dependencies
   (declared order, stated blockers) are satisfied by already-merged work.
   Width is bounded by review capacity, not lane count (see Bounds).
5. **Launch.** Present the wave to the reviewer as one batch, so any
   per-unit approval gate is satisfied in one motion at cut time. Then one
   fresh session per unit, each on its own branch, each delivering exactly
   its unit and nothing beside it.
6. **Merge in sequence.** First finished, first merged. Every still-flying
   session then syncs its branch with the trunk and resolves by conflict
   class (below) before continuing.
7. **Barrier, reconcile, repeat.** When every unit in the wave has landed or
   been returned to the queue, run the verifiers on trunk, re-audit any
   remaining packet whose anchors the wave moved, and cut the next wave.

## Conflict classes

| Class | Example | Resolution |
|---|---|---|
| Authored content, same file | two units editing one skill body | Designed away by the lane partition. A conflict here means the partition was wrong: stop, re-partition, re-cut the wave. |
| Serialized queue artifacts | two deliveries each drop a row; positional numbering shifts | Mechanical re-derivation at merge: apply both drops, renumber once, let the queue verifier confirm. Structural fix where available: derive serials instead of authoring them, so the artifact carries no per-row number to conflict on. |
| Generated artifacts | two branches each recompile a contract, registry, or code map | Merge the *sources*, then re-run the generator; a generated file is never hand-merged. Freshness gates catch a forgotten regeneration. |
| Listing lines | two deliveries add or move lines in one directory listing | Ordinary small merges; canonical ordering (alphabetical) keeps insertions from colliding and makes resolutions obvious. |

## Bounds

- **Review attention is the scarcer resource.** Waves optimize agent
  wall-clock, and a wave of N units is N concurrent review obligations. Cap
  wave width at what the reviewer will actually absorb, not at the lane
  count.
- **A same-surface queue degenerates.** When most units share one surface,
  the partition yields one lane and waves add ceremony to what is serial
  delivery anyway. Check the partition before committing to waves.
- **Incomplete packets serialize better.** A unit expected to need
  mid-flight judgment — an approach still open, a ruling embedded in the
  delivery — belongs in a serial session where the judgment can be posed and
  answered. Waves suit units whose packets are complete handoffs.

## Instantiation in this bundle

| Methodology term | Here |
|---|---|
| queue | [the matter register](/meta/matters.md), consumed by [`/matter`](/.claude/skills/matter/SKILL.md) |
| unit | a [matter](/beliefs/glossary/matter.md) — one per PR per [atomic pull requests](/meta/policy/git-atomic-pull-requests.md) |
| packet | the matter doc under [`meta/matters/`](/meta/matters/index.md) |
| queue↔doc verifier | `mix brain.matters` |
| branch sync | [`/sync-branch-with-main`](/.claude/skills/sync-branch-with-main/SKILL.md) |
| generated class | `CLAUDE.md`, `meta/registry.md`, `meta/code-map.md`, index listings |

The register's row numbering is authored data today and renumbers on every
delivery — the standing exception to near-mechanical merges, with its
structural fix tracked in
[derive the register's row numbering](/meta/matters/derive-the-register-row-numbering.md).
The 2026-08-03 register audit produced the first worked partition, four lanes:
skills + policy/contract, `lib/` tooling, the knowledge tree, and wide-touch
units flying solo. A future orchestration skill can cite this document as its
design; until one exists, a session directed to run a wave follows the
Procedure section directly.

# Citations

- get-shit-done (GSD), [USER-GUIDE — Execution Wave Coordination](https://github.com/gsd-build/get-shit-done/blob/main/docs/USER-GUIDE.md)
  and [execute-phase workflow](https://github.com/gsd-build/get-shit-done/blob/main/get-shit-done/workflows/execute-phase.md):
  "Execute each selected wave in sequence. Within a wave: parallel if
  `PARALLELIZATION=true`, sequential if `false`."

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:bd4cce">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-03-matter-list-audit-and-wave-delivery-methodology (2026-08-03)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:bd4cce`]**

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

---

**[`em:bd4cce`]**

I reached for it as standard parallel-scheduling vocabulary — in compilers and DAG scheduling this is *wavefront* or *level* scheduling: topologically level a dependency graph, run each level in parallel, run the levels in sequence (that provenance is from memory; the term-of-art status is not in doubt). I did not consciously take it from get-shit-done — though GSD's docs are popular enough that I can't rule out training-data influence on which word came to hand; introspection on word choice is not reliable.

Whether it's the *same usage* I checked directly against the framework's own docs today, and yes — semantically identical. GSD's USER-GUIDE, under "Execution Wave Coordination": "GSD groups plans into waves (parallel where independent, sequential where dependent), spawns a fresh 200k-context executor per plan, and commits each task atomically." And its execute-phase workflow: "Execute each selected wave in sequence. Within a wave: parallel if `PARALLELIZATION=true`, sequential if `false`." Parallel within a wave, sequential across waves, grouped by dependency — the same concept I used, both convergent on the standard scheduling idea rather than one borrowing from the other.

One real difference in setting, which shaped the methodology doc: GSD's wave executors work inside one working tree and the framework serializes the commits, so its wave problem is pure scheduling. Our units are separate sessions on separate branches, each landing through its own reviewed merge — so the load-bearing addition here is **merge-surface partitioning** (which units may fly together), which is exactly what your audit request surfaced. The doc quotes and cites GSD as prior art for the term. Incidentally, the brain already knew GSD before today — solely as the case study in the trust-state-inversion capture (the May 2026 governance collapse), which is its own kind of footnote on framework dependence.

Sources: [GSD USER-GUIDE](https://github.com/gsd-build/get-shit-done/blob/main/docs/USER-GUIDE.md), [execute-phase workflow](https://github.com/gsd-build/get-shit-done/blob/main/get-shit-done/workflows/execute-phase.md)

---

**[`em:bd4cce`]**

Filed as [wave-based concurrent delivery of a serialized work queue](https://github.com/ob6to8/elixir-mind/blob/claude/matter-list-audit-sequence-rt6udk/knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md) (`em:bd4cce`, `type: methodology`) on a new `knowledge/SWE/agentic/orchestration/` shelf — a subdirectory under the established `agentic` domain, created autonomously per the taxonomy protocol with its `index.md` and parent listing. It's written as a general technology, not a register manual: a seven-step procedure (audit against HEAD → classify write surfaces → partition into lanes → cut a wave → launch as one approval batch → merge in sequence → barrier and reconcile), a conflict-class table with the resolution rule for each (authored content is designed away by the partition; queue serials re-derive mechanically; generated artifacts regenerate from merged sources, never hand-merge; listings stay alphabetical so insertions resolve obviously), and a bounds section — the sharpest bound being that a wave of N units is N concurrent review obligations, so width is capped by your attention, not by lane count. The bundle-specific mapping (register, matter docs, `mix brain.matters`, `/sync-branch-with-main`, the generated class) sits in one closing table, so a future orchestration skill can cite the doc as its design and a session told to "run a wave" can follow the Procedure section directly — the skill-vs-referenced-instruction choice stays open, as you framed it.
