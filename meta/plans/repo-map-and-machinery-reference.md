---
type: plan
title: "Repo-map and machinery reference: catalog the non-bundle tooling by routing to existing generators, not new hand-kept glossaries"
description: Catalog the repo's directories, files, config surface, data structures, and commands by routing most into the existing glossary and generated code map, and building one new generated artifact (mix brain.repomap, --check-gated) for the true gap — the non-bundle machinery.
status: proposed
tags: [tooling, code-map, glossary, generated-artifacts, reference, machinery]
timestamp: 2026-07-23
attribution:
  when: 2026-07-23T18:48:28Z
  channel: agent-authored
  agent: "Claude Code agent, interactive session (session-start hook comment → machinery-reference design)"
  why: "operator asked to create glossaries for the repo's directories/files/variables/data-structures/commands; design reshaped to fit the generated-artifact ethos and escalated to a plan (new mix task + CI gate = shape change)"
---

# Repo-map and machinery reference

## Problem

The operator asked for "several new glossaries" cataloguing the repository's own
machinery, in five categories: **directories** (e.g. `.git/hooks`), **files**
(e.g. `.claude/hooks/session-start.sh`), **"variables"** (e.g. the git config key
`core.hooksPath`), **data structures** used through the codebase, and **Elixir
commands** (`mix format --check-formatted`, `mix brain.contract --check`, …).

The motivating observation is real: an agent (or human) reading this repo cold has
no single place that says *what `.githooks/` is for*, *what `session-start.sh`
does*, *which environment variables the tooling reads*, or *what the handful of
non-`brain.*` mix commands are*. That knowledge is currently scattered across
`CLAUDE.md`, per-directory `index.md` files, the tutorials, and the code
docstrings.

But a literal "five hand-written glossaries" reading collides with this repo's
dominant design law: **generated artifact + `--check` gate, never hand-kept, never
duplicated** — the discipline behind `CLAUDE.md`, `meta/registry.md`,
`meta/code-map.md`, and `meta/dev-history.md`. Five hand-kept catalogs would
**drift** the instant a file is renamed or a task is added (no generator, no gate)
and would **duplicate** three things that already exist:

- the **code map** ([`meta/code-map.md`](/meta/code-map.md)) — generated from
  `lib/` docstrings by `mix brain.codemap`, `--check`-gated — already documents
  **every `lib/*.ex` file**, **all 16 `mix brain.*` commands** with usage, and the
  declared `@type`s;
- the **glossary** ([`/beliefs/glossary/`](/beliefs/glossary/index.md)) — already
  holds machinery/ecosystem *terms* (`mix-task`, `otp`, `sessionstart-hook`,
  `posttooluse-hook`, `skill`, `plugin`, `routine`, `git-trailer`,
  `github-pages`, `webhook`, …) as `common`/`dual`-sense entries, accreted by
  `/add-to-glossary`;
- the **layout prose** in [`README.md`](/README.md) ("Layout") and
  [`meta/index.md`](/meta/index.md) ("Related tooling"), which already narrate the
  top-level bundle + primary-tooling structure.

So the design is not "build five glossaries." It is: **route four categories into
machinery that already exists, and build exactly one new generated artifact for the
category that has no home** — the non-bundle *machinery* directories, the non-`.ex`
files, and the config/env-var surface.

## Decisions (ratified in-session 2026-07-23)

1. **Generated, not hand-kept.** The one new artifact is compiled by a new
   `mix brain.repomap` task and guarded by `mix brain.repomap --check` in CI and
   the pre-commit hook, on the identical discipline as `mix brain.codemap`. A
   plain hand-written governance doc was rejected: it would drift like any prose,
   against the repo's whole ethos.

2. **"Data structures" = enrich the code map, not a new doc.** The *document*
   data model (the frontmatter field set, the `attribution` map, the
   routing-ledger row, the `<routes>` region) is **already canonical and
   machine-enforced** — defined in `CLAUDE.md` §1 and the `frontmatter-schema` /
   `resource-attribution` / `routing-ledger` / `route-tagging` policies, validated
   by `mix brain.verify` rules 1–8. Re-documenting it would fragment a source of
   truth and drift from a machine-checked one. So we **cross-link** to those
   policies and do **not** recopy them. The genuine gap is three `@moduledoc false`
   in-memory structs the code map omits — `%ElixirMind.Lineage.Flow{}`,
   `ElixirMind.Registry.Entry`, and the `ElixirMind.DevHistory` entry struct —
   which we cover by **enriching their docstrings and un-hiding them** so the
   existing code map grows to include them.

## The shape of the change — where each of the five categories routes

