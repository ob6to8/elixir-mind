---
id: em:715616
type: plan
title: "Dvorak vim — next steps: verify langmap, build the peek MVP, read vimhjkl"
description: Build-order plan sequencing the three follow-ups the prior-art survey surfaced — verify whether vim's stock langmap already covers part of the project's premise, build a minimal :Dv ? peek-key slice of the keybinding reference, and read vimhjkl's implementation (not just its README) before designing the drill engine's mode 3 — so a cold session executes in the right order instead of guessing it.
status: proposed
tags: [projects, vim, neovim, dvorak, planning, build-order]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed project sketch session"
  why: "operator directed persisting a plan for the three next steps before closing the session; execution is deferred to a future session that will not share this session's context on why the order was chosen"
---

# Dvorak vim — next steps: verify langmap, build the peek MVP, read vimhjkl

The [prior-art survey](/projects/dvorak-vim.md) in this session's hub update
surfaced three follow-ups, each of which changes what gets built next. This
plan fixes their order and scope rather than leaving a future session to
re-derive it from the survey prose.

## Order

### 1. Verify langmap — first, because it can shrink the whole project

Vim ships a `langmap` option and a stock `$VIMRUNTIME/macros/dvorak` macro.
Whether either covers normal-mode command characters is currently unverified —
the hub's account of them rests on web-search snippets, not `:help` itself
(a direct fetch of the source page 402'd). Run `:h langmap` and
`:e $VIMRUNTIME/macros/dvorak` and read what they actually do.

- If `langmap` only translates insert/search/command-line text entry, as
  reported, and leaves normal-mode commands untouched, the project's premise
  in the hub stands unchanged.
- If it also covers normal-mode command characters, the reference and drill
  scope narrows to whatever `langmap` doesn't already solve — the hub's
  premise section needs re-scoping before step 2 proceeds.

This gates step 2's **scope**, not its existence: the peek-key MVP is useful
either way, so it is not blocked on this check completing.

### 2. Build the `:Dv ?` peek-key MVP

The minimal slice of
[the keybinding reference](/projects/dvorak-vim/keybinding-reference-design.md)
that delivers the surface identified as the actual value: press a key, see
the character it produces and what that character is bound to, without
executing it. Semantic lookup, by-command lookup, and the generated static
forms are deferred — they read the same underlying data and cost nothing to
add once real usage justifies them.

File tree, trimmed from the full reference plan's tree:

```
dvorak-vim.nvim/
└── lua/dvorak-vim/
    ├── init.lua      # NEW  :Dv registration, dispatches to peek only
    ├── layout.lua    # NEW  KeyPos records; the dvorak table, generated
    │                        from the knowledge doc's mapping table
    ├── bindings.lua  # NEW  Binding records — normal-mode core only;
    │                        the full set from the reference plan can wait
    ├── annotate.lua  # NEW  keys × layout → display string, per the
    │                        reference plan's signature
    └── ui.lua        # NEW  peek-key capture (getcharstr) + floating
                             window render
```

`query.lua`, `drill/`, and `gen/` stay deferred; the full reference and drill
plans still govern their eventual shape unchanged by this cut.

### 3. Read vimhjkl's source before designing mode 3

The prior-art survey read
[vimhjkl](https://github.com/S-Sigdel/vimhjkl)'s README, not its
implementation. Before
[the drill engine](/projects/dvorak-vim/drill-engine.md)'s mode 3 (execute)
is designed in earnest, read the actual scoring code — how it captures
keystrokes via `vim -W`, computes the verified-par comparison, and structures
its Leitner scheduling — to decide whether mode 3 **forks vimhjkl directly**
(adding layout awareness and latency timing on top of its existing
correctness/efficiency grading) or is a **fresh build** that borrows only the
verified-par idea. This turns the drill plan's "what to borrow" section from a
README-level gesture into a concrete integration decision, and resolves its
open "Mode 3 material" question.

## Decisions

| Decision | Choice | Rationale |
|---|---|---|
| Order | verify → build → research, not build-first | `langmap` can shrink the project's scope; better to know before `bindings.lua`'s normal-mode set is written against an assumption that might be wrong |
| MVP scope | peek-key only, no lookup or generation | it is the surface identified as retiring the recovery loop; the rest waits for real usage to justify the added surface area |
| vimhjkl timing | read its source before mode 3, not before the MVP | mode 3 doesn't block the peek-key MVP, and using the MVP will surface real friction that should inform how mode 3 gets scoped |

## Carried-over open questions

Unaffected by this sequencing; still open in the plans that own them:

- Semantic ranking; peek-key capture in insert mode —
  [the keybinding reference](/projects/dvorak-vim/keybinding-reference-design.md)
- Latency thresholds; mode-3 material; typing-hand confound; session shape;
  item retirement — [the drill engine](/projects/dvorak-vim/drill-engine.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:715616">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-31-dvorak-vim-reference-and-practice-project (2026-07-31)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:715616`]**  (co-feeds: `em:dc21d4`)

Vim has **built-in Dvorak support** — a `langmap` option and a stock `$VIMRUNTIME/macros/dvorak` macro. Per the search snippets, `langmap` translates keystrokes in insert, search, and command modes while leaving normal-mode navigation untouched. If that's accurate, a one-line config already handles part of what this project addresses, and the honest question becomes how much problem is left.

---

**[`em:715616`]**  (co-feeds: `em:da9532`)

`vimhjkl` is the strongest and has an idea better than mine: grading against a verified optimal keystroke count. I recorded that as something to lift rather than re-derive. `vim-gym` is the instructive counterexample — it asks you to self-report a 0–5 score, which is the exact input the latency rule exists to avoid, since self-rating is least reliable right after you've recovered from a stall.
