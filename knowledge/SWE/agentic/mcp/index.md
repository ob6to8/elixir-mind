# Model Context Protocol (MCP)

The open protocol Anthropic originated for connecting agents to external context
and capabilities — a stateful JSON-RPC session protocol with a client-host-server
architecture. Distinct from the
[Anthropic product surfaces](/knowledge/SWE/agentic/anthropic/index.md) that
consume it: MCP is the standard, not a vendor feature.

## Notes

- [MCP architecture — the client-host-server model and capability negotiation](/knowledge/SWE/agentic/mcp/mcp-architecture.md) — one host runs many clients, each holding a 1:1 session with a server; the host enforces the security boundary, and servers can neither read the whole conversation nor see each other. Capability negotiation at initialization determines what the session may do. **Superseded** by the stateless 2026-07-28 revision below.
- [The MCP tools primitive — discovery, invocation, schemas, and the trust rules](/knowledge/SWE/agentic/mcp/mcp-tools-primitive.md) — `tools/list` and `tools/call`, the Tool definition schema, structured vs unstructured results, and the distinction between protocol errors and in-band `isError` execution errors the model can recover from.
- [The MCP 2026-07-28 specification — stateless core and OAuth hardening](/knowledge/SWE/agentic/mcp/mcp-spec-2026-07-28.md) — drops the stateful session handshake for self-contained request/response calls, replaces server-initiated mid-call requests with poll-based Multi Round-Trip Requests, and hardens authorization to RFC 9207 issuer validation and Client ID Metadata Documents.

## See also

- [Model Context Protocol (glossary)](/beliefs/glossary/model-context-protocol.md) — the term itself
- [Claude API tool use](/knowledge/SWE/agentic/anthropic/claude-api/claude-api-tool-use.md) — the vendor-side tool surface MCP tools are exposed through
