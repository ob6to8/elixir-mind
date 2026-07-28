---
id: em:3b0352
type: reference
title: "The MCP tools primitive — discovery, invocation, schemas, and the trust rules"
description: MCP tools are model-controlled capabilities discovered via tools/list and invoked via tools/call, defined by a JSON Schema input contract and optional output schema, with execution errors reported in-band as isError rather than as protocol errors.
resource: https://modelcontextprotocol.io/specification/2025-06-18/server/tools
provenance: "Model Context Protocol specification, revision 2025-06-18 — Server/Tools page"
tags: [mcp, model-context-protocol, tools, json-schema, tool-design, security, cca]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "filling the MCP pillar gap for the Claude Certified Architect study program; tool design is the part of MCP an architect is most often asked to get right"
---

# The MCP tools primitive

> **Revision captured: 2025-06-18.** The current specification revision is
> **2025-11-25**; dated revision paths stay live indefinitely, so this capture
> does not become invalid, but it may lag. Re-verify against the current
> revision before relying on normative detail — see
> [the source-surface map](/meta/analysis/anthropic-primary-source-surfaces.md).

Tools are the MCP primitive that lets a model act. The spec frames them as
**model-controlled**:

> "Tools in MCP are designed to be **model-controlled**, meaning that the
> language model can discover and invoke tools automatically based on its
> contextual understanding and the user's prompts."

The protocol deliberately does not mandate a UI, but it is emphatic about the
human:

> "For trust & safety and security, there **SHOULD** always be a human in the
> loop with the ability to deny tool invocations."

A server supporting tools **MUST** declare the `tools` capability; the
`listChanged` flag inside it indicates whether the server will emit
`notifications/tools/list_changed` when its tool list changes.

## The two messages

| Message | Direction | Purpose |
|---|---|---|
| `tools/list` | client → server | discover available tools; supports cursor pagination |
| `tools/call` | client → server | invoke a tool by `name` with an `arguments` object |
| `notifications/tools/list_changed` | server → client | signal that the tool list changed (requires `listChanged`) |

## The Tool definition

| Field | Required | Holds |
|---|---|---|
| `name` | yes | unique identifier |
| `title` | no | human-readable display name |
| `description` | yes in practice | what the tool does — this is what the model reads to decide |
| `inputSchema` | yes | JSON Schema for the expected parameters |
| `outputSchema` | no | JSON Schema for structured results |
| `annotations` | no | optional properties describing tool behavior |

Annotations carry a specific warning:

> "For trust & safety and security, clients **MUST** consider tool annotations
> to be untrusted unless they come from trusted servers."

That is, a server claiming its tool is read-only or idempotent is *asserting*,
not proving. Annotations inform UI and heuristics; they are not a security
control.

## Results: unstructured, structured, and the compatibility rule

Unstructured results go in `content[]` and may mix text, image, audio, resource
links, and embedded resources. Structured results go in `structuredContent` as a
JSON object.

If an `outputSchema` is provided, "Servers **MUST** provide structured results
that conform to this schema" and "Clients **SHOULD** validate structured results
against this schema."

Two details that catch people out:

- **Backwards compatibility:** a tool returning structured content SHOULD *also*
  return the serialized JSON in a text content block. Both fields get populated.
- **`structuredContent` is not "structured outputs".** The spec is explicit that
  it "is server-produced result data and is unrelated to LLM 'structured
  outputs' (schema-constrained model generation)."

## Error handling — the distinction that matters

Two mechanisms, and choosing wrongly breaks the agent loop:

| Kind | Mechanism | Use for |
|---|---|---|
| **Protocol errors** | standard JSON-RPC `error` | unknown tool, invalid arguments, server faults |
| **Tool execution errors** | successful result with `isError: true` | API failures, invalid input data, business-logic errors |

The reason execution errors are reported *in-band* is that the model needs to
see them. A JSON-RPC error is a transport-level failure the client handles; an
`isError: true` result is content the model can read and recover from — retry
with different arguments, or explain the failure to the user. Reporting a
recoverable business error as a protocol error hides it from the model.

## Security obligations

The spec splits these by role.

Servers **MUST**: validate all tool inputs; implement proper access controls;
rate limit tool invocations; sanitize tool outputs.

Clients **SHOULD**: prompt for user confirmation on sensitive operations; show
tool inputs to the user before calling the server, "to avoid malicious or
accidental data exfiltration"; validate tool results before passing them to the
LLM; implement timeouts; and log tool usage for audit.

Note the asymmetry: server duties are `MUST`, client duties are `SHOULD`. The
server is the one place that cannot assume a well-behaved counterparty.

# Citations

- [MCP specification 2025-06-18 — Tools](https://modelcontextprotocol.io/specification/2025-06-18/server/tools)

# See also

- [MCP architecture](/knowledge/SWE/agentic/mcp/mcp-architecture.md)
- [Claude API tool use](/knowledge/SWE/agentic/anthropic/claude-api/claude-api-tool-use.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:3b0352">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-cca-study-program-and-the-primary-source-miss (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:3b0352`]**  (co-feeds: `em:121acc em:b4a91a em:038169 em:53f32a`)

That changes the picture materially. Re-keyed to Anthropic's own scope statement, the brain is far thinner than my earlier figure suggested — **that 42% was keyed to the third-party blueprint and to conceptual overlap, and it overstated readiness.** The real position:

| Anthropic-named pillar | Filed knowledge | Verdict |
|---|---|---|
| Claude Code | 8 docs in its dir (mostly cloud-env sources); ambient mentions everywhere | thin on configuration specifics |
| Claude Agent SDK | **0 docs** in its dir, 11 passing mentions | near-empty |
| Claude API | **~0** — no filed knowledge on the API surface | empty |
| MCP | no dedicated dir, 25 incidental mentions | near-empty |

The brain is strong on agentic *concepts* and near-empty on the four *product surfaces* the exam actually names. That makes your ordering (gaps first) clearly right. Rewriting the plan against primary-sourced structure:
