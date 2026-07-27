---
type: analysis
title: "Does scar-tissue drift threaten this bundle, and where should the framing live?"
description: Maps the 300-hour-run post's three countermeasures onto the bundle's machinery — the "immutable baseline" exists here in a stronger, ratification-mutable form and "receipts" are the attribution/provenance layer already in force, while behavioral fingerprinting is the real gap, anatomized into three measurable style surfaces across the agent-writing channels — and resolves the persistence question by decomposing "scar tissue" into three statements of different epistemic kinds: a lexical fact (glossary concept), an aptness claim (verification ladder), and the operator's adoption of the lens as a working frame (genuinely belief-shaped; a candidate seed belief for the proposed belief layer). Recommends a new quote-seeded doctrine, "bound adaptation," as the citable anchor the ratification policies implement.
provenance: "Claude Code session (2026-07-27) — operator asked for an analysis of the scar-tissue source against this repo, focusing on the post's three action items and the comment insights, and whether the framing should persist as a belief; revised same-day at operator request (redo on the intended model), absorbing the operator's follow-up questions on doctrine placement, fingerprint mechanics, tag epistemics, and the analogy-adoption argument"
tags: [meta, analysis, drift, agent-reliability, ratification, attribution, fingerprinting, doctrine, beliefs, type-vocabulary]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator dialogue on the code-cleanliness-trust branch"
  why: "operator asked how the scar-tissue post's three action items and comment insights map onto this repo, and how the framing itself should be persisted — perhaps as a belief"
  from: [em:60242a, /meta/threads/2026-07-27-scar-tissue-drift-doctrine-and-link-policy.md]
---

# Does scar-tissue drift threaten this bundle, and where should the framing live?

**Question.** The [scar-tissue capture](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md)
(`em:60242a`) describes a 300-hour autonomous run whose coding style mutated
through four individually-rational local fixes that compounded into an
incoherent effective policy. The post proposes three countermeasures — an
immutable hour-zero baseline, forced "receipts," and behavioral
fingerprinting. Three questions follow for this repo: which of the three are
already load-bearing here, and in what form; where exactly is the gap, and
what would close it; and how should the scar-tissue framing itself be
persisted — perhaps, as the operator asked, as a `belief`?

## The mechanism, stated precisely

Scar tissue is not context degradation. The post's agent wasn't failing to
*retrieve* its goal ([context rot](/beliefs/glossary/context-rot.md)); it was
succeeding at retrieving the wrong thing — each local fix silently promoted
itself into standing behavior, and the *set* of promoted fixes became the
agent's effective policy. One commenter (MacFall-7) states the violated
invariant almost as a specification:

> Persistent state and locally approved fixes accumulate into a new effective
> policy unless every material adaptation is bound, tested and revalidated
> against an immutable behavioral contract.

That sentence is, nearly clause for clause, a description of this bundle's
architecture — a point taken up below under *the doctrine question*, because
a sentence that good deserves a better home than a Reddit comment thread.

## Countermeasure 1 — the immutable hour-zero baseline

**Status: present, in a stronger form than the post proposes.**

The post's version: freeze a behavioral baseline at hour zero and audit
against it, because comparing an agent to its own most recent output uses a
ruler that decays with the thing measured. A top commenter sharpens it: treat
the baseline as a *test suite* of frozen invariants run on a schedule, not
just when something breaks.

This bundle's version is exactly that, with one deliberate amendment:

- **The baseline is the [operating contract](/CLAUDE.md)** — compiled from
  ratified policy, never hand-edited, binding on every agent including fresh
  sandboxed ones. An agent cannot "adapt" the contract mid-run; the only
  write path is a policy edit, a shape change requiring operator ratification.
- **The scheduled re-validation is the gate suite** — `mix brain.verify`,
  `brain.contract --check`, `brain.registry --check`, `brain.route_tags` —
  run unconditionally in CI and pre-commit on every commit, not on failure.
  The [render-contract analysis](/meta/analysis/render-contract-invocation-and-auto-render.md)
  established the operative principle: unconditional re-derivation plus
  byte-compare, so a stale artifact cannot merge.
