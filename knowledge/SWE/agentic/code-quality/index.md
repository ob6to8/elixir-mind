# Code quality

Maintaining code quality and craft under AI-assisted development — the guardrails,
review layering, and feedback loops that hold a project to its author's standards
as agents generate more of its code.

## Documents

- [Why TDD works so well in AI-assisted programming (Jason Gorman)](/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md) — TDD's small-steps discipline mapped one-to-one onto LLM failure modes (effective context far below advertised limits, broken code polluting later predictions, examples beating descriptions), making red-green-refactor the control loop that keeps an agent close to working code. `em:e7644d` _(reference)_
- [Getting good results from Claude Code (Chris Dzombak, 2025-08) — and how it aged](/knowledge/SWE/agentic/code-quality/getting-good-results-from-claude-code.md) — the fourteen-practice agentic-coding playbook (spec first, staged plans, TDD, incremental compiling commits, three-attempt stop, never weakening tests, full human review), assessed a year on: four practices became product features, nine remain valid user-side discipline, and the fat global CLAUDE.md aged out. `em:49315a` _(reference)_
- [Guarding Against AI Drift (Mike Zornek)](/knowledge/SWE/agentic/code-quality/guarding-against-ai-drift.md) — a solo-developer's two-layer playbook against AI quality drift: automated Elixir guardrails (compile/format/lint/security/workflow checks) for the mechanical, plus deliberately non-delegated layered human review, with recurring misses promoted into the standards docs the agent reads.
- [Elixir coding conventions (Zornek's LocalCents standards)](/knowledge/SWE/agentic/code-quality/elixir-coding-conventions-localcents.md) — the transferable Elixir/typespec/documentation conventions from LocalCents' CODING_STANDARDS.md (the very agent-read standards doc the AI-drift feedback loop feeds), foregrounding the `@spec` argument-naming and layout rules.
