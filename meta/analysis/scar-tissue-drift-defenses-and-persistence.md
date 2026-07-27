---
type: analysis
title: "Does scar-tissue drift threaten this bundle, and where should the framing live?"
description: Maps the 300-hour-run post's three countermeasures onto the bundle's machinery — the "immutable baseline" is here as the ratification-gated contract plus the unconditional gate suite, "receipts" as the attribution property and thread capture, while "behavioral fingerprinting" is the real gap (only recall and freshness are trended; nothing measures style drift across intakes) — and finds the scar-tissue framing itself is epistemic, not a value-laden prior, so it files as a glossary concept, not a belief, even once the proposed belief type is ratified.
provenance: "Claude Code session (2026-07-27) — operator asked for an analysis of the scar-tissue source against this repo, focusing on the post's three action items and the comment insights, and whether the framing should persist as a belief"
tags: [meta, analysis, drift, agent-reliability, ratification, attribution, fingerprinting, beliefs, type-vocabulary]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator dialogue on the code-cleanliness-trust branch"
  why: "operator asked how the scar-tissue post's three action items and comment insights map onto this repo, and how the framing itself should be persisted — perhaps as a belief"
  from: [em:60242a]
---

# Does scar-tissue drift threaten this bundle, and where should the framing live?

**Question.** The [scar-tissue capture](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md)
(`em:60242a`) describes a 300-hour autonomous run whose coding style mutated
through four individually-rational local fixes that compounded into an
incoherent effective policy. The post proposes three countermeasures — an
immutable hour-zero baseline, forced "receipts," and behavioral
fingerprinting. The operator asks: how do those three, plus the comment
thread's insights, map onto this repo? And how should the scar-tissue framing
itself be persisted — perhaps as a `belief`?

## The mechanism, stated precisely

Scar tissue is not context degradation. The post's agent wasn't failing to
*retrieve* its goal ([context rot](/beliefs/glossary/context-rot.md)); it was
succeeding at retrieving the wrong thing — each local fix silently promoted
itself into standing behavior, and the *set* of promoted fixes became the
agent's effective policy. One commenter (MacFall-7) states the invariant that
was violated almost as a specification:

> Persistent state and locally approved fixes accumulate into a new effective
> policy unless every material adaptation is bound, tested and revalidated
> against an immutable behavioral contract.

That sentence is, nearly clause for clause, a description of this bundle's
architecture. The analysis below is therefore less "should we adopt the three
countermeasures" than "which of the three are already load-bearing here, in
what form, and where is the honest gap."

## Countermeasure 1 — the immutable hour-zero baseline

**Status: present, in a stronger form than the post proposes.**

The post's version: freeze a behavioral baseline at hour zero and audit
against it, because comparing an agent to its own most recent output uses a
ruler that decays with the thing measured. A top commenter sharpens it: treat
the baseline as a *test suite* of frozen invariants that runs on a schedule,
not just when something breaks.

This bundle's version is exactly that, with one deliberate amendment:

- **The baseline is the [operating contract](/CLAUDE.md)** — compiled from
  ratified policy, never hand-edited, and binding on every agent including
  fresh sandboxed ones. An agent cannot "adapt" the contract mid-run; the only
  write path is a policy edit, which is a shape change requiring operator
  ratification.
- **The scheduled re-validation is the gate suite** — `mix brain.verify`,
  `brain.contract --check`, `brain.registry --check`, `brain.route_tags` — run
  unconditionally in CI and pre-commit on every commit, not on failure. The
  [render-contract analysis](/meta/analysis/render-contract-invocation-and-auto-render.md)
  already established the design principle: the check is *unconditional
  re-derivation plus byte-compare*, so a stale artifact cannot merge.
