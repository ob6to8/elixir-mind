---
id: em:96c282
type: concept
title: ablation
description: Removing a component and re-measuring to determine what it contributed — informative about the component's effect only when the metric actually attributes outcomes to it, so a no-change result is evidence about the instrument as much as about the component.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [evaluation, experiment-design, evals, attribution]
timestamp: 2026-08-05
attribution:
  when: 2026-08-05T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term carried the eval-blindness argument in the 2026-08-05 context-engineering intake thread"
---

# ablation

Standard experimental practice: delete one part of a system, re-run the
measurement, and attribute the difference to what was removed. The inference is
sound only when the metric is sensitive to that part in the first place.

The failure mode is a **null result read as a verdict on the component**. When
an ablation moves nothing, two hypotheses remain live and the measurement
cannot separate them: the component contributed nothing, or the instrument
never measured what it contributed. Distinguishing them takes a second
condition where the component *is* expected to matter — a different model
generation, a different task distribution, a stressed regime — and without that
counterfactual the null is a statement about the eval.

This bites hardest on prompt and instruction content, where aggregate
benchmarks attribute no outcome to any individual rule. Deleting instructions
and observing no regression is therefore uninformative about whether those
instructions ever worked, which is the reasoning behind
[instruction conflict has no mechanical oracle](/knowledge/SWE/agentic/governance/instruction-conflict-has-no-mechanical-oracle.md)
and its transferable rule: *a deletion that does not move your evals is not
evidence the deleted thing was obsolete — it is evidence your evals never
measured it.* The same caution applies to trimming this bundle's own contract.

Distinct from a [test oracle](/beliefs/glossary/test-oracle.md), which decides
whether a single output is correct; an ablation compares aggregate performance
across two configurations and inherits whatever blindness that aggregate has.

*Seen in:* [2026-08-05 context-engineering intake and instruction conflict](/meta/threads/2026-08-05-anthropic-context-engineering-intake-and-instruction-conflict.md)
