---
id: em:e2f673
type: reference
title: "Hologram — full-stack Elixir web framework that compiles to JavaScript"
description: An Elixir web framework, built on Phoenix, that transpiles the client-side portion of an Elixir codebase directly to JavaScript so browser-side interactivity needs no round trip to the server and no hand-written JS.
resource: https://hologram.page/
provenance: "hologram.page introduction docs and the author's (bartblast) own description in the r/elixir 'Phoenix + Inertia is killer stack' thread, fetched 2026-08-02"
tags: [hologram, elixir, phoenix, transpiler, frontend-architecture, beam]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to also capture the Hologram reference surfaced in the Phoenix+Inertia reddit thread"
---

# Hologram

Hologram is a "full-stack isomorphic Elixir web framework that runs on top of
[Phoenix](/knowledge/SWE/web-frameworks/phoenix-liveview-vs-inertia-vs-spa.md)."
It lets an app be written entirely in Elixir — including the parts that run in
the browser — by having the framework itself decide which code needs to ship
client-side and compiling that code to JavaScript.

## How it differs from LiveView and a WASM/BEAM-in-browser approach

Its author, replying in the r/elixir thread that surfaces this framework,
states the core mechanism plainly:

> "Your Elixir compiles to JS, so handlers run in the browser with no round
> trip and no socket to drop. Semantics match the BEAM down to the error
> messages. [...] There's no VM in there, so no WASM and no `.beam` files.
> Shipping a VM to the browser would balloon the bundle substantially, which
> isn't practical. JS is just the substrate the compiler targets."
>
> — Hologram's author, replying in [the r/elixir thread](https://www.reddit.com/r/elixir/comments/1vcmevc/phoenix_inertia_is_killer_stack/)

This targets the two specific LiveView costs raised elsewhere in that same
thread (see
[the Phoenix frontend-options comparison](/knowledge/SWE/web-frameworks/phoenix-liveview-vs-inertia-vs-spa.md)):
LiveView keeps interactivity live over a WebSocket that can drop and
reconnect; Hologram's compiled-to-JS handlers run client-side with no
connection to maintain. The trade-off is architectural rather than free:
Hologram is a **compiler**, not a runtime — it statically determines which
code is reachable from the client and transpiles only that, rather than
shipping a BEAM VM (WASM-based or otherwise) into the browser.

## Architecture, per its own docs

- **Isomorphic**: server-side rendering for the initial page load, then
  client-side state management for subsequent interactivity — the same Elixir
  code runs in both places.
- **Automatic code distribution**: the framework analyzes the call graph and
  separates client-bound code from server-only code without manual
  configuration (no explicit "this runs on the client" annotation described in
  the intro docs beyond the framework's own analysis).
- **HTTP/2 persistent connections** for client-server communication (distinct
  from LiveView's WebSocket channel).
- **Component-based**, with declarative stateful and stateless components;
  design influences cited are Elm, Phoenix LiveView, Surface, and Rails.

## Maturity

As of this capture, Hologram is pre-1.0 (the thread comment cites "0.10," with
"some rough edges") but described by its author as already running in
production for some users. Source: [github.com/bartblast/hologram](https://github.com/bartblast/hologram).

# Citations

- [hologram.page](https://hologram.page/) — project site
- [hologram.page/docs/introduction](https://hologram.page/docs/introduction) — architecture overview
- [github.com/bartblast/hologram](https://github.com/bartblast/hologram) — source
- Author's comment in [r/elixir: "Phoenix + Inertia is killer stack"](https://www.reddit.com/r/elixir/comments/1vcmevc/phoenix_inertia_is_killer_stack/)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:e2f673">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-02-phoenix-inertia-hologram-intake (2026-08-02)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:e2f673`]**  (co-feeds: `em:e83408`)

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
