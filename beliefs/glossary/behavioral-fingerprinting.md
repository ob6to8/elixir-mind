---
id: em:3e872b
type: concept
title: behavioral fingerprinting
description: Tracking a rolling vector of style and behavior metrics for a long-running agent — verbosity, retry density, error-message tone, diff size — compared against a frozen baseline over time, so gradual drift surfaces before it breaks system logic.
provenance: "Agent-distilled glossary definition, from the 300-hour-run post's operator discourse"
verified: false
tags: [glossary, agentic, drift, reliability, monitoring]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "term surfaced by the 2026-07-27 scar-tissue session — the third countermeasure in the captured post and the named gap in the defenses analysis"
---

# behavioral fingerprinting

The countermeasure aimed at the failure no single output reveals: each
individual action of a drifting agent looks fine, and only the *distribution*
of its behavior moves — so the detector must be a distribution watched against
a ruler that does not drift along with the agent (the frozen baseline is what
separates this from simply comparing today's output to yesterday's). Third of
the three countermeasures in the captured
[scar-tissue post](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md),
alongside the immutable hour-zero baseline and forced receipts.

**In this brain:** the
[defenses analysis](/meta/analysis/scar-tissue-drift-defenses-and-persistence.md)
names this the one countermeasure the bundle lacks, anatomizes it into three
measurable surfaces (description register, tag consistency, distillation
depth) over the corpus — behavior's durable residue here, since sessions are
ephemeral — and recommends implementing it in the
[dedup-probe](/meta/evals/dedup-probe.md) pattern (committed baseline, delta
per run, trend in git history, warn-never-fail) as a rider on the
[escape-rate plan](/meta/plans/auto-intake-escape-rate-sampling.md), whose
per-doc defect judgments it complements with a trend view.

*Seen in:* [scar-tissue capture](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md), [scar-tissue defenses analysis](/meta/analysis/scar-tissue-drift-defenses-and-persistence.md), [2026-07-27 scar-tissue session](/meta/threads/2026-07-27-scar-tissue-drift-doctrine-and-link-policy.md)

*See also:* [scar tissue](/beliefs/glossary/scar-tissue.md), [escape rate](/beliefs/glossary/escape-rate.md), [drift class](/beliefs/glossary/drift-class.md), [detector](/beliefs/glossary/detector.md)
