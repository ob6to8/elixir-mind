---
id: em:bb3021
type: plan
title: "Bitwig shell control — architecture and build order"
description: "Design for `bw`, a shell-first realtime control surface for Bitwig Studio: ride the DrivenByMoss OSC address space (transport decision), expose Grid DSP through a remote-controls naming convention, build as an Elixir escript in its own repo — phased from a zero-code smoke test through send verbs, a feedback watcher, and a named-parameter mapping layer, with a custom controller extension held as the deferred endgame."
status: proposed
provenance: "Claude Fable 5, agent-authored from the session's web research"
tags: [projects, bitwig, plan, architecture, osc, cli, elixir, the-grid]
timestamp: 2026-08-14
attribution:
  when: 2026-08-14T22:35:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "records the transport decision, command surface, and build order for the bw CLI before any of it is built, so a fresh session (or the operator) can execute without re-deriving the research"
---

# Bitwig shell control — architecture and build order

**The problem.** Bitwig has no shell surface: every realtime gesture —
starting the transport, sweeping a Grid patch's filter, launching a scene —
requires the GUI or a hardware controller. The operator wants those gestures
scriptable from a terminal, which also makes them loopable, bindable, and
drivable by agents. The research (filed under
[daw-control](/knowledge/media-production/daw-control/index.md)) found the
control planes that exist; this plan picks one and shapes a tool on it.

**The constraint that shapes everything.** The Grid is
[parameter-addressable, not patch-addressable](/knowledge/media-production/daw-control/bitwig/the-grid-programmability-boundary.md):
external control performs a patch through its exported surface (remote-control
slots, notes, modulators) and swaps presets for topology change. So the tool's
job is ergonomic, observable *parameter performance* — never patch editing.

## Current state

```
operator gesture → Bitwig
├── GUI            mouse only; nothing scriptable
├── DrivenByMoss   installed? unknown — its OSC module is the documented UDP
│                  address space (/play, /device/param/{n}/value, /vkb_midi/…)
│                  with a feedback stream; zero adoption cost once configured
├── MIDI learn     per-parameter hand mapping, 7-bit, no feedback
└── websocket-rpc  community JSON-RPC bridge; README targets API 8–10
                   (Bitwig 3.x era) — staleness risk against Bitwig 6
```

## Desired state

```
shell → bw → Bitwig (realtime, bidirectional)
├── bw <verb> …          one gesture = one command = one UDP datagram
│   ├── transport        bw play · bw stop · bw tempo 128 · bw click on
│   ├── mixer            bw track 3 volume 0.8 · bw track 3 mute
│   ├── params           bw param 1 0.5           (selected device slot 1)
│   │                    bw project-param 2 0.7   (project-wide macros)
│   ├── clips/scenes     bw clip 3 2 launch · bw scene 1 launch
│   ├── notes            bw note c3 100 · bw note c3 off   (Grid synths playable)
│   └── raw              bw raw /device/param/1/value 96   (full register escape hatch)
├── bw sweep <slot> <from> <to> <secs>    control-rate ramps (the shell-loop killer)
├── bw watch [pattern]   decoded feedback stream (oscdump with names)
└── bw map …             phase 3: names → (page, slot) per project/patch
                         bw grid cutoff 0.7  ≡  bw param 1 0.7 under the map
```

## File-tree (new external repo `bw/`, per the projects namespace)

```
bw/
├── mix.exs                  # NEW — escript entry; deps: OSCx (encode/decode only)
├── lib/bw.ex                # NEW — public API: send/2, watch/1, sweep/4
├── lib/bw/cli.ex            # NEW — escript main/1: verb parse → command dispatch
├── lib/bw/command.ex        # NEW — verb → {address, args} table (the vocabulary)
├── lib/bw/osc.ex            # NEW — OSCx encode/decode + :gen_udp send/listen
├── lib/bw/map.ex            # NEW (phase 3) — named params: YAML per project → (page, slot)
└── test/                    # NEW — command-table and codec tests; UDP loopback scenario
```

## Flow trees

Production (send path and watch path are independent):

```
bw play
└── Bw.CLI.main/1 → Bw.Command.resolve/1 → Bw.OSC.send/2 → UDP :8000 → DrivenByMoss → Bitwig

bw watch
└── Bw.OSC.listen/1 (UDP :9000) → decode → Bw.CLI render loop → stdout
```

Under test, the UDP seam substitutes: `Bw.OSC` sends to a loopback
`:gen_udp` fixture socket owned by the test, which asserts on decoded
packets — no Bitwig in CI, ever; the live smoke test is phase 0 on the
operator's machine.

## Signatures

```elixir
@spec send(verb :: [String.t()], opts :: keyword()) :: :ok | {:error, term()}
@spec resolve(verb :: [String.t()]) :: {:ok, {address :: String.t(), args :: [OSCx.arg()]}} | {:error, :unknown_verb}
@spec listen(port :: :inet.port_number()) :: Enumerable.t()   # stream of decoded messages
@spec sweep(slot :: 1..8, from :: float(), to :: float(), seconds :: float()) :: :ok
```

## Boundary decisions

- **DrivenByMoss owns the Bitwig side.** `bw` never links against the
  Controller API; the extension is configuration, not code this project
  maintains.
- **`Bw.Command` owns the vocabulary.** One table maps verbs to addresses;
  adding a verb is a data change. `bw raw` bypasses it so the full register
  is reachable before the table grows.
