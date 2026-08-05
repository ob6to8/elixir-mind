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
