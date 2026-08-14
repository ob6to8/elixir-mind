---
id: em:4a51b2
type: reference
title: "DrivenByMoss OSC — Bitwig's de-facto OSC server"
description: "DrivenByMoss's Open Sound Control module turns Bitwig into a bidirectional UDP OSC endpoint: a documented address space for transport, track mixing, device/project remote controls, clip and scene launching, and virtual-keyboard MIDI, plus a feedback stream of DAW state — the zero-code plane for controlling Bitwig from any process that can send a datagram."
resource: "https://github.com/git-moss/DrivenByMoss-Documentation/blob/master/Generic-Tools-Protocols/Open-Sound-Control-(OSC).md"
provenance: "Claude Fable 5 distillation of the DrivenByMoss documentation and mossgrabers.de release page, fetched 2026-08-14"
tags: [media-production, daw-control, bitwig, osc, drivenbymoss, reference]
timestamp: 2026-08-14
attribution:
  when: 2026-08-14T22:35:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "the address space a shell-control tool for Bitwig would be built on, captured so the design can cite exact addresses"
---

# DrivenByMoss OSC

[DrivenByMoss](https://github.com/git-moss/DrivenByMoss) — "Bitwig Studio
extensions for many controllers: Ableton Push I/II, Akai APC40mkI/mkII/mini,
Fire, Arturia Beatstep, Novation Launchpads / Remote SLs, NI Maschine /
Komplete, Open Sound Control (OSC) and many more" — includes a generic OSC
module that makes a running Bitwig a **bidirectional UDP OSC endpoint**.
Current release 26.6.3 (2026-07-26), LGPLv3, distributed from
[mossgrabers.de](http://www.mossgrabers.de/Software/Bitwig/Bitwig.html) and
listed there under "Bitwig 5.3+" (a reading that includes Bitwig 6; the page
names no explicit Bitwig 6 statement — confirm on install).

## Setup

Install the extension, add **Open Sound Control** as a controller in Bitwig's
settings, then configure the network in the extension's preferences — the
documentation's own field descriptions:

> "Port to receive on: The port on which the OSC extension listens for
> incoming commands."
> "Host to send to: The host address to which to send OSC commands from the
> OSC extension." / "Port to send to: The host port to which to send OSC
> commands from the OSC extension."
> "Value resolution: Configures the value range to use. Higher values provide
> a higher resolution but the client need (or OSC template of your client)
> needs to be configured accordingly!"
> "Bank page size: The number of entries to be used for bank pages. The
> default is 8."

Send and receive ports must differ. Numeric ranges written `{0-MAX_VALUE}`
below scale with the configured value resolution.

## Address space (the load-bearing subset)

Extracted from [the register](https://github.com/git-moss/DrivenByMoss-Documentation/blob/master/Generic-Tools-Protocols/Open-Sound-Control-(OSC).md);
`{1-8}` indices address the current bank page (size configurable, default 8).

| Address | Value | Effect |
|---|---|---|
| `/play` | `{0,1,-}` | stop/start/toggle playback |
| `/stop` | — | halt playback |
| `/record` | — | arranger record |
| `/tempo/raw` | `{0-666}` | set tempo (decimals accepted) |
| `/click` | `{0,1,-}` | metronome |
| `/track/{1-8}/volume` | `{0-MAX_VALUE}` | track volume |
| `/track/{1-8}/pan` | `{0-MAX_VALUE}` | pan (0 = left) |
| `/track/{1-8}/mute` · `/solo` · `/recarm` | `{0,1,-}` | switch/toggle |
| `/device/param/{1-8}/value` | `{0-MAX_VALUE}` | selected device's remote-control slot |
| `/device/param/{1-8}/reset` | — | reset slot to default |
| `/device/bypass` | — | bypass device |
| `/project/param/{1-8}/value` | `{0-MAX_VALUE}` | project-wide remote controls |
| `/track/{1-8}/clip/{1-8}/launch` | `{0,1}` | launch/release clip |
| `/scene/{1-8}/launch` | `{0,1}` | launch scene |
| `/vkb_midi/{Ch:1-16}/note/{Note:0-127}` | `{Vel:0-127}` | play a note |
| `/vkb_midi/{Ch:1-16}/drum/{Note:0-127}` | `{Vel:0-127}` | play a drum pad note |
| `/vkb_midi/{Ch:1-16}/cc/{CC:0-127}` | `{Val:0-127}` | send a CC |

The full register is several times this size (browser, marker, layout,
groove, note-repeat, bank navigation …); this capture keeps only what a
shell-control surface stands on.

## Feedback — Bitwig talks back

The extension **sends** state to the configured client host/port as the DAW
changes: `/play {0,1}`, `/tempo/raw`, `/time/str`, per-track
`/track/{n}/volume` · `/pan` · `/mute`, per-slot `/device/param/{n}/value`,
with `/update {0,1}` bracketing each update cycle. A shell listener on the
send port therefore observes Bitwig in realtime — state is readable, not only
writable.

## Why this plane matters

- **Zero code to adopt** — any OSC-capable process controls Bitwig; see
  [realtime OSC from the shell](/knowledge/media-production/daw-control/osc-from-the-shell.md).
- **Reaches the Grid** — `/device/param/…` drives whatever a Grid patch's
  remote-control pages expose; `/vkb_midi/…` plays its voices (see
  [the Grid's programmability boundary](/knowledge/media-production/daw-control/bitwig/the-grid-programmability-boundary.md)).
- **Actively maintained** — release cadence tracks Bitwig's, unlike the
  WebSocket-RPC bridge (README targets Extension API 8–10, Bitwig 3.x era).

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:4a51b2">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-14-bitwig-shell-control-incubation-and-agentic-daw-fit (2026-08-14)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:4a51b2`]**  (co-feeds: `em:b91fe3 em:bb3021`)

**The ten-minute path** (commands composed from the cited docs, unexecuted here): install DrivenByMoss from mossgrabers.de, add its **Open Sound Control** controller in Bitwig's settings, note the receive/send ports, then:

```sh
oscsend localhost 8000 /play i 1                  # transport starts
oscsend localhost 8000 /device/param/1/value i 96 # selected Grid patch, slot 1 moves
oscsend localhost 8000 /vkb_midi/1/note/60 i 100  # play middle C into it
oscdump 9000                                      # watch Bitwig's state stream back
```
