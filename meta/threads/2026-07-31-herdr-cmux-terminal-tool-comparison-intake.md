---
type: reference
title: 2026-07-31-herdr-cmux-terminal-tool-comparison-intake
description: Compared herdr, Warp, cmux, tmux, Ghostty, and Superlogical against herdr's own comparison matrix, evaluated where libghostty is actually adopted across them, and intook the two tools not yet in the bundle — herdr and cmux — as dev-tools reference docs.
provenance: "Claude Code session (Claude Sonnet 5), 2026-07-31; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, herdr, cmux, terminal, terminal-multiplexer, libghostty, dev-tools]
timestamp: 2026-07-31
session: https://claude.ai/code/session_01UKJddToWvJYDBzMKmU6JCW
---

# 2026-07-31-herdr-cmux-terminal-tool-comparison-intake

## Where this landed

The operator asked for a comparison of six terminal tools — herdr, Warp, cmux,
tmux, Ghostty, and Superlogical — against herdr's own published comparison
matrix, plus an evaluation of where `libghostty` is actually used across them,
and asked that any of the six not already in the bundle be filed via
`/intake`. A repo search found Warp, tmux, and Ghostty already represented
(glossary concepts plus the existing Superlogical capture from an earlier
session), leaving herdr and cmux as genuinely new. Both were researched
(product sites, GitHub repos, herdr's `/compare` matrix, Mitchell Hashimoto's
libghostty announcement) and filed as `reference` docs under the established
`knowledge/SWE/dev-tools/` directory — `em:eb9f29` (herdr) and `em:16581e`
(cmux) — with a dedup gold-set row harvested from the operator's comparison
phrasing. The full gate suite passed and the change was committed and pushed
to `claude/terminal-multiplexer-compare-dmzt6h`. The operator then invoked
`/create-pull-request merge` to capture, glossary, and land the change.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Compare herdr/Warp/cmux/tmux/Ghostty/Superlogical and evaluate libghostty adoption; intake the missing tools | closed | [herdr](/knowledge/SWE/dev-tools/herdr.md), [cmux](/knowledge/SWE/dev-tools/cmux.md) | - |

## User

https://herdr.dev/

compare herdr vs warp vs cmux vs tmux vs ghostty vs https://www.superlogical.com/, and evaluate the use of libghostty. reference https://herdr.dev/compare/#matrix

/intake any of these that are not already in the repo

## Assistant

<routes ref="em:eb9f29 em:16581e">
Pushed to `claude/terminal-multiplexer-compare-dmzt6h`. Here's the comparison and what got filed.

## In plain terms

You asked how six terminal tools stack up and where `libghostty` fits. The short version: two different games are being played. **tmux** and **herdr** are multiplexers — they run *inside* whatever terminal you already have and just manage panes/sessions; herdr's twist is that it also tracks whether an AI agent in each pane is blocked, working, or done. **Warp**, **cmux**, **Ghostty**, and **Superlogical**'s upcoming multiplexer are all terminal *emulators* — they own the window and do the actual pixel rendering. `libghostty` is Ghostty's rendering engine, pulled out into a reusable library — and it's being picked up specifically by that second group (cmux and Superlogical build on it directly; Ghostty *is* its origin), while Warp built its own renderer from scratch before libghostty existed, and the pure multiplexers (tmux, herdr) don't render anything themselves so libghostty doesn't apply to them at all. Two of the six — **herdr** and **cmux** — weren't in the bundle yet, so I filed them; Warp, tmux, and Ghostty were already covered (glossary terms plus the existing Superlogical capture), and Superlogical itself was captured in this same session's earlier turn.

## The comparison

**The two axes.** Herdr's own [comparison matrix](https://herdr.dev/compare/#matrix) draws exactly this line: "runs inside existing terminal" (Herdr, tmux/Zellij) vs. "no, terminal app" (cmux/Warp). That's the load-bearing distinction across all six:

| Tool | Kind | Renders its own pixels? | Uses `libghostty`? | Agent-aware? |
|---|---|---|---|---|
| [herdr](https://herdr.dev/) | multiplexer (Rust) | No — hosted by another terminal | No — nothing to render | Yes, per-pane state: blocked/working/done/idle |
| tmux | multiplexer (C) | No | No | No |
| [cmux](https://cmux.com/) | terminal emulator (Swift/AppKit, macOS) | Yes, via libghostty | **Yes** — rendering engine | Yes, sidebar + notifications |
| Warp | terminal emulator (Rust) | Yes, custom `WarpUI` on `wgpu` | No — predates libghostty, own renderer | Yes, native "Agentic Development Environment" |
| Ghostty | terminal emulator (Zig) | Yes | Is the source of libghostty | No (general-purpose) |
| [Superlogical](/knowledge/SWE/dev-tools/superlogical.md) | multiplexer (pre-launch) | Yes (its clients render) | **Yes**, explicitly built atop it | Framed around durable sessions across human/automated/agent work |

**libghostty's actual role.** It's a C-ABI library (currently just `libghostty-vt`: VT-sequence parsing + terminal state, extracted from Ghostty's proven core, zero dependencies) meant to let anyone embed correct terminal rendering instead of writing another ad-hoc ANSI parser. Its adopters so far are, unsurprisingly, exactly the tools that need a renderer and didn't want to build one: cmux wraps it in a native macOS shell; Superlogical's multiplexer clients build on it. tmux and herdr have no rendering surface to put it in — libghostty's own pitch does name multiplexers like tmux/zellij as *potential* future consumers (for VT parsing rather than rendering), but neither has adopted it. Warp is the interesting outlier: it needs exactly what libghostty offers but built `WarpUI` in-house years before libghostty existed, so it's a case of prior art rather than rejection.

**Where herdr and cmux actually differ from each other**, despite both being "agent-aware": herdr is infrastructure-first (SSH-reachable, remote, tmux-compatible keybindings, tracks *any* terminal-based agent anywhere) while cmux is experience-first (native macOS chrome, git/PR/port status in a sidebar, notification rings) — they're solving the same problem (agent visibility) from opposite ends of the stack (headless multiplexer vs. polished native app), which is exactly the pairing herdr/cmux occupy on opposite sides of its own matrix.

## What I did

| Doc | Type | Why this type |
|---|---|---|
| `knowledge/SWE/dev-tools/herdr.md` (`em:eb9f29`) | `reference` | Captured/summarized external material (herdr.dev, its compare matrix, GitHub repo) |
| `knowledge/SWE/dev-tools/cmux.md` (`em:16581e`) | `reference` | Captured/summarized external material (cmux.com, GitHub repo) |

| File | Change |
|---|---|
| `knowledge/SWE/dev-tools/index.md` | Added herdr and cmux entries |
| `meta/registry.md` | Regenerated for the two new ids |
| `meta/evals/dedup-probe.md` | Harvested a gold row from your comparison phrasing; refreshed baseline (6/20, no regression) |

| Action | Result |
|---|---|
| Dedup search (herdr/cmux/warp/tmux/ghostty/libghostty) | No existing docs for herdr or cmux; warp/tmux/ghostty already represented via glossary + the Superlogical capture, so skipped per your instruction |
| Full pre-commit gate suite (`format`, `xref`, `verify`, `route_tags`, `glossary`, `lineage`, `test`) | All green — 188 tests passing |
| Committed and pushed | `40345be` on `claude/terminal-multiplexer-compare-dmzt6h` |

No new directory or type was needed (both filed autonomously under the already-established `dev-tools`), so nothing is awaiting ratification. No PR opened, since none was requested — let me know if you'd like one.
</routes>

## User

/create-pull-request merge
