---
id: em:9baaad
type: methodology
title: Split retrieval and generation evaluation for RAG, and calibrate the LLM judge
description: Evaluate a RAG pipeline's retrieval and generation stages separately with mechanical, stage-appropriate metrics, and calibrate any LLM-judge against a human-scored sample using a different model family — because reference-based metrics score surface overlap, not correctness, and an uncalibrated judge inherits its own model's bias.
provenance: "Distilled from a r/LLMDevs discussion thread, pasted verbatim by the operator 2026-07-29"
tags: [evals, rag, retrieval, llm-as-judge, evaluation, annotation, hallucination]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked for analysis alongside the verbatim capture of the RAG-evaluation thread"
---

# Split retrieval and generation evaluation for RAG, and calibrate the LLM judge

A RAG pipeline that retrieves and answers correctly still leaves the hardest
part undone: knowing whether the answers are any good. Reference-based
metrics don't transfer from their origin (machine translation, summarization)
to open-ended question answering, because they score n-gram overlap against a
single reference string, not correctness against an unbounded space of valid
phrasings. As one practitioner put it: "Evaluating RAG with BLEU/ROUGE is like
judging a chef by how many times they used the word 'salt' in a recipe. The
metric is technically correct, but it tells you absolutely nothing about
whether the food actually tastes good." Naive LLM-as-judge inherits a
different failure: it is "biased toward whatever model you're using as the
judge." Full text of the discussion this distills is captured at
[r/LLMDevs — evaluation is so much harder than actually building the model wrapper](/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md).

The community's converged answer, across five independent commenters, is to
stop scoring the pipeline as one unit.

## Evaluate retrieval and generation as separate stages

"Separate retrieval eval from generation eval, because they fail for
different reasons and need different metrics." Retrieval failure and
generation failure have different causes, different fixes, and — the load-
bearing point — retrieval failure caps what generation can possibly achieve:
"if your retrieval isn't surfacing the right chunks, the generation step
can't fix it." Conflating the two into one end-to-end score means a
generation defect and a retrieval defect look identical from outside, and the
wrong half gets tuned.

## Retrieval: a small [gold set](/beliefs/glossary/gold-set.md), scored mechanically

Retrieval evaluation is cheap to make rigorous because it has a checkable
ground truth: "Have someone (or another LLM) annotate a set of test questions
with which chunks should have been retrieved." A practitioner further along
started with "a tiny set of 20 questions where the right answer should pull
from a specific doc chunk, then checking if the retrieval actually grabbed
that chunk" — logging chunk IDs and scripting the misses so only the
disagreements need a human look. The standard metrics once the gold set
exists are **hit rate** (did the correct chunk appear in the retrieved set at
all) and **MRR** (mean reciprocal rank — how high the correct chunk ranked
when it did appear, penalizing a correct-but-buried result). This is a
[test oracle](/beliefs/glossary/test-oracle.md) in the retrieval domain: cheap
to build because the evaluator can construct the right answer rather than
having to discover it.

## Generation: ask groundedness, not correctness

Open-ended correctness has no cheap oracle, but a narrower question does:
"did the answer use the retrieved context, and did it add anything that
isn't in the context." This groundedness/hallucination check sidesteps the
need for a reference answer entirely — it only requires comparing the
generation against the context it was given, which the pipeline already
has. It is the same decompose-then-verify shape as
[FActScore/SAFE](/knowledge/SWE/evals/decompose-then-verify-factuality.md),
narrowed to a single evidence source (the retrieved chunk) instead of an
open web search.

**Its blind spot is retrieval's blind spot.** When the retrieved chunk itself
is subtly wrong — "adjacent but not quite right" — the answer can be
perfectly grounded in bad context and the check passes anyway: "the answer
looks consistent with context and the check passes. That's where it stops
helping and you're back to needing someone who actually knows the domain."
Groundedness eval is therefore not a substitute for retrieval eval; it
inherits retrieval's errors uncaught. A generation check that appears to pass
consistently is not, by itself, evidence retrieval is sound.

## Lower the review bar with chunk visibility, not just a lighter UI

Showing the reviewer the retrieved chunk alongside the answer changes *what*
they're judging, not just how fast: "they're not judging correctness from
scratch, they're just checking whether the answer matches the chunk. That's
a much lower bar than domain expertise." This is what makes triage by a
non-specialist reviewer viable at all for a domain-specific corpus — up to
the adjacent-chunk failure mode above, where matching the chunk stops being
sufficient and the reviewer needs the domain knowledge back.

On top of that, a lightweight annotation interface cuts review time roughly
6x: "a simple interface where a reviewer flags each output as
correct/partial/wrong with one click, free-text only on the wrong ones... the
session takes 10 minutes instead of an hour" (versus writing a comment per
row). The byproduct is a labeled dataset reusable for regression testing —
the triage pass and the [gold set](/beliefs/glossary/gold-set.md)-building
pass are the same act.

## Calibrate the LLM judge instead of trusting it

Where an LLM-as-judge is used for generation quality, three moves turn it
from "kinda fake" into something that catches regressions: use "a judge model
different from your generator" (a different model family, not just a
different checkpoint, to avoid self-preference bias); "define a rubric
explicitly (groundedness, relevance, completeness separately)" rather than a
single holistic score; and "anchor it to ten answers you scored by hand, then
spot-check the judge against those weekly." The anchor set is a
[control](/beliefs/an-instrument-without-a-control-measures-itself.md) on the
judge itself — a known-answer case the judge must reproduce, re-checked on a
cadence, so judge drift is caught rather than silently trusted. Done this
way the loop "turns 50-a-day into a handful of disagreements to look at."

## Tooling and the adjacent axis

MLflow's eval framework (Databricks-hosted or self-hosted) runs
reference-based and LLM-judge metrics in the same run and tracks them across
pipeline versions, which removes the need to hand-compute this per notebook
run. A related but distinct axis, raised in the same thread: evaluating a
whole session rather than a single turn — recording a real session, replaying
it against pipeline changes, and measuring session-level outcomes with a
simulated-user LLM standing in for the human. That measures the pipeline
under realistic multi-turn use rather than isolated question/answer pairs, and
is a different evaluation than either retrieval hit rate or per-turn
groundedness.

## Why it is in this brain

This is the practical, converged answer to a question this bundle already has
a normative half of: [coverage and quality must be measured
jointly](/beliefs/coverage-and-quality-must-be-measured-jointly.md) says
availability and correctness are separate factors that a single metric
conflates. Retrieval hit rate/MRR is the coverage measurement for a RAG
pipeline; groundedness is its quality measurement; and neither substitutes
for the other, for exactly the reason that belief predicts.

# Citations

- Full thread text: [r/LLMDevs — evaluation is so much harder than actually
  building the model wrapper](/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md),
  fetched 2026-07-29 —
  <https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/evaluation_is_so_much_harder_than_actually/>
