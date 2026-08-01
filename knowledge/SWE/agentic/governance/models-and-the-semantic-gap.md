---
id: em:e4d9cf
type: reference
title: "Models and the semantic gap (MAGE, ch. 2.2)"
description: Typed models sit between ambiguous prose and verbose code as the binding layer agents can reason over in bulk, but only when authored independently of the code as a spec rather than derived from it as a mirror — and governance checks must fire at the abstraction level where a property is legible, not below it.
resource: https://davisjam.github.io/model-based-agentic-software-engineering/book/2.2-models-and-the-semantic-gap.html
provenance: "James C. Davis (Purdue University), 'Model-Based Agentic Software Engineering' (MAGE; site retitled from 'Agent Governance Mechanisms'), chapter 2.2, fetched 2026-07-31; resource URL updated 2026-08-01 after the book's site moved (old path https://davisjam.github.io/agent-governance-mechanisms/book/2.2-models-and-the-semantic-gap.html)"
tags: [agent-governance, models, model-driven-engineering, definition-of-done, context-compaction, spec-vs-implementation, agentic-loop, comparative-analysis]
timestamp: 2026-08-01
attribution:
  when: 2026-07-31T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "filed after reviewing the chapter in chat"
---

# Models and the semantic gap (MAGE, ch. 2.2)

**James C. Davis** (Purdue University), *Model-Based Agentic Software
Engineering* (MAGE), chapter 2.2.
*(Summarized — full chapter and the rest of the book at the resource link.)*

## Plain-language summary

Prose documentation is soft and ambiguous; code is exact but too dense to
skim in bulk. This chapter argues a **typed model** sits in between — compact
enough to read at a glance, precise enough to check mechanically — and that
this middle layer, tried and mostly abandoned in earlier eras of software
engineering (UML, CASE tools, Model-Driven Architecture), is worth trying
again specifically *because* agents exist: an agent can reason over a
structured model in a way it cannot reason over an entire codebase, so the
old cost of keeping a model synced with code now buys something new.

The catch is a well-known trap given a new name here: a model that's
**derived from** the code just mirrors whatever the code already does, so
comparing the two for "drift" is circular — both can wander off together and
the check stays green. A model earns its power only by being **authored
independently**, expressing intent the code must be checked against.

The chapter's other main idea is the **semantic gap**: many governance checks
fail not because the property is wrong but because it's enforced at too fine
a grain — a single commit, a single file — where the property being checked
simply isn't visible yet. The fix is to check at the level where the property
*becomes* legible (e.g., "the model matches the code" only needs to hold once
a whole feature is done, not at every intermediate commit within it), and the
chapter works this through a concrete example: deciding when to force a
context-compaction checkpoint in an agent session.

## Key terms

- **Model** (as used here) — a structured, typed description of a system,
  positioned as more compact than code and more precise than prose; the
  binding layer meant to keep documentation, code, and tests from drifting
  apart independently.
- **Derived model ("mirror")** — a model generated from or reflecting the
  current implementation. Useless as a drift check on its own: if the model
  is downstream of the code, code and model can drift together in the same
  wrong direction and a diff between them stays clean.
- **Authored model ("spec")** — a model written to express *intent*,
  independent of whatever the code currently does. Only an independently
  authored model can catch an implementation error, because it doesn't move
  when the code moves.
- **Three-island problem** — the default state of prose, code, and tests as
  three disconnected artifacts with no structural link between them, so nothing
  forces them to stay consistent as any one changes.
