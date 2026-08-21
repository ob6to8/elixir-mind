---
id: em:afa1ce
type: reference
title: "Git at any scale — Cursor's Origin Git-hosting architecture"
description: Cursor's Origin system hosts Git at scale on S3's atomic compare-and-swap operations, using write-ahead logging plus compaction to separate object storage from reference management across replicas, without a separate consensus layer.
resource: https://cursor.com/blog/git-at-any-scale
provenance: "Cursor engineering blog (Vicent Martí), fetched 2026-08-21; discussed on Hacker News (item 49348141)"
tags: [git, version-control, infrastructure, cursor, s3, distributed-systems]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Git at any scale

Cursor's writeup of Origin, its Git-hosting system, by Vicent Martí (prior
GitHub-internals and Vitess/PlanetScale experience — a credential Hacker
News commenters weighed heavily in assessing the design).

## The core architectural bet

Rather than building a distributed-consensus layer, Origin leans on S3's own
atomic compare-and-swap operation as the source of truth, treating S3's
durability guarantees as the foundation instead of something to route
around. On top of that: a write-ahead log (WAL) plus periodic compaction,
and a split between Git's object storage and its reference (branch/tag)
management, replicated separately.

## Reception

Hacker News discussion was largely favorable on the engineering, with
skepticism on two other axes: whether the design actually resolves scaling
difficulty or defers it elsewhere, and — unrelated to the technical
merits — pointed criticism of Cursor's association with Elon Musk, with
several commenters stating they would not adopt the platform regardless of
the architecture's quality. Some frustration that Origin itself sits behind
a paid subscription rather than shipping as something independently usable.

# Citations

- <https://cursor.com/blog/git-at-any-scale>
- <https://news.ycombinator.com/item?id=49348141> — Hacker News discussion
