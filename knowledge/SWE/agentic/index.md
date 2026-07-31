# Agentic

Working with AI agents — the tools, their runtimes, the vendors that build them,
and the practices they change.

## Subdirectories

- [adoption](/knowledge/SWE/agentic/adoption/index.md) — how organizations adopt agentic coding: maturity models, rollout stages, bottlenecks, and guardrails
- [agent-memory](/knowledge/SWE/agentic/agent-memory/index.md) — how agents persist and reuse experience across sessions: memory architectures, experience graphs, structured vs. raw-trajectory memory
- [agentic-loop](/knowledge/SWE/agentic/agentic-loop/index.md) — the core execution loop of an LLM agent (reason→act→observe) and the "loop engineering" lexicon around it
- [anthropic](/knowledge/SWE/agentic/anthropic/index.md) — Anthropic's products: Claude, Claude Code, the Agent SDK, and managed agents
- [code-context](/knowledge/SWE/agentic/code-context/index.md) — tools that build and serve structured codebase context (knowledge graphs, indexes) to coding agents
- [code-quality](/knowledge/SWE/agentic/code-quality/index.md) — maintaining code quality and craft under AI-assisted development: guardrails, review layering, and feedback loops against quality drift
- [context-engineering](/knowledge/SWE/agentic/context-engineering/index.md) — structuring, curating, and managing LLM conversation/agent context
- [editor-integration](/knowledge/SWE/agentic/editor-integration/index.md) — how coding agents connect to the editor a developer already uses: protocols, plugin ecosystems, and how deeply an agent can reach into a live session
- [frameworks](/knowledge/SWE/agentic/frameworks/index.md) — libraries for building and orchestrating agents
- [governance](/knowledge/SWE/agentic/governance/index.md) — enforcement mechanisms for agent-produced work: typed models as the binding layer between prose and code, checking properties at the abstraction level where they're legible
- [mcp](/knowledge/SWE/agentic/mcp/index.md) — the Model Context Protocol: the open client-host-server standard for connecting agents to external context and capabilities
- [multi-model](/knowledge/SWE/agentic/multi-model/index.md) — working across multiple model providers in coding-agent workflows: escaping single-provider lock-in while keeping the dev ergonomics
- [provenance](/knowledge/SWE/agentic/provenance/index.md) — trust and provenance layers for content moving through multi-agent pipelines: grading transmitters, chain trust, and corroboration
- [supervision](/knowledge/SWE/agentic/supervision/index.md) — how a human stays in the loop over agent work: the postures available, the consoles built for them, and what makes agent activity legible enough to act on
- [supply-chain-security](/knowledge/SWE/agentic/supply-chain-security/index.md) — trust and governance risk in the agentic-AI dependency supply chain
