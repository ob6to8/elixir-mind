---
id: em:04281b
type: plan
title: "Dvorak vim — the keybinding reference"
description: Design for the reference half of the project — the command-character-plus-keycap notation, the layout/binding data split that keeps vim's binding set independent of any one layout, the three query directions (semantic, by-command, reverse-by-keycap), and the peek-key surface that beats a scratch buffer at answering "which key is that".
status: proposed
tags: [projects, vim, neovim, dvorak, reference-tooling, lua, planning]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed project sketch session"
  why: "the reference is one of the two components the operator named; its notation and data split are the decisions the drill engine depends on, so they are recorded before either is built"
---

# Dvorak vim — the keybinding reference

The [project hub](/projects/dvorak-vim.md) fixes the bounding constraint this
plan builds against: the reference competes with opening a scratch buffer and
pressing the key, which answers "which key is that" in roughly two seconds and
wins on latency against every stored diagram. A reference that costs more than
that gets skipped. Everything below is shaped by that budget.

## Current state

Nothing is built. The material that exists:

```
knowledge/human-computer-interaction/keyboard-layouts/
└── dvorak-qwerty-positional-mapping.md   # the layout table, both directions,
                                          # with row and finger per position
```

## Desired state — the surfaces

```
:Dv <query>          semantic lookup      "delete word"  → dw (h,)
:Dv =<keys>          by-command lookup    "=dw"          → dw (h,) delete word
:Dv ?                peek-key             press any key  → reports the character
                                          it produces and every binding on it,
                                          without executing it
:Dv                  browse, grouped by task
```

`:Dv ?` is the surface that retires the recovery loop. It is the scratch buffer
with the semantics attached and the round trip removed: the keypress is
captured rather than inserted, so the answer arrives with no buffer to open, no
text to undo, and no mode to leave.

The generated static forms — a printable one-page card and a web page — carry
the same table for the away-from-editor case, and are emitted from the same
data rather than maintained.

## Desired state — the data

Three modules, and the boundary between them is the load-bearing decision: the
binding set is vim's and knows nothing about layouts; the layout table is the
layout's and knows nothing about vim; one module joins them.

```
layout.lua      character → physical position        (generated from the
                                                      knowledge doc's table)
bindings.lua    vim's binding set, layout-agnostic
annotate.lua    the only module that reads both      → "dw (h,)"
```

A second layout is then one new table in `layout.lua` and no other change; a
new binding is one record in `bindings.lua` and is drillable immediately.

## File tree

```
dvorak-vim.nvim/
├── lua/dvorak-vim/
│   ├── init.lua        # NEW  setup/1, :Dv registration and argument dispatch
│   ├── layout.lua      # NEW  KeyPos records; the dvorak table
│   ├── bindings.lua    # NEW  Binding records for stock normal-mode vim
│   ├── annotate.lua    # NEW  keys × layout → display string; the shared primitive
│   ├── query.lua       # NEW  the three directions; returns data, renders nothing
│   ├── ui.lua          # NEW  floating-window render; peek-key capture
│   └── drill/          # see the drill-engine plan
└── gen/
    ├── card.lua        # NEW  printable one-page card
    └── site.lua        # NEW  static web page
```

## Signatures

```lua
---@class KeyPos
---@field label  string   -- the QWERTY keycap label: "f"
---@field shift  boolean  -- whether the character needs shift on that key
---@field row    "number"|"top"|"home"|"bottom"
---@field finger string   -- "left index", "right pinky", …

---@class Layout
---@field name   string
---@field pos    table<string, KeyPos>  -- character → position

---@class Binding
---@field keys   string    -- "dw", "ci(", "<C-o>"
---@field modes  string[]  -- {"n", "v", "o"}
---@field desc   string    -- "delete word"
---@field group  string    -- "motion" | "operator" | "text-object" | "mode" | …
---@field terms  string[]  -- extra search terms for semantic lookup

---Render a command as "<keys> (<labels>)"; passes <C-…> and <leader> through
---untouched, and uppercases a label whose character needs shift.
---@param keys   string
---@param layout Layout
---@return string
function annotate.render(keys, layout) end

---@param q      string  -- free text matched against desc and terms
---@param layout Layout
---@return Binding[]     -- ranked, best first
function query.semantic(q, layout) end

---@param keys   string
---@return Binding[]     -- bindings whose keys start with the given prefix
function query.by_command(keys) end

---Given a physical keycap label, the character it produces and what that
---character is bound to.
---@param label  string
---@param shift  boolean
---@param layout Layout
---@return string, Binding[]   -- the character, then its bindings
function query.reverse(label, shift, layout) end
```

## Boundary decisions

- **`layout.lua` owns the mapping and nothing else.** It has no notion of vim,
  of modes, or of what a binding is — so it is the only file a second layout
  touches.
- **`bindings.lua` owns vim and stays layout-blind.** It stores command
  characters exactly as vim documents them, so it can be checked against
  `:help` directly and stays correct under any layout.
- **`annotate.lua` is the sole join.** Every surface — lookup, peek, drills,
  card, web page — renders through it, so the notation is decided once.
- **`query.lua` returns data; `ui.lua` renders.** The drill engine reuses query
  without inheriting a floating window.
- **The knowledge doc is upstream of `layout.lua`.** The table in
  [the positional mapping](/knowledge/human-computer-interaction/keyboard-layouts/dvorak-qwerty-positional-mapping.md)
  is the source; the Lua table is generated from it, so a correction lands in
  one place.

## Decisions and open questions

| Decision | Choice | Rationale |
|---|---|---|
| Notation | `keys (labels)` — command first | the reader arrives holding the command, having read it in a vim doc |
| Multi-key rendering | concatenate both halves, `dw (h,)` | keeps one token per command instead of a per-key table the eye has to reassemble |
| Shift rendering | uppercase the label, `: (Z)` | shows the physical action rather than the character, which is what the finger needs |
| Control and leader keys | passed through unannotated | `<C-o>` is layout-stable in the part that matters and annotating it adds noise |
| Layout table provenance | generated from the knowledge doc | the mapping is true regardless of this project and is filed accordingly |

Open:

- **Notation direction** — inherited from the hub's first open question and
  unresolved until the operator confirms; it is one line in `annotate.render`.
- **Semantic ranking** — whether `terms` hand-curated per binding is enough, or
  the query needs fuzzy matching over `:help` text pulled in at build time.
- **Peek-key capture in insert mode** — `getcharstr()` covers normal mode
  cleanly; whether the peek surface should be reachable mid-insert, and what it
  costs to get out and back, is unexamined.
- **Whether the card and web page are worth building at all** once `:Dv ?`
  exists, or whether they are only for the shared-machine case where the plugin
  is absent.
