---
id: em:b3586c
type: reference
title: "LLM Evals: Everything You Need to Know — Hamel Husain & Shreya Shankar"
description: A curated FAQ (from the questions the authors received teaching 700+ engineers & PMs) covering error analysis, binary vs. Likert evaluation design, when to outsource annotation, tooling gaps, guardrails vs. evaluators, and evaluating RAG, multi-turn, and agentic systems — opinionated field guidance, not universal rules.
resource: "https://hamel.dev/blog/posts/evals-faq/evals-faq.pdf"
provenance: "Hamel Husain & Shreya Shankar, hamel.dev, 2025-05-28"
tags: [evals, llm-as-judge, error-analysis, human-annotation, rag, guardrails, evaluation-methodology, faq]
timestamp: 2026-08-01T00:00:00Z
attribution:
  when: 2026-08-01T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pasted three AI-evals sources (a study guide, a video, this FAQ) for capture into the brain"
---

# LLM Evals: Everything You Need to Know — Hamel Husain & Shreya Shankar

## Summary

This FAQ is a distillation of the most common questions two AI-evals
instructors received while teaching hundreds of engineers and product
people, and it reads as a set of sharp, field-tested opinions rather than a
neutral reference. Its throughline: the single highest-value activity in
building a reliable AI product is a domain expert manually reading through
real transcripts of the system's behavior, noting what went wrong, and
grouping those notes into a short list of named failure types — and every
other technique in the FAQ (automated checks, an AI grader, safety filters)
exists to scale up what that reading already found, never to replace it.
The authors are emphatic that this reading should not be delegated —
neither to engineers who lack product judgment, nor to an outsourced
labeling vendor who lacks domain context, nor to an LLM asked to do the
whole job unsupervised.

Beyond that core discipline, the FAQ answers a wide spread of practical
questions teams actually hit: how many people should grade outputs (usually
one accountable "benevolent dictator," not a committee); why a strict
good/bad judgment beats a 1-5 star rating; when a generic off-the-shelf
metric (BERTScore, a canned "helpfulness" score) is actively misleading;
how to build and validate an AI grader so it can be trusted; the difference
between a safety guardrail and a quality evaluator; and how the shape of
evaluation changes for retrieval-augmented answers, long documents, and
multi-turn or multi-agent conversations.

## Key terms

- **Error analysis** — reading a sample of real interaction logs by hand,
  writing free-form notes on what's wrong (*open coding*), then sorting
  those notes into a small set of named failure categories and counting
  frequencies (*axial coding*), repeated until roughly 100+ traces have
  been read and new categories stop appearing. The FAQ calls this "the
  most important activity in evals."
- **Benevolent dictator** — a single domain expert (a lawyer for legal
  document review, a psychologist for a mental-health chatbot) given final
  say over what counts as a good or bad output, rather than splitting
  judgment across a committee — used specifically to avoid the "paralysis
  that comes from too many cooks in the kitchen."
- **Binary (pass/fail) evaluation** — the FAQ's recommended grading scheme
  over 1–5 Likert scales, because adjacent Likert points (3 vs. 4) are
  subjective and inconsistent across graders, annotators default to middle
  values to dodge hard calls, and detecting a real statistical difference
  on a scale needs a larger sample than a binary split does.
- **[LLM-as-judge](/beliefs/glossary/llm-as-judge.md)** — an LLM doing a
  scoped, binary classification task in place of a human grader, only
  after being validated against held-out human labels; the FAQ recommends
  starting with the most capable available model for the judge and
  optimizing cost only once alignment is established.
- **True Positive Rate / True Negative Rate (TPR/TNR)** — the two accuracy
  numbers a judge must be checked against, both required to individually
  clear a high bar, because a single "agreement" percentage is misleading
  when real failures are rare in the sample (a judge that always says PASS
  can still score high agreement).
- **Think-aloud protocol** — a usability-testing technique repurposed for
  evals: ask a domain expert to verbalize their reasoning while reviewing a
  handful of traces, extracting deep tacit knowledge in a single one-hour
  session rather than trying to write a complete rubric up front.
- **Inter-Annotator Agreement (IAA) / Cohen's Kappa** — the chance-corrected
  agreement metric used when more than one person must grade the same
  data, needed because larger or multi-domain organizations sometimes
  can't rely on a single benevolent dictator.
- **Guardrail vs. evaluator** — a guardrail is a fast, deterministic, inline
  check (regex, schema validation, a lightweight classifier) that runs in
  the request path and can redact, refuse, or regenerate a response before
  a user sees it; an evaluator runs asynchronously after a response is
  produced, measuring qualities (factual correctness, completeness) that
  simple rules cannot, feeding dashboards and regression tests without
  blocking the live answer.
