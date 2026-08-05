---
id: em:b2676a
type: reference
title: "The Normalization of Deviance in AI (wunderwuzzi)"
description: Vendors and adopters are repeating the Challenger-disaster pattern of normalizing deviance — treating each successful run of an insecure agentic setup as proof of safety, so oversight erodes exactly as agent capability (and the cost of a miss) rises.
resource: https://embracethered.com/blog/posts/2025/the-normalization-of-deviance-in-ai/
provenance: "wunderwuzzi, Embrace The Red blog, published 2025-12-04"
tags: [agentic-security, organizational-risk, normalization-of-deviance, threat-modeling, human-oversight, sandboxing]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# The Normalization of Deviance in AI

wunderwuzzi applies sociologist Diane Vaughan's concept from the Space Shuttle
*Challenger* investigation to agentic AI deployment. **Normalization of
deviance** is "the process in which deviance from correct or proper behavior
or rule becomes culturally normalized" — each near-miss that doesn't cause
visible harm is read as evidence the risky practice is fine, rather than as a
warning, and the guardrail erodes a little further next time.

## The pattern in AI

Vendors and organizations "lower their guard or skip human oversight
entirely, because 'it worked last time.'" The result is a false sense of
security: "organizations confuse the absence of a successful attack with the
presence of robust security." Major vendors (Microsoft, OpenAI, Anthropic,
Google) openly acknowledge agentic risks — data exfiltration, prompt
injection, unintended actions — yet keep shipping agentic features faster
than the guardrails around them mature, because competitive pressure to ship
first outweighs the incentive to invest in security first.

## The structural claim

The article's operative security principle: "security controls (access
checks, proper encoding, and sanitization, etc.) must be applied downstream
of LLM output" — the model's output is never itself a trust boundary, however
well-behaved it has appeared so far. Agentic systems that skip this and let
model output act with ambient privilege are exactly the deviance the piece
names: each unchecked run that doesn't misfire normalizes the gap a little
further.

## Recommendation

The article argues AI systems should stay "human-led, particularly in
high-stake contexts," backed by real threat modeling, sandboxing, and
least-privilege access — not by hoping "the model will just do the right
thing." This is the same erosion-of-oversight shape as
[Ambient agent observability](/knowledge/SWE/agentic/supervision/ambient-agent-observability.md)
describes from the supervision side, and the downstream-of-output principle
matches
[Indirect prompt injection in document pipelines](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md):
both treat model output as attacker-influenced input to the next system, not
as a trusted instruction source.

# Citations

- Source: <https://embracethered.com/blog/posts/2025/the-normalization-of-deviance-in-ai/>
