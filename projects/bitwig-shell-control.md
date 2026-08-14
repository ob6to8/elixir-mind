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
