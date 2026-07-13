---
type: plan
title: "Attribution: a frontmatter record of the ingestion event"
description: Add a structured `attribution` frontmatter property to bundle concepts recording when the concept was ingested, through which channel and by whom, and why it was deemed worth filing — an immutable event record, distinct from provenance (content origin) and timestamp (last change).
status: proposed
provenance: "Claude Code session, 2026-07-13 — commissioned by the operator: 'create an attribution property for resources absorbed into the knowledge collection — including when it was ingested, how/who, and why'"
tags: [meta, plan, frontmatter, attribution, provenance, intake, auto-intake, schema]
timestamp: 2026-07-13
---

# Attribution: a frontmatter record of the ingestion event

## Problem

When a concept enters the brain, the *ingestion event* — when it arrived, through
which pathway, driven by which actor, and why it was judged worth filing — is
currently scattered across four places, none of which is queryable from the bundle
surface:

- **Free-text `provenance`**, which conflates two different things: where the
  *content* came from (its author/origin, which may long predate the brain) and
  how it happened to *enter* the brain. Compare
  `provenance: "Agent-distilled glossary definition"` (content origin) with
  `provenance: "auto-intaken from /research inbox 2026-07-12"` (ingestion event)
  — the same field is carrying both meanings, unstructured.
- **The `auto-intake` tag**, a single-channel special case invented so the
  operator's post-intake editorial pass could find what `/research` filed. It
  answers "how" for exactly one pathway and says nothing about when or why.
- **The digest line** in `inbox/` (for auto-intaken items), which holds the *why*
  (the reason-tag and category match) — but in a dated file the concept doesn't
  point back to.
- **Git archaeology** (`git log --diff-filter=A --follow`), which answers *when*
  and — via session trailers — *which session*, but is invisible to an agent
  reading the bundle as files, erodes under renames and update-in-place merges,
  and is absent entirely when the bundle is consumed outside this repo (OKF
  bundles are meant to be portable).

This matters more as [auto-intake](/meta/plans/auto-intake-featured-research.md)
scales the corpus past what an agent holds in context: trust calibration ("did an
operator vouch for this or did a feed match a keyword?"), the editorial pass, and
staleness triage all want a per-concept answer to *when / how / who / why it got
here* — cheaply, in-band, without re-deriving it from history each time.

## Design

One new frontmatter key on bundle concepts, `attribution`, a small structured map
with four fixed sub-keys mirroring the question it answers:

```yaml
attribution:
  when: 2026-07-13T14:02:00Z
  channel: auto-intake
  agent: "Claude Code agent, /research daily Routine"
  why: "featured in the 2026-07-13 digest under agents/orchestration; reason-tag: impactful"
```

| Sub-key | Holds | Form |
|---------|-------|------|
| `when` | The ingestion instant — when the concept entered the bundle | ISO 8601 (date minimum; datetime preferred) |
| `channel` | *How* it entered — the pathway | Controlled vocabulary (below) |
| `agent` | *Who* acted — the operator, or the agent and the automation context it ran in | Free text, one line |
| `why` | Why it was deemed worth filing — the featuring reason, the operator's ask, the gap it fills | Free text, one sentence |

### Channel vocabulary

Controlled and small, growing deliberately (operator ratifies additions, same as
the `type` vocabulary):

- `intake` — operator-initiated `/intake` of pasted material or links.
- `auto-intake` — filed autonomously by `/research` featuring (subsumes the
  `auto-intake` tag; see migration below).
- `glossary` — a term file created by `/add-to-glossary`.
- `agent-authored` — a statement (`claim`/`note`/`concept`) the agent distilled
  directly from a working session, not from external pasted/fetched material.
- `backfill` — attribution reconstructed retroactively from git history for
  concepts that predate this property (see backfill below).

### Semantics — the three load-bearing rules

1. **Attribution is an event record, and events don't change: the property is
   immutable once written**, like `id`. Update-in-place merges never rewrite it —
   `timestamp` carries "last meaningful change", the commit graph carries the
   change narrative, and a later merge that absorbs a second source is
   `provenance`/`# Citations` territory. One concept, one ingestion event.
2. **Attribution is orthogonal to provenance.** The existing fields keep their
   meanings; attribution takes over the ingestion-event duty that `provenance`
   free text has been informally absorbing:

   | Field | Answers | Mutability |
   |-------|---------|------------|
   | `resource` | *what asset* — canonical URI of the underlying thing | immutable |
   | `provenance` | *where the content came from* — its author/origin, possibly predating the brain | immutable history |
   | `attribution` | *how it got here* — the ingestion event: when / channel / actor / reason | immutable event |
   | `timestamp` | *when it last meaningfully changed* | mutable |

3. **It is not a log.** The
   [retire-hand-kept-logs decision](/meta/plans/retire-hand-kept-logs.md) stands:
   the commit graph remains the single provenance *layer* (the full change
   narrative). Attribution is a single write-once record of one event — it cannot
   drift, because it is never maintained. It summarizes in-band the one commit
   that git makes progressively harder to reach (renames, merges, agents without
   git access, foreign bundle consumers); it does not compete with git for
   anything else.

### Scope

All **bundle concepts** — everything that carries an `sb:` id — going forward
from ratification. The governance namespace (`meta/`, `inbox/`) is excluded, as
with ids: plans, threads, digests, and elaborations are already self-describing
about their own origin (frontmatter `provenance`, the thread `pr:` anchor, dated
digest filenames).

The operator's ask named "resources absorbed into the knowledge collection", and
captures (`reference`/`source`) are indeed where attribution earns the most —
but a uniform all-bundle-concepts rule is simpler to state, enforce, and query
than a per-type carve-out, and *why was this filed* is just as valuable on an
agent-authored `claim` as on a capture. Scoping down to capture types only is
kept as an open question.

## Enforcement — `mix brain.verify`

New rules, in the verifier's existing named-error style:

- **Shape (from day one):** when `attribution` is present it must be a map;
  `when` parses as ISO 8601; `channel` is from the vocabulary; `agent` and `why`
  are non-empty strings — except `why`, which is optional when
  `channel: backfill` (the reason is often unrecoverable from history; invent
  nothing).
- **Placement:** `attribution` on a governance-namespace doc is an error (same
  boundary as `sb:` ids).
- **Presence (after backfill completes):** every bundle concept carries
  `attribution` — flipped on as a rule only once the backfill lands, so the rule
  is never aspirational. Until then presence is skill-enforced at filing time,
  not verifier-enforced.

Immutability is not machine-checked (the verifier sees one snapshot, not a diff)
— it is a contract obligation on agents, like "never hand-edit the registry",
with git review as the safety net.

## Writers — skill updates

- **`/intake` step 4 (Distill):** write `attribution` alongside the existing
  fields. `channel: intake`, `agent` = the acting agent/session context, `why` =
  the operator's ask in one sentence (the same natural phrasing step 8 harvests
  for the dedup gold set — one motion, two artifacts).
