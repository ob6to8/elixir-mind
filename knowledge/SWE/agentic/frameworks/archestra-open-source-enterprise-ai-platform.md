---
id: em:1b6814
type: reference
title: "Archestra — open-source enterprise AI platform"
description: An AGPL-licensed self-hosted platform bundling an LLM gateway, an MCP gateway with OAuth on-behalf-of, a sandboxed agent runtime, deterministic Dual-LLM and Lethal-Trifecta guardrails, SSO/RBAC, and OpenTelemetry tracing into one deployable product.
resource: https://github.com/archestra-ai/archestra
provenance: "Distilled from the archestra-ai/archestra GitHub README, fetched 2026-07-28"
tags: [agentic, mcp, platform, open-source, enterprise, security, sandboxing, guardrails, observability]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:13:44Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pasted the repo alongside the Archestra weak-models post, as the product that practice was developed against"
---

# Archestra — open-source enterprise AI platform

Self-described as "The all-in-one open-source enterprise AI platform." The
positioning claim is that the security and observability layer is not an
add-on: "Built on a strong security and observability foundation: SSO and RBAC,
sandboxed code execution, Dual-LLM and Lethal-Trifecta guardrails,
OpenTelemetry traces, and Prometheus metrics — first-class, not bolted on."

Dual-licensed **AGPL-3.0 / Enterprise**, deployed on-premises rather than as a
managed service — the vendor runs its own instance and supports enterprise
self-hosted deployments, which is why it has no telemetry from customer
installs (a constraint that motivates the
[weak-model harness debugging practice](/knowledge/SWE/evals/debugging-agent-harnesses-on-weak-models.md)).

## Components

| Layer | What it provides |
|---|---|
| **Chat** | internal AI assistant with project and MCP-app support |
| **LLM gateway** | provider-agnostic routing — Anthropic, OpenAI, Azure, Bedrock, DeepSeek, and others |
| **MCP gateway** | [MCP](/beliefs/glossary/model-context-protocol.md) server access with OAuth and on-behalf-of delegation; a private MCP registry; a Kubernetes operator for MCP orchestration |
| **Agent runtime** | scheduled, email, and webhook triggers, with sandboxed code execution |
| **Guardrails** | deterministic Dual-LLM verification and Lethal Trifecta protections |
| **Identity** | SSO over OIDC, SAML, Okta, Entra; RBAC |
| **Observability** | OpenTelemetry traces and Prometheus metrics |
| **Knowledge** | RAG knowledge base with connectors |
| **Deployment** | Helm chart and Terraform provider |

## What is notable about it

- **The MCP gateway is the differentiating piece.** OAuth on-behalf-of means a
  tool call carries the *end user's* identity to the downstream system rather
  than a shared service credential, which is the difference between an agent
  platform that can be given production access and one that cannot. The private
  registry and Kubernetes operator make MCP servers an operated fleet rather
  than per-developer config — the deployment story the
  [MCP architecture](/knowledge/SWE/agentic/mcp/mcp-architecture.md) leaves to
  implementers.
- **The guardrails are named after specific attack shapes, not generically.**
  "Lethal Trifecta" is Simon Willison's term for an agent that simultaneously
  has access to private data, exposure to untrusted content, and the ability to
  exfiltrate — the conjunction that turns indirect prompt injection into data
  loss. Dual-LLM is the companion mitigation pattern: a privileged model that
  never sees untrusted content, driving a quarantined model that does. Building
  both in as product features is the same structural bet as the
  [secure financial agent](/projects/secure-financial-agent.md) — that what the
  agent is *permitted* to do, rather than what the model decides, is the
  security boundary.
- **It is a plausible source of harness-design evidence.** The platform's
  engineering team publishes its nightly product-level benchmark methodology,
  which is where the
  [weak-model debugging practice](/knowledge/SWE/evals/debugging-agent-harnesses-on-weak-models.md)
  comes from.

## Status

The README claims production maturity: $13.5M total funding, three Fortune-50
deployments, and a stated p95 latency of 31ms. Repository metadata at capture
time: ~4,000 stars, ~1.1k forks. These are the project's own figures, unaudited.

# Citations

- `archestra-ai/archestra` README —
  <https://github.com/archestra-ai/archestra> (fetched 2026-07-28)
