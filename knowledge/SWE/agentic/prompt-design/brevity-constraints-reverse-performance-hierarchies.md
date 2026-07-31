---
id: em:2f847a
type: source
title: "Brevity Constraints Reverse Performance Hierarchies in Language Models"
description: Research demonstrating that larger language models underperform smaller ones on benchmark tasks due to spontaneous verbosity, and that brevity constraints reverse this hierarchy while improving accuracy and reducing compute.
resource: https://arxiv.org/abs/2604.00025
provenance: "MD Azizul Hakim, arXiv preprint, March 2026"
tags: [prompt-engineering, model-behavior, scale-dependent-verbosity, brevity, prompt-constraints, performance-tuning, LLM-prompting, model-efficiency, benchmark-performance]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: intake
  agent: "Claude Code agent, /intake"
  why: "Relevant research on prompt engineering and model behavior in agentic contexts; addresses performance degradation in larger models"
---

# Brevity Constraints Reverse Performance Hierarchies in Language Models

## Summary

Hakim's research identifies a counterintuitive phenomenon: larger language models (up to 405B parameters) sometimes underperform significantly smaller models (0.5B parameters) on certain benchmark tasks. The root cause is **spontaneous scale-dependent verbosity** — larger models tend to produce unnecessarily elaborate responses that introduce errors. Constraining these models to provide concise answers completely reverses the performance hierarchy, yielding improvements of 7.7–15.9 percentage points on mathematical reasoning and scientific knowledge benchmarks.

## Key Findings

**Problem Scope:** On 7.7% of benchmark problems spanning five datasets, larger models underperformed smaller ones by as much as 28.4 percentage points.

**Root Cause:** Larger models exhibit a tendency toward overelaboration — they generate verbose responses with unnecessary detail, which paradoxically increases error rates rather than improving accuracy.

**Solution & Results:** Applying brevity constraints to large models:
- Completely reverses performance hierarchies on math and science benchmarks
- Achieves 7.7–15.9 percentage point improvements in accuracy
- Simultaneously reduces computational cost via shorter generation length

## Implications for Agent Prompting

The research validates a practical principle for agentic systems: **scale-aware prompt engineering is critical**. Since agents operate in loops with context accumulation, verbosity is a compounding cost — overly elaborate outputs consume context tokens and introduce errors that later turns must correct. Constraining large models to concise responses optimizes both accuracy and efficiency.

## Citations

arXiv:2604.00025 (March 2026)
- https://arxiv.org/abs/2604.00025
