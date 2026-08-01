---
id: em:91e7bb
type: concept
title: indirect prompt injection
description: The variant of prompt injection in which the malicious instructions arrive inside content the agent was asked to process — a document, email, web page, or database record — rather than from the operator's own message.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, security, prompt-injection, agents, document-processing]
timestamp: 2026-07-29
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "term surfaced by the secure-financial-agent architecture session, where it is the load-bearing risk"
---

# indirect prompt injection

The distinguishing feature is that the operator's request is innocuous and the payload rides in on the data. This inverts the usual trust intuition: material that *feels* authoritative — an invoice, a statement, a tax form — is precisely the material a third party authored, so format is no evidence of safety.

Because the instructions are interpreted by whichever model reads the content, the attack is unaffected by where that model runs; a fully air-gapped deployment is as susceptible as a hosted one. Defense therefore lives on the action surface — [privilege minimization](/beliefs/glossary/prompt-injection.md) and a human gate on consequential operations — rather than in classifying the input, since no reliable detector exists for text that is semantically an instruction.

A newer subclass, [agent data injection](/knowledge/SWE/security/agent-data-injection.md) (ADI), forges the *trusted metadata* an agent parses structure from — sender names, resource identifiers, tool-call formats — rather than smuggling an instruction, which is why classifiers built to catch instruction injection largely fail to catch it.

*Seen in:* [indirect prompt injection in document pipelines](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md), [secure financial agent](/projects/secure-financial-agent.md), [Agent Data Injection](/knowledge/SWE/security/agent-data-injection.md), [2026-07-29 research digest thread](/meta/threads/2026-07-29-research-digest-mcp-spec-security-and-reliability.md)
