---
type: reference
title: 2026-07-31-todo-surface-cli-and-neovim-plan
description: The operator asked what prior work existed on a Neovim todo system and whether to build one in Elixir with mix tasks and an IEx entry point; a repo check found no prior work, a verified 15-repo plugin survey found no maintained plugin reading markdown-with-frontmatter as a task source, and the session closed by filing a plan for an ElixirMind.Todos module, a mix brain.todo task emitting NDJSON, and a thin shell-out Neovim client.
provenance: "Claude Code session (claude-sonnet-5, switched to claude-opus-5 mid-session), 2026-07-31; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, todos, neovim, editor-integration, cli, ndjson, elixir-tooling, planning]
timestamp: 2026-07-31
session: https://claude.ai/code/session_01RMxto949nCMPrJimKDALg6
pr: 207
---

# 2026-07-31-todo-surface-cli-and-neovim-plan

## Where this landed

A scoping session that started as a question about prior art and ended with one
filed plan. The repo check found no prior work on a Neovim todo system — the
nearest neighbours are the [dvorak-vim project](/projects/dvorak-vim.md)
(editor-side, unrelated subject) and the
[2026-07-25 journal entry](/journal/2026-07-25.md)'s question about Manus-style
todo *recitation* into agent context, which is a different mechanism aimed at
agents rather than at the operator.

The plugin survey was run twice: once from model recollection in the opening
answer, then verified against 15 repositories via the GitHub API. Verification
corrected two recalled facts (`arnarg/todotxt.nvim` is archived; taskwiki's
canonical slug is `tbabej/taskwiki`) and surfaced two things recollection had
missed — `edmundmiller/tasknotes.nvim`, whose data model is markdown-plus-YAML-frontmatter
exactly like `meta/todos/`, and a firm CLI-shell-out precedent in
`octo.nvim` and `ribelo/taskwarrior.nvim` together with its latency caveat.

Two constraints found by reading the tree, rather than assumed, shaped the
build order in the resulting plan: there is no JSON encoder available (Elixir
1.14 / OTP 25 under `deps: []`, and `:json` arrives in OTP 27), and the
mutate-a-todo half is blocked on an order-preserving frontmatter serializer
that the [parser rewrite](/meta/plans/frontmatter-parser-profile-rewrite.md)
has not yet built. The plan therefore ships read-and-create first and leaves
`done`/`cancel` as a `/todo`-skill action.

Outcome: [a mechanical todo surface](/meta/plans/todo-cli-and-neovim-surface.md),
`status: proposed`, carrying six recorded decisions and two open questions for
the operator.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Prior work on a Neovim todo/productivity system in this brain | closed | [todo-cli-and-neovim-surface](/meta/plans/todo-cli-and-neovim-surface.md) | - |
| Neovim task-plugin landscape and the adopt-vs-build call | closed | [todo-cli-and-neovim-surface](/meta/plans/todo-cli-and-neovim-surface.md) | - |
| An Elixir todo surface: module, mix task, IEx entry point | open | [todo-cli-and-neovim-surface](/meta/plans/todo-cli-and-neovim-surface.md) | Plan is `proposed` — awaits operator ratification before execution |
| Whether the Neovim client should depend on a picker plugin | paused | [todo-cli-and-neovim-surface](/meta/plans/todo-cli-and-neovim-surface.md) | Telescope/snacks dependency vs. runtime detection with a `vim.ui.select` fallback (recommended) |
| Whether the editor client is worth building at all vs. the shell surface alone | paused | [todo-cli-and-neovim-surface](/meta/plans/todo-cli-and-neovim-surface.md) | Steps 1–2 are useful standalone; recommendation is to build through step 3 |
| Filing genre: plan vs. a `projects/` hub for the editor client | closed | [todo-cli-and-neovim-surface](/meta/plans/todo-cli-and-neovim-surface.md) | - |

## User

What work has been done on creating a todo/productivity tracking system in neovim? Are there some existing plugins?

Alternatively, what about using or creating one written in elixir? Imagining shell mix tasks as well as maybe even being able to drop into iex

## Assistant

I checked the brain first — no existing project or note on a neovim todo/productivity system. The closest is `projects/dvorak-vim` (a keybinding drill engine, unrelated), and journal entries from 2026-07-25 touch on Manus-style todo *recitation* for agents, not a neovim tool. So this would be a new area, not a resume.

**Neovim landscape (from memory, unchecked against docs):**
- `folke/todo-comments.nvim` — highlights/greps `TODO:`/`FIXME:` comments in code, not a standalone tracker.
- `nvim-orgmode/orgmode` — full org-mode port (agenda, TODO states, scheduling, recurring tasks) — closest to a real GTD system.
- `nvim-neorg/neorg` — broader PKM/note system with a task module, more ambitious/less stable than orgmode.
- `vimwiki/vimwiki` — wiki + simple `[ ]`/`[X]` checkboxes, no scheduling logic.
- `arnarg/todotxt.nvim` / various todo.txt plugins — thin wrappers around the todo.txt format.
- `kristijanhusak/orgmode`-adjacent and Taskwarrior bridges (`taskwiki`, mostly Vim not Neovim-native) — offload the actual data model to Taskwarrior, Neovim is just the UI.

None of these read your OKF bundle's `type: todo` docs under `meta/todos/` — they're independent data stores.

**Elixir option — my recommendation: build a thin Neovim UI over your existing `meta/todos/` + `mix brain.*` layer, rather than adopting a separate system.** You already have the data model (frontmatter, `status`, the `/todo` skill, `mix brain.session_init`); the gap is just an editor-native front end. Concretely: a `mix todo.*` task family (list/create/done) that shells out cleanly, plus a Neovim plugin that shells to `mix` and parses JSON output into a picker (Telescope/snacks.nvim) — no Lua reimplementation of the data logic. `iex -S mix` then gives you a REPL over the same `ElixirMind.Todo`-style module for ad hoc queries, which none of the existing plugins offer since they don't know your bundle exists.

**Main tradeoff:** an existing plugin (orgmode.nvim) is more mature and comes with scheduling/recurring tasks for free, but it means a second, disconnected task store living outside the brain. Building it in Elixir keeps everything in one queryable system (one source of truth, git-tracked, already governed by your contract) at the cost of writing the Neovim-side UI yourself.

Want me to sketch this as a `type: plan` (mix task shape, Lua plugin skeleton, IEx module signatures) before any code gets written?

## User

yes sketch as a plan, then
/create-pull-request merge
