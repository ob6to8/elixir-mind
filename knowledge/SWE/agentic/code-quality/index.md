# Code quality

Maintaining code quality and craft under AI-assisted development — the guardrails,
review layering, and feedback loops that hold a project to its author's standards
as agents generate more of its code.

## Methodologies

- [Agent development methodology — TDD-first, atomic PRs, review-gated](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md) — the operator's global-tier methodology for agent-driven development: a test-first loop where tests are the ratified contract agents may not weaken, matklad-style test architecture, the Elixir fast loop, one-concern PRs sized for review, layered gates — with the lean vendorable block consuming repos embed. `em:cab2c5` _(methodology)_

## Documents

- [Why TDD works so well in AI-assisted programming (Jason Gorman)](/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md) — TDD's small-steps discipline mapped one-to-one onto LLM failure modes (effective context far below advertised limits, broken code polluting later predictions, examples beating descriptions), making red-green-refactor the control loop that keeps an agent close to working code. `em:e7644d` _(reference)_
- [Getting good results from Claude Code (Chris Dzombak, 2025-08) — and how it aged](/knowledge/SWE/agentic/code-quality/getting-good-results-from-claude-code.md) — the fourteen-practice agentic-coding playbook (spec first, staged plans, TDD, incremental compiling commits, three-attempt stop, never weakening tests, full human review), assessed a year on: four practices became product features, nine remain valid user-side discipline, and the fat global CLAUDE.md aged out. `em:49315a` _(reference)_
- [Guarding Against AI Drift (Mike Zornek)](/knowledge/SWE/agentic/code-quality/guarding-against-ai-drift.md) — a solo-developer's two-layer playbook against AI quality drift: automated Elixir guardrails (compile/format/lint/security/workflow checks) for the mechanical, plus deliberately non-delegated layered human review, with recurring misses promoted into the standards docs the agent reads.
- [Elixir coding conventions (Zornek's LocalCents standards)](/knowledge/SWE/agentic/code-quality/elixir-coding-conventions-localcents.md) — the transferable Elixir/typespec/documentation conventions from LocalCents' CODING_STANDARDS.md (the very agent-read standards doc the AI-drift feedback loop feeds), foregrounding the `@spec` argument-naming and layout rules.
- [It does what it says on the tin: why naming matters more with AI (Wicksipedia)](/knowledge/SWE/agentic/code-quality/it-does-what-it-says-on-the-tin.md) — a misleading name a human reviewer would have questioned gets taken at face value by an AI agent and built on with confidence, illustrated by a TinaCMS feature Claude implemented against an unreliable API it had no reason to distrust.
- [dzhng/skills — a software-factory skill library for autonomous agent runs](/knowledge/SWE/agentic/code-quality/dzhng-skills-software-factory.md) — a harness-agnostic skill library implementing a map-unknowns-then-spec-then-build-unattended loop, reviewed via a choices ledger instead of the raw diff.
- [Stage (stagereview) — chapter-organized local code review](/knowledge/SWE/agentic/code-quality/stagereview-chapter-code-review.md) — a local CLI/browser tool that groups a diff into logical review chapters with risk context before the reviewer opens a single line.
- [Lowering the cognitive burden of reviewing AI code (Michelle Tilley)](/knowledge/SWE/agentic/code-quality/reviewing-ai-generated-code-two-tool-workflow.md) — a two-tool review workflow pairing a chapter-level overview pass (Stage) with a detail-level annotated diff pass (Plannotator).
- [Reviewing code is a skill (typesanitizer)](/knowledge/SWE/agentic/code-quality/reviewing-code-is-a-skill.md) — a case that code-review proficiency is learnable and teachable, argued from research on what reviewers value and three bugs caught by reasoning about invariants and failure modes.
