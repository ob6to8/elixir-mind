---
type: reference
title: 2026-07-23-session-start-hook-gate-and-machinery-reference-plan
description: Explained the session-start.sh core.hooksPath comment concept-by-concept, then reshaped the operator's "new glossaries for repo machinery" request into a generated-artifact plan and a companion tutorial.
provenance: "Claude Code session (Claude Opus 4.8), 2026-07-23; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, git-hooks, sessionstart-hook, pre-commit, code-map, glossary, tooling, plan]
timestamp: 2026-07-23
session: https://claude.ai/code/session_01AnZeVjrSipVeACzMb6K7MC
---

# 2026-07-23-session-start-hook-gate-and-machinery-reference-plan

## Where this landed

The session opened with the operator asking for a concept-by-concept explanation
of a comment in `.claude/hooks/session-start.sh` — the block that points git at
the checked-in `.githooks/pre-commit` gate via `core.hooksPath`. The explanation
surfaced that the block is not actually in the current hook (which only provisions
and warms the Elixir toolchain), but the mechanism it describes is real: fresh
web-session sandboxes clone without `core.hooksPath` set, so the local gate never
runs there and a red gate is only found in CI.

The operator then asked to build "several new glossaries" cataloguing repo
machinery — directories, files, "variables", data structures, and Elixir commands.
Investigation showed most of that already has a home (the generated `code-map.md`,
the term glossary with its `sense` field, and the README/`meta` layout prose), so
the design was reshaped: route four categories into existing machinery and build
one new generated artifact (`mix brain.repomap` → `meta/repo-map.md`, `--check`-gated)
for the true gap. Two decisions were ratified in-session — (1) generate, don't
hand-keep; (2) "data structures" = enrich the code map (the frontmatter model stays
canonical in policy, cross-linked, not recopied). That design is persisted as
[the repo-map-and-machinery-reference plan](/meta/plans/repo-map-and-machinery-reference.md)
(`status: proposed`, execution deferred to ratification).

Finally the operator asked for a tutorial covering the explanation, then a
`/create-pull-request merge`. The tutorial
[The SessionStart hook and why a fresh web sandbox skips the local gate](/meta/tutorials/sessionstart-hook-and-the-local-gate-in-a-fresh-sandbox.md)
was written as a companion to the existing gate-suite tutorial, and this capture
plus the PR close the session.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Explain the `session-start.sh` `core.hooksPath` comment concept-by-concept | closed | [sessionstart-hook-and-the-local-gate-in-a-fresh-sandbox](/meta/tutorials/sessionstart-hook-and-the-local-gate-in-a-fresh-sandbox.md) | - |
| "New glossaries" for repo machinery → reshaped generated-artifact design | closed | [repo-map-and-machinery-reference](/meta/plans/repo-map-and-machinery-reference.md) | - |
| Plan-vs-execute, and how to ship (PR vs keep building) | closed | `unrouted` | - |

## User

can you explain to me this comment, concept by concept, from session-start.sh?

```
# Point git at the checked-in pre-commit gate. Fresh web-session sandboxes clone
# without core.hooksPath set, so the local gate suite (.githooks/pre-commit) never
# runs and a red gate is only found in CI. Harmless if already set; the hook
# degrades gracefully when mix is absent.
if command -v git >/dev/null 2>&1; then
  repo="${CLAUDE_PROJECT_DIR:-$PWD}"
  if [ -d "$repo/.git" ] && [ -d "$repo/.githooks" ]; then
    git -C "$repo" config core.hooksPath .githooks 2>/dev/null || true
  fi
fi
```

## Assistant

Here's the comment, unpacked concept by concept. Note first: **this block isn't currently in `.claude/hooks/session-start.sh`** — the live hook only provisions Elixir and warms `mix compile`. But everything the comment describes is real in this repo (the gate it points at is `.githooks/pre-commit`, which I read above), so it's either a proposed addition or lives on another branch. The explanation holds either way.

### The comment, line by line

> **"Point git at the checked-in pre-commit gate."**

Git looks for hooks (scripts it runs automatically at points like "just before a commit is recorded") in a directory. By default that's `.git/hooks/` — which lives *inside* the `.git` folder and is therefore **not** version-controlled; it never travels with a clone. This repo instead keeps its hook as a **checked-in** file at `.githooks/pre-commit` (tracked in git, shared by everyone). "Pointing git at it" means telling git to use `.githooks/` as its hooks directory instead of the default. That's exactly what `.githooks/pre-commit`'s own header says to do: `git config core.hooksPath .githooks`.

> **"the pre-commit gate"** / **"the local gate suite (.githooks/pre-commit)"**

