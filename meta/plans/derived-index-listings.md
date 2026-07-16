---
type: plan
title: "Derived index listings: compile Contents sections from frontmatter, with write-time summaries"
description: Retire hand-maintained index.md listings — a mix brain.index generator derives every directory's listing section from its children's frontmatter (newest-first, glossary A–Z, status-grouped where children carry status), bullet text sourced from a new write-time summary field with description fallback; absorbs PR #70's nav-sort core and supersedes its 30 hand-reorderings.
status: proposed
provenance: "Claude Code session, 2026-07-15 — grew out of investigating PR #70's merge conflicts; the operator redirected from 'hand-reorder the listings by date' to 'derive the listings so hand-sync stops existing'"
attribution:
  when: 2026-07-15T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, PR #70 investigation session"
  why: "persists the derived-listings design and the write-time-vs-build-time LLM placement decision per the persist-plans policy, as the spec a later session builds against"
tags: [meta, plan, tooling, generated-artifact, indexes, llm-placement]
timestamp: 2026-07-15
---

# Derived index listings: compile Contents sections from frontmatter, with write-time summaries

## Problem

PR #70 ("Order every collection by date modified, except the glossary") is
unmergeable: it predates the `SecondBrain` → `ElixirMind` rename (its two code
files no longer exist at their paths) and the knowledge-tree reorganization
(`agentic-coding/` → `agentic/anthropic/…`), and `main` has since accumulated
358/161 lines of index churn across the same ~30 `index.md` files it
hand-reordered. Re-resolving it would reproduce stale orderings over newer
intake.

But the failure is diagnostic, not incidental. PR #70 had two parts:

- a **durable mechanical core** — the site nav sorts collections by
  `timestamp` descending with a `beliefs/glossary/` alphabetical carve-out
  (`sort_files/2` in the site builder plus two pinning tests); and
- a **brittle convention** — hand-reordering ~30 `index.md` listing bodies to
  match, which is exactly the kind of hand-kept shadow of derivable state that
  the [retire-hand-kept-logs plan](/meta/plans/retire-hand-kept-logs.md)
  eliminated for `log.md`.

The operator's directive on review: *if ordering is a derived property, the
listings themselves should be derived — a need to edit by hand to keep in sync
is unnecessary complexity.* The listings are in fact derivable: every bundle
concept already carries `title` and `description` in frontmatter, and the pure
listings (knowledge tree, `inbox`, glossary) are precisely
`[title](path) — description` bullets. Only the **curated governance indexes**
(`plans`, `issues`, `analysis`, …) carry content beyond frontmatter:
multi-sentence editorial bullets and status grouping. That content belongs on
the artifact itself, not in a sibling file that drifts.

## Decision

Derive, don't sort. Listings become **generated sections inside `index.md`**,
on the same compile-and-check discipline as `CLAUDE.md`, `meta/registry.md`,
the route-tagged excerpt logs, and `meta/dev-history.md` — and the editorial
bullet text migrates onto the docs it describes, as a new write-time `summary`
frontmatter field.

### 1. `mix brain.index` — the listing generator

A new `ElixirMind.Index` module with a `mix brain.index` task, mirroring the
`brain.route_tags` / `brain.lineage` interface:

- `mix brain.index --materialize` (default) — for every bundle directory with
  an `index.md`, re-derive its listing section(s) from the directory's
  children and write them in place.
- `mix brain.index --check` — re-derive and byte-compare; non-zero exit on
  divergence. Wired into CI and the pre-commit hook beside the existing
  `--check` gates.

The generator owns only its **marked listing section**; everything above it —
the directory's prose preamble, genre framing, cross-links — stays
hand-written. This is the established hybrid shape of the route-tagged
excerpt logs: hand prose + a generated, verifier-owned block in one file.

### 2. Bullet text: `summary`, falling back to `description`

Each child's bullet renders as `[title](path) — <text>` where text is the
child's **`summary`** frontmatter field if present, else its `description`.

