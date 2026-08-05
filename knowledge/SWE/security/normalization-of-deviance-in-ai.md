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

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:b2676a">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-05-reading-list-batch-intake (2026-08-05)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:b2676a`]**  (co-feeds: `em:cdd51c em:79c1a1 em:45adfd em:f9f0d5 em:41ab78 em:86f6df em:d146ff em:d27de7 em:563b18 em:fab63b em:134093 knowledge/SWE/performance/index.md`)

**What I created**

| Doc | Type | Why this type |
|---|---|---|
| [Normalization of Deviance in AI](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/security/normalization-of-deviance-in-ai.md) | reference | captured external analysis |
| [Claude Fable is relentlessly proactive](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/anthropic/claude-code/fable-is-relentlessly-proactive.md) | reference | captured external analysis |
| [Proofreader prompt](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/prompt-design/proofreader-prompt-pattern.md) | snippet | a reusable prompt template, not a distilled argument |
| [LLM — multi-provider CLI/library](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/dev-tools/llm-cli-tool.md) | reference | product docs + its 0.32 release notes, combined |
| [OpenAI's accidental cyberattack against Hugging Face](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/security/openai-cyberattack-huggingface.md) | reference | captured external analysis |
| [Profiling Rust NIFs in Elixir](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/performance/profiling-rust-nifs-in-elixir.md) | reference | captured how-to writeup |
| [Litestream](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/dev-tools/litestream.md) | reference | promoted from the survey/bookmarks tier |
| [Model-Based Agentic Software Engineering (MAGE) — framework overview](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/governance/model-based-agentic-software-engineering-mage.md) | reference | whole-framework granularity beside the existing chapter capture |
| [METR's AI Productivity Study is Really Good](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/expertise/metr-ai-productivity-study-is-really-good.md) | reference | captured external analysis |
| [Analysis of vibecoded outputs (MostAwesomeDude)](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/expertise/vibecoded-outputs-analysis-mostawesomedude.md) | reference | captured external analysis |
| [UML — introduction](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/software-design/unified-modeling-language-introduction.md) | reference | encyclopedia-style capture |
| [Jido Assembly — a Slack clone](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/frameworks/jido-assembly-slack-clone.md) | reference | captured case study |

Plus `knowledge/SWE/performance/index.md` for the new subdirectory, and every touched directory's `index.md` (`security`, `claude-code`, `prompt-design`, `dev-tools`, `governance`, `expertise`, `software-design`, `frameworks`, top-level `SWE`).
