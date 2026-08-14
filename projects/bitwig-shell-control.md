---
id: em:e36f3a
type: project
title: "Bitwig shell control"
description: "A shell-first realtime control surface for Bitwig Studio — transport, mixer, device and Grid remote controls, clip/scene launching, and live note injection driven from a terminal (and observable back in it), riding the DrivenByMoss OSC address space, with an ergonomic `bw` CLI to be built outside this repo."
status: incubating
provenance: "Claude Fable 5, agent-authored from the session's web research"
tags: [projects, bitwig, osc, daw-control, the-grid, dsp, realtime, elixir, cli]
timestamp: 2026-08-14
attribution:
  when: 2026-08-14T22:35:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "the operator asked to introduce shell-based realtime control of Bitwig's Grid, DSP, and other features; this hub incubates the system that answers it"
---

# Bitwig shell control

Realtime control of a running Bitwig Studio from the shell: start and stop
the transport, set the tempo, mix tracks, sweep any parameter a device or
**Grid** patch exposes, launch clips and scenes, play notes into a Grid
synth, and watch the DAW's state stream back — each action one command, so
everything is scriptable, loopable, and drivable by agents. The vehicle is
the DrivenByMoss OSC address space (already installed-and-configured
infrastructure, no custom code) fronted by a small ergonomic CLI, `bw`,
built in its own repository once ratified; this repo incubates the design.

The Grid is controlled *through the surface a patch exports* — its
remote-control pages, note input, and modulators — with DSP topology changed
by preset swap; the boundary and its consequences are the design's ground
truth (see the knowledge docs below).

## Design records

- [Architecture and build order](/projects/bitwig-shell-control/architecture-and-build-order.md)
  — the plan: transport choice (OSC over the WebSocket bridge), the `bw`
  command surface, the Grid remote-control convention, phased build order
  from a zero-code smoke test to a named-parameter mapping layer.
- [Agentic DAW fit — Bitwig vs. Ableton Live](/projects/bitwig-shell-control/daw-agentic-fit-bitwig-vs-ableton.md)
  — the comparison behind this project's scope: Bitwig for performing what
  exists (this system), Ableton + Max for Live as the deeper substrate if an
  agent is to *construct* sound design — a sibling project if wanted.

## Knowledge filed (the split rule)

Findings true beyond this system live in the taxonomy:

- [Bitwig's programmatic control surfaces](/knowledge/media-production/daw-control/bitwig/bitwig-control-surfaces.md)
  — the four control planes and the realtime character of each
- [DrivenByMoss OSC](/knowledge/media-production/daw-control/bitwig/drivenbymoss-osc.md)
  — the address space and feedback channel the system rides
- [The Grid's programmability boundary](/knowledge/media-production/daw-control/bitwig/the-grid-programmability-boundary.md)
  — parameter-addressable, not patch-addressable
- [Realtime OSC from the shell](/knowledge/media-production/daw-control/osc-from-the-shell.md)
  — the command-line OSC vocabulary the phase-0 recipe uses

## Relation to code-driven AV production

[Code-driven AV production](/projects/code-driven-av-production.md) renders
declared time *without* a DAW in the path (SuperCollider NRT, sample-exact);
this project performs on a DAW *live* (control-rate, human-in-the-loop). Same
operator practice, two tenses: compose offline there, perform and sound-design
here. A Grid patch tuned over OSC can later be rendered or resampled into that
pipeline's material.

## Status and open ends

- **Incubating.** Research and design are filed; none of it has run against a
  live Bitwig yet — the phase-0 smoke test in the plan is the operator's
  ten-minute validation on their own machine, and its outcome gates the CLI
  build.
- **Next decision.** Ratify the plan's recommendation (Elixir escript over
  the DrivenByMoss OSC plane) or redirect; committing spawns the external
  `bw` repository and, if queued, a delivery matter per build phase.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:e36f3a">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-14-bitwig-shell-control-incubation-and-agentic-daw-fit (2026-08-14)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:e36f3a`]**

could you introduce some sort of shell based realtime control of the grid and dsp and/or other features in bitwig?

---

**[`em:e36f3a`]**

Bitwig appears nowhere in the bundle yet — this is a fresh subject, and "the Grid" here means Bitwig's modular environment, distinct from the existing project's *declared timing grid*. The existing `code-driven-av-production` project deliberately keeps the DAW out of the render path, so realtime DAW control is a new sibling project. Let me check the house style for project docs and knowledge references.

---

**[`em:e36f3a`]**  (co-feeds: `em:892df3`)

**The short version:** yes, and the fastest form of it needs no new code. A free, actively maintained Bitwig extension (DrivenByMoss, 26.6.3 as of 2026-07-26) turns a running Bitwig into a network endpoint that plain shell commands can drive *and observe* — transport, tempo, mixer, any parameter a device or Grid patch exposes, clip/scene launching, even playing notes into a Grid synth. The one hard boundary the research found: nothing external can rewire a Grid patch's module graph. Realtime control means *performing* a patch through the remote-control slots it exports and swapping presets to change DSP topology — so patches get authored once in the GUI with their remote controls treated as a public interface. I filed the research into the brain, opened a project around it, and wrote the build plan for `bw`, a small Elixir CLI that makes the raw control surface ergonomic. Nothing here has touched a live Bitwig — none runs in this container — so the plan's phase 0 is a ten-minute smoke test on your machine.
