---
id: em:b4e21d
type: reference
title: "Caveman — AI agent output compression"
description: A multi-platform plugin for AI coding agents (Claude Code, Cursor, Copilot, etc.) that reduces output tokens by ~65% through terse communication while preserving technical accuracy and code correctness.
resource: https://github.com/juliusbrussee/caveman
provenance: "Julius Brussee, GitHub repository, 2026"
tags: [token-reduction, agent-efficiency, output-optimization, cost-reduction, prompt-compression, ai-coding-agents, caveman-tool]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: intake
  agent: "Claude Code agent, /intake"
  why: "Tool for optimizing agent communication efficiency; relevant to agentic-loop cost and context management patterns"
---

# Caveman — AI agent output compression

## What It Does

Caveman is a plugin/skill available across 30+ AI coding agents (Claude Code, Cursor, Gemini, Cline, Copilot, and others) that compresses agent responses by removing filler language and adopting terse communication. Its core principle: *"why use many token when few token do trick."*

**Key invariant:** Code, commands, and error messages remain **byte-for-byte identical**—only explanatory prose shrinks.

## Design & Features

**Six compression levels** can be toggled with `/caveman [level]`:
- `lite` — minimal compression
- `full` — standard compression
- `ultra` — aggressive compression
- `wenyan` — specialized mode (name suggests Classical Chinese brevity aesthetic)

**Specialized command variants:**
- `/caveman-commit` — one-line commit messages (token-optimized)
- `/caveman-review` — ultra-concise PR review comments
- `/caveman-stats` — token savings tracking across sessions

**Memory file compression:** `/caveman-compress` rewrites documentation in-place, cutting input tokens by ~46% for all future sessions using that memory.

**Universal installation** auto-detects and configures supported agents; **zero telemetry**, entirely local operation.

## Problem Solved

Addresses two operational constraints in AI-assisted coding:

1. **Token cost & speed:** Longer agent responses consume more tokens and take longer to generate. By cutting output verbosity, caveman reduces API costs and improves latency.

2. **Output quality paradox:** Caveman's premise (backed by the March 2026 arXiv paper `2604.00025`) is that *less prose = better reasoning*. Overly elaborate explanations can introduce errors; concise communication forces clarity and reduces hallucination. The paper reports ~26 percentage point accuracy improvements by constraining output length on benchmarks.

## Relevance to Agentic Loops

In the context of [agentic-loop](/knowledge/SWE/agentic/agentic-loop/index.md) design:
- Reduces context bloat from agent output over multi-turn sequences
- Aligns with the [control-plane principle](/knowledge/SWE/agentic/agentic-loop/unattended-agent-operation-control-plane-patterns.md) of deterministic, efficient dispatch
- Cost ceiling enforcement (per session) benefits from token-reduction at the source rather than just output filtering

## Related

- [Brevity Constraints Reverse Performance Hierarchies](/knowledge/SWE/agentic/prompt-design/brevity-constraints-reverse-performance-hierarchies.md) — the research grounding caveman's brevity hypothesis

## Citations

GitHub: juliusbrussee/caveman
- https://github.com/juliusbrussee/caveman
