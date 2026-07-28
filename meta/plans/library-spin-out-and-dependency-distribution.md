---
type: plan
title: "Library spin-out: knowledge-base repos consuming Elixir Mind as a packaged dependency"
description: Spec for the end-state separation — the library extracts into its own repo, taking the elixir-mind name (this repo renames to knowledge at spin-out to free the slug), and is pulled into each knowledge-base repo as a versioned Mix dependency (git-tag first, Hex when stable), while this repo sheds the code and remains the operator's knowledge base with its provenance anchors and its em: id namespace intact.
status: proposed
provenance: "Claude Code session, 2026-07-17 — operator asked to spec out the separation where the knowledge content (knowledge/, analyses, plans, threads) lives in a dedicated knowledge-base repo, the elixir-mind library is abstracted out, and knowledge repos depend on the library, asking specifically whether distribution would be via something like Hex"
attribution:
  when: 2026-07-17T18:01:24Z
  channel: agent-authored
  agent: "Claude Code agent, library spin-out spec session"
  why: "graduates the deferred Phase 4 spin-out of the bundle/library separation plan into its own executable spec, recording the dependency-distribution decision the operator asked about"
  from: [/meta/threads/2026-07-17-library-spin-out-spec.md]
tags: [meta, plan, architecture, separation-of-concerns, spin-out, hex, dependency, tooling]
timestamp: 2026-07-28
---

# Library spin-out: knowledge-base repos consuming Elixir Mind as a packaged dependency

This plan graduates **Phase 4** of
[separate-okf-bundle-and-elixir-mind-library](/meta/plans/separate-okf-bundle-and-elixir-mind-library.md)
— the deferred spin-out — into its own spec, per the
[persist-plans policy](/meta/policy/persist-plans.md). The parent plan settled
*that* the repo is two deliverables and *where* the boundary runs; this plan
specs *how* they come apart and how the two artifacts relate afterward.

## Target shape — two kinds of repo

**One library repo, N knowledge-base repos.** The end state is not one split
but a one-to-many relationship:

