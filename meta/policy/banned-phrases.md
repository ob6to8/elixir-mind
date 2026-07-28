---
type: policy
title: Banned words and phrases
description: A register of words and phrases banned from agent-composed prose, each entry carrying the phrase, its generalized pattern, and the reason it fails — grown organically via /ban-phrase when the operator flags a phrase, with the invocation itself serving as ratification.
section: communication
order: 6
status: active
tags: [meta, governance, communication, composition, register]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, communication-guidance session"
  why: "the operator asked for a formalized, organically-growing list of banned communication phrases, seeded from a phrase flagged in the 2026-07-27 session"
---

**Certain words and phrases are banned from agent-composed prose.** The
register below lists each banned phrase with the *pattern* it exemplifies and
the reason it fails; the ban covers close variants of the pattern, not only the
literal string. Before delivering a response or filing a document, prose that
matches an entry is recast — usually by deleting the framing and stating the
content directly.

- **The register grows organically.** When the operator flags a phrase in
  conversation, [`/ban-phrase`](/.claude/skills/ban-phrase/SKILL.md) appends it
  here with the reasoning from that exchange and recompiles the contract. The
  operator's invocation *is* the ratification — no separate approval pass.
  Agents may propose entries but never add one unflagged.
- **Entries carry their reasoning.** A bare blacklist teaches nothing and
  invites near-miss variants; the reason is what lets an agent recognize the
  pattern in a phrasing the register has never seen.
- **Scope.** Delivered responses, document bodies, and index glosses — wherever
  the agent composes prose. Thread renders are exempt (verbatim record), and so
  is quoted material: a banned phrase inside a verbatim quote stays as its
  source wrote it.

### The register

- **"worth flagging rather than burying" / "worth noting rather than
  burying"** — pattern: *"worth X-ing rather than Y-ing"*, and more broadly
  any framing that advertises the act of communicating instead of
  communicating. If the content were not worth mentioning it would not be in
  the response, so "worth flagging" asserts nothing; and "rather than burying"
  calls attention to a negative case not taken — a failing nobody raised — which
  is the phrase-level form of
  [negate-only-explicit-cases](/meta/policy/negate-only-explicit-cases.md).
  Recast: state the items directly, under a heading if they need prominence.
