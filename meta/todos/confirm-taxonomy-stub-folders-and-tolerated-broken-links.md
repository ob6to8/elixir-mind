---
type: todo
title: "Confirm the empty taxonomy stub folders and the tolerated broken links in frozen namespaces"
description: The agentic-coding to agentic restructure left claude-managed-agents/ holding only an index.md, and left broken links in frozen inbox/ and threads/ content that were tolerated rather than decided — two small confirmations that were requested and never given.
status: open
provenance: "Claude Code session (2026-07-13) — raised at the end of the anthropic-node restructure; stub folder re-verified 2026-07-28"
tags: [meta, todo, taxonomy, links, housekeeping]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from an untracked routing-ledger strand; two operator confirmations that were asked for at restructure time and never closed out"
  from: [/meta/threads/2026-07-13-artifacts-concept-and-anthropic-node-restructure.md, /meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md]
---

# Confirm the taxonomy stubs and tolerated broken links

The `agentic-coding` → `agentic` restructure landed and added an `anthropic/`
node. Two things were flagged for confirmation and never confirmed.

**1. The empty stub folder.** `knowledge/SWE/agentic/anthropic/claude-managed-agents/`
holds only its `index.md` (verified 2026-07-28) — a directory announcing a topic
with nothing filed under it. Its sibling `claude-code-sdk/` has real content, so
this is not a consistent pattern but a leftover.

[directory-hierarchy](/meta/policy/directory-hierarchy.md) says to create the
natural path even for a single document — which argues for keeping a stub *when a
document is imminent*, not indefinitely. Either file something under it or remove
it; an index listing nothing is a promise the tree does not keep.

**2. The tolerated broken links.** The restructure left links to old paths inside
frozen `inbox/` digests and `meta/threads/` docs. [OKF conformance](/meta/policy/okf-conformance.md)
says a tolerant consumer never rejects a bundle for broken links, and those
namespaces are records that should not be rewritten — so tolerating them is
defensible. It was never *decided*, though, and `mix brain.verify` and the
docs-freshness warnings keep surfacing them.

**Done when.** The stub is filled or removed, and the broken-link posture is
recorded as a deliberate carve-out (frozen namespaces are exempt) rather than
recurring as an unexplained warning.
