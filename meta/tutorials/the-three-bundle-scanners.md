---
type: tutorial
title: The three bundle scanners — Registry, Verifier, and RouteTags
description: How the toolchain walks the repository — one base scanner (Registry.scan) that enumerates knowledge-bundle concepts through a directory-exclusion filter, and two consumers (the Verifier and RouteTags) that build on it, with RouteTags adding a second scan surface over meta/threads and bridging the governance and knowledge namespaces by stable id.
tags: [meta, tooling, elixir, registry, verifier, route-tags, scanning, architecture]
timestamp: 2026-07-09
attribution:
  when: 2026-07-09T12:10:09+00:00
  channel: backfill
  agent: "reconstructed by mix brain.attribution --backfill, 2026-07-13"
---

# The three bundle scanners — Registry, Verifier, and RouteTags

Three of the `mix brain.*` tasks work by **walking the repository and reading
files**: the registry (`mix brain.registry`), the verifier (`mix brain.verify`),
and the route-tag checker (`mix brain.route_tags`). It is tempting to think of
them as three independent crawlers. They are not. There is **one** scanner —
[`ElixirMind.Registry.scan/1`](/lib/elixir_mind/registry.ex) — and the other
two are *consumers* of it. Understanding that hierarchy explains what each tool
sees, what it deliberately ignores, and why fixtures placed under `test/` are
invisible to all three.

## The shared foundation: `Registry.scan/1`

Everything starts here. `scan/1` answers one question — *what are the bundle's
concepts?* — and answers it the same way for every caller:

```elixir
def concept_paths(root \\ File.cwd!()) do
  root
  |> Path.join("**/*.md")
  |> Path.wildcard()          # every markdown file under root
  |> Enum.map(&Path.relative_to(&1, root))
  |> Enum.reject(&excluded?/1) # drop non-bundle paths
  |> Enum.sort()
end
```

Each surviving path is read, its YAML frontmatter parsed, and folded into an
`Entry` struct — `{id, concept_id, path, type, title, verified, resource,
verified_by}`. `scan/1` returns `{entries, errors}`, where `errors` collects two
failure classes: files whose frontmatter won't parse, and **duplicate ids**
(two concepts claiming the same `em:` id). That is the whole scan: *wildcard →
exclude → parse → struct*, with duplicate-id detection folded in.

The scoping is the interesting part. The registry is the **stable-identity
layer**, and identity is a property of *knowledge-bundle concepts only* — not
governance, not tooling, not the archive. So `excluded?/1` drops any path whose
top-level directory or basename is on a fixed list:

| Excluded | Why it isn't a bundle concept |
|----------|-------------------------------|
| `.git` `.github` `.githooks` `_build` `deps` `tmp` | machinery, not knowledge |
| `.claude` | skills — agent behavior, not concepts |
| `lib` `test` | the Elixir toolchain (and its fixtures) |
| `meta` | governance namespace — policies, threads, tutorials, this file |
| `inbox` | the daily candidate feed — a non-bundle namespace with no `em:` ids |
| `deprecated` | the read-only archive of legacy content |
| `index.md` `log.md` `README.md` `CLAUDE.md` | reserved/generated files, any level |

A path survives only if it is a real concept living at the root or in a
knowledge subdirectory. This single filter is what keeps the identity layer
scoped, and it is why a `type: plan` doc under `meta/plans/` or a fixture concept
under `test/scenarios/` never receives an `em:` id or shows up in the registry —
they are structurally outside the scan.

`Registry` then adds the *compiled view* on top of the scan: `render/1` sorts the
id-bearing entries and emits `meta/registry.md`; `check/1` compares that render to
what's on disk and reports staleness. But the crawl underneath is `scan/1`.

## Scanner 2: the Verifier — same corpus, plus rules

[`ElixirMind.Verifier.run/1`](/lib/elixir_mind/verifier.ex) does **not** walk
the tree itself. Its first line delegates:

```elixir
{entries, scan_errors} = Registry.scan(root)
```

It inherits exactly the registry's corpus and exclusions, then layers rule checks
over each entry, accumulating human-readable error strings:

| Rule | What it enforces |
|------|------------------|
| **type** | every concept has a non-empty `type` (OKF conformance) |
| **id** | every concept carries an `id` matching `em:[0-9a-f]{6}` |
| **edges** | every `verified_by` reference resolves to an existing id in the corpus |
| **grounding — capture** | a concept with a `resource` (a capture) may not be `verified: true` |
| **grounding — evidence** | `verified: true` requires a non-empty `verified_by` |

