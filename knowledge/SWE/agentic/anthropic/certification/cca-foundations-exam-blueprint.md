---
id: em:214aa4
type: source
title: "CCAR-F exam blueprint — the 30 task statements and six scenarios"
description: The authoritative content outline for the Claude Certified Architect – Foundations exam, captured from Anthropic's public exam guide — five weighted domains expanded into 30 task statements, plus the six production scenarios every item is framed inside.
resource: https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542750%2FClaude+Certified+Architect+%E2%80%93+Foundations+Exam+Guide.pdf
provenance: "Claude Certified Architect – Foundations Exam Guide, Version 1.0, effective July 2026 (Anthropic), sections 3–6"
tags: [anthropic, certification, cca, ccar-f, exam-blueprint, objectives, primary-source]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "the authoritative content outline for the exam the operator is studying toward; the 30 task statements are the coverage denominator for the practice question bank"
---

# CCAR-F exam blueprint

Captured from Anthropic's public exam guide. The guide states plainly that
**"Exam items are written against these objectives"**, which makes the 30 task
statements — not the five domain headings — the real unit of study.

## Exam facts

| | |
|---|---|
| Exam code | `CCAR-F` · guide Version 1.0, effective July 2026 |
| Number of items | 60 |
| Item format | multiple-choice **and multiple-response**; each item states how many responses to select |
| Exam structure | 4 scenarios drawn from a bank of 6 |
| Time limit | 120 minutes |
| Passing score | scaled 720 on a 100–1,000 range |
| Fee / validity | $125 USD · 12 months |

## Domain weights

| # | Domain | Weight | Task statements |
|---|---|---|---|
| 1 | Agentic Architecture & Orchestration | 27% | 7 |
| 2 | Tool Design & MCP Integration | 18% | 5 |
| 3 | Claude Code Configuration & Workflows | 20% | 6 |
| 4 | Prompt Engineering & Structured Output | 20% | 6 |
| 5 | Context Management & Reliability | 15% | 6 |

Weights "reflect the relative importance of each domain to competent
performance as determined through the job task analysis."

## The 30 task statements

**Domain 1 — Agentic Architecture & Orchestration (27%)**

1. **1.1** Design and implement agentic loops for autonomous task execution
2. **1.2** Orchestrate multi-agent systems with coordinator-subagent patterns
3. **1.3** Configure subagent invocation, context passing, and spawning
4. **1.4** Implement multi-step workflows with enforcement and handoff patterns
5. **1.5** Apply Agent SDK hooks for tool call interception and data normalization
6. **1.6** Design task decomposition strategies for complex workflows
7. **1.7** Manage session state, resumption, and forking

**Domain 2 — Tool Design & MCP Integration (18%)**

8. **2.1** Design effective tool interfaces with clear descriptions and boundaries
9. **2.2** Implement structured error responses for MCP tools
10. **2.3** Distribute tools appropriately across agents and configure tool choice
11. **2.4** Integrate MCP servers into Claude Code and agent workflows
12. **2.5** Select and apply built-in tools (Read, Write, Edit, Bash, Grep, Glob) effectively

**Domain 3 — Claude Code Configuration & Workflows (20%)**

13. **3.1** Configure CLAUDE.md files with appropriate hierarchy, scoping, and modular organization
14. **3.2** Create and configure custom slash commands and skills
15. **3.3** Apply path-specific rules for conditional convention loading
16. **3.4** Determine when to use plan mode vs direct execution
17. **3.5** Apply iterative refinement techniques for progressive improvement
18. **3.6** Integrate Claude Code into CI/CD pipelines

**Domain 4 — Prompt Engineering & Structured Output (20%)**

19. **4.1** Design prompts with explicit criteria to improve precision and reduce false positives
20. **4.2** Apply few-shot prompting to improve output consistency and quality
21. **4.3** Enforce structured output using tool use and JSON schemas
22. **4.4** Implement validation, retry, and feedback loops for extraction quality
23. **4.5** Design efficient batch processing strategies
24. **4.6** Design multi-instance and multi-pass review architectures

**Domain 5 — Context Management & Reliability (15%)**

25. **5.1** Manage conversation context to preserve critical information across long interactions
26. **5.2** Design effective escalation and ambiguity resolution patterns
27. **5.3** Implement error propagation strategies across multi-agent systems
28. **5.4** Manage context effectively in large codebase exploration
29. **5.5** Design human review workflows and confidence calibration
30. **5.6** Preserve information provenance and handle uncertainty in multi-source synthesis

