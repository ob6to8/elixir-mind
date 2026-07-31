---
id: em:9efeba
type: claim
title: Dvorak–QWERTY positional mapping
description: The character-to-physical-key correspondence between the Dvorak Simplified Keyboard and the QWERTY key labels printed on standard hardware, in both directions, with the row and finger of each position — the lookup table any Dvorak-facing keybinding reference is generated from.
verified: false
tags: [keyboard-layouts, dvorak, qwerty, touch-typing, input, reference-data]
timestamp: 2026-07-30
provenance: "Claude Opus 5, recalled from training; the standard US Dvorak Simplified Keyboard arrangement"
attribution:
  when: 2026-07-30T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed project sketch session"
  why: "the mapping is true regardless of the dvorak-vim project that prompted it, so the split rule files it to the knowledge taxonomy where the project links out to it"
---

# Dvorak–QWERTY positional mapping

A Dvorak typist working on standard hardware holds two coordinate systems at
once: the **character** a key produces (Dvorak) and the **label** printed on
its keycap (QWERTY). Almost every keyboard, diagram, and colleague's machine
speaks the second; the typist's own fingers speak the first. This document is
the correspondence between them, in both directions, plus the row and finger
of each physical position — the data a layout-aware reference or drill is
generated from rather than restating by hand.

`verified: false` — the arrangement below is asserted from training, not
checked against a primary source in this session. Grounding it wants a
`type: source` capture of the Dvorak layout definition (ANSI X4.22-1983, or
the layout tables shipped with X11 / macOS / Windows).

## What stays put

Three groups of keys are identical between the two layouts, and knowing this
shrinks what has to be learned:

- **Every digit and every shifted digit.** `1`–`0`, and `!  @  #  $  %  ^  &
  *  (  )` with them.
- **Backtick/tilde and backslash/pipe.** `` ` `` `~` `\` `|`.
- **Exactly two letters: `a` and `m`.** Every other letter moves.

Everything remaining — the other 24 letters and the non-digit punctuation —
is displaced.

## Physical position → Dvorak character

Read the QWERTY label off the keycap, get the character it produces.

| Row | QWERTY labels | Dvorak characters |
|---|---|---|
| Number | `` ` `` `1` `2` `3` `4` `5` `6` `7` `8` `9` `0` `-` `=` | `` ` `` `1` `2` `3` `4` `5` `6` `7` `8` `9` `0` `[` `]` |
| Top | `q` `w` `e` `r` `t` `y` `u` `i` `o` `p` `[` `]` | `'` `,` `.` `p` `y` `f` `g` `c` `r` `l` `/` `=` |
| Home | `a` `s` `d` `f` `g` `h` `j` `k` `l` `;` `'` | `a` `o` `e` `u` `i` `d` `h` `t` `n` `s` `-` |
| Bottom | `z` `x` `c` `v` `b` `n` `m` `,` `.` `/` | `;` `q` `j` `k` `x` `b` `m` `w` `v` `z` |

Shifted pairs travel with their key, so the shifted characters land wherever
their unshifted partner did: `:` on the key labelled `z`, `<` on `w`, `>` on
`e`, `?` on `[`, `"` on `q`, `_` on `'`, `{` on `-`, `}` on `=`, `+` on `]`.

## Dvorak character → physical position

The direction a keybinding reference needs: given the character a program
documents, find the key to press and where it sits.

| Char | Key label | Row | Finger |
|---|---|---|---|
| `a` | `a` | home | left pinky |
| `b` | `n` | bottom | right index |
| `c` | `i` | top | right middle |
| `d` | `h` | home | right index |
| `e` | `d` | home | left middle |
| `f` | `y` | top | right index |
| `g` | `u` | top | right index |
| `h` | `j` | home | right index |
| `i` | `g` | home | left index |
| `j` | `c` | bottom | left middle |
| `k` | `v` | bottom | left index |
| `l` | `p` | top | right pinky |
| `m` | `m` | bottom | right index |
| `n` | `l` | home | right ring |
| `o` | `s` | home | left ring |
| `p` | `r` | top | left index |
| `q` | `x` | bottom | left ring |
| `r` | `o` | top | right ring |
| `s` | `;` | home | right pinky |
| `t` | `k` | home | right middle |
| `u` | `f` | home | left index |
| `v` | `.` | bottom | right ring |
| `w` | `,` | bottom | right middle |
| `x` | `b` | bottom | left index |
| `y` | `t` | top | left index |
| `z` | `/` | bottom | right pinky |

Punctuation, same direction:

| Char | Key label | Row | Finger |
|---|---|---|---|
| `;` `:` | `z` | bottom | left pinky |
| `,` `<` | `w` | top | left ring |
| `.` `>` | `e` | top | left middle |
| `'` `"` | `q` | top | left pinky |
| `/` `?` | `[` | top | right pinky |
| `-` `_` | `'` | home | right pinky |
| `=` `+` | `]` | top | right pinky |
| `[` `{` | `-` | number | right pinky |
| `]` `}` | `=` | number | right pinky |

## Why this collides with vim specifically

The layout is optimized for English prose: the home row spells `aoeuidhtns`,
putting the highest-frequency letters under the strongest fingers. Vim's
command set was designed against QWERTY's geometry, where the choices encode
*spatial* facts rather than linguistic ones — `hjkl` are four adjacent home-row
keys, `dw` and `db` sit under opposite hands, `n`/`N` are a shift apart under
one finger.

Run those choices through the table above and the geometry dissolves:

| Vim | Key label | Row | Finger |
|---|---|---|---|
| `h` (left) | `j` | home | right index |
| `j` (down) | `c` | bottom | left middle |
| `k` (up) | `v` | bottom | left index |
| `l` (right) | `p` | top | right pinky |

Four adjacent keys under one hand become three rows, both hands, and a pinky.
The mnemonic layer survives the translation intact — `d` is still delete, `y`
still yank — because it is linguistic; the spatial layer does not survive,
because it was never about the characters.

This is the general shape of the problem: a keybinding scheme carries two kinds
of design, and a layout change preserves the mnemonic kind while destroying the
positional kind. Any remedy therefore has to supply the positional layer
separately, since the program's own documentation encodes it only implicitly,
in the QWERTY geometry it assumes.
