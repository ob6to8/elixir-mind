---
id: em:b7b5d8
type: concept
title: add/add conflict
description: A merge conflict in which both branches independently created a file at the same path, leaving no common-ancestor version of it to merge against, so git stages both versions whole and refuses to combine them.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, git, version-control, merge]
sense: common
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T04:15:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-28 channels-register-merge-and-video-vetting thread"
---

# add/add conflict

Three-way merging works by comparing each side against the version they share.
When a path exists on both sides but in neither's history before the split, that
shared version is missing, so the comparison has nothing to anchor on and the
entire file conflicts rather than a few hunks within it.

What makes this kind distinctive is what it means rather than how it presents:
line-level conflicts signal that two people edited the same code, while this one
signals that two people **built the same thing twice**. Resolving it is therefore
a design decision — which artifact survives, and what the loser contributes —
not a merge in the mechanical sense. Taking one side wholesale
(`git checkout --ours` / `--theirs`) resolves the conflict while silently
discarding the other side's work, which is why the honest resolution is usually
to author a replacement that reconciles both.

It is a conflict on a
[true merge](/beliefs/glossary/true-merge.md), and the case a
[fast-forward merge](/beliefs/glossary/fast-forward-merge.md) by definition never
produces: a fast-forward means one side's history already contains the other's,
so no independent creation of the same path can have occurred.

*Seen in:* [2026-07-28 channels register merge and video vetting](/meta/threads/2026-07-28-channels-register-merge-and-video-vetting.md)
