---
type: plan
title: "Rename the brain: second-brain → elixir-brain"
description: Spec for renaming the repository and all associated naming from "second-brain" to "elixir-brain" — the GitHub repo, the Elixir app/module namespace, hooks, docs, and prose — while keeping the immutable `sb:` id prefix, frozen thread bodies, and cited history intact.
status: proposed
provenance: "Claude Code session (claude-fable-5), 2026-07-13 — operator asked to spec out the second-brain → elixir-brain rename lift"
tags: [meta, plan, rename, tooling, governance]
timestamp: 2026-07-13
---

# Rename the brain: second-brain → elixir-brain

## The ask

The operator wants the repository and all associated naming moved from
**second-brain** to **elixir-brain**. This plan is the spec: what the name
touches, what renames cleanly, what must *not* be renamed, the decisions that
need ratification, and the build order.

A full-repo sweep (`grep -ri 'second[-_ ]?brain'`) finds **459 occurrences
across 128 files**, but most of that count is *not* rename work: frozen thread
bodies, read-only archives, generated artifacts that recompile, and prose uses
of "second brain" as a product category rather than as this repo's name. The
real lift is one mechanical in-repo PR plus a few minutes of operator action on
GitHub.

## Inventory — where the name lives

| Surface | What's there | Rename action |
|---------|--------------|---------------|
| **GitHub repo** | `ob6to8/second-brain` | Operator renames in repo Settings → `ob6to8/elixir-brain` (Phase 2) |
| **Elixir app** | `mix.exs` `app: :second_brain`; module namespace `SecondBrain` (~78 occurrences across `lib/` + `test/`); dirs `lib/second_brain/`, `test/second_brain/` | `:elixir_brain` / `ElixirBrain` / `lib/elixir_brain/` / `test/elixir_brain/` — fully mechanical |
| **Mix tasks** | `mix brain.contract`, `brain.verify`, `brain.route_tags`, … | **Unchanged** — the task namespace is `brain.*`, not `second_brain.*`; skills and CI keep working |
| **Session hook** | `.claude/hooks/session-start.sh`: log path `/tmp/second-brain-session-start.log`, two `second-brain:` message prefixes | Rename strings |
| **CI workflows** | `.github/workflows/ci.yml`, `pages.yml` | **No occurrences** — nothing to change |
| **Generated artifacts** | `CLAUDE.md` (title "Operating Contract — Second Brain (OKF)"), `meta/registry.md`, route-tag excerpt logs, `meta/flows/lineage.md` | Never hand-edited — edit sources (`meta/preamble.md`, policies), then regenerate (`mix brain.contract`, `brain.registry`, `brain.route_tags --materialize`, `brain.lineage --materialize`) |
| **Maintained docs** | `README.md`, root `index.md` (`# Second Brain`), `meta/preamble.md`, skill `SKILL.md`s, `meta/flows/*`, `meta/tutorials/*`, policy examples (e.g. route-tagging's `lib/second_brain/route_tags.ex` sample ref) | Update names and code paths |
| **Route-tag path refs in frozen threads** | `<routes ref="… lib/second_brain/….ex">` attributes inside `meta/threads/` docs; `mix brain.route_tags` **fails CI** if a path ref doesn't resolve to a file on disk | Update the `ref` attributes when `lib/` moves — see Decision 2 |
| **Filed concept slug** | `knowledge/SWE/testing/elixir-second-brain-testing-methodology.md` (`sb:d58da3`) | Rename file; id survives the move — see Decision 3 |
| **GitHub Pages** | Site served at `ob6to8.github.io/second-brain/`; the site build uses relative URLs throughout (only doc comments mention the subpath) | No code change; URL moves to `…/elixir-brain/` on repo rename, **old Pages URL will 404** (Pages does not redirect) |
| **Environment / sessions** | Claude Code remote environment source and session repo scope pinned to `ob6to8/second-brain`; local clone dir `/home/user/second-brain` | Operator updates the environment source after the repo rename; git-level redirects cover existing clones/Routines in the interim |
| **Frozen / archival prose** | `meta/threads/` bodies, `deprecated/` (read-only), `inbox/` dated digests, point-in-time `meta/analysis/` docs | **Not renamed** — see scope boundaries |

## Decisions for ratification

**Decision 1 — keep the `sb:` id prefix (recommended: keep).**
The stable-identity policy makes ids *opaque and immutable*: minted once, never
changed, never reused. Migrating `sb:` → `eb:` would rewrite every concept's
`id`, every `verified_by` edge, every `<routes ref="sb:…">` tag — including tags
inside frozen thread bodies — the dedup-probe gold set, and the registry,
violating both the immutability rule and the thread-freeze rule in one motion.
The prefix is an opaque namespace token, not a display name; nothing requires it
to abbreviate the repo title. **Keep `sb:` permanently.** If the operator
nevertheless wants `eb:`, that is a separate, much larger migration plan with
its own tooling — explicitly out of scope here.

**Decision 2 — update `<routes>` path refs inside frozen thread docs
(recommended: yes).**
Moving `lib/second_brain/` breaks path back-links like
`<routes ref="lib/second_brain/session_init.ex">` in `meta/threads/`, and
`mix brain.route_tags` fails CI on unresolved refs. The capture policy freezes
the *retained text* — the verbatim message stream — but route tags are machinery
applied *over* the frozen body, not part of it, so updating a tag's `ref`
attribute (and re-running `--materialize`) is maintenance of the routing layer,
not a rewrite of history. The alternative (an alias map in the verifier) adds
permanent complexity to serve one rename. **Update the ref attributes; touch
nothing else in the bodies.**

**Decision 3 — rename the one filed concept whose slug carries the name
(recommended: yes).**
`knowledge/SWE/testing/elixir-second-brain-testing-methodology.md` names *this
project*. Per the identity policy, "identity survives refactors; paths don't
have to": rename to `elixir-brain-testing-methodology.md`, keep `sb:d58da3`,
update inbound prose links, regenerate the registry. By contrast,
`meta/analysis/comparison-with-the-2026-second-brain-field.md` stays — there
"second brain" is the product category being compared against, not this repo.

**Decision 4 — prose policy: proper noun vs. category term.**
Where "Second Brain" names *this repo* (README title, root `index.md` heading,
`meta/preamble.md` title, hook messages), it becomes **Elixir Brain** /
**elixir-brain**. Where "second brain" is the *category* ("a personal second
brain stored as an OKF bundle", the field-comparison analysis, glossary
definitions of the concept), the recommendation is to keep the category term —
the repo is still *a* second brain; it is just no longer *named* that. The
preamble's opening line can carry both: "…a personal second brain … named
**elixir-brain**." Operator may instead direct a full prose sweep; that widens
the diff into policy/tutorial prose but changes nothing structural.

## Scope boundaries — what does not change

- **`sb:` ids, `verified_by` edges, and the registry's id column** (Decision 1).
- **`mix brain.*` task names** — already repo-name-agnostic.
- **Frozen retained text** in `meta/threads/` bodies: prose mentions of
  "second brain", old URLs, and quoted commit messages stay verbatim. Only
  `<routes>` ref attributes are touched (Decision 2).
- **`deprecated/`** — read-only archive; not part of the bundle.
- **`inbox/` dated digests and point-in-time `meta/analysis/` docs** — dated
  records; their historical wording stands.
- **Git history, cited SHAs, PR numbers** — untouched; GitHub repo renames
  preserve issues/PRs and redirect `github.com/ob6to8/second-brain/…` web URLs
  and git remotes to the new name, so `pr:` anchors in thread frontmatter and
  commit-message references keep resolving.
- **CI workflow files** — contain no repo-name references.

## Build order

**Phase 0 — ratify.** Operator approves this plan and the four decisions.
Plan `status` → `accepted`.

**Phase 1 — in-repo rename (one PR, one session).**
Ordered so every gate is green at the end:

1. `mix.exs`: `SecondBrain.MixProject` → `ElixirBrain.MixProject`,
   `app: :second_brain` → `app: :elixir_brain`.
2. `git mv lib/second_brain lib/elixir_brain`,
   `git mv test/second_brain test/elixir_brain`; sweep
   `SecondBrain` → `ElixirBrain` and `second_brain` → `elixir_brain` across
   `lib/` and `test/` (~78 module references plus path strings in moduledocs).
3. `.claude/hooks/session-start.sh`: log path and message prefixes.
4. Maintained docs sweep: `README.md`, root `index.md`, `meta/preamble.md`,
   `.claude/skills/*/SKILL.md`, `meta/flows/*.md` (including `lineage:` blocks
   if they carry code paths), `meta/tutorials/*.md`, `meta/policy/*` examples —
   rename proper-noun uses and every `lib/second_brain/…` / `test/second_brain/…`
   path per Decision 4.
5. Decision 3 file rename + inbound-link fixes.
6. Frozen-thread `<routes>` ref-attribute sweep (Decision 2).
7. Regenerate everything generated: `mix brain.contract`, `mix brain.registry`,
   `mix brain.route_tags --materialize`, `mix brain.lineage --materialize`.
   Hand-edit none of them; if a materialized surface (excerpt logs, glossary
   co-feeds lines) still shows an old path afterward, fix the *tag*, not the log.
8. Full gate suite: `mix compile --warnings-as-errors`, `mix format
   --check-formatted`, `mix test`, `brain.contract --check`, `brain.registry
   --check`, `brain.verify`, `brain.route_tags`, `brain.lineage --check`,
   `brain.site`.
9. Case-variant residue check before opening the PR:
   `grep -ri 'second[-_ ]?brain' --exclude-dir=deprecated --exclude-dir=_build .`
   — every remaining hit must be an intentional keep (frozen thread prose,
   category-term prose, dated records, this plan).
10. PR, true merge (never squash), delete the head branch.

**Phase 2 — GitHub rename (operator, after Phase 1 merges).**

1. Repo Settings → rename to `elixir-brain`. Git remotes and web URLs redirect;
   Actions, branch protection, and Pages settings carry over.
2. The Pages site redeploys on the next push at
   `ob6to8.github.io/elixir-brain/`; the **old Pages URL 404s** (no redirect at
   the Pages layer) — update any external bookmarks/links the operator keeps.
   Old-URL mentions inside frozen threads stay as historical record.
3. Update the Claude Code environment source / session repo scope to
   `ob6to8/elixir-brain` so new sessions clone under the new name; existing
   Routines keep working through git redirects in the interim but should be
   re-pointed when convenient.
4. Optionally re-point local clones: `git remote set-url origin
   git@github.com:ob6to8/elixir-brain.git` (the redirect makes this non-urgent).

**Phase 3 — post-rename verification (first session in the renamed repo).**
Confirm: session hook provisions and prints the new name; CI and the Pages
deploy are green; the site serves at the new URL; `mix brain.verify` and
`brain.route_tags` pass untouched. File an `issue` for anything that slipped.

## Risks & notes

- **The route-tags verifier is the sharp edge.** Steps 2 and 6–7 of Phase 1
  must land in the same PR; a partial rename leaves CI red on unresolved path
  refs or stale materialized logs.
- **Old Pages URL breakage is permanent** — the only non-redirected surface.
  Anything external linking to `ob6to8.github.io/second-brain/…` needs a manual
  update; in-repo, site links are relative and unaffected.
- **A future re-clone under the old name** (a stale environment config) still
  works via GitHub's redirect but produces a working dir named `second-brain`;
  harmless, since nothing in the tooling depends on the directory basename.
- **Sweep discipline:** the name appears in four casings (`second-brain`,
  `second_brain`, `SecondBrain`, `Second Brain`); step 9's grep is the
  completeness oracle, with the scope boundaries above as the keep-list.

## Estimate

Phase 1 is a single focused session: ~130 files show hits, but the majority are
frozen/kept or regenerate; the hand-edited set is roughly the Elixir tree
(mechanical), one hook, ~15 maintained docs, and ~10 thread-doc ref sweeps.
Phases 2–3 are minutes of operator action plus one verification session.