- **The amendment: the baseline is ratification-mutable, not immutable.** A
  truly immutable baseline cannot learn; a growing brain must. What the
  scar-tissue failure actually requires is not that the baseline never change
  but that it never change *through the agent's own adaptations*. Here the
  distinction between learning and drift is procedural — **who approved it** —
  which is precisely what the
  [taxonomy-evolution protocol](/meta/policy/taxonomy-evolution-protocol.md)
  and the ratification gates encode. The post's hour-241 hybrid workaround is
  unrepresentable as standing behavior here: there is no channel by which it
  could become a rule without passing the operator.

There is even a literal instance of the post's frozen-baseline idea already
in service: the [dedup probe](/meta/evals/dedup-probe.md) commits its
`## Baseline` table and keeps the trend in git history, so recall is always
measured against a recorded prior state, never against "how it did
yesterday."

## Countermeasure 2 — forced receipts

**Status: present; it is the resource-attribution property.**

The post: when an agent adapts, force it to log the trigger condition
alongside the new rule — "I am modifying my behavior because X just
happened" — so no one reverse-engineers the rationale 200 hours later.

This bundle writes that receipt at every layer where behavior can change:

- **Per document**: the `attribution` map (`when`/`channel`/`agent`/`why`) is
  a write-once record of the trigger for every filing — machine-enforced and
  immutable after write, which is stronger than the post's voluntary logging.
  The 300-hour agent *dropped* its trigger context; a required immutable
  field cannot be dropped.
- **Per rule**: governance docs carry append-only `attribution.from`, tracing
  each policy/plan/analysis to the thread it came out of. A rule here cannot
  exist without its receipt chain: thread → governance doc → ratified policy
  → compiled contract.
- **Per change**: commits carry session trailers; `/capture` freezes the
  producing session; the [merge-strategy policy](/meta/policy/merge-strategy.md)
  keeps cited commits reachable forever precisely so receipts stay auditable.

One nuance: attribution records *filing* events, not *behavior-change*
events. That is sufficient here because in this architecture behavior changes
**are** filings — a policy edit is the only way standing behavior changes —
which is itself the anti-scar-tissue design decision.

## Countermeasure 3 — behavioral fingerprinting: the gap, anatomized

**Status: the genuine gap.** The post: track a rolling fingerprint of style
metrics (verbosity, retry density, error-message tone) to catch invisible
drift before it breaks logic. What this bundle trends today — dedup-probe
plain recall, docs-freshness warnings, route-tags coverage — is all
*structural*. Nothing measures style drift in what the agents write. The
operator's follow-up questions force the gap into sharper focus:

**Which processes, specifically?** The channels that write *distilled prose*
into the bundle: `/research` auto-intake (the primary exposure — daily,
agent-driven, bulk, explicitly deferred to a post-hoc editorial pass),
`/intake` (operator-triggered but agent-distilled), `/add-to-glossary`
(definition depth), and `/elaborate` (expansion depth). Explicitly *not*
`/capture`, which is verbatim by design — it strips noise, never condenses
substance, so it has no distillation depth to drift.

**Three measurable surfaces, of different kinds:**

1. **Description register** (verbosity of the one-sentence `description`, and
   body length by channel). Purely stylistic; mechanically measurable. On
   enforcement, the operator asked: examples, prose instruction, or both?
   **Both, with distinct jobs, plus measurement as the third leg.** Prose
   states the boundary (one sentence; what to exclude) but adjectives like
   "concise" are unanchored — a model imitates distributions far better than
   it obeys qualifiers, so 2–3 canonical examples are what actually calibrate
   the register. The bundle already runs this trio in miniature: the
   glossary's single-overview convention is a prose rule, calibrated by the
   corpus of existing entries, machine-checked by `mix brain.glossary`
   (containment percentages, warn-only). The same pattern — instruction to
   define, examples to calibrate, measurement to keep both honest —
   generalizes to descriptions at large.
2. **Tag consistency.** The operator objects: isn't tag sprawl an *epistemic*
   question — how knowledge should be structured? **At the root, yes — and
   the fingerprint deliberately does not answer it.** Tags are currently an
   ungoverned second taxonomy axis: the contract makes the tree the canonical
   taxonomy and gates its evolution, while `tags` are free strings,
   "recommended," with no controlled vocabulary and no ratification. Two
   phenomena hide under "sprawl": *which tags should exist* (genuinely
   epistemic — folksonomy vs. controlled vocabulary vs. dropping tags in
   favor of tree+links — an implicit decision never actually ratified), and
   *inconsistency of tagging practice* (synonym tags, per-session idiolects —
   this very session filed one doc tagged `agentic-ai` and another `agentic`,
   a live specimen). The second is mechanical and fingerprint-able
   (distinct-tag growth vs. corpus growth; near-duplicate tag pairs). The
   first is a governance question the fingerprint can only *surface*: if the
   trend shows sprawl, "should tags be governed?" graduates to its own plan
   for ratification. Sprawl is not cosmetic, either way — intake dedup
   searches tags, so tag idiolects directly erode the entry gate's recall.
3. **Distillation depth** (summary-to-source ratio, citation-block share,
   dump-vs-distill drift). Here the
   [escape-rate plan](/meta/plans/auto-intake-escape-rate-sampling.md)
   already owns the *defect* view: its escape taxonomy names
   **dump-not-distill** and **bad distillation** as classes 3 and 6, judged
   per-doc by the operator-edits-as-oracle. What it lacks is the *trend*
   view — a continuous metric that moves before any single doc is bad enough
   to count as an escape. The two views are complementary, not redundant:
   escape rate is a binary judgment against an oracle; a depth fingerprint is
   a distribution watched for drift.

