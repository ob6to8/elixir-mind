---
id: em:121acc
type: reference
title: "MCP architecture — the client-host-server model and capability negotiation"
description: MCP is a stateful JSON-RPC session protocol in which one host process runs many clients, each holding a 1:1 connection to a server, with the host enforcing security boundaries and servers deliberately unable to see the whole conversation or each other.
resource: https://modelcontextprotocol.io/specification/2025-06-18/architecture
provenance: "Model Context Protocol specification, revision 2025-06-18 — Architecture page"
tags: [mcp, model-context-protocol, architecture, json-rpc, agents, protocol, cca]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "filling the MCP pillar gap for the Claude Certified Architect study program; MCP is one of the four technologies Anthropic names as exam scope"
---

# MCP architecture

> **Revision captured: 2025-06-18.** The current specification revision is
> **[2026-07-28](/knowledge/SWE/agentic/mcp/mcp-spec-2026-07-28.md)**, which replaced
> the stateful session model described below with a stateless request/response
> core; dated revision paths stay live indefinitely, so this capture does not
> become invalid, but it now describes a superseded architecture. Re-verify
> against the current revision before relying on normative detail — see
> [the source-surface map](/meta/analysis/anthropic-primary-source-surfaces.md).

The [Model Context Protocol](/beliefs/glossary/model-context-protocol.md) is
described by its own spec as a three-role architecture:

> "The Model Context Protocol (MCP) follows a client-host-server architecture
> where each host can run multiple client instances. […] Built on JSON-RPC, MCP
> provides a stateful session protocol focused on context exchange and sampling
> coordination between clients and servers."

The three roles are distinct, and conflating them is the usual source of
confusion — "MCP server" does not mean a remote service, and often is not one.

| Role | What it is | Responsibilities |
|---|---|---|
| **Host** | the application process (e.g. an agent harness) | creates and manages clients; controls connection permissions and lifecycle; enforces security policy and consent; handles user authorization; coordinates LLM sampling; aggregates context across clients |
| **Client** | one connector instance inside the host | maintains exactly one stateful session per server; performs protocol and capability negotiation; routes messages bidirectionally; manages subscriptions and notifications; maintains isolation between servers |
| **Server** | a focused capability provider, local process or remote service | exposes resources, tools, and prompts; operates independently; may request sampling through the client; must respect security constraints |

The cardinality is the part worth memorizing: **a host runs many clients, and
each client holds a 1:1 relationship with one server.** Isolation is per-client.

## Design principles

The spec states four, and the third is the one with real architectural teeth:

1. **Servers should be extremely easy to build.** The host carries the complex
   orchestration; servers implement narrow, well-defined capabilities.
2. **Servers should be highly composable.** Focused functionality in isolation,
   combined seamlessly through the shared protocol.
3. **Servers should not be able to read the whole conversation, nor "see into"
   other servers.** Servers receive only necessary contextual information; full
   conversation history stays with the host; cross-server interaction is
   controlled by the host.
4. **Features can be added progressively.** A minimal core protocol, with
   additional capabilities negotiated as needed and backwards compatibility
   maintained.

Principle 3 is a **confidentiality boundary enforced by the host**, not a
courtesy. It is why a compromised or hostile server cannot exfiltrate the
conversation, and why the host — never the server — is where consent lives.

## Capability negotiation

MCP is capability-based: clients and servers "explicitly declare their supported
features during initialization", and those declarations determine what is
available for the rest of the session.

- Servers declare capabilities such as resource subscriptions, tool support, and
  prompt templates.
- Clients declare capabilities such as sampling support and notification
  handling.
- **Both parties must respect declared capabilities throughout the session.**

Consequences the spec spells out: implemented server features must be advertised
in the server's capabilities; emitting resource-subscription notifications
requires declaring subscription support; tool invocation requires declaring tool
capabilities; and sampling requires the *client* to declare support.

The session shape that follows is: host initializes client → client initializes
session with capabilities → server responds with its supported capabilities →
active session (client requests for tools/resources, server requests for
sampling, notifications both ways) → host terminates → client ends session.

## Why the direction of "sampling" surprises people

Most traffic runs client → server (list tools, call a tool, read a resource).
**Sampling runs the other way**: the server asks the client to obtain an LLM
completion, which the client forwards to the host, which calls the model. This
lets a server use the model without holding model credentials or seeing the
conversation — a direct consequence of design principle 3.

# Citations

- [MCP specification 2025-06-18 — Architecture](https://modelcontextprotocol.io/specification/2025-06-18/architecture)

# See also

- [MCP tools primitive](/knowledge/SWE/agentic/mcp/mcp-tools-primitive.md)
- [Model Context Protocol (glossary)](/beliefs/glossary/model-context-protocol.md)
- [Remote procedure call (glossary)](/beliefs/glossary/remote-procedure-call.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:121acc">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-cca-study-program-and-the-primary-source-miss (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:121acc`]**  (co-feeds: `em:3b0352 em:b4a91a em:038169 em:53f32a`)

That changes the picture materially. Re-keyed to Anthropic's own scope statement, the brain is far thinner than my earlier figure suggested — **that 42% was keyed to the third-party blueprint and to conceptual overlap, and it overstated readiness.** The real position:

| Anthropic-named pillar | Filed knowledge | Verdict |
|---|---|---|
| Claude Code | 8 docs in its dir (mostly cloud-env sources); ambient mentions everywhere | thin on configuration specifics |
| Claude Agent SDK | **0 docs** in its dir, 11 passing mentions | near-empty |
| Claude API | **~0** — no filed knowledge on the API surface | empty |
| MCP | no dedicated dir, 25 incidental mentions | near-empty |

The brain is strong on agentic *concepts* and near-empty on the four *product surfaces* the exam actually names. That makes your ordering (gaps first) clearly right. Rewriting the plan against primary-sourced structure:
