---
type: reference
title: 2026-08-02-mix-brain-matters-and-consumed-retirement
description: A register-consumption session delivers matter-docs build 5 — ElixirMind.Matters and the mix brain.matters gate (register shape, refs and doc shape, row-doc agreement, plan-order inversion, warn-only landing metadata) — retires the register's Consumed section in favor of pr stamps on done docs (two backfilled from merge-graph evidence), closes the matter-docs plan done, and fixes a Path.wildcard unicode fragility the test suite exposed.
provenance: "Claude Code session (Claude Fable 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [thread, matters, verifier, tooling, work-queue]
timestamp: 2026-08-02
session: https://claude.ai/code/session_012RbGDhSXNHAudAv1RxCWJe
---

# 2026-08-02-mix-brain-matters-and-consumed-retirement

A register-consumption session under the `/matter` skill's first full
consume run, delivering the [matter-docs plan](/meta/plans/matter-docs-architecture.md)'s
last build item. The top row was the
[mix brain.matters verifier](/meta/matters/mix-brain-matters-verifier.md)
(build 5). The session printed the record, anchored a proposal against the
live tooling, and put three recommendations to the operator — warn-only
landing metadata, git-history-only for the four pre-migration Consumed rows,
evidence-only `pr:` backfill — all accepted. Delivery: `ElixirMind.Matters` +
`mix brain.matters` (five named checks) wired into CI and the pre-commit
hook, `SessionInit` repointed onto the module's register parser, the two
pre-stamp done docs backfilled from merge-graph evidence (PR #164, PR #216),
the register's Consumed section retired with its protocol prose rewritten,
the `/matter` skill and skills-registry close steps reworded (contract
recompiled), and the matter-docs plan closed `done`. En route the test suite
exposed `Path.wildcard` silently matching nothing under a root containing
non-latin1 codepoints; the module scans with `File.ls` instead. Gates green,
delivered as `6ec0b18f`. Closed via `/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Consume the top matter: the build-5 verifier — record, proposal, three ratified recommendations | closed | [mix-brain-matters-verifier](/meta/matters/mix-brain-matters-verifier.md) | - |
| ElixirMind.Matters + mix brain.matters built, gated in CI and the pre-commit hook, SessionInit repointed | closed | [mix-brain-matters-verifier](/meta/matters/mix-brain-matters-verifier.md) | - |
| Consumed-section retirement: landing `pr:` on done docs, two backfilled from merge-graph evidence, fifo-queue gloss present-tensed | closed | [matters register](/meta/matters.md) | - |
| /matter close step + skills-registry entry reworded to the stamp-only close; contract recompiled | closed | [skills-registry](/meta/policy/skills-registry.md) | - |
| matter-docs plan complete: build 5 was its last item | closed | [matter-docs plan](/meta/plans/matter-docs-architecture.md) | - |
| Path.wildcard matches nothing under non-latin1 roots; module scans via File.ls | closed | `unrouted` | - |

## User

/matter

## Assistant

<routes ref="meta/matters/mix-brain-matters-verifier.md">
No blocker is recorded on the doc, so this row consumes. Per the protocol, the record first, then research to anchor the proposal before I put it to you.

**Matter:** [mix brain.matters verifier](/meta/matters/mix-brain-matters-verifier.md)
**Type:** planned — [matter-docs plan](/meta/plans/matter-docs-architecture.md)
**Order:** 5

Packet body, verbatim:

> Per [matter-docs plan](/meta/plans/matter-docs-architecture.md) build-order 5:
> pointer refs resolve, the global order never inverts a plan's internal order,
> row↔doc agreement; then retire [the register](/meta/matters.md)'s Consumed
> section in favor of landing metadata on done docs. Gate admission per the
> [coding-standards](/meta/policy/elixir-coding-standards.md) rule.

Now anchoring the approach against the actual tooling: the existing verifier pattern, the gate suite's wiring, the done docs' landing metadata, and every surface that references the Consumed section.
</routes>

Four of the six done docs already carry `pr:`; the two folded-from-todo done docs (`diagnose-the-dev-history-regeneration-lag`, `gate-index-listing-coverage`) lack it. `ElixirMind.SessionInit` already parses the register — reading it plus the verifier pattern, the gate wiring, and the surfaces that mention the Consumed section.

<routes ref="meta/matters/mix-brain-matters-verifier.md lib/elixir_mind/matters.ex">
Research is done — the proposal below is anchored against the working tree (`ElixirMind.Verifier`/`RouteTags` patterns, `SessionInit`'s register parser, `ci.yml`, the pre-commit hook, and the six done matter docs).

## Orientation

This matter finishes the matter-docs plan: a machine check (`mix brain.matters`) that catches hand-kept-register slips — a queue row pointing at a missing doc, row numbering gone wrong, the register's columns disagreeing with a doc's frontmatter, or the global queue ordering a plan's steps out of sequence. Once that check exists, the register's hand-kept history table (the `## Consumed` section) retires: a delivered matter's landing is recorded on its own doc (`pr: <N>`) instead of in a second, drift-prone table. Checked against the tree just now: four of the six done docs already carry `pr:`; the two folded from the old todo system (`diagnose-the-dev-history-regeneration-lag`, `gate-index-listing-coverage`) don't.

## Proposed delivery

**File-tree diff:**

```
lib/elixir_mind/matters.ex          # NEW — ElixirMind.Matters: register+doc parsing, named checks
lib/mix/tasks/brain.matters.ex      # NEW — task wrapper, route_tags-style {name, status, detail} report, exit 1 on :fail
test/elixir_mind/matters_test.exs   # NEW — tmp_dir fixtures per check class (session_init_test pattern)
lib/elixir_mind/session_init.ex     # MODIFIED — register_positions/1 replaced by ElixirMind.Matters.queue_positions/1 (one parser, no drift)
test/elixir_mind/session_init_test.exs  # MODIFIED — fixture loses its Consumed section
meta/matters.md                     # MODIFIED — ## Consumed deleted; protocol prose now: flip done, drop row, pr: stamped at close
meta/matters/diagnose-the-dev-history-regeneration-lag.md   # MODIFIED — pr: backfilled from git evidence
meta/matters/gate-index-listing-coverage.md                 # MODIFIED — pr: backfilled from git evidence
.claude/skills/matter/SKILL.md      # MODIFIED — consume steps 5/6 lose Consumed logging; close = stamp pr: only
meta/policy/skills-registry.md      # MODIFIED — /matter entry matches → CLAUDE.md recompile rides
meta/plans/matter-docs-architecture.md  # MODIFIED — status: done (build 5 is the last item) + plans index gloss
meta/matters/mix-brain-matters-verifier.md + meta/matters/index.md + register row drop  # bookkeeping per protocol
meta/code-map.md                    # regenerated (new moduledoc)
.github/workflows/ci.yml + .githooks/pre-commit  # gate wired beside brain.route_tags/brain.glossary
```

**The checks** (`@spec run_checks(root :: String.t()) :: [{String.t(), :ok | :warn | :fail, String.t()}]`):

1. **Register shape** (fail) — queue rows parse as 4 cells; `#` runs 1..N contiguously; each Matter cell links `/meta/matters/*.md`; no duplicate targets.
2. **Refs resolve** (fail) — every row's doc exists; every matter doc's `plan` resolves; `plan`/`order` co-present or co-absent; `order` a positive integer; `status` ∈ open/done/cancelled.
3. **Row↔doc agreement** (fail) — queued doc is `status: open`; Type cell (`independent` vs `planned` link) matches the doc's `plan`; Order cell matches the doc's `order`.
4. **No order inversion** (fail) — within each plan, register positions run in ascending doc `order`.
5. **Landing metadata** (warn) — a `status: done` matter doc without `pr:`.

Missing register file or unparseable docs degrade tolerantly (skip, never crash), matching the bundle's consumer posture. Glossary entries that grep-matched `Consumed` (`fifo-queue`, `todo-type`) get a present-tense pass at delivery; done docs and threads that mention the section are records and stay as written.

## Questions you need to answer

| # | Question | My recommendation |
|---|---|---|
| 1 | Check 5 severity — warn, hard fail, or no check? | **Warn.** The `/matter` close flow flips a doc `done` before its PR number exists (stamped at `/create-pull-request` time), so a hard fail would block the delivery commit at the pre-commit hook mid-window. A warn keeps the Consumed-section replacement visible without breaking the flow. |
| 2 | The four pre-migration Consumed rows have no docs (PRs #229, #228, #227, #226). Deleting the section leaves their record only in git history, threads, and PR history. Accept, or create backfilled done docs first? | **Accept.** The register's own prose already assigns pre-migration packets to git history, and the plan ratified retirement "in favor of landing metadata on done docs" — retroactive docs would re-create what the migration deliberately left behind. |
| 3 | For the two bare done docs, backfill `pr:` from git evidence (status-flip commit → PR)? | **Yes, evidence-only.** If a lookup is ambiguous I leave the doc bare and the warn stands — never a guessed number. |

Flipping the plan to `done` rides, since build 5 is its last item. Awaiting your approval before I write anything.
</routes>

## User

all recs accepted, proceed

## Assistant

<routes ref="meta/matters/mix-brain-matters-verifier.md meta/matters.md lib/elixir_mind/matters.ex">
Matter delivered, committed (`6ec0b18f`, 19 files), and pushed to `claude/matter-ilk3j1`.

## Orientation

The brain now has a machine check for its work queue: `mix brain.matters` reads the register and every matter doc, and fails the build when they disagree — a row pointing at a missing doc, numbering slips, a queued doc that isn't open, register columns contradicting a doc's frontmatter, or a plan's steps queued out of order. The register's hand-kept history table is gone: a delivered matter's landing now lives on its own doc as `pr: <N>`, and the gate warns whenever a done doc is missing that stamp. The one warning it currently prints is this very matter's doc — done, awaiting its stamp until the PR exists, which is exactly the window the warn-not-fail decision was for.

**What I created**

| File | Purpose |
|---|---|
| `lib/elixir_mind/matters.ex` | `ElixirMind.Matters` — register/doc parsing, the five named checks, and `queue_positions/1` as the one register parser |
| `lib/mix/tasks/brain.matters.ex` | task wrapper: named results, exit 1 on `:fail`, warns never fail |
| `test/elixir_mind/matters_test.exs` | nine tmp-dir scenarios: the green path, each failure class, the warn, and `queue_positions` tolerance |

**What I modified**

| Area | Thrust |
|---|---|
| `meta/matters.md` | `## Consumed` deleted; protocol prose now: flip done, drop row, `pr:` stamped at close; row 1 consumed, queue renumbered 1–6 |
| two done docs | `pr: 164` and `pr: 216` backfilled from merge-graph evidence (each cross-checked against the doc's own `attribution.agent`) |
| `session_init.ex` + its test | register parsing delegated to `Matters.queue_positions/1`; fixture updated to the current register shape |
| `.github/workflows/ci.yml`, `.githooks/pre-commit` | `mix brain.matters` wired beside the other verifiers |
| `/matter` SKILL.md, `skills-registry.md`, `CLAUDE.md` | Consumed-logging step removed; close = stamp `pr:` only; contract recompiled |
| plan + indexes + glossary | matter-docs plan `done` (build 5 was its last item), matter doc `done` with a delivered paragraph, both indexes moved, `fifo-queue.md` present-tensed |

**Actions I have taken**

| Action | Result |
|---|---|
| Evidence lookup for the two bare done docs | unambiguous: flip commits `b11108e8` → PR #164, `779f28ac` → PR #216 |
| Full gate suite (pre-commit hook, all gates + 211 tests) | green; the one matters warn is the by-design pending-stamp window |
| Commit + push | `6ec0b18f` on `claude/matter-ilk3j1` |

One implementation finding: the module scans docs with `File.ls` rather than `Path.wildcard` — wildcard silently matches nothing under a root containing non-latin1 codepoints, which a unicode-named test tmp-dir exposed. That fragility is real for legal root paths, so the fix went into the module rather than renaming the test.

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | Invoke `/create-pull-request` | captures the session, opens the PR, and — per the close step binding this session — stamps `pr: <N>` into this matter's done doc, clearing the warn in the same PR |
| 2 | Continue to the next matter in a fresh thread | register row 1 is now the `/create-pull-request` scoping edit |
</routes>
