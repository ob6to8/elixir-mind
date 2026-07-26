---
id: em:6c7e85
type: belief
title: Plan artifacts surface decisions otherwise made implicitly at code review
description: Each program-design artifact — a call-stack tree, a file-tree diff, a set of type signatures — is a decision that would otherwise be made implicitly during code review, at the most expensive time to change one's mind.
provenance: "Dex Horthy, 'Why Software Factories Fail' (wsff.md), HumanLayer — https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md; filed at operator direction from the 2026-07-26 pseudocode-plans session"
tags: [belief, planning, review, program-design, coding-agents]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: intake
  agent: "Claude Code agent, pseudocode-plans session — operator-directed belief filing"
  why: "operator directed filing this with the quote's referent ('every one') resolved, so the belief stands alone outside its source essay"
---

# Plan artifacts surface decisions otherwise made implicitly at code review

The belief, quoted verbatim from its source:

> "none of these take long to produce (the model drafts them, you argue with
> it), and every one of them is a decision you'd otherwise be making implicitly
> during code review -- at the most expensive possible time to change your mind."

— Dex Horthy,
["Why Software Factories Fail"](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md),
program-design section.

**The referent of "every one of them"**, resolved so this belief stands alone:
the three program-design artifacts the essay prescribes drafting before
implementation —

1. **call-stack trees** (orchestration/control-flow changes, in diff syntax),
2. **file-tree diffs** (where new and modified files live in the codebase), and
3. **types and method signatures** for the key new functions.

Held as a prior because it locates the *value* of structured plan bodies: the
artifacts are not documentation overhead but decisions relocated from the most
expensive point (code review, after implementation) to the cheapest (plan
review, before it). It is the motivating belief behind the
[structured-plan-bodies policy](/meta/policy/structured-plan-bodies.md).

# Citations

- https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md —
  the source essay; the quote and the three artifacts are in its "Program
  design" section.
