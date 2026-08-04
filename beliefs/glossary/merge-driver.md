---
id: em:ab3267
type: concept
title: merge driver
description: A git mechanism that replaces the default three-way text merge for files matched by a .gitattributes pattern — either a built-in (like union, which keeps both sides' lines) or a custom command configured per clone that produces the merged result and signals whether resolution succeeded.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, git, merge, gitattributes]
sense: common
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T04:05:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 retrieval-spike thread's generated-artifact conflict fix"
---

# merge driver

The `.gitattributes` side (`path merge=<name>`) is committed and travels with
the repository; a *custom* driver's command (`merge.<name>.driver`) lives in
per-clone git config and must be provisioned — in this brain, by the
SessionStart hook. In this brain the `regen` driver resolves generated
artifacts as `ours` for re-derivation by `mix brain.regen`, and the built-in
`union` driver merges append-only `index.md` listings (see
[generated-artifact-merge-conflicts](/meta/issues/generated-artifact-merge-conflicts.md)).
Distinct from a merge *strategy* (`ort`, `octopus`), which governs the whole
merge rather than one file's content resolution.

*Seen in:* [2026-08-02 retrieval-spike thread](/meta/threads/2026-08-02-retrieval-spike-doma-intake-and-static-embeddings.md) · [generated-artifact-merge-conflicts](/meta/issues/generated-artifact-merge-conflicts.md)