A **gate** is a pass/fail check that blocks an action unless everything is green. The `pre-commit` script is a gate that runs on every `git commit` and, before letting the commit through, runs the project's whole verification suite: `mix format --check-formatted`, `mix brain.contract --check`, `mix brain.registry --check`, `mix brain.verify`, `mix brain.route_tags`, `mix test`, and so on (I pasted the full list above). If any fails, `set -euo pipefail` makes the script exit non-zero and git aborts the commit. It's called the **local** gate because it runs on your machine — as opposed to **CI**, the same checks run on the server after you push.

> **"Fresh web-session sandboxes clone without `core.hooksPath` set"**

`core.hooksPath` is a *git config setting*, not a file in the repo. Config lives in `.git/config` (or your global git config) — again, **not** part of what gets cloned. So when Claude Code on the web spins up a brand-new sandbox and clones the repo fresh, that setting starts unset. Git falls back to the default `.git/hooks/`, which is empty. Result: **the checked-in gate exists in the tree but git isn't wired to run it.**

> **"so the local gate suite never runs and a red gate is only found in CI"**

Consequence of the above. "Red gate" = a failing check (red = fail, green = pass). Without the wiring, you can commit code that breaks formatting or verification without noticing locally; the failure only surfaces later when CI runs the same checks on the server — a slower, more annoying feedback loop. Wiring `core.hooksPath` at session start closes that gap so the failure is caught **at commit time**, before it ever reaches CI.

### The code

```bash
if command -v git >/dev/null 2>&1; then
```
Only proceed if `git` is actually installed. `command -v git` prints git's path if found; `>/dev/null 2>&1` throws away both that output and any error, so the `if` keys purely on the exit status (success = found).

```bash
  repo="${CLAUDE_PROJECT_DIR:-$PWD}"
```
Where's the repo? Prefer the harness-provided `CLAUDE_PROJECT_DIR`; if that variable is unset or empty (the `:-` default), fall back to `$PWD` (current directory).

```bash
  if [ -d "$repo/.git" ] && [ -d "$repo/.githooks" ]; then
```
Two safety checks: only act if this really is a git repo (`.git/` exists) **and** the checked-in hooks directory (`.githooks/`) is actually present. This prevents pointing git at a directory that isn't there.

```bash
    git -C "$repo" config core.hooksPath .githooks 2>/dev/null || true
```
Do the wiring. `git -C "$repo"` runs git as if from the repo directory. `config core.hooksPath .githooks` sets that config value. `2>/dev/null` hides any error message, and `|| true` swallows a non-zero exit so the command can never abort the session-start hook (which runs under `set -e`, where an unguarded failure would kill the whole script).

### The last two sentences

> **"Harmless if already set"**

`git config core.hooksPath .githooks` is **idempotent** — running it when the value is already `.githooks` just rewrites the same value. So re-running the hook (e.g. a local machine that configured this once) costs nothing and breaks nothing.

> **"the hook degrades gracefully when mix is absent"**

Here "the hook" means the **pre-commit gate itself**, not this session-start block. Look at lines 6–9 of `.githooks/pre-commit`: if `mix` (the Elixir build tool) isn't installed, it prints a "skipping" notice and `exit 0` — success. So even if you wire git to the gate on a machine that has no Elixir, commits still succeed; the gate just quietly no-ops instead of erroring. "Degrades gracefully" = loses functionality without breaking.

---

**The whole point in one sentence:** a repo can *ship* its own commit-time checks (`.githooks/`), but git won't *use* them until `core.hooksPath` is set — and that setting doesn't survive a clone — so this block re-establishes the wiring automatically each time a fresh web sandbox starts, moving gate failures from "found in CI" back to "found at commit."

If you'd like, I can add this block to the live `.claude/hooks/session-start.sh` (it's currently missing) so web sessions actually get the local gate wired up.

## User

create several new glossaries, based off of resources in this repo:

