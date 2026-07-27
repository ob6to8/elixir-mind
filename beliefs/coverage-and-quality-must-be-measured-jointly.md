---
id: em:06de36
type: belief
title: Coverage and quality must be measured jointly, or degradation hides behind availability
description: An evaluation that scores only whether a system produced an answer cannot see a system whose answers got worse — availability and correctness are one measurement, and reporting either alone is a metric that a degraded system passes.
provenance: "Claude Code session, 2026-07-27 — synthesized while intaking the Beyond Refusal paper (arXiv:2607.05842), whose coverage×quality decomposition generalizes past its security setting; ratified as a belief by the operator in the same session"
tags: [belief, evaluation, metrics, measurement, degradation]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, arXiv:2607.05842 intake session — operator-directed belief filing"
  why: "operator directed extracting the coverage×quality decomposition as a belief generalizing past the security setting"
---

# Coverage and quality must be measured jointly, or degradation hides behind availability

A system under evaluation can fail in two ways that a single metric cannot
separate: it can decline to answer, or it can answer badly. Measuring only the
first — response rate, uptime, completion rate, non-refusal — produces a number
that a thoroughly degraded system passes cleanly, because every degraded answer
still counts as an answer. The prior: **treat "did it respond" and "was the
response any good" as two factors of one measurement**, and distrust any headline
figure that reports only the first.

The formulation that names it comes from
[Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md),
where defender-side utility decomposes as `U(y) = C(y)·Q(y)` — coverage times
answer quality, with unusable answers scoring zero. Its sharpest statement of the
consequence, quoted verbatim:

> "A model that rarely refuses but produces incorrect localization or unusable
> patches may be no more useful to defenders than one that refuses frequently."

That paper measured it in a setting where the stakes make the point unusually
legible — it argues that in security deployment "availability, correctness, and
actionability are not merely usability concerns; they are security-relevant
properties of the system" — and found the effect empirically: both model states
answered ~97% of the time while differing substantially in whether those answers
were correct or actionable. The refusal-rate metric saw nothing.

The belief is held as an evaluation prior rather than a finding about language
models, because the failure shape is not specific to them. Any measurement that
counts *events* while assuming their *quality* is constant inherits it: a test
suite scored by tests-run, a retrieval layer scored by hit count, a pipeline
scored by throughput. It is the measurement-side counterpart of
[invisible degradation](/beliefs/glossary/invisible-degradation.md) — degradation
that emits no signal is degradation that the instrument was not built to emit a
signal for.

The practical consequence is a design rule for any metric this brain adopts:
where a quality dimension exists, multiply it in and let unusable output score
zero, so a single number cannot be satisfied by volume alone. This is the same
reasoning that makes
[decompose-then-verify](/knowledge/SWE/evals/decompose-then-verify-factuality.md)
score claims rather than responses.

# Citations

- Li, Qiu, Peng, Fan, Fu, Ding & Feng, "Beyond Refusal: A Same-Lineage Study of
  Aligned and Abliterated LLMs for Vulnerability Analysis", arXiv:2607.05842v1
  [cs.SE], 7 Jul 2026 — <https://arxiv.org/abs/2607.05842>
