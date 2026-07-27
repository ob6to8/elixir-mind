---
id: em:1374e6
type: concept
title: jailbreak
description: A prompt crafted to make an aligned model produce output its safety training would otherwise suppress, working through the input rather than by altering the model's weights.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, llm-safety, alignment, adversarial, security]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# jailbreak

Distinct from [prompt injection](/beliefs/glossary/prompt-injection.md) in who is being subverted: a jailbreak is the *user* circumventing the model's own policy, while prompt injection is a *third party* smuggling instructions through content the model reads on the user's behalf. Both exploit the absence of a trust boundary inside a single token stream.

Also distinct from [abliteration](/beliefs/glossary/abliteration.md), which achieves a comparable outcome by editing weights instead of composing text — the jailbreak leaves the model intact and defeats it at inference, which is why the two motivate different defenses. Attacks range from hand-written roleplay framings to optimized adversarial suffixes that transfer across models, and the existence of transferable suffixes is the evidence that refusal training is a shallow behavioral layer rather than a property of the model's knowledge.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>
