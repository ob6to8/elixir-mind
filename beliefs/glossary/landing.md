---
id: em:6e36a9
type: concept
title: landing
description: The merged destination of a change — a change lands when its pull request merges into the mainline, and its landing is the PR or merge commit where that happened.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, git, pull-requests, matters]
sense: dual
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T11:20:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 mix-brain-matters-and-consumed-retirement thread — the landing-metadata check named after it"
---

# landing

Industry usage, not merely merging: a change *lands* once it is in the
mainline others build on, so "where did this land?" asks for the PR or merge
commit that carried it in.

**In this brain:** a delivered [matter](/beliefs/glossary/matter.md)'s
landing is recorded structurally — the `pr: <N>` key stamped into its done
doc when [`/create-pull-request`](/meta/policy/skills-registry.md) opens the
PR — so the done docs under [`meta/matters/`](/meta/matters/index.md) are the
delivery history. `mix brain.matters`' **landing metadata** check warns on a
done doc still awaiting its stamp (warn, never fail: the stamp legitimately
postdates the done-flip until the PR exists).

*Seen in:* [2026-08-02 mix-brain-matters-and-consumed-retirement thread](/meta/threads/2026-08-02-mix-brain-matters-and-consumed-retirement.md), [the matter register](/meta/matters.md)
