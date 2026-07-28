---
id: em:8510f4
type: concept
title: control case
description: An input to a measurement whose correct result is known before the run, included so that a wrong result identifies the instrument rather than the subject.
provenance: "Agent-distilled glossary definition, pointer to the defining belief"
verified: false
sense: common
tags: [glossary, measurement, evaluation, verification, testing]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the term the closing belief turns on, used across that belief and the fetch-fidelity plan"
---

# control case

Two kinds do different work and both are needed: a **positive** control must
pass (an unmodified input, a hand-computed answer the instrument has to
reproduce), and a **negative** control must fail (an input designed to come out
the other way). An instrument checked only against positives cannot detect its
own permissiveness — the [dedup probe](/meta/evals/dedup-probe.md)'s `negative`
band exists for exactly that reason.

Distinct from a [test oracle](/beliefs/glossary/test-oracle.md): an oracle
decides whether a *result* is correct, a control decides whether the *instrument*
is working. The prior that makes it mandatory rather than advisable is
[an instrument without a control measures itself](/beliefs/an-instrument-without-a-control-measures-itself.md).

*Seen in:* [an instrument without a control measures itself](/beliefs/an-instrument-without-a-control-measures-itself.md), [the fetch fidelity probe plan](/meta/plans/build-the-fetch-fidelity-probe.md)

*See also:* [test oracle](/beliefs/glossary/test-oracle.md), [gate suite](/beliefs/glossary/gate-suite.md)
