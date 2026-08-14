---
id: em:253029
type: plan
title: "Neovim commands — architecture and build order"
description: Design for the neovim-commands repo — the one-file-per-intent data format and its parse contract, the thin picker plugin's module boundaries and signatures (picker-agnostic core, telescope adapter, vim.ui.select fallback), the add-flow, and the sequenced build from ratification to dogfooding.
status: proposed
provenance: "Claude Fable 5"
tags: [projects, neovim, vim, reference-tooling, fuzzy-finding, telescope, lua, planning]
timestamp: 2026-08-14
attribution:
  when: 2026-08-14T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed project spec session"
  why: "operator asked for the spec and architecture to be decided and recorded before any code is committed; the executor will be a future session that does not share this one's context"
---

# Neovim commands — architecture and build order

The [project hub](/projects/neovim-commands.md) fixes the premise: a recall
failure, answered by a personal file-per-intent corpus queried by intent from
inside the editor, with the answer displayed rather than executed. This plan
fixes the artifact: the data format's parse contract, the plugin's module
boundaries, and the build order.

## Current state

Nothing is built and the external repo does not exist. Adjacent material in
this brain:

```
projects/dvorak-vim/keybinding-reference-design.md   # :Dv semantic lookup over
                                                     # stock bindings — adjacent
                                                     # surface, different corpus
knowledge/SWE/dev-tools/
└── neovim-command-discovery-plugins.md              # the genre map; the
                                                     # picker-action vocabulary
                                                     # borrowed below
```

## Desired state — the repo

```
neovim-commands/                       # NEW  external repo; plugin + data in one
├── README.md                          # NEW  what it is, install, add-a-command
├── commands/                          # NEW  the corpus: commands/<category>/<intent>.md
│   ├── tabs/next-tab.md               #      seed examples…
│   ├── tabs/close-all-other-tabs.md
│   ├── windows/…  buffers/…  motions/…  editing/…  search-replace/…
│   ├── folds/…  marks/…  registers/…  macros/…  quickfix/…  lsp/…
│   ├── nvim-tree/…                    #      plugin categories sit beside stock ones
│   └── telescope/…
├── lua/nvim_commands/
│   ├── init.lua                       # NEW  setup(opts), open(), add(); data_dir resolution
│   ├── scan.lua                       # NEW  pure: commands/**/*.md → Entry[]
│   ├── pickers/
│   │   ├── telescope.lua              # NEW  primary adapter: finder/previewer/actions
│   │   └── ui_select.lua              # NEW  zero-dependency fallback
│   └── scaffold.lua                   # NEW  the add flow: template a file, :edit it
└── plugin/nvim-commands.lua           # NEW  :NvimCommands command; opt-in default keymap
```

## The format contract

A command file is markdown, written for a human first; the scanner reads only
the pieces below, and tolerates everything else.

```markdown
---
aliases: tab forward, switch tab
---
`gt` — next tab (`{n}gt` jumps to tab n)
`:tabnext`

Normal mode; `g<Tab>` returns to the last-visited tab.
```

- **Path is the primary index.** `commands/tabs/next-tab.md` contributes
  `tabs next tab` to the match corpus. Categories are directories; slugs are
  kebab-case intent phrases.
- **Frontmatter is optional**, and v1 reads exactly one key: `aliases:`, a
  one-line comma-separated list. Unknown keys are preserved and ignored — no
  YAML library, one pattern match.
- **The first non-empty body line is the primary invocation**, shown as the
  picker's command column; a leading backtick span is extracted (`gt`), the
  full line kept for the preview. Everything after it is alternates and notes,
  displayed by previewing the file itself.
- Placeholder brackets follow vim's help convention — `{n}` required,
  `[range]` optional — matching the notation in cheatsheet.nvim's format so
  a later autofill action can stop at the first placeholder.

## Call flow

Production topology:

```
:NvimCommands  /  <leader>? (opt-in)
└── require("nvim_commands").open(opts)
    ├── scan.entries(data_dir)              -- fresh scan per open; no cache
    └── pickers/telescope.open(entries)     -- when telescope is available
        └── pickers/ui_select.open(entries) -- fallback: vim.ui.select

:NvimCommands add [intent words…]
└── scaffold.new(words)
    ├── category prompt, completing over existing commands/*/ dirs
    ├── write commands/<category>/<slug>.md from the template (never overwrite)
    └── :edit the new file — the buffer is the authoring UI
```

Test topology: v1 ships with no automated suite — a personal plugin dogfooded
daily is its own oracle. The seam is kept clean anyway: `scan.lua` is a pure
function over a directory, so a headless `nvim -l` smoke test (scan the seed
corpus, assert entry count and shape) can bolt on without refactoring when the
parse contract next changes.

## Signatures

```lua
---@class Entry
---@field path     string    -- absolute file path
---@field category string    -- first directory under commands/
---@field name     string    -- de-hyphenated slug: "next tab"
---@field aliases  string[]  -- from frontmatter; {} when absent
---@field command  string    -- primary invocation, backticks stripped: "gt"
---@field ordinal  string    -- category .. name .. aliases — the fuzzy corpus

---@param data_dir string
---@return Entry[]
function scan.entries(data_dir) end

---@param entries Entry[]
---@param opts    {prompt?: string}   -- prompt pre-fills the picker's query
function pickers.open(entries, opts) end   -- both adapters share this shape

---@param words string[]              -- intent words from the command line
function scaffold.new(words) end
```

