---
id: em:fa9469
type: concept
title: FIFO queue
description: A first-in-first-out queue — items are consumed in exactly the order they were added, so the oldest waiting item is always the next one served.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, computer-science, work-queue]
sense: dual
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T05:20:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 deferred-work thread — the operator's characterization of the matters register"
---

# FIFO queue

Enqueue appends at the tail, dequeue takes the head — fairness by arrival
order. Contrast a stack (LIFO — the newest item is served first) and a
priority queue (served by rank, regardless of arrival).

**In this brain:** the [matters register](/meta/matters.md) is consumed as
one — the top row is always the next [matter](/beliefs/glossary/matter.md)
delivered, and a delivered row is dropped, the landing recorded on its done
doc (`pr: <N>`). FIFO by
default rather than by invariant: the operator reorders rows deliberately
(bumping an urgent matter to the top), which a strict FIFO would not allow.

*Seen in:* [2026-08-02 deferred-work policy and consumed-matters log](/meta/threads/2026-08-02-deferred-work-policy-and-consumed-matters-log.md)
