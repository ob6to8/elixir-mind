---
id: em:324f71
type: reference
title: "Reviewing code is a skill (typesanitizer)"
description: A case that code-review proficiency — catching bugs, spotting design flaws, building team awareness — is learnable and teachable rather than innate, argued from research on what reviewers value and three real bugs the author caught by reasoning about invariants and failure modes.
resource: https://typesanitizer.com/blog/code-review.html
provenance: "typesanitizer.com, \"Reviewing Code is a Skill\", fetched 2026-08-21"
tags: [code-review, mentorship, engineering-practice, invariants]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Reviewing code is a skill

The central claim: "I learnt how to review code along the way. I was not
magically born with some innate ability to do code review, or to catch bugs
in code review." Code review is treated as a learnable competency with room
to improve across every dimension — bug-catching, design-flaw detection,
spreading team norms, and building familiarity with a codebase — not a fixed
trait some engineers have and others don't.

## Why review matters beyond defect-catching

Citing Google-internal and academic research on what developers actually want
from review: "By coding our interview data, we identified four key themes
for what Google developers expect from code reviews: education, maintaining
norms, gatekeeping, and accident prevention." Defect detection is one of
four functions, not the whole point — which matters for arguments that an
LLM reviewer alone can substitute for human review.

## Three bugs, as worked examples of the skill

The author walks three real catches to show what "reasoning about invariants
and failure modes" looks like in practice: a git configuration locking issue
that risked non-deterministic devbox startup, an AWS CLI version
incompatibility that would have broken a CI job, and a potential outage from
uploading checksums after tarballs rather than before (breaking an atomicity
guarantee the deploy process depended on). Each was caught by domain
knowledge plus deliberately questioning an assumption the diff's author had
left implicit, not by pattern-matching against a known bug class.

## How to build the skill deliberately

- **Socratic dialogues.** Pair junior and senior engineers in randomized
  review sessions where the reviewer asks probing questions about the
  author's reasoning, surfacing the author's own gaps rather than just
  fixing them.
- **Near-miss post-mortems.** Record short clips explaining bugs caught in
  review, and discuss them at retrospectives — distributing knowledge about
  near-failures across the team, not just the individual who caught one.
- **Lightweight formal modeling.** For high-risk or multi-codebase changes,
  one person builds a formal model independently while another writes the
  code, then the two align — a second, differently-shaped pass over the same
  problem rather than one person reading the other's diff.
- **Expertise analysis.** Identify reviewers who are outliers at catching a
  particular class of issue, and use structured elicitation (Applied
  Cognitive Task Analysis) to extract and teach their tacit knowledge instead
  of leaving it un-transferred.

## The conditional case for keeping the skill

"If you're a software developer, and if you believe that people will
continue to be involved in the development and maintenance of programs for
the foreseeable future, then it's valuable to get better at reviewing code."
The argument is explicitly conditional on that second premise — a hedge
against a future where review is fully delegated, not a claim that review
stays valuable regardless.

## Reading against this bundle

The self-reported density figure ("30–100 SLOC per comment") and the
invariants-and-failure-modes framing sit beside
[Lowering the cognitive burden of reviewing AI code](/knowledge/SWE/agentic/code-quality/reviewing-ai-generated-code-two-tool-workflow.md):
that piece tools the *orientation* cost of review away; this one argues the
*judgment* underneath orientation is a skill worth building on purpose,
regardless of tooling. Together they cover the two halves of what makes
review of an AI-authored diff hard — an unfamiliar structure to map, and
invariant-level reasoning to apply once it's mapped.

# Citations

- typesanitizer.com, "Reviewing Code is a Skill" — <https://typesanitizer.com/blog/code-review.html>
