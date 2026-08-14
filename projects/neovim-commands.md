---
id: em:b90524
type: project
title: Neovim commands
description: A personal, git-versioned corpus of Neovim commands — one markdown file per intent, categories as directories — surfaced inside the editor by a thin fuzzy picker, so typing "next tab" into a prompt returns `gt` with its alternates and notes.
status: incubating
provenance: "Claude Fable 5"
tags: [projects, neovim, vim, reference-tooling, fuzzy-finding, telescope, lua, knowledge-management]
timestamp: 2026-08-14
attribution:
  when: 2026-08-14T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed project spec session"
  why: "operator described the storage model and asked for the spec and architecture to be decided before any code is committed"
---

# Neovim commands

A command reference the operator owns and grows: every Neovim command they use
often — or keep forgetting — stored as one small markdown file in a category
directory, in a repo of its own (`neovim-commands`), and queried from inside
the editor through a fuzzy picker. The query is the *intent* ("next tab",
"collapse file tree"); the answer is the invocation (`gt`, `W` in nvim-tree)
plus its alternates and any notes, displayed rather than executed.

## The premise — recall, not discovery

The failure this fixes is a **recall** failure: the operator knows a command
exists — there is *some* way to close every other tab — but not what it is.
Stock vim commands have `:help`, but `:help` is indexed by the command's name,
which is exactly the missing piece; plugin commands (nvim-tree, telescope
itself) are worse, scattered across READMEs. What the operator holds is the
intent, so the reference must be **queryable by intent** and must answer where
the question arises: inside the editor, a keystroke away.

The corpus is deliberately personal rather than encyclopedic. It seeds with
the most-often-used core and grows one file at a time as real gaps surface —
a low-friction add flow is therefore part of the design, not an
afterthought. A curated corpus keeps every fuzzy query's result list
signal-dense; an encyclopedic one buries the commands actually used under
hundreds never used.

## The shape

```
neovim-commands (its own repo = a lazy.nvim-installable plugin + its data)
├── commands/<category>/<intent-slug>.md    one file per intent
│       body: invocations first, notes after; optional `aliases:` frontmatter
└── lua/nvim_commands/                      thin picker plugin
        scan  →  entries {category, name, aliases, command, path}
        pick  →  telescope adapter (vim.ui.select fallback)
        add   →  :NvimCommands add — scaffold a new file from a template
```

The picker fuzzy-matches over **path words plus aliases** — so both halves of
the operator's "file names or strings in a file" question are the index — and
previews the file body, which is where the displayed answer lives. Because the
corpus is plain files, it is picker-agnostic by construction: terminal `fzf`
over `commands/` works the day the data exists, before any plugin does, and
the corpus outlives whichever picker fronts it.

## Relationship to [Dvorak vim](/projects/dvorak-vim.md)

Adjacent surface, different question. Dvorak vim answers *"which physical key
produces this command"* — stock vim's binding set crossed with the layout
table, plus latency-graded drills. Neovim commands answers *"what is the
command for this intent"* — a personal corpus that includes plugin commands
and ex-commands no layout table covers. The seed data overlaps stock vim's
core bindings; that duplication is accepted for now, and a deferred
integration point is recorded in
[the architecture plan](/projects/neovim-commands/architecture-and-build-order.md):
dvorak-vim's `annotate` join could decorate this picker's key-sequence
answers with keycap annotations once both exist.

## Decisions so far

| Decision | Choice | Rationale |
|---|---|---|
| Storage unit | one file per **intent**, listing all its invocations (`gt`, `:tabnext`, `{n}gt` in one file) | the query is an intent; alternates belong on one page, not in sibling files that would split its search hits |
| Category encoding | a directory per category, matched via the relative path (`tabs/next-tab.md`) | the path still leads with the category, so fuzzy search sees it exactly as a `tabs-next-tab.md` filename would, and browsing/scaffolding get the directory tree for free; the operator's literal flat-filename form is the recorded alternative |
| Search corpus | path words + optional `aliases:` frontmatter | filenames carry the canonical phrasing; aliases carry synonyms ("file tree" for nvim-tree) without renaming files |
| Interface | thin Neovim plugin: picker-agnostic core, telescope adapter first, `vim.ui.select` fallback | telescope is the named daily driver; the fallback keeps the tool working with zero dependencies, and other adapters stay a small file each |
| Answer delivery | **display, never execute** in v1 | this is a learning surface — the point is to see `gt`, then press it; executing stored key sequences is mode- and count-dependent and teaches nothing. Autofill/execute actions are recorded as v1.1 candidates |
| Data location | inside the plugin repo, under `commands/` | one clone serves both; installed via lazy.nvim from the local clone so the add flow writes committable files |
| Freshness | rescan on every open; no cache, no index build | hundreds of small files stat in milliseconds; an index is a second copy that can go stale |

## Prior art

The genre map is filed as knowledge —
[Neovim command-discovery plugins](/knowledge/SWE/dev-tools/neovim-command-discovery-plugins.md)
— since it is true regardless of this project. The one-paragraph version:
the closest existing tool is
[cheatsheet.nvim](https://github.com/sudormrfbin/cheatsheet.nvim)
(telescope-fronted search over `description | command` one-liner rows in
`cheatsheet.txt` files); the palette genre
([legendary.nvim](https://github.com/mrjones2014/legendary.nvim) and kin)
executes what is already configured rather than teaching what isn't; and
telescope's own `keymaps` builtin introspects live mappings without intent
descriptions. None of the surveyed tools searches a personal, file-per-intent,
git-versioned corpus — that storage model is what this project exists to keep,
and cheatsheet.nvim's picker-action vocabulary (autofill, execute, yank) is
the part worth borrowing from the genre.

## Open questions

- **Which picker is the daily driver?** Telescope is assumed from the
  operator's description; if fzf-lua or snacks.picker is the actual habit,
  the adapter build order flips (the core is unaffected).
- **Repo visibility.** Nothing in a command reference is sensitive, so public
  is the low-friction default (plain lazy.nvim install); private works but
  adds auth friction to every machine.
- **Seed breadth.** The planned seed is the most-often-used core (~60–100
  intents) across stock vim plus nvim-tree and telescope; whether other
  plugins belong in the seed depends on the operator's actual plugin list.

## Documents

- [Architecture and build order](/projects/neovim-commands/architecture-and-build-order.md)
  — the data format contract, the plugin's module boundaries and signatures,
  the picker behavior, and the sequenced build
- [Project docs](/projects/neovim-commands/index.md)

## Knowledge this project draws on

- [Neovim command-discovery plugins](/knowledge/SWE/dev-tools/neovim-command-discovery-plugins.md)
  — the four genres that already answer "what's the command?" in-editor, and
  the gap between them this project's storage model sits in
