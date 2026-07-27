---
type: policy
title: Negative findings name their scope
description: A claim that something does not exist, is not stated, or was not found is a claim about a search space, so it must name the space actually searched — "I found no X in A or B" is reportable, "no X exists" is not, unless the search space was enumerated first.
section: filing
order: 18
status: active
tags: [meta, governance, filing, research, epistemics, communication]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, CCA certification session"
  why: "the operator ratified the rule after the agent reported that no primary source stated the CCA exam's price or blueprint, having searched two of Anthropic's seven documentation hosts while the authoritative guide sat public on a third"
---

**Negative findings name their scope.** A statement that something *does not
exist*, *is not stated anywhere*, or *could not be found* is a claim about a
search space, not about the world. Report it **relative to the space actually
searched**. "I found no pricing on the docs site or the corporate site" is
honest and actionable; "no primary source states the price" is a claim about
every source, and is sayable only when the sources were enumerated first.

- **The test: could the reader reconstruct what was checked?** If yes, the
  finding is scoped and a reader can extend the search. If the sentence would
  survive unchanged no matter how little was looked at, it is overclaiming.
- **Escalate before a decision rests on it.** When a negative finding is
  load-bearing — it justifies building something, retracting something, or
  telling the operator a thing is unavailable — enumerate the search space
  first, or say plainly that the enumeration was not done. An unscoped negative
  that turns out false corrupts every artifact built on it.
- **Search returns a finite result set.** Absence within it is evidence about
  the query, not about what exists. Scoped tools — a `site:`-filtered search, a
  grep over one directory, a single fetched page — silently encode a guess
  about where the answer lives; when the guess is wrong the tool reports
  nothing and the guess never surfaces.
- **Scope.** Delivered responses and document bodies alike, including a filed
  `claim` whose content is a non-existence assertion — its body carries the
  search space. Thread renders are exempt (verbatim record).

Distinct from
[negate-only-explicit-cases](/meta/policy/negate-only-explicit-cases.md), which
governs *rhetorical* negation in prose (whether a negative sentence has an
anchor). This governs *epistemic* negation: whether a negative claim has been
earned. A worked example, and the seven-host source map that motivated it, is
in
[Anthropic's primary-source surfaces](/meta/analysis/anthropic-primary-source-surfaces.md).
