---
type: plan
title: "A mechanical todo surface: `mix brain.todo` plus a thin Neovim client over the brain's own task store"
description: Give the brain's todos a non-LLM read/write surface — an ElixirMind.Todos module, a mix brain.todo task emitting text and NDJSON, and a dependency-free Neovim plugin that shells out to it — so the editor, the shell, and IEx all read one task store instead of a second tracker being adopted alongside it.
status: proposed
provenance: "Claude Code session (claude-opus-5), 2026-07-31 — operator asked what work existed on a Neovim todo system and whether to build one in Elixir instead"
tags: [meta, plan, tooling, todos, neovim, editor-integration, cli, ndjson]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, todo-tracking-neovim-elixir session"
  why: "operator commissioned the plan after weighing adopting an existing Neovim task plugin against building an Elixir surface over the brain's existing meta/todos/ store"
  from: [/meta/threads/2026-07-31-todo-surface-cli-and-neovim-plan.md]
---

# A mechanical todo surface: `mix brain.todo` + a thin Neovim client

## Problem

The brain already has a task store. [`meta/todos/`](/meta/todos/index.md) holds
`type: todo` documents with a controlled `status`, the
[`/todo`](/.claude/skills/todo/SKILL.md) skill files and lists them, and
[`ElixirMind.SessionInit`](/lib/elixir_mind/session_init.ex) reads them into the
[`/priorities`](/.claude/skills/priorities/SKILL.md) digest. What it does not
have is a **mechanical** surface: every todo operation today is an LLM action.

```
todo lifecycle today — every arrow is an agent turn
├── create ........ /todo skill → agent hand-writes meta/todos/<slug>.md
├── list .......... /todo skill → agent greps and parses frontmatter itself
├── complete ...... /todo skill → agent hand-edits `status:` and `timestamp:`
└── digest ........ mix brain.session_init → SessionInit.open_todos/1
                    ^^^ the one mechanical reader, and it is private to the digest
```

Three costs follow from that shape:

- **No editor can reach the store.** An editor plugin needs something to call;
  there is nothing but a markdown directory and an agent. This is the whole of
  why "use a Neovim todo plugin" and "use the brain's todos" are currently
  disjoint choices rather than one system.
- **Checking the list costs a session.** Reading four open todos requires
  spending an agent turn on work a `find`-and-parse does deterministically.
- **The reader is trapped in the digest.** `SessionInit.open_todos/1` is the
  correct scan, but it is reachable only by rendering the whole digest, so
  every other consumer would reimplement it.

The standing alternative is to adopt an existing Neovim task plugin instead of
building anything. The survey below is the case against it: the mature options
each carry their own store and format, so adopting one adds a **second** task
list beside `meta/todos/` — the outcome
[update-in-place](/meta/policy/update-in-place.md) exists to prevent, applied at
the level of stores rather than documents.

## The Neovim landscape, surveyed

**Scope of the survey**: 15 repositories checked 2026-07-31 against the GitHub
API (star counts, push dates) plus README and code-search fetches, reached from
one search pass over a seed list. Every negative claim below is scoped to those
15 — a plugin doing frontmatter-driven task queries could exist outside them.

