---
type: todo
title: "Generate the channels register's Ingested column instead of hand-maintaining it"
description: survey/channels.md is hand-maintained, and its Ingested column is fully re-derivable from what is already filed, so it drifts silently the way every hand-kept mirror in this repo has — while contract, registry, and code-map all have generators.
status: open
provenance: "Claude Code session (2026-07-28) — raised while merging the channels register and vetting videos"
tags: [meta, todo, survey, channels, generated-artifact, tooling]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from an untracked routing-ledger strand; a re-derivable column kept by hand is the drift pattern this repo has already solved three times"
  from: [/meta/threads/2026-07-28-channels-register-merge-and-video-vetting.md]
---

# Generate the channels register's `Ingested` column

[`survey/channels.md`](/survey/channels.md) is maintained by hand. Its `Ingested`
column records whether a channel's material has been filed — a fact already true
or false in the tree, restated in a second place.

**Why it matters.** Every other re-derivable view in this repo has a generator and
a freshness gate: `CLAUDE.md` (`mix brain.contract`), `meta/registry.md`
(`mix brain.registry`), `meta/code-map.md` (`mix brain.codemap`). The one that does
not is the one that will be wrong, and unlike those three nothing will catch it.

**Task.** Add `mix brain.channels` owning the derived column, following the
established shape: generate by default, `--check` for CI, never hand-edit the
generated region. Leave the operator-authored columns (the channel, its topic, the
vetting note) hand-kept — only the derivable column moves.

**Done when.** `Ingested` is generated, `mix brain.channels --check` runs beside
the other freshness gates, and the register's hand-kept columns are untouched.

Weigh against the [admission rule](/meta/policy/elixir-coding-standards.md): the
check must run offline as a plain `mix` task with no dependencies, and its signal
must beat its upkeep. If the register stays small enough that drift is obvious on
sight, record that judgment and cancel this rather than building it.
