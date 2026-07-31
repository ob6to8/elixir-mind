# Dvorak vim — documents

Design records for [Dvorak vim](/projects/dvorak-vim.md). Project-scoped by
construction: anything true regardless of this system files to
[knowledge](/knowledge/index.md) instead, per the
[projects-namespace policy](/meta/policy/project-namespace.md) — the
Dvorak–QWERTY layout table is filed there for exactly that reason.

## Design records

- [The keybinding reference](/projects/dvorak-vim/keybinding-reference-design.md)
  — the command-character-plus-keycap notation, the layout/binding data split
  that keeps vim's binding set layout-blind, the three query directions, and
  the peek-key surface that answers "which key is that" faster than a scratch
  buffer. _(plan)_
- [The drill engine](/projects/dvorak-vim/drill-engine.md) — three escalating
  drill modes over the same binding data, graded on response latency in bands
  so a recovered-after-a-stall answer schedules like a miss. _(plan)_
