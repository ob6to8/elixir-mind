---
type: reference
title: 2026-08-01-classification-definitions-hierarchy
description: The operator asked for the etymology and epistemology of the controlled type vocabulary and whether `belief` could be a superset of all other types; the session traced each type's origin through the policy and plan history and answered no, filing the judgment as an analysis.
provenance: "Claude Code session, 2026-08-01; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, taxonomy, beliefs, doctrine, type-vocabulary, epistemics]
timestamp: 2026-08-01
session: https://claude.ai/code/session_01JQEjTpEGuxHfNqdvjNKDLn
pr: 218
---

# 2026-08-01-classification-definitions-hierarchy

## Where this landed

The operator asked for the etymology, epistemology, and definitions of the
bundle's controlled `type` vocabulary, and then asked directly whether
`belief` could be a superset of all the other types. The session read the
controlled-type-vocabulary policy plus the plans and analyses that shaped it
(the belief-layer plan, the second-mind-taxonomy analysis, the is-to-ought
analysis, the concept-terminology plan, and the glossary hub) and answered
both questions in chat. The operator then asked for the belief-as-superset
judgment to be persisted as an analysis and the session closed via
`/create-pull-request merge`. The analysis is filed as
[belief-as-superset-of-the-type-vocabulary](/meta/analysis/belief-as-superset-of-the-type-vocabulary.md):
the classical belief/knowledge reading genuinely subsumes the descriptive
tier (and arguably doctrine), but the bundle rejected the superset framing
twice — a genus-level `belief` collides with `claim`/`note`/`concept` and
erases the repair-mode marker the epistemic/teleological split exists to
carry — and no reading of "belief" reaches the conative types (`plan`/`todo`/
`issue`/`policy`) or the archival captures (`reference`/`source`/`person`),
which are not attitudes about the world at all.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Etymology/epistemology of the type vocabulary; whether `belief` supersets the other types | closed | [belief-as-superset-of-the-type-vocabulary](/meta/analysis/belief-as-superset-of-the-type-vocabulary.md) | - |
| Direction-of-fit distinction (belief vs. commitment) used to bound the superset claim | closed | [direction of fit](/beliefs/glossary/direction-of-fit.md) | - |

## User

what is the etymology/epistemology/definitions of the classifications/types in this repo? ie. analysis, plan, concept, note, gloss, definition (glossary). belief, etc

is it possible beliefs could in fact be considered a superset of all others?

## Assistant

This is a question about the intellectual history and epistemic structure of the type vocabulary, so let me ground the answer in the actual source documents — the policies that define each type, and the plans/threads where each was ratified — rather than answering only from the compiled contract.

I have the full picture now. Per the link policy, let me get proper GitHub URLs for the documents I'll cite:

## The short version first

Your type vocabulary wasn't designed top-down from a philosophy — it accreted, one operator-ratified addition at a time, and the repo has actually litigated its own epistemology twice in filed analyses. The types sort into three epistemic families: things held **true** (claim, note, concept — on a verification ladder), things held **to** (doctrine, policy — directions and rules, which can't be true or false, only wise or misguided), and things merely **recorded** (reference, source, person — captures of the world, not attitudes about it). `belief` was deliberately carved as a narrow *fourth* register between the first two — what you act *as if* is true — not as an umbrella.

On your superset question: philosophically you're half right, and the repo's own documents say so — but the architecture deliberately rejected the superset framing, twice, for reasons that are recorded and I think sound. Details below.

## Etymology — how each type actually got here

