---
type: reference
title: 2026-07-28-swappable-bundle-spec-and-library-naming
description: The session that retrofitted the library spin-out plan with its structured swappable-bundle spec (a file:line coupling audit of lib/, the Bundle manifest/struct design, two-repo file trees), then executed two operator naming rounds — the library takes the elixir-mind name (this repo renames to knowledge at spin-out) and the id prefix is em: for both bundles, splitting the Phase 3 oracle.
provenance: "Claude Code session (claude-fable-5), 2026-07-28; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, spin-out, separation-of-concerns, architecture, naming, glossary]
timestamp: 2026-07-28
session: https://claude.ai/code/session_01Sux5kkrbQvoyGWagUgwGUm
---

# 2026-07-28-swappable-bundle-spec-and-library-naming

## Where this landed

The operator asked for a spec of breaking the tooling out of this repo so the
OKF bundle becomes swappable across clients, suspecting a plan already existed.
Two did — the bundle/library separation plan and its Phase 4 spin-out spec — so
the session deepened the
[spin-out plan](/meta/plans/library-spin-out-and-dependency-distribution.md) in
place with the structured body the
[retrofit plan](/meta/plans/retrofit-plans-to-structured-bodies.md) had slated
for it: a file:line coupling audit of `lib/`, the `Bundle` manifest/struct spec
(bundle root + manifest as the library's only inputs), two-repo file-tree
diffs, call trees, boundary decisions, and three new open questions. Two
operator naming rounds followed: first the library's name changed from
composable-beliefs-3 to **elixir-mind** (this repo renames at spin-out to free
the slug; interim demo prefix `dm:`), then the prefix was set to **`em:`
across the board** and the knowledge repo's new name to **`knowledge`** —
fully resolving the naming question and splitting the Phase 3 oracle (the
fixture proves path/vocabulary lifts; a dedicated `id_prefix`-override test
proves the prefix lift). A final exchange clarified the PR file list (each
glossary term is its own document; the extra-looking files were glossary
entries) and surfaced a stale local `origin/main`. The session closed with
`/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Swappable-bundle spec: coupling audit, Bundle manifest/struct, structured retrofit of the spin-out plan | closed | [library-spin-out plan](/meta/plans/library-spin-out-and-dependency-distribution.md) | - |
| Library naming reversal (elixir-mind) and the knowledge-repo rename (knowledge) | closed | [library-spin-out plan](/meta/plans/library-spin-out-and-dependency-distribution.md), [separation plan](/meta/plans/separate-okf-bundle-and-elixir-mind-library.md) | - |
| em: prefix for both bundles and the Phase 3 oracle split | closed | [fixture bundle](/beliefs/glossary/fixture-bundle.md) | - |
| Glossary living-surface sweep for the renamed library | closed | [glossary index](/beliefs/glossary/index.md) | - |
| PR file-list clarification (per-term glossary layout; stale local origin/main) | closed | unrouted | - |

## User

spec out what it will look like to break the logic out from this repo so that the knowledge okf bundle can be swappable, so the architecture can be used with different clients. there may already be a plan related to this

## Assistant

Two existing plans are directly on point:

- **separate-okf-bundle-and-elixir-mind-library** — settled *that* the repo is two deliverables and where the boundary runs (Phase 3 = configurability audit, Phase 4 = spin-out).
- **library-spin-out-and-dependency-distribution** — the Phase 4 spec: library extracts to `composable-beliefs-3`, knowledge repos consume it as a Mix dep, config becomes the per-bundle manifest.

What neither has is the **code-grounded spec of the swappable-bundle surface** — the actual inventory of where the library is coupled to *this* bundle, and the concrete config/API shape that makes any bundle pluggable. That's the gap the user's ask fills, and it also serves the accepted retrofit-plans-to-structured-bodies plan (this plan is an active retrofit target). Let me audit the code coupling now.

The audit is done and the retrofit plan explicitly expects this plan to get "file-tree diffs (two repos), boundary decisions (config manifest)" — the pilot pattern is a `## The shape, structured` section, prose untouched, timestamp bumped, new design questions appended to open questions. That's exactly the vehicle for this spec. Writing it now.

The spec is written, committed, and pushed. There were indeed already plans on this — two, chained — so per the update-in-place rule I deepened the existing one rather than filing a duplicate.

**What existed:** the [bundle/library separation plan](https://ob6to8.github.io/elixir-mind/meta/plans/separate-okf-bundle-and-elixir-mind-library.html) settled that this repo is two deliverables and where the boundary runs, and its Phase 4 was already graduated into the [library spin-out plan](https://github.com/ob6to8/elixir-mind/blob/claude/swappable-bundle-architecture-s14sna/meta/plans/library-spin-out-and-dependency-distribution.md) — the library extracts to `composable-beliefs-3`, and knowledge repos consume it as a versioned Mix dependency. What neither had was the code-grounded spec of *how the bundle becomes swappable*. That's what I added, as the structured `## The shape, structured` section the accepted retrofit-plans-to-structured-bodies plan had already slated for this exact doc.

<routes ref="em:ad34c1">
**The core of the new spec:** the library's entire knowledge of any particular collection reduces to two inputs — a **bundle root** (path to an OKF checkout) and a **manifest** (the consuming repo's `config/config.exs`). Any client supplying both gets the full toolchain: your agent sessions here, other operators' knowledge repos, CI, and the planned thin Jido host are all the same call path with different manifests. Concretely:

- **A coupling audit of `lib/` at HEAD** — every place the code binds to *this* bundle, with file:line sites: the `em:` prefix in five modules, three overlapping excluded-dir lists, the channel/statement-type/sense vocabularies, a dozen hardcoded governance addresses (`meta/policy`, `CLAUDE.md`, `meta/registry.md`, …), and the this-repo-only backfill module. One finding: the controlled `type` vocabulary is enforced nowhere in code today, so "library checks membership in the bundle-declared list" is a new capability the manifest enables, not a lift.
- **A `Bundle` struct spec** — `Bundle.load/1` becomes the single config read point, threaded as an explicit argument to every module; the fixture bundle (`cb:`-namespaced) tests the unmodified production code path just by supplying a different manifest.
- **Two-repo file-tree diffs** and production/test call trees, plus boundary decisions (profile = shape the library owns; manifest = values a second bundle could legitimately set differently).
- **Three new open questions** appended, not answered — notably that the proposed `brain.* → mind.*` task rename must be sequenced against the extraction, since post-split the task names ship to every consuming bundle.
</routes>

| What I modified | Thrust |
|---|---|
| `meta/plans/library-spin-out-and-dependency-distribution.md` | Added the structured shape section (audit, manifest/struct spec, trees, boundary decisions, anchors, decision list); appended open questions 5–7; bumped `timestamp` |
| `meta/plans/index.md` | Moved the entry to the top of Proposed (timestamp ordering) and extended its gloss |

| Actions I have taken | Result |
|---|---|
| Coupling audit of `lib/` at `d08abf2` | Inventory table with file:line anchors, embedded in the plan |
| Full gate suite (verify, route tags, contract/registry/codemap checks, tests) | Green — 183 tests, 0 failures; only pre-existing editorial warnings |
| Commit + push to `claude/swappable-bundle-architecture-s14sna` | Pushed; no PR opened (not requested) |

| Your options from here | What it entails |
|---|---|
| 1. Ratify the deepened spec | Flip the spin-out plan to `accepted`; execution still waits on the parent plan's Phases 1–3 |
| 2. Pull Phase 3 forward | The audit table is now the ready work-list for the configurability lift — it could land here before any extraction, making the bundle swappable in place |
| 3. Answer open questions 5–7 | Profile-vs-manifest boundary for statement types, backfill-module retirement, and `mind.*` rename sequencing are all operator calls that would de-risk execution |

## User

lets change "composable-beliefs-3" to "elixir-mind"

## Assistant

Good catch needed here: "Composable Beliefs" also names the operator's separate reference system (`composablebeliefs/composable-beliefs`), glossaried in its own right — those historical references stay. What changes is the *spin-out library's* name. Let me read the living surfaces that carry it:

Now I'll execute the rename. One consequence to handle: this repo currently *holds* the `ob6to8/elixir-mind` slug, so the library taking the name means this repo renames at spin-out — that reverses the 2026-07-17 naming call recorded in both plans, and it un-blocks a nice simplification (the code already *is* `:elixir_mind`/`ElixirMind`, so the extraction no longer needs any app/module rename). Let me check one remaining reference first:

Done — the library is now named **elixir-mind** throughout the spec, committed and pushed. One structural consequence and one judgment call worth your eyes:

**The consequence:** this repo currently holds the `ob6to8/elixir-mind` slug, so the library taking the name means *this repo renames at spin-out*. That reverses the 2026-07-17 resolution in both plans, and the knowledge repo's new name is now the reopened open question 1. The costs the old decision avoided are recorded where they'll matter: the Pages URL moves with the rename (one config edit plus contract/site recompiles), and — the sharper edge — GitHub's rename redirects for this repo's old links *retire the moment the library claims the freed slug*, so migration step 1 now sequences the rename and the claim back-to-back. The upside is real, too: the extraction no longer needs any app or module rename, since the code is already `:elixir_mind`/`ElixirMind`, and the eventual Hex package name is naturally `elixir_mind`.

**The judgment call:** the demo bundle's id prefix was `cb:`, mnemonically mirroring composable-beliefs. With that name gone the mnemonic was orphaned — and `cb` already denotes the Composable Beliefs reference system in your glossary — so I moved the fixture prefix to `dm:` (demo). Nothing has minted under it yet, so this is free to change if you'd prefer another token.

Frozen thread docs still say composable-beliefs-3 — deliberately untouched, per the session-capture verbatim rule; they're the historical record of the decision as it was made.

| What I modified | Thrust |
|---|---|
| `meta/plans/library-spin-out-and-dependency-distribution.md` | Full rename sweep: target shape, dep tuples, config/`ElixirMind.Bundle` spec, file trees, migration step 1 (name-swap sequencing + redirect caveat), scope boundary, open questions 1/2/7, `cb:` → `dm:` |
| `meta/plans/separate-okf-bundle-and-elixir-mind-library.md` | Open question 1 records the 2026-07-28 reversal; timestamp bumped |
| `meta/plans/index.md` | Both glosses updated; parent plan reordered up per timestamp |
| 5 glossary entries (`hex`, `git-dependency`, `git-filter-repo`, `reusable-workflow`, `fixture-bundle`) + index | Bodies/description now name the `elixir-mind` library and `dm:` fixture prefix; glossary index re-materialized |

| Actions I have taken | Result |
|---|---|
| Repo-wide sweep for the old name outside frozen threads | Only deliberate historical mentions remain (the reversal records themselves) |
| Full gate suite via pre-commit | Green — 183 tests, 0 failures |
| Commit + push to `claude/swappable-bundle-architecture-s14sna` | `f907e38` pushed |

| Your options from here | What it entails |
|---|---|
| 1. Name the knowledge repo | Settles reopened open question 1 (and, secondarily, whether `em:` should ever follow it — no migration is forced) |
| 2. Keep or change `dm:` | The fixture prefix is my placeholder call; one-line change while nothing mints under it |
| 3. PR this branch | The spec retrofit + rename are coherent as one reviewable unit; say the word and I'll run `/create-pull-request` |

## User

the prefix should be em, NOT dm or cb
the knowledge repo should be called "knowledge"

## Assistant

<routes ref="em:7f58e2">
Two clean decisions to fold in: the prefix is `em:` across the board (it travels with the library's schema — no `dm:`/`cb:` fixture namespace), and the knowledge repo's new name is **knowledge**, which fully resolves open question 1. The one design consequence to handle honestly: a fixture that also mints `em:` no longer proves the prefix is configurable, so the prefix half of the Phase 3 oracle moves into a dedicated test. Making the edits:
</routes>

Both decisions are in, committed (`995e82f`), and pushed — the naming question is now fully closed across the spec.

**What the two calls settle:** the id prefix is `em:` everywhere — the demo/fixture bundle mints under it (the interim `cb:`/`dm:` fixture prefixes are gone), and this bundle's existing ids ride through everything untouched, with no migration ever needed since the prefix now mirrors the *library's* name, which is stable. And this repo renames to **knowledge** at spin-out, which resolves the last open half of question 1: the end state is `ob6to8/elixir-mind` (the library) + `ob6to8/knowledge` (this bundle), with the Pages site moving to `ob6to8.github.io/knowledge/` at rename time.

<routes ref="em:7f58e2">
**One design consequence I had to handle rather than just find-and-replace:** the fixture's *not*-being-`em:` was previously the proof that the prefix was genuinely lifted into config ("hardcoded `em:` assumptions cannot survive a non-`em:` corpus"). With the fixture on `em:`, that proof would silently vanish — so the spec now splits the Phase 3 oracle: the demo bundle remains the acceptance test for paths, directory lists, and vocabularies, while prefix configurability is proven by a dedicated test that overrides `id_prefix` over a small synthetic corpus. Nothing about the swappable-bundle property weakens; only where it's tested moves.
</routes>

One small observation, no action needed: the repo named `knowledge` will contain a top-level `knowledge/` directory — harmless (repo slug vs. bundle taxonomy dir), just visually doubled in paths like `knowledge/knowledge/SWE/…` when reading clones.

| What I modified | Thrust |
|---|---|
| `meta/plans/library-spin-out-and-dependency-distribution.md` | Id-namespace section rewritten (`em:` for both bundles, oracle split); manifest example, file trees, test topology, migration step 1, scope boundary, and open question 1 (now fully resolved) all updated |
| `meta/plans/separate-okf-bundle-and-elixir-mind-library.md` | Question 1 record completed: library = elixir-mind, this repo → knowledge, `em:` unchanged |
| `meta/plans/index.md` | Both glosses reflect the settled naming and the oracle split |
| `beliefs/glossary/fixture-bundle.md` + glossary index | Entry now describes the `em:`-minting fixture and the relocated prefix test; index re-materialized |

| Actions I have taken | Result |
|---|---|
| Residual-reference sweep | Only one `dm:`/`cb:` mention remains, deliberately — the decision-history line recording what was superseded |
| Full gate suite via pre-commit | Green — 183 tests, 0 failures |
| Commit + push | `995e82f` on `claude/swappable-bundle-architecture-s14sna` |

The spec is now internally consistent with all naming settled. Want me to run `/create-pull-request` to land the branch?

## User

i see all files being modified being plans and glossaries, but the pr shows other files being modified:
fixture-bundle.md
git-dep.md
fit-filter-repo.md
etc

## Assistant

No discrepancy — those files *are* the glossary. Fresh diff against GitHub's live `main` confirms the branch touches exactly **9 files**, and every one is a plan or a glossary artifact:

| File | Why it's in the PR |
|---|---|
| `meta/plans/library-spin-out-and-dependency-distribution.md` | The spec itself (retrofit + both naming rounds) |
| `meta/plans/separate-okf-bundle-and-elixir-mind-library.md` | Parent plan's open question 1 updated |
| `meta/plans/index.md` | Gloss updates + timestamp reordering |
| `beliefs/glossary/fixture-bundle.md` | Glossary **term entry** — body described the `cb:`/`dm:` fixture prefix, now `em:` |
| `beliefs/glossary/git-dependency.md` | Term entry — its example dep tuple named `composable_beliefs_3` |
| `beliefs/glossary/git-filter-repo.md` | Term entry — described extraction "to create composable-beliefs-3" |
| `beliefs/glossary/hex.md` | Term entry — Hex requirement example used the old package name |
| `beliefs/glossary/reusable-workflow.md` | Term entry — said composable-beliefs-3 publishes the gate suite |
| `beliefs/glossary/index.md` | Re-materialized (fixture-bundle's `description` changed) |

The confusion is layout, not content: in this bundle **each glossary term is its own document** under `beliefs/glossary/` — there's no single glossary file. So `fixture-bundle.md`, `git-dependency.md`, and `git-filter-repo.md` look like standalone docs in the PR file list, but their full paths are `beliefs/glossary/…`. They were written on 2026-07-17 when the spin-out spec session glossaried its own terms, and their bodies embedded the old library name in examples — living surfaces that must state the present, so the rename swept them.

One housekeeping note from checking this: my container's local `origin/main` ref had gone stale (main has moved on to PR #174 while we worked). That affected nothing pushed — the branch itself is clean and based on a commit that's in main's history — but I've re-fetched, and if you'd like I can merge current `main` into the branch (`/sync-branch-with-main`) so the PR stays conflict-free before landing.