| Repo | What it is | Its task store | Stars | Activity |
|---|---|---|---|---|
| `vimwiki/vimwiki` | wiki with `[ ]`/`[X]` checkboxes | plain wiki/markdown, no task metadata | 9.5k | pushed 2026-04-30 |
| `nvim-neorg/neorg` | PKM suite, task module | bespoke `.norg` format | 7.5k | pushed 2026-07-26 |
| `epwalsh/obsidian.nvim` | Obsidian vault integration | your markdown vault | 6.2k | pushed 2026-06-04 |
| `folke/todo-comments.nvim` | highlights `TODO:`/`HACK:` in source | none — read-only buffer scan | 4.2k | pushed 2025-11-10 |
| `nvim-orgmode/orgmode` | Org-mode clone: agenda, TODO states, `DEADLINE`/`SCHEDULED` | `.org` files | 3.9k | pushed 2026-06-29 |
| `pwntester/octo.nvim` | GitHub issues/PRs in buffers | none — shells out to `gh` | ~3.3k | — |
| `obsidian-nvim/obsidian.nvim` | maintained community fork | markdown vault; real frontmatter parser + validator | 2.1k | pushed 2026-07-30 |
| `stevearc/overseer.nvim` | build/run task runner (not personal todos) | make/npm/cargo/`tasks.json` | 1.9k | updated 2026-07-30 |
| `tbabej/taskwiki` | vimwiki ↔ Taskwarrior bridge | Taskwarrior, via the `tasklib` Python library | 914 | last commit 2025-06-14 |
| `bngarren/checkmate.nvim` | markdown-native todos, `@tag(value)` metadata | plain GFM `- [ ]` | 376 | last commit 2026-04-25 |
| `ribelo/taskwarrior.nvim` | Telescope picker over Taskwarrior | parses `task export` JSON | 128 | last commit 2024-03-20 |
| `huantrinh1802/m_taskwarrior_d.nvim` | syncs markdown checkboxes ↔ Taskwarrior | Taskwarrior, via the `task` CLI | 94 | pushed 2026-02-23 |
| `arnarg/todotxt.nvim` | todo.txt viewer | a `todo.txt` file | 71 | **archived** 2025-03-05 |
| `MattHandzel/taskwarrior.nvim` | Taskwarrior tasks edited as markdown | Taskwarrior | 29 | created 2026-03-22 |
| `edmundmiller/tasknotes.nvim` | one markdown file per task | **markdown + YAML frontmatter** | 1 | unverified |

**On adoption.** Among the maintained options, none treats
markdown-with-YAML-frontmatter as a task *source*. The maintained
`obsidian.nvim` fork comes closest — it has a real `lua/obsidian/frontmatter/`
module with a validator — but frontmatter there is note metadata and its only
task surface is `toggle_checkbox`. `checkmate.nvim`, the best-maintained
markdown todo plugin, keeps metadata in inline `@tag(value)` annotations rather
than frontmatter. So adopting any of them splits the task list in two.

`orgmode` is the most complete GTD system of the group — real agenda views,
state transitions, and scheduling — and would be the right answer for a task
list with no prior home. The brain's task list has a home, a schema, a
verifier, and a git history; that is the asset worth keeping, and `orgmode`
would require converting it to `.org` (and Neovim 0.11+) to use.

The one plugin whose data model already *is* this one is
`edmundmiller/tasknotes.nvim` — "each task is a markdown file with YAML
frontmatter", with `status`/`priority`/`due`/`tags` fields. At 1 star it is a
reference implementation to read before building the client, not a dependency.

**On the architecture.** Shelling out to an external CLI and rendering the
result is well-established, at three scales: `octo.nvim` (~3.3k stars) drives
its entire GitHub data layer through the `gh` subprocess; `overseer.nvim`
discovers tasks by invoking make/npm/cargo; and `ribelo/taskwarrior.nvim` is
the exact shape proposed here — run `task export`, parse the emitted JSON, feed
a Telescope picker. That last one is dormant (last commit 2024-03-20) but it
settles the design question: external CLI emits JSON, Neovim renders a picker,
and the only difference here is that `mix brain.todo` sits where `task export`
did.

The precedent also carries the warning. `gh` and `task` start in milliseconds;
`mix` pays BEAM startup on every invocation. `ribelo`'s answer — one export
call per picker session, filter in Lua, re-fetch after a write — is the pattern
to copy, and it is what the latency item under *Deferred* budgets against.

## The decision: build the surface, keep the store

Expose the store the brain already maintains through three mouths that share
one implementation:

- a **module** (`ElixirMind.Todos`) — the single reader/writer,
- a **mix task** (`mix brain.todo`) — text for humans, NDJSON for machines,
- a **Neovim plugin** — a picker that shells out to the task.

The IEx affordance the operator asked about is not a fourth thing to build. It
falls out of putting the logic in a module rather than in a task: `iex -S mix`
then `ElixirMind.Todos.list(status: :open)` works the moment the module exists.
That property is itself the argument for the module/task split, and it matches
how every other capability here is already shaped — `SessionInit`, `Glossary`,
`RouteTags` are modules with thin `Mix.Task` wrappers.

### Two constraints found in the tree that shape the build

