---
id: em:2ad710
type: concept
title: scar tissue
description: The accumulation of individually-rational local fixes in a long-running agent that silently promote themselves into standing behavior, until the agent's effective policy reflects its failure history rather than its goal.
provenance: "Nascent coinage from a 2026 r/AgentsOfAI post on a 300-hour autonomous run — adopted within its comment thread, not yet established field vocabulary; agent-distilled definition"
verified: false
tags: [glossary, agentic, drift, reliability, long-horizon]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, operator-directed glossary filing"
  why: "operator asked how the scar-tissue framing should be persisted in the repo; the analysis judged it epistemic field vocabulary, so it files as a glossary concept"
---

# scar tissue

Named by analogy with wound healing: each fix is a rational response to a real
injury, and each leaves the system slightly less flexible than before. The
defining mechanism is *silent promotion* — a workaround adopted under one
failure is retained as if it were an instruction, its trigger context dropped,
so later work builds on it as settled behavior. Individually the adaptations
are defensible; it is their unreviewed *accumulation* that produces an
effective policy no one chose, optimized for surviving past errors rather
than doing the job. The canonical countermeasures are a frozen behavioral
baseline audited on a schedule (drift cannot be measured against a ruler that
drifts too), receipts binding every adaptation to its trigger condition, and
rolling fingerprints of style metrics that surface drift before it breaks
logic — see the [captured source](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md)
and this bundle's [defenses analysis](/meta/analysis/scar-tissue-drift-defenses-and-persistence.md).
The term is a **nascent coinage** — one source post and its approving
commenters — filed here before it has wide currency; the aptness of its
underlying analogy, and the operator's adoption of the lens as a working
frame, are treated as separate statements in the defenses analysis's
persistence section.
Distinct from [context rot](/beliefs/glossary/context-rot.md) (retrieval
degrades over a long context — scar tissue survives retrieval perfectly well)
and from [cognitive debt](/beliefs/glossary/cognitive-debt.md) (the *operator's*
comprehension lags the system — scar tissue is the *agent's* policy lagging
its goal).

*Seen in:* [scar-tissue behavioral drift capture](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md), [scar-tissue defenses analysis](/meta/analysis/scar-tissue-drift-defenses-and-persistence.md)

*See also:* [context rot](/beliefs/glossary/context-rot.md), [cognitive debt](/beliefs/glossary/cognitive-debt.md), [cross-reference drift](/beliefs/glossary/cross-reference-drift.md), [drift class](/beliefs/glossary/drift-class.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:2ad710">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-scar-tissue-drift-doctrine-and-link-policy (2026-07-27)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:2ad710`]**

makes sense re: scar tissue being epistemic, not a belief. and yet something seem off about filing it in the glossary. This is a creative analogy. This is not a colloquial term. That's why to me it seems to veer towards a belief because you could say it's a belief that this failure mode resembles scar tissue. That scar tissue is an appropriate analogy for this failure mode. that arguably requires belief adoption. I believe that this is appropriate. in a way you could say, "I will act as if the analogy to scar tissue is appropriate for this failure mode." agree or disagree?

---

**[`em:2ad710`]**

**The analogy argument: agree and disagree, because three statements hide in one phrase.** (1) *The lexical fact* — "the term is used to mean X" — is what the glossary records, and here your instinct lands a real blow: it's a **nascent coinage** (one post, taken up by its commenters), not colloquial vocabulary, so `sense: common` overstates it — the entry should be re-marked the way `cognitive debt` marks its coinage. (2) *The aptness claim* — "the mapping holds for this failure mode" — is where I **disagree**: aptness is defeasible by cases (the four hour-marks are confirming instances; non-fitting failures would retire it), and anything evidence can retire belongs on the verification ladder, where beliefs by definition don't sit. (3) *The lens adoption* — "I will act as if the trauma lens is the right frame" — here I **agree with you entirely**: the same facts support rival frames (the thread itself offers "software entropy" and "local minima"), and choosing among extensionally-equivalent frames is not settled by evidence — it's a value-laden commitment that guides action. The choice of frame is belief; the fit of the chosen frame is claim. Neat landing: the belief plan's build order wants 2–3 seed beliefs at ratification — your lens-adoption prior is a natural candidate.
