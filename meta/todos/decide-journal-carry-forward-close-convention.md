---
type: todo
title: "Decide whether journal entries adopt a carry-forward closing line"
description: Journal entries accumulate rather than compound — each is self-contained, so a thread running across days has no explicit link forward, and a closing carry-forward line was proposed on day two and never decided.
status: open
provenance: "Claude Code session (2026-07-26) — recurring editorial note raised on the second journal entry"
tags: [meta, todo, journal, convention, editorial]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from an untracked routing-ledger strand; a convention question that recurs on every entry while undecided"
  from: [/meta/threads/2026-07-26-journal-day-two-intermediary-layer.md, /meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md]
---

# Decide the journal carry-forward close convention

[`journal/`](/journal/index.md) entries are dated, self-contained, and anchored by
date rather than inbound links. That makes each entry easy to write and easy to
find, and it means a line of thinking developed across three days reads as three
unrelated entries.

**The proposal (day two).** Close each entry with a short carry-forward line —
what is unresolved and expected to continue — so entries *compound* rather than
merely accumulate.

**The tension.** The operator's voice in a journal entry is inviolable per the
[`/journal`](/.claude/skills/journal/SKILL.md) skill: the agent transcribes and
cleans dictation noise, nothing more. A mandated closing line is a structural
demand on the operator's own writing, which is a different thing from a filing
convention the agent follows.

So the decision is really two:

1. Does a carry-forward line get adopted at all?
2. If so, is it written by the operator as part of the entry, or added by the
   agent below the entry the way a `## Response` is — operator voice above, agent
   voice below, never interleaved?

**Recommendation.** Option 2's separation already exists and is proven; extending
it costs nothing and keeps the operator's text untouched.

**Done when.** The convention is adopted and recorded in the `/journal` skill, or
declined and recorded here so it stops recurring per entry.
