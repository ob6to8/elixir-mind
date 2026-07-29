---
id: em:57c28a
type: reference
title: "Agent Data Injection (ADI) — forging the metadata an agent trusts"
description: A new indirect-prompt-injection subclass that disguises malicious payloads as trusted metadata (sender names, resource identifiers, tool-call formats) rather than as instructions, evading defenses built to catch instruction-smuggling and clearing up to 50% of the time against Claude Code, Codex, and Gemini CLI.
resource: https://arxiv.org/abs/2607.05120
provenance: "Choi, Kim, Kang, Jeong, Xing, Lee — \"Agent Data Injection Attacks are Realistic Threats to AI Agents\", arXiv:2607.05120, submitted 2026-07-06; corroborated via The Hacker News, fetched 2026-07-29"
tags: [security, prompt-injection, agents, threat-model, mcp, agentic-coding]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: auto-intake
  agent: "Claude Code agent, /research daily Routine"
  why: "featured in the 2026-07-29 digest under SWE; reason-tag: groundbreaking, impactful"
---

# Agent Data Injection (ADI)

A team from Seoul National University, UIUC, and Largosoft (Choi, Kim, Kang,
Jeong, Xing, Lee) names a new subclass of
[indirect prompt injection](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md)
that operates one layer beneath the well-studied one. Where ordinary
instruction injection smuggles an imperative sentence into untrusted content
("ignore previous instructions and…"), **Agent Data Injection (ADI)** forges
the *trusted metadata* an agent uses to parse structure — resource
identifiers, data-origin fields, sender names, button IDs, tool-call and
tool-response formats — so the agent completes its assigned task correctly,
but acting on facts the attacker planted. From the paper's framing: "corrupt
those, and the agent still does your task, only on top of the information the
attacker planted."

## The mechanism: probabilistic delimiter injection

The core technique exploits how a language model reads structural punctuation.
An agent's context wraps data in delimiters — quotes, braces, tags, brackets,
line breaks — that mark where one field ends and the next begins. A strict
parser enforces those boundaries; a language model *guesses* at them
probabilistically from the surrounding tokens. An attacker who controls one
field can sprinkle delimiter-like characters (fake quotation marks, curly
quotes, stray braces) into it, and the model will often read that punctuation
as real structure that was never actually parsed as such — silently
relocating where one field ends and an attacker-controlled one begins.

This is why ADI evades defenses built for instruction injection: those
defenses classify *sentences that look like commands*, and a forged sender
name or a corrupted `resource_id` field is not a command — it's just wrong
data, wearing the same punctuation as the right data.

## What it does in practice

Concrete demonstrated effects: a web agent clicking "Buy Now" instead of "Read
More" because a button's forged ID field pointed it at the wrong element; a
coding assistant running an attacker's shell command because it was disguised
as a maintainer-approved fix in a tool-result field the agent had no reason to
doubt.

## Measured attack success

Across six models, probabilistic delimiter injection succeeded **31.3%–43.3%
of the time on structured JSON data** and **33.3%–100% of the time on web DOM
data**. The comparison that matters is against purpose-built anti-injection
defenses: those defenses block classic instruction injection almost
completely, while ADI still lands **up to 50% of the time** against the same
defenses — because the defenses were built to catch the wrong layer of
attack.

**Systems tested and found vulnerable:** web agents (Claude in Chrome, Google
Antigravity, Nanobrowser) and coding agents (Claude Code, OpenAI Codex, Google
Gemini CLI), across models including GPT-5.2, GPT-5-mini, Claude Opus
4.5/Sonnet 4.5, and Gemini 3 Pro/Flash.

## Why it sharpens the existing threat model

The brain's filed position on indirect injection
([em:7da513](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md))
already holds that defense is structural — bound the *action surface*, don't
try to classify the input — because there is no reliable classifier for "is
this text an instruction." ADI is evidence for exactly that argument from a
different angle: even the classifiers that exist for the instruction-injection
case don't generalize to the data-forgery case, because the payload was never
instruction-shaped in the first place. A human-confirmation gate on
consequential actions, or privilege minimization on what the agent can do
regardless of what it believes about the data, degrades far less under ADI
than any content-classification defense — the action-surface argument gets
*stronger*, not weaker, once the attack moves to a layer content classifiers
can't reach at all.

# Citations

- <https://arxiv.org/abs/2607.05120> — Choi, Kim, Kang, Jeong, Xing, Lee, "Agent Data Injection Attacks are Realistic Threats to AI Agents"
- <https://thehackernews.com/2026/07/new-agent-data-injection-attack-can.html> — reporting on tested systems and real-world attack examples

# See also

- [Indirect prompt injection in document pipelines](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md)
