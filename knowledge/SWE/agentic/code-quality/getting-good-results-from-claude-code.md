---
id: em:49315a
type: reference
title: "Getting good results from Claude Code (Chris Dzombak, 2025-08) — and how it aged"
description: Dzombak's fourteen-practice playbook for agentic coding — spec first, staged plans, TDD, incremental compiling commits, a three-attempt stop rule, never weakening tests, full human review — assessed a year on, where four practices became product features, nine remain valid user-side discipline, and the fat global CLAUDE.md it relied on is the one element that aged out.
resource: https://www.dzombak.com/blog/2025/08/getting-good-results-from-claude-code/
provenance: "Distilled from Chris Dzombak's blog post, 2025-08-08; aged assessment against Claude Code documentation as of 2026-08"
tags: [agentic, claude-code, ai-assisted-development, workflow, code-quality, tdd]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T17:56:08Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "a year old — evaluate how its directions aged and which proved out for incorporation into the operator's methodology"
---

# Getting good results from Claude Code (2025-08)

Chris Dzombak's playbook for productive agentic coding, written August 2025.
The frame: the human owns the outcome — *"I believe I'm ultimately responsible
for the code that goes into a PR with my name on it, regardless of how it was
produced."* Follow-up: his December 2025
[streamlined user-level CLAUDE.md](/knowledge/SWE/agentic/context-engineering/streamlining-user-level-claude-md.md)
revises the guidance-file half of this post.

## The fourteen practices

**Before the agent runs:**

1. *"Writing a clear spec ahead of time … provides context to the agent as it
   works"* (a `SPEC.md`).
2. A project structure document covering builds/linters (project `CLAUDE.md`).
3. A personal *"global"* agent guide (`~/.claude/CLAUDE.md`) holding
   philosophy, process, quality gates, and prohibitions.
4. Break complex work into *"3-5 stages"* documented in
   `IMPLEMENTATION_PLAN.md` with testable success criteria.

**While the agent works:**

5. TDD: *"Write test first (red) / Implement minimal code to pass (green)."*
6. *"Study existing patterns in codebase"* before implementing.
7. *"Commit working code incrementally"* — every commit compiles and passes
   tests.
8. *"Maximum 3 attempts per issue, then STOP"* — then document *"What you
   tried, Specific error messages, Why you think it failed"* and reassess.
9. *"Never disable tests, fix them."*
10. *"Use project's existing build system, test framework, formatter/linter
    settings."*

**After the agent stops:**

11. Ask the agent to review its own work — *"surprisingly fruitful."*
12. Manually review **all** AI-written code and test cases.
13. Add the test cases the agent missed.
14. Quality gates as a definition of done: compile, tests, lint, docs, no
    `--no-verify`.

## How it aged (assessed 2026-08)

Checked against current Claude Code documentation (code.claude.com — memory,
best-practices, and common-workflows pages, 2026-08). The practices aged far
better than their storage vehicle.

**Became product features (4):** the project structure doc (`/init` now
generates and maintains project `CLAUDE.md`, detecting build systems and test
frameworks); self-review (`/code-review`); the global guide as a formal memory
layer (`~/.claude/CLAUDE.md` in a documented managed-policy → user → project
hierarchy); and test-weakening, now guarded by an auto-mode classifier that
blocks commenting-out or force-passing guarding tests.

**Still valid user-side discipline (9):** spec-first, staged plans, TDD,
pattern-study, incremental compiling commits, the three-attempt stop, failure
documentation, full human review, and human-added tests. The product supports
each (plan mode, checkpoints, hooks) but scaffolds and enforces none — they
remain things a methodology has to impose.

**Aged out (1):** the *fat prescriptive global CLAUDE.md* itself. Dzombak's
own December follow-up cut it hard to avoid *"conflicting with principles that
seem to be built into Claude Code these days, e.g. planning mode"*; official
guidance now caps CLAUDE.md files at ~200 lines and applies the test "Would
removing this cause Claude to make mistakes? If not, cut it." Process moved
from prompt text into product affordances; the guide's residual job is the
deltas the product can't infer.

**The notable gap:** TDD is the one practice the product still neither
scaffolds nor recommends — current docs teach *verification-driven* iteration
("give Claude something that produces a pass or fail") but never test-first.
A TDD-with-agents methodology has to come from the operator; the case for it
is [Gorman's argument](/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md).

# Citations

Chris Dzombak, "Getting Good Results from Claude Code", 2025-08-08 —
<https://www.dzombak.com/blog/2025/08/getting-good-results-from-claude-code/>
