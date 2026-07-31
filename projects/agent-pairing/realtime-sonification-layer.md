---
id: em:857398
type: analysis
title: "A real-time sonification layer — supervision below the visual attention floor"
description: Designs an auditory client for the broker's event stream — ambient texture for agent activity, earcons for decision points, per-agent voices for fleet listening — finding it fills the supervision tier visual rendering cannot reach (eyes on your own work, ears on the herd) and that the operator's SuperCollider competence makes it unusually cheap to prototype.
tags: [projects, agent-pairing, analysis, sonification, supervision, audio, ux]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T06:44:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed design session on agent-driven editor workflows"
  why: "operator asked what a real-time sonification layer over the pairing system would look like"
---

# A real-time sonification layer

**Question.** The broker renders the agent's event stream visually — follow
windows, marks, quickfix. What would it look like to render it as sound, in
real time, and is that a gimmick or a tier?

**Thesis.** It is a tier — the one below tier 1. Every visual rendering costs
foveal attention: to see the follow window you must look at it, which is why
attended supervision competes with the operator's own work. Audition is the
peripheral channel — always on, spatially unbound, monitored without being
attended — and operators have always used it (machinery monitored by ear, the
mainframe-era radio on the CPU cabinet, network operators running
Peep-style ambient soundscapes). [Sonification](/beliefs/glossary/sonification.md)
of the broker stream gives the operator *ears on the herd while their eyes stay
on their own buffer*, which no visual tier can offer. The design problem is not
mapping events to sounds — that part is easy — but staying on the right side of
the line between ambient texture and alarm fatigue.

## Why sound fits this stream

Three properties of the broker's event stream match auditory display
specifically:

- **It is temporal.** Sonification's home ground is quantities that vary over
  time; the edit stream *is* a time series (rate, burstiness, pauses), and
  rhythm is heard far more precisely than it is read off a scrolling display.
- **Deviation matters more than value.** The supervising ear does not need to
  know what the agent did — it needs to notice when the *texture* changes: the
  steady edit patter stopping (blocked), accelerating (runaway loop), the
  error-tone entering (diagnostics accumulating). Habituation, the enemy of
  visual dashboards, is the mechanism here: a constant is tuned out for free
  and its change is startling.
- **Concurrency is native.** [Auditory stream segregation](/beliefs/glossary/auditory-stream-segregation.md)
  lets a listener track several simultaneous sources by timbre, register, and
  position — which is precisely the fleet problem. Give each agent a voice
  (timbre + stereo position) and the herd becomes a polyphonic texture: any
  operator who can hear that the bass dropped out of a mix can hear that agent
  3 went idle.

## The mapping

Two sound classes, matching the stream's two kinds of content:

**Continuous texture — activity, never attended.** The `PostToolUse` /
`FileChanged` stream drives an ambient bed: event density → pulse density;
tool class → timbral family (reads as soft/granular, edits as pitched and
percussive); LSP diagnostics delta → consonance (errors accumulating detune
the texture, errors clearing resolve it); working-tree distance from the
operator's own buffer → stereo width. The bed is *designed to be tuned out* —
its information is carried by change.

**Discrete [earcons](/beliefs/glossary/earcon.md) — decisions, always
attended.** The small set of events that require the operator: pending
acknowledgement (tier 3), agent blocked, deny returned, test run resolved
(pass/fail as motif inversion — an [auditory icon](/beliefs/glossary/auditory-icon.md)
where resemblance works, an earcon where it doesn't). These sit above the bed
in register and loudness, keyed to the per-agent voice, so *which* agent needs
attention arrives in the same instant as *that* one does — the
[figure-ground inversion](/beliefs/glossary/figure-ground-inversion.md) is the
design: texture is ground, earcon is figure, and an event class is assigned to
exactly one side.

The posture mapping completes the
[supervision spectrum](/knowledge/SWE/agentic/supervision/agent-as-driver-pairing-inversion.md):
attended pairing (eyes + ears), follow mode (glances + ears), **ambient mode
(ears only)** — the new tier — then notification-only. Sonification is also the
natural *replay* channel: tier 2's paced playback with the audio bed restored
plays like a tape, and scrubbing by ear ("find where the texture went wrong")
is a real navigation primitive.

## Architecture

Nothing changes in the broker; this is the thin-client thesis paying out. The
audio client subscribes to the same typed stream the editor client does and
owns only the mapping and synthesis. Latency budget is generous by musical
standards (tens of milliseconds is inaudible for monitoring), so transport is
not a constraint.

Synthesis: a small real-time SuperCollider server (`scsynth`) driven by OSC
from the client is the obvious engine — the operator already runs
SuperCollider in the
[code-driven-av-production](/projects/code-driven-av-production.md) project,
in non-realtime mode there; this reuses the instrument competence with the
server in its ordinary real-time role. The mapping layer is data (event class →
synth + params), so voices and moods are configuration, not code.

Two disciplines carry over from the visual side. The audio rendering is a
[derived view](/beliefs/glossary/derived-view.md) of the stream and must hold
no state of its own. And **silence is a claim**: a dead audio client sounds
identical to a quiet herd, which is the trusted-rendering failure in its purest
form — the bed therefore carries a barely-audible heartbeat whose *absence*
means the rendering, not the agents, has stopped.

## The failure modes

- **Annoyance is the adoption killer.** Every failed ambient-audio system
  failed here. Mitigations are known: information lives in texture *change*
  rather than absolute loudness; earcons are rationed to genuinely blocking
  events (the same budget discipline as the ack protocol — over-alerting is
  rubber-stamping for the ears); everything is mutable per-class; and the bed
  must pass the "can you leave it on for four hours" test before any feature
  is added to it.
- **Shared spaces.** Headphones or nothing; a sonified herd is an office
  hazard. Bone-conduction and spatial-audio setups are the deluxe path, not a
  requirement.
- **Learned vocabulary.** Earcons must be taught and retained; the vocabulary
  therefore stays small (≤ 6 discrete signals) and stable, with per-agent
  identity carried by voice rather than by distinct motifs per event type.

**Recommendation.** Build it as the third client, after tier 1 proves the
premise and the typed stream exists — it is a weekend of mapping code on top of
the broker plus existing SuperCollider competence, and it is the only tier that
adds supervision capacity *without* spending visual attention. Prototype with
the continuous bed plus two earcons (blocked, pending-ack) and live with it
before growing the vocabulary. If the ambient tier proves out, it also becomes
the strongest demo the project has: nobody has heard a herd before.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:857398">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-30-neovim-adoption-and-the-agent-pairing-project (2026-07-30)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:857398`]**

**Sonification.** A genuine tier, not a gimmick — the one *below* tier 1, the only rendering that adds supervision capacity without spending visual attention: eyes on your own buffer, ears on the herd. A continuous ambient bed carrying information in *change*, plus a rationed vocabulary of ≤6 earcons. Thin-client architecture, synthesis via a real-time `scsynth` over OSC, reusing your SuperCollider competence from the AV project. One detail I'd defend hardest: silence is a claim, so the bed carries a heartbeat whose absence means the rendering died, not the herd went quiet.
