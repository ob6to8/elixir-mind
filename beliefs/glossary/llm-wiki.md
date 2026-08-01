---
id: em:343006
type: concept
title: llm-wiki (Karpathy pattern)
description: Andrej Karpathy's April-2026 gist sketching a personal knowledge base an LLM incrementally builds and maintains — raw sources plus an LLM-owned wiki, a hand-written index, a log, and a schema prompt file — with cross-reference drift named as the pattern's known failure mode.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, karpathy, second-brain, llm-wiki, knowledge-management]
sense: common
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the terse-brain evaluation thread; already used unlinked across several existing glossary entries and analyses"
---

# llm-wiki (Karpathy pattern)

The anchor text for what this bundle's own field surveys call "Tier 2" of the
second-brain landscape — agent-native systems built on the same shape: raw
sources register into a folder, an LLM distills structure into a wiki, and a
periodic lint pass catches drift. Karpathy's own estimate — one ingested
source touches 10–15 existing wiki pages — is the load-bearing number behind
[cross-reference drift](/beliefs/glossary/cross-reference-drift.md): a
partial-view agent updates only what it retrieved, and everything else rots
silently. Public implementations vary in how they harden the pattern against
that failure — from advisory lint passes to, in
[terse-brain](/meta/analysis/terse-lang-terse-brain-evaluation.md)'s case, six
named lint checks over a purpose-built queryable state format (TERSE) instead
of hand-kept markdown.

*Seen in:* [2026-08-01 terse-brain evaluation and index-coverage gate thread](/meta/threads/2026-08-01-terse-brain-evaluation-and-index-coverage-gate.md), [2026-07-10 field comparison analysis](/meta/analysis/comparison-with-the-2026-second-brain-field.md)
