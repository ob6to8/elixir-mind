---
id: em:0836b3
type: concept
title: PreToolUse hook
description: A Claude Code lifecycle hook that fires before a tool call executes and can allow, deny, defer, or escalate it — and can rewrite the call's arguments or inject context into the model — making it the interception point for external supervision of a running agent.
provenance: "Agent-distilled glossary definition, grounded in the official Claude Code hooks reference"
verified: false
tags: [glossary, claude-code, hooks, agents, supervision]
sense: common
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T06:07:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-30 agent-pairing session as the decisive supervision primitive"
---

# PreToolUse hook

The sibling of the [PostToolUse hook](/beliefs/glossary/posttooluse-hook.md),
and the more powerful of the two for supervision, because it runs while the
action is still preventable. It returns `hookSpecificOutput.permissionDecision`
with one of `allow`, `deny`, `ask`, or `defer`; `updatedInput` to rewrite the
tool's arguments; and `permissionDecisionReason` or `additionalContext` to put
text into the model's next inference.

Its second, less obvious property is **temporal**: hooks are synchronous and
blocking by default with a 600-second timeout, so holding the return value holds
the agent. That converts the hook from a guardrail into a pacing primitive — the
mechanism by which a human can supervise an agent at the speed they read rather
than the speed it types. Details and the full event surface are in
[hook events as the agent-supervision seam](/knowledge/SWE/agentic/anthropic/claude-code/hook-events-as-supervision-seam.md).

*Seen in:* [hook events as the agent-supervision seam](/knowledge/SWE/agentic/anthropic/claude-code/hook-events-as-supervision-seam.md), [agent pairing architecture](/projects/agent-pairing/architecture-and-build-order.md)
