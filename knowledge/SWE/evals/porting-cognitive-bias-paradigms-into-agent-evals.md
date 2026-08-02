---
id: em:d5dbe1
type: methodology
title: "Porting cognitive-bias paradigms into agent evals"
description: "Treat a human bias paradigm as a stimulus-design template, not a test to pass: define the failure operationally in the agent's ontology, regenerate novel isomorphs, embed at deployment shape, measure dose-response over perturbation families, and audit the judge's own biases."
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02 — distilled from the machine-psychology eval literature and its critiques for the bias-mapping research spike"
tags: [evals, cognitive-bias, agentic, methodology, contamination, prompt-sensitivity, llm-judge]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T03:49:14Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research spike on bias mapping"
  why: "the eval-facing residue of the bias-mapping spike is a repeatable procedure and needed filing where eval builders will look"
---

# Porting cognitive-bias paradigms into agent evals

Seventy years of experimental psychology is a library of validated
manipulations, controls, and known moderators for failure modes of bounded
reasoners — the single richest import the human-bias mapping offers
(see [mapping agent failure modes to cognitive biases](/knowledge/SWE/agentic/failure-modes/mapping-agent-failure-modes-to-cognitive-biases.md)).
But a paradigm transplanted naively measures the wrong thing. The procedure:

## 1. Define the failure operationally before naming the bias

Write down the observable regularity in the agent's own ontology — context,
tools, turns, artifacts — as the thing the eval measures. The bias name is a
pointer into the design library, never the eval's definition; an eval
defined operationally stays valid whatever the failure ends up being called.
Example: "after an explicit retraction of premise P, output remains
P-conditioned" is measurable; "the agent has einstellung" is not.

## 2. Port the manipulation; regenerate the stimuli

The paradigm's *structure* transfers (set-forming trials, then a critical
trial where the practiced approach is suboptimal — Luchins; premise, build,
retract, probe — the retraction paradigm). The canonical *stimuli* do not:
famous vignettes sit in the training corpus, so verbatim reuse measures
recall of the literature, not the bias. Generate procedurally novel
isomorphs, and generate them as **perturbation families**, not single items:
"small variations that maintain the principles of ToM turn the results on
their head" (Ullman, <https://arxiv.org/abs/2302.08399>), and "small
perturbations to vignette-based tasks can lead GPT-3 vastly astray"
(Binz & Schulz, <https://arxiv.org/abs/2206.14576>). Ullman's scoring moral
transfers whole: "outlying failure cases should outweigh average success
rates."

## 3. Embed at deployment shape

Most bias batteries are chat-shaped — one vignette, one answer (CogBench,
<https://arxiv.org/abs/2402.18225>; BiasBuster,
<https://arxiv.org/abs/2403.00811>). Agent biases bite inside long
contexts, tool loops, and multi-turn sessions, where position mechanics and
salience gradients do the compounding
([position-biased context use](/knowledge/SWE/agentic/failure-modes/long-context-use-is-position-biased.md),
[premise-retraction persistence](/knowledge/SWE/agentic/failure-modes/premise-retraction-persistence.md)).
Agentic-setting bias evals exist but are young — SynAnchors for anchoring
(<https://arxiv.org/abs/2505.15392>), bias in attack-selection agents,
emotional-priming agent studies, multi-round probing (MindScope) — and in
the sweeps run for this spike, no prominent benchmark surfaced that jointly
targets classic biases *and* long-context tool use; the two literatures run
separately. Deployment-shaped embedding is where the open ground is.

## 4. Measure dose-response, not pass/fail

A bias is a parametric phenomenon; the eval's deliverable is a curve, not a
bit. For retraction persistence: plant premise P, let the agent build on it
(elaboration depth d), retract explicitly, then measure P-conditioned
behavior downstream as a function of d, tokens-since-retraction, competing
salience, and whether a supersession summary exists. And measure **both
sides of the dial**: Belief-R found models tuned toward updating
"underperformed in scenarios without necessary updates, highlighting a
critical trade-off" (<https://arxiv.org/abs/2406.19764>) — an eval that only
rewards revision trains in over-revision. Pair every retraction item with a
matched no-retraction control.

## 5. Report distributions over paraphrases and orderings

Bias magnitude swings with wording and order — "permuting the premise order
can cause a performance drop of over 30%"
(<https://arxiv.org/abs/2402.08939>) — so a single-prompt effect size is
noise. Report the distribution over paraphrase/order variants; treat
variance across variants as a finding (it measures how much of "the bias"
is a stable disposition versus a prompt artifact).

## 6. Audit the instrument

LLM judges carry their own catalog: "position, verbosity, and
self-enhancement biases" (Zheng et al.,
<https://arxiv.org/abs/2306.05685>). A bias eval scored by a biased judge
confounds subject and instrument — randomize positions, control lengths,
and calibrate the judge against human-scored anchors before trusting deltas.

What transfers from the human literature, in sum, is the **design library**
— manipulations, moderators, controls, and the habit of minimal pairs. What
does not transfer is the norm: human effect sizes, human pass thresholds,
and human mechanistic interpretations stay on the human side of the map.

# Citations

- Ullman (2023), "Large Language Models Fail on Trivial Alterations to
  Theory-of-Mind Tasks": <https://arxiv.org/abs/2302.08399>
- Binz & Schulz (2023), "Using cognitive psychology to understand GPT-3":
  <https://arxiv.org/abs/2206.14576>
- Coda-Forno et al. (2024), "CogBench": <https://arxiv.org/abs/2402.18225>
- Echterhoff et al. (2024), "Cognitive Bias in Decision-Making with LLMs"
  (BiasBuster): <https://arxiv.org/abs/2403.00811>
- Huang et al. (2025), "Understanding the Anchoring Effect of LLM with
  Synthetic Data" (SynAnchors): <https://arxiv.org/abs/2505.15392>
- Wilie et al. (2024), "Belief Revision" (Belief-R):
  <https://arxiv.org/abs/2406.19764>
- Chen et al. (2024), "Premise Order Matters in Reasoning with Large
  Language Models": <https://arxiv.org/abs/2402.08939>
- Zheng et al. (2023), "Judging LLM-as-a-Judge with MT-Bench and Chatbot
  Arena": <https://arxiv.org/abs/2306.05685>
