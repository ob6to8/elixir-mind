---
type: matter
title: "Matters-register plan metadata"
description: Add Type (planned/independent) and Order columns to both tables of the matter register, so each row shows whether a plan's build order emitted its matter and its position in that plan's own sequence.
status: done
provenance: "Claude Fable 5, matters-register metadata session"
tags: [meta, matter, matters, register]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T08:50:00Z
  channel: agent-authored
  agent: "Claude Code agent, matters-register metadata session"
  why: "operator-directed register revision, filed as its own matter and consumed in the same session per the instruction's file-execute-consume shape"
---

# Matters-register plan metadata

Operator instruction (2026-08-02): the register's tables do not show whether
a row's matter is part of a plan, nor — when it is — the matter's position in
that plan's self-contained order. Express both in the tables: a **Type**
column (`planned`, linking the emitting plan, or `independent`) and an
**Order** column (the matter's number in that plan's own build order; `-`
when independent). The columns persist in the Consumed section as well.

The values are a projection of the matter docs' `plan`/`order` frontmatter —
per the [vocabulary](/meta/policy/controlled-type-vocabulary.md), both keys
present exactly when a plan's build order emits the matter — so the docs stay
canonical and row↔doc agreement falls to the queued
[`mix brain.matters` verifier](/meta/matters/mix-brain-matters-verifier.md).
Pre-migration Consumed rows, which have no docs, take their values from their
scope packets in git history and the emitting plans' build orders.

Delivered 2026-08-02: both tables carry the columns (queue: three matter-docs
builds, one bias-taxonomy build, one two-level build, four independent;
Consumed: the two matter-docs builds identified from their packets and the
plan, the rest independent), the register's protocol and Consumed prose name
the docs as the columns' source, and this doc is the delivery record.
