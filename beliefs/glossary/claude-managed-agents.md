---
id: sb:04b9a8
type: concept
title: Claude Managed Agents (CMA)
description: Anthropic's hosted agent service (beta) where the agent loop runs on Anthropic's orchestration layer and each session provisions a sandboxed container for tool execution — with versioned agent configs, scheduled deployments, rubric-graded outcomes, and egress-substituted credential vaults.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, managed-agents, anthropic, agents, hosted, beam]
timestamp: 2026-07-12
---

# Claude Managed Agents (CMA)

Beta header `managed-agents-2026-04-01`; the one Anthropic surface that supplies *both* the agent harness and its deployment. An agent is a persisted config pinning model, system prompt, tools, MCP servers, and skills; a **session** mounts resources (files, GitHub repos, memory stores), runs the agent's tools (bash, file ops, code) in its container, and emits an event stream. Scheduled deployments fire sessions on a cron with audited runs; **outcomes** drive an iterate loop against their rubric; **permission policies** (`always_ask`) pause for human confirmation, alongside the **[credential vaults](/beliefs/glossary/credential-vault.md)**. Its unit of agency is always a Claude session — a heavyweight, LLM-backed worker — which fits deliberative work and misfits high-frequency mechanical work, the split the [two-plane rule](/beliefs/glossary/two-plane-rule.md) draws.

*Seen in:* [Managed Agents vs. Jido/BEAM analysis](/meta/analysis/claude-managed-agents-vs-beam-jido.md)
