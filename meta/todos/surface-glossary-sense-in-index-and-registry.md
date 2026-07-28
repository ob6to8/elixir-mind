---
type: todo
title: "Surface the glossary `sense` field in the index and registry views"
description: Glossary terms carry a sense (common vs. repo-specific) that is invisible in both /beliefs/glossary/index.md and meta/registry.md, so a reader browsing either view cannot tell a standard term of art from a bundle coinage without opening each file.
status: open
provenance: "Claude Code session (2026-07-13) — deferred in the glossary sense-disambiguation plan, which shipped the field without the display surfaces"
tags: [meta, todo, glossary, registry, index, disambiguation]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from an untracked routing-ledger strand; the direction is already committed by a shipped plan, only the display surfaces are unbuilt"
  from: [/meta/threads/2026-07-13-glossary-sense-disambiguation.md]
---

# Surface `sense` in the index and registry views

The [glossary sense-disambiguation plan](/meta/plans/glossary-sense-disambiguation.md)
(`status: done`) added a `sense` field distinguishing a term's **common** meaning
from its **repo**-specific one. The field landed; the surfaces that would make it
visible did not, and were deferred inside the now-closed plan — which is why this
sat untracked.

**Why it matters.** [prefer-established-terminology](/meta/policy/prefer-established-terminology.md)
requires a bespoke term to be glossaried with `sense: repo`. That rule is only
enforceable if a reviewer can *see* which terms are coinages. Today they cannot,
short of opening every file.

**Task.**

- Badge each line in [`/beliefs/glossary/index.md`](/beliefs/glossary/index.md)
  with its `sense`, in the generated listing rather than by hand.
- Add a `sense` column to [`meta/registry.md`](/meta/registry.md) via
  `mix brain.registry`, left blank for non-glossary documents.

**Done when.** Both views show `sense` without a hand-maintained copy, and
`mix brain.registry --check` still passes as a freshness gate.
