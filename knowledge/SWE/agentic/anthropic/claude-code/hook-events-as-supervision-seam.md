---
id: em:8a9ed7
type: reference
title: "Claude Code hook events as the agent-supervision seam"
description: The hook surface that lets an external supervisor observe, pace, gate, and amend an agent's tool calls — PreToolUse blocking with allow/deny/ask/defer, tool-input rewriting, context injection back into the model, and the lifecycle events around them.
resource: https://code.claude.com/docs/en/hooks
provenance: "Distilled from the official Claude Code hooks reference at code.claude.com/docs/en/hooks, fetched 2026-07-30; field names and timeouts quoted verbatim from that page"
tags: [claude-code, hooks, supervision, agentic, human-in-the-loop, anthropic]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T05:48:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research session on agent supervision tooling"
  why: "the hook surface is the interface any external agent supervisor binds to, and its blocking semantics were the decisive finding for the agent-pairing design"
---

# Claude Code hook events as the agent-supervision seam

Claude Code's hook system is a general-purpose supervision interface, not only a
guardrail mechanism. Because `PreToolUse` fires **before** a tool call and is
**synchronous and blocking by default with a 600-second timeout**, an external
process can hold an agent mid-action for up to ten minutes while a human
decides — which makes human-paced supervision of a running agent a
configuration problem rather than a harness-modification problem.

## The event surface

| Group | Events |
|---|---|
| Session | `SessionStart`, `Setup`, `SessionEnd` |
| Per-turn | `UserPromptSubmit`, `UserPromptExpansion`, `Stop`, `StopFailure` |
| Tool execution | `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `PermissionRequest`, `PermissionDenied`, `PostToolBatch` |
| Subagents & tasks | `SubagentStart`, `SubagentStop`, `TaskCreated`, `TaskCompleted`, `TeammateIdle` |
| Async / reactive | `WorktreeCreate`, `WorktreeRemove`, `Notification`, `ConfigChange`, `InstructionsLoaded`, `CwdChanged`, `FileChanged`, `PreCompact`, `PostCompact` |
| MCP elicitation | `Elicitation`, `ElicitationResult` |
| Display | `MessageDisplay` |

## PreToolUse: the decision point

The docs state plainly: *"PreToolUse: Before a tool call executes. Can block
it"*. The hook returns JSON on stdout:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Human-readable explanation",
    "updatedInput": { "command": "npm run lint" },
    "additionalContext": "Context for Claude"
  }
}
```

Four capabilities matter for supervision:

- **`permissionDecision`** takes `allow`, `deny`, `ask`, or `defer` (`defer`
  lets the normal permission flow apply). Exit code 2 is the shell equivalent of
  a block, with stderr as the reason.
- **`updatedInput` rewrites the tool arguments before execution.** A supervisor
  can therefore amend an agent's edit rather than only accept or reject it —
  the navigator correcting the driver's keystroke before it lands.
- **`permissionDecisionReason` and `additionalContext` carry free text back into
  the model's context**, so a human's correction enters the agent's reasoning
  through the same call it gated.
- **The block is the pacing primitive.** Holding the return value holds the
  agent, bounded by the timeout.

## Execution model

Hooks block by default; `"async": true` runs one in the background, and
`"asyncRewake": true` runs it in the background and wakes Claude on exit code 2.
All matching hooks run in parallel and are deduplicated.

Timeouts: 600 seconds for `command`, `http`, and `mcp_tool` hooks; 30 for
`prompt` hooks and 60 for `agent` hooks. `UserPromptSubmit` lowers the
command/http/mcp default to **30 seconds**, and `MessageDisplay` lowers it to
**10** — the display path is deliberately kept tight. `SessionEnd` shares a
1.5-second budget across all hooks.

Universal output fields available to every event: `continue`, `suppressOutput`,
`systemMessage`, `terminalSequence`, `additionalContext`.

Decision fields vary by event: `PreToolUse` uses
`hookSpecificOutput.permissionDecision`; `PermissionRequest` uses
`hookSpecificOutput.decision.behavior` (allow/deny); `UserPromptSubmit`, `Stop`,
and `SubagentStop` use a top-level `decision: "block"` with `reason`;
`PermissionDenied` uses `hookSpecificOutput.retry: true`.

## Why this is the seam

A supervisor built on these events needs no harness modification and no
screen-scraping: `PreToolUse` supplies pre-action intent (which file, what
edit), `PostToolUse`/`PostToolBatch`/`FileChanged` supply completion,
`MessageDisplay` supplies the agent's narration, and the subagent and task
events supply fleet state. What the surface does **not** supply is a semantic
unit boundary (pacing is per tool call, not per logical change), structured
*intent* as opposed to structured action (the reasoning arrives as prose on the
display path), or a rollback checkpoint. Those gaps sit with the supervisor to
close.

The interface is Claude Code-specific; an equivalent supervisor for another
harness needs that harness's own event surface.

# Citations

- [Claude Code hooks reference](https://code.claude.com/docs/en/hooks)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:8a9ed7">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-30-neovim-adoption-and-the-agent-pairing-project (2026-07-30)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:8a9ed7`]**

The harness seam, with the field names from the hooks reference: `PreToolUse` fires before the call and is synchronous and blocking by default with a 600-second timeout; `permissionDecision` takes allow/deny/ask/defer; `permissionDecisionReason` and `additionalContext` carry text back into the model; and `updatedInput` rewrites the tool arguments — so the navigator can correct the driver's keystroke *before it happens*. What the harness genuinely lacks: no semantic unit boundary, no structured intent (only structured action), no cheap rollback checkpoint, no standard event schema across agents.