- **The amendment: the baseline is ratification-mutable, not immutable.** A
  truly immutable baseline cannot learn; a growing brain must. What the
  scar-tissue failure actually requires is not that the baseline never change
  but that it never change *through the agent's own adaptations*. Here the
  distinction between learning and drift is procedural — **who approved it** —
  and that is precisely what the
  [taxonomy-evolution protocol](/meta/policy/taxonomy-evolution-protocol.md)
  and ratification gates encode. The post's hour-241 hybrid workaround is
  impossible as standing behavior here: there is no channel by which it could
  become a rule without passing the operator.

There is even a literal instance of the post's frozen-baseline idea: the
[dedup probe](/meta/evals/dedup-probe.md) commits its `## Baseline` table and
keeps the trend in git history, so recall is always measured against a
recorded prior state, never against "how it did yesterday."

## Countermeasure 2 — forced receipts

**Status: present; it is the resource-attribution property.**

The post: when an agent adapts, force it to log the trigger condition
alongside the new rule — "I am modifying my behavior because X just
happened" — so no one reverse-engineers the rationale 200 hours later.

This bundle writes that receipt at every layer where behavior can change:

- **Per document**: the `attribution` map (`when`/`channel`/`agent`/`why`) is
  a write-once record of the trigger for every filing — and it is
  machine-enforced, immutable after write, which is stronger than the post's
  voluntary logging (the 300-hour agent *dropped* its trigger context; an
  immutable required field cannot be dropped).
- **Per rule**: governance docs carry append-only `attribution.from`, tracing
  each policy/plan/analysis back to the thread it came out of. A rule here
  cannot exist without its receipt chain: thread → governance doc → ratified
  policy → compiled contract.
- **Per change**: commits carry session trailers; `/capture` freezes the
  session that produced the change; the
  [merge-strategy policy](/meta/policy/merge-strategy.md) keeps those commits
  reachable forever precisely so the receipts stay auditable.

The comment thread's "behavior change log" is thus not something to add — it
is the bundle's provenance layer, already structural. The one nuance worth
naming: attribution records *filing* events, not *behavior-change* events.
That is sufficient here because in this architecture behavior changes **are**
filings (a policy edit is the only way behavior changes), which is itself the
anti-scar-tissue design decision.

## Countermeasure 3 — behavioral fingerprinting

**Status: the genuine gap.**

The post: track a rolling fingerprint of style metrics (verbosity, retry
density, error-message tone) to catch invisible drift before it breaks logic.
A commenter adds diff size and policy-violations-per-hour.

What this bundle trends today: dedup-probe plain recall (the committed
baseline), docs-freshness warnings, and the route-tags coverage cross-check —
all *structural* signals. What nothing measures is **style drift across the
corpus itself**: description length distributions, tag-vocabulary sprawl,
body verbosity, distillation depth across successive intakes. The
[auto-intake channel](/meta/plans/auto-intake-featured-research.md) is the
exposure that matters — an agent filing documents daily whose *shape* the
verifier checks but whose *style* nothing watches. Two governance docs
already circle this hole from different sides:
[cognitive debt](/beliefs/glossary/cognitive-debt.md) names the operator-side
cost of unwatched accretion, and the
[escape-rate plan](/meta/plans/auto-intake-escape-rate-sampling.md) proposes
the quality-defect fingerprint (sampled escape rate on an independent oracle —
the [tier-3/4 analysis](/meta/analysis/tier-3-4-interface-and-trust-determination.md)
even specifies that drift in that metric is a demotion signal, which *is*
behavioral fingerprinting under another name).

**Recommendation**: treat style fingerprinting as a candidate metric inside
the escape-rate plan's orbit rather than a new subsystem — e.g. a small
`mix brain.fingerprint` emitting per-intake style statistics with a committed
baseline table, exactly the dedup-probe pattern (warn-and-trend, never fail).
Not filed as a todo here; the operator should say whether it earns one.

## The comment insights, mapped

