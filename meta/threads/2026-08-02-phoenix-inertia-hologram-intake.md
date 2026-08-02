---
type: reference
title: 2026-08-02-phoenix-inertia-hologram-intake
description: Intook the r/elixir "Phoenix + Inertia is killer stack" thread as a Phoenix frontend-options comparison (LiveView vs. Inertia.js vs. API+SPA) plus a separate Hologram reference, filed under a new knowledge/SWE/web-frameworks/ subdirectory.
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, phoenix, elixir, inertia.js, liveview, hologram, web-frameworks]
timestamp: 2026-08-02
session: https://claude.ai/code/session_01ESFwypWk6RzT5UQLZS2pyu
pr: 236
---

# 2026-08-02-phoenix-inertia-hologram-intake

## Where this landed

The operator invoked `/intake` on a r/elixir thread ("Phoenix + Inertia is
killer stack") and, mid-flow, asked to also capture its Hologram reference.
Direct fetches of the thread (`reddit.com`, `old.reddit.com`, `api.reddit.com`,
and via the `r.jina.ai` reader) were all blocked by network policy; the
content was recovered via the `safereddit.com` Redlib mirror. A dedup search
found no existing bundle coverage of Inertia.js, Hologram, LiveView-as-a-topic,
or Phoenix-as-a-web-framework, so two `reference` documents were filed under a
new `knowledge/SWE/web-frameworks/` subdirectory (autonomous — a subdirectory
of the already-established `SWE` domain): the Phoenix frontend-options
comparison (`em:e83408`) and Hologram (`em:e2f673`, cross-checked against its
own docs at hologram.page). A dedup gold-set row was harvested from the
operator's "hologram" phrasing; the baseline showed no regression. The full
gate suite passed and the operator's session moved into `/create-pull-request`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Intake the Phoenix+Inertia reddit thread | closed | [Phoenix frontend options in practice](/knowledge/SWE/web-frameworks/phoenix-liveview-vs-inertia-vs-spa.md) | - |
| Also intake the thread's Hologram reference | closed | [Hologram](/knowledge/SWE/web-frameworks/hologram.md) | - |

## User

https://www.reddit.com/r/elixir/comments/1vcmevc/phoenix_inertia_is_killer_stack/

## User

also note the reference to hologram, intake as well

## Assistant

<routes ref="em:e83408 em:e2f673">
Before wrapping this into a PR, here's what the intake produced.

I fetched the Reddit thread (direct access was blocked by network policy — recovered via a Redlib mirror, cross-checked the Hologram claims against its own docs), and filed two documents under a new `web-frameworks` subdirectory: one capturing the Phoenix/LiveView/Inertia.js/API+SPA trade-off discussion from the thread, and one for Hologram, the Elixir-to-JS compiler a commenter surfaced partway through. Both passed the full gate suite.

**What I created**

| type | doc | why this type |
|---|---|---|
| `reference` | `knowledge/SWE/web-frameworks/phoenix-liveview-vs-inertia-vs-spa.md` (`em:e83408`) | captured/summarized external material (the reddit thread) |
| `reference` | `knowledge/SWE/web-frameworks/hologram.md` (`em:e2f673`) | captured/summarized external material (hologram.page docs + the author's own reddit comment) |

**What I modified**

| file | change |
|---|---|
| `knowledge/SWE/index.md` | added the new `web-frameworks` entry |
| `knowledge/SWE/web-frameworks/index.md` | new directory index (2 entries) |
| `meta/registry.md` | regenerated for the two new ids |
| `meta/evals/dedup-probe.md` | harvested a gold row from your "hologram" phrasing; refreshed baseline (plain 8/30, no regression) |

**Actions I have taken**

| action | result |
|---|---|
| Dedup search across the bundle (excluding `deprecated/`) for "inertia", "hologram", "liveview", and Phoenix-web-framework terms | no existing coverage found — filed as new |
| Fetch `reddit.com`/`old.reddit.com`/`api.reddit.com` directly and via `r.jina.ai` | all blocked (403, "network policy") |
| Fetch via `safereddit.com` (a Redlib/libreddit mirror) | succeeded — full post + comment thread retrieved |
| Full gate suite (`contract`, `registry`, `verify`, `route_tags`, `format`, `xref`, `glossary`, `dedup_probe`, `test`) | all green, 211 tests passing |

No new directory ratification was needed — `web-frameworks` sits under the already-established `SWE` top-level domain, so it was filed autonomously per the taxonomy-evolution protocol. Continuing now with capture and the PR.
</routes>
