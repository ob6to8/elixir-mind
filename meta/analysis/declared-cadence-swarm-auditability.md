---
type: analysis
title: "Declared cadence for agent swarms: transplanting gen~'s time model to BEAM orchestration audit"
description: "Develops the strongest cross-domain transplant from the media-production investigation: reconstructing swarm behavior from logs is the measured-timeline pattern (onset detection), while giving orchestration a declared cadence makes audit arithmetic — yielding a small vocabulary of timing-derived auditability parameters (cadence conformance, swing vs. jitter, dropped slots, phase drift, burst factor), a musical-texture-to-topology mapping, and a sonification channel that makes swarm pathology audible; bounded to the orchestrator layer, and hypothesis-status until the named spike runs."
provenance: "Claude Code session, 2026-07-28 — gen~ time model from the Wakefield course-notes capture (em:98a026); distributed-systems anchors (logical clocks, rounds/synchronizers) and the auditory-monitoring tradition are training knowledge, marked in place; no swarm timeline has yet been rendered or measured"
tags: [meta, analysis, beam, agents, swarm, orchestration, auditability, timing, sonification, gen, media-production]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T22:05:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "operator asked for a breakout of the BEAM/swarm/gen~ synergy, presented in plainspeak alongside the technical level"
  from: [/meta/threads/2026-07-28-code-driven-av-production-and-declared-cadence.md]
---

# Declared cadence for agent swarms

## In plain terms

A music box and a jazz band keep time differently. The music box *declares*
its timing — pins on a cylinder, turned at a set speed — so checking whether
it played correctly is trivial: compare pins to sounds. A jazz band's timing
exists only in the performance; to check what happened you must record it and
reconstruct — who came in late, who rushed — by careful listening after the
fact.

Systems of cooperating AI agents are, today, jazz bands. Each agent works at
its own pace, messages fly asynchronously, and when something goes wrong the
only recourse is reading timestamped logs and reconstructing the interleaving
— slow, error-prone, after-the-fact listening. This session's music work
demonstrated the other way round on actual music: *declare* the beat grid
first, render everything from it, and verification collapses into comparing
numbers against the declaration.

The proposal here is to run agent orchestration like the music box where an
orchestrator already owns the pacing: declare the rhythm the swarm is supposed
to keep — rounds, check-ins, barriers — and then audit becomes subtraction:
how far off its declared slot did each event land? Deviations acquire musical
names with diagnostic content: consistent lateness is *swing* (a systematic
load pattern), random scatter is *jitter* (contention), a missing check-in is
a *dropped beat*, a burst of restarts is a *ratchet*, two loops slowly
sliding against each other is *phasing* (a livelock signature). And because
the music pipeline renders timelines to audio with sample accuracy, a swarm's
performed timeline can be *played*: the same ear that instantly hears a
drummer's flam — at timing scales plots don't show — becomes a monitoring
instrument for machine behavior. All of this is proposal, not practice: the
last section names the small experiment that would test it.

## The technical account

**Question.** gen~ organizes time by refusing discrete events: declare a
continuous phase, derive all events from it by arithmetic
("No messages means no [trigger] etc.; use 0/1 signals" —
[Wakefield course-notes capture](/knowledge/media-production/audio-synthesis/wakefield-gen-course-notes.md);
concept: [ramps as time](/knowledge/media-production/sequencing/ramps-as-time.md)).
The BEAM is the opposite pole: asynchronous message passing, per-process
scheduling, no shared clock. Does the declaration move transplant — and what
would "mapping timing to agentic auditability parameters" concretely produce?

**Thesis.** The transplant is real but scoped: it applies where an
orchestrator owns pacing (workflow spines, cron/Routines, supervision
heartbeats, eval harnesses), and there it converts audit from reconstruction
to arithmetic and yields a compact parameter vocabulary. It does not apply to
emergent dynamics nobody paces. Everything below is design reasoning grounded
in the music-side measurements; the swarm side is unmeasured until the spike
runs.

### The duality, and the transplant

Auditing a swarm from logs is the **measured-timeline** pattern the
[declared-grid analysis](/projects/code-driven-av-production/declared-grid-av-production.md)
identifies in video editing: onset-detecting a rendered artifact to recover,
with error, structure that was never written down. Log-reconstruction of an
interleaving is onset detection over events. The transplant is the same
inversion the AV pipeline made: **declare the cadence, render execution
against it, and let deviation be the measurement.** Distributed systems
already hold the adjacent ideas (training knowledge, unchecked): logical
clocks order events post hoc, and round-based synchrony gives algorithms a
declared step structure. The gen~ move sharpens both into an audit
instrument: the cadence is *prescriptive*, owned by the orchestrator, so
deviation from it is well-defined per event — no global physical clock
required, only the orchestrator's own phase.

### The parameter vocabulary

Each musical deviation category is a computable audit parameter, and the
music/orchestration pairing is diagnostic, not decorative — the musical term
names the *shape* of the deviation, which is what distinguishes causes:

| Texture / deviation | Orchestration analogue | Audit parameter | Diagnostic content |
|---|---|---|---|
| downbeat / barrier | `parallel()` join; round close | all-voices-resolved check; straggler lag | which voice drags, and by how much |
| counterpoint | free-running `pipeline()` stages | per-stage tempo stability | stages are *supposed* to be independent — correlation is coupling |
| ostinato | cron Routine, heartbeat | period jitter | scheduler health |
| swing | systematic slot offset | mean signed deviation | *structured* lateness = load pattern, distinct from noise |
| jitter | random slot scatter | deviation variance | contention, GC, scheduling pressure |
| dropped beat | missed heartbeat / silent agent | dropped-slot rate | stuck or dead process |
| ratchet burst | restart storm, retry loop | intra-slot event burst factor | supervision pathology |
| phasing | two loops, incommensurate periods | relative phase drift | livelock / beating signature |
| rubato | adaptive pacing (self-scheduled wakeups) | declared tempo warp vs. residual | separates *intended* slowdown from drift |

Swing versus jitter is the pair that shows why the vocabulary earns its keep:
both are "events landing off-slot", but mean-offset and variance have
different causes and different fixes, and the musical terms carry exactly that
distinction.

Two further imports from the music side. The **alignment move** — the
predecessor pipeline located a 21 s stem inside a 4-minute render by sliding
correlation of loudness shapes — is trace alignment: sliding a performed event
log along the declared score localizes *where* a run diverged, turning "this
run was weird" into a timestamped region. And the **error-budget discipline**
(each subsystem has one default that silently costs milliseconds; rank them,
fix the ones above the tolerance threshold) applies to a swarm's timing stack
verbatim.

### The sonification channel

Once a swarm's events sit against a declared cadence, rendering them is the
project's verified
[NRT path](/knowledge/media-production/audio-synthesis/supercollider-nrt-rendering.md):
map event classes to timbres, place them at their performed times over a
click at the declared cadence, render deterministically. The payoff is the
perceptual-gate finding from the
[synergies survey](/meta/analysis/media-production-domain-synergies.md): the
blockSize measurement showed 1.3 ms — invisible in any plausible plot — is
audible as flam. A restart storm renders as a ratchet, a stuck agent as a
dropped beat, livelock as phasing that never resolves. Auditory monitoring of
machine systems has precedent (training knowledge, unchecked: the
auditory-display literature and the older operations tradition of hearing
machine-room state), but the declared cadence is what makes it *rigorous*
here — the listener hears deviation from a beat, the most sensitive timing
judgment humans make, rather than free-form event noise.

On the BEAM specifically (training knowledge, unchecked): `:telemetry`
instrumentation is pervasive in Elixir systems, and OSC over UDP is simple
enough to emit dependency-free — so a live scsynth channel or a post-hoc NRT
render are both small integrations, complementing (never replacing) the
existing observability the runtime already provides.

### Where it binds in this bundle

The [swarm-eval substrate analysis](/meta/analysis/inkling-beam-swarm-eval-substrate.md)
and its [harness plan](/meta/plans/inkling-beam-swarm-eval-harness.md) already
commit to an OTP harness with full-trace capture for agent-swarm failure
modes. Declared cadence slots in as *instrumentation design* for that
harness: if the harness's campaign loop declares its rounds explicitly, every
parameter in the table above is computable from the trace it already
captures, and the sonification channel is a rendering of that same trace.
The transplant costs the harness nothing it wasn't building and adds an
analysis dimension — timing pathology — orthogonal to the correctness
oracles it plans.

### Limits

- **Scope: orchestrator-paced systems.** Declaring cadence is a design choice
  available to whoever owns pacing. Arbitrary emergent swarm dynamics have no
  owner to declare against; there the measured-timeline pattern (log
  reconstruction) remains the only option, and this analysis claims nothing
  about it.
- **Cadence is not free.** Forcing round structure onto genuinely
  latency-diverse work trades throughput for auditability (a barrier waits
  for stragglers). The music-side answer — rubato: declare the warp — softens
  but does not eliminate this.
- **Hypothesis status.** The music-side halves are measured (sample-exact NRT
  rendering; onset arithmetic); the swarm-side halves are design reasoning.
  Nothing here has rendered a real workflow journal yet.

**Judgment.** The transplant holds at the orchestrator layer and its test is
cheap: **the spike is to take one real workflow journal (or this session's own
event timeline), declare the cadence it nominally ran at, compute the
parameter table, and render the sonification with the verified NRT path** —
one artifact proving the audit arithmetic and the perceptual channel at once.
If the spike shows signal, the instrumentation design graduates into the
swarm-eval harness plan per
[plan-vs-capture](/meta/policy/plan-vs-capture.md); if it shows noise, this
analysis records why the idea seemed strong and where it broke.
