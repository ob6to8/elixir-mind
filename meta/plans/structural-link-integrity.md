---
type: plan
title: "Structural link integrity: gate link resolution, automate the refile"
description: Split `ElixirMind.Links.check/1` into a gating link-resolution family and an advisory index-coverage family so an unresolved internal link fails `mix brain.verify`, and add `mix brain.refile` performing a document move — `git mv`, inbound-link rewrite, route-tag path refs, both index updates, registry regeneration — as one tested operation; the path-preserving alternative to id-referenced links.
status: proposed
provenance: "Claude Code session, 2026-08-01 — recommendation of the id-referenced-links analysis, written up as the executable shape; not yet ratified for execution"
tags: [meta, plan, links, verifier, tooling, mix-task, refile]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, architecture-docs-placement session"
  why: "persists the two-move recommendation from the id-referenced-links analysis so a future session can execute it without re-deriving the judgment"
  from: [/meta/threads/2026-08-01-refile-architecture-paper-and-link-integrity.md]
---

# Structural link integrity: gate link resolution, automate the refile

## Status

**Proposed.** The operator asked for the judgment and its executable shape to
be filed; execution is not yet ratified. The reasoning behind choosing this
over id-referenced links lives in
[the analysis](/meta/analysis/id-referenced-links-vs-path-links.md) and is not
restated here.

## Problem

Moving a document requires finding every inbound link by grep and rewriting it
by hand. Nothing structurally forces that sweep to be complete: the check that
would catch a miss exists but is advisory, so a stale link prints one line among
the freshness warnings and merges green. The exposure is small today (zero
unresolved links across 6,685) and stays small only by the operator noticing.

## Move 1 — gate link resolution

### Current state

```
mix brain.verify
└── Verifier.run/0                          → :ok | {:error, errors}   [GATES]
    └── on :ok → report_freshness_warnings/0
        └── Links.check/1 ++ Attribution.warnings/0
            ├── link_warnings/2   (private)  → unresolved internal links   [advisory]
            └── index_warnings/2  (private)  → index-coverage gaps         [advisory]
```

### Desired state

```
mix brain.verify
├── Verifier.run/0                          → :ok | {:error, errors}   [GATES]
├── Links.link_errors/1        (public, new) → unresolved internal links [GATES]
└── on both :ok → report_freshness_warnings/0
    └── Links.index_warnings/1 (public, promoted) ++ Attribution.warnings/0
                                                                        [advisory]
```

`Links.check/1` stays as the both-families entry point so existing callers and
tests keep working.

### Boundary decisions

- **`Links` detects, `Mix.Tasks.Brain.Verify` decides severity.** The module
  returns two labelled families; the task chooses which one exits non-zero.
  No severity knowledge moves into `Links`.
- **The two families separate at the public API, not by string-matching one
  list.** `check/1` returning a flat `[String.t()]` cannot be partitioned by a
  caller without parsing prose.
- **Exemptions are unchanged.** Frozen `meta/threads/` bodies, route-tagged
  excerpt sections, ellipsis placeholders, external targets, and code spans stay
  exempt — they are already correct, and gating without them would fail on
  history.
- **Index coverage stays advisory.** It is editorial, and it warns on
  directories mid-restructure where failing would obstruct legitimate work.

## Move 2 — `mix brain.refile`

### Desired flow

```
mix brain.refile <source> <dest>
├── resolve source            accept a repo path or an `em:` id (via Registry)
├── validate                  dest is free; dest dir exists or is created
├── git mv                    preserve rename detection in history
├── rewrite inbound links     every `.md` outside the frozen set
│   ├── prose links           /old/path.md → /new/path.md  (bundle-absolute)
│   └── <routes ref="...">    path back-links only; `em:` refs need no change
├── update indexes            move the entry line: old parent index → new
├── regenerate registry       Registry.write/1
└── report                    links rewritten, indexes touched, residual warnings
```

### The frozen-set subtlety

Thread bodies are verbatim history and their prose links stay as written — a
broken link quoted in a frozen thread is a record, not drift, which is why
`Links` already exempts them. But `<routes ref="path">` back-links inside those
same files **are** verified (`mix brain.route_tags` resolves 149 path
back-links) and must be rewritten. So the frozen set is per-construct, not
per-file: skip prose links in `meta/threads/` and in excerpt sections, rewrite
route-tag path refs everywhere.

### File-tree diff

```
lib/elixir_mind/
  links.ex                      # MODIFIED — split check/1 into two public families
  refile.ex                     # NEW — the move: plan it, apply it, report it
lib/mix/tasks/
  brain.verify.ex               # MODIFIED — gate on link_errors/1
  brain.refile.ex               # NEW — argv parsing, dry-run flag, reporting
test/elixir_mind/
  links_test.exs                # MODIFIED — cover the family split
  refile_test.exs               # NEW — scenario tests over a fixture tree
```

### Signatures