* directories (ie. .git/hooks, which would include for example info like "Git looks for hooks (scripts it runs automatically at points like "just before a commit is recorded") in a directory. By default that's .git/hooks/ — which lives inside the .git folder and is therefore not version-controlled; it never travels with a clone. "
* files - ie. claude/hooks/session-start.sh (describe purpose and usage)
* "variables" (if that's what they are called in elixir) ie. core.hooksPath
* data structures - data that is used through the codebase
* elixir commands used - mix format --check-formatted, mix brain.contract --check etc

ask questions/expand upon my listing as necessary

worth making a plan, or executing here?

## Assistant

The existing glossary is already sophisticated — term-based, cross-domain, with a `sense` field (common/repo/dual). Your proposal is a different shape: reference docs organized by *kind of repo resource*. Before I recommend plan-vs-execute, let me check what already documents this repo's own machinery, so we don't duplicate.

## Assistant

Good instinct to pause — I dug into what already exists, and the headline is: **most of your five categories already have a home in this repo, and the ones that don't are narrower than the list suggests.** That changes the answer from "build five glossaries" to "route four of them into existing machinery and build one small new thing." That reshaping is exactly what deserves a plan. Let me show you the mapping.

### Your five categories vs. what already exists

| Your category | Already covered by | The actual gap |
|---|---|---|
| **Directories** (`.git/hooks`) | `index.md` progressive disclosure covers every *bundle* dir; README "Layout" + `meta/index.md` "Related tooling" cover the top-level layout in prose | The **non-bundle machinery** dirs — `.git/hooks`, `.githooks/`, `.claude/hooks/`, `.github/workflows/`, `config/`, `_build/`, `lib/mix/tasks` vs `lib/elixir_mind` — have no queryable catalog |
| **Files** (`session-start.sh`) | `meta/code-map.md` documents **every `lib/*.ex`** file, generated from docstrings, `--check`-gated | The **non-`.ex` files**: shell scripts (`session-start.sh`, `pre-commit`), workflow YAML (`ci.yml`, `pages.yml`), `config.exs`, `mix.exs`, `.formatter.exs` |
| **"Variables"** (`core.hooksPath`) | Elixir has no globals; your examples are really **env vars** (`CLAUDE_CODE_REMOTE`, `CLAUDE_PROJECT_DIR`, `HTTPS_PROXY`…), **git config keys** (`core.hooksPath`), and **app config** (`:elixir_mind, :site_base_url`) | The *portable concept* of each belongs in the glossary; the *inventory of which ones this repo uses and why* has no home |
| **Data structures** | `code-map.md` lists declared `@type`s (`page/0`, `result/0`, `Row`) | Internal structs (`Registry.Entry`, `%Flow{}`, `%Page{}`) are `@moduledoc false` and deliberately omitted; the **frontmatter data model** (the `attribution` map, routing-ledger row, `<routes>` region) is scattered |
| **Elixir commands** (`mix brain.contract --check`) | `code-map.md` documents **all 16 `mix brain.*` tasks** with full usage | Only the handful of **standard** commands (`mix format --check-formatted`, `mix compile`, `mix test`) are undocumented — and they're tiny and stable |

And critically — the glossary **already holds machinery/ecosystem terms**: `mix-task`, `otp`, `sessionstart-hook`, `posttooluse-hook`, `skill`, `plugin`, `routine`, `cron-expression`, `git-trailer`, `git-worktree`, `github-pages`, `webhook`. So "what *is* a git hook / `core.hooksPath` / a mix task" is already the glossary's job (as `common`/`dual`-sense terms), fed by `/add-to-glossary`.

### Why this reshapes the design

This repo has one dominant law: **generated artifact + `--check` gate, never hand-kept, never duplicated** (that's what `code-map.md`, `registry.md`, `CLAUDE.md`, `dev-history.md` all are). Five hand-written glossaries would violate it twice over — they'd **drift** the instant a file is renamed (no generator, no gate), and they'd **duplicate** the code map, the glossary, and the README layout.

So the right shape is almost certainly *not* five new glossaries. It's:

1. **Portable concepts → existing glossary** via `/add-to-glossary` (git hook, `core.hooksPath`, env var, mix task, pre-commit hook). Zero new machinery.
2. **Data structures → enrich docstrings** (`@typedoc`, un-hide the key `@moduledoc false` structs) so the **existing generated code map** grows to cover them. Zero new artifact.
3. **The genuinely-new machinery inventory** (non-bundle dirs + non-`.ex` files + the config/env-var surface) → **one new generated artifact**, e.g. `meta/repo-map.md` built by a new `mix brain.repomap` with a `--check` gate, on the exact discipline as `code-map.md`.

That's a much smaller, drift-proof surface than the original framing — but it involves a new mix task, a new CI gate, and docstring changes, all of which are **shape changes the contract says I propose and you ratify**, not build autonomously.

### Plan or execute? → **Plan.**

Three of the plan-vs-capture escalators fire cleanly:
- **Substantial standalone design** — the generated-vs-hand-kept split and the "route to glossary / enrich code map / build one generator" decomposition are real decisions with alternatives, worth a queryable record.
- **Shape change requiring ratification** — new `mix brain.repomap` task + CI gate + docstring enrichment.
- **Cross-session build order** — generator → gate → CI wiring → backfill descriptions → glossary entries is a multi-step build that'll likely span sessions.

Executing it inline would mean autonomously creating new tooling and a new artifact kind, which is precisely what the taxonomy/shape rules reserve for your ratification.

### Two decisions that are genuinely yours

1. **How generated should the machinery catalog be?** A `mix brain.repomap` generator + `--check` gate (drift-proof, matches repo ethos, more upfront work) — versus a plain hand-kept `meta/repo-map.md` governance doc (faster, but drifts like any prose). I lean generator, given how hard this repo leans on `--check`.

2. **Scope of "data structures."** Just enrich the code map to cover internal structs — or also document the *frontmatter data model* (the `attribution` map, routing-ledger row, `<routes>` region shape) as a first-class thing? The latter is arguably already spread across `CLAUDE.md` + code-map moduledocs.

If you'd like, I'll draft the `type: plan` doc under `meta/plans/` capturing this reshaped design, the routing of each of your five categories, those two open decisions, and the build order — then you ratify or push back before anything gets built. Want me to write it?

## User

1 - generator
2 - latter, unless is redundant?

answer 2, then we will write

## Assistant

Confirmed against the source. Here's decision 2.

### Decision 2: **redundant — go with the former.**

The distinction is *which* data:

- **The document/frontmatter data model** — the frontmatter field set, the `attribution` map, the routing-ledger row, the `<routes>` region shape — is **already canonical and machine-enforced elsewhere**: defined field-by-field in `CLAUDE.md` §1 + the `frontmatter-schema` / `resource-attribution` / `routing-ledger` / `route-tagging` policies, and validated by `mix brain.verify` (rules 1–8). Re-documenting it as a first-class "data model" doc would fragment a source of truth and *drift from a machine-checked one* — the exact anti-pattern the repo avoids. So: **cross-link to the policies, don't recopy them.**

- **The in-memory Elixir structs** are the genuine gap, and it's small — exactly **three** `@moduledoc false` structs the code map omits: `%Flow{}` (lineage.ex), `Registry.Entry`, and the DevHistory entry struct. (`DedupProbe.Row` and `Policy.t` already surface.) The fix is decision 1's mechanism: **enrich their docstrings and un-hide them so the existing generated code map grows to cover them** — no new hand-kept artifact.

So "data structures" collapses into the code-map path, not a new doc. Both your decisions now point the same way: generate, don't hand-keep; extend what exists, add one new generated artifact only for the true machinery gap (dirs + non-`.ex` files + config/env-var surface).

Now let me write the plan.

## Assistant

Done. Both decisions are settled and the plan is filed.

**Decision 2 → redundant; scoped to the code map.** The frontmatter/attribution/ledger/routes model stays canonical in policy (cross-linked, not recopied); "data structures" collapses to enriching the three `@moduledoc false` structs so the existing generated code map covers them.

**Plan written:** `meta/plans/repo-map-and-machinery-reference.md` (`status: proposed`), listed in `meta/plans/index.md`. It captures:
- the **route-don't-duplicate** design — four of your five categories go into the existing glossary + code map; only the true gap (machinery dirs + non-`.ex` files + config/env-var surface) becomes a new artifact;
- **one new generated artifact** — `mix brain.repomap` → `meta/repo-map.md`, `--check`-gated in CI and pre-commit, same discipline as `mix brain.codemap`;
- both ratified decisions, an unresolved sub-question (where the hand-authored descriptions live — a data file vs. header-comment extraction), a 5-step build order, and scope boundaries.

`mix brain.verify` is green — the only output is the expected advisory warning that the plan's `attribution.from` isn't stamped yet (that back-link to this session's thread gets filled in by `/create-pull-request` after capture, per policy; nothing to fix now).

Two ways forward:
1. **Ship the plan now** — `/create-pull-request` captures this session, stamps the `from` back-link, and opens a PR with just the plan doc (build happens later, cold, against a concrete spec).
2. **Keep going and build it here** — start on the low-risk independent steps (glossary pass + the three-struct code-map enrichment) in this same session, since I already hold the context.

Which do you want? If you're leaning "build now," I'd start with step 2 (code-map enrichment) since it's fully self-contained and validates the approach before the generator work.

## Assistant

Committed and pushed to `claude/session-start-hooks-comment-pvcwlb` (commit `41a2350`). The plan is now durable — safe from the sandbox being reclaimed.

Note this was a plain save-commit, **not** the full `/create-pull-request` flow: no session capture, no glossary pass, and the plan's `attribution.from` back-link is still unstamped (that's the advisory warning from earlier, filled in when the session is captured).

The two forks from before still stand:
1. **`/create-pull-request`** — captures this session, stamps `from`, glossaries the thread, and opens a PR with the plan.
2. **Keep building here** — start on the low-risk independent steps (code-map struct enrichment, then the glossary pass) while I hold the context.

Say which and I'll proceed.

## User

create a tutorial doc covering this, then /create-pull-request merge

## Assistant

Done — tutorial written, session captured, and the PR opened and merged. (Closing summary follows the merge in this same turn.)
