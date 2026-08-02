---
id: em:e71983
type: claim
title: "LLM reasoning shows human-like content effects"
description: "Across NLI, syllogisms, and the Wason selection task, language models answer logical problems more accurately when the semantic content supports the correct inference — the human belief-bias signature, with parallels extending to response-time patterns."
verified: true
verified_by: [em:acb51d]
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02 — distilled from Dasgupta et al. (2022/PNAS Nexus)"
tags: [agentic, failure-modes, cognitive-bias, belief-bias, content-effects, pretraining, distributional-inheritance]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T03:41:25Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research spike on bias mapping"
  why: "the pretraining-mimicry channel is one of the three evidence legs the bias-mapping cluster stands on and needed to be filed at claim strength"
---

# LLM reasoning shows human-like content effects

Dasgupta, Lampinen, Chan et al. ran three formal-reasoning tasks — natural
language inference, syllogism validity judgment, and the Wason selection
task — on large language models and on humans, and found the models
"reflect many of the same patterns observed in humans across these tasks —
like humans, models answer more accurately when the semantic content of a
task supports the logical inferences"
([captured abstract](/knowledge/SWE/agentic/failure-modes/sources/dasgupta-2022-content-effects-on-reasoning.md)).
The parallels run below accuracy: model answer distributions relate to human
response times. This is the belief-bias signature from the human reasoning
literature — logic modulated by whether the conclusion is believable —
reproduced in systems with no stake in the conclusion.

## Why this claim matters

Content effects are the cleanest evidence for the **distributional
inheritance** channel: the bias tracks *meaning*, and meaning enters the
model only through the training distribution. The paper's own framing
locates the channel — models' "prior expectations capture some aspects of
human knowledge," so corpus-derived priors bleed into nominally formal
inference. The general form of the same argument is McCoy et al.'s
teleological account: task, input, and output *probability* modulate
accuracy "even in deterministic settings where probability should not
matter," because the system was shaped by "next-word prediction over
Internet text" (<https://arxiv.org/abs/2309.13638>). Where a bias tracks
the statistics of human-generated text, the mirror between human and model
bias is inheritance, not coincidence — one of the channels separated in
[mapping agent failure modes to cognitive biases](/knowledge/SWE/agentic/failure-modes/mapping-agent-failure-modes-to-cognitive-biases.md).

Belief bias is also one of the three biases whose strength moves at the
tuning stage
([instruction tuning can amplify cognitive biases](/knowledge/SWE/agentic/failure-modes/instruction-tuning-can-amplify-cognitive-biases.md)) —
the channels compose rather than compete.

# Citations

- Dasgupta et al. (2022), "Language models show human-like content effects
  on reasoning tasks" —
  [captured abstract](/knowledge/SWE/agentic/failure-modes/sources/dasgupta-2022-content-effects-on-reasoning.md),
  <https://arxiv.org/abs/2207.07051>
- McCoy et al. (2023), "Embers of Autoregression":
  <https://arxiv.org/abs/2309.13638>