- **`/research` auto-intake step:** `channel: auto-intake`, `why` = the featuring
  reason (category match + reason-tag), which finally lands the digest's
  rationale *on the concept itself*. The `auto-intake` **tag** keeps being
  written during a transition window; once the editorial pass queries
  attribution instead (tooling below), the tag is retired from the skill and
  policy text.
- **`/add-to-glossary`:** `channel: glossary`, `why` = which thread/doc surfaced
  the term.
- **Inline agent filing** (a concept distilled mid-session outside any skill):
  `channel: agent-authored`, `why` = what in the session prompted filing it.

## Backfill

A one-shot `mix brain.attribution --backfill` derives attribution for the
existing corpus:

- `when` from `git log --diff-filter=A --follow` (first-add date).
- `channel`/`agent` heuristically from `tags` (`auto-intake` → `auto-intake`) and
  `provenance` text where unambiguous; otherwise `channel: backfill` with the
  derivable facts and no invented `why`.
- Output is an ordinary diff for operator review, not a silent rewrite.

After the backfill merges, the verifier's presence rule flips on.

## Tooling (optional phase — the machine consumer)

`mix brain.attribution` as a read-only query surface:
`mix brain.attribution --channel auto-intake --since 2026-07-01` lists matching
concepts (id, path, when, why). This makes the post-auto-intake editorial pass a
one-command listing instead of a tag grep, and is the consumer that justifies the
structured map over free text — same principle as typed edges: structure it only
because a machine will read it. If this phase is deferred, the structured shape
still costs nothing and stays grep-able.

## Interactions

- **Epistemic overlay plan** ([epistemic-overlay](/meta/plans/epistemic-overlay.md),
  `proposed`): no conflict. Attribution is event metadata *on* nodes; the overlay
  is typed edges *between* nodes. Both extend frontmatter under the same
  "document is the concept" commitment. If supersession lands there, a
  superseding concept gets its own fresh attribution (it is a new ingestion
  event), and the chain lives in the overlay's edges, not here.
- **Frontmatter-schema policy:** gains one row (`attribution` | When applicable →
  Mandatory after backfill | sub-key table or a pointer to the new policy).
- **Verification grounding:** untouched — attribution says how a concept
  *arrived*, never anything about whether it is *true*. `verified`/`verified_by`
  semantics are unaffected.

## Build order

1. **Ratify** this plan; on acceptance write the policy
   (`meta/policy/resource-attribution.md`, section: composition) and run
   `/render-contract`.
2. **Verifier shape rules** + ExUnit tests (mirroring the rule-6 pattern from the
   [code-review hardening plan](/meta/plans/code-review-toolchain-hardening.md)).
3. **Skill updates** (`/intake`, `/research`, `/add-to-glossary`) so every new
   concept is born attributed.
4. **Backfill task**, operator-reviewed diff, then flip the verifier presence
   rule on.
5. *(Optional)* `mix brain.attribution` query surface; retire the `auto-intake`
   tag once the editorial pass uses it.

## Open questions (for the operator)

1. **Scope:** all bundle concepts (proposed), or only resource-capture types
   (`reference`/`source`)?
2. **Presence:** flip to verifier-mandatory after backfill (proposed), or leave
   permanently recommended-but-optional?
3. **`agent` granularity:** name the model (as `provenance` sometimes does), the
   pathway ("Claude Code agent, /research Routine"), or both? Proposed: pathway
   over model name — the model is already in the commit trailer, and pathway is
   what trust calibration actually reads.
4. **Retire the `auto-intake` tag** after the transition window, or keep it
   indefinitely as a redundant convenience?
