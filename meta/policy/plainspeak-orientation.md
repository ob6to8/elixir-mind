---
type: policy
title: Lead with a plainspeak orientation
description: A dense delivered response opens with a short plain-language orientation — what happened, where things stand, what needs deciding, in common words — before the technical presentation; repo-specific terms are introduced only after the plain statement they label, so the reader is onboarded to the general thrust before meeting terminology.
section: communication
order: 1
status: active
tags: [meta, governance, communication, plainspeak, levels]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, communication-guidance session"
  why: "the operator repeatedly had to request plainspeak restatements of dense responses (2026-07-27 and 2026-07-28 sessions) and asked for a standing balance between the two registers"
---

**Lead with a plainspeak orientation; keep the technical register after it.**
A delivered response of any density — one that reports work, presents a
finding, or leans on artifacts and concepts the operator is not already
holding in mind from the immediate conversation — opens with a short
**plainspeak orientation**: what just happened, where things now stand, and
what (if anything) needs deciding, in common words. The technical
presentation follows at full density, unchanged — the orientation is a
runway to it, never a replacement for it.

- **Onboard before terminology.** The reader must meet the general thrust
  before meeting the terms. Within the orientation, name an artifact by what
  it does before (or alongside) its repo name — "the file that lists every
  merged PR (`meta/dev-history.md`)" — and defer repo coinages to the
  technical half entirely where the plain description carries the point.
- **One presentation, then the other — never interleaved phrase-by-phrase.**
  The orientation is a whole, short account (a paragraph or two), after which
  the technical presentation stands on its own. Phrase-level unpacking is a
  different tool and stays on demand:
  [`/elaborate`](/.claude/skills/elaborate/SKILL.md).
- **The orientation is a derivation, not a second account.** It restates the
  technical content at lower resolution; it must not introduce claims,
  caveats, or decisions the technical half lacks. This is the response-surface
  form of the *one canonical level plus anchored derivations* rule from the
  [three-level documentation plan](/meta/plans/three-level-documentation.md),
  whose committed plain tier serves the same reader on the document surface.
- **Calibrate by density, not length.** Conversational turns, simple answers,
  and responses whose terms are all live in the current exchange need no
  separate orientation — an orientation over three plain sentences is
  ceremony. The trigger is referential density: when following the response
  requires holding artifacts or concepts the conversation has not just
  established, orient first.
- **Placement.** The orientation opens the response, above any
  [work-report tables](/meta/policy/response-work-report-format.md); tables
  and technical prose keep their existing form beneath it.
