---
id: em:2b1f58
type: reference
title: "AI Evals For Engineers, PMs & QAs: Complete Study Guide"
description: A 16-chapter, 7-appendix study guide (built on Hamel Husain & Shreya Shankar's evals course) walking through observability setup, error analysis, LLM-as-judge construction with train/dev/test splits, code-based evaluators, RAG/multi-step/multi-turn/agentic evaluation, production guardrails, and statistical correction of judge bias with `judgy`.
resource: "https://github.com/ombharatiya/ai-system-design-guide/blob/main/ai_evals_comprehensive_study_guide.md"
provenance: "ombharatiya/ai-system-design-guide, GitHub repository, enriched from the Maven course by Hamel Husain & Shreya Shankar"
tags: [evals, llm-as-judge, error-analysis, observability, rag, agentic-evaluation, evaluation-methodology, study-guide]
timestamp: 2026-08-01T00:00:00Z
attribution:
  when: 2026-08-01T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pasted three AI-evals sources (this guide, a video, Hamel Husain's FAQ) for capture into the brain"
---

# AI Evals For Engineers, PMs & QAs: Complete Study Guide

## Summary

This guide is a practitioner's manual for figuring out whether an AI product
actually works, aimed equally at engineers, product managers, and QA — not
just the people who write the code. Its central claim is that the highest-
leverage activity is not building fancy dashboards or automated scoring
systems; it is a human sitting down and reading through 100 real interaction
logs, noting what went wrong, and grouping those notes into a handful of
recurring problem categories. Everything else in the guide — automated
checks, an LLM standing in as a grader, safety filters — is built on top of
what that reading turns up, not in place of it.

The guide's arc follows one project end to end: first capture a complete
record of every AI interaction (not just the final answer, but every
intermediate step); then read a sample of those records by hand and name the
failure patterns; then decide, failure by failure, whether a cheap
rule-based check can catch it or whether it needs a second AI model trained
to grade it like a human would. That second option — an AI grading another
AI — only earns trust once its judgments are checked against real human
verdicts on data it has never seen, using the classic two-sided statistics
of "how often did it correctly catch a real problem" versus "how often did
it wrongly grade a fine answer as bad." The later chapters extend this same
grade-what-actually-broke discipline to trickier shapes of AI system:
retrieval-augmented answers, multi-step pipelines, long conversations, and
autonomous agents — plus how to run all of this cheaply and continuously
once a product ships, rather than as a one-time exercise.

## Key terms

- **Trace** — the complete record of one AI interaction: system prompt,
  user messages, every tool call and its result, and the final response.
  The unit of evidence error analysis reads.
- **Error analysis** — the practice of reading traces by hand, writing
  open-ended notes on what went wrong (*open coding*), then grouping those
  notes into a small set of named failure categories (*axial coding*) and
  counting how often each occurs. The guide's central technique.
- **Theoretical saturation** — the stopping point for error analysis: once
  roughly 20 additional traces in a row surface no new failure category, the
  taxonomy is judged complete enough to act on (after an initial pass over
  at least 100).
- **Dimensional sampling** — generating diverse synthetic test queries by
  first defining a handful of dimensions of variation (e.g. dietary
  restriction × cuisine × complexity), hand-writing a few example tuples per
  dimension combination, then having an LLM expand tuples into natural-
  language queries in a separate step from generating the tuples — because
  asking an LLM to invent test queries directly, unstructured, produces
  generic, repetitive output.
- **[LLM-as-judge](/beliefs/glossary/llm-as-judge.md)** — an LLM prompted to
  grade another AI system's output the way a domain expert would, used
  where a plain code check cannot capture a subjective quality. The guide's
  version is always a binary PASS/FAIL classifier with an explanation, never
  a numeric scale.
- **Train/dev/test split** — the 15%/40%/45% partition of hand-labeled
  ground truth used to build a judge: train supplies few-shot examples for
  the judge prompt, dev is where the prompt is iterated against, and test is
  touched exactly once, at the end, for an unbiased final read.
- **TPR / TNR (true positive / true negative rate)** — the two-sided
  accuracy check a judge must pass before it is trusted: TPR is how often it
  correctly flags a real failure, TNR is how often it correctly clears a
  good response. A judge that always says PASS scores near-100% "agreement"
  whenever failures are rare while its TNR (or TPR, depending on framing)
  collapses — which is why agreement percentage alone is a misleading
  metric and both rates must individually clear roughly 80%.
- **`judgy`** — a library the guide uses to statistically correct a judge's
  raw pass rate for its own known TPR/TNR error rates, producing a corrected
  estimate (with a confidence interval) of the system's true failure rate
  rather than trusting the judge's verdicts at face value.
- **Guardrail vs. evaluator** — a guardrail is a fast, deterministic,
  synchronous check (regex, schema validation, a lightweight classifier)
  that sits in the request path and can block or redact a response before a
  user sees it; an evaluator runs asynchronously after the fact to measure
  qualities a rule cannot capture (factual correctness, tone), feeding
  dashboards and regression tests but never blocking the live answer.
- **Transition failure matrix** — for multi-step or agentic workflows, a
  matrix whose rows are "last successful state" and columns are "state
  where the first failure occurred," used to spot which step-to-step
  transition (e.g. generate-SQL → execute-SQL) causes the most failures.
- **[Recall@k](/beliefs/glossary/recall-at-k.md)** and Precision@k — the
  traditional information-retrieval metrics the guide uses to score a RAG
  system's retrieval stage on its own, separately from the generation stage.

## Technical summary

The guide opens by establishing observability as a prerequisite: without a
trace capturing every system prompt, tool call, and intermediate result —
not just final output — there is nothing for error analysis to read. It walks setup for two open-source
platforms, Arize Phoenix (self-hosted) and Langfuse (cloud or self-hosted),
treating both as interchangeable examples of the same underlying concepts
(traces, spans, datasets, experiments).

Error analysis is then positioned as the load-bearing activity of the whole
methodology: open-code a sample of traces into free-text notes, axial-code
those notes into 5–6 named failure categories, count frequencies, and keep
sampling — mixing random sampling with clustering, outlier detection, and
user-feedback signals — until roughly 20 consecutive fresh traces stop
turning up new categories (theoretical saturation), having reviewed at least
100 to start. Where no production data yet exists, dimensional sampling
generates synthetic queries by first defining variation dimensions,
hand-authoring seed tuples, then expanding tuples to natural language in a
step separate from tuple generation — avoiding the generic, repetitive
output that comes from asking an LLM for "test queries" with no structure.

Once failure categories and their frequencies are known, each one is routed
to the cheapest evaluator that can catch it: a code-based check (regex,
schema validation, tool-call verification) where the failure is objective,
or an [LLM-as-judge](/beliefs/glossary/llm-as-judge.md) where it is not. The
guide is prescriptive about how a judge is built and validated: label
150–200 traces PASS/FAIL as ground truth, split 15%/40%/45% into
train/dev/test, build a four-part judge prompt (role and domain
definitions, explicit binary criteria, 1–3 few-shot examples drawn from the
train split, and a structured output format), iterate the prompt against
the dev split until both TPR and TNR individually clear roughly 80%, then
read the test split exactly once for a final, unbiased number. `judgy` then
statistically corrects the judge's raw pass rate on production data for its
known TPR/TNR error rates, yielding a bias-corrected failure-rate estimate
with a confidence interval rather than trusting the judge's raw verdicts.
The guide is emphatic that agreement percentage alone is a misleading
validation metric, because a judge that defaults to PASS scores high
agreement whenever real failures are rare in the sample.

Specialized chapters extend the same discipline to harder shapes of system:
RAG evaluation splits cleanly into a retrieval stage scored with
[Recall@k](/beliefs/glossary/recall-at-k.md)/Precision@k/MRR against a
synthetically generated query-document gold set, and a generation stage
scored the same way as any other LLM output (error analysis → judge);
multi-step pipelines get both outcome metrics (did the final business
result meet requirements) and process metrics (step count, latency),
segmented by pipeline stage since early-stage failures cascade downstream;
multi-turn conversations are debugged by first checking the whole
conversation pass/fail, annotating only the first upstream failure, and
reproducing it in the simplest possible single-turn test case before
treating it as genuinely conversation-dependent; and agentic workflows are
evaluated in two phases — end-to-end task success treating the agent as a
black box, then step-level diagnostics (tool choice, parameter extraction,
error recovery, context retention) once error analysis shows which
workflows fail most — with a transition failure matrix (rows = last
successful state, columns = first-failure state) used to locate the
highest-failure step transitions.

For production, the guide distinguishes offline evals (run after traces are
collected, measuring quality trends over minutes to hours) from online
guardrails (fast, deterministic, synchronous checks in the request path that
can block or redact before a user sees a response) — reserving
[LLM-as-judge](/beliefs/glossary/llm-as-judge.md) for the offline/async side
because its latency and non-determinism make it unsuitable as a synchronous
gate except in narrow, latency-tolerant cascades. Closing chapters cover a
concrete two-week bootstrap (logging, then 100-trace manual error analysis,
then categorization, then a first code-based and LLM-judge evaluator in
week one; automation, alerting, and dashboards in week two) sustained by 30
minutes of weekly review and monthly 50-trace refresh passes, and a
twelve-item list of common mistakes — skipping error analysis, trusting
agreement alone, delegating error analysis away from PMs/QAs, skipping the
train/dev/test split, building evaluators for every failure mode rather than
the ones that persist after obvious prompt fixes, and copy-pasting generic
eval prompts without domain customization chief among them.

# Citations

- [`ai_evals_comprehensive_study_guide.md`](https://github.com/ombharatiya/ai-system-design-guide/blob/main/ai_evals_comprehensive_study_guide.md),
  fetched 2026-08-01 — the full 16-chapter, 7-appendix guide this document
  distills; the appendices (glossary, quick reference, full production judge
  prompts, platform method reference, 30-day learning path) are not
  reproduced here and are best read at the source.

See also, filed alongside this document from the same intake session: a
live worked example of this methodology in
[Complete Beginner's Course on AI Evaluations — Aman Khan](/knowledge/SWE/evals/complete-beginners-course-on-ai-evaluations-aman-khan.md),
and the FAQ this guide's own methodology traces back to,
[LLM Evals — Hamel Husain & Shreya Shankar](/knowledge/SWE/evals/llm-evals-faq-hamel-husain-shreya-shankar.md).