Each task statement in the guide carries explicit *Knowledge of* and *Skills in*
bullets. Notably, several also name **anti-patterns** the exam tests against —
for example under 1.1, "parsing natural language signals to determine loop
termination, setting arbitrary iteration caps as the primary stopping mechanism,
or checking for assistant text content as a completion indicator."

## The six scenarios

Every item is framed inside one of six production contexts; four are drawn at
random per sitting.

| # | Scenario | Primary domains |
|---|---|---|
| 1 | Customer support resolution agent (MCP tools: `get_customer`, `lookup_order`, `process_refund`, `escalate_to_human`; 80%+ first-contact resolution target) | 1, 2, 5 |
| 2 | Code generation with Claude Code (slash commands, CLAUDE.md, plan mode vs direct execution) | 3, 5 |
| 3 | Multi-agent research system (coordinator delegating to search / analysis / synthesis / report subagents) | 1, 2, 5 |
| 4 | Developer productivity tooling (codebase exploration, built-in tools, MCP servers) | 2, 3, 1 |
| 5 | Claude Code for CI/CD (automated review, test generation, minimizing false positives) | 3, 4 |
| 6 | Structured data extraction (JSON schema validation, edge cases, downstream integration) | 4, 5 |

## Intended audience

A solution architect with **6+ months** hands-on experience building with the
Claude API, Agent SDK, Claude Code, and MCP, who "must demonstrate not only
conceptual knowledge but practical judgment about architecture, configuration,
and tradeoffs in production deployments."

# Citations

- [Claude Certified Architect – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542750%2FClaude+Certified+Architect+%E2%80%93+Foundations+Exam+Guide.pdf) (PDF, 39pp, Version 1.0)
- [Partner Academy — certifications catalog](https://anthropic-partners.skilljar.com/page/partner-certifications)

# See also

- [The Claude Certification Program](/knowledge/SWE/agentic/anthropic/certification/claude-certification-program.md)
- [CCA study program plan](/meta/plans/cca-certification-study-program.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:214aa4">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-cca-study-program-and-the-primary-source-miss (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:214aa4`]**

Yes — official. Skilljar is the LMS vendor; `anthropic-partners.skilljar.com` is Anthropic's own Partner Academy tenant. And it doesn't just have prices — **the complete 39-page exam guide is public on that page**, served from an S3 `/public/` path with no login. That was the single largest open question in the plan, and it was one link from a page I had already read.

**What went wrong, precisely**

I fetched the Academy's *individual* CCA certification page, which states scope but no pricing or blueprint. My `site:` searches were scoped to `anthropic.com` and `claude.com`, so they never touched the skilljar host at all. I then concluded "no primary source states the price" from "the primary pages I happened to check don't state it."

That's absence of evidence asserted as evidence of absence — and it's the exact failure the quarantine discipline exists to prevent. The discipline was sound; my classification of the facts was wrong, in the more damaging direction: I told you real primary data was third-party.

**What the guide actually says**

All primary now, and it corrects the third-party record in two ways that matter for building:

| | |
|---|---|
| Code / version | `CCAR-F`, v1.0, effective July 2026 |
| Items | 60 — **multiple-choice *and* multiple-response** (prep sites say "one correct answer" — wrong) |
| Structure | **4 scenarios drawn from a bank of 6** (prep sites say 6 — wrong) |
| Time / cut score | 120 min · scaled 720 on 100–1,000 · criterion-referenced |
| Fee / validity | $125 · 12 months · free non-proctored renewal, lapse = full retake |

Domains: Agentic Architecture & Orchestration 27%, Claude Code Configuration & Workflows 20%, Prompt Engineering & Structured Output 20%, Tool Design & MCP Integration 18%, Context Management & Reliability 15% — expanded into **30 task statements**, each with explicit *Knowledge of* / *Skills in* bullets. The guide says items "are written against these objectives," which makes task statements the real unit of study and gives question coverage a denominator.

**One finding changes the project's constraints.** Section 14 binds candidates to an NDA covering "all exam content, including questions, answer options, and scenarios." So the bank must be authored from the published objectives, never reconstructed from recalled items; third-party question banks become *not ingestible* (they may themselves be reconstructions); and excluding the bank from the public site moves from prudent to settled. That's now written into the plan as binding design input.
