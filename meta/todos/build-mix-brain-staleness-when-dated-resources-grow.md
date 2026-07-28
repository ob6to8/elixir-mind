---
type: todo
title: "Build mix brain.staleness once dated-revision resources pass ~10 docs"
description: Done when a task exists that checks every doc whose `resource` is a dated-revision path against the source's current revision — but not before the exposure justifies it.
status: open
tags: [meta, todo, tooling, staleness, primary-sources]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, CCA certification session"
  why: "deferred rather than built: measured exposure is 2 of 78 resource-bearing docs, which does not clear the admission rule, but the failure mode is real and recurs silently"
  from: [/meta/threads/2026-07-27-cca-study-program-and-the-primary-source-miss.md]
---

# Build `mix brain.staleness` once dated-revision resources pass ~10 docs

A specification served from a **dated revision path** stays live indefinitely and
never signals that it has been superseded. A capture made against it stays
technically valid and quietly goes stale. This was observed on 2026-07-27: two
MCP documents were filed against revision `2025-06-18` while `2025-11-25` was
current.

The check has a clean mechanical oracle — for each doc whose `resource` matches
a dated-revision pattern, compare against the source's current revision — so it
is a genuine tooling candidate rather than an editorial rule.

## Why it is deferred rather than built

**Measured exposure is 2 of 78 resource-bearing documents**, and both already
carry explicit captured-revision notes. The
[coding standards](/meta/policy/elixir-coding-standards.md) admit a new check
only when "its signal beats its upkeep" *and* it "runs offline as a plain `mix`
task with no dependencies". This check fails both today: the signal is two
already-annotated documents, and it necessarily makes network calls, which
breaks the offline-toolchain property
([why the toolchain runs offline](/meta/tutorials/why-the-toolchain-runs-offline.md)).

Building it now would mean a network-dependent task earning its keep on two
files.

## Trigger

Build when **either** holds:

- dated-revision `resource` paths exceed roughly **10 documents**, or
- a stale capture is observed to have **misled** a filed conclusion (as opposed
  to merely lagging).

## Shape when built

An **on-demand task, never a gate** — CI and the pre-commit hook stay offline.
Report per document: captured revision, current revision, and whether they
differ. Until then, the
[`/intake`](/.claude/skills/intake/SKILL.md) gather step carries the manual
check, and captures record the revision they were taken against.
