---
id: em:2ecdd2
type: belief
title: Review is not an oracle
description: Inspecting generated output cannot establish its correctness however many times it is repeated, because the reviewer shares the generator's blind spots and has nothing independent to check against — only a source of truth outside the output can settle it.
provenance: "Claude Code session, 2026-07-27 — synthesized while intaking Karsten Hahn's G DATA field report on LLM malware analysis, whose five-verification-pass result is the empirical case; ratified as a belief by the operator in the same session"
tags: [belief, verification, evaluation, review, agent-output, epistemics]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, arXiv:2607.05842 intake session — operator-directed belief filing"
  why: "operator directed committing the review-is-not-an-oracle observation as a belief distinct from the coverage×quality prior"
---

# Review is not an oracle

Reviewing output tests whether it *looks* right. An
[oracle](/beliefs/glossary/test-oracle.md) tests whether it *is* right, and its
authority comes from being independent of the thing under test. Re-reading
generated prose supplies no such independence: a plausible-sounding wrong answer
is plausible to the reviewer for the same reasons it was to the generator, so
additional passes reduce the error rate without ever bounding it. The prior:
**treat review as a filter, never as a verification step, and count a claim as
checked only when something outside the output decided it.**

The empirical case comes from
[Hahn's malware-analysis field report](/knowledge/SWE/security/llms-in-malware-analysis-scripts-over-reports.md),
where five explicit verification passes were run over the highest-stakes
structured fields — IPs, hashes, filenames, paths, registry keys, offsets, line
numbers — and the outcome, quoted verbatim:

> "Even with five verification passes, there are frequent mistakes in key points
> of the report."

The same report supplies the contrast that makes the mechanism legible rather
than merely discouraging. Scripts, in that workflow, *were* trustworthy —
because *"the LLM has a feedback loop that tells if the script is working or
not."* Nothing about the model changed between the two cases; what changed is
that one artifact executes and the other does not. Correctness followed the
oracle, not the effort.

Held as a prior rather than a finding because its force is in what it forbids,
and the temptation it forbids is permanent: review is always available, always
feels like diligence, and scales by simply doing more of it. The belief says that
scaling is illusory past the first pass or two, and that effort spent on a third
review is better spent constructing *any* independent check — a test, an
execution, a second derivation, a source consulted directly.

Two consequences follow for how this brain is built. It is why a standard earns a
[gate](/beliefs/glossary/gate-suite.md) only when it has a mechanical oracle and
stays explicitly editorial when it doesn't — an editorial standard is honest
about resting on review, where a gate without an oracle would launder review as
verification. And it is why
[verification here requires evidence rather than assertion](/meta/policy/verification-grounding.md):
`verified: true` demands a non-empty `verified_by` pointing at captures outside
the statement, which is this belief encoded as a machine-enforced rule.

It sits beside
[coverage and quality must be measured jointly](/beliefs/coverage-and-quality-must-be-measured-jointly.md)
without following from it: that prior governs *what to measure*, this one governs
*what counts as having checked*.

# Citations

- Karsten Hahn, "LLMs in Malware Analysis: Doing Things Right is Difficult",
  G DATA blog, 3 March 2026 —
  <https://blog.gdatasoftware.com/2026/03/38381-llm-malware-analysis>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:2ecdd2">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-llm-security-intakes-and-two-evaluation-beliefs (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:2ecdd2`]**

3 - yes, commit to a belief
2 - approved
1 - proceed when done with above, then merg
