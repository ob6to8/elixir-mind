---
id: em:d1ba60
type: belief
depends_on: [em:189d88]
title: A surface that must be remembered will be forgotten
description: The decision prior behind preferring generation over discipline — an obligation to update a hand-kept surface is carried by memory, which fails silently and at unpredictable intervals, while a derived surface cannot fall out of date because nothing is being remembered.
provenance: "Agent-authored synthesis, 2026-07-28 — the unstated prior in the policy-index-gloss recommendation, surfaced when the operator decomposed that passage into base and inferred statements"
tags: [belief, staleness, generated-artifacts, freshness, maintenance, epistemics]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "operator directed filing the prior that turns the freshness-gate observation into a design recommendation; the two analytic statements around it were already filed as a concept"
---

# A surface that must be remembered will be forgotten

The belief, as stated:

> "A surface that must be remembered will eventually be forgotten; a surface
> that is derived cannot be."

**This belief depends on
[freshness gate](/beliefs/glossary/freshness-gate.md):** *given* that a
freshness gate can only cover an artifact that is derivable — it re-derives and
compares, so with no source to re-derive from there is nothing to compare — the
question of what to do about hand-kept surfaces is left open. This belief closes
it, and it is the step that turns an observation about gate mechanics into a
design preference.

The distinction it rests on is between two ways a document stays current. One
routes through an agent noticing an obligation and discharging it; the other
routes through a computation that runs whether anyone remembered or not. The
first fails **silently** — nothing announces that a gloss went stale — and at
intervals nobody can predict, because the failure depends on attention at a
moment already occupied by the change that caused it. The second has no failure
mode of that kind: a derived surface is not remembered, so it cannot be
forgotten.

**Why it is a belief and not a claim.** It is not empirically settled, and it is
not the kind of thing this bundle could settle — it asserts something about how
agents and people behave under standing obligations, held true enough to act on
rather than proven. It is also normative in effect: it says the burden of proof
belongs on the hand-kept option, not the generated one. A `claim` would expect
evidence; this expects a decision.

**What it rules out.** Answering a recurring staleness problem with a rule that
asks future sessions to remember. That answer is available, cheap, and this
belief holds it insufficient on its own — the rule may still be worth stating,
but it is a mitigation rather than a fix.

**Where it is acted on.** The
[policy-index gloss issue](/meta/issues/policy-index-glosses-drift-on-policy-edits.md)
weighs three fixes and leans toward generating the gloss; this belief is the
reason that lean exists rather than an appeal to consistency. The same prior
produced the purge of hand-kept `log.md` files in favor of the commit graph, and
the `--materialize`/`--check` shape shared by the contract, registry, code map,
lineage, and route-tag logs.

**Its limit.** Generation is only available where the surface is genuinely
derivable from something else. Where it is not — a prose argument, a judgment
call, an operator's own words — the belief offers no escape and the obligation
stays with memory. It argues for converting surfaces that *can* be derived, not
for pretending all of them can be. This is the boundary it shares with
[derived views stay disposable](/meta/doctrine/derived-views-stay-disposable.md),
which governs the same seam from the other side: that doctrine forbids a derived
view from becoming a second source of truth, while this belief pushes hand-kept
surfaces toward being derived. Together they bound the direction of travel —
toward derivation, but never past the point where the files stop being the truth.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:d1ba60">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-secure-financial-agent-and-projects-namespace (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:d1ba60`]**

Your instinct that something belief-shaped is in that passage is right — it's just one step further along than either sentence you quoted. Neither of those gets you to a recommendation. The jump I actually made was from *"ungateable"* to *"therefore prefer generating the surface,"* and that jump needs a prior the analytic statements don't supply:

> **A surface that must be remembered will eventually be forgotten; a surface that is derived cannot be.**

That one is value-laden, not empirically settled, and action-guiding — it's a claim about how agents and humans behave under a standing maintenance obligation, and it's what turns an observation about gate mechanics into an argument for generating the policy index.