## Picker behavior

- **Display**: `category · name` left, primary `command` right-aligned — the
  answer is readable from the results list alone for the common case.
- **Ordinal** (what fuzzy matching runs against): `category name aliases`.
  Telescope's default sorter treats a spaced query as independent fuzzy terms,
  so "next tab" hits `tabs/next-tab.md` regardless of word order.
- **Preview**: the file itself, markdown filetype — alternates and notes cost
  no extra UI.
- **Actions**, v1: `<CR>` opens the file (read the detail, or edit it);
  `<C-y>` yanks the primary invocation. Recorded for v1.1, borrowed from
  cheatsheet.nvim's vocabulary: autofill the command line for `:`-invocations
  stopping at the first placeholder, execute directly, and create-from-query
  (scaffold a new file pre-named from the live prompt on a miss).

## Boundary decisions

- **`scan.lua` owns reading and parsing, and returns plain tables.** It never
  touches UI, so every adapter and any future surface (headless test, CLI)
  reads one implementation of the format contract.
- **Adapters own presentation only.** A picker file never parses markdown; a
  change to the format touches `scan.lua` alone.
- **`scaffold.lua` is the only writer**, and it refuses to overwrite — an
  existing file is opened instead, which is the update-in-place move.
- **`init.lua` owns configuration.** `data_dir` defaults to the plugin root's
  `commands/` (resolved relative to the Lua source location) and is
  overridable; installing from the local clone (lazy.nvim `dir =` / `dev =
  true`) is the documented setup, so `add` writes files git can commit.
- **Git stays outside the plugin.** Committing the corpus is the operator's
  motion; v1 adds no VCS integration to a reference tool.

## Build order

1. **Operator ratifies this plan** — including the two decisions that
  override the literal description: category directories instead of flat
  category-prefixed filenames, and display-only actions in v1.
2. **Create the external repo** (`neovim-commands` under the operator's
  GitHub account). This session's GitHub scope is elixir-mind-only, so the
  repo is created by the operator or by a session granted it; the brain marks
  the hub `active` when code lands there.
3. **Scaffold the plugin** — the file tree above, README included, installable
  via lazy.nvim from the local clone.
4. **Seed the corpus** — ~60–100 most-often-used intents across the stock
  categories plus `nvim-tree/` and `telescope/`; agent-generated, operator-
  reviewed (cheap to generate, and review is the quality gate).
5. **Dogfood and tune** — live with it; tune display columns, sorter choice,
  and the seed's signal density before adding any v1.1 action.
6. **v1.1 candidates, in whatever order usage argues for**: autofill/execute
  actions, create-from-query, a body-grep secondary mode (`live_grep` scoped
  to `data_dir` is nearly free), an fzf-lua adapter, and keycap annotation of
  key-sequence answers via
  [dvorak-vim's annotate join](/projects/dvorak-vim/keybinding-reference-design.md).

## Decisions and open questions

| Decision | Choice | Rejected alternative and why |
|---|---|---|
| Storage | one markdown file per intent | one line per cheat (cheatsheet.nvim's model) — no room for alternates and notes per intent; a single YAML/JSON register — authoring means editing structure, and fuzzy search needs a custom source anyway |
| Category encoding | directory per category, path-matched | flat `tabs-next-tab.md` (the operator's literal form) — identical search corpus, but a several-hundred-file flat directory browses poorly and the add flow would parse categories out of filenames instead of completing over directories |
| Search corpus | path words + `aliases:` frontmatter | body-text grep as the primary index — bodies hold prose whose words would pull unrelated hits into every query; grep stays as a deferred secondary mode |
| Interface | thin plugin; picker-agnostic core, telescope adapter first, `vim.ui.select` fallback | hard telescope dependency — forfeits the corpus's tool-agnosticism for no gain; building on cheatsheet.nvim — its line-per-cheat store is the part this project replaces |
| Answer delivery | display + yank; never execute in v1 | feedkeys execution — mode/count-dependent, and the tool's purpose is learning the key, not outsourcing the press |
| Data location | in the plugin repo | separate data repo — two clones and a path config for one personal tool |
| Freshness | rescan per open | cached index — a second copy of the corpus that can go stale to save milliseconds |
| Naming | repo `neovim-commands`, module `nvim_commands`, command `:NvimCommands` | — checked against a GitHub exact-phrase search: the name collides with nothing established |

Open:

- **The daily-driver picker** — telescope assumed; the operator's answer flips
  adapter order at zero cost to the core.
- **Repo visibility** — public recommended (plain install URL, nothing
  sensitive); the operator decides.
- **Seed breadth** — which plugins beyond nvim-tree and telescope belong in
  the seed corpus.
- **Category vocabulary** — the seed proposes ~14 categories; whether they
  match how the operator thinks (e.g. `search-replace` vs `substitute`)
  surfaces only in dogfooding, and renames are cheap while the corpus is
  young.
