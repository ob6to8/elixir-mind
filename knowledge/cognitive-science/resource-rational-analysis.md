---
id: em:24b4fd
type: concept
title: "Resource-rational analysis"
description: "Lieder & Griffiths' framework reading many cognitive biases as optimal trade-offs under bounded computation rather than defects — the shared optimization pressure that makes bias-like shortcuts expectable in any resource-limited reasoner."
verified: false
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02 — distilled from the Lieder & Griffiths BBS target article and its use in the LLM-behavior literature"
tags: [cognitive-science, bounded-rationality, rational-analysis, cognitive-bias, computational-modeling]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T03:41:25Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research spike on bias mapping"
  why: "the convergent-pressure argument in the bias-mapping cluster needed the framework it rests on filed as a citable concept"
---

# Resource-rational analysis

Resource-rational analysis (Lieder & Griffiths, *Behavioral and Brain
Sciences* 2020) models cognition as the **optimal use of limited
computational resources**: instead of asking whether behavior matches an
unbounded normative standard (logic, Bayesian inference) and cataloguing the
deviations as "biases," it asks what strategy would be optimal for an agent
that must pay for time, memory, and computation — and reads observed
heuristics as answers to *that* optimization problem. Anchoring-and-
adjustment, availability, and satisficing stop being defects and become
rational policies under a compute budget. The methodological motivation,
from the abstract: "Modeling human cognition is challenging because there
are infinitely many mechanisms that can generate any given observation"
([PubMed abstract](https://pubmed.ncbi.nlm.nih.gov/30714890/)) — bounded
optimality supplies the missing constraint.

## Why it matters beyond psychology

The framework's explanatory move — derive behavior from the optimization
pressure the system actually faces, not from a deficit against an ideal —
transfers to any bounded reasoner. Two consequences are load-bearing for
this bundle:

- **Convergence without copying.** Any system that amortizes inference —
  caches, primes, reuses established structure to buy speed — will exhibit
  set-persistence phenomena as the flip side of that amortization. When a
  human and an LLM agent show analogous perseveration, resource-rationality
  says this can be *convergent* (same pressure, different substrate) rather
  than inherited or coincidental. This is the principled middle position
  between "the model learned our biases" and "the resemblance is an
  accident," developed in
  [mapping agent failure modes to cognitive biases](/knowledge/SWE/agentic/failure-modes/mapping-agent-failure-modes-to-cognitive-biases.md).
- **The same style of analysis exists for LLMs.** McCoy et al.'s "Embers of
  Autoregression" (2023) is resource-rational analysis transposed: explain
  LLM failure modes from "the problem that they were trained to solve:
  next-word prediction over Internet text" rather than from a deficit
  model. The two frameworks license the same inference pattern — behavior
  is a signature of the optimization pressure — applied to different
  optimizers.

# Citations

- Lieder, F., & Griffiths, T. L. (2020). "Resource-rational analysis:
  Understanding human cognition as the optimal use of limited computational
  resources." *Behavioral and Brain Sciences*, 43, e1.
  <https://pubmed.ncbi.nlm.nih.gov/30714890/>
- McCoy, R. T., Yao, S., Friedman, D., Hardy, M., & Griffiths, T. L. (2023).
  "Embers of Autoregression: Understanding Large Language Models Through the
  Problem They are Trained to Solve." <https://arxiv.org/abs/2309.13638>
