# Agent frameworks

Libraries and frameworks for building AI agents — orchestration, middleware, and
state management, as distinct from the loop theory in
[agentic-loop](/knowledge/SWE/agentic/agentic-loop/index.md).

## References

- [Archestra — open-source enterprise AI platform](/knowledge/SWE/agentic/frameworks/archestra-open-source-enterprise-ai-platform.md) — AGPL self-hosted platform bundling an LLM gateway, an MCP gateway with OAuth on-behalf-of, a sandboxed agent runtime, Dual-LLM and Lethal-Trifecta guardrails, SSO/RBAC, and OpenTelemetry. `em:1b6814` _(reference)_
- [GitLord — git as the storage engine for agent orchestration](/knowledge/SWE/agentic/frameworks/gitlord-git-backed-agent-orchestration.md) — sessions/subagents as branches, turns as commits, rewind as checkout, and a derived (never authoritative) vector index over the log. `em:31e85b` _(reference)_
- [sagents — agent orchestration framework for Elixir (built on LangChain)](/knowledge/SWE/agentic/frameworks/sagents-elixir-agent-orchestration.md) — AgentServer, middleware, and state management on top of Elixir LangChain. `em:eeb2bb` _(reference)_
- [Caveman — AI agent output compression](/knowledge/SWE/agentic/frameworks/caveman-agent-output-compression.md) — multi-platform plugin for AI coding agents that reduces output tokens by ~65% through terse communication while preserving code correctness. `em:b4e21d` _(reference)_
- [Jido Assembly — a Slack clone built with Jido and Hologram](/knowledge/SWE/agentic/frameworks/jido-assembly-slack-clone.md) — a multi-user chat app where people and AI agents post through the same Jido Messaging/Signal persistence and routing, with Hologram compiling the browser UI's Elixir to JavaScript instead of a live socket.