- **Context-share erosion** (retsof81: the original goal becomes a shrinking
  fraction of context until artifacts crowd it out) — countered here by the
  session model itself: sessions are bounded, `/capture` freezes them, and
  durable state lives in the bundle, not the context window
  ([fresh-context execution](/beliefs/glossary/fresh-context-execution.md)).
  One commenter's quip that humans "/clear every night" is this bundle's
  actual design: the brain persists; sessions are disposable.
- **Quirks mistaken for instructions** (I_NEED_YOUR_MONEY: the agent
  eventually says "pinned to 2.1.1 as per instructions" about a workaround it
  invented) — this is the sharpest comment in the thread, and the bundle's
  answer is the **policy/instance split**: instructions have exactly one
  provenance-tracked source (ratified policy compiled into the contract), so
  a quirk cannot masquerade as an instruction — its receipt chain would be
  missing.
- **Parent/child auditing** (a parent agent holds intent and re-tasks
  drifting children) — here the operator *is* the parent, with `/priorities`
  as the realignment instrument; the
  [workflow fan-out analysis](/meta/analysis/executing-ratified-plans-via-workflow-fan-out.md)
  formalizes the child side (fresh-context subagents scoped by a plan they
  cannot amend).
- **Durable structured memory over ad hoc context** (turlockmike: vector
  recall plus a file system acting as a graph DB) — an unwitting description
  of an OKF bundle: typed documents, stable ids, links as edges, a compiled
  registry.

## Where should the framing persist? On "perhaps as a belief"

Three candidate homes, judged against the vocabulary:

1. **`belief` — no, twice over.** First, the
   [belief type is `proposed`, unratified](/meta/plans/belief-type-and-beliefs-namespace.md);
   filing one now would jump the gate. Second — and decisive even after
   ratification — the plan's own filing test says *epistemic (what is true)
   files as claim/concept; value-laden prior (what I act as if is true) files
   as belief*. "Agents accumulate scar tissue" is a mental model of how
   long-running agents fail: epistemic, checkable in principle, already
   evidenced by the capture. It is not an operator value. Forcing it into
   `belief` would blur exactly the boundary the plan exists to draw.
2. **`doctrine` — no.** The standing-direction version ("no agent adaptation
   becomes standing behavior without ratification") is not a new direction —
   it is a *description of existing policy* (ratification + compiled
   contract). A doctrine restating enforced policy would be redundant with
   its own implementation.
3. **Glossary `concept` — yes.** "Scar tissue" is field vocabulary (the
   capture is its *Seen in*), it names a distinct failure mode not covered by
   the existing drift cluster ([context rot](/beliefs/glossary/context-rot.md)
   = retrieval degradation; [cognitive debt](/beliefs/glossary/cognitive-debt.md)
   = operator comprehension lag; [cross-reference drift](/beliefs/glossary/cross-reference-drift.md)
   = stale interlinks; scar tissue = **policy accretion from local fixes**),
   and the glossary machinery — one `concept` per term, `em:` id, citable
   from any response or analysis — is built for exactly this. Filing it is
   autonomous (existing type, existing directory, existing channel).

**Recommendation**: file `scar tissue` as a glossary concept now (done
alongside this analysis), and let the framing feed the belief layer only if
the operator later distills a genuine prior from it (e.g. "I act as if any
unratified adaptation channel will eventually drift" *would* be a `belief`
once the type exists — that phrasing is value-laden and unfalsifiable in the
plan's sense).

## Verdict

The bundle is, by construction, an anti-scar-tissue architecture: the post's
countermeasures 1 and 2 are not recommendations to adopt but descriptions of
the ratification gate and the attribution/provenance layer already in force.
The honest exposure is countermeasure 3 — nothing fingerprints style drift in
the agent-driven accretion channels (auto-intake, glossary), and the editorial
checks that would catch it warn rather than fail, which delegates detection to
an operator whose [cognitive debt](/beliefs/glossary/cognitive-debt.md) grows
with the corpus. The cheapest honest fix follows the dedup-probe pattern:
committed style baseline, trend in git history, warn on divergence —
a candidate rider on the escape-rate plan, awaiting the operator's call.
