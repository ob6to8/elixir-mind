---
type: reference
title: 2026-07-31-dvorak-vim-reference-and-practice-project
description: Operator proposed a layout-aware vim reference and practice system for Dvorak typists; the session sketched it as an incubating project (hub plus keybinding-reference and drill-engine plans), split the universally-true Dvorak-QWERTY positional mapping out to the knowledge taxonomy, surveyed prior art (finding the genre splits cleanly into static layout-aware cheatsheets and layout-blind drill tools, with vim's stock langmap support flagged as an unverified scope-narrowing risk), and closed with a build-order plan sequencing the three follow-ups before handing off to /create-pull-request merge.
provenance: "Claude Code session (Claude Opus 5, then Claude Sonnet 5 after a mid-session /model switch), 2026-07-31; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, vim, neovim, dvorak, keyboard-layouts, projects, prior-art]
timestamp: 2026-07-31
session: https://claude.ai/code/session_01SRMMrnt1jLMJcf5bdFyKqu
pr: 198
---

# 2026-07-31-dvorak-vim-reference-and-practice-project

## Where this landed

The operator asked for a sketch of a Dvorak-vim reference-and-practice project.
The session filed it as an incubating project
([em:dc21d4](/projects/dvorak-vim.md)) with two design plans — the keybinding
reference ([em:04281b](/projects/dvorak-vim/keybinding-reference-design.md))
and the drill engine ([em:da9532](/projects/dvorak-vim/drill-engine.md)) — and
split the layout-agnostic Dvorak-QWERTY positional mapping out to a new
`knowledge/human-computer-interaction/keyboard-layouts/` subtree
([em:9efeba](/knowledge/human-computer-interaction/keyboard-layouts/dvorak-qwerty-positional-mapping.md)),
per the projects-namespace split rule. The operator caught a notation-direction
error in the first pass (the worked example's two characters were transposed)
and confirmed the target hardware as a MacBook's QWERTY-engraved keyboard
running Dvorak in software; both closed as decisions. A prior-art survey then
found the genre split cleanly — every layout-aware artifact is a static
diagram, every drill tool is layout-blind — with vim's stock `langmap`/
`$VIMRUNTIME/macros/dvorak` support flagged as an unverified risk to the
project's premise. The session closed by persisting a build-order plan
sequencing three follow-ups (verify `langmap`, build a minimal `:Dv ?` peek-key
slice, read vimhjkl's implementation before designing drill mode 3) —
[em:715616](/projects/dvorak-vim/next-steps.md) — before handing off to
`/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Dvorak–QWERTY positional mapping | closed | [Dvorak–QWERTY positional mapping](/knowledge/human-computer-interaction/keyboard-layouts/dvorak-qwerty-positional-mapping.md) | - |
| Dvorak-vim project premise, notation, and prior art | closed | [Dvorak vim](/projects/dvorak-vim.md) | - |
| Keybinding reference design | closed | [The keybinding reference](/projects/dvorak-vim/keybinding-reference-design.md) | - |
| Drill engine design | closed | [The drill engine](/projects/dvorak-vim/drill-engine.md) | - |
| Build order for the three follow-ups | paused | [Next steps](/projects/dvorak-vim/next-steps.md) | verify `langmap` coverage, build the `:Dv ?` peek-key MVP, and read vimhjkl's implementation before designing mode 3 — order fixed in the plan, execution deferred to a future session |

## User

sketch out a project that is a reference and practice integration with vim for people who use dvorak

with dvorak I find that the muscle memory of typing prose is different than spacially remember exactly which key is which. what could be useful is a system of tests that help make that association, and also a reference to keybindings that list the dvorak key binding first and then the vilsual standard key second, ie. 'f (u)', meaning 'f' in dvorak 'u' in standard - this allows for quick lookup and avoids the 'open up a text editor to check exactly what that key is again" or "find that visual overlay I have stored somewhere and crossreference the key i want ok never mind I'll just open a text editor to check" problems

## Assistant

<routes ref="em:dc21d4">
I sketched the project and filed it. Here's the plain version first.

You described two things — a lookup reference and a set of practice tests — and I filed them as one project with a shared core, because they want the same underlying table: the list of vim commands crossed with where each character actually sits on your keyboard. Build that once, and the reference and the drills are both just different views of it.
</routes>

<routes ref="em:dc21d4">
Two things came out of thinking it through that changed the shape. First, the reason your stored overlay diagram goes unopened isn't that it's incomplete — it's that opening a text editor and pressing the key is *faster*. So the reference has to live inside the editor and answer in under a second, or it loses to the workaround again. Second, your problem isn't getting bindings wrong, it's the pause before getting them right. A practice system that scores correctness would tell you you've mastered exactly the keys that stall you — so the drills are timed, and a slow-but-correct answer counts as a miss.
</routes>

<routes ref="em:dc21d4 em:9efeba">
One thing I need you to check: your example `f (u)` has the two letters in the opposite relationship from the actual layout. The key labelled `f` produces the character `u` in Dvorak, not the reverse — so that pair, written as "command first," is `u (f)`: vim's undo, on the keycap marked `f`. I built the whole thing on command-first. If you meant keycap-first, it's a one-line flip.
</routes>

---

## What I created

| Type | Doc | Why this type |
|---|---|---|
| `project` | [Dvorak vim](https://github.com/ob6to8/elixir-mind/blob/claude/dvorak-vim-reference-c29zbn/projects/dvorak-vim.md) | a system built outside this repo, incubating here per the projects-namespace policy |
| `plan` | [The keybinding reference](https://github.com/ob6to8/elixir-mind/blob/claude/dvorak-vim-reference-c29zbn/projects/dvorak-vim/keybinding-reference-design.md) | notation, data split, and query directions are decisions the drill engine depends on |
| `plan` | [The drill engine](https://github.com/ob6to8/elixir-mind/blob/claude/dvorak-vim-reference-c29zbn/projects/dvorak-vim/drill-engine.md) | the scoring model is the decision that distinguishes it from a generic vim trainer |
| `claim` | [Dvorak–QWERTY positional mapping](https://github.com/ob6to8/elixir-mind/blob/claude/dvorak-vim-reference-c29zbn/knowledge/human-computer-interaction/keyboard-layouts/dvorak-qwerty-positional-mapping.md) | true regardless of the project, so the split rule files it to knowledge; `verified: false` — recalled from training, not checked against a primary source |

## What I modified

| File | Thrust |
|---|---|
| `projects/index.md` | listed the new project hub |
| `knowledge/index.md`, `index.md` | listed `human-computer-interaction/`, a new subdomain under the established `knowledge` top level (autonomous per the taxonomy protocol) |
| `meta/registry.md` | regenerated after minting four ids |

## Actions I have taken

| Action | Result |
|---|---|
| `mix brain.id` + `brain.registry` | 4 ids minted, registry regenerated |
| Full gate suite via pre-commit | all green; 188 tests pass. Two warnings fired, both pre-existing and unrelated (a ledger cross-check on a July 13 thread, and glossary description-overlap) |
| Committed and pushed | `745710b` on `claude/dvorak-vim-reference-c29zbn`. No PR opened |

## The design worth arguing with

<routes ref="em:dc21d4">
**The premise, stated precisely.** Typing prose trains sequences, not keys — you don't retrieve `d`-`e`-`l`-`e`-`t`-`e`, you execute the word as one motor program. On QWERTY the isolated-character skill gets built anyway, incidentally, because every glance at the keycap is a free repetition of the association. On Dvorak with standard hardware you get zero such repetitions, because the keycaps state the wrong character. Vim is the workload that exposes the gap, since it asks for isolated characters in sequences that aren't words. That's why this is a real skill deficit and not just a lookup problem.
</routes>

<routes ref="em:04281b">
**The surface that kills the recovery loop** is `:Dv ?` — press it, then press any key, and it reports which character that key produces and what it's bound to, without executing it. That's your scratch buffer, minus the round trip, plus the semantics.
</routes>

<routes ref="em:9efeba">
**One fact from the mapping that's worth having in your head regardless:** every digit and shifted digit is fixed, as are backtick and backslash — and exactly two letters don't move, `a` and `m`. Everything else displaces. And `hjkl`, four adjacent home-row keys on QWERTY, become three rows, both hands, and a right pinky.
</routes>

## Questions you need to answer

| # | Question | My recommendation |
|---|---|---|
| 1 | Notation direction — command-first (`u (f)`) or keycap-first (`f (u)`)? | Command-first. The character is what you arrive holding, having just read it in a `:help` page or a plugin README; the keycap is the unknown you're looking up. Your stated rule ("dvorak binding first, visual standard second") agrees — I think only the example letters got transposed. |
| 2 | What do your keycaps say — QWERTY labels, Dvorak engravings, or blank? | Assumed QWERTY-labelled. If they're Dvorak-engraved or blank, the parenthesized half is dead weight and the second element should be row-and-finger instead ("home, left index"), which the mapping table already carries. |

## Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Answer the two questions and leave it incubating | Both plans stay `proposed`; a later session executes from them with the refresh step. |
| 2 | Build the reference half first | The `:Dv ?` peek surface is the highest-value piece and needs only `layout.lua` + `annotate.lua` + key capture — a working day, not a project. |
| 3 | Ground the mapping table | Capture the Dvorak layout definition as a `type: source` and flip the claim to `verified: true`. It's the data everything else generates from, so an error in it propagates everywhere. |
| 4 | Open a PR | I held off since you asked for a sketch, not a landing. |

## User

1 - you are correct my mistake
2- are you referring to my avtual keyboard keys?

Do you see any project out there like this, or related to dvorak vim?

## Assistant

<routes ref="em:dc21d4 em:04281b">
Answering (2) first, then I'll go look.

**Yes — your actual physical keycaps.** The question is what's engraved on the plastic your fingers sit on. Three cases, and they want different second elements in the notation:

| Your hardware | The `(x)` half should be |
|---|---|
| QWERTY-engraved keycaps, Dvorak set in software | the QWERTY label — `u (f)` — since you can read it off the key |
| Dvorak-engraved keycaps (or a hardware-Dvorak board) | row + finger — `u (home, left index)` — the QWERTY label means nothing to you |
| Blank keycaps | row + finger, same reason |

Now let me check for prior art.
</routes>

## User

Qwerty

## User

Macbook

## Assistant

<routes ref="em:dc21d4">
Short version: yes, there's a lot out there — but it splits along exactly the seam this project would cross. Everything that knows about Dvorak is a **static picture**. Everything that drills you is **layout-blind**. Nobody has built the thing in the middle, and nobody grades on hesitation.

I found one thing that partly challenges the premise, though, so lead with that.
</routes>

## The finding that could change the plan

<routes ref="em:dc21d4 em:715616">
Vim has **built-in Dvorak support** — a `langmap` option and a stock `$VIMRUNTIME/macros/dvorak` macro. Per the search snippets, `langmap` translates keystrokes in insert, search, and command modes while leaving normal-mode navigation untouched. If that's accurate, a one-line config already handles part of what this project addresses, and the honest question becomes how much problem is left.
</routes>

Basis: search-result snippets only. I could not read the [Vim Tips Wiki page](https://vim.fandom.com/wiki/Using_Vim_with_the_Dvorak_keyboard_layout) directly — Fandom returned HTTP 402 to the fetch. You can settle it in ten seconds with `:h langmap` and `:e $VIMRUNTIME/macros/dvorak`. I flagged it in the hub as unverified rather than writing it in as established.

## The landscape

**Layout-aware references — every one a static diagram**

| Artifact | Form | Layouts |
|---|---|---|
| [mattmc3/neovim-cheatsheet](https://github.com/mattmc3/neovim-cheatsheet) | Google Sheets → PDF | Dvorak, Programmer Dvorak, Colemak(+DH), Workman, Norman, Carpalx, Minimak |
| [smt.io Dvorak edition](https://www.smt.io/posts/vim-cheat-sheet-for-programmers-dvorak-edition/) | PDF | Dvorak |
| [Wikimedia programming-Dvorak cheatsheet](https://commons.wikimedia.org/wiki/File:Cheatsheet_Vim_with_'programming_Dvorak'_layout.png) | PNG | Programmer Dvorak |
| [studylib vi/vim Dvorak](https://studylib.net/doc/11479665/vi---vim-graphical-cheat-sheet---q.-j) | PDF | Dvorak |

<routes ref="em:dc21d4">
`neovim-cheatsheet` is the closest existing thing to your reference, and it's well done — "a modern and customizable take on the excellent viemu cheat sheet, supporting QWERTY as well as alternative keyboard layouts such as Colemak and Dvorak". It is also, precisely, the artifact you described as unusable: a keyboard diagram, stored somewhere, that you cross-reference. Its existence proves the demand and its form is the gap.
</routes>

**The remapping school** — the other answer to the same problem: [danalexilewis/vim-dvorak](https://github.com/danalexilewis/vim-dvorak), [njcom/hjkl-remap](https://github.com/njcom/hjkl-remap), [tendertree/nforcolemak](https://github.com/tendertree/nforcolemak) (Colemak), [jbranso/evil-dvorak](https://github.com/jbranso/evil-dvorak) for Emacs.

**Drill tools — none layout-aware, none timed**

| Tool | Grades on | Layout |
|---|---|---|
| [matt-savvy/vim-gym](https://github.com/matt-savvy/vim-gym) | self-reported 0–5 → SR scheduling | none — README doesn't mention any layout |
| [S-Sigdel/vimhjkl](https://github.com/S-Sigdel/vimhjkl) | correctness + keystrokes vs "a verified par", Leitner box, 6 modes | remap support only |
| [dahu/vim-sm2](https://github.com/dahu/vim-sm2) | SM2 in pure VimL — a component | none |
| [VimGym](https://www.vimgym.dev/), [KeyCombiner](https://keycombiner.com/vim/), [ShortcutFoo](https://www.shortcutfoo.com/) | correctness, web-based | none |

<routes ref="em:da9532 em:715616">
`vimhjkl` is the strongest and has an idea better than mine: grading against a verified optimal keystroke count. I recorded that as something to lift rather than re-derive. `vim-gym` is the instructive counterexample — it asks you to self-report a 0–5 score, which is the exact input the latency rule exists to avoid, since self-rating is least reliable right after you've recovered from a stall.
</routes>

<routes ref="em:dc21d4">
**The unoccupied position:** layout-aware *and* a drill, in-editor, latency-graded, with the isolated character as a drillable unit. Scope of that claim — six web searches (Dvorak vim plugins/remapping, Dvorak cheatsheets, vim spaced-repetition trainers, layout-aware Neovim plugins, keybinding-display plugins) plus direct README reads of the three tools above. Not swept: dotfyle and awesome-neovim by name, or GitHub topics systematically.
</routes>

## Actions I have taken

| Action | Result |
|---|---|
| Wrote the survey into the hub as a `## Prior art` section | so it isn't stranded in chat — with the langmap caveat marked unverified |
| Added `## What to borrow` to the drill plan | vimhjkl's verified-par grading in, vim-gym's self-report explicitly out |
| Closed both open questions | command-first `u (f)` and QWERTY keycap labels moved from questions into decisions in the hub and reference plan |
| Committed and pushed | `39f1653`, gates green, 188 tests pass |

## Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Check `:h langmap` yourself | Ten seconds, and it's upstream of everything — if stock langmap covers more than expected, the project narrows to normal-mode navigation |
| 2 | Build `:Dv ?` alone | The peek-key surface is the whole reference value in one afternoon: layout table, annotate, `getcharstr()`. Nothing in the survey does this |
| 3 | Read `vimhjkl` properly before mode 3 | It has already solved the buffer-drill problem; mode 3 may be a fork rather than a build |
| 4 | Open a PR | Still holding off — you asked for a sketch |

## User

create a plan for 1/2/3, then
/create-pull-request merge
