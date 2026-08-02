---
type: matter
title: "Standardize the verbatim-capture filing pattern"
description: Ratify the sibling-source pattern as the one filing shape for verbatim external captures, add the policy sentence, and retype the strays the content review found.
status: open
plan: /meta/plans/decision-queue-matter-sequence.md
order: 3
provenance: "Claude Fable 5, decision-queue session"
tags: [meta, matter, filing, types, captures, policy]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T11:26:00Z
  channel: agent-authored
  agent: "Claude Code agent, decision-queue session"
  why: "decision-queue row 3, broken out as matter 3 of the sequence"
---

# Standardize the verbatim-capture filing pattern

The [content review](/meta/analysis/content-quality-sample-review.md)'s
erosion 2: the same artifact class — a verbatim external thread/post — files
three ways, so type-scoped queries are less trustworthy than the controlled
vocabulary implies. The review's recommendation, carried here: **the
sibling-`source` pattern is the strongest of the three in use** (a verbatim
capture as a `type: source` doc beside the distilled statement/reference
that cites it — the shape ISNAD and agent-says-done already follow).

**Deliver:**

1. **The policy sentence** — one bullet into
   [capture-knowledge-cite-the-source](/meta/policy/capture-knowledge-cite-the-source.md)
   ratifying the pattern: a verbatim external thread/post kept in the bundle
   files as a sibling `type: source` capture beside the distilled document,
   never as a second `reference` and never wholesale inside the distilled
   body. `/render-contract` rides.
2. **Retype the strays** (ids immutable; `type` and index glosses change;
   re-check each against HEAD first):
   - [rag-evaluation-is-harder…-reddit-thread](/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md)
     — a verbatim capture typed `reference` → `source`.
   - [founders-playbook](/knowledge/startups/founders-playbook-ai-native-startup.md)
     — external captured material typed `methodology` → `reference` (the
     vocabulary's authored-here/captured-elsewhere line).
3. **Rule on the embedded-verbatim cases** (steps-of-ai-adoption,
   markdown-folder — verbatim blocks welded inside distilled references):
   split the block out into a sibling `source` (minting a new `em:` id), or
   tolerate in place with the policy binding future filings only.
   Recommendation: split only where the block dominates the doc; tolerate
   the rest — retro surgery on every embedded quote is churn the pattern
   does not require.

Constraint to honor: verification-grounding — a capture carrying `resource`
never carries `verified`; check the retyped docs' fields at delivery.
