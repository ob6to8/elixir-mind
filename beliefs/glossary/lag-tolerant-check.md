---
id: em:731c59
type: concept
title: lag-tolerant check
description: A staleness gate for a generated artifact that accepts the on-disk copy being behind its source (missing the newest entries) but fails on any divergence in the content it does contain — used where regeneration structurally trails the data.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, tooling, generated-artifact, ci]
sense: repo
timestamp: 2026-07-23
attribution:
  when: 2026-07-13T17:18:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term coined in the 2026-07-13 derived-dev-history thread"
---

# lag-tolerant check

A variant of the `--check` staleness gate used for generated artifacts whose
source keeps moving after the artifact is committed: the check accepts the
on-disk copy *lagging* (a fresh derivation may carry newer sections the file
lacks) but fails on any divergence in the preamble or sections the file does
contain — so hand edits and drift are caught while structural lag passes.
Coined for `mix brain.dev_history --check`: a checked-in derivation of merge
history can never contain the merge commit of the PR that ships it, so strict
equality (the discipline of `mix brain.registry --check`) would fail on `main`
after every merge. The tolerance is on the **shape**, not the size, of the lag —
the disk copy must be a *suffix* of a fresh render, so any number of missing
newest sections passes while a reordered or hand-edited section fails.

That unbounded tolerance is why the pattern ultimately lost its only instance
here: if staleness never fails, the complementary mechanism — re-deriving where
the source is complete, at deploy time in `pages.yml` — is doing all the work,
and the checked-in copy is redundant. The dev-history view is now generated at
deploy and gitignored rather than committed and lag-checked.

*Seen in:* [2026-07-13 derived-dev-history thread](/meta/threads/2026-07-13-derived-dev-history-from-merge-graph.md), [derived-dev-history plan](/meta/plans/derived-dev-history.md), [2026-07-23 ai-drift intake thread](/meta/threads/2026-07-23-ai-drift-intake-and-coding-standards-ratification.md), [2026-07-23 dev-history-drift thread](/meta/threads/2026-07-23-dev-history-drift-and-regeneration-flow.md)