`run/1` returns `:ok` or `{:error, errors}` (the scan errors prepended). Every
rule above is the registry's scan **plus a validation pass** — no new files, only
*judgments* about the files the registry already found.

One rule breaks that pattern: **index-listing coverage**
(`ElixirMind.Links.unlisted_errors/1` — a directory's *existing* `index.md`
must list every doc and subdirectory filed beside it, `evals/` excepted). It
does open a second door, the way RouteTags does below — `Links.doc_paths/1` is
its own wildcard-plus-exclusion walk, scoped differently from the registry's
(it *includes* `meta/` and `inbox/`, which the registry excludes as
non-bundle namespaces, and stays out of `test/`/`deprecated/` like the
registry does). So `mix brain.verify` still never trips over a fabricated id
under `test/` — but it does now judge a stale `meta/plans/index.md` the same
as a stale `knowledge/` one.

## Scanner 3: RouteTags — a second surface, bridged by id

[`ElixirMind.RouteTags.run_checks/1`](/lib/elixir_mind/route_tags.ex) is the
one that adds something genuinely new, because the route-tagging convention spans
**two namespaces the registry keeps apart**:

```elixir
threads  = scan_threads(root)              # NEW surface: meta/threads/*.md
concepts = bundle_concepts(root)           # reuses Registry.scan
id_index = Map.new(concepts, &{&1.id, &1.path})
sinks    = scan_sinks(root, concepts)      # excerpt logs inside concepts
```

- **`scan_threads/1`** globs `meta/threads/*.md` (minus `index.md`) and runs
  `parse_regions/1` over each to extract the `<routes ref="…">` tag regions.
  Note the directory: `meta/threads` is *excluded from the registry* — threads
  are governance records with no `em:` id. The registry's own scan would never
  surface them, so RouteTags reaches into that namespace directly.
- **`bundle_concepts/1`** is just `Registry.scan(root)` keeping the id-bearing
  entries — the same base scanner again.
- **`scan_sinks/2`** reads each concept and pulls its
  `## Thread excerpts — route-tagged log` blocks via `parse_log_section/1`.

The bridge is the **stable id**. A tag in a governance-namespace thread
(`<routes ref="em:d479e3">`) points at a knowledge-namespace concept via its
registry id. So RouteTags is the one scanner that joins the two namespaces — it
reads tags from files the registry excludes, and resolves them against the
identity layer the registry compiles. Its five checks (wellformedness, ref
resolution, sink logs, log fidelity, and the warn-level ledger cross-check) all
run off those three reads, and `materialize/1` writes each sink's log back from
the current tags so the log stays a derivation, never a hand-kept copy.

## How they compose

```
              Path.wildcard + exclusion filter + frontmatter parse
                              │
                    Registry.scan/1  ◄─────────────── the base crawler
                     /            \
            Verifier.run/1     RouteTags.run_checks/1
         (rules over the       (adds meta/threads as a
          same corpus, plus     second surface; joins the
          Links.doc_paths/1     two namespaces by id)
          for index coverage)
```

`Registry.scan/1` is the trunk every tool starts from; the verifier is mostly a
rule layer with no new inputs, plus the one index-coverage rule that walks
`Links.doc_paths/1` instead; RouteTags opens its own second door (into
`meta/threads`) and then walks back through the registry to resolve what it
found.

## A practical consequence

`test/` and `deprecated/` sit on every tool's exclusion list — the registry's,
`Links.doc_paths/1`'s, and RouteTags' thread glob alike — so **anything under
one of those is invisible to the whole toolchain, even though the lists
otherwise differ** (`Links` walks `meta/` and `inbox/`; the registry doesn't).
Put a markdown file with a fabricated `em:` id under `test/`, and `mix
brain.registry`, `mix brain.verify`, and `mix brain.route_tags` all sail past
it: `test` is on the
exclusion list, the verifier scans through the registry, and RouteTags only reads
threads from `meta/threads`. That is precisely what makes on-disk scenario
fixtures safe — they can carry whatever frontmatter a realistic input needs
without colliding with the live identity layer.

## In one sentence

There is one base bundle scanner — `Registry.scan/1`, a wildcard-plus-exclusion
crawl that enumerates knowledge concepts — and the verifier layers rules over its
output (plus one index-coverage rule reading `Links.doc_paths/1`'s
governance-inclusive walk instead) while RouteTags adds a second read over
`meta/threads` and rejoins the two namespaces by stable id; everything each
tool's own exclusion list drops is, by construction, invisible to it.