```elixir
# ElixirMind.Links
@spec check(root :: String.t()) :: [String.t()]
@spec link_errors(root :: String.t()) :: [String.t()]
@spec index_warnings(root :: String.t()) :: [String.t()]

# ElixirMind.Refile
@type plan :: %{
        source: String.t(),
        dest: String.t(),
        link_edits: [{path :: String.t(), line :: pos_integer()}],
        index_edits: [String.t()]
      }

@spec plan(source :: String.t(), dest :: String.t(), root :: String.t()) ::
        {:ok, plan()} | {:error, String.t()}
@spec apply(plan(), root :: String.t()) :: {:ok, plan()} | {:error, String.t()}
@spec inbound(target :: String.t(), root :: String.t()) ::
        [{path :: String.t(), line :: pos_integer()}]

# Mix.Tasks.Brain.Refile
@spec run(argv :: [String.t()]) :: :ok
```

### Boundary decisions

- **`plan/3` is pure; `apply/2` owns every side effect.** The dry run is then
  `plan/3` plus rendering, with no second code path to drift — and the tests
  assert on a plan struct rather than on a mutated tree.
- **`Refile` shells out for `git mv` only.** File rewriting is `File.write!`;
  git is used for the rename record, not as a text engine.
- **Index entry lines move, they are not regenerated.** The gloss is editorial
  prose the task must not invent; it relocates the existing line and leaves a
  warning if the target index has no `## Contents` section.
- **The task never fixes prose *around* a moved link.** Sentences can assert
  co-location (this session hit exactly that: a *Seen in* list saying four
  papers were "captured beside this concept"). The task reports every file it
  edited so the operator reviews the surrounding prose; detecting that
  automatically has no oracle.
- **Registry regeneration is in-task, not left to the caller** — the move is
  incomplete without it, and a half-applied refile is the failure this exists
  to prevent.

### Test topology

```
refile_test.exs   → fixture tree under tmp/, real files, real git init
  ├── plan/3 finds inbound links across namespaces (bundle + governance + index)
  ├── plan/3 excludes frozen thread prose, includes route-tag path refs
  ├── apply/2 moves the file and leaves zero unresolved links (Links.link_errors/1 == [])
  ├── apply/2 relocates the index entry line verbatim
  └── plan/3 errors on an occupied dest / unknown em: id

links_test.exs    → link_errors/1 and index_warnings/1 partition check/1
```

`Links.link_errors/1` returning `[]` over the fixture tree after `apply/2` is
the real assertion — the two moves verify each other.

## Build order

1. Split `Links.check/1`; wire `link_errors/1` into `brain.verify`. Ship alone —
   it is independently valuable and currently free (zero warnings).
2. `ElixirMind.Refile` with `plan/3` + tests against a fixture tree.
3. `apply/2`, then the mix task wrapper with `--dry-run`.
4. Regenerate `meta/code-map.md`; add both to the pre-commit hook if #1's
   runtime allows (it already runs there inside `brain.verify`).

## Anchors

- `lib/elixir_mind/links.ex:37` — `check/1`, the function to split
- `lib/elixir_mind/links.ex:95` — `internal_targets/1`, reusable for `inbound/2`
- `lib/elixir_mind/links.ex:112` — `resolve_target/2`, the normalizer
- `lib/mix/tasks/brain.verify.ex:33` — `report_freshness_warnings/0`, where the
  gate splits from the advisory print
- `lib/elixir_mind/registry.ex` — `scan/1` for `em:` id → path resolution
- `lib/elixir_mind/route_tags.ex` — the path-back-link ref format `apply/2` must
  rewrite
- [testing methodology](/knowledge/SWE/testing/elixir-mind-testing-methodology.md)
  — scenario-test conventions for flows

Per [structured-plan-bodies](/meta/policy/structured-plan-bodies.md), re-derive
the current-state tree against `HEAD` before executing: these anchors bind to
line numbers that move.

## Decisions

- **Recommended shape** — two independent moves, #1 shippable on its own.
- **Rejected: id-referenced links with build-time substitution.** Capped at
  ~49% of links, costs the GitHub blob view during audit, adds registry
  indirection to progressive disclosure. Full reasoning in
  [the analysis](/meta/analysis/id-referenced-links-vs-path-links.md).
- **Rejected: gating index coverage too.** Editorial, and it would block
  legitimate mid-restructure states.
- **Rejected: a git hook that refiles on detected renames.** A rename is
  ambiguous at hook time (is it a refile or a delete-plus-create?), and the
  operator's review of surrounding prose is load-bearing.
- **Open question — should `brain.refile` also move a whole directory?** The
  bulk-rename case is directory restructuring, so a `--dir` mode is where most
  of the value sits. Deferred: single-document refile is the smaller, testable
  first cut, and directory mode inherits its machinery.
- **Assumption** — zero current link warnings holds at execution time. If a
  merge lands unresolved links first, #1 blocks until they are fixed, which is
  the gate working rather than a defect.
