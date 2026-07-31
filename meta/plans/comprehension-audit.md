---
type: plan
title: "The comprehension audit: a full-repo sweep that converts the move-fast backlog into operator understanding and filed artifacts"
description: Execute the methodology shift declared in the 2026-07-28 journal entry — sweep the whole repo in four stages (governance, operational surfaces, tooling at signature altitude, knowledge bundle), operator-reads-first per artifact, routing every finding into issues/tutorials/glossary/todos so the audit is self-recording and its issue ledger becomes the slop census.
status: proposed
provenance: "Claude Code session, 2026-07-28/31 — drafted from the operator's 2026-07-28 journal entry and the response's recommendations, at operator direction"
tags: [meta, plan, comprehension, auditing, slop, code-map, methodology]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T03:45:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-methodology session"
  why: "the operator directed drafting the comprehension audit as an executable plan — sweep order, granularity, artifact routing, and done-criterion — for ratification"
  from: [/meta/threads/2026-07-28-operator-methodology-shift-and-comprehension-audit.md]
---

# The comprehension audit

Execute the transition to comprehension-and-auditing declared in the
[2026-07-28 journal entry](/journal/2026-07-28.md): "going over the whole repo
with a fine toothed comb, stopping at every single thing I don't understand,
and baking that understanding into the knowledge base itself." This plan
supplies what the declaration deliberately left open — the sweep order, the
granularity, the artifact routing, and the done-criterion — under the direction
of [comprehension-precedes-acceptance](/meta/doctrine/comprehension-precedes-acceptance.md).

## Problem

The move-fast era accepted agent work vetted at intent level only: diffs
unread absent a specific concern, implementation detail waved through,
unwieldy matters punted into plans. Its presumed residue is **slop** —
"unvetted architecture that optimizes for the local considerations of the
agent at the time of authoring vs the high level intent and direction of the
repo" ([journal, 2026-07-28](/journal/2026-07-28.md)) — at an unknown rate:
the only current evidence (models producing corrections when asked to verify)
is an unreliable proxy in both directions. The audit replaces the guess with a
count, and the under-comprehension with filed understanding.

## Sweep order — four stages

```
comprehension audit
├── stage 1 — governance: the contract and its sources
│   ├── CLAUDE.md read against each meta/policy/*.md it compiles from
│   ├── meta/doctrine/*.md
│   └── highest leverage: policies bind every agent in every session,
│       so misalignment here compounds fastest
├── stage 2 — operational surfaces: skills and flows
│   ├── .claude/skills/*/SKILL.md (each against its policy counterpart)
│   └── meta/flows/*.md (each against the machinery it describes)
├── stage 3 — Elixir tooling, at signature altitude
│   ├── walk order: meta/code-map.md, module by module
│   ├── per module: moduledoc → public functions and @specs → call stacks
│   │   (who calls it, what it calls; mix xref as the instrument)
│   └── implementations skipped by default — descend only where the
│       oracle is distrusted (intent-is-the-source: opacity is earned)
└── stage 4 — the knowledge bundle
    ├── tree walk from /index.md, directory by directory
    └── per document: does the operator understand what it claims, why it
        is filed where it is, and whether its type/frontmatter fit?
```

Granularity for stage 3 is the operator's declared bound: "understand it on
the level of functions, types, and call stacks, but to skip function
implementation for now" ([journal, 2026-07-28](/journal/2026-07-28.md)). Each
signature-level comprehension failure that forces a descent into an
implementation is itself a finding (the oracle under-covers there) and is
filed, not just endured.

## Per-artifact protocol — operator reads first

The audit is agent-assisted but **operator-led**, in this order per artifact:

1. **Operator reads the artifact and states their understanding** — and every
   point where understanding stops — in the session, before any agent
   summary. (Retrieval-practice ordering: an agent summarizing first would
   reintroduce the borrowed-synthesis dependence the journal's day-one entry
   warned against.)
2. **Agent checks the stated understanding** against the artifact and the
   repo, corrects it, and answers the stopped-at points.
3. **Residue is routed immediately** (table below) in the same session, so
   the audit is self-recording — no private notes, no end-of-audit write-up.

## Artifact routing — where findings go

| The finding is… | Files as | Per |
|---|---|---|
| something wrong (defect, misalignment with repo intent) | `issue` | [governance-artifact-routing](/meta/policy/governance-artifact-routing.md) |
| something now understood that wasn't legible | `tutorial`, glossary term, or a moduledoc/code-map upgrade | same |
| a fix whose approach needs deciding | `plan` | same |
| a plain task | `todo` | same |
| a defective policy/doctrine text | edit + `/render-contract`, operator-ratified | contract rules |

At completion, the set of issues filed by the audit **is** the slop census —
scoped, enumerable, and a measured replacement for the entry's guess.

## Progress & done-criterion

- **Tracking.** A stage checklist below is updated as audit sessions complete
  slices; `status` moves to `in-progress` when stage 1 starts.
- **Per artifact, "understood" means:** the operator can state its role and
  interface at the target altitude unaided. A stage is done when its artifact
  list is exhausted with every item dispositioned (understood / finding filed).
- **The audit is done** when all four stages are done. The doctrine it serves
  does not expire with it.

Checklist: ☐ stage 1 · ☐ stage 2 · ☐ stage 3 · ☐ stage 4

## Decision list

- **Recommended shape:** governance-first ordering, operator-reads-first
  protocol, route-as-you-go filing, signature-altitude code bound.
- **Alternatives rejected:**
  - *Taxonomy-first* (largest surface, most operator-authored intent) — but
    policies bind every future session; a defective policy compounds while the
    taxonomy is being read.
  - *Code-first* — the tooling already sits behind the strongest mechanical
    oracle in the repo (gates, 188 tests); its silent-failure risk is lowest,
    so it can wait for stage 3.
  - *Agent-summaries-first per artifact* — cheaper per item, but reproduces
    the dependence the audit exists to break.
  - *Single big-bang audit session* — the sweep is operator-paced by design;
    bounded slices across sessions, with this plan as the cross-session spine.
- **Open questions:**
  1. Re-audit cadence once the sweep completes — standing periodic audit, or
     rely on the doctrine's ex-ante gate to keep debt from re-accruing?
  2. Should audit findings that are *questions about intent* (not defects) get
     a home lighter than `issue`? Default: route them to the journal or the
     session thread until a pattern emerges.