- **Semantic gap** — the mismatch between the abstraction level a check
  operates at and the abstraction level a property is actually legible at; a
  property that only makes sense in light of "an entire feature and its plan"
  will look fine (or won't even be checkable) at the level of one commit.
- **Epic** — a tracked unit of work larger than a single commit: a feature or
  effort with its own file, plan, and definition of done, carried out across
  several agent dispatches.
- **Definition of done** — the explicit list of conditions a unit of work
  must satisfy to count as finished (tests present, docs updated, model in
  sync), checked once at the end rather than assumed throughout.
- **Ouroboros** — the degenerate failure mode where a system spends its
  cycles summarizing/reprocessing its own prior output instead of making
  progress, consuming itself.

## Technical summary

The chapter opens by positioning **models as the sweet spot** between prose
("ambiguous," "soft") and code ("perfectly precise" but "far too verbose to
reason over in bulk"): a model is meant to be "accurate and unambiguous, yet
compact." It then addresses the obvious objection — model-based engineering
(CASE tools, UML, Model-Driven Architecture) already failed once, because
keeping models synchronized with fast-moving code required manual labor teams
abandoned once agile development sped up change cycles. The chapter's claim
is that **agents invert this economics**: an agent can't parse a large
codebase efficiently but can reason over a compact structured model, so the
synchronization cost that killed the old approach now buys real capability.
It also floats a training-data explanation for why agents don't reach for
modeling on their own: "the corpus is full of text about models, and most of
it is negative."

The **three-island problem** frames prose, code, and tests as disconnected by
default — "a change to the code does not touch the doc; a stale test does not
know the schema moved" — with a typed model at the top of the documentation
hierarchy providing the checked edges that bind the three together.

The chapter's sharpest distinction is **spec vs. mirror**: a model *derived*
from the implementation only reflects it, so a drift check between the two is
circular and stays green even as both wander together. The power "was never
in modeling as such. It was in the model being **authored independently of
the code**" — independence is what lets the model actually catch an
implementation error rather than just restate one.

It briefly surveys **executable models** — the forty-year-old dream of
skipping code generation entirely and running the model directly, still
alive in avionics/telecom/safety-critical domains but abandoned by mainstream
software because "heavy modeling could not keep that pace." The chapter
declines to pick a fixed point on the modeling-to-executability spectrum,
treating agents as shifting the economics rather than settling the question.

The **semantic gap** is presented as a general diagnosis for a recurring
enforcement mistake: pushing a property check down to an abstraction level
where the property is "invisible in any one" small unit. A property that
needs "an entire feature and its plan" to be legible must be checked when the
agent returns from that whole task, not enforced (and failed) at every
intermediate commit inside it — intermediate model/code disagreement can be
legitimate mid-feature; only the finished deliverable must reconcile them.
This is offered as the reason pre-commit hooks fail for many governance
properties: they sit structurally below the level where the property has
meaning.

The chapter closes with a **worked example: context compaction**. When an
agent session's context window fills, the runtime must summarize/compact —
but the compaction mechanism itself only sees token counts, not which
knowledge is semantically important, so it operates at the wrong abstraction
level to make that call well. The proposed fix moves the check upward: a
**dual-condition hook** that fires only when the context window is full *and*
durable records (strategy docs, hand-off notes) have gone stale — either
condition alone is common and would over-trigger, but both together signals
real risk of losing a decision. The chapter concedes the theoretical ideal
(a pre-compaction hook catching everything) is impractical: it fires too
late in practice, and the act of writing a checkpoint can itself trigger the
compaction it's trying to get ahead of. Approximate checking a bit earlier,
accepting a small loss, beats a perfectly timed check that doesn't actually
run in time.

The chapter ends by deferring formal-methods coverage (linear temporal
logic, bounded model checking) and concrete model-authoring patterns
("the Model Zoo") to later chapters.

## Comparison with this bundle's governance approach

First, plainly: the chapter argues that agent-governed systems should keep a
compact, machine-checkable description (a "model") between fuzzy prose and
verbose code, wire it to build-time drift gates, and enforce properties at
the level of a *completed unit of work* rather than per-commit — because, as
the chapter puts it, "this is the semantic gap: the failure you get whenever
you enforce a property at the wrong level of abstraction." This bundle
already runs most of that playbook, applied to a knowledge corpus instead of
a codebase. The interesting differences are where it made the opposite bet.

### Where this bundle is doing the same thing

**Drift-and-parity gates — this bundle has them, and they're the backbone.**
The chapter's "typed model wired to a build-time drift check" is structurally
what this repo's generated-artifact suite is: `CLAUDE.md` compiled from
`meta/policy/` with `mix brain.contract --check`, `meta/registry.md` from
per-file ids with `--check`, the code map from moduledocs, and the route-tag
logs, where `mix brain.route_tags` "re-derives each sink's log from the
current tags and **fails on divergence**, converting the log's freshness from
procedural to structural" ([route-tagging](/meta/policy/route-tagging.md)).
That last phrase is the chapter's thesis in this bundle's own vocabulary.

**The semantic gap — this bundle independently landed on the same
enforcement level.** The chapter's core example is that per-commit drift
checking is wrong: "the model may be legitimately out of sync in the middle
and correct again by the end. Enforce at the commit and you are checking a
sentence for grammar before the paragraph is written." This bundle's
governance repeatedly picks the session/PR close as the enforcement boundary
for exactly this reason:
[session-capture](/meta/policy/session-capture.md) is "on demand, not a
hook… never a per-turn hook," with tagging as "one finalization motion over
that frozen body, not a per-turn rewrite";
[concerns-block-the-close](/meta/policy/concerns-block-the-close.md)
inventories open concerns at the close, not mid-work; and
`/create-pull-request` stamps `attribution.from` only once the thread path
exists. Mid-session, the bundle is legitimately inconsistent; the property
"the record is complete and routed" is only legible at the close. That *is*
the chapter's enforcement-level principle, enacted.

**A typed model binding the islands.** The chapter complains the usual setup
"gives you docs, code, and tests — and *nothing binding them together*. They
sit as three separate islands." This bundle's islands are different — the
record layer (threads), the knowledge layer (documents), and the change layer
(commits) — but the glue is the same move: a typed structure (`em:` ids,
`verified_by` edges, route tags, `attribution.from`, `pr:` stamps, session
trailers) that `mix brain.verify` checks referentially. The frontmatter
schema plus the controlled type vocabulary is, in the chapter's sense, a
typed model of the corpus.

**"Agreement, not correctness" — this bundle draws the identical epistemic
line.** The chapter insists the gate "proves one thing: the model and the
code **agree**" — it can't prove the model right. This bundle's contract
states the same boundary repeatedly: route-tag *coverage* "has no mechanical
oracle and stays editorial"; the model-attribution field is "an attestation,
not a measurement — a checker can establish presence and form, never
truthfulness"; `mix brain.verify` checks shape, never whether a claim is
true — truth goes through the separate, evidence-based
[verification-grounding](/meta/policy/verification-grounding.md) ladder.

### Where this bundle diverges

**Spec vs. mirror — this bundle made the opposite choice, deliberately.**
This is the sharpest contrast. The chapter's model must be *authored
independently* of the code (a spec, not a mirror), because only an
independent second description can catch bugs at the parity check; a derived
model only reflects what is. This bundle's generated artifacts are all
*mirrors by design* — `CLAUDE.md`, the registry, the code map, the route-tag
logs are derived views, and their gates check freshness of derivation, not
agreement between two independent accounts. More than that: where two
independent descriptions of the same fact *could* exist, this bundle's
policies systematically delete the second one —
[provenance-lives-in-metadata](/meta/policy/provenance-lives-in-metadata.md)
bans prose restating attribution, the evidence narrative is "derived on
demand… never committed," and hand-kept `log.md` files were purged in favor
of the commit graph. The chapter's instinct is "maintain the second
description and gate its agreement"; this bundle's is "there shall be no
second description — generate it." Both defeat rot; they defeat it
differently, and this bundle's approach forfeits the chapter's bug-catching
benefit of independent authorship *for those artifacts*. The place this
bundle does keep an independently-authored model is upstream: the policy
corpus itself is the spec, and the checkable subject is the bundle — the
check runs bundle-against-policy rather than model-against-code. And
[structured-plan-bodies](/meta/policy/structured-plan-bodies.md) is this
bundle's one true spec-not-mirror artifact — trees, diffs, and signatures
authored *before* the code, with the refresh rule ("re-derive the
current-state tree against `HEAD`, diff it against the plan's") acting as a
hand-run drift check. Notably, that check is editorial, not gated.

**Economics — the chapter says model more; this bundle holds a stricter
admission bar.** The chapter's bet: "Agents removed that cost. When the map
stays in sync almost for free, the typed model… becomes the one you start
from" — as maintenance cost approaches zero, the rational amount of modeling
goes up. This bundle's
[coding standards](/meta/policy/elixir-coding-standards.md) accept the
drift-gate half but reject the expansion half: "a check earns a gate when its
**signal beats its upkeep** *and* it runs offline… with no dependencies," and
on those grounds this bundle has *declined* — not deferred — a declarative
shapes layer (SHACL), Credo, Dialyzer, and gated coverage. The implicit
disagreement: agent labor drives the *synchronization* cost toward zero, but
dependency weight, toolchain complexity, and false-positive noise are costs
agents don't remove, so cheap maintenance alone doesn't justify more model.
That's a real, defensible refinement of the chapter's claim rather than a
contradiction of it.

**Different substrate, different correctness oracle.** The chapter governs
software, where tests are the third island and correctness has an executable
oracle. This bundle's primary subject is knowledge, which has no test
suite — so it built a different apex for correctness: `claim` → `source`
captures with verbatim spans → `verified_by` edges → `verified: true`. That
is, interestingly, the chapter's "independently authored description catches
errors" idea reappearing at the knowledge layer: the primary-source capture
is the independent description, and verification is the parity check between
statement and evidence. Meanwhile the `lib/` tooling gets the chapter's
treatment straight (warnings-as-errors, xref compile-coupling at zero, format
checks), per
[guarding-against-ai-drift](/knowledge/SWE/agentic/code-quality/guarding-against-ai-drift.md).

**One gap on this bundle's side the chapter would poke at.** The chapter's
semantic-gap lens suggests asking, for each editorial-only rule, whether it's
editorial because no oracle *can* exist or because none has been built at the
right level yet. Route-tag coverage and the model-attribution presence check
are both candidates the contract itself flags as "mechanically checkable"
someday — the chapter's framing would say the unit-of-work level (the PR gate
this bundle already has) is exactly where such checks belong when they're
added, and this bundle's admission rule is the right filter for whether
they're worth it.

In one sentence: the chapter and this bundle agree on gates, on enforcing at
the unit of work, and on "agreement ≠ correctness" — and disagree on whether
the model should be an independent spec (chapter) or whether second
descriptions should be eliminated and generated (this bundle), and on whether
near-free maintenance justifies more modeling (chapter) or whether
upkeep-vs-signal remains the binding constraint (this bundle).

# Citations

James C. Davis, "Models and the Semantic Gap," *Model-Based Agentic Software
Engineering* (MAGE), ch. 2.2 —
<https://davisjam.github.io/model-based-agentic-software-engineering/book/2.2-models-and-the-semantic-gap.html>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:e4d9cf">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-31-neovim-pr-tree-view-and-mage-semantic-gap-intake (2026-07-31)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:e4d9cf`]**

**Filed**

I intook the chapter you'd been discussing — no other "resources" were in scope from this conversation, so this is the one item.

| Created | Type | Path |
|---|---|---|
| Models and the semantic gap (MAGE, ch. 2.2) | `reference` (`em:e4d9cf`) | `knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md` |

**Fetched:** the chapter itself, plus the book's landing page to get title/author/context (James C. Davis, Purdue — *Model-Based Agentic Software Engineering*, ch. 2.2). Fully distilled (plain-language summary → key terms → technical summary) rather than link-only, since it's dense enough to warrant the layered breakdown but short enough to capture faithfully.

**New directory:** `knowledge/SWE/agentic/governance/` — no existing subdirectory covered "typed models as an enforcement/governance layer for agent work" (closest neighbors, `code-quality/` and `supervision/`, are about drift-guardrails and human oversight respectively, not this). Created autonomously since `agentic/` is an already-established domain under the `SWE` top-level dir — same precedent as the earlier `provenance/` subdirectory. Both `index.md` files (new dir + parent `agentic/`) are updated.

**Housekeeping:** `mix brain.verify` passes; dedup baseline refreshed, no recall regression (held at 8/22 plain). No natural operator phrasing to harvest into the dedup gold set — you pasted the link with no descriptive framing (calling it "a PR" doesn't describe the content), so per the skill I skipped that step rather than inventing a query.

Nothing is committed yet — say the word or run `/create-pull-request` when you want this opened as a PR.

---

**[`em:e4d9cf`]**

Committed (`e11848c`) and pushed to `claude/neovim-pr-file-tree-qr65ce`. No PR opened yet — let me know if you'd like one, or if you're continuing the session further before wrapping up.