**1. There is no JSON encoder available.** The toolchain runs Elixir 1.14 on
OTP 25 with `deps: []` — a documented design goal
([why the toolchain runs offline](/meta/tutorials/why-the-toolchain-runs-offline.md)),
re-affirmed in `mix.exs`. OTP's `:json` module arrives in OTP 27, so it is
absent here (`Code.ensure_loaded?(:json)` returns `false` on this sandbox), and
adding Jason would break the offline stance for one encoder. The plan therefore
carries a ~40-line encoder confined to one private function, emitting
**NDJSON** (one object per line) rather than a document — line-oriented output
is what a shell client wants anyway, and it keeps the encoder from needing
pretty-printing or nesting depth. It is written to be **deleted**: when
[raise the Elixir/OTP toolchain floor](/meta/plans/raise-elixir-otp-toolchain-floor.md)
lands OTP 27+, the private function is replaced by `:json.encode/1` with no
change to any caller.

**2. The write half is blocked; the read half is not.** Creating a todo writes
a *new* file, which is a template render — no parsing involved, so it is
unblocked. Completing one *mutates existing frontmatter* (`status`,
`timestamp`), and the tree has no order-preserving frontmatter serializer:
`ElixirMind.Frontmatter` is read-only, and the one existing mutation path
(`ElixirMind.Attribution.Backfill`) does regex surgery on raw text that assumes
a fixed indentation shape. Building a second regex mutator here would
double-down on the exact defect
[the frontmatter-parser rewrite](/meta/plans/frontmatter-parser-profile-rewrite.md)
is queued to remove. So **`set_status/3` waits for `Frontmatter.dump/1`** from
that plan, and this plan ships read + create first. The build order below
enforces the split.

## The shape, structured

**Desired-state tree** (behavior → layer → anchor):

```
todo surface
├── read path
│   ├── list open/done/cancelled todos ....... ElixirMind.Todos.list/1
│   │   └── frontmatter scan ................. reuses SessionInit's docs_in/2 shape
│   ├── human rendering ...................... mix brain.todo list
│   ├── machine rendering .................... mix brain.todo list --format ndjson
│   ├── priorities digest .................... SessionInit.open_todos/1 → delegates
│   └── REPL ................................. iex -S mix → Todos.list/1   (free)
├── write path
│   ├── file a new todo ...................... Todos.create/1 → template render
│   │   └── attribution + index entry ........ written by the same call
│   └── close a todo ......................... Todos.set_status/2  [PHASE 2]
│       └── needs order-preserving write ..... Frontmatter.dump/1 (other plan)
└── editor client
    ├── fetch ................................ vim.system() → mix brain.todo
    ├── decode ............................... vim.json.decode per line
    └── present .............................. vim.ui.select fallback; picker if present
```

**File-tree diff:**

```diff
 lib/elixir_mind
+├── todos.ex                       # NEW — the one reader/writer: list/1, create/1,
+│                                  #   set_status/2 (phase 2), path/slug helpers,
+│                                  #   and the private NDJSON encoder
~└── session_init.ex                # MODIFIED — open_todos/1 delegates to
                                    #   Todos.list(status: :open); docs_in/2 stays
                                    #   (issues and plans still use it)
 lib/mix/tasks
+└── brain.todo.ex                  # NEW — subcommand dispatch + --format flag
 test/elixir_mind
+├── todos_test.exs                 # NEW — list filtering, ordering, tolerance,
+│                                  #   NDJSON shape, create template + index entry
~└── session_init_test.exs          # MODIFIED — assert the delegation is behavior-
                                    #   preserving (same todos, same order)
 nvim                               # NEW dir — the editor client, incubated in-repo
+├── README.md                      # install snippet + brain-root config
+├── plugin/elixir-mind.lua         # :BrainTodo, :BrainTodoNew commands
+└── lua/elixir-mind
+    ├── init.lua                   # setup/1, config (brain root, mix binary)
+    ├── cli.lua                    # vim.system wrapper + NDJSON decode
+    └── ui.lua                     # picker with a vim.ui.select fallback
 .github/workflows                  # MODIFIED — no new gate; brain.todo has no
                                    #   generated artifact to --check
```

**Signatures:**

