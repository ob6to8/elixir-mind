---
id: em:7f58e2
type: concept
title: fixture bundle
description: The small demo OKF collection that ships inside the spun-out library repo, exercising every schema feature under the shared em: id namespace, serving simultaneously as the library's test fixture, its demonstration content, and the proof that no bundle-specific path or vocabulary remains hardcoded.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, testing, architecture, spin-out]
sense: repo
timestamp: 2026-07-28
attribution:
  when: 2026-07-17T18:10:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-17 library spin-out spec thread"
---

# fixture bundle

Today the library's tests can only run against the operator's live personal
data — one of the
[separation plan](/meta/plans/separate-okf-bundle-and-elixir-mind-library.md)'s
core arguments for the split. The
[spin-out plan](/meta/plans/library-spin-out-and-dependency-distribution.md)
gives the replacement a double duty: a green test run against it *is* the
acceptance test for the Phase 3 configurability audit's path, directory-list,
and vocabulary lifts. The fixture mints `em:` ids like every other bundle
(operator-set, 2026-07-28), so the prefix half of the audit is proven
separately: a dedicated test overrides `id_prefix` over a small synthetic
corpus, keeping hardcoded `em:` assumptions unable to survive the suite.

*Seen in:* [2026-07-17 library spin-out spec thread](/meta/threads/2026-07-17-library-spin-out-spec.md)