- `summary` is a new optional frontmatter field: a multi-sentence editorial
  synthesis of the doc — what today lives as the hand-written bullet in the
  curated governance indexes (e.g. the plans index's *"operator-designated top
  priority (`priority: 1`)…"* annotations). It is richer than the
  one-sentence `description` and may carry status notes and cross-links.
- It is written **at artifact creation or substantive revision, by the
  authoring agent** — see §5 for why there, and not in the build.
- Knowledge-tree concepts don't need one; their `description` already is the
  bullet. `summary` is expected mainly on governance genres.

**One-time migration, nothing lost:** each existing curated bullet's text is
lifted verbatim off the index and into its target doc's `summary`. The
editorial writing is preserved — it just moves to the artifact it describes,
where there is exactly one copy.

### 3. Ordering and grouping — all derived

- **Files: newest-modified first** — sort key `{timestamp desc,
  attribution.when desc, title}` (PR #70's `recency_key`, kept verbatim).
- **Glossary exception:** `beliefs/glossary/` (and anything under it) stays
  alphabetical — a name-keyed reference collection, not a dated one.
- **Subdirectory bullets: alphabetical** — a taxonomy map is structural, not
  dated (PR #70's call, kept). A directory bullet's text derives from the
  first prose sentence of the child directory's own `index.md` preamble, so
  each directory describes itself in one place.
- **Status grouping where children carry `status`:** the generator groups
  bullets under status headings in a per-vocabulary canonical order,
  active-first (plans: `proposed · accepted · in-progress` before `done ·
  superseded`; issues: `open` before `resolved · wontfix`; todos: `open`
  before `done · cancelled`), recency-ordered within each group. Grouping is
  data-driven — no per-directory configuration.

### 4. The nav sort — PR #70's core, absorbed

Port `sort_files/2`, `alphabetical_dir?/1`, and `recency_key/1` (plus the two
pinning tests) into `ElixirMind.Site` / `ElixirMind.SiteTest` — a
near-verbatim transplant; the diff was module-internal. The ordering
functions live in **one shared module** used by both the nav builder and the
listing generator, so the sidebar and the `index.md` bodies cannot disagree.

### 5. Where the LLM call lives — write-time, not build-time

The `summary` field is LLM-authored content inside an otherwise deterministic
pipeline. Three placements were considered:

1. **Write-time, in the authoring agent (chosen).** Every artifact in this
   brain is already created or revised by an agent session — an LLM is
   already in the loop at exactly the moment the doc's meaning is freshest.
   The skills and policies that govern artifact creation (persist-plans,
   `/todo`, issue filing, `/intake`) gain one instruction: *write or refresh
   `summary` when you create or substantively revise the doc.* The output is
   committed frontmatter — reviewed in the PR like any other content — and
   the build stays a pure function of the repo.
2. **On-demand tooling (optional convenience, not load-bearing).** A
   `mix brain.summarize <path>` task that invokes an LLM — either an HTTP
   call to the Messages API (`Req` + `ANTHROPIC_API_KEY`) or a shell-out to
   headless Claude Code (`claude -p "<prompt>"`) — and writes the result into
   frontmatter for the operator to review and commit. Useful for batch
   backfill; architecturally it is still write-time: generate → commit →
   review. Deferred unless the migration in §2 proves tedious by hand.
3. **Build-time, inside `Site.build`/`brain.index` (rejected).** Embedding a
   live LLM call in the derivation pipeline breaks the repo's core idiom
   three ways: `--check` gates work by re-deriving and byte-comparing, and a
   non-deterministic step can never pass one; CI and the Pages deploy would
   need API secrets and per-build spend; and the rendered site would no
   longer be reproducible from a commit. Caching responses by input
   content-hash could paper over determinism, but the cache itself becomes a
   committed artifact — at which point it *is* option 2 with extra steps.

The decision rule this encodes, for any future "should an LLM call go here?"
question: **LLM calls belong at the authoring edges, where their output
becomes committed, reviewable source; the derivation pipeline stays a pure
function of the repo.** Agents write; compilers derive; checkers compare.

### 6. Policy updates

- [`maintain-reserved-files`](/meta/policy/maintain-reserved-files.md) — index
  upkeep becomes *"run `mix brain.index` (the pre-commit hook runs it for
  you)"*; the hand-listing mandate is retired. States the ordering convention
  (newest-first, glossary A–Z) as a property of the generator.
- [`frontmatter-schema`](/meta/policy/frontmatter-schema.md) — document
  `summary` (optional; multi-sentence editorial synthesis; the index bullet
  source; expected on governance genres).
- [`reserved-filenames`](/meta/policy/reserved-filenames.md) — `index.md` now
  carries a generated listing section; hand prose stays above it.
- Recompile `CLAUDE.md` (`mix brain.contract`).

### 7. PR #68 and PR #70 disposition

PR #68 ("order plans/todos/issues indexes by timestamp") and PR #70 are
**open, unmergeable siblings from the same 2026-07-13 session** — independent
branches, not a stack, but #70 was written with #68 in context and
semantically subsumes it: #70's every-index reorder includes #68's three, and
#70 re-creates #68's glossary `timestamp` entry outright. Both predate the
`second-brain` → `elixir-mind` rename (`sb:` ids, `lib/second_brain` paths)
and the knowledge-tree reorganization, so both are stale the same way.

**Both are superseded by this plan** — the hand-reordering convention they
established (state-it-in-the-header, maintain-at-filing-time) is exactly what
derivation retires. Close both unmerged once this plan's PR lands. But #68
uniquely holds three artifacts that exist on neither `main` nor #70's branch,
salvaged as a build step here (§Build order, step 3a):

- the **[`collection-view-by-date` plan doc]** — the decision record this
  plan's ordering key stands on: the three-date-signals survey
  (`attribution.when` = created, `timestamp` = semantic modified, git =
  mechanical), the operator's ratification of `timestamp`, and the deferred
  recency surfaces (`mix brain.recent`, skill `by-date` dispatch, site sort
  toggle) — transplanted onto the current tree with paths/prefixes fixed,
  kept `status: done` (its deferred options remain live options);
- its **thread doc** (`2026-07-13-collection-view-by-date.md`, `pr: 68`) —
  the session record backing that plan's `attribution.from`;
- the **glossary `timestamp` entry** — re-filed with the `em:` prefix
  (`sb:715275`'s tail carries per the stable-identity migration rule,
  collision-checked against the registry at mint time).

Transplant, never plain-merge — the same discipline as the
[transplant-surviving-unmerged-branches plan](/meta/plans/transplant-surviving-unmerged-branches.md),
whose problem class both branches join. After both PRs close, the two
branches carry unmerged commits — per the
[git-branch-deletion policy](/meta/policy/git-branch-deletion.md), deletion is
proposed to the operator, not automatic (and is moot for content once the
salvage lands).

## Build order

1. Port the nav sort + two tests into `ElixirMind.Site` (§4); extract the
   shared ordering module.
2. Add `summary` to the frontmatter-schema policy; recompile the contract.
3. Lift every curated index bullet into its target doc's `summary` (verbatim;
   ~40 governance docs across plans/issues/todos/analysis/threads/
   elaborations). Bump nothing else — `attribution` is immutable and this is
   a metadata move, but `timestamp` bumps per update-in-place.

   3a. Salvage PR #68's three orphaned artifacts (§7): transplant the
   `collection-view-by-date` plan doc and its thread doc onto the current
   tree, and re-file the glossary `timestamp` entry under the `em:` prefix.
4. Build `ElixirMind.Index` + `mix brain.index` (`--materialize`/`--check`)
   with tests over a tmp-dir bundle (grouping, recency order, glossary
   exception, dir-bullet derivation, preamble preservation).
5. Materialize all ~41 bundle `index.md` files; eyeball the diff against the
   pre-migration listings for dropped content.
6. Wire `--check` into CI and the pre-commit hook; update
   maintain-reserved-files + reserved-filenames; recompile the contract.
7. All gates green (`mix format --check-formatted`, `compile
   --warnings-as-errors`, `brain.contract --check`, `brain.registry --check`,
   `brain.verify`, `brain.route_tags`, `brain.lineage --check`, `brain.index
   --check`, `mix test`); PR; then close PR #70 as superseded.

## Out of scope / deferred

- **`mix brain.summarize` LLM tooling** (§5 option 2) — deferred until the
  hand migration proves painful or a batch-refresh need appears.
- **Auto-refreshing `summary` on doc edits** — a stale summary is an
  editorial problem, caught in review, not a mechanical one; no verifier rule
  attempts semantic freshness.
- **The root `index.md` prose and `beliefs/glossary.md` hub** — hand-written
  framing docs, untouched beyond their generated listing sections.

## Open questions

- **Section heading ownership.** Does the generator own a single `## Contents`
  heading everywhere, or adopt each genre's existing heading (`## Terms`,
  `## Proposed`, …)? Leaning: generator emits genre-appropriate headings from
  the status vocabulary, and owns everything below the first generated
  heading marker.
- **Threads index granularity.** `meta/threads/` is inherently dated and
  large — flat newest-first, or year/month grouping once it grows? Flat until
  it hurts.
- **`verified`-style enforcement for `summary`.** None planned — it's
  editorial prose. Confirm the verifier should merely tolerate the field.
