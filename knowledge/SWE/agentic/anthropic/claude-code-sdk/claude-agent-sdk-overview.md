---
id: em:b4a91a
type: reference
title: "Claude Agent SDK — Claude Code as a library"
description: The Agent SDK exposes Claude Code's own agent loop, built-in tools, and context management as a Python and TypeScript library, so the tool-execution loop you would otherwise hand-write against the Messages API is handled for you.
resource: https://code.claude.com/docs/en/agent-sdk/overview
provenance: "Anthropic Claude Code documentation — Agent SDK overview"
tags: [anthropic, agent-sdk, claude-code, agents, sdk, hooks, subagents, mcp, cca]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "filling the Agent SDK pillar gap for the Claude Certified Architect study program; the SDK is one of the four technologies Anthropic names as exam scope"
---

# Claude Agent SDK

The [Agent SDK](/beliefs/glossary/claude-agent-sdk.md) is Claude Code packaged as
a library:

> "The Agent SDK gives you the same tools, agent loop, and context management
> that power Claude Code, programmable in Python and TypeScript."

For other languages, the documented path is to run the CLI programmatically in
headless mode (`-p` with `--output-format json`) rather than reimplementing the
loop. Both language packages **bundle a native Claude Code binary**, so Claude
Code need not be installed separately. Python requires 3.10 or later.

The entry point is a single streaming call — `query(prompt, options)` — that
yields messages as the agent works.

## The distinction that defines it

The clearest way to place the SDK is against the plain API client:

> "With the Client SDK, you implement a tool loop. With the Agent SDK, Claude
> handles it."

```
Client SDK  →  you write:  while stop_reason == "tool_use": execute, resend
Agent SDK   →  you write:  async for message in query(prompt=...)
```

This is the single most load-bearing fact about the SDK: it is not a thinner
wrapper over the Messages API, it is the *harness* — loop, tool execution,
context management, and permissions included.

## Capabilities

| Capability | What it gives you |
|---|---|
| **Built-in tools** | `Read`, `Write`, `Edit`, `Bash`, `Glob`, `Grep`, `WebSearch`, `WebFetch`, `Monitor`, `AskUserQuestion` and more — no tool-execution code to write |
| **Hooks** | callbacks at lifecycle points — `PreToolUse`, `PostToolUse`, `Stop`, `SessionStart`, `SessionEnd`, `UserPromptSubmit` — to "validate, log, block, or transform agent behavior", matched by tool-name regex |
| **Subagents** | `agents` definitions (description, prompt, tools) spawned via the `Agent` tool; messages from a subagent carry `parent_tool_use_id` so you can attribute them |
| **MCP** | `mcp_servers` config plus `mcp__<server>__*` tool allowlisting |
| **Permissions** | `allowed_tools` pre-approves; `disallowed_tools` blocks outright; unlisted tools fall through to `permission_mode` |
| **Sessions** | capture `session_id` from the `init` system message, then `resume` it later with full context; sessions can also be forked |

The permission semantics are worth stating precisely, because the three-way
split is a common exam-shaped confusion: **`allowed_tools` is pre-approval, not
an allowlist.** Tools absent from it are still available — they fall through to
the permission mode. Blocking requires `disallowed_tools`.

## Filesystem configuration

The SDK also loads Claude Code's file-based configuration from `.claude/` in the
working directory and `~/.claude/`, restrictable via `setting_sources` /
`settingSources`:

| Feature | Location |
|---|---|
| Skills | `.claude/skills/*/SKILL.md` |
| Commands (legacy format; skills preferred for new work) | `.claude/commands/*.md` |
| Memory | `CLAUDE.md` or `.claude/CLAUDE.md` |
| Plugins | programmatic, via the `plugins` option |

## Where it sits among Anthropic's agent products

| | Agent SDK | Managed Agents |
|---|---|---|
| Runs in | your process, your infrastructure | Anthropic-managed infrastructure |
| Interface | Python or TypeScript library | REST API |
| Works on | files on your infrastructure | a managed sandbox per session |
| Session state | JSONL on your filesystem | Anthropic-hosted event log |
| Custom tools | in-process functions | Claude triggers; you execute and return |

Against the **CLI**, the docs frame it as "Same capabilities, different
interface" — CLI for interactive development and one-off tasks, SDK for CI/CD,
custom applications, and production automation. The documented common path is to
prototype with the Agent SDK locally and move to Managed Agents for production.

## Authentication

`ANTHROPIC_API_KEY` by default, with third-party providers selected by
environment variable: `CLAUDE_CODE_USE_BEDROCK`, `CLAUDE_CODE_USE_ANTHROPIC_AWS`
(plus `ANTHROPIC_AWS_WORKSPACE_ID`), `CLAUDE_CODE_USE_VERTEX`, and
`CLAUDE_CODE_USE_FOUNDRY`. Anthropic does not permit third-party developers to
offer claude.ai login or rate limits for products built on the SDK, absent prior
approval.

## Branding constraint

For partners, Claude branding is optional; "Claude Agent", "Claude", and
"{YourAgentName} Powered by Claude" are permitted, while **"Claude Code" and
"Claude Code Agent" are not**, nor visual elements mimicking Claude Code.

# Citations

- [Agent SDK overview](https://code.claude.com/docs/en/agent-sdk/overview)
- [Example agents](https://github.com/anthropics/claude-agent-sdk-demos)

# See also

- [Claude Code settings and permissions](/knowledge/SWE/agentic/anthropic/claude-code/claude-code-settings-and-permissions.md)
- [Claude API tool use](/knowledge/SWE/agentic/anthropic/claude-api/claude-api-tool-use.md)
- [MCP architecture](/knowledge/SWE/agentic/mcp/mcp-architecture.md)
