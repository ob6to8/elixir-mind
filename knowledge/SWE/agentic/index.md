# Agentic

Working with AI agents — the tools, their runtimes, the vendors that build them,
and the practices they change.

## Subdirectories

- [action-verification](/knowledge/SWE/agentic/action-verification/index.md) — confirming an agent's state-changing actions actually landed in the target system: read-backs, receipts, reconciliation, and why traces and evals cannot detect a silent no-op
- [adoption](/knowledge/SWE/agentic/adoption/index.md) — how organizations adopt agentic coding: maturity models, rollout stages, bottlenecks, and guardrails
- [agent-memory](/knowledge/SWE/agentic/agent-memory/index.md) — how agents persist and reuse experience across sessions: memory architectures, experience graphs, structured vs. raw-trajectory memory
- [agentic-loop](/knowledge/SWE/agentic/agentic-loop/index.md) — the core execution loop of an LLM agent (reason→act→observe) and the "loop engineering" lexicon around it
- [anthropic](/knowledge/SWE/agentic/anthropic/index.md) — Anthropic's products: Claude, Claude Code, the Agent SDK, and managed agents
- [architecture](/knowledge/SWE/agentic/architecture/index.md) — how agents shape software architecture: the structural decisions they make while building, and the review practices proposed to govern them
- [code-context](/knowledge/SWE/agentic/code-context/index.md) — tools that build and serve structured codebase context (knowledge graphs, indexes) to coding agents
- [code-quality](/knowledge/SWE/agentic/code-quality/index.md) — maintaining code quality and craft under AI-assisted development: guardrails, review layering, and feedback loops against quality drift
- [context-engineering](/knowledge/SWE/agentic/context-engineering/index.md) — structuring, curating, and managing LLM conversation/agent context
- [editor-integration](/knowledge/SWE/agentic/editor-integration/index.md) — how coding agents connect to the editor a developer already uses: protocols, plugin ecosystems, and how deeply an agent can reach into a live session
- [failure-modes](/knowledge/SWE/agentic/failure-modes/index.md) — operational failure modes of LLM agents and their relation to documented human cognitive biases: the mapping's uses and limits, premise-retraction persistence, and the evidence for where mirrored biases come from
- [frameworks](/knowledge/SWE/agentic/frameworks/index.md) — libraries for building and orchestrating agents
- [governance](/knowledge/SWE/agentic/governance/index.md) — enforcement mechanisms for agent-produced work: typed models as the binding layer between prose and code, checking properties at the abstraction level where they're legible
- [mcp](/knowledge/SWE/agentic/mcp/index.md) — the Model Context Protocol: the open client-host-server standard for connecting agents to external context and capabilities
- [multi-model](/knowledge/SWE/agentic/multi-model/index.md) — working across multiple model providers in coding-agent workflows: escaping single-provider lock-in while keeping the dev ergonomics
- [prompt-design](/knowledge/SWE/agentic/prompt-design/index.md) — approaches and research for effective prompt engineering in agentic systems
- [provenance](/knowledge/SWE/agentic/provenance/index.md) — trust and provenance layers for content moving through multi-agent pipelines: grading transmitters, chain trust, and corroboration
- [skill-optimization](/knowledge/SWE/agentic/skill-optimization/index.md) — optimizing an agent's instruction/skill file against a score rather than authoring it by judgment: text-space optimizers, edit budgets, and held-out gates
- [supervision](/knowledge/SWE/agentic/supervision/index.md) — how a human stays in the loop over agent work: the postures available, the consoles built for them, and what makes agent activity legible enough to act on
- [supply-chain-security](/knowledge/SWE/agentic/supply-chain-security/index.md) — trust and governance risk in the agentic-AI dependency supply chain
- [workflow-decomposition](/knowledge/SWE/agentic/workflow-decomposition/index.md) — when an LLM-powered workflow should stay in one probabilistic call versus decompose into deterministic parsers, rules, classifiers, and classical ML
