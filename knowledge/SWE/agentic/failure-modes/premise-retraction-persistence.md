---
id: em:1b6809
type: note
title: "Premise-retraction persistence in append-only agent contexts"
description: "A frame or premise established earlier in a session keeps steering an agent's output after being explicitly retracted — an append-only context has no retraction operation, so supersession is only another token sequence competing on salience."
verified: false
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02 — synthesis over an operator-relayed session report and the belief-revision / long-context literature"
tags: [agentic, failure-modes, context-engineering, belief-revision, truth-maintenance, retraction, salience]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T03:41:25Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research spike on bias mapping"
  why: "the motivating failure case of the bias-mapping spike needed a filed operational description before analogies to human biases could be assessed against it"
---

# Premise-retraction persistence in append-only agent contexts

## The phenomenon

An agent adopts a frame or premise early in a session; the premise is later
explicitly retracted; the agent's subsequent output keeps conforming to the
retracted frame anyway. A session report from another operator-run
repository, relayed in the exchange that commissioned this cluster,
describes the failure exactly:

> a frame formed earlier in a session (a length-cap framing of PR size) kept
> steering later prose after its premise had been explicitly retracted,
> because an append-only context has no retraction operation — a superseded
> premise and its successor coexist as tokens, and the in-progress line of
> thought usually holds more salience. The missing faculty has a
> classical-AI name — truth maintenance

The operational signature: **retraction is an addition.** Nothing leaves the
context window; "X is retracted" is more tokens beside X, and which of the
two controls generation is decided by attention dynamics, not by the logical
relation *supersedes*.

## Why append-only contexts produce it

- **No deletion operation.** The context grows monotonically within a
  session. A superseded premise remains present, differing from live
  premises only in what has been said *about* it since.
- **No dependency structure.** The context records token order, not
  derivation. When a premise is withdrawn, there is no recorded set of
  downstream conclusions that rested on it — the
  [blast radius](/beliefs/glossary/blast-radius.md) of the retraction is not
  a computable set, so nothing gets systematically re-derived.
- **Salience favors the elaborated line.** The in-progress line of thought
  has been repeatedly attended and extended; every generated token
  conditions on the frame's tokens and deepens the groove
  (self-conditioning). A one-line retraction competes against pages of
  elaboration built on the premise it withdraws.
