---
id: em:20b7a1
type: concept
title: trunk-based development
description: A branching model in which the trunk is the only long-lived branch — every other branch is short-lived and merges back quickly — so integration happens continuously and the trunk stays always-releasable.
provenance: "Agent-distilled glossary definition, from the Atlassian trunk-based-development article read during the version-control audit"
verified: false
tags: [glossary, git, version-control, ci, workflow]
sense: common
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the benchmark model the version-control audit measured this repo's workflow against"
---

# trunk-based development

The defining constraint is **one long-lived branch**: work happens on short-lived
branches (or directly on trunk) that merge back within roughly a day, so no branch
accumulates divergence. Its opposite is the environment-per-branch family
(GitFlow-style `dev`/`master` splits), where two persistent branches drift apart
between promotions and the promotion becomes a big-bang merge. It presupposes a
comprehensive automated gate on every change — without one, continuous integration
into the trunk just breaks it faster. This repo practices it: `main` is the trunk,
`claude/<slug>` session branches are short-lived, and every change passes the
[gate suite](/beliefs/glossary/gate-suite.md). See
[the git workflow](/meta/tutorials/the-git-workflow.md).

*Seen in:* [2026-07-26 version-control-audit thread](/meta/threads/2026-07-26-version-control-audit-and-response-format-policies.md)
