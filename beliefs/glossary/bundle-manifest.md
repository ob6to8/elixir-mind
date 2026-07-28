---
id: em:ad34c1
type: concept
title: bundle manifest
description: The knowledge-base repo's config/config.exs in its post-spin-out role — the one place a bundle declares everything about itself that the shared library must not hardcode, including id prefix, site and repo URLs, excluded directories, and the controlled type and channel vocabularies.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, architecture, configuration, spin-out]
sense: repo
timestamp: 2026-07-17
attribution:
  when: 2026-07-17T18:10:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term coined by the 2026-07-17 library spin-out spec thread"
---

# bundle manifest

Coined in the
[spin-out plan](/meta/plans/library-spin-out-and-dependency-distribution.md)
as the target of the parent plan's Phase 3 configurability audit: every
bundle-specific constant lifted out of library code lands here, making the
library generic over N bundles. The design keeps governance where it belongs
— the library enforces that a document's `type` is *in the declared list*,
while *what the list contains* remains a per-bundle, operator-ratified act.
The existing `site_base_url`/`repo_url` entries are the pattern the rest of
the surface (notably the `em:`
[id prefix](/beliefs/glossary/stable-id.md)) follows.

*Seen in:* [2026-07-17 library spin-out spec thread](/meta/threads/2026-07-17-library-spin-out-spec.md), [2026-07-28 swappable-bundle spec and library naming thread](/meta/threads/2026-07-28-swappable-bundle-spec-and-library-naming.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:ad34c1">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-swappable-bundle-spec-and-library-naming (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:ad34c1`]**

**The core of the new spec:** the library's entire knowledge of any particular collection reduces to two inputs — a **bundle root** (path to an OKF checkout) and a **manifest** (the consuming repo's `config/config.exs`). Any client supplying both gets the full toolchain: your agent sessions here, other operators' knowledge repos, CI, and the planned thin Jido host are all the same call path with different manifests. Concretely:

- **A coupling audit of `lib/` at HEAD** — every place the code binds to *this* bundle, with file:line sites: the `em:` prefix in five modules, three overlapping excluded-dir lists, the channel/statement-type/sense vocabularies, a dozen hardcoded governance addresses (`meta/policy`, `CLAUDE.md`, `meta/registry.md`, …), and the this-repo-only backfill module. One finding: the controlled `type` vocabulary is enforced nowhere in code today, so "library checks membership in the bundle-declared list" is a new capability the manifest enables, not a lift.
- **A `Bundle` struct spec** — `Bundle.load/1` becomes the single config read point, threaded as an explicit argument to every module; the fixture bundle (`cb:`-namespaced) tests the unmodified production code path just by supplying a different manifest.
- **Two-repo file-tree diffs** and production/test call trees, plus boundary decisions (profile = shape the library owns; manifest = values a second bundle could legitimately set differently).
- **Three new open questions** appended, not answered — notably that the proposed `brain.* → mind.*` task rename must be sequenced against the extraction, since post-split the task names ship to every consuming bundle.
