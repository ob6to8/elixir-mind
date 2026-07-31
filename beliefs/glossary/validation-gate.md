---
id: em:b9eb99
type: concept
title: validation gate
description: A control on an iterative-improvement loop that accepts a candidate change only when it strictly improves a score measured on a held-out split, and discards it otherwise — bounding the worst case of self-revision rather than trusting every proposed edit.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evals, validation, self-revision, methodology]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 Microsoft SkillOpt intake thread"
---

# validation gate

The mechanism is what separates disciplined self-revision from open-ended
drift: without it, a system that edits its own instructions or parameters has
no way to tell a genuine improvement from a plausible-looking regression, and
errors compound across iterations. With it, the worst case is bounded — a
non-improving edit is simply discarded rather than shipped. Both
[SkillOpt](/knowledge/SWE/agentic/skill-optimization/skillopt.md) and its
[SkillOpt-Sleep](/knowledge/SWE/agentic/agent-memory/skillopt-sleep.md)
companion gate every accepted edit this way, scored against a
[held-out set](/beliefs/glossary/held-out-set.md).

*Seen in:* [2026-07-31 Microsoft SkillOpt intake](/meta/threads/2026-07-31-microsoft-skillopt-intake.md)

*See also:* [held-out set](/beliefs/glossary/held-out-set.md), [text-space optimization](/beliefs/glossary/text-space-optimization.md)
