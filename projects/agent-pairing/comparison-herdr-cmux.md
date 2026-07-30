---
id: em:48e404
type: analysis
title: "Agent pairing vs. herdr and cmux — complementary, competitive, or superseding?"
description: Compares the agent-pairing supervision layer against the two leading agent-aware terminals along the granularity axis, finding them complementary by construction at the substrate level, competitive over the attention-routing surface, and superseding only the sidebar's role once decision-granularity routing exists.
tags: [projects, agent-pairing, analysis, herdr, cmux, supervision, competitive]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T06:02:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed design session on agent-driven editor workflows"
  why: "operator asked for an explicit comparison against the tools this system would sit beside, to decide where it composes and where it collides"
---

# Agent pairing vs. herdr and cmux

**Question.** herdr and cmux are the two strongest agent-aware terminals. Agent
pairing is a supervision layer that renders agent work into the operator's
editor. Where do they compose, where do they collide, and what — if anything —
does one make redundant?

**Thesis.** They are complementary by construction at the substrate level and
compete over exactly one surface: **attention routing**. herdr and cmux route
attention *to an agent* and stop; agent pairing routes attention *within* an
agent's work. Because the second subsumes the question the first answers,
agent pairing supersedes the agent-state sidebar's role as the operator's
primary queue while leaving both terminals' substrate role untouched — and a
terminal that grows edit-granularity awareness is the one path where the
relationship turns genuinely competitive.

## What each one is

| | herdr | cmux | agent pairing |
|---|---|---|---|
| Form | single ~10MB Rust binary, runs inside any terminal | native macOS terminal (Swift/AppKit on libghostty) | broker daemon + thin editor clients |
| Multiplexes | PTY panes, one per agent | tabs, splits, and git worktrees | nothing — it supervises one agent's edit stream at a time |
| Agent awareness | detects agent CLIs by process name and output; sidebar states blocked/working/done/idle | notification rings per pane; OSC 9/99/777; Claude Code hook integration | typed hook events: pending edit, tool input, diagnostics delta, fleet state |
| Programmability | socket for focus, splits, layout | CLI and socket API; `cmux list-workspaces` | the entire product is a programmable decision path |
| Persistence | background server, detach/reattach over SSH | native app; iOS companion sync | replay buffer, interjection record, rule store |
| Platform | Linux + macOS (Windows beta) | macOS only | wherever the harness and editor run |

Full details in the [console landscape](/knowledge/SWE/agentic/supervision/agent-supervision-consoles.md).

## Complementary: the substrate relationship

Agent pairing has no opinion about where processes live. It needs an agent
running somewhere and an editor running somewhere, and both terminals are good
at exactly that:

- **Process lifecycle and persistence.** herdr's background server keeps a herd
  alive across disconnects; cmux wraps the worktree lifecycle into single
  commands. Agent pairing supplies neither and should not.
- **The pane the client renders in.** The Neovim client needs a window beside
  the agent. herdr's unified `Ctrl+h/j/k/l` navigation across Vim splits and
  herdr panes, and its deck launcher opening editor + agent + shell + lazygit
  together, are the ergonomics this workflow assumes.
- **Remote and mobile reach.** herdr's SSH detach/reattach and cmux's iOS sync
  extend where supervision can happen; the broker is indifferent to that
  distance because it speaks to the harness, not to a terminal.
- **cmux's hook integration is a shared dependency, not a conflict.** Both bind
  Claude Code hooks — cmux for notifications, agent pairing for decisions. Hooks
  compose: multiple matching hooks run in parallel and are deduplicated.

The composition is therefore natural: a herdr deck holding the agent pane, an
editor pane running the client, and the broker behind both.

## Competitive: the attention-routing surface

One question is contested. herdr's sidebar and cmux's notification rings exist
to answer *which agent needs me*. Agent pairing's deferred fleet decision queue
answers the same question by routing every agent's blocking decision point into
the editor's quickfix list.

The two answers differ in quality, not just location:

- **Signal derivation.** herdr infers state by matching process names and
  terminal output patterns; cmux surfaces what a pane chooses to emit as an OSC
  escape. Agent pairing reads typed hook events. Inference from rendered output
  is a scrape — it works well and it is guessing; a `PreToolUse` payload is not.
- **Granularity.** "Agent 3 is blocked" tells the operator where to look.
  "Agent 3 is about to delete this function, here is the diff" is the thing they
  were going to look *for*. Once the second exists, the first is a strictly
  weaker rendering of the same fact.
- **Destination.** Routing into quickfix puts the queue in the surface the
  operator is already working in, with `]q` navigation already in muscle memory,
  rather than in a sidebar they must switch to.

There is also a mild positional collision: both terminals are consolidating
toward being *the* agent control room, and a supervision layer that owns the
decision queue takes the most valuable part of that role.

## Supersession: bounded and specific

Agent pairing supersedes **the sidebar's role as the operator's primary attention
queue**, and nothing else. herdr and cmux retain process supervision, session
persistence, layout, worktree lifecycle, remote reach, and rendering — none of
which agent pairing attempts or should. A herdr user who adopts agent pairing
keeps herdr and stops consulting the sidebar first; that is a demotion of one
feature, not displacement of a tool.

It supersedes nothing at all in cmux's case beyond the same notification role,
because cmux's differentiators — libghostty rendering, GPU acceleration, iOS
sync, the scriptable browser pane — sit on axes agent pairing does not touch.

## Where it turns genuinely competitive

One path. **A terminal that grows edit-granularity awareness.** herdr is the
likelier of the two to take it: it already parses agent output for state, it is
already the session backend for editor plugins, and it has a plugin ecosystem
that would carry the rendering. If herdr bound Claude Code hooks directly and
rendered pending edits in a pane, it would occupy tiers 1 and 3 from a position
of existing distribution.

Two things argue against that outcome, neither decisive. It is off-thesis: both
tools are *terminals*, and their reason for existing is that agents render
themselves — taking a position on what an edit means is a different product.
And the editor-side rendering is the hard half — diffs in the operator's own
buffers, diagnostics deltas, quickfix integration — which a terminal is
structurally poor at, because it sees pixels where the editor sees structure.

The defensive posture follows from that and matches the
[opportunity assessment](/projects/agent-pairing/opportunity-assessment.md):
build the broker as cross-editor, cross-harness infrastructure rather than a
terminal feature, and lean on the capability neither terminal can reach — the
editor's own structured state, which is what makes diagnostics deltas,
absence-marks, and attention-aware scheduling possible at all.

## Verdict

| Relationship | Scope |
|---|---|
| Complementary | process lifecycle, persistence, layout, worktrees, remote/mobile reach — the substrate agent pairing assumes and does not build |
| Competitive | attention routing: the sidebar and notification rings vs. the decision queue |
| Superseding | the sidebar as *primary* queue, once decision-granularity routing exists — one feature demoted, no tool displaced |
| Threatening | only if herdr binds hooks and renders edits itself, which is off-thesis for a terminal and weak on the editor-side half |

Integrate rather than compete: ship the Neovim client assuming a herdr or cmux
pane around it, and treat their session APIs as placement targets rather than
rivals.
