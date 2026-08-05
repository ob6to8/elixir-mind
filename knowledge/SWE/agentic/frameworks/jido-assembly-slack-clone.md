---
id: em:134093
type: reference
title: "Jido Assembly — a Slack clone built with Jido and Hologram"
description: A multi-user chat application demonstrating agent-native architecture end to end — people and AI agents both post through the same Jido Messaging/Signal persistence and CloudEvents-compatible routing, with Hologram compiling the browser UI's Elixir code to JavaScript instead of a live socket.
resource: https://jido.run/blog/jido-assembly-slack-clone
provenance: "Mike Hostetler, jido.run blog; discussed at https://www.reddit.com/r/elixir/comments/1veq0pv/jido_assembly_a_slack_clone_built_with_jido_and/ (fetch blocked); fetched 2026-08-05"
tags: [jido, elixir, hologram, agent-native, otp, case-study]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# Jido Assembly

Mike Hostetler's case study on **Jido Assembly**, a multi-user chat
application — a Slack clone — built to demonstrate agent-native architecture
across the Jido ecosystem: people and AI agents participate as equals in
channels, direct messages, and threads, with reactions, mentions, search, and
presence tracking.

## Stack

- **Jido / Jido AI** — the agent runtime and LLM-backed strategies.
- **Jido Messaging** — message persistence, via a SQLite adapter.
- **Jido Signal** — CloudEvents-compatible event routing.
- **Jido Chat** — with Telegram and Discord adapters.
- **Hologram** — the browser interface, compiling Elixir directly to
  JavaScript rather than shipping a VM or a live socket (see this bundle's
  existing [Hologram](/knowledge/SWE/web-frameworks/hologram.md) capture).
- **Phoenix** — presence tracking and PubSub.
- **BEAM/Elixir/OTP** as the runtime foundation.

## What "agent-native" means here

The case study's central claim: "Agents use the same rooms, messages,
threads, and events as people." An agent's responses travel the identical
persistence and broadcast path a human message would — there is no separate
AI infrastructure bolted on beside the chat system, the agent is just another
participant writing through the same Jido Messaging/Signal pipeline.

## Architecture note

A specific design decision the case study calls out: "Hologram keeps
component state in the browser and compiles the required Elixir code to
JavaScript," which lets client-side event handling stay local while
protected operations still route through server-side Commands — splitting
UI responsiveness from the operations that need to stay server-authoritative.

# Citations

- Source: <https://jido.run/blog/jido-assembly-slack-clone>
- Discussion: <https://www.reddit.com/r/elixir/comments/1veq0pv/jido_assembly_a_slack_clone_built_with_jido_and/> (r/elixir; not independently fetched — blocked by the host)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:134093">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-05-reading-list-batch-intake (2026-08-05)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:134093`]**  (co-feeds: `em:b2676a em:cdd51c em:79c1a1 em:45adfd em:f9f0d5 em:41ab78 em:86f6df em:d146ff em:d27de7 em:563b18 em:fab63b knowledge/SWE/performance/index.md`)

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