- **`Bw.OSC` owns transport.** Encoding via OSCx, sockets via `:gen_udp`;
  nothing above it knows about datagrams.
- **State lives in Bitwig.** `bw` is stateless per invocation; `watch` renders
  the feedback stream and holds nothing. (A caching daemon is deliberately
  out of scope until a real use demands `bw state`.)
- **The patch's remote-control pages are its public interface.** Grid
  patches are authored with slots named and paged intentionally; `bw map`
  (phase 3) records that interface, it does not discover it.

## Build order

0. **Smoke test, zero code (operator, ~10 min).** Install DrivenByMoss
   (26.6.3, mossgrabers.de), add the OSC controller, note its
   receive/send ports, then from the shell:
   `oscsend localhost 8000 /play i 1` → transport runs;
   `oscsend localhost 8000 /device/param/1/value i 96` → selected Grid
   patch's slot 1 moves; `oscdump 9000` → feedback visible. Commands and
   caveats: [realtime OSC from the shell](/knowledge/media-production/daw-control/osc-from-the-shell.md).
   **Gate: this passing is the premise of every later phase.**
1. **`bw` send verbs.** Escript with the desired-state vocabulary minus
   watch/map; `--host/--port` flags with env-var defaults; command-table
   tests.
2. **Feedback.** `bw watch [pattern]` over the send port; decoded, greppable.
3. **Named parameters.** `bw map` YAML (per project/patch) resolving
   `bw grid cutoff 0.7`; the naming convention documented in the repo.

**Deferred** (in this doc until they graduate): a bespoke controller
extension via the API's OSC module (`host.getOscModule()`) if the
DrivenByMoss surface proves insufficient — richer introspection, stable
track addressing beyond bank pages; a pattern/live-coding bridge
(TidalCycles-style) atop `/vkb_midi`; re-evaluating
[bitwig-websocket-rpc](https://github.com/jhorology/bitwig-websocket-rpc)
if structured query becomes load-bearing.

## Anchors

- Address space + feedback: [DrivenByMoss OSC](/knowledge/media-production/daw-control/bitwig/drivenbymoss-osc.md)
  (primary: the [register](https://github.com/git-moss/DrivenByMoss-Documentation/blob/master/Generic-Tools-Protocols/Open-Sound-Control-(OSC).md))
- Shell OSC tools: [osc-from-the-shell](/knowledge/media-production/daw-control/osc-from-the-shell.md)
- Encoding lib: [OSCx on hexdocs](https://oscx.hexdocs.pm/OSCx.html) —
  "deliberately minimalistic and no network transport or process logic is
  included", exactly the seam shape above
- Control-plane map: [bitwig-control-surfaces](/knowledge/media-production/daw-control/bitwig/bitwig-control-surfaces.md)

## Decisions

- **Recommended:** OSC via DrivenByMoss as the sole transport; Elixir escript
  (operator's home stack; `:gen_udp` + OSCx keeps deps near zero); phases 0–3
  as ordered above.
- **Rejected:** *websocket-rpc as primary* — API 8–10 era vs Bitwig 6,
  staleness risk with no offsetting need yet. *MIDI as primary* — 7-bit,
  hand-mapped, no feedback. *Custom extension first* — highest-fidelity
  endgame, wrong first move: it front-loads Java build/install cost before
  the OSC surface's sufficiency has been tested against real use.
- **Open questions:** the operator's machine/OS for phase 0 (the AV-production
  hub records macOS — `brew install liblo` — assumed here, unchecked for this
  project); whether DrivenByMoss 26.6.3 installs clean against the operator's
  Bitwig 6.x (its page says "Bitwig 5.3+", no explicit 6 statement — phase 0
  answers it); whether `bw` wants a daemon mode later (declined for now, see
  boundary decisions).

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:bb3021">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-14-bitwig-shell-control-incubation-and-agentic-daw-fit (2026-08-14)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:bb3021`]**  (co-feeds: `em:b91fe3 em:4a51b2`)

**The ten-minute path** (commands composed from the cited docs, unexecuted here): install DrivenByMoss from mossgrabers.de, add its **Open Sound Control** controller in Bitwig's settings, note the receive/send ports, then:

```sh
oscsend localhost 8000 /play i 1                  # transport starts
oscsend localhost 8000 /device/param/1/value i 96 # selected Grid patch, slot 1 moves
oscsend localhost 8000 /vkb_midi/1/note/60 i 100  # play middle C into it
oscdump 9000                                      # watch Bitwig's state stream back
```

---

**[`em:bb3021`]**  (co-feeds: `em:a1b6d2`)

**The design in one paragraph:** ride DrivenByMoss OSC as the sole transport (documented address space, bidirectional, release cadence tracking Bitwig's); reject the community WebSocket-RPC bridge as primary (its README targets Extension API 8–10, a Bitwig 3.x-era surface — staleness risk against Bitwig 6) and defer a bespoke controller extension until the OSC surface proves insufficient; build `bw` as an Elixir escript (`:gen_udp` + the OSCx encode/decode library) with verbs like `bw play`, `bw track 3 volume 0.8`, `bw param 1 0.5`, `bw sweep`, `bw watch`, and a phase-3 mapping layer so `bw grid cutoff 0.7` resolves named parameters per patch.

---

**[`em:bb3021`]**

One premise to know before phase 0: the plan assumes your macOS machine from the AV-production project's record (`brew install liblo`), and the 8000/9000 ports in the examples are conventional defaults from training — read the real values off the extension's settings pane.
