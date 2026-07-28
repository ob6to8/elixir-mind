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

*Seen in:* [2026-07-17 library spin-out spec thread](/meta/threads/2026-07-17-library-spin-out-spec.md), [2026-07-28 swappable-bundle spec and library naming thread](/meta/threads/2026-07-28-swappable-bundle-spec-and-library-naming.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:7f58e2">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-swappable-bundle-spec-and-library-naming (2026-07-28)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:7f58e2`]**

Two clean decisions to fold in: the prefix is `em:` across the board (it travels with the library's schema — no `dm:`/`cb:` fixture namespace), and the knowledge repo's new name is **knowledge**, which fully resolves open question 1. The one design consequence to handle honestly: a fixture that also mints `em:` no longer proves the prefix is configurable, so the prefix half of the Phase 3 oracle moves into a dedicated test. Making the edits:

---

**[`em:7f58e2`]**

**One design consequence I had to handle rather than just find-and-replace:** the fixture's *not*-being-`em:` was previously the proof that the prefix was genuinely lifted into config ("hardcoded `em:` assumptions cannot survive a non-`em:` corpus"). With the fixture on `em:`, that proof would silently vanish — so the spec now splits the Phase 3 oracle: the demo bundle remains the acceptance test for paths, directory lists, and vocabularies, while prefix configurability is proven by a dedicated test that overrides `id_prefix` over a small synthetic corpus. Nothing about the swappable-bundle property weakens; only where it's tested moves.