```elixir
@type status :: :open | :done | :cancelled
@type t :: %{
        slug: binary(),
        rel_path: binary(),
        title: binary(),
        description: binary() | nil,
        status: status(),
        priority: pos_integer() | nil,
        timestamp: binary()
      }

@spec list(opts :: keyword()) :: [t()]
@spec get(slug :: binary()) :: {:ok, t()} | {:error, :not_found}
@spec create(attrs :: keyword()) :: {:ok, t()} | {:error, term()}
@spec to_ndjson([t()]) :: binary()

# phase 2 — gated on Frontmatter.dump/1
@spec set_status(slug :: binary(), status()) :: {:ok, t()} | {:error, term()}
```

`list/1` takes `:status` (default `:open`, `:all` for everything) and `:root`
(default `File.cwd!()`), matching how `SessionInit` already threads its root so
the tests can point at a fixture bundle.

**Call trees** — production, then test:

```
# production
mix brain.todo list --format ndjson
  Todos.list(status: :open)
    scan meta/todos/*.md → Frontmatter.parse/1 → reject index.md → sort
  Todos.to_ndjson/1
    private encode/1                    # replaced by :json.encode/1 post-floor-raise

# neovim
:BrainTodo
  cli.fetch()  → vim.system({mix, "brain.todo", "list", "--format", "ndjson"})
  cli.decode() → vim.json.decode per line
  ui.select()  → picker if available, else vim.ui.select

# test — the seam is the bundle root, never the filesystem globally
Todos.list(root: fixture_root, status: :open)     # tmp bundle written per test
Mix.Tasks.Brain.Todo.run(["list", "--format", "ndjson"])  # captured via ExUnit
```

**Boundary decisions:**

- `ElixirMind.Todos` owns **all** filesystem reads and writes for todos; the
  mix task owns argument parsing and rendering only, and the Lua client owns
  no knowledge of the store's format beyond the NDJSON field names.
- The **NDJSON contract is the plugin's only coupling** to Elixir. Field names
  are the plugin's API; renaming one is a breaking change to the client.
- `SessionInit` keeps ownership of *ranking and digest rendering*; it delegates
  only the *scan*. The heuristic weights stay where they are.
- Index maintenance (`meta/todos/index.md`) belongs to `create/1`, not to the
  caller — otherwise the mix task and the `/todo` skill drift on whether the
  index was updated.
- The Lua client fetches **once per picker session** and filters in Lua
  (the `ribelo/taskwarrior.nvim` pattern), and holds no cache across
  invocations; a stale list is fixed by reopening the picker.

**Anchors** (verify against `HEAD` before building, per the
[structured-plan-bodies](/meta/policy/structured-plan-bodies.md) refresh rule):

- Reuse `ElixirMind.SessionInit.docs_in/2`'s scan shape
  (`lib/elixir_mind/session_init.ex:185`) — tolerant parse, `index.md`/`log.md`
  rejected, `{timestamp, rel_path}` descending sort. Its `to_priority/1`
  coercion is the model for the `priority` field.
- `ElixirMind.Frontmatter.parse/1` is the read entry point; do not add a second
  parser.
