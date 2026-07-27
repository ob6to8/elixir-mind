---
id: em:48b2f1
type: concept
title: dual-use
description: The property of knowledge, tooling, or capability that serves protective and harmful ends through the same mechanism, so that restricting the harmful application necessarily restricts the protective one.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, security, governance, llm-safety, policy]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# dual-use

Inherited from export-control and biosecurity policy, where it describes goods and research with both civilian and military application. Applied to language models it names the structural reason safety mechanisms cannot be made precise by content alone: a request to explain how an exploit reaches a vulnerable sink is the same request whether the asker intends to patch it or fire it, and the distinguishing information — intent, authorization, role — is not present in the text.

Attempts to recover the distinction from the prompt itself (authorization clauses, stated roles) are unreliable in both directions, since the cues are trivially asserted by a bad actor and frequently omitted by a legitimate one. This is why filtering on vocabulary produces [over-refusal](/beliefs/glossary/over-refusal.md) concentrated in exactly the professional domains that most need the assistance.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>
