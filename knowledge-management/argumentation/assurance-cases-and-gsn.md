---
id: sb:59895a
type: reference
title: Assurance cases and Goal Structuring Notation (GSN)
description: The safety-engineering practice of arguing a system property as an explicit claim tree — goals decomposed via strategies down to evidence — standardized as GSN (University of York, Tim Kelly; Community Standard 2011) and used across aviation, automotive, rail, nuclear, and clinical domains.
resource: https://en.wikipedia.org/wiki/Goal_structuring_notation
provenance: "Distilled from the Wikipedia article on Goal Structuring Notation, fetched 2026-07-11"
tags: [argumentation, assurance-case, safety-case, gsn, safety-critical, epistemics, evidence]
timestamp: 2026-07-11
---

# Assurance cases and Goal Structuring Notation (GSN)

An **assurance case** (safety case, security case) is a structured argument
that a system satisfies a property — presented not as prose but as an explicit
graph of claims and evidence. **Goal Structuring Notation** is the dominant
graphical standard for writing one: "the elements of an argument and the
relationships between those elements in a clearer format than plain text."

## The notation

- **Goals** — claims to be substantiated (the property being argued).
- **Strategies** — the reasoning approach that decomposes a goal into subgoals.
- **Solutions / evidence** — the facts (test results, analyses, inspections)
  that terminate the argument's leaves.
- **Context and assumptions** — the conditions under which the argument holds.

GSN emerged at the University of York in the early 1990s (ASAM-II project),
was systematized by **Tim Kelly**'s doctoral work (construction methods,
reusable argument patterns), and became the **GSN Community Standard** in
2011. It is standard practice in aviation, automotive, rail, nuclear, and
clinical care, and has been applied to security cases, patents, debate, and
legal argument.

## The standing criticism

Charles Haddon-Cave (Nimrod Review) warned that GSN arguments risk becoming a
"self-fulfilling prophesy": when the top-level goal presumes the system safe,
the case can mask uncertainty rather than expose it. An argument structure
audits *coherence*, not *truth* — the leaves are only as good as their
evidence, and an
[ungrounded inference](/glossary/ungrounded-inference.md) hidden mid-tree
invalidates everything above it.

## Why it is in this brain

Assurance cases are the code-facing proof-of-concept for overlaying an
epistemic structure on engineering artifacts: a claim tree over a system,
mechanically checkable for shape (every goal decomposed, every leaf evidenced)
while the leaf judgments stay human/expert. That is the shape of auditing the
*claims about* code — design docs, ADRs, comments — against the artifact
itself. See the
[belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md)
and the [Toulmin model](/knowledge-management/argumentation/toulmin-model-of-argument.md),
GSN's intellectual ancestor.

# Citations

Goal structuring notation — Wikipedia:
<https://en.wikipedia.org/wiki/Goal_structuring_notation>
