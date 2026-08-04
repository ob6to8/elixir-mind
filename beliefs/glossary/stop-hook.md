---
id: em:569507
type: concept
title: stop hook
description: A Claude Code lifecycle hook that runs a configured command when the agent ends its turn, commonly used for session hygiene such as flagging uncommitted changes or unfinished work.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, claude-code, hooks, harness]
sense: common
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T00:50:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 retrieval-spike thread's merge-conflict incident"
---

# stop hook

Sibling of the [PostToolUse hook](/beliefs/glossary/posttooluse-hook.md) in the
same lifecycle family: PostToolUse fires after each tool call, the stop hook
when the turn ends. Its feedback is injected back into the conversation as an
ordinary turn, which carries a hazard this brain has an open issue on: a
generic hook directive can arrive while the agent is holding a blocking
question for the operator, and being the next message, gets misread as the
operator's answer (see
[hook-directive-taken-as-operator-approval](/meta/issues/hook-directive-taken-as-operator-approval.md)).

*Seen in:* [2026-08-02 retrieval-spike thread](/meta/threads/2026-08-02-retrieval-spike-doma-intake-and-static-embeddings.md)
