---
id: em:332bd0
type: concept
title: probabilistic delimiter injection
description: An attack technique that exploits a language model's tendency to guess at structural boundaries (quotes, braces, tags) from surrounding tokens rather than enforcing them like a strict parser, letting an attacker-controlled field relocate where trusted data ends and injected content begins.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, security, prompt-injection, agents]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "term coined by the Agent Data Injection paper, surfaced in the 2026-07-29 research digest"
---

# probabilistic delimiter injection

A strict parser enforces delimiters (quotes, braces, brackets, line breaks) as
hard boundaries; a language model reading the same structure only *guesses* at
where one field ends and the next begins, from the surrounding tokens. An
attacker who controls one field can plant delimiter-like characters inside it
— stray quotation marks, curly quotes, extra braces — and the model will often
read that punctuation as genuine structure, silently shifting the boundary so
attacker content is read as though it came from a trusted field. This is the
core mechanism behind
[agent data injection](/knowledge/SWE/security/agent-data-injection.md), and it
evades defenses built to catch instruction-shaped text, because the injected
payload is never phrased as an instruction — it's phrased as punctuation.

*Seen in:* [Agent Data Injection](/knowledge/SWE/security/agent-data-injection.md), [2026-07-29 research digest thread](/meta/threads/2026-07-29-research-digest-mcp-spec-security-and-reliability.md)
