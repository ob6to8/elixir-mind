# Claude API

Anthropic's developer API — the Messages API and the tool-use surface built on
it. The layer beneath the
[Agent SDK](/knowledge/SWE/agentic/anthropic/claude-code-sdk/index.md): the SDK
runs the tool loop this API expects you to write yourself.

## Notes

- [Claude API tool use — client tools, server tools, and the tool_use round trip](/knowledge/SWE/agentic/anthropic/claude-api/claude-api-tool-use.md) — tools split by where code executes: client tools return a `tool_use` block your application must execute and answer with `tool_result`, while server tools run on Anthropic's infrastructure and return inline. Covers `tool_choice`, strict tool use, and the per-request token cost of a large tool surface.