1. **The library repo** — **`elixir-mind`** (operator-decided 2026-07-28,
   reversing the 2026-07-17 call that named it `composable-beliefs-3`: the
   library carries the name outward, and this repo — which holds the
   `ob6to8/elixir-mind` slug today — renames to **`knowledge`** at spin-out
   to free it; open question 1 records the naming history): the Elixir
   package. Contains
   `lib/`, `mix.exs`, `test/` (running against a small fixture bundle), a
   demo OKF bundle for demonstration and tests, the versioned **metadata
   profile spec** (the parent plan's Phase 2 artifact), reusable CI workflow
   definitions, and the tool-wrapper agent skills. It knows nothing about any
   particular collection.
2. **Knowledge-base repos** (this repo is the first and, initially, only
   one): pure OKF collections plus their governance — `knowledge/`,
   `beliefs/`, `inbox/`, `deprecated/`, the whole `meta/` namespace
   (policies, plans, analyses, threads, issues, todos, doctrine,
   elaborations, flows, evals), the root `index.md` tree, the compiled
   `CLAUDE.md`, the editorial skills, and a **thin Mix skeleton** whose only
   job is to pull the library in and configure it for this bundle.

The operator's framing was "knowledge … saved into a dedicated knowledge base
repo." That end state is reached **by subtraction, not by moving the
content**: the library extracts *out*, and what remains of this repo *is* the
dedicated knowledge-base repo. The direction matters for provenance:

- Thread docs anchor on **`pr: <N>`**, and PR numbers are repo-scoped —
  migrating the content to a fresh repo would turn every `pr:` anchor into a
  dangling reference to another repo's PR list.
- Durable docs and the dev-history view cite **commit SHAs** reachable in
  this repo's merge graph; the
  [merge-strategy policy](/meta/policy/merge-strategy.md) exists precisely to
  keep those reachable. A content exodus would orphan all of them.

So: **the bundle keeps the repo; the code leaves — with the name.** The
remaining repo renames to **`knowledge`** at spin-out (operator-decided
2026-07-28; open question 1 records the naming history).

## The dependency mechanism — yes, a Hex-style dep, staged

The operator's question: *would the library be distributed via something like
Hex, and pulled into each knowledge repo as a dep?* **Yes — that is the right
end state**, reached in two stages rather than one jump:

**Stage A — git dependency pinned to a release tag.**

```elixir
# knowledge repo's mix.exs — post-split, ob6to8/elixir-mind is the library repo
defp deps do
  [{:elixir_mind, github: "ob6to8/elixir-mind", tag: "v0.2.0"}]
end
```

- Zero publishing ceremony: cutting a release is `git tag` + push, so the
  library can iterate fast while its API surface is still settling.
- Works with a private repo through existing GitHub auth — no Hex
  organization (paid) needed while the library is private.
- Mix compiles the dep and its **`Mix.Tasks.Brain.*` modules become
  available in the consuming project automatically** — `mix brain.verify`,
  `mix brain.contract`, `mix brain.site` all run from the knowledge repo
  exactly as today; nothing about the operator's workflow changes except a
  one-time `mix deps.get`.

**Stage B — publish to Hex** once the library has a stable v1 API, the
metadata profile spec is versioned, and (if desired) the library goes public:

- Semver resolution (`{:elixir_mind, "~> 1.0"}`), hexdocs-hosted API docs,
  and a checksum-verified, immutable release artifact — the standard way an
  Elixir library is consumed, and the natural move if the library is meant
  for adoption beyond the operator's own bundles.
- Hex is public by default; publishing is also the moment the library's
  README, demo bundle, and profile spec become its public face. Private Hex
  requires a paid organization — hence Stage A first, and Stage B only
  with a deliberate go-public decision.

**Rejected alternatives** (weighing the parent plan's open question 4):

- **Vendored archive** (committing the library into each knowledge repo):
  preserves today's zero-fetch offline property but makes every upgrade a
  manual copy-sweep across N repos and forfeits lockfile/checksum integrity.
  The offline property is better preserved by committing `mix.lock` and
  caching deps in CI; the sandbox environments the no-deps rule was written
  for do have network for `deps.get`.
- **Path dependency**: only works when both checkouts are co-located; fine
  as a local development convenience (`MIX_ENV`-gated override), not a
  distribution mechanism.

The one real cost: `mix.exs` stops being dependency-free, so a fresh sandbox
needs one `mix deps.get` before the toolchain runs. The committed `mix.lock`
pins the exact version; CI caches the fetch; and the SessionStart hook can run
`deps.get` so agents never see the difference.

## What the library must gain first — the config surface

The spin-out is blocked on the parent plan's **Phase 3 configurability
audit**. For N bundles to share one library, every bundle-specific constant
must move from code to the consuming repo's `config/config.exs`, which
becomes in effect the **bundle manifest**:

| Setting | Today | Post-split |
|---------|-------|-----------|
| Site base URL, repo URL | Already in `config/config.exs` | Unchanged — pattern to copy |
| Id namespace prefix (`em:`) | Hardcoded across verifier, registry, route tags, dedup probe | `config :elixir_mind, id_prefix: "em"` — a per-bundle setting; `em` is the default and both known bundles use it (see the id-namespace section below) |
| Bundle root | Assumed = cwd/repo root | Configurable path (default `.`) |
| Excluded / non-bundle directories (`deprecated/`, `inbox/`, `.claude/`, …) | Hardcoded carve-out lists | Configurable list with the current values as defaults |
| Controlled `type` vocabulary | In verifier + policy prose | Bundle-declared list; library enforces membership-in-declared-list, not a fixed list — vocabulary ratification stays a per-bundle governance act |
| Attribution `channel` vocabulary | Same | Same treatment |
| Reserved filenames, frontmatter schema shape | Library code | Stay in the library — this **is** the Elixir Mind metadata profile, the interface every conforming bundle shares |

The last row is the boundary test from the parent plan: what is *profile* (the
library defines and enforces it, versioned with the package) versus what is
*instance* (each bundle declares it in config). The oracle for Phase 3
completeness is unchanged: **the library's tests pass against a fixture
bundle that is not this one.**

## Id namespaces are per-bundle

**The prefix is a bundle-manifest setting, and both known bundles set it to
`em:`** (operator-decided 2026-07-28, superseding the interim `cb:`/`dm:`
demo-prefix choices that tracked the library's earlier name). `em`
mnemonically mirrors elixir-mind — now the *library's* name — so the prefix
travels with the schema: the demo bundle mints under `em:`, and this repo's
existing `em:` ids ride through both the spin-out and the repo's own rename
to `knowledge` unchanged, with no migration. The
[stable-identity policy](/meta/policy/stable-identity.md) is untouched: the
prefix is a namespace token, not part of a document's identity, it stays
opaque (nothing may depend on its letters carrying meaning), and the config
surface above keeps it per-bundle — the library enforces *shape*
(`<prefix>:[0-9a-f]{6}`) with `em` as the default, and a future bundle may
still configure its own.

Three refinements to the "documents split out to the lib get their own
prefix" framing:

- **Almost nothing carrying an `em:` id actually moves.** The docs that
  belong to the library concern — tooling tutorials, the code map, plans and
  analyses about the machinery — live in the **governance namespace and carry
  no `em:` id at all**. Bundle documents with `em:` ids are knowledge
  content, and they stay. So the demo bundle is not a re-labeling of
  migrated documents; it mints **new** ids, under the same `em:` prefix.
- **Identity is bundle-scoped; it does not transfer across bundles.** If a
  document ever genuinely relocates from one bundle to another, it is filed
  as a new document in the destination (minting a fresh id under the
  destination prefix) and the source id retires — minted once, never reused,
  per the stable-identity policy. Tail uniqueness is likewise per-bundle:
  with both bundles minting under `em:`, two bundles may coincidentally
  produce the same fully-qualified id, so any future cross-bundle reference
  scheme must qualify refs by bundle rather than relying on prefixes to keep
  them distinct.
- **The prefix half of the Phase 3 oracle moves into the test suite.** With
  the demo bundle on `em:`, a green run against the fixture no longer proves
  the prefix is lifted into config — that proof becomes a dedicated test
  overriding `id_prefix` over a small synthetic corpus. The fixture remains
  the acceptance oracle for every other manifest field (paths, directory
  lists, vocabularies).

## The shape, structured

*(Retrofit per
[structured-plan-bodies](/meta/policy/structured-plan-bodies.md), audited
against `main` at `d08abf2`, 2026-07-28. This section grounds the
config-surface table above in the actual coupling sites and specs the target
architecture; the decisions above are unchanged, and the design questions it
surfaced are appended to the open questions below.)*

**The swappable-bundle property, stated once.** The library's entire knowledge
of a particular collection reduces to two inputs: a **bundle root** (a path to
an OKF checkout) and a **manifest** (the consuming repo's config). Any client
that supplies both gets the full toolchain over its own bundle — this repo's
agent sessions, another operator's knowledge-base repo, CI, and the
[thin Jido host](/meta/plans/thin-jido-brain-host.md) (which drives the same
`brain.*` verbs over a checkout) are the same call path with different
manifests. Nothing else in the library may know which bundle it operates on —
that invariant is what makes the bundle swappable and the architecture
client-agnostic.

### Current state — where the library binds to this bundle

The inventory of bundle-specific constants in `lib/` at audit time (module
attributes unless noted) — the concrete work-list behind the parent plan's
Phase 3. Completeness is guaranteed by the fixture-bundle oracle, not by this
table.

| Group | Constant | Sites |
|---|---|---|
| Already config | `site_base_url`, `repo_url` | `config/config.exs`, read only via `ElixirMind.SiteConfig` (default base URL also hardcoded at `site_config.ex:24`) |
| Id namespace | `em:` prefix | `registry.ex:21` (`@id_format`), `registry.ex:47` (minting), `route_tags.ex:222` (`classify_ref/1`), `attribution.ex:305` (`resolves?/3`), `dedup_probe.ex:215` (id regex) |
| Namespace layout | three overlapping excluded-dir lists | `registry.ex:22`, `links.ex:31`, `site_config.ex:28` |
| | anchored non-bundle dirs | `orphans.ex:28` (`@anchored_dirs`) |
| | attribution exemption globs/prefixes | `attribution.ex:64`, `attribution.ex:75-78` |
| Vocabularies | attribution `channel` list | `attribution.ex:38` (`@channels`) |
| | statement types | `verifier.ex:36` (`@statement_types`) |
| | glossary senses | `verifier.ex:38` (`@senses`) |
| Governance addresses | policy dir; contract output + preamble; registry output; threads dir; flows dir + lineage index; glossary dir + index; code-map, dev-history, dedup-gold outputs; session-init dirs | `policy.ex:25`, `contract.ex:16-17`, `registry.ex:127`, `route_tags.ex:47`, `lineage.ex:32-33`, `glossary.ex:34-35` + `verifier.ex:37`, `code_map.ex:26`, `dev_history.ex:31`, `dedup_probe.ex:48`, `session_init.ex:89-122` |
| This-bundle-only code | reorg-history path mapping and backfill heuristics | `attribution/backfill.ex` (e.g. `pre_reorg_path/1`) — migration code for *this* repo's 2026-07 attribution backfill |
| Project identity | app `:elixir_mind`, zero deps | `mix.exs` |

Notably absent: the controlled `type` vocabulary. The verifier enforces
non-empty `type` (OKF conformance), not list membership — so the config
table's "library enforces membership-in-declared-list" row is a **new** check
the manifest enables, not a lift of an existing one.

### Desired state — the manifest and the `Bundle` struct

One module owns all instance knowledge; everything else takes it as an
argument.

```elixir
# knowledge repo's config/config.exs — the bundle manifest
config :elixir_mind,
  bundle_root: ".",
  id_prefix: "em",                     # library enforces <prefix>:[0-9a-f]{6}
  site_base_url: "https://ob6to8.github.io/knowledge/",  # post-rename Pages home
  repo_url: "https://github.com/ob6to8/knowledge",
  type_vocabulary: ~w(note claim concept reference source person project area
                      snippet methodology policy tutorial issue plan analysis
                      todo elaboration doctrine belief),
  attribution_channels: ~w(intake auto-intake glossary agent-authored backfill),
  excluded_dirs: [...],                # today's hardcoded values as defaults
  anchored_dirs: ~w(meta/threads inbox survey journal),
  governance: [
    policy_dir: "meta/policy",
    preamble: "meta/preamble.md",
    contract_output: "CLAUDE.md",
    registry_output: "meta/registry.md",
    threads_dir: "meta/threads",
    flows_dir: "meta/flows",
    glossary_dir: "beliefs/glossary"
  ]
```

```elixir
defmodule ElixirMind.Bundle do
  @type t :: %__MODULE__{
          root: Path.t(),
          id_prefix: String.t(),
          type_vocabulary: [String.t()],
          attribution_channels: [String.t()],
          excluded_dirs: [String.t()],
          anchored_dirs: [String.t()],
          governance: map(),
          site_base_url: String.t() | nil,
          repo_url: String.t() | nil
        }

  @spec load(overrides :: keyword()) :: t
  @spec id_regex(t) :: Regex.t()
  @spec mint_id(t) :: String.t()
  @spec bundle_doc?(t, rel_path :: String.t()) :: boolean()
  @spec excluded?(t, rel_path :: String.t()) :: boolean()
end
```

Entry points shift from a bare root path to the struct (root subsumed):

```elixir
@spec run(ElixirMind.Bundle.t(), keyword) :: :ok | {:error, [String.t()]}
# ElixirMind.Verifier.run/2 today; likewise Registry.scan/1, RouteTags,
# Site, Contract, Glossary, … — every module that now calls File.cwd!()
```

### File-tree diffs

The library repo (`elixir-mind`, on the freed slug), created by history
extraction — with the library keeping the name, **no app or module rename is
needed**: `:elixir_mind` and the `ElixirMind` namespace travel as-is.

```
elixir-mind/                       # the library repo, post name-swap
├── mix.exs                        # app :elixir_mind, unchanged; still zero deps
├── lib/
│   ├── elixir_mind/              # ← unchanged module namespace
│   │   ├── bundle.ex             # NEW — manifest struct, single config read point
│   │   └── …                     # existing modules, attrs → Bundle fields
│   └── mix/tasks/                # the task suite (naming: open question 7)
├── test/                         # existing suite, retargeted at the fixture
├── priv/demo_bundle/             # NEW — demo/fixture OKF bundle (mints em: ids)
├── profile/metadata-profile.md   # NEW — the versioned schema spec (parent Phase 2)
└── .github/workflows/gates.yml   # NEW — reusable (workflow_call) gate suite
```

This repo (renamed to **`knowledge`** at spin-out), after the removal PR:

```diff
 knowledge/                        # this repo, under its new name
-├── lib/                          # extracted
-├── test/
~├── mix.exs                       # thin: app + {:elixir_mind, tag: …}
+├── mix.lock                      # pins the dep; offline property via CI cache
~├── config/config.exs             # becomes the bundle manifest (above)
~├── .github/workflows/ci.yml      # shrinks to `uses: …/gates.yml@vX` + deps cache
~├── .github/workflows/pages.yml   # stays per-bundle; calls the dep's tasks
 ├── knowledge/ beliefs/ meta/ …   # untouched — the collection and its governance
 └── .claude/skills/               # editorial skills stay; tool-wrappers move (Q3)
```

### Call/flow trees

Production — every task, one shape:

```
mix brain.<task>                   # run from a knowledge repo
└── Bundle.load()                  # reads the manifest; the only Application.get_env site
    └── <Module>.run(bundle, opts)
        └── file IO under bundle.root, filtered by bundle.excluded_dirs / bundle_doc?/2
```

Test — the manifest is the seam; the production code path runs unmodified:

```
ExUnit (in the library repo)
└── Bundle.load(root: "priv/demo_bundle", …)   # id_prefix defaults to "em"
    └── <Module>.run(bundle, opts)  # same path as production, different manifest
        # a separate test overrides id_prefix over a synthetic corpus —
        # the prefix half of the Phase 3 oracle
```

### Boundary decisions

- **`Bundle.load/1` is the single config read point.** Every other module
  receives instance knowledge as an explicit argument — which is also what
  lets the fixture-bundle tests exercise the production code path with a
  substituted manifest rather than a mock.
- **Profile vs. manifest, operationalized:** the library owns *shape*
  (frontmatter schema, id shape `<prefix>:[0-9a-f]{6}`, attribution map
  structure, reserved filenames); the manifest owns *values* (the prefix, the
  vocabularies, the directory lists, the URLs). The test: a rule a second
  bundle could legitimately set differently is a manifest field; one it
  couldn't is profile.
- **Vocabularies are membership checks against declared lists.** The library
  ships no normative type or channel list; ratifying an addition stays a
  per-bundle governance act — an edit to that bundle's manifest.
- **The three excluded-dir lists collapse into manifest fields** with today's
  values as defaults; per-module deltas (`Registry` additionally skipping the
  governance dirs, `Orphans`' anchored dirs) become derived views over the
  same fields, not independent lists.
- **Detection vs. side effects, unchanged:** library modules detect and return
  error lists; mix tasks own exit codes and writes — the split the codebase
  already has, now with `Bundle.t` threaded through it.

### Anchors

- **Coupling sites:** the current-state table above (file:line at `d08abf2`).
- **Pattern to copy:** `ElixirMind.SiteConfig`
  (`lib/elixir_mind/site_config.ex`) is the existing config-not-constant
  precedent; `Bundle` generalizes it and absorbs it.
- **Reuse:** `Registry.scan/1` is the shared walk every checker builds on —
  the first function to take `Bundle.t`, and the choke point where
  `excluded_dirs`/`bundle_doc?/2` apply.
- **Tests that prove the property:** the full gate suite green against
  `priv/demo_bundle` (the Phase 3 oracle for paths, directory lists, and
  vocabularies); a prefix-override test running the verifier over a small
  synthetic corpus with a non-`em` `id_prefix` (the prefix half of the
  oracle); a regression asserting
  `Bundle.load/1` is the only `Application.get_env` caller; this repo's CI
  green on the removal PR with the manifest set to today's values (behavioral
  no-op).

### Decision list (this section)

- **Recommended:** explicit `Bundle.t` argument threading over ambient config
  reads; manifest defaults equal to today's hardcoded values so the removal PR
  here is behaviorally a no-op; the demo bundle doubles as test fixture and
  Phase 3 oracle.
- **Rejected:** per-module config keys (re-scatters the manifest across the
  namespace); a process-dictionary or agent-held bundle context (implicit
  state defeats the test seam); a standalone YAML/markdown manifest file
  parsed at runtime (`config.exs` is already the established per-repo
  manifest surface and needs no new parser).
- **Open questions surfaced:** 5–7 below.

## What each knowledge-base repo keeps

- **A thin `mix.exs`** — the knowledge repo's own app name, the
  `:elixir_mind` dep, nothing else. (With the library keeping the elixir-mind
  name, the extraction involves no OTP-app or module rename — `:elixir_mind`
  and `ElixirMind` travel as-is; only the knowledge repo's thin skeleton app
  takes a new name (for this repo, `:knowledge`), alongside the repo itself.
  The `mix brain.*` task names
  are independent of app names and stay as they are, so the operator-facing
  command surface is unchanged.)
- **`config/config.exs`** — the bundle manifest (table above).
- **Thin CI** — the gate suite invoked from the dep. Preferably the library
  repo publishes a **reusable workflow** (`workflow_call`) so each bundle's
  `ci.yml` shrinks to a few lines and gate-suite evolution ships with library
  releases; `pages.yml` stays per-bundle (deploy target and cadence are
  bundle concerns) but calls the same tasks.
- **Editorial skills** (`/intake`, `/capture`, `/add-to-glossary`,
  `/research`, …) — they encode *this bundle's* policy and stay. Tool-wrapper
  skills (`/render-contract` and kin) move to the library and are consumed as
  a Claude Code plugin or vendored templates (open question 3).
- **`CLAUDE.md`** — still compiled per-bundle from that bundle's
  `meta/policy/` by the library's contract compiler; still CI-checked. A
  library upgrade that changes compiled framing shows up as `--check` drift
  the upgrade PR must recompile — the version pin makes contract changes
  reviewable events rather than ambient drift.

## Migration mechanics

1. **Create the library repo** by history extraction, not fresh start:
   `git filter-repo` over `lib/`, `test/`, `mix.exs`, and workflow files, so
   the library's own commit → session provenance survives in its new home.
   No app or module rename — the code already carries the library's name.
   This rewrites nothing here — this repo's history is untouched.
   The **name swap** is its own sequenced motion: rename this repo to
   **`knowledge`** first (freeing the `elixir-mind` slug; git remotes and web
   links redirect), then create the library repo on the freed slug. The
   moment the library claims it, GitHub's rename redirects for this repo's
   old URLs **retire** — old clone URLs and blob links resolve to the
   library instead — so the two steps land back-to-back, remotes are updated
   immediately, and this repo's `site_base_url`/`repo_url` config
   (→ `https://ob6to8.github.io/knowledge/`) plus a `mix brain.contract` +
   `mix brain.site` recompile ship in the same motion (the Pages URL moves
   with the rename; it does not redirect).
2. **Author the demo bundle** in the library repo: a dozen-document OKF
   collection minting `em:` ids, exercising every schema feature
   (ids, attribution, verification edges, route tags, glossary), doubling as
   the test fixture.
3. **Land Phase 3** (config surface) in the library repo, gated on the
   fixture-bundle oracle.
4. **The removal PR here**: delete `lib/`, `test/`, most of `mix.exs`; add
   the dep + manifest config; swap CI to the reusable workflow; recompile
   generated artifacts. One PR, one true merge — the deletion is ordinary
   additive history, severing nothing.
5. **Tag `v0.1.0`** on the library; this repo pins it. Hex publication
   (Stage B) waits for API stability and the go-public call.

## Scope boundaries

- **Naming is decided; no rename executes now.** Operator calls 2026-07-28
  (reversing the 2026-07-17 resolution): the spun-out library takes
  **`elixir-mind`**, and this repo renames to **`knowledge`** at spin-out to
  free the slug. Nothing renames until the extraction executes; until then
  this repo's Pages URL and remote refs stay put. No app or module rename
  happens at any point — the code already carries the library's name.
- **No schema changes.** The split moves the schema's *enforcement point*,
  not its content.
- **This plan does not execute anything.** It is the spec the parent plan's
  Phase 4 deferred to; execution follows ratification, after the parent
  plan's Phases 1–3 land.

## Open questions

1. ~~**Naming** (inherited)~~ — **fully resolved, in two rounds.**
   2026-07-17: this repo keeps `elixir-mind`; the library is
   `composable-beliefs-3`. 2026-07-28 (operator, superseding that): the
   library takes **`elixir-mind`**; this repo renames to **`knowledge`** at
   spin-out (two repos cannot share the `ob6to8/elixir-mind` slug); and the
   id prefix is **`em:`** across the board — the demo bundle mints under it,
   this bundle's ids ride through the rename unchanged, and no prefix
   migration accompanies the repo rename (the prefix now mirrors the
   *library*, whose name is stable). The rename's costs are recorded in
   migration step 1: the Pages URL moves to the new slug, and GitHub's
   redirects for `ob6to8/elixir-mind` retire when the library claims it.
2. **Public or private library?** Stage B (Hex) implies public; private
   forever means staying on git-tag deps, which is workable indefinitely.
   (If public, the Hex package name is naturally `elixir_mind`.)
3. **Skill distribution**: Claude Code plugin from the library repo (clean
   updates, new machinery) vs. vendored skill templates (simple, drifts).
4. **Governance-doc dedup post-split**: which `meta/policy/` docs that
   restate library-enforced mechanics shrink to pointers at the library's
   docs (parent plan's open question 3) — needs a doc-by-doc pass in the
   removal PR.
5. **Statement types and glossary senses — profile or manifest?**
   `@statement_types` implements the verification-grounding policy's
   semantics and `@senses` the glossary's sense model. Leaning **profile**
   (they define what verification and sense *mean*, not which values this
   bundle chose), with a manifest override deferred until a second bundle
   actually wants different semantics.
6. **Disposition of `attribution/backfill.ex` at extraction.** It encodes
   this repo's 2026-07 reorg history (`pre_reorg_path/1` and kin) and its
   backfill has landed. Retire it in the extraction, or park it
   bundle-side? Leaning **retire** — git history keeps it, and a library
   module hardcoding one bundle's past paths is the coupling this plan
   removes.
7. **Task-namespace coordination with the
   [brain.\* → mind.\* rename plan](/meta/plans/rename-brain-tasks-to-mind.md).**
   After extraction the task names ship to every consuming bundle, so that
   rename must land either before extraction (here) or after it (in the
   library repo) — and with the library itself named elixir-mind, `mind.*`
   now aligns naturally with the library's name. Sequencing (and whether the
   rename still carries its weight) is an operator call; the plan above
   deliberately keeps the operator-facing command surface stable in the
   meantime.
