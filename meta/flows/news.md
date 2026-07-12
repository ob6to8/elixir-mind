---
type: note
title: News — the daily candidate feed into the inbox
description: The end-to-end flow for a /news run — building the query profile from the taxonomy, the double dedup, the reason-tag featuring gates, the cross-domain read, and the write into the non-bundle inbox/ namespace — the touch-sequence, actor boundaries, invariants, and why this flow's spine is thin and deliberately outside the id gates.
tags: [meta, governance, news, inbox, feed, flow, workflow]
timestamp: 2026-07-12
---

# News — the daily candidate feed into the inbox

The connective doc for the brain's scanning surface: how a `/news` run turns
the outside world into today's dated inbox digest — candidates with synopses,
held in the waiting room until the operator graduates one through `/intake`.
It narrates the flow end to end and points at the artifacts that make it work;
it does **not** restate the procedure — that has a home.

> **The artifacts (point, don't restate):**
> - **Rules** → [link-processing](/meta/policy/link-processing.md) (the inbox
>   parks *candidates*, never bundle concepts) ·
>   [tree-is-the-taxonomy](/meta/policy/tree-is-the-taxonomy.md) (the tree is
>   the query profile) · the design records
>   [news-daily-read-synthesis](/meta/plans/news-daily-read-synthesis.md).
> - **Procedure** → the [`/news` skill](/.claude/skills/news/SKILL.md) — the
>   featuring gates, the reason-tag vocabulary, the digest format.
> - **Namespace mechanics** → [bundle scope and non-bundle
>   namespaces](/meta/tutorials/bundle-scope-and-non-bundle-namespaces.md) —
>   why `inbox/` is registry-excluded but site-rendered.
> - **Operational state** → the open issue
>   [daily /news Routine runs not landing](/meta/issues/daily-news-routine-runs-not-landing.md).

---

## 1. The problem

The brain only grows when the operator feeds it, and the operator's attention
is the scarcest input. `/news` inverts the direction: instead of the operator
hunting for material, the brain's *own taxonomy* is used as a standing query
against the outside world, and the results wait — distilled to
decide-at-a-glance synopses — in a namespace that can't contaminate the bundle.

## 2. The pipeline

```
   the taxonomy (index.md tree + concept titles/tags/ids)
          │  read
          ▼
   ┌──────────────┐   /news (daily or on demand)
   │ QUERY PROFILE │   per-domain interest signals + recent sb: ids
   └──────┬───────┘
          │  search per domain (web, papers)
          ▼
   ┌──────────────┐   dedup ×2: vs the bundle, vs recent digests
   │ SELECT + TAG  │   featuring gates: relevance · novelty · a reason
   └──────┬───────┘   tag fires · source quality; then the volume cap
          │
          ▼
   ┌──────────────┐   the cross-domain synthesis, grounded in sb: ids
   │  THE READ     │   (reinforce / contest / extend filed positions)
   └──────┬───────┘
          ▼
   inbox/YYYY-MM-DD.md   (type: reference, no sb: id, immutable)
   inbox/index.md        (latest pointer + archive list)
```

Almost all of this is **agent judgment** — search, selection, tagging, and the
read have no mechanical oracle. The deterministic part is only the write
conventions at the bottom: the dated filename, the frontmatter shape, the
digest immutability, and the index upkeep.

## 3. The touch-sequence (a canonical run)

| # | Actor | Action | Files touched | Checked by |
|---|-------|--------|---------------|------------|
| 1 | operator/Routine | Invoke `/news` (by hand, or the scheduled daily fire) | — | — |
| 2 | agent | Build the query profile: root + domain `index.md`s, concept titles/tags, recent `sb:` ids | — (reads bundle) | editorial |
| 3 | agent | Search per domain (current window; primary sources preferred) | — (reads external) | editorial |
| 4 | agent | Dedup twice — against the bundle, against recent digests | — (reads bundle + inbox) | editorial |
| 5 | agent | Feature + reason-tag (the four gates, then the volume cap) | — | editorial |
| 6 | agent | Write **the read**, grounded in `sb:` ids | — | editorial |
| 7 | agent | Write today's digest (regenerate the same file if it exists) | `inbox/YYYY-MM-DD.md` | convention (site render) |
| 8 | agent | Maintain the inbox landing view: latest pointer + archive entry | `inbox/index.md` | convention (site render) |
| 9 | operator | Read the digest; optionally say "intake the … item" → `/intake` handoff | — | editorial |

## 4. Actor boundaries

| Actor | Does |
|-------|------|
| **Operator** | reads the digest; picks candidates for `/intake`; ratifies additions to the reason-tag vocabulary |
| **Agent** | profiles, searches, dedups, features, tags, writes the read and the digest, maintains `inbox/index.md` |
| **Routine** | fires the daily run on schedule (currently not landing — see the [open issue](/meta/issues/daily-news-routine-runs-not-landing.md)) |

## 5. The data model

Digests are **candidates, not concepts**: `type: reference`, no `sb:` id, in
the `inbox/` namespace that `Registry.scan/1` excludes — so the id gates
(`brain.id`/`brain.registry`/`brain.verify`) never see them, and a daily feed
can never break CI or pollute the identity layer. The site renders the inbox
anyway (namespaces the registry ignores are still shown), so the digest is
readable on Pages. Graduation is one-way and explicit: `/intake` on a picked
item produces a real bundle concept; the digest line may gain a
`✓ intaken → /path` backlink — the sole allowed edit to a past digest.

## 6. Invariants

- **The inbox proposes; only `/intake` files.** Nothing under `inbox/` carries
  an `sb:` id or a `verified` field, ever.
- **Digests are immutable** once written (except the intake backlink); the
  dated files are their own archive.
- **The taxonomy is the filter.** No mapping to a domain's interest signals ⇒
  not featured, however interesting in the abstract.
- **Reason tags are a fixed vocabulary** — the tags *are* the featuring
  criteria; additions are proposed to the operator, never invented silently.
- **The read is a perspective, not a re-listing** — cross-domain, grounded in
  `sb:` ids, asserting nothing beyond what the day's selections support.

## 7. Verify — why this flow has no scenario test

The flows genre pairs each doc with an ExUnit scenario pinning the flow's
deterministic spine — where one exists. `/news` is the limit case: its spine is
**write conventions, not tooling** — no `mix brain.*` task participates, no id
is minted, no generated artifact must stay fresh. The mechanical checks that do
apply are indirect: the site build (a gate) renders `inbox/`, so a digest that
breaks markdown structure fails there, and the registry's exclusion list is
what *keeps* the digests out of the id gates (pinned by the registry tests).
The editorial spot-checks carry the rest: did every featured item clear the
four gates; is the read grounded in real `sb:` ids; were both dedup passes
actually run. If the inbox conventions ever grow tooling (e.g. a digest-shape
validator), a scenario should pin it then — deferred, not forgotten.

**Reference instance.** [`inbox/2026-07-11.md`](/inbox/2026-07-11.md) is a
worked green run: multi-domain, reason-tagged, with a read grounded in filed
concepts.
