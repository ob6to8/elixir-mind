---
id: em:a1b6d2
type: note
title: "Bitwig's programmatic control surfaces"
description: "A running Bitwig Studio instance is externally controllable through four planes — Open Controller API extensions (in-process Java/JS), the DrivenByMoss OSC address space (UDP, bidirectional), plain MIDI mapping, and a community WebSocket JSON-RPC bridge — all converging on the same parameter model; realtime control means driving parameters, transport, clips, and notes, not editing device graphs."
verified: false
provenance: "Claude Fable 5, distilled from the web sources cited inline, fetched 2026-08-14; not exercised against a live Bitwig instance in the authoring session"
tags: [media-production, daw-control, bitwig, osc, controller-api, midi, realtime]
timestamp: 2026-08-14
attribution:
  when: 2026-08-14T22:35:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "the operator asked for shell-based realtime control of Bitwig; this maps which control planes exist before designing on one"
---

# Bitwig's programmatic control surfaces

Bitwig Studio (current major version 6, released 2026-03-11) has no built-in
shell or scripting console, but a running instance exposes four control planes
to external processes. All four converge on the same underlying model — the
**Open Controller API**'s view of transport, tracks, clips, and each device's
**remote controls** (banked pages of 8 mappable parameter slots).

## The four planes

1. **Open Controller API extensions** — in-process Java (`.bwextension`) or
   JavaScript (`.control.js`) code loaded by Bitwig as a "controller".
   Full-fidelity: transport, track banks, clip launching, device and project
   remote controls, browsing/preset loading, note input. Extensions can open
   their own network endpoints — the API ships an OSC module
   (`host.getOscModule()` → `createAddressSpace()` in community extension
   code), which is how OSC bridges are implemented as ordinary extensions.
   This is the plane every other plane is built on.
2. **DrivenByMoss OSC** — Jürgen Moß's LGPL extension suite (current
   26.6.3, 2026-07-26, listed for "Bitwig 5.3+") includes a generic
   **Open Sound Control** module: a documented UDP address space for
   transport, track mixing, device/project parameters, clip and scene
   launching, and virtual-keyboard MIDI, with a feedback stream of DAW state
   sent to a client port. The practical plane for shell control — any process
   that can emit a UDP datagram can drive Bitwig. Details:
   [DrivenByMoss OSC](/knowledge/media-production/daw-control/bitwig/drivenbymoss-osc.md).
3. **Plain MIDI mapping** — Bitwig's per-parameter MIDI learn ("Map to
   Controller or Key") plus the MIDI modulator. Works from any virtual MIDI
   port, so shell tools that emit MIDI reach it; costs 7-bit resolution and
   hand-built mappings, and offers no feedback or discovery.
4. **WebSocket JSON-RPC** — the community bridge
   [`jhorology/bitwig-websocket-rpc`](https://github.com/jhorology/bitwig-websocket-rpc)
   wraps controller-API modules (transport, mixer, browser, cursor track …)
   in JSON-RPC 2.0 over `ws://localhost:8887`, installable via
   `npx bws-rpc install`. Attractive for request/response queries, but its
   README documents Extension API versions 8–10 (a Bitwig 3.x-era surface,
   with an API-15 support commit later in its history), so treat it as a
   staleness risk against Bitwig 6 until proven.

## What "realtime control" reaches

Every plane manipulates the *running state* of the project: start/stop,
tempo, mixer levels, any parameter exposed on a device's remote-control
pages (Grid patches included — see
[the Grid's programmability boundary](/knowledge/media-production/daw-control/bitwig/the-grid-programmability-boundary.md)),
clip/scene launches, and live note events. Control is at UI/control rate
over UDP or WebSocket — fine for performing and automation-style sweeps,
not a sample-accurate scheduler. For sample-accurate composition the
brain's declared-grid NRT pipeline is the complementary tense:
[code-driven AV production](/projects/code-driven-av-production.md).

## Choosing a plane

Shell-first realtime control wants **DrivenByMoss OSC** (documented, current,
bidirectional, zero code to adopt); the **Controller API** is the endgame
when a bespoke address space or richer introspection is needed; **MIDI** is
the fallback for one-off knob mappings; the **WebSocket bridge** is the
option to re-evaluate if structured queries become load-bearing. For
agent-native (MCP) consumers, packaged bridges over the Controller API
already exist: [WigAI](https://github.com/fabb/WigAI) (an extension serving
MCP at `localhost:61169/mcp`; Bitwig 5.2.7+, Java 21) and
[bitwig-mcp-server](https://github.com/WeModulate/bitwig-mcp-server).

## Citations

- Bitwig 6 launch coverage: [Sound On Sound](https://www.soundonsound.com/news/bitwig-studio-6-launches),
  [MusicTech](https://musictech.com/news/gear/bitwig-studio-6/)
- [DrivenByMoss](https://github.com/git-moss/DrivenByMoss) and its
  [OSC register](https://github.com/git-moss/DrivenByMoss-Documentation/blob/master/Generic-Tools-Protocols/Open-Sound-Control-(OSC).md);
  version/compatibility from [mossgrabers.de](http://www.mossgrabers.de/Software/Bitwig/Bitwig.html)
- Controller API usage: [Bitwig on controller integration](https://www.bitwig.com/stories/controller-integration-in-bitwig-studio-414/),
  `getOscModule` example via [programtalk extract](https://programtalk.com/java-more-examples/com.bitwig.extension.api.opensoundcontrol.OscAddressSpace.registerDefaultMethod()/),
  community OSC extensions ([charles-bitwig-osc](https://github.com/CharlesHolbrow/charles-bitwig-osc))
- MIDI mapping: [Bitwig userguide, MIDI controllers](https://www.bitwig.com/userguide/latest/midi_controllers/)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:a1b6d2">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-14-bitwig-shell-control-incubation-and-agentic-daw-fit (2026-08-14)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:a1b6d2`]**  (co-feeds: `em:892df3`)

Research is sufficient. The picture: DrivenByMoss 26.6.3 (July 2026) gives Bitwig a documented OSC address space with feedback; the Grid is officially "controllable from the same Open Controller API" via remote controls; patch *topology* editing has no API. Now I'll set up the branch and check the id-minting workflow before writing the docs.

---

**[`em:a1b6d2`]**  (co-feeds: `em:bb3021`)

**The design in one paragraph:** ride DrivenByMoss OSC as the sole transport (documented address space, bidirectional, release cadence tracking Bitwig's); reject the community WebSocket-RPC bridge as primary (its README targets Extension API 8–10, a Bitwig 3.x-era surface — staleness risk against Bitwig 6) and defer a bespoke controller extension until the OSC surface proves insufficient; build `bw` as an Elixir escript (`:gen_udp` + the OSCx encode/decode library) with verbs like `bw play`, `bw track 3 volume 0.8`, `bw param 1 0.5`, `bw sweep`, `bw watch`, and a phase-3 mapping layer so `bw grid cutoff 0.7` resolves named parameters per patch.
