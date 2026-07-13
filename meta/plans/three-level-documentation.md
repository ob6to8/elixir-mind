---
type: plan
title: "Three-level documentation: plain, technical, and grounding tiers"
description: Present opt-in documents at three levels — a plain-speak backstop for the tutorial-mode reader, the canonical terse technical body, and a grounding tier one abstraction below the source — implemented as one canonical level plus two anchored derivations, never three parallel texts.
status: proposed
provenance: "Claude Code session, 2026-07-13 — operator proposed three presentation levels (plain / technical / code); framing refined and core decisions agreed in-session"
tags: [meta, plan, documentation, accessibility, levels]
timestamp: 2026-07-13
---

# Three-level documentation: plain, technical, and grounding tiers

## Status & provenance

**Proposed** — the operator raised the idea on 2026-07-13 and the core framing
was agreed in the same session: levels are opt-in per document, and the design
is *one canonical level plus two anchored derivations*, not three parallel
texts. The concrete artifact shape below (section conventions, frontmatter
edge, verifier behavior) is the agent's elaboration of that framing and awaits
operator ratification before execution.

## Problem

The bundle's documents are written at one register: terse, dense,
information-rich, and dependent on the reader carrying the accompanying
concepts in their head. That register is correct as the canonical form — it is
also the level at which agent and operator converse. But it silently assumes a
reader who already has the intuitions.

The operator's situation breaks that assumption. When systems are built
through natural-language collaboration, the operator is often *learning the
system by using it* — in effect in **constant tutorial mode**. It is easy to
lose sight of what a dense technical reference refers to. The glossary helps,
but chasing definitions leads into nested webs of concepts in which the
intuition — the general thrust of what is being said — is lost. Two audiences
are underserved:

- **The tutorial-mode operator**, who needs a fail-safe backstop: when the
  technical body fails to land, somewhere to recover the general meaning
  without leaving the document.
- **A reader surveying the system** deciding whether to adopt it. For that
  reader, technical specificity and brevity are not our friends.

Separately, the terse register also under-serves the opposite direction: a
policy like [verification-grounding](/meta/policy/verification-grounding.md)
gestures repeatedly at its enforcement ("`mix brain.verify` rejects…") without
ever anchoring *what the machine actually does* — the reader who wants to
descend a level has no marked path down.

## The three levels

1. **Plain** — a plain-spoken presentation of the concepts, intelligible to a
   nontechnical reader. Not a summary for skimming but a *backstop*: if the
   reader fails to intuit the technical body, the plain tier restores the
   general thrust and meaning.
2. **Technical** — the canonical body, exactly as documents are written today.
   Terse, dense, precise. This level is the source; nothing about it changes.
3. **Grounding** — **one level of abstraction below whatever the source is.**
   This tier is *relative*, not fixed at "code": for a machine-enforced policy
   it is the enforcing code (a path, e.g. `lib/second_brain/verifier.ex`); for
   a doctrine it is the policies that implement the doctrine (`sb:` id edges);
   for a tooling doc it is the modules and tasks. It answers "what concretely
   realizes this, one step down?"

The tiers are asymmetric by design. Level 2 is canonical and hand-written.
Level 1 is a *derived presentation* of level 2. Level 3 is an *anchored edge*
downward plus optional prose. Treating them as three parallel hand-maintained
renderings would recreate the drift problem this bundle's tooling exists to
prevent (compiled contract, compiled registry, materialized route-tag logs,
derived evidence narratives).

## Decisions (agreed in-session)

1. **Opt-in per document.** Levels are added where they earn their keep — where
   the audience genuinely varies or the code exists — and absent otherwise. No
   bundle-wide retrofit.
2. **One canonical level plus two anchored derivations.** The technical body
   remains the single source of truth. The plain tier is regenerated from it;
   the grounding tier points below it. Neither may fork into an independently
   drifting account.
3. **The grounding tier is relative.** `implemented_by` on a doctrine holds
   `sb:` id edges to the policies implementing it; on a policy it holds path
   refs to the enforcing code. This mirrors the route-tag ref rule exactly: a
   ref is a stable `sb:` id (a bundle sink) or a path (a back-link to code).
4. **The plain tier is committed, not site-only.** An earlier alternative —
   rendering level 1 only on the Pages site — was rejected by the level-1
   rationale: the backstop must be adjacent to the technical body *wherever*
   the operator reads (repo checkout, chat citation, site). A committed
   section serves all three; a site toggle serves only one.

## Proposed artifact shape (awaiting ratification)

- **Level 1**: a `## Plain` section in the same file, placed immediately after
  the frontmatter and before the technical body — the failing reader meets it
  first; the fluent reader skips a clearly-marked block at zero cost.
  Agent-maintained: whenever a session meaningfully edits the body, it
  re-renders the plain section *in the same motion* (the update-in-place
  discipline applied to a derived section).
- **Level 3**: an `implemented_by:` frontmatter field — inline YAML list of
  `sb:` ids and/or repo paths — plus an optional `## Grounding` prose section
  describing what the referenced level does. The edge is the anchor; the prose
  is editorial.
- **Verification**: `mix brain.verify` checks what has a mechanical oracle —
  `implemented_by` targets resolve (ids exist in the registry; paths exist on
  disk). Plain-section *faithfulness* has no mechanical oracle and stays
  editorial, like route-tag coverage: convention plus review, a warning at
  most, never a CI failure.
- **Pilot documents** (execution scope):
  - [verification-grounding](/meta/policy/verification-grounding.md) — the
    full three-tier case: plain section, existing body,
    `implemented_by: lib/second_brain/verifier.ex` (+ mix task) with a
    grounding section on what the verifier rules actually check.
  - [engineer-as-orchestrator](/meta/doctrine/engineer-as-orchestrator.md) —
    the doctrine case: plain section, existing body, `implemented_by` id edges
    to the policies that realize the doctrine.

## Open questions

- **Section naming.** `## Plain` and `## Grounding` are placeholders; the
  operator may prefer other names (e.g. `## In plain terms`,
  `## Implementation`).
- **Staleness signal for the plain tier.** Presence is checkable; freshness is
  not. Whether to add a soft signal (e.g. a verifier warning when a body's
  timestamp outruns some marker on the plain section) is deferred until the
  pilot shows how often drift actually occurs.
- **Site presentation.** Whether the Pages build styles the plain and
  grounding sections distinctly (collapsible, badged, toggled) is a
  presentation-layer question deferred until the committed shape settles.
- **Relation to `/summarize-technical` and `/elaborate`.** Both skills already
  produce level-1↔level-2 movements for external material and phrases; once
  the section convention exists they could target it directly. Deferred.

## Build order (on ratification)

1. Settle section names and flip this plan to `accepted`.
2. Policy doc under `meta/policy/` (the levels convention, the
   `implemented_by` field, the opt-in rule) + `/render-contract`.
3. Verifier rule for `implemented_by` resolution, with tests.
4. Pilot the two documents above.
5. Gate suite, commit, push; flip to `done` with any classification calls
   recorded.
