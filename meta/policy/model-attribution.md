---
type: policy
title: Agent-authored documents record the producing model
description: Commit trailers already name the model per *commit*; this rule adds the per-*document* attestation — an agent-authored governance or statement document names its producing model in `provenance`, in the same display form the trailer uses, and a session that cannot determine or disclose its model records that explicitly rather than omitting or guessing.
section: verification
order: 3
status: active
tags: [meta, governance, provenance, attribution, model-selection, auditability, verification]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T02:40:00Z
  channel: agent-authored
  agent: "Claude Code agent, agent-substrate analysis session"
  why: "operator ratified the thin attribution policy that capability-matched-model-selection proposes, after the graph-engineering talk supplied the doctrine's first empirical evidence and raised the cost of leaving reviewer-tier unrecorded under fan-out"
---

**An agent-authored document names the model that produced it.**
[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md)
directs the strongest models to motions where "the output *is* the judgment and
there is no oracle behind it" — but selection "**cannot be enforced**: it is a
runtime act". Attribution is its enforceable shadow, and this rule fixes where
that shadow falls on a **document**.

**What the commit graph already covers, and what it does not.** The harness
injects `Co-Authored-By: Claude <Name> <Version>` alongside `Claude-Session:` on
commits Claude authors, so the model is already recorded per *commit* for the
majority of this repo's history. Two gaps remain, and they are what this rule
addresses — not the absence of any record:

- **A trailer attributes a commit, not a document.** One commit routinely touches
  several documents written across a session; the trailer assigns all of them to
  one model even where the motions differed in weight. The audit
  capability-matched-model-selection wants is per-artifact.
- **A document is read outside its git history.** On the published site, after a
  move, or when quoted elsewhere, the trailer is not present. A document that
  travels carries only its own frontmatter.

**The rule.**

- **Who records.** An agent-authored **governance** document (under `meta/`) or
  **statement** document (`claim` · `note` · `concept`) whose
  `attribution.channel` is `agent-authored` or `auto-intake` names its producing
  model in `provenance`. An operator-authored document does not; a capture of
  external material attributes its *source*, and names a model only if one
  produced the distillation.
- **One form — the trailer's display form** (`Claude Opus 4.8`,
  `Claude Fable 5`), so the document-level and commit-level records join on the
  same string. Do not coin a second form: a field that reads three ways cannot be
  grepped, counted, or trended, and the repo's existing `provenance` fields
  already split across display names, ids, and bare "Claude Code session".
- **An undisclosed model is stated, never omitted.** A session that cannot
  determine its model, or that runs in an environment withholding the identifier
  from committed artifacts, writes `model undisclosed` in `provenance`. Omission
  and a guess are both defects: omission makes an unattributable document
  indistinguishable from an unremarkable one, and a guess corrupts the field the
  audit reads. This is *silence is not success*
  ([escape-rate plan](/meta/plans/auto-intake-escape-rate-sampling.md)) applied
  to attribution.
- **It is an attestation, not a measurement.** A session writes its own
  identifier; the repository cannot verify it. A checker can establish
  **presence and form**, never truthfulness — so read the field as self-reported
  provenance, evidence about authorship rather than proof of it.
- **Scope is forward-looking.** The rule binds documents filed from its
  ratification onward. The existing corpus is mixed — many agent-authored
  governance documents name no model — and a retrofit sweep is its own decision,
  not an obligation imposed here (the posture
  [structured-plan-bodies](/meta/policy/structured-plan-bodies.md) takes toward
  pre-existing plans).
- **Enforcement is editorial today.** Presence-and-form is mechanically checkable
  and is the natural shape of a future `mix brain.verify` rule or warn-only
  report; until one exists this binds agent judgment, as the oracle-less
  [coding standards](/meta/policy/elixir-coding-standards.md) conventions do. A
  checker earns a gate on the standing admission rule, not automatically.

This refines [resource-attribution](/meta/policy/resource-attribution.md), which
holds that `attribution.agent` names "the **pathway, not the model** (the model
is in the commit trailer)". That division stands: the pathway belongs in
`attribution`, and the model belongs in `provenance` — beside the *content's*
origin, which is what it is. Why it became worth ratifying is recorded in
[three agent-substrate talks read against this brain](/meta/analysis/agent-substrate-talks-read-against-this-brain.md):
under fan-out the reviewing node's tier is the property most worth auditing
afterward, and an unrecorded tier is the audit that cannot be run.
