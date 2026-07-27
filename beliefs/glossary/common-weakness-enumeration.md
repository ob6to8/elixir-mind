---
id: em:2ac1be
type: concept
title: Common Weakness Enumeration (CWE)
description: A community-maintained taxonomy of software and hardware weakness types, each with a stable numeric identifier, used to classify what kind of flaw a vulnerability is rather than which product it appears in.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, security, taxonomy, vulnerability, classification]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the Beyond Refusal paper intake (arXiv:2607.05842)"
---

# Common Weakness Enumeration (CWE)

Run by MITRE, and the axis along which vulnerabilities are grouped for triage and risk classification: CWE-79 is [cross-site scripting](/beliefs/glossary/cross-site-scripting.md), CWE-502 unsafe deserialization, CWE-611 XML external entity processing, CWE-74 improper neutralization in a downstream component. It answers *what kind of mistake was made*, where a CVE identifier answers *which specific product instance was affected*; one CWE class spans thousands of CVEs.

Because the classes are hierarchical and partly overlapping, exact-match scoring of a predicted CWE label is a harsh metric — a defensible near-miss at the wrong level of the tree scores the same as a wholly wrong answer, which is worth remembering when reading single-digit CWE-attribution accuracies in LLM evaluations.

*Seen in:* [Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md), <https://arxiv.org/abs/2607.05842>
