---
id: em:4a7357
type: source
title: "Why Does CLAUDE.md Keep Growing? Catastrophic Remembering in Agentic Coding"
description: Agentic-coding instruction files grow without bound because deleting an old instruction risks a regression once its rationale is forgotten — named catastrophic remembering, and shown to be halted by comments that preserve each instruction's reasoning.
resource: https://www.alphaxiv.org/abs/2608.11095
provenance: "alphaXiv abstract (2608.11095), fetched 2026-08-21"
tags: [evals, agentic-coding, prompt-engineering, instruction-following, ifeval]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Why Does CLAUDE.md Keep Growing? Catastrophic Remembering in Agentic Coding

Author: Kushal Chakrabarti.

The paper's premise, quoted directly: "Agentic coding READMEs like this
http URL grow without bound in real repositories, stopping only when the
repository retires or someone rewrites the file wholesale." The mechanism it
identifies: appending a new instruction is always cheap, but once an
instruction's *rationale* is lost, deleting it without risking a correctness
regression costs "O(2^|D|) in a prompt of |D| instructions" — every existing
instruction is a potential interaction the deleter would have to re-check.
The paper names this **catastrophic remembering**, framed as the inverse of
*catastrophic forgetting* from continual learning: instead of a model losing
old knowledge as it learns new things, an instruction file keeps *everything*
because nothing is ever safe to forget.

## Findings

- Across 247,694 instruction lifetimes in 1,867 repositories, agentic prompts
  grow "more than tripling over their lifetime (+226%)," gaining "+4.9 net
  instructions every commit."
- The older an instruction gets, the less likely it is to be deleted
  (log-hazard -0.032/commit) — bloat compounds because survival probability
  rises with age, not falls.
- Inverting IFEval (constructing verifiable synthetic worlds whose *optimal*
  prompt is known in advance) lets the paper measure excess bloat directly:
  prompt comments that encode an instruction's latent reasoning "remove 99.3%
  of excess instructions (+211.3% to +1.4%)."
- Applying the same technique to WildIFEval (real-world instructions), prompt
  comments "improve real-world agentic instruction-following by up to 23.1%."

## Relevance to this bundle

This is a direct empirical study of the exact failure mode this bundle's own
`CLAUDE.md` is engineered against: `CLAUDE.md` here is a **generated
artifact** compiled from small, individually-sourced `meta/policy/*.md`
documents rather than hand-accreted in place, and
[living-text-is-present-tense](/meta/policy/living-text-is-present-tense.md)
already forbids narrating stale rationale inline. The paper's finding —
that *preserving rationale next to the instruction* is what makes safe
deletion possible — is independent empirical support for that structure:
policy source files carry their own `_Source:` provenance and are edited
individually rather than appended to a single ever-growing document.

# Citations

- <https://www.alphaxiv.org/abs/2608.11095> — abstract