- **Criteria drift** — the empirically observed phenomenon (cited from
  Shreya Shankar's own research, "Who Validates the Validators?") that a
  team's evaluation criteria shift once they actually start reviewing a
  model's outputs — the FAQ's argument for why evaluation is an iterative,
  human-driven process rather than a target that can be set once and
  handed to an automated prompt optimizer.
- **[Recall@k / Precision@k / MRR](/beliefs/glossary/recall-at-k.md)** —
  the traditional information-retrieval metrics the FAQ recommends for the
  retrieval half of a RAG system, kept explicitly separate from generation-
  quality evaluation of the answer built from retrieved context.
- **Abstention ability** — the research term (worth an Arxiv search per the
  FAQ) for a model's calibration in refusing to answer when it lacks
  sufficient information, evaluated with a balanced set of answerable and
  unanswerable questions where a "pass" requires both answering what it
  can and refusing what it can't.
- **Transition failure matrix** — for multi-step and agentic workflows, a
  matrix of last-successful-state vs. first-failure-state used to locate
  which step-to-step transition causes the most failures, turning
  individual trace review into an aggregate, actionable picture.

## Technical summary

The FAQ opens by grounding evals in a simple foundational claim: a
complete-record trace of an interaction is the substrate everything else
works from, and a minimum
viable evaluation setup is not infrastructure at all — 30 minutes spent
manually reviewing 20–50 outputs with a single accountable domain expert.
Error analysis is then developed as the core discipline: gather
representative (or, absent real data, structured dimensional-sampling
synthetic) traces; open-code a sample into free notes, favoring the *first*
observed failure per trace since upstream failures cascade downstream;
axial-code those notes into a small failure taxonomy and count frequencies;
and keep sampling — mixing random sampling, clustering, outlier/data-
analysis signals, and classifier-flagged traces, always keeping some
purely random traces in the mix to catch what current signals miss — until
roughly 100+ traces have been read and new traces stop revealing new
categories. This process is explicitly assigned to product managers and
QA, not delegated to engineering, on the argument that "you have the domain
expertise" and technical correctness ("did the tool call succeed") is a
different question from product correctness ("has an appointment actually
been made").

On evaluation design, the FAQ argues hard against three common defaults:
1–5 Likert scales (binary forces a real decision and is cheaper to validate
statistically); "ready-to-use" generic metrics like BERTScore, ROUGE, or a
canned helpfulness score ("the abuse of generic metrics is endemic" —
these measure properties orthogonal to what actually matters for a given
product, though similarity metrics retain real utility for retrieval and
output-diversity measurement specifically); and eval-driven development,
i.e. writing evaluators before you have evidence of what breaks — with a
narrow exception for hard constraints where the failure mode is already
fully known in advance (e.g. "never mention competitors").
[LLM-as-judge](/beliefs/glossary/llm-as-judge.md) construction gets the
same rigor as the
[study guide sibling document](/knowledge/SWE/evals/ai-evals-for-engineers-pms-qas-study-guide.md)
in this bundle: using the same
model family for the main task and the judge is generally fine, since what
matters is alignment with human judgment rather than architectural
independence; both TPR and TNR must individually clear a high bar (roughly
80%) because agreement alone is misleading when failures are rare; and the
FAQ names `judgy` for statistically correcting a judge's raw pass rate for
its own known error rates once TPR/TNR are established.

On human process, the FAQ recommends a single "benevolent dictator" for
most teams, scaling to multiple annotators with Cohen's-Kappa-measured
agreement only where domain or scale genuinely demands it, and argues
outsourcing core error analysis is "usually a big mistake" because it
severs the feedback loop between observing a failure and building product
intuition from it — with clean exceptions carved out for purely mechanical
tasks (validating an email address), tasks without product-specific
context (translation), and hiring domain experts *as* internal reviewers
(not as an outsourced replacement for them). LLMs are endorsed for
accelerating specific sub-steps of this workflow — first-pass axial coding,
mapping annotations to failure modes, suggesting prompt fixes, pattern-
mining annotation data — but explicitly not for the initial open coding
pass, validating LLM-suggested failure taxonomies, or ground-truth labeling
for judge validation, because these are exactly the steps that build the
human's own understanding of the data. On tooling, the FAQ argues a
custom-built annotation interface — tailored to render domain-specific
output naturally, with keyboard navigation and progress indicators —
outpaces off-the-shelf annotation tools by roughly 10x for most teams, and
that most vendors remain roughly feature-equivalent at the core, making
support quality ("vibes") the real differentiator; prompts themselves are
best versioned in git, reviewed and deployed atomically with application
code, notebooks providing the best environment for prompt experimentation
with a Python codebase's full tool and RAG capabilities available inline.

Production guidance distinguishes CI evaluation (small, purpose-built,
frequently-run datasets favoring cheap deterministic assertions) from
production monitoring (sampled live traffic, more reliance on reference-
free LLM-judge evaluators, tracked with confidence intervals) — the two
feeding each other as newly discovered production failure patterns become
new CI regression cases — and sharply separates guardrails (fast,
deterministic, synchronous, blocking) from evaluators (asynchronous,
heavier-weight, non-blocking), noting a slow LLM-as-judge is almost never
appropriate as a synchronous guardrail except in narrow latency-tolerant
cascades on borderline cases. Domain-specific chapters cover: RAG,
splitting cleanly into IR-metric retrieval evaluation
([Recall@k/Precision@k/MRR](/beliefs/glossary/recall-at-k.md), scored
against a synthetically reverse-generated query-document gold set) and
generation evaluation via the same error-analysis-then-judge pipeline as
any other output, following Jason Liu's "Only 6 RAG Evals" tiering of
context-relevance, answer-faithfulness, and answer-relevance; document
chunking, where fixed-output tasks (extract one fact) favor large chunks
to reduce fragmentation while expansive-output tasks (summarize every
section) favor small chunks to preserve reasoning quality and bound output
length, chunk size treated as a tunable hyperparameter rather than a fixed
rule; multi-turn debugging, which starts with a whole-conversation
pass/fail judgment, annotates only the first upstream failure initially,
and reproduces failures in the simplest possible single-turn test case
before concluding conversation context itself is the cause; and agentic
workflows, evaluated in two phases (end-to-end black-box task success,
then step-level diagnostics of tool choice, parameter extraction, error
recovery, and context retention once error analysis shows which workflows
fail most), with a transition failure matrix used to locate the highest-
failure step-to-step transitions.

# Citations

- ["LLM Evals: Everything You Need to Know"](https://hamel.dev/blog/posts/evals-faq/evals-faq.pdf),
  Hamel Husain & Shreya Shankar, hamel.dev, 2025-05-28, fetched (full text
  via `pdftotext`) 2026-08-01. HTML edition at
  <https://hamel.dev/blog/posts/evals-faq/>.
