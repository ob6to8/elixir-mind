---
id: em:038169
type: reference
title: "Claude API tool use — client tools, server tools, and the tool_use round trip"
description: Tool use on the Messages API splits by where code executes — client tools return a tool_use block your application must execute and answer with tool_result, while server tools run on Anthropic's infrastructure and return results inline.
resource: https://platform.claude.com/docs/en/build-with-claude/tool-use/overview
provenance: "Anthropic Claude API documentation — Tool use overview"
tags: [anthropic, claude-api, tool-use, messages-api, agents, json-schema, cca]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "filling the Claude API pillar gap for the Claude Certified Architect study program; the brain had no filed knowledge of the API surface at all"
---

# Claude API tool use

Tool use lets Claude call functions you define or that Anthropic provides.
Claude decides when to call one based on the request and the tool's
**description** — which is why the description, not the schema, is the primary
steering surface.

## The axis that organizes everything: where the code runs

> "Tools differ primarily by where the code executes."

| | Client tools | Server tools |
|---|---|---|
| Executes on | your application | Anthropic's infrastructure |
| You handle | the full round trip | nothing |
| Examples | your own tools; `bash`, `text_editor`, `memory`, `computer` (Anthropic-schema) | `web_search`, `web_fetch`, `code_execution`, `tool_search`, `advisor` |
| Response | `stop_reason: "tool_use"` + `tool_use` block(s) | results returned inline |

**Anthropic-schema client tools** are the category people miss: Anthropic
publishes the schema and trains Claude on it, but *your* application still
executes the call and returns the `tool_result`. Publishing the schema is not
the same as running the code.

## The round trip

1. Request carries `tools` — each with `name`, `description`, `input_schema`
   (JSON Schema).
2. Claude responds with `stop_reason: "tool_use"` and one or more `tool_use`
   blocks, each with an `id`, `name`, and `input`.
3. Your code executes the operation.
4. A second request appends the assistant message, then a user message
   containing a `tool_result` block keyed by `tool_use_id`.
5. Claude answers using the result.

```json
{
  "name": "get_weather",
  "description": "Get the current weather for a given location.",
  "input_schema": {
    "type": "object",
    "properties": {
      "location": {"type": "string", "description": "City and state, e.g. San Francisco, CA"}
    },
    "required": ["location"]
  }
}
```

The SDKs' **Tool Runner** performs this loop for you, and the Agent SDK subsumes
it entirely.

## Controlling when tools fire

The default is `tool_choice: {"type": "auto"}` — Claude decides per turn. The
docs describe the boundary as *steerable by system prompt*, with a graded
effect: `"Use the tools to investigate before responding."` increases tool use;
`"Always call a tool first before responding."` pushes harder; `"Use your
judgment about whether to call a tool or respond directly."` keeps it
conservative. To *require* a call rather than nudge, set `tool_choice`
explicitly.

`disable_parallel_tool_use: true` caps a turn at one tool call. `strict: true`
on a custom tool guarantees calls conform exactly to your schema.

## Missing required parameters

Model-dependent behavior worth knowing: given a required parameter the prompt
does not supply, "Claude Opus is much more likely to recognize that a parameter
is missing and ask for it", whereas Sonnet "might also infer a reasonable
value" — i.e. silently invent one. Not guaranteed either way, and less reliable
on more ambiguous prompts and weaker models. The architectural implication is
that required-parameter validation belongs in your executor, not in the prompt.

## Pricing shape

Tool use is billed as ordinary input/output tokens plus, for server tools,
usage-based charges. The additional tokens come from the `tools` parameter
itself (names, descriptions, schemas), the `tool_use` blocks, and the
`tool_result` blocks. Supplying `tools` also injects a special system prompt —
for Claude Opus 5, 286 tokens under `auto`/`none` and 406 under `any`/`tool`.

That is the concrete cost of a large tool surface: every tool's description is
re-sent on every request. It is the pressure the `tool_search` server tool
exists to relieve.

# Citations

- [Tool use with Claude](https://platform.claude.com/docs/en/build-with-claude/tool-use/overview)

# See also

- [MCP tools primitive](/knowledge/SWE/agentic/mcp/mcp-tools-primitive.md)
- [Claude Agent SDK overview](/knowledge/SWE/agentic/anthropic/claude-code-sdk/claude-agent-sdk-overview.md)
