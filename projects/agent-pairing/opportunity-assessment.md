---
id: em:c3c2f8
type: analysis
title: "Agent pairing — is there an unoccupied position, and where is the moat?"
description: Assesses each planned capability against what ships today, finding the edit-granularity supervision surface unoccupied while recording and correction-learning are already solved at the harness layer — and locates the defensible position in the rendering and governance layers rather than in capture.
tags: [projects, agent-pairing, analysis, competitive, supervision]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T05:58:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research session on agent supervision tooling"
  why: "records the competitive judgment that shapes the build order, so the reasoning survives the session that produced it"
---

# Agent pairing — is there an unoccupied position, and where is the moat?

**Question.** The agent-pairing system proposes an edit-granularity supervision
surface with four extensions layered on it. How much of that already ships, and
what part of it is defensible?

**Thesis.** The position is real but narrower than the feature list suggests.
Edit-granularity supervision and its rendering layer are unoccupied; session
recording and correction-learning are solved, well, by others. The defensible
work is **placement and governance** — projecting an event stream into the
operator's working surface, and putting operator ratification around what an
agent learns — not capture, which is where the effort would naturally go and
where it would be wasted.

## Capability by capability

| Capability | State of the art | Residue |
|---|---|---|
| Edit-granularity supervision (tiers 1–3) | consoles route attention at pane/workspace/task granularity and hand off; Omnara alone supervises at decision granularity, and off-editor | the whole surface |
| Exploration visibility | agent panes show "Read X / Grepped Y" as a chat-column activity feed; agent-inspect renders tool-call execution trees in the terminal; an open opencode request asks for an "agent activity flow view" | spatial projection onto the editor's own file tree and buffers, and the computed absences |
| Fleet decision queue | Omnara relays blockers to a phone; Vibe Kanban gives a review column; herdr and Claude Squad sit at pane/session granularity | in-editor rendering — quickfix as the exception queue |
| Session recording | **Entire** captures sessions via hooks, checkpoints on commit, stores metadata on an append-only shadow branch with a session ↔ commit join, and rewinds; Agent Note does the light version in git notes | paced replay only |
| Corrections → rules | Claude Code **auto memory** learns from corrections into `~/.claude/projects/<project>/memory/` across sessions; Cursor Memories is the same move | anchored capture, repetition detection, operator-ratified promotion into *committed* rules |

## What follows for the build

**Tier 2 consumes rather than builds.** Entire already solves capture,
checkpointing, and the commit join — the expensive, unglamorous half. Building a
second recorder would spend the project's scarcest effort re-solving a
maintained problem. The unbuilt piece is paced playback, which is a rendering
concern and sits naturally in this project.

**Correction-learning is a governance play or nothing.** The harness vendors own
the learning loop and will keep extending it; auto memory already does the core
of the capability. What they do not do is anchor a correction to a code
location, detect repetition across sessions, or route promotion through operator
ratification into rules that land in the repository — auto memory is
agent-private and ungated, which is the wrong trust model for a shared codebase.
That residue is real and narrow. It is a differentiator, not a headline.

**Exploration visibility is the cheapest unoccupied capability.** No protocol
design, no blocking, no agent cooperation — the same event stream, rendered
differently — and it yields a trust signal nothing else provides: an agent
editing a file it never read. Build it early.

## Where the moat is

Tier 1 is absorbable: a sidekick.nvim or similar could add follow-mode in an
afternoon, and probably will. What is not absorbable by an editor plugin is the
broker: the acknowledgement protocol, the pending queue, the interjection
record, and the rule store are cross-editor, cross-harness infrastructure, and
the value compounds as harnesses grow event surfaces. Building editor-first
would put the durable logic in the disposable layer.

The structural risk is different from the competitive one. Tier 3 costs full
operator attention, and the reason people run agents is to avoid spending it —
so tier 3's market is the subset of work where attention is worth it
(unfamiliar, subtle, high blast radius), while tiers 1 and 2 are cheap enough to
leave on always. Adoption likely concentrates in the tiers with the smaller
claim.

**Recommendation.** Build tier 1 first as a premise test, add exploration
visibility immediately after as the cheapest differentiated capability, and hold
tiers 2–3 until tier 1 demonstrates it changes operator behavior. Design
broker-first from the start even while only one client exists, because the
retrofit cost is the entire architecture.

## Scope of the negative findings

The claims above that something is unoccupied rest on: web searches for each
capability conducted 2026-07-30, plus surveys of Neovim plugin listings, the
herdr plugin ecosystem, and Cursor's shipped feature set. Not enumerated: the VS
Code and JetBrains marketplaces, GitHub topic listings, and non-English sources.
Exploration visibility in particular could exist as an obscure extension without
surfacing in a search of that shape, and a capability found later does not
invalidate the build order — it changes which tier is differentiated.
