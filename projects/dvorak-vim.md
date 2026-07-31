---
id: em:dc21d4
type: project
title: Dvorak vim
description: A layout-aware vim reference and drill system for Dvorak typists learning stock vim — every binding shown as the command character plus the QWERTY keycap that produces it, served inside the editor where the question is actually asked, and paired with latency-graded drills that build the isolated character-to-key association prose typing never trains.
status: incubating
tags: [projects, vim, neovim, dvorak, keyboard-layouts, spaced-repetition, reference-tooling]
timestamp: 2026-07-31
attribution:
  when: 2026-07-30T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed project sketch session"
  why: "operator proposed the system and directed sketching it as a project hub before any of it is built"
---

# Dvorak vim

A reference and a practice system for one specific population: people who type
Dvorak and use stock vim. The reference names every binding twice — the
character vim documents, and the QWERTY keycap that produces it — and lives
inside the editor. The drills train the association the reference is a crutch
for, so the crutch is needed less over time.

## The premise

**Typing prose trains sequences, not keys.** A fluent typist does not retrieve
`d`, `e`, `l`, `e`, `t`, `e` and press them; they execute the word as one
motor program. That is why layout fluency and keybinding fluency are separate
skills rather than one skill applied twice, and why someone who types Dvorak at
full speed can still stall on a single isolated `d`.

On QWERTY the gap gets filled incidentally: the keycap under the finger is
labelled with the character it produces, so every glance down is a free
repetition of the isolated association. A Dvorak typist on standard hardware
gets no such repetitions, because the keycaps state the wrong character — the
one surface that would teach the mapping is actively contradicting it. Vim,
which asks for isolated characters constantly and in sequences that are not
words, is exactly the workload that surfaces the missing skill.

Two failure modes follow, and this project targets one each:

- **The lookup stall.** The binding is known semantically ("delete inside
  parens") but its location is not, so the flow breaks while it is recovered.
- **The recovery loop.** The stored overlay diagram is somewhere else, so
  cross-referencing it costs more than opening a scratch buffer and pressing
  the key to see what appears — and the scratch buffer wins every time, which
  is why the diagram stays unopened and the mapping stays unlearned.

## The design consequence

The recovery loop is the sharper constraint, because it fixes a *latency
budget* rather than a content requirement. A scratch buffer answers "which key
is that" in about two seconds. Any reference that costs more than that loses,
however complete it is — and losing means it goes unconsulted, which is the
state the operator already reports. So:

**The reference has to be served where the question is asked, at a cost below
a scratch buffer.** That rules out the artifacts this genre usually produces —
a stored overlay image, a web cheatsheet, a printed card — as the *primary*
surface, not because they are wrong but because reaching them costs more than
the workaround they are competing with. The primary surface is in-editor and
one keystroke away; the printable and web forms are generated from the same
data for the cases where the editor is not available.

The same reasoning sets the drill metric. A drill scored on correctness would
call the operator fluent, because the answer is nearly always eventually
correct — the reported failure is the stall, not the error. So **drills are
graded on latency**, and a correct-but-slow answer schedules for repetition
exactly like a wrong one.

## Notation

Every binding is written **command character first, keycap second**:

```
u (f)     undo              — the character u, on the key labelled f
d (h)     delete operator   — the character d, on the key labelled h
f (y)     find char forward — the character f, on the key labelled y
:  (Z)    command line      — shift on the key labelled z
dw (h,)   delete word       — multi-key commands concatenate both halves
```

The first element is what every vim document, `:help` page, plugin README, and
Stack Overflow answer says. The second is what is printed on the hardware. A
reader who has one and wants the other gets both without leaving the line, in
either direction, which is the whole job.

## Shape

```
                    bindings.data ──┐   the single source of truth:
                    layout.data ────┤   vim's binding set × the Dvorak
                                    │   positional mapping
                                    ▼
                            ┌───────────────┐
                            │  generators   │
                            └───────┬───────┘
              ┌─────────────────────┼─────────────────────┐
              ▼                     ▼                     ▼
      in-editor lookup       drill engine          printable card
      (:Dv <query>)          (latency-graded       + web page
      semantic · by-key      spaced repetition)    (away from the editor)
      · reverse
```

Both halves read the same data, so a binding added to the reference becomes
drillable in the same motion, and a drill can link back to the reference entry
it exercises.

## Decisions so far

| Decision | Choice | Rationale |
|---|---|---|
| Notation order | command character, then keycap in parens — `u (f)` | the character is the key the reader arrives with, having read it in a vim doc; the keycap is what they are looking up. Operator-confirmed |
| Second element | the QWERTY keycap label | the target hardware is a MacBook's built-in QWERTY-engraved keyboard with Dvorak set in software, so the label is readable off the key. Row-and-finger is the fallback for Dvorak-engraved or blank keycaps, and the mapping table already carries it |
| Primary surface | in-editor, one keystroke away | the reference competes with a scratch buffer on latency, and any surface reached by leaving the editor loses that comparison |
| Drill metric | response latency, banded | correctness scores the operator as fluent on exactly the bindings that stall them |
| Learn stock vim | yes; the layout adapts, the bindings do not | remapping `hjkl` to the Dvorak home row restores adjacency but forfeits every `:help` page, plugin default, tutorial, and unconfigured machine — the reference exists precisely so stock stays viable |
| Host editor | Neovim | drills need real vim semantics to be worth anything, the reference needs to be in the editor anyway, and Lua makes both one plugin instead of two programs |
| Layout data | separate from binding data | the binding set is vim's; the mapping is the layout's — see [the positional mapping](/knowledge/human-computer-interaction/keyboard-layouts/dvorak-qwerty-positional-mapping.md), which other layouts can slot into unchanged |

## Prior art

The genre is populated, and it splits cleanly along the same seam this project
proposes to cross. Every layout-aware artifact is a **static diagram**; every
drill tool is **layout-blind**.

**Layout-aware references — all static, all outside the editor:**

| Artifact | Form | Layouts |
|---|---|---|
| [mattmc3/neovim-cheatsheet](https://github.com/mattmc3/neovim-cheatsheet) | Google Sheets, printable | Dvorak, Programmer Dvorak, Colemak (+DH), Workman, Norman, Carpalx, Minimak |
| [smt.io Dvorak edition](https://www.smt.io/posts/vim-cheat-sheet-for-programmers-dvorak-edition/) | PDF | Dvorak |
| [Wikimedia "Cheatsheet Vim with programming Dvorak"](https://commons.wikimedia.org/wiki/File:Cheatsheet_Vim_with_'programming_Dvorak'_layout.png) | PNG | Programmer Dvorak |

`neovim-cheatsheet` is the closest existing thing to the reference half, and it
describes itself as "a modern and customizable take on the excellent viemu
cheat sheet, supporting QWERTY as well as alternative keyboard layouts such as
Colemak and Dvorak". It is a keyboard *diagram* rendered per layout — precisely
the overlay artifact this project's premise identifies as the thing that goes
unconsulted, because reaching it costs more than the scratch-buffer workaround.
Its existence confirms the demand; its form is the gap.

**The remapping school** — the other answer to the same problem, taken by
[danalexilewis/vim-dvorak](https://github.com/danalexilewis/vim-dvorak),
[njcom/hjkl-remap](https://github.com/njcom/hjkl-remap),
[tendertree/nforcolemak](https://github.com/tendertree/nforcolemak) (the
Colemak equivalent), and
[jbranso/evil-dvorak](https://github.com/jbranso/evil-dvorak) for Emacs. Vim
also ships stock support here: `langmap`, and a `$VIMRUNTIME/macros/dvorak`
macro, with `langmap` reportedly translating in insert, search, and command
modes while leaving normal-mode navigation alone. That last detail is from
search results, unverified against `:help langmap` — check before relying on
it, since a stock `langmap` posture would be a real alternative to this
project's whole premise.

**Drill tools — none layout-aware, none latency-graded:**

| Tool | Grading | Layout awareness |
|---|---|---|
| [matt-savvy/vim-gym](https://github.com/matt-savvy/vim-gym) | self-reported 0–5, then SR scheduling | none — the README does not mention any layout |
| [S-Sigdel/vimhjkl](https://github.com/S-Sigdel/vimhjkl) | correctness + keystroke count against "a verified par"; Leitner box | remapped keys are "graded as the original", which is remap support rather than layout awareness |
| [dahu/vim-sm2](https://github.com/dahu/vim-sm2) | SM2 in pure VimL — a component, not a trainer | none |
| [VimGym](https://www.vimgym.dev/), [KeyCombiner](https://keycombiner.com/vim/), ShortcutFoo | web trainers, correctness-based | none |

`vimhjkl` is the strongest of these and worth reading before building mode 3 —
grading against a verified optimal keystroke count is a better idea than
anything in the drill plan, and should be borrowed. Neither it nor `vim-gym`
measures response time: `vim-gym` asks the learner to self-report, which is the
input this project's scoring rule specifically excludes, and `vimhjkl` scores
efficiency, which is a different axis from hesitation.

**The unoccupied position**, then, is the intersection: layout-aware *and* a
drill, in-editor, with latency as the grade and the isolated character as a
drillable unit. Scope of that negative finding — six web searches (vim/Dvorak
plugins and remapping, Dvorak vim cheatsheets, vim spaced-repetition trainers,
layout-aware Neovim plugins, keybinding-display plugins) plus direct reads of
the `neovim-cheatsheet`, `vim-gym`, and `vimhjkl` READMEs. Not searched: the
Neovim plugin registries (dotfyle, awesome-neovim) by name, or a systematic
GitHub topic sweep.

## Open questions

- **Scope of the binding set.** Stock normal-mode motions and operators are the
  obvious core. Whether it extends to visual mode, ex commands, and the
  operator's own plugin bindings determines whether the data file ships fixed
  or is user-extensible from the start.
- **Where the drills get their material.** Synthetic buffers are easy to
  generate and easy to game by pattern-matching the drill rather than the
  binding; real files from the operator's own work are harder to schedule
  around but train the actual task.
- **Whether the reference should learn.** It knows which bindings the drills
  score as stalled, so it could surface those first, or annotate them. This may
  also be a way to lose trust in the reference's ordering.

## Knowledge this project draws on

- [Dvorak–QWERTY positional mapping](/knowledge/human-computer-interaction/keyboard-layouts/dvorak-qwerty-positional-mapping.md)
  — the layout table both halves are generated from, and the account of which
  half of vim's design survives a layout change

## Documents

- [The keybinding reference](/projects/dvorak-vim/keybinding-reference-design.md)
  — notation, data model, and the three query directions
- [The drill engine](/projects/dvorak-vim/drill-engine.md) — the three drill
  modes and latency-graded scheduling
- [Project docs](/projects/dvorak-vim/index.md)
