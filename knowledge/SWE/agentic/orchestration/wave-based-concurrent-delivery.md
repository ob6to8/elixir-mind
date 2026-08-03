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