- **Position mechanics compound it.** Attention structurally over-weights
  context beginnings — Xiao et al. observe "strong attention scores towards
  initial tokens as a 'sink' even if they are not semantically important"
  (<https://arxiv.org/abs/2309.17453>) — and
  [retrieval degrades mid-context](/knowledge/SWE/agentic/failure-modes/long-context-use-is-position-biased.md),
  so an early frame enjoys positional privilege over a mid-session
  retraction. Anthropic's context-engineering guidance frames the budget:
  "LLMs have an 'attention budget' that they draw on when parsing large
  volumes of context," and "Context, therefore, must be treated as a finite
  resource with diminishing marginal returns"
  (<https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>).

Practitioner taxonomies name adjacent composites: Drew Breunig's *context
poisoning* — "When a hallucination or other error makes it into the context,
where it is repeatedly referenced" — and *context clash* — "When you accrue
new information and tools in your context that conflicts with other
information in the context"
(<https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html>).
Premise-retraction persistence is the special case where the conflict is not
accidental: the context *states* which side is authoritative, and the model
follows the other one.

## What the benchmarks show

The general faculty — revising in-context conclusions when premises change —
is measurably weak, and weak in both directions:

- Belief-R (Wilie et al., 2024): "LMs generally struggle to appropriately
  revise their beliefs in response to new information," and "models adept at
  updating often underperformed in scenarios without necessary updates,
  highlighting a critical trade-off"
  (<https://arxiv.org/abs/2406.19764>) — under-revision when a premise is
  defeated, over-revision once tuned to update.
- Knowledge-conflict studies (Xie et al., ICLR 2024): models are
  "highly receptive to external evidence even when that conflicts with their
  parametric memory, given that the external evidence is coherent and
  convincing," yet show "a strong confirmation bias when the external
  evidence contains some information that is consistent with their
  parametric memory" (<https://arxiv.org/abs/2305.13300>) — updating is
  governed by coherence and prior-fit, not by provenance or authority.
- Retraction behavior (Yang & Jia, 2025): "while LLMs are capable of
  retraction, they do so only rarely, even when they can recognize their
  mistakes when asked"; retraction is gated by an internal belief state that
  "frequently diverge[s] from models' parametric knowledge"
  (<https://arxiv.org/abs/2505.16170>).

## Nearest human analogs — plural

The failure resembles more than one documented human bias, and the fan-out
is itself informative (see
[mapping agent failure modes to cognitive biases](/knowledge/SWE/agentic/failure-modes/mapping-agent-failure-modes-to-cognitive-biases.md)):

- The [continued influence effect](/knowledge/cognitive-science/biases/continued-influence-effect.md)
  is the closest match when the persisting item is a *retracted factual
  premise*: in humans too, a retraction is an addition — a second memory
  trace that must out-compete the first and systematically fails to.
- The [einstellung effect](/knowledge/cognitive-science/biases/einstellung-effect.md)
  is the closer match when the persisting item is a *procedure or framing*
  (the reported case — a length-cap frame governing how prose gets written —
  has this flavor): the first schema keeps directing attention after its
  justification lapsed.
- Anchoring is the numeric-estimate cousin (an early value conditioning
  later judgments).

One agent behavior, three candidate human labels: the analogies are real at
the behavioral level, but none of them is the failure's *identity*.

## The missing faculty — truth maintenance

Classical AI built exactly the machinery this failure lacks.
[Truth maintenance systems](/knowledge/knowledge-management/knowledge-representation/truth-maintenance-systems.md)
record, for every conclusion, the justifications it rests on; Doyle's
founding paper defines the TMS as "a problem solver subsystem for performing
these functions by recording and maintaining the reasons for program
beliefs" ([captured passages](/knowledge/knowledge-management/knowledge-representation/doyle-1979-a-truth-maintenance-system.md)).
With justification edges recorded, retracting a premise makes the affected
conclusions a *computable set* — dependency-directed backtracking re-derives
exactly what lost support. An LLM context has no justification edges, so the
same operation has no mechanical substrate: the model would have to
re-derive the dependency structure from prose, mid-generation, against the
salience gradient described above.

## Mitigations in current practice

All known mitigations are context-surgery or externalization — engineering
moves with no human analog (a person cannot excise a paragraph from their
own working memory):

- **Compaction with explicit supersession.** When summarizing or compacting,
  write the *current* state of each decision ("X was considered and
  retracted; Y is in force") rather than replaying the history — the
  summary, unlike the transcript, can perform a real deletion.
- **Living state outside the transcript.** Keep decisions in an external
  artifact that states only the present (a plan file, a state doc) and
  re-read it before acting, so generation conditions on a surface that has
  overwrite semantics.
- **Fresh-context handoff.** Move the work to a sub-agent or new session
  that inherits the *conclusion* but not the superseded frame's tokens —
  isolation as retraction.
- **Structural markers.** Make retractions loud and positionally favored
  (recap at the end of context, where recency helps) rather than one line
  mid-transcript.

An eval shape for measuring the failure parametrically — plant, build,
retract, then measure downstream leakage as a dose-response curve — is
specified in
[porting cognitive-bias paradigms into agent evals](/knowledge/SWE/evals/porting-cognitive-bias-paradigms-into-agent-evals.md).

# Citations

- Operator-relayed session report from a sibling repository (quoted above;
  no public URL).
- Xiao et al. (2023), "Efficient Streaming Language Models with Attention
  Sinks": <https://arxiv.org/abs/2309.17453>
- Anthropic engineering (2025), "Effective context engineering for AI
  agents": <https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>
- Breunig (2025), "How Long Contexts Fail": <https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html>
- Wilie et al. (2024), "Belief Revision: The Adaptability of Large Language
  Models Reasoning" (Belief-R): <https://arxiv.org/abs/2406.19764>
- Xie et al. (2024), "Adaptive Chameleon or Stubborn Sloth" (ICLR 2024):
  <https://arxiv.org/abs/2305.13300>
- Yang & Jia (2025), "When Do LLMs Admit Their Mistakes? Understanding the
  Role of Model Belief in Retraction": <https://arxiv.org/abs/2505.16170>
- Chen et al. (2024), "Premise Order Matters in Reasoning with Large
  Language Models": <https://arxiv.org/abs/2402.08939>
