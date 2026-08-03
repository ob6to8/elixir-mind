---
type: reference
title: 2026-08-03-herdr-vs-claude-code-analysis
description: Compare-and-contrast analysis of herdr against the Claude Code app, expanded with a concrete build for approximating CCR's architecture using herdr plus Fly.io/Shellbox.
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-02–2026-08-03; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped; parsed from the host session log"
tags: [meta, thread, analysis, claude-code, herdr, fly-io, shellbox, comparison]
timestamp: 2026-08-03
session: https://claude.ai/code/session_01WnQUE5PtV3SgAwqwbzQVWW
pr: 244
---

# 2026-08-03-herdr-vs-claude-code-analysis

## Where this landed

The operator asked for a compare-and-contrast analysis of herdr (a terminal
multiplexer for coding agents) against the Claude Code app, filed as
[`meta/analysis/herdr-vs-claude-code-app.md`](/meta/analysis/herdr-vs-claude-code-app.md):
herdr is a self-hosted, vendor-agnostic multiplexer that already lists Claude
Code as one of its native backends rather than a rival, so the two overlap on
capability more than they compete on category. The operator then asked to
expand it with the infra needed to approximate the Claude Code app's cloud
(CCR) architecture using herdr plus Fly.io and Shellbox; the analysis grew a
concrete build — splitting compute into an always-on herdr control-plane node
plus disposable per-session VMs cloned from a shared base image (Shellbox
`duplicate` or a Fly Machine/Sprite clone) — mapping each of CCR's four
load-bearing primitives onto a Shellbox/Fly.io equivalent and naming what has
no off-the-shelf answer (org-managed settings injection, native cross-vendor
agent-teaming, CCR's own credential-custody trust boundary). Both passes were
committed and pushed directly to the session branch.

*(At the operator's request, this render stops here. The session continued —
a `main` sync, a git commit-signature question, and the close via
`/create-pull-request` — but that continuation is recorded by the commit
graph and this thread's PR rather than in this transcript.)*

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Herdr vs. Claude Code app comparison, expanded with a CCR-approximation build (herdr + Fly.io/Shellbox) | closed | [Herdr vs. the Claude Code app](/meta/analysis/herdr-vs-claude-code-app.md) | - |

## User

create an analysis compare and contrasting herdr https://herdr.dev/ with the anthropic claude code app

## Assistant

<routes ref="meta/analysis/herdr-vs-claude-code-app.md">
I filed and pushed the analysis comparing herdr and the Claude Code app.

| What I created | Type | Why this type |
|---|---|---|
| [`meta/analysis/herdr-vs-claude-code-app.md`](https://github.com/ob6to8/elixir-mind/blob/claude/herdr-vs-claude-analysis-u1ihhs/meta/analysis/herdr-vs-claude-code-app.md) | `analysis` | a reasoned comparison against evidence (herdr.dev fetched directly; Claude Code facts grounded in this bundle's existing docs), not a plan or a captured reference |

| What I modified | Thrust of the change |
|---|---|
| `meta/analysis/index.md` | added the new analysis to the contents list |

**Bottom line of the analysis:** herdr is a self-hosted, vendor-agnostic terminal multiplexer (persistent PTY sessions, remote/mobile reattachment, a pane UI, a JSON socket API) that can host *any* CLI coding agent; the Claude Code app is one vendor's agent with its own first-party harness (CLI, Anthropic-hosted cloud runtime, desktop/mobile, IDE extensions, experimental peer "agent teams") that already ships persistence and remote access for its own sessions. They overlap on capability (persistence, remote reach, multi-session visibility) more than they compete on category — herdr lists Claude Code as one of its native integrations, so the likelier real-world shape is Claude Code sessions running *inside* herdr rather than one replacing the other.

Commit `521acb7` passed the full gate suite (format, xref, contract/registry/codemap freshness, `brain.verify`, route-tags, glossary, matters, lineage, tests) and is pushed to `claude/herdr-vs-claude-analysis-u1ihhs`. No PR opened — say the word if you'd like one (or want me to run `/capture` first to freeze this session as a thread doc).
</routes>

## User

expand the analysis to describe exactly what you would need to do to get a workflow with herdr and infra that would approximate the primary architecture of the claude code app, possibly using:
https://fly.io/
https://shellbox.dev/#synopsis

## Assistant

<routes ref="meta/analysis/herdr-vs-claude-code-app.md">
I expanded the analysis with a concrete build for approximating Claude Code's cloud architecture using herdr plus infra, and pushed it.

| What I modified | Thrust of the change |
|---|---|
| `meta/analysis/herdr-vs-claude-code-app.md` | added "Approximating CCR's architecture with herdr + infra" — a two-VM-role design (always-on herdr control-plane node + disposable per-session VMs), a table mapping each of CCR's four load-bearing primitives onto a Shellbox or Fly.io equivalent, a 7-step build order, an honest list of what has no off-the-shelf answer, and a Shellbox-vs-Fly comparison for the session-VM role; expanded frontmatter (description, provenance, tags) and source notes accordingly |
| `meta/analysis/index.md` | updated the entry to reflect the expanded scope |

**The core design:** split compute the way CCR actually does but doesn't expose — one small always-on box running herdr's server (the reattach/status layer), plus one disposable VM per agent session cloned from a shared "golden" image. Shellbox's `duplicate` (instant COW clone) or a Fly Machine/Sprite clone stands in for CCR's environment-snapshot→session mechanic; Shellbox's default stop-after-idle mode or Fly's Sprite standby stands in for "reclaimed after inactivity." Three things stay genuinely unreproduced without bespoke work: Anthropic's org-managed settings-injection layer, native cross-vendor agent-teaming (agent teams is Claude-only; herdr's socket API could fake it), and CCR's credential-custody trust boundary — forwarding your own SSH keys into a third-party vendor's VM is a weaker posture than Anthropic's own sandbox guarantee, even where the mechanics look similar.

One grounding gap worth flagging: Fly's own Sprites page returned only a CLI-install stub on every fetch (looks like a JS app shell this tool can't render), so every Sprites-specific claim (checkpoint/restore latency, free standby, Claude Code preinstalled) is sourced from secondary press coverage, not Fly's own docs — called out inline and in the source notes rather than stated as checked.

Commit `2e91d01` passed the full gate suite and is pushed to `claude/herdr-vs-claude-analysis-u1ihhs`. Still no PR opened — let me know if you'd like one.
</routes>
