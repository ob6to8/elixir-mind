---
id: em:9495ee
type: concept
title: channel
description: "In this brain, one word with two referents: the ingestion pathway recorded on a document (`attribution.channel`, from a controlled vocabulary), or a standing source — a recurring publication registered in `survey/channels.md`, monitored for new material and credited with what has been ingested from it."
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, attribution, survey, channels]
sense: repo
timestamp: 2026-07-28
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-27 channels-register-and-research-wiring thread"
---

# channel

Two repo senses, distinguished by what flows through them:

1. **Ingestion pathway** — the `channel` sub-key of every bundle document's
   [`attribution`](/beliefs/glossary/attribution.md) block: *how* the document
   entered the brain, drawn from a controlled vocabulary (`intake` ·
   `auto-intake` · `glossary` · `agent-authored` · `backfill`) that grows only
   by operator ratification (see the
   [resource-attribution policy](/meta/policy/resource-attribution.md)).
2. **Standing source** — a row in the
   [channels register](/survey/channels.md): a recurring publication
   (newsletter, blog, author feed, vendor docs, archive, video channel, forum)
   monitored for new material, carrying a focus line, an access note
   (free / login / paid), the documents already ingested from it, and the origin
   of the recommendation. The row runs in both directions — where to look and
   what it cost, plus what the looking yielded — so a source's continued place
   in the register is answerable from the register. Distinct from a bookmark in
   the [survey tier](/beliefs/glossary/survey-tier.md) — a channel is a *source*
   that keeps producing, a bookmark a *document* already produced; `/research`
   scans the register as its first per-domain search step.

*Seen in:* [2026-07-27 channels register and /research wiring](/meta/threads/2026-07-27-channels-register-and-research-wiring.md), [2026-07-28 channels register merge and video vetting](/meta/threads/2026-07-28-channels-register-merge-and-video-vetting.md), [channels register](/survey/channels.md), [resource-attribution policy](/meta/policy/resource-attribution.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:9495ee">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-channels-register-merge-and-video-vetting (2026-07-28)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:9495ee`]**  (co-feeds: `survey/channels.md`)

**They answered different questions.** Main's is forward-looking — *what should I monitor, and what does it cost to read?* (9 rows, Focus/Access/From, seeded from codesupreme.ai). Mine was backward-looking — *what has each source already produced?* (43 channels derived from filed documents, plus the vetted video set).

**I made main's shape win**, and not just because it landed first. It's ratified where mine was only proposed: the `channel` glossary concept (`em:9495ee`) defines a channel as a standing source with a focus line and an access note, and — the deciding factor — **`/research` scans this register as its first per-domain search step**, honoring the access note to decide what it may fetch. Restructuring around my medium-grouped `### heading` sections would have broken a live consumer.

---

**[`em:9495ee`]**  (co-feeds: `survey/channels.md`)

**In the register**, the scope statement is explicit about running in both directions: prospectively the focus line and access note (what `/research` reads before deciding what it may fetch), retrospectively the documents drawn from that source. The reason they belong in one row is stated too — the second is the evidence for the first. A channel earns continued attention by having yielded something, and a row that stays empty is a watchlist entry nobody has had to justify.
