---
id: em:7cdaf6
type: reference
title: "loopmaster / groovemaster: livecoding music in the browser via WASM DSP"
description: An open-source browser livecoding environment deployed under two names, groovemaster.xyz and loopmaster.xyz — writing signal-generator function calls (saw(), sine(), euclid()) produces audio instantly through a WebAssembly DSP engine, no install or plugins.
resource: https://groovemaster.xyz/
provenance: "Client bundle strings and metadata at groovemaster.xyz, fetched 2026-08-18; GitHub org loopmaster-xyz"
tags: [media-production, audio-synthesis, livecoding, webassembly, browser, generative-music, dsp]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# loopmaster / groovemaster: livecoding music in the browser via WASM DSP

groovemaster.xyz serves a live-coding music environment: writing code
produces audio in real time, in the browser, with no plugin or install. The
interface supports shareable "one-liners" (short example snippets), named
projects with an artist name and social-share links, and a project-export
flow.

## Two names, one project

The site is not a separate product from **loopmaster** — it is the same
open-source project under at least two domain names. Direct evidence, from
the page's own client bundle: the manifest identifies the app as
`"loopmaster"`; the in-app Discord, feedback board, support page, and
GitHub link (`github.com/loopmaster-xyz/loopmaster`, described as a
"Livecoding DSP environment") are all "loopmaster"-branded, while the
visible logo text, page title, and self-canonicalizing hostname redirect
are "groovemaster"-branded. This reads as a project mid-rename or
dual-branded rather than two competing tools.

## What the tool actually is

From the client bundle (function names referenced by the UI, not a full
language spec): a functional DSL of signal-generator calls (`saw()`,
`sine()`, `euclid` — Euclidean-rhythm — sequencer references), compiled or
interpreted into a WebAssembly DSP engine running through the Web Audio
`AudioWorklet` API for low-latency real-time audio, MIT-licensed, built with
Bun tooling. This puts it in the same family as Strudel, Tidal Cycles, and
Sonic Pi (function-call/pattern-language livecoding), distinguished by
targeting WASM rather than a server-side or native audio engine.

## Relation to this bundle's DSP material

The "code as a compiler specification, not an interpreted patch" framing
this bundle already holds for gen~ —
[DSP reduces to a small primitive vocabulary](/knowledge/media-production/audio-synthesis/gen-dsp-primitive-reduction.md)
— is the same shape of claim made here for a different substrate: loopmaster
turns short function-call code into a compiled WASM DSP graph rather than
interpreting it sample-by-sample.

# Citations

- <https://groovemaster.xyz/> — product site
- <https://github.com/loopmaster-xyz/loopmaster> — source repository