**Why "dedup-probe-pattern" is exactly a fingerprint.** The operator asked
for the mechanism, precisely. The post's fingerprint is a rolling vector of
behavioral metrics compared against earlier values to catch drift no single
output reveals. The dedup-probe pattern supplies every component of that:
(a) a deterministic measurement over the corpus — the metric vector, i.e. the
fingerprint proper; (b) a **committed baseline table** — the frozen prior
state, satisfying countermeasure 1's requirement that the ruler not decay
with the thing measured (deltas are computed against git-pinned numbers, not
impressions); (c) a printed delta on every run — the drift detector; (d) the
trend in git history (`git log -p` over the baseline) — the "rolling"
record; (e) warn-never-fail — an editorial trend signal, matching the
fingerprint's early-warning role. The one honest difference from the post:
this fingerprints the *corpus* (behavior's residue) rather than the agent's
runtime behavior. In this repo that is the right proxy — sessions are
ephemeral and captured; the bundle is the only durable surface agent behavior
leaves — but it is a proxy, and should be named as one.

**Recommendation, unchanged but sharpened**: a style fingerprint belongs in
the escape-rate plan's orbit, not as a new subsystem — the two instruments
walk the same `channel: auto-intake` document set, share the
committed-baseline idiom, and split one concern (semantic quality) into
defect and trend views. A rider on that plan, for the operator's call.

**A naming note** (operator question): the task namespace would be
`mix brain.fingerprint` — `brain.*`, not `mind.*` — because the
[rename plan](/meta/plans/rename-second-brain-to-elixir-mind.md) explicitly
scoped task names out of the second-brain → elixir-mind rename: "the task
namespace is `brain.*`, not `second_brain.*` … already repo-name-agnostic and
domain-neutral." That was a ratified decision, not an omission; a `mind.*`
migration would be its own small plan (aliases first) if the operator wants
one.

## The comment insights, mapped

- **Context-share erosion** (the original goal becomes a shrinking fraction
  of context until artifacts crowd it out) — countered by the session model
  itself: sessions are bounded, `/capture` freezes them, durable state lives
  in the bundle
  ([fresh-context execution](/beliefs/glossary/fresh-context-execution.md)).
  One commenter's quip that humans "/clear every night" is this bundle's
  actual design: the brain persists; sessions are disposable.
- **Quirks mistaken for instructions** (the agent eventually says "pinned to
  2.1.1 as per instructions" about a workaround it invented) — the sharpest
  observation in the thread, and the bundle's answer is the policy/instance
  split: instructions have exactly one provenance-tracked source (ratified
  policy compiled into the contract), so a quirk cannot masquerade as an
  instruction — its receipt chain would be missing.
- **Parent/child auditing** (a parent holds intent and re-tasks drifting
  children) — the operator *is* the parent, `/priorities` the realignment
  instrument; the
  [workflow fan-out analysis](/meta/analysis/executing-ratified-plans-via-workflow-fan-out.md)
  formalizes the child side: fresh-context subagents scoped by a plan they
  cannot amend.
- **Durable structured memory over ad hoc context** (vector recall plus a
  file system acting as a graph DB) — an unwitting description of an OKF
  bundle: typed documents, stable ids, links as edges, a compiled registry.

## The doctrine question

The operator asked whether the MacFall-7 sentence should be added verbatim to
an existing policy or doctrine, or stand alone. **Standalone doctrine,
quote-seeded** — for three reasons:

1. **Not into a policy.** Policies are enforceable rules with specific scopes
   (taxonomy evolution, merge strategy, attribution shape). The sentence is
   not a rule but the *direction several rules jointly serve* — embedding it
   in one policy would misfile the why inside a what, and the contract's own
   layering says doctrine sits above policy precisely so the why is citable
   on its own.
2. **Not into an existing doctrine.** No entry in the roster governs
   adaptation:
   [engineer-as-orchestrator](/meta/doctrine/engineer-as-orchestrator.md)
   names the human's role,
   [capability-matched model selection](/meta/doctrine/capability-matched-model-selection.md)
   model-tier allocation, and the 2026-07 additions
   ([comprehension-of-generated-code](/meta/doctrine/comprehension-of-generated-code.md),
   [intent-is-the-source](/meta/doctrine/intent-is-the-source.md) and its
   companions) the comprehension and artifact-status directions — none says
   what governs an agent's *self-modification*. Notably, the doctrine layer
   already has a vacancy in
   this region: the escape-rate plan's `## Doctrine` section cites "measured
   trust before scaled autonomy" — a direction argued in an analysis but
   filed nowhere. Adaptation governance and measured trust are two faces of
   the same standing direction (adaptations must be *bound and revalidated*;
   trust must be *measured, not declared*).
3. **The quote-seeded pattern has precedent.** Engineer-as-orchestrator is
   itself built around a verbatim quote from Anthropic's coding-trends
   report. The proposed doc — working name **"bound adaptation"** — would
   quote the MacFall-7 sentence verbatim as its seed (with provenance to the
   capture, `em:60242a`), then state the bundle's one amendment: here the
   behavioral contract is not immutable but *ratification-mutable*, and that
   substitution — who approved it, not whether it changed — is what
   distinguishes learning from drift. The policies that implement the
   direction (taxonomy-evolution, resource-attribution, merge-strategy, the
   compiled contract) get cited as its implementations, and future plans
   (escape rate, style fingerprint) gain a citable anchor that is currently a
   Reddit comment.

Filing a doctrine is a standing-direction change — **awaiting the operator's
ratification**; the shape above is the proposal.

## Where should the framing persist? Resolving "perhaps as a belief"

First, the ground rule the operator asked about: the filing test —
*epistemic (what is true) files as claim/concept; value-laden prior (what I
act as if is true) files as belief; teleological (what standing direction)
files as doctrine* — **is discretely drafted but not in force**. It exists as
one line in the [belief-layer plan](/meta/plans/belief-type-and-beliefs-namespace.md)
(§"The shape of the change," item 4), *proposed* to be added to the
controlled-type-vocabulary policy upon ratification. Today it binds nothing;
this analysis applies it as the best available decision rule because the
operator invoked "belief" in that plan's sense.

> **Post-merge note (2026-07-27, same day).** The closing `origin/main` sync
> brought the belief layer in ratified and seeded by parallel sessions: the
> belief plan is now `status: done`, the `belief` type and its filing test are
> in the [controlled vocabulary](/meta/policy/controlled-type-vocabulary.md),
> and six operator-ratified beliefs are filed under `/beliefs/`. The test this
> section applied as a draft heuristic is contract law as of the merge —
> unchanged in content, so the decomposition below stands. One consequence
> updates: the lens-adoption prior (statement 3) no longer waits on the *type*
> existing — it is filable as a `type: belief` the moment the operator affirms
> holding it.

The operator then pressed the real objection: scar tissue is a *creative
analogy*, not a colloquial term — and adopting an analogy is arguably an act
of belief ("I will act as if the analogy to scar tissue is appropriate for
this failure mode"). Agree or disagree?

**Both — because three distinct statements are hiding in one phrase, and
they file differently:**

1. **The lexical fact**: *"the term 'scar tissue' is used to mean
   local-fix accretion into unchosen policy."* This is what the
   [glossary entry](/beliefs/glossary/scar-tissue.md) (`em:2ad710`) records —
   lexicography, not endorsement. The operator's instinct lands a real blow
   here, though: the term is a **nascent coinage** (one post, taken up
   approvingly by its commenters), not established field vocabulary, and the
   entry's `sense: common` overstates its currency. The
   [cognitive debt](/beliefs/glossary/cognitive-debt.md) precedent shows the
   glossary holds coinages comfortably — but marks them (provenance +
   `coined` tag). The entry should be marked the same way; a term whose
   usage never spreads beyond its source post is still a legitimate entry,
   just an honestly-labeled one.
2. **The aptness claim**: *"the analogy is apt — the structural mapping
   (adaptive local repair → global rigidity; trigger context lost →
   maladaptive reapplication) holds for this failure mode."* This is where
   the disagreement lives, and the answer is: **claim-shaped, not
   belief-shaped.** Aptness has truth-tracking content — the analogy is apt
   iff the mapped structure holds across cases, and the capture's four
   hour-marks are exactly such cases. Crucially, it is *defeasible by
   evidence*: failure modes that don't fit the mapping would retire the
   analogy. Anything evidence can retire sits on the verification ladder,
   where beliefs by definition do not. (Nobody need file this claim as a
   document; the analysis records the judgment. But if it were filed, it
   would be a `claim` with the capture in `verified_by`.)
3. **The lens adoption**: *"I will act as if the trauma/scar-tissue lens is
   the right frame for reasoning about agent failure modes."* **Here the
   operator is right — this is genuinely belief-shaped.** The same facts
   support competing frames — the comment thread itself offers "software
   entropy" and "error-minimizers stuck in local minima" as rival lenses for
   the identical phenomenon — and choosing among extensionally-equivalent
   frames is not settled by evidence. It is a value-laden commitment that
   guides action (it is *why* receipts and baselines feel like the important
   countermeasures rather than, say, better optimization). Frames are
   chosen, not proven; once chosen, their mappings succeed or fail
   empirically — the choice is belief, the fit is claim.

So: **disagree** that the analogy's aptness requires belief-adoption — fit is
epistemic and case-checkable; **agree** that adopting the lens as a working
frame is belief-adoption in exactly the proposed plan's sense. The practical
residue is tidy: the glossary entry stays (re-marked as a coinage); the
aptness judgment lives here; and the lens-adoption statement is a natural
**seed belief** for the belief plan's build-order step 4 ("intake 2–3 real
operator priors as the first `belief` concepts") — if the operator holds it,
it can be among the first beliefs filed when the type is ratified.

## Verdict

The bundle is, by construction, an anti-scar-tissue architecture:
countermeasures 1 and 2 are not recommendations to adopt but descriptions of
the ratification gate and the attribution/provenance layer already in force —
with the deliberate amendment that the baseline is ratification-mutable, so
learning and drift are distinguished by who approves. The honest exposure is
countermeasure 3, and it decomposes cleanly: description register (style —
enforce with prose + examples + measurement), tag consistency (mechanical
symptom of an ungoverned epistemic axis the fingerprint can surface but not
settle), and distillation depth (the trend complement to the escape-rate
plan's defect classes). The cheapest instrument is a dedup-probe-pattern
fingerprint riding the escape-rate plan. Awaiting the operator: that rider,
the "bound adaptation" doctrine proposal, the glossary entry's coinage
re-marking, and — standing behind all of it — the belief-layer plan whose
ratification would give the lens-adoption prior a home.