**The seed set (2026-07-05 bootstrap).** `note`, `claim`, `concept`, `reference`, `source`, `person`, `project`, `area`, `snippet` came from the greenfield OKF bootstrap. OKF itself requires a `type` but "registers no vocabulary," so this list was invented here — loosely borrowing PARA vocabulary (`project`/`area` are straight out of Forte's second-brain method) and a claim/concept distinction that mirrors classical epistemology's unverified-assertion vs. accepted-knowledge split.

**The governance accretion (July 2026, ongoing).** `policy`, `tutorial`, `issue`, `plan`, `analysis`, `todo`, `methodology`, `elaboration` were each added when a real artifact had no home. Their names follow the repo's [prefer-established-terminology policy](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/prefer-established-terminology.md) — all are standard terms of art (issue trackers, ADR-style plans, etc.) rather than coinages. The [governance-artifact-routing policy](https://github.com/ob6to8/elixir-mind/blob/main/CLAUDE.md) is the after-the-fact rationalization of that growth: each type is discriminated by *what the thing fundamentally is* (a judgment → analysis, a problem → issue, a task → todo, a proposed change → plan, a rule → policy).

**`doctrine`, then `belief` — the interesting pair.** `doctrine` came first, as "the why that informs judgment without prescribing a specific enforceable action." Then on 2026-07-13 the operator ran an external ChatGPT dialogue ("Second brain distinctions") against the bundle, and the resulting [second-mind taxonomy analysis](https://github.com/ob6to8/elixir-mind/blob/main/meta/analysis/second-mind-taxonomy-and-the-belief-gap.md) found the dialogue's one sharp idea was the epistemic/teleological split: "a *belief* says 'I think the world works this way' (epistemic); a *doctrine* says 'given that, this is the standing direction' (teleological); and doctrine is not belief with more confidence — two people can share a belief and hold opposite doctrines." That exposed a real gap — `/beliefs/` held no beliefs, and operator priors like "prefer depth over reach" had no type — and the [belief-layer plan](https://github.com/ob6to8/elixir-mind/blob/claude/classification-definitions-hierarchy-mlsy9p/meta/plans/belief-type-and-beliefs-namespace.md) shipped the type on 2026-07-26.

**Glossary terms are not a type.** A glossary entry is a `type: concept` file under `/beliefs/glossary/`, one per term, with a `sense` field (`common`/`repo`/`dual`) saying whether the term is portable vocabulary or repo jargon. The "gloss" is the standard lexicographic sense: the one-line `description` rendered beside each link in `index.md` listings. And per the [glossary hub](https://github.com/ob6to8/elixir-mind/blob/claude/classification-definitions-hierarchy-mlsy9p/beliefs/glossary.md), for contract-defined terms the policy wording is the authority (defines by *role*) and the glossary entry is a deferring restatement (defines by *function*).

**One known incoherence, on the record.** The [concept-terminology plan](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/concept-terminology-and-type-redefinition.md) (status: proposed, part 2 open) found that `type: concept` is "two different things sharing a name": ~98% of the corpus is glossary term-definitions (unverified), while the type is *also* the graduation target for verified claims — a proposition and a definition are different speech acts, and "(established/accepted)" is checked by nothing. That's an open question awaiting your ratification.

## Epistemology — the structure the types encode

The [is-to-ought analysis](https://github.com/ob6to8/elixir-mind/blob/claude/classification-definitions-hierarchy-mlsy9p/meta/analysis/is-to-ought-belief-grounds-doctrine.md) (updated 2026-07-27) is the repo's own epistemology paper, and its corrected stack is the cleanest summary:

| Tier | Register | Type / home | Answers |
|------|----------|-------------|---------|
| Statement | descriptive (*is*, checkable) | `claim`/`note`/`concept` | What is the case? |
| Belief | value-laden prior (*act as if*) | `belief`, `/beliefs/` | What do I hold true enough to act on? |
| Doctrine | normative direction (*ought*, general) | `doctrine` | What should guide design and priorities? |
| Policy | normative rule (*ought*, enforceable) | `policy` → `CLAUDE.md` | What must an agent do? |

Three structural features do the epistemic work:

- **The verification ladder** applies only to the descriptive tier: `claim` (asserted, `verified: false`) → backed by `source` captures via `verified_by` → `verified: true` → may graduate to `concept`. Machine-enforced: the verifier rejects `verified` on any other type.
- **Captures vs. statements**: a `reference` or `source` stores the world (it carries a `resource`); it can't be verified because it asserts nothing — it's evidence, not a claim.
- **The three-way filing test** is the boundary logic: "epistemic (what is true) files as `claim`/`concept`; value-laden prior (what I act as if is true) files as `belief`; teleological (what standing direction) files as `doctrine`." And the boundary is self-repairing: a belief that turns out empirically checkable is *refiled* as a claim — "the type boundary is the test."

The remaining types are outside epistemology entirely: `plan`/`todo`/`issue` are commitments and trackers (work, not propositions); `tutorial`/`elaboration`/`analysis` are explanatory genres; `project`/`area`/`person`/`snippet` are organizational.

## Could `belief` be a superset of the others?

**Philosophically: yes, for about half the vocabulary — and the repo's own analysis concedes the underlying point.** In mainstream epistemology, belief *is* the genus: knowledge is classically justified true belief, so a `claim` is a belief awaiting justification, a `concept` is a belief that got it, and a `note` is a belief you haven't bothered to grade. You can even stretch it to `doctrine` — "I believe we ought to prioritize X" is a normative belief. On a Bayesian reading, everything assertoric is just credence at different confidence levels, and `belief` names the genus.

**Architecturally: no, and the rejection was deliberate, not an oversight.** Four recorded reasons:

1. **It was proposed and refused — twice.** The original is-to-ought analysis rejected a broad belief type precisely because "the descriptive work is already covered by `claim`/`note`/`concept`, so a `belief` type would collide with them." The 2026-07-27 update shows the type that shipped escapes the collision *only because it's narrow*: `belief` is defined **residually** — it's what remains after you subtract the checkable and the teleological. Widen it to the genus and the collision returns.

2. **Different failure modes need different repairs.** From the is-to-ought analysis: "When a belief is wrong it is *false*, and the fix is to correct it against evidence. When a doctrine is wrong it is *misguided*, and the fix is to re-decide the direction." A superset type erases the marker that tells an agent *which repair to apply* — argue evidence, or re-decide values. That distinction is the whole reason the split exists.

<routes ref="em:2b2532">
3. **Direction of fit.** This is the strongest philosophical objection to full subsumption (my synthesis, not a repo doc): beliefs have mind-to-world fit — they're revised when the world disagrees. Plans, todos, and policies have world-to-mind fit — when reality disagrees with a plan, you change *reality* (do the work), not the plan. A `todo` is not a belief about anything; it's an intention. And captures (`reference`, `source`, `person`) aren't attitudes at all — a PDF you saved isn't something you believe. So even the maximal philosophical superset covers only `claim`/`note`/`concept`/`belief` and arguably `doctrine` — never the conative or archival types.
</routes>

4. **The repo trades expressiveness for checkability.** The taxonomy analysis rejected confidence-scored beliefs as "free-floating probabilities with no oracle; they rot silently." A genus-`belief` with sub-flavors is the same trade in disguise: one type whose important distinctions live in unenforceable metadata, versus the current scheme where the distinction *is* the type and the verifier can gate on it.

**The defensible version of your intuition:** `belief` is the superset *register* for everything assertoric — and the repo effectively treats the verification ladder as a machine for sorting beliefs by evidential status, with `belief`-the-type reserved for the ones evidence can't sort. What it can never absorb are the types that aren't held-true at all: the commitments (`plan`, `todo`, `policy`), the genres (`analysis`, `tutorial`), and the captures. If you want this settled as a filed position, it would make a good `analysis` (or a `belief` about beliefs, which has a pleasing recursion to it) — say the word and I'll file it.

## User

create an analysis doc
then
/create-pull-request  merge

## Assistant

Good, on the right branch, clean tree. Now let me write the analysis doc. Per the persist-plans/analysis conventions, this is a governance doc (`meta/analysis/`), no `em:` id, needs `attribution` (with `from` filled in by `/create-pull-request` later per its step 3 — I should leave it inline-filed per the intake norm, and `/create-pull-request` will stamp `from`).
