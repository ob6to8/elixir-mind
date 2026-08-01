---
type: analysis
title: "Is `belief` a superset of the type vocabulary?"
description: Evaluates whether `belief` could subsume the controlled type vocabulary — finds the intuition partly right under a classical belief/knowledge reading, but the architecture deliberately rejected the superset framing twice, because a genus-level belief type erases the failure-mode marker (evidence-repair vs. re-decide-the-direction) the epistemic/teleological split exists to carry, and because commitments, genres, and captures aren't attitudes about the world at all.
provenance: "Claude Code session (2026-08-01) — operator asked for the etymology/epistemology of the type vocabulary and whether belief could be considered a superset of all other types"
tags: [meta, analysis, taxonomy, beliefs, doctrine, type-vocabulary, epistemics]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, classification-definitions-hierarchy session"
  why: "persists the judgment on whether belief subsumes the type vocabulary, requested directly by the operator after a review of the vocabulary's etymology and epistemology"
  from: [/meta/threads/2026-08-01-classification-definitions-hierarchy.md]
---

# Is `belief` a superset of the type vocabulary?

**Question.** Having traced where the controlled `type` vocabulary's entries came
from and what epistemic structure they encode, the operator asked directly:
could `belief` be considered a superset of all the others?

**Answer in one line.** Partly — under a classical belief/knowledge reading,
`belief` is the natural genus for the descriptive tier (`claim`, `note`,
`concept`), and arguably stretches to `doctrine`. But the bundle considered and
rejected the superset framing twice, for reasons that hold independently of
this question being asked a third time, and the rejection generalizes further
than either prior pass stated: the conative types (`plan`, `todo`, `issue`,
`policy`) and the archival types (`reference`, `source`, `person`) are not
attitudes about the world at all, so no reading of "belief" — however wide —
reaches them.

## Where the vocabulary actually came from

The controlled vocabulary in
[controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md) did
not descend from a designed epistemology; it accreted. The seed set (`note`,
`claim`, `concept`, `reference`, `source`, `person`, `project`, `area`,
`snippet`) shipped in the 2026-07-05 greenfield bootstrap, since OKF "requires
a `type` but registers no vocabulary" — `project`/`area` echo PARA, and
`claim`/`concept` echo the classical unverified-assertion vs.
accepted-knowledge split. The governance types (`policy`, `tutorial`, `issue`,
`plan`, `analysis`, `todo`, `methodology`, `elaboration`) were each added later
when a real artifact had no home, per
[governance-artifact-routing](/meta/policy/governance-artifact-routing.md)'s
after-the-fact discriminator: what the thing fundamentally *is*, not how big it
is.

`doctrine` and `belief` are the interesting pair, and both were reasoned about
explicitly rather than merely added. `doctrine` shipped first, as the
"standing direction" type. `belief` followed an external ChatGPT dialogue run
against the bundle on 2026-07-13, distilled in
[second-mind-taxonomy-and-the-belief-gap](/meta/analysis/second-mind-taxonomy-and-the-belief-gap.md):
a belief says "I think the world works this way" (epistemic); a doctrine says
"given that, this is the standing direction" (teleological); and critically,
"doctrine is not belief with more confidence — two people can share a belief
and hold opposite doctrines." That analysis found the gap — operator-held,
value-laden priors like "prefer depth over reach" had no type — and the
[belief-layer plan](/meta/plans/belief-type-and-beliefs-namespace.md) shipped
`belief` on 2026-07-26, deliberately narrow: "an operator-held, value-laden
decision prior … held *true enough to guide action* even where unverifiable,
uncertain, or normative," kept outside the verification ladder by construction
(a belief that turns out checkable is refiled as a `claim`).

## The epistemic structure the vocabulary encodes

[is-to-ought-belief-grounds-doctrine](/meta/analysis/is-to-ought-belief-grounds-doctrine.md)
(updated 2026-07-27, after `belief` shipped) is the bundle's own account, and
its corrected four-tier stack is the reference point for this question:

| Tier | Register | Type / home | Answers |
|------|----------|-------------|---------|
| Statement | descriptive (*is*, checkable) | `claim`/`note`/`concept` | What is the case? |
| Belief | value-laden prior (*act as if*) | `belief`, `/beliefs/` | What do I hold true enough to act on? |
| Doctrine | normative direction (*ought*, general) | `doctrine` | What should guide design and priorities? |
| Policy | normative rule (*ought*, enforceable) | `policy` → `CLAUDE.md` | What must an agent do? |

Everything in this stack is an **attitude toward a proposition** — held with
different degrees of checkability and different repair mechanisms when wrong.
Everything *outside* it — `plan`, `todo`, `issue` (commitments to future
action), `reference`, `source`, `person`, `project`, `area`, `snippet`
(archival captures of the world), `tutorial`, `elaboration`, `analysis` itself
(explanatory genres) — is not a member of this stack at all. A `todo` is not
a belief about anything; it is an intention. A `reference` is not a belief;
it is a stored fact about what some external source said. This is the
question's own boundary before any resolution: superset-of-what, exactly.

## The case for the superset reading

Classical epistemology treats belief as the genus of which knowledge is a
justified, true species (the standard "justified true belief" analysis). Read
this way:

- A `claim` is a belief not yet justified (`verified: false`).
- A `concept` is a belief that got justified (`verified: true`, graduated).
- A `note` is a belief nobody has bothered to grade.
- `doctrine` stretches further: "we ought to prioritize X" is itself a
  (normative) belief, on a Bayesian reading where credence just varies in
  confidence and kind rather than forming discrete types.

Under this reading `belief` is the natural umbrella for the entire descriptive
tier and arguably the normative-direction tier too — four of the sixteen-odd
types in one genus. This is a real and correct observation, not a
misreading — the bundle's own analyses concede the underlying logic (see next
section) rather than disputing the philosophy.

## Why the architecture rejected it anyway — twice

**First rejection**, in the original (pre-shipping)
[is-to-ought analysis](/meta/analysis/is-to-ought-belief-grounds-doctrine.md):
a broad descriptive `belief` type was proposed and refused because "the
descriptive work is already covered by `claim`/`note`/`concept`, so a `belief`
type would collide with them." The type that eventually shipped escapes that
collision only because it is defined **residually** — belief is what remains
*after* subtracting the checkable (claim/concept territory) and the
teleological (doctrine territory). Widen `belief` back to the genus and the
collision returns immediately: every `claim` would also legitimately be a
`belief`, and the type system would stop discriminating anything.

**Second rejection**, implicit in the same analysis's discussion of failure
modes: "When a belief is wrong it is *false*, and the fix is to correct it
against evidence. When a doctrine is wrong it is *misguided*, and the fix is
to re-decide the direction. Conflating them means applying the wrong repair —
arguing evidence at a values disagreement, or asserting a preference where a
fact is in dispute." A superset type erases exactly the marker that tells an
agent which repair applies. The type name is not decorative; it is the
dispatch key for what happens when the statement turns out wrong.

**The general pattern**, from
[second-mind-taxonomy-and-the-belief-gap](/meta/analysis/second-mind-taxonomy-and-the-belief-gap.md)'s
Finding 2: the bundle consistently trades expressiveness for checkability —
"the bundle's binary `verified` plus machine-checked evidence edges trades
expressiveness for checkability — the right trade for a corpus agents
maintain," rejecting confidence-scored beliefs on the same ground ("free-
floating probabilities with no oracle; they rot silently"). A genus-level
`belief` with internal sub-flavors is the same trade in a different guise: one
type whose important distinctions move into unenforceable prose or metadata,
versus the current scheme where the distinction *is* the type and the verifier
gates directly on it (`claim`/`note`/`concept` alone are eligible for
`verified`; `belief` is categorically excluded).

## What no reading of "belief" reaches

Even granting the widest defensible philosophical reading — extending belief
to cover doctrine as normative credence — the superset stops at the boundary
between attitude and non-attitude, which the classical **direction of fit**
distinction names precisely: a belief has mind-to-world fit (revised when the
world disagrees), while an intention or commitment has world-to-mind fit (when
reality disagrees with a plan, the fix is to act on the world, not to revise
the plan). On this ground:

- **`plan`, `todo`, `issue`, `policy` are commitments, not beliefs.** A `todo`
  under [governance-artifact-routing](/meta/policy/governance-artifact-routing.md)
  is "a plain task to complete" — there is no proposition it asserts that could
  be true or false. A `policy` is an enforceable rule; violating it is
  non-compliance, not falsification.
- **`reference`, `source`, `person`, `project`, `area`, `snippet` are
  archival captures, not attitudes.** Per
  [verification-grounding](/meta/policy/verification-grounding.md), "a
  document that stores a link — anything carrying a `resource` — is a
  **capture**, not a statement: verification is **not possible** for it." A
  saved PDF is not something anyone believes; it is evidence that could ground
  a belief.
- **`analysis`, `tutorial`, `elaboration` are explanatory genres, not
  propositions themselves** — an `analysis` *contains* claims and
  recommendations, but the document-type is a container shape, not the
  assertoric content inside it.

So the maximal honest superset is: `belief` genuinely subsumes
`claim`/`note`/`concept` (the descriptive tier) under the classical reading,
and arguably `doctrine` (the normative-direction tier) under an extended
Bayesian-credence reading — four of roughly sixteen types. It reaches none of
the conative types and none of the archival types, regardless of how the
definition of belief is stretched, because those types are not held true at
all; they are held-*to* or held-*as-evidence*.

## Recommendation

Do not widen `belief` to a genus. The narrow, residual definition
([controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md)) is
load-bearing precisely because it is narrow: it is what lets the type name
double as a repair-mode dispatch key and lets the verifier mechanically
exclude `belief` from the checkability machinery. The correct statement of the
relationship is *containment within the descriptive-and-normative attitude
family*, not *supersession of the vocabulary* — and that family is itself a
minority of the controlled types, alongside the conative and archival
families the belief concept was never meant to, and cannot coherently, cover.

If a query needs "which types are attitudes I hold, in some sense, true?"
the answer is exactly the four-tier stack in
[is-to-ought-belief-grounds-doctrine](/meta/analysis/is-to-ought-belief-grounds-doctrine.md);
if it needs "which types could I file this under" the
[governance-artifact-routing](/meta/policy/governance-artifact-routing.md)
discriminator table is the tool, and it is a category error to reach for
`belief` there for anything outside that four-tier stack.
