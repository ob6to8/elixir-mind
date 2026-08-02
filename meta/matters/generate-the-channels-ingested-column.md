---
type: matter
title: "Generate the channels register's Ingested column with mix brain.channels"
description: Done when the Ingested column is derived from filed documents' resource URIs and gated with --check, instead of being hand-maintained and silently driftable.
status: open
tags: [meta, matter, tooling, channels, generated-artifacts]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T04:30:00Z
  channel: agent-authored
  agent: "Claude Code agent, channels-register session"
  why: "the Ingested column added to survey/channels.md is derivable from the bundle but hand-kept, which is the drift shape the contract/registry/code-map gates already exist to prevent"
  from: [/meta/threads/2026-07-28-channels-register-merge-and-video-vetting.md]
---

# Generate the channels register's `Ingested` column with `mix brain.channels`

The [channels register](/survey/channels.md) carries an **Ingested** column: the
filed documents drawn from each channel. It is a *join*, not a record — every
document already names its source in `resource` frontmatter, and the column
inverts that edge.

Derived data that is hand-kept goes stale silently, which is precisely the
failure the generated-artifact gates (`mix brain.contract --check`,
`brain.registry --check`, `brain.codemap --check`) exist to prevent. Today the
column's freshness rests on whoever files a document remembering to update a
second file; the register documents a re-derivation `grep` in its Maintenance
section, but a documented check nobody runs is not a gate.

## Why this one plausibly clears the admission rule

The [coding standards](/meta/policy/elixir-coding-standards.md) admit a check
when its signal beats its upkeep *and* it runs offline as a plain `mix` task
with no dependencies. Unlike
[`mix brain.staleness`](/meta/matters/build-mix-brain-staleness-when-dated-resources-grow.md),
which needs network and therefore fails the offline half, this task reads only
the bundle: parse each document's `resource`, group by channel, compare against
the register. Fully offline, deterministic, dependency-free — the same shape as
the existing generators.

## The part that needs deciding

Channel identity is not mechanical. Grouping is currently editorial: the
*Artificial Intelligence* journal rows are keyed by DOI prefix, Anthropic is
split across its engineering blog, the Claude blog, the Claude Code docs, and
CDN-hosted PDFs, and one row is "author preprint pages (university-hosted)" —
a category, not a host. A naive host-based grouping would fragment these and
fight the register rather than maintain it.

So the task is not just codegen: it needs a stated mapping from `resource` URI
to channel row — most likely an explicit per-row URL-pattern field the task
matches against, so the editorial judgment stays in the register and the tool
only enforces it. Get that shape wrong and the generator becomes something
future sessions work around.

## Scope note

Only the **Ingested** column is derivable. Focus, Access, and From are
operator/agent judgments about a source and stay hand-written — so this
generates one column of a hand-maintained table, not the whole file. That is a
different shape from the fully-generated artifacts and is worth confirming
before building.
