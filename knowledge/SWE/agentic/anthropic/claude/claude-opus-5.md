---
id: em:636e39
type: reference
title: "Claude Opus 5"
description: Anthropic's July 24, 2026 successor to Opus 4.8, priced identically at $5/$25 per MTok, with gains in agentic coding, computer use, and long-horizon knowledge work; the system card rates it not more capable overall than Fable 5 and assesses very low overall alignment risk.
resource: https://www.anthropic.com/news/claude-opus-5
provenance: "Anthropic, \"Introducing Claude Opus 5\", and the Claude Opus 5 System Card, fetched 2026-07-29"
tags: [anthropic, claude, model-release, opus, pricing, benchmarks]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: auto-intake
  agent: "Claude Code agent, /research daily Routine"
  why: "featured in the 2026-07-29 digest under SWE; reason-tag: recent, impactful"
---

# Claude Opus 5

Released 2026-07-24, succeeding Opus 4.8 at identical pricing — **$5/$25 per
MTok**, with a Fast mode running 2.5× faster at double the base cost. Knowledge
cutoff is May 2026. It becomes the default model for Claude Max subscribers and
is available on Claude.ai, Claude Code, Claude Cowork, and the Claude Platform
API as `claude-opus-5`.

## What improved over Opus 4.8

Stronger agentic reasoning and self-verification, better organic-chemistry and
protein-analysis performance, improved visual output generation, better token
efficiency across effort levels, and improved judgment on iterative problems.
On benchmarks: it surpasses all competitors and roughly doubles Opus 4.8's
score on Frontier-Bench v0.1 at lower cost, lands within 0.5% of Fable 5 on
CursorBench 3.2 at half the cost, scores 3× the next-best model on ARC-AGI 3,
and beats Fable 5 on OSWorld 2.0 at a third of the cost. Cursor's co-founder:
"Claude Opus 5 delivers near Fable 5 intelligence at Opus speed and cost."

Two named exceptions: Mythos 5 stays ahead of Opus 5 on cybersecurity
exploitation and autonomous biology-research tasks.

## Safety assessment

The system card rates Opus 5 as **not more capable overall than Fable 5**,
with no new concerning alignment properties and an overall assessment of
**very low alignment risk**.

# Citations

- <https://www.anthropic.com/news/claude-opus-5> — "Introducing Claude Opus 5"
- <https://www-cdn.anthropic.com/c5fbac3f0b1280a933ebd26d3cb8bb9f5bdeaf48/Claude%20Opus%205%20System%20Card.pdf> — Claude Opus 5 System Card

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:636e39">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-29-research-digest-mcp-spec-security-and-reliability (2026-07-29)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:636e39`]**  (co-feeds: `em:be781f em:57c28a em:51e5f3 em:5f9c0d`)

Pushed to `claude/research-17ueta`. Commit `d7d62f6` — 13 files, all gates green (format, xref, contract, verify, route-tags, glossary, 188 tests). No PR opened, since that wasn't requested — the branch is up for you to review or ask me to open one.
