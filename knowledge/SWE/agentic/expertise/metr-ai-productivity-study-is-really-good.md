---
id: em:d27de7
type: reference
title: "METR's AI Productivity Study is Really Good (Sean Goedecke)"
description: Goedecke's read of METR's RCT on experienced open-source developers using Cursor Pro and Claude Sonnet on large, familiar codebases — they predicted and believed a ~20-24% speedup but measured 19% slower — and his account of why expert-in-familiar-codebase is close to the worst case for AI acceleration.
resource: https://www.seangoedecke.com/impact-of-ai-study/
provenance: "Sean Goedecke, seangoedecke.com essay, published 2025-07-11"
tags: [developer-productivity, metr-study, ai-assisted-development, expertise, empirical-evaluation]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# METR's AI Productivity Study is Really Good

Sean Goedecke praises METR's randomized controlled trial measuring AI's
effect on experienced open-source developers working with state-of-the-art
tools (Cursor Pro, Claude Sonnet) on large, real-world codebases they already
knew well.

## The counterintuitive result

Participants predicted AI would make them roughly 24% faster, and afterward
*believed* they had been about 20% faster. Objectively measured, they were
19% **slower** — despite having full discretion over when and how to use AI.
The study found "no difference" in the slowdown between participants with
prior AI experience and those without, and "developers didn't get faster
with AI over the course of the experiment" as they gained practice in-study.

## Goedecke's reading

He finds most plausible that highly experienced developers working in
codebases they already know well have little room left for AI to
accelerate — expertise-in-a-familiar-codebase is close to the condition
under which AI assistance has the least to add, not the most. His own
addition: "pure" software projects with high quality bars (compilers,
libraries) resist AI contribution more than most other domains, because
correctness stakes are higher and the tolerance for AI's characteristic
sloppiness is lower.

On the *illusion* of speed specifically — why participants believed they
were faster when they weren't — Goedecke's theory is that AI-assisted coding
lowers cognitive load, and the resulting feeling of ease gets misread as
velocity, rather than actually saving time. He calls this the field's most
rigorous engineering-focused AI productivity study to date, despite (or
because of) the surprising result.

## Relation to the rest of the corpus

This measures the opposite end of the ability distribution from
[AI makes weak engineers less harmful](/knowledge/SWE/agentic/expertise/ai-makes-weak-engineers-less-harmful.md):
where AI raises the floor for weak engineers, this study suggests it may not
raise the ceiling for the strongest ones already working inside familiar,
high-quality-bar code — consistent with
[LLMs reward expertise](/knowledge/SWE/agentic/expertise/llms-reward-expertise.md)'s
claim that the bottleneck is specifying and judging output, which an expert
in a familiar codebase was already doing efficiently without AI.

# Citations

- Source: <https://www.seangoedecke.com/impact-of-ai-study/>