| Category | Route | Mechanism |
|----------|-------|-----------|
| **Directories** | new `meta/repo-map.md` | `mix brain.repomap` walks the non-bundle machinery tree (`.git/hooks`, `.githooks/`, `.claude/hooks/`, `.claude/skills/`, `.github/workflows/`, `config/`, `_build/`, `lib/mix/tasks/` vs `lib/elixir_mind/`, `test/`, `deprecated/`) with a hand-authored one-line intent per dir, held in a source the generator reads (see "artifact shape") |
| **Files (non-`.ex`)** | new `meta/repo-map.md` | same generator: shell scripts (`session-start.sh`, `pre-commit`), workflow YAML (`ci.yml`, `pages.yml`), `config.exs`, `mix.exs`, `.formatter.exs`, `.gitignore` — purpose + when it runs. (`lib/*.ex` stays in the code map.) |
| **"Variables" (config surface)** | new `meta/repo-map.md` | env vars (`CLAUDE_CODE_REMOTE`, `CLAUDE_PROJECT_DIR`, `CLAUDE_CODE_REMOTE_SESSION_ID`, `DEBIAN_FRONTEND`, `HTTPS_PROXY`), git config keys (`core.hooksPath`), Elixir app config (`:elixir_mind, :site_base_url`, `:repo_url`). The *portable concept* of each (what a git hook / env var *is*) routes to the **glossary** instead. |
| **Data structures** | **existing** `meta/code-map.md` | enrich + un-hide the three `@moduledoc false` structs (decision 2); the document/frontmatter model stays canonical in policy, cross-linked |
| **Elixir commands** | mostly **existing** code map + `meta/index.md` | all `mix brain.*` already documented; the new artifact adds only the standard commands (`mix format --check-formatted`, `mix compile`, `mix test`) as the gate suite runs them |
| **Portable concepts** (cross-cutting) | **existing** glossary | `/add-to-glossary` entries for `git hook`, `core.hooksPath`, `pre-commit hook`, `environment variable`, `core.hooksPath` etc. as `common`/`dual`-sense terms — feeds any response that needs to cite them |

## Artifact shape — `meta/repo-map.md` via `mix brain.repomap`

Open question to settle at build time: **where the hand-authored descriptions
live.** The code map solves this by reading `@moduledoc` from the source itself —
there is no equivalent docstring anchor for a directory or a shell script. Two
candidate designs, to decide when we build:

- **(a) A checked-in data file** (e.g. `meta/repo-map.data.md` or a small
  structured source the task parses) holding `path → one-line intent`, from which
  `mix brain.repomap` renders `meta/repo-map.md`. The generator supplies the tree
  walk + drift check; the human supplies the prose. Closest analogue to how the
  gold-set docs (`meta/evals/`) pair a parsed source with a rendered view.
- **(b) Header comments in the machinery files themselves** (shell scripts and
  YAML already carry top-of-file comments — `session-start.sh` and `pre-commit`
  both do) that the task extracts, mirroring `@moduledoc` extraction. Elegant
  where a file exists to host the comment; no home for a *directory*'s description,
  so this needs a fallback source for dirs regardless.

Leaning **(a)** for uniformity (dirs and files use one mechanism) with the option
to later pull file-level intent from header comments. The `--check` gate compares
the checked-in `meta/repo-map.md` against a fresh render and fails on divergence,
exactly like `mix brain.codemap --check`.

## Build order

1. **Glossary pass** (`/add-to-glossary`) — file the portable concepts as
   `common`/`dual` terms: `git hook`, `core.hooksPath`, `pre-commit hook`,
   `environment variable`, `SessionStart hook` (verify it isn't already there;
   `sessionstart-hook` exists — extend if needed). Independent of the tooling
   work; can land first.
2. **Code-map enrichment** — write `@moduledoc`/`@typedoc` for `%Lineage.Flow{}`,
   `Registry.Entry`, and the `DevHistory` entry struct; un-hide them; run
   `mix brain.codemap` to regenerate `meta/code-map.md`; confirm
   `mix brain.codemap --check` stays green. Small, self-contained.
3. **`mix brain.repomap` generator** — `ElixirMind.RepoMap` module (tree walk +
   render + `check/1`) and the `mix brain.repomap` task, with the description
   source chosen per "artifact shape". Zero-dependency, offline, like every other
   `brain.*` task. Ships with red+green tests in `test/`.
4. **Author the descriptions** — fill the description source for every machinery
   dir, non-`.ex` file, and config/env var; render `meta/repo-map.md`; list it in
   `meta/index.md`.
5. **Wire the gate** — add `mix brain.repomap --check` to `.github/workflows/ci.yml`,
   `.githooks/pre-commit`, and (if it renders) the Pages build, beside the other
   `--check` gates.

Steps 1–2 are independent and low-risk; steps 3–5 are the shape change proper and
the reason this is a plan rather than an in-session edit.

## Scope boundaries

- **In:** the non-bundle machinery catalog, the three-struct code-map enrichment,
  the portable-concept glossary entries, one new task + gate.
- **Out:** re-documenting the frontmatter/attribution/ledger/routes model (already
  canonical in policy — cross-link only); any change to the knowledge-bundle
  taxonomy; a new top-level directory (the new artifact lives in the existing
  `meta/` governance namespace, so no taxonomy ratification is needed beyond this
  plan).

## Why a plan (not executed in-session)

Substantial standalone design (the route-don't-duplicate decomposition), a shape
change requiring ratification (new `mix brain.repomap` task + CI gate +
docstring/struct visibility changes), and a cross-session build order — three of
the [plan-vs-capture](/meta/policy/plan-vs-capture.md) escalators. Building it
inline would mean autonomously adding new tooling and a new artifact kind, which
the taxonomy/shape rules reserve for operator ratification.
