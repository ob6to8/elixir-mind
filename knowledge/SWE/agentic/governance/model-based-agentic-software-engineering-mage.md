---
id: em:d146ff
type: reference
title: "Model-Based Agentic Software Engineering (MAGE) — framework overview"
description: James C. Davis's framework for governing AI-agent fleets in software delivery, built from a 19-week case study, arguing the bottleneck agentic development hits isn't writing code anymore but governing the conditions under which fast code can be trusted — a catalogue of constraint- and sensor-based mechanisms grown from real failures rather than hypothetical ones.
resource: https://davisjam.github.io/model-based-agentic-software-engineering/
provenance: "James C. Davis (Purdue University), \"Model-Based Agentic Software Engineering\" book/site and its companion GitHub repository, fetched 2026-08-05"
tags: [agent-governance, mage, model-driven-engineering, agentic-loop, vibe-coding, engineering-methodology, claude-skills]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# Model-Based Agentic Software Engineering (MAGE)

James C. Davis (Purdue University) frames MAGE as a response to a shift in
where agentic software delivery's bottleneck sits: "the hard part stops being
writing code and becomes governing the conditions under which fast code can
be trusted." Code generation got cheap; the scaling limit is now *churn* —
agents confidently undoing or contradicting earlier work once it exceeds
their context window.

MAGE positions itself between two failure modes: **vibe coding** (fast but
chaotic, no governing structure) and **oversight-centric development**
(rigorous but bottlenecked on a human reviewing everything). Its answer is
"velocity + guardrails grown from failure" — mechanisms earn a place in the
catalogue because a real failure motivated them, not because they sounded
prudent in the abstract.

## The two theses

- **Modeling thesis.** "Documentation, taken to its limit, is a structured
  model" — the same claim this bundle already holds at chapter granularity in
  [Models and the semantic gap](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md)
  (MAGE ch. 2.2): a typed model is the compact, checkable binding layer
  between ambiguous prose and dense code, valid only when authored
  independently of the code rather than derived from it.
- **Alignment thesis.** "Hold intent with a mechanism: prevent first, sense
  the rest" — governance mechanisms split into constraint-based ones that
  prevent a failure class outright, and sensor-based ones that detect it
  after the fact when prevention isn't cheap enough.

## Structure

The framework's "six big ideas" run: the problem (churn is the scaling
limit) → the stance (a governance-centric environment) → thesis 1 (modeling)
→ thesis 2 (alignment) → the practice (convert recurring failures into
controls) → the seat (agents take the developer role; engineers author
intent and govern the output).

The companion GitHub repository (`davisjam/model-based-agentic-software-engineering`)
holds the same content as an interactive web book plus a downloadable PDF, a
**catalogue of governance mechanisms** derived from Davis's 19-week case
study, three Claude skills (self-governance, self-operations,
self-communicate) for adopting the mechanisms directly, a quick-start guide,
and the academic paper "Cheap Code, Costly Judgment." The recommended
starting point is a small number of high-leverage mechanisms, expanded
incrementally as real failures surface — not the whole catalogue at once.

# Citations

- Source (book/site): <https://davisjam.github.io/model-based-agentic-software-engineering/>
- Source (repository): <https://github.com/davisjam/model-based-agentic-software-engineering>

# See also

- [Models and the semantic gap (MAGE, ch. 2.2)](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md) — this bundle's existing chapter-level capture of the modeling thesis