- `Mix.Tasks.Brain.SessionInit` is the template for the task wrapper: `@shortdoc`,
  `@moduledoc` with a usage block, `use Mix.Task`, `@impl Mix.Task` (never
  `@impl true`, per the contract's coding standards).
- The todo file template is fixed by the [`/todo`](/.claude/skills/todo/SKILL.md)
  skill's Create step; `create/1` must emit exactly that shape, including a
  valid `attribution` map, or `mix brain.verify` fails on the written file.
- Tests: `test/elixir_mind/session_init_test.exs` shows the fixture-bundle
  pattern to copy.
- Read before writing the Lua client: `ribelo/taskwarrior.nvim` for the
  CLI→JSON→picker shape, and `edmundmiller/tasknotes.nvim` for a markdown+
  frontmatter task model already expressed in Lua.
- `nvim/` must be added to `ElixirMind.SiteConfig`'s `@excluded_dirs`
  (`lib/elixir_mind/site_config.ex:28`, alongside `deprecated .claude lib test`),
  or the plugin source is published as pages.

## Build order

1. **`ElixirMind.Todos` read half** + tests. `list/1`, `get/1`, `to_ndjson/1`.
   Nothing else depends on it yet, so it lands green in isolation.
2. **`mix brain.todo list|show`** + `SessionInit` delegation. The delegation
   test asserts the digest is byte-identical before and after.
3. **The Neovim client**, read-only (`:BrainTodo` picker → jump to file). This
   is the first point the whole idea is usable, and it needs no write path —
   editing the todo is what the editor is for.
4. **`create/1` + `mix brain.todo new`** + `:BrainTodoNew`. Template render, so
   unblocked; the index-entry write is the fiddly part.
5. **[Deferred] `set_status/2` + `mix brain.todo done|cancel`.** Gated on
   `Frontmatter.dump/1` from the
   [frontmatter-parser rewrite](/meta/plans/frontmatter-parser-profile-rewrite.md).
   Until then, closing a todo stays a `/todo`-skill action, exactly as today.

Steps 1–3 are the minimum that answers the operator's question with something
runnable. Steps 4–5 are separable and can wait.

## Deferred

- **`set_status/2`** — see step 5; blocked, not descoped.
- **Extending the surface to issues, plans, and strands.** `SessionInit` already
  scans all four uniformly, so a `mix brain.work --kind` generalization is a
  short step from here. It is deliberately not step 1: the todo case is the one
  with a demonstrated consumer, and generalizing before a second consumer exists
  would be designing against a guess.
- **Startup-latency escape hatch.** `mix` pays BEAM startup and a compile check
  on every invocation, where the CLIs behind the precedent plugins (`gh`,
  `task`) start in milliseconds. Fetched once per picker session that is
  tolerable; per-keystroke it would not be. If measurement shows it grating,
  `mix escript.build` produces a self-contained binary with far lower startup,
  at the cost of a build step and a staleness question. Measure before
  building: the named experiment is "time `mix brain.todo list` on a cold
  shell, and decide against a 300ms budget."
- **Break-out to its own repository.** If the Lua client grows past a few
  hundred lines it stops being a thin client and becomes a system, at which
  point it graduates to a `type: project` hub under
  [`/projects/`](/projects/index.md) per the projects-namespace policy — the
  shape [`projects/dvorak-vim`](/projects/dvorak-vim.md) already uses for
  editor-side work. It is filed as a plan now because the buildable weight sits
  in this repo's tooling and the client is a shell-out.

## Decisions, alternatives, open questions

**Decided:**

1. **Build the surface over `meta/todos/`; do not adopt a task plugin.** The
   store, schema, verifier, and history already exist; every surveyed plugin
   would add a second store. Cost accepted: no scheduling, recurrence, or
   agenda view — `orgmode` has those and this will not.
2. **NDJSON with a hand-rolled encoder**, confined to one private function and
   written for deletion when the OTP floor rises. Rejected: adding Jason (breaks
   `deps: []`); emitting a bespoke delimited format (the client would need a
   parser instead of `vim.json.decode`).
3. **Read + create now, mutate later.** Refusing to write a second regex
   frontmatter mutator is the point; the alternative was building one and
   removing it when the parser rewrite lands.
4. **Name the task `brain.todo`**, matching every existing task, rather than
   pre-emptively `mind.todo`. It rides the
   [`brain.* → mind.*` rename](/meta/plans/rename-brain-tasks-to-mind.md) with
   the rest of the namespace; splitting the namespace early would give that
   accepted plan a second migration to perform.
5. **Incubate the plugin in-repo at `nvim/`**, not a separate repository yet —
   the client and the NDJSON contract it depends on change together, and one
   repo keeps them honest until the shape settles.
6. **File as a `plan`, not a `project` hub.** The center of gravity is this
   repo's Elixir tooling; the editor client is a shell-out thin enough to live
   inside the plan. Recorded because it is a judgment call and the deferred
   break-out condition above is when it flips.

**Open questions for the operator:**

1. **Should the Neovim client depend on a picker plugin?** A Telescope or
   `snacks.nvim` picker is a much better experience than `vim.ui.select`; a
   hard dependency makes the plugin non-portable to a config that lacks it.
   Recommendation: detect at runtime and fall back — the fallback is ~10 lines
   and keeps the plugin dependency-free.
2. **Does the todo surface belong in the editor at all, or in the shell?** Steps
   1–2 deliver a usable `mix brain.todo` on their own; the Neovim client is
   step 3 and could be dropped without invalidating the rest. Recommendation:
   build through step 3 — the editor is where the operator already is when a
   task occurs to them, which is the capture-friction argument for doing it.
