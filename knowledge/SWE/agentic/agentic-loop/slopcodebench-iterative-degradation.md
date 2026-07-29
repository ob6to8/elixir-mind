---
id: em:5f9c0d
type: reference
title: "SlopCodeBench — coding agents degrade monotonically over iterative extension"
description: A 20-problem, 93-checkpoint benchmark where agents repeatedly extend their own prior solutions against evolving specs finds no agent solves any problem end-to-end, and code quality erosion and verbosity climb monotonically the longer an agent iterates — 2.2x more verbose than maintained human code, with cost growing 2.9x and no matching correctness gain.
resource: https://arxiv.org/abs/2603.24755
provenance: "\"SlopCodeBench: Benchmarking How Coding Agents Degrade Over Long-Horizon Iterative Tasks\", arXiv:2603.24755, fetched 2026-07-29"
tags: [agentic-loop, evals, long-horizon, code-quality, agent-reliability, benchmarks]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: auto-intake
  agent: "Claude Code agent, /research daily Routine"
  why: "featured in the 2026-07-29 digest under SWE; reason-tag: groundbreaking, influential"
---

# SlopCodeBench

Most coding-agent benchmarks score single-shot correctness: give the agent a
spec, check whether the output passes. **SlopCodeBench** measures something
existing benchmarks miss entirely — what happens to code quality when an
agent has to keep **extending its own prior solution** as a specification
evolves, the way real feature work actually happens.

## Design

20 language-agnostic problems, 93 checkpoints total. At each checkpoint the
agent receives an updated specification and must modify the code it wrote at
the *previous* checkpoint — no prescribed interface (only external behavior is
specified, forcing the agent to make its own architectural decisions), and
hidden test suites (the agent sees spec prose and examples, never the actual
tests). 11 models were evaluated, agents running in isolated Docker containers
between checkpoints. Two quality metrics track the erosion pass-rate alone
would hide:

- **Structural erosion** — the fraction of total cyclomatic complexity
  concentrated in functions above a complexity threshold of 10.
- **Verbosity** — redundant/duplicated code growth, via 137 AST pattern rules
  plus structural clone analysis.

## Headline findings

**No agent solved any problem end-to-end** across the full checkpoint chain;
the best checkpoint completion rate was 17.2%. Beyond the pass/fail number:

- Structural erosion increased across **80%** of trajectories; verbosity
  increased across **89.8%**.
- Agent code landed **2.2× more verbose** than maintained human repositories,
  with erosion running roughly 2.2× higher too.
- **The degradation is monotonic.** Human-maintained codebases stabilize over
  time as a project matures; agent code just keeps getting worse, checkpoint
  after checkpoint.
- Cost grew **2.9×** across a problem's checkpoint sequence, with no
  corresponding gain in correctness — the agent spends more and produces
  worse code the longer the task runs.
- Quality-aware prompting (explicitly asking for clean code) improved the
  *starting* quality but did not slow the *rate* of decay, and did not raise
  the pass rate.

## Why it belongs with the reliability thread

SlopCodeBench is the mechanism-level companion to two notes already filed
here. [PARC](/knowledge/SWE/agentic/agentic-loop/parc-self-reflective-long-horizon-agent.md)
and
[agent task time horizons](/knowledge/SWE/agentic/agentic-loop/agent-task-time-horizons.md)
measure *whether* an agent keeps functioning across a long run; SlopCodeBench
measures what its *output* looks like once it does — and the answer rhymes
with the practitioner account in
[scar tissue](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md):
individually-plausible local decisions compounding into something worse than
any single decision explains, except SlopCodeBench shows it's the norm
across 11 models and 93 checkpoints, not one operator's anecdote. It also
sharpens
[test features, not code](/knowledge/SWE/testing/how-to-test-features-not-code.md)
(`em:a5ea86`) for the specific failure mode of *iterative* agent work: a
pass-rate check on the final state says nothing about whether the code that
got there is something a human should be maintaining.

# Citations

- <https://arxiv.org/abs/2603.24755> — "SlopCodeBench: Benchmarking How Coding Agents Degrade Over Long-Horizon Iterative Tasks"

# See also

- [PARC — a self-reflective agent for long-horizon autonomous execution](/knowledge/SWE/agentic/agentic-loop/parc-self-reflective-long-horizon-agent.md)
- [Agent task time horizons](/knowledge/SWE/agentic/agentic-loop/agent-task-time-horizons.md)
- [Scar tissue: behavioral drift in long-running autonomous coding agents](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md)
- [How to test: test features, not code (matklad)](/knowledge/SWE/testing/how-to-test-features-not-code.md)
