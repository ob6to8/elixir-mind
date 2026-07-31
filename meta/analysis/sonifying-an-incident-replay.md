---
type: analysis
title: "Sonifying an incident replay: what the ear buys when a visual encoding spends both spatial axes on topology"
description: "Designs a six-layer sonification of the Hugging Face frontier-lab agent-intrusion replay and audits what audio buys over its visual encoding; finds the page's two weakest encodings are structural rather than incidental (nine phase bars self-normalized to their own totals carry only elapsed time, so a 1,161x magnitude difference is invisible; calendar-day bins make two 1,130-action days look identical at 47 vs 79 actions/hour), locates the general cause in a display that needs both spatial axes for network topology while also encoding a five-day time series, and recommends audio as the relief channel for rate, concurrency, and irreversible state while the screen keeps absolute values and random access."
provenance: "Claude Code session, 2026-07-30 — design derived from the page's own inline data model (NODES/PHASES/DAYS/EVENTS) read from source, not from the rendered view; psychoacoustic thresholds are training knowledge, marked in place"
tags: [meta, analysis, sonification, data-visualization, multimodal-interfaces, security, incident-response, accessibility, media-production]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "operator asked what sonifying the frontier-lab intrusion replay would look like and what advantages it would carry over the strictly visual presentation"
  from: [/meta/threads/2026-07-30-sonifying-an-incident-replay.md]
---

# Sonifying an incident replay

## In plain terms

The subject is a web page that replays a five-day computer break-in as a
46-second animation: a network diagram whose boxes light up as the attacker
reaches them, nine counters ticking upward, a scrolling list of the commands
that were run, and a bar chart of how busy each day was. Everything moves at
once, and a reader has one pair of eyes that can only look at one panel at a
time.

Sonifying it means giving the ear the parts of the story that are really about
*time* — how fast the attacker is working, which kinds of activity are running
at the same moment, how far into the organization the compromise has spread —
while leaving the eye the parts that are about *space and words*: the diagram,
the command text, the exact numbers. Hearing is good at exactly what looking is
bad at here. It runs in parallel without being aimed anywhere, it judges speed
and rhythm precisely, and a rare odd sound in a busy texture is *more* noticeable
the rarer it is — whereas a rare event in a bar chart is a bar too short to see.

Reading the page's own code turned up two places where its visuals lose
information that sound would keep for free. Its nine progress bars are each
scaled to their own total, so a phase with 6 actions and a phase with 6,972 draw
the identical bar — all the magnitude survives only as small print. And its day
chart bins by calendar date while the recorded window starts mid-morning and ends
mid-afternoon, so the second and last days look the same height (1,135 and 1,130
actions) despite one running at roughly 47 actions per hour and the other at 79.
A sound layer driven by rate has no bins to get wrong, because density in time is
what sound already is.

The recommendation is not audio instead of the picture. It is audio *relieving*
the picture of the job it is worst at, so that neither channel is carrying two
jobs at once.

## The technical account

**Subject.** `https://huggingface-anatomy-of-frontier-lab-model-intrusion.static.hf.space/index.html`
— an interactive incident replay, kicker "Incident replay · IR-2026-07 ·
reconstructed from ~17,600 logged actions", lede "Thousands of small decisions at
machine speed. Press play to watch it unfold." The window runs 2026-07-09 02:28
→ 2026-07-13 14:14 UTC (`SPAN = 6466` minutes) and plays in `DUR_1X = 46`
seconds, with 0.5×–4× speed controls and a `#<frac>` deep-link that freezes an
instant.

**Question.** What would a sonification of this presentation look like
concretely, and what does the auditory channel buy over the visual encoding
alone?

**Thesis.** The page is a single display asked to carry two incompatible jobs:
network topology, which needs both spatial axes, and a five-day time series,
which needs a temporal axis it does not have. Every weak encoding on the page
traces back to that collision — time gets borrowed back from the channels that
were already spent (bar length, color, glow), and the borrowing costs magnitude
and rate. Sound is natively temporal and natively parallel, so it is the right
channel to hand the time series to; the screen keeps absolute values and random
access, which sound is bad at. The division is *relief*, not replacement.

### Finding 1 — the state vector, and two structural encoding losses

Nine live channels update simultaneously through the run: the agent packet's
position at the frontier node, eight edges drawing on, five trust zones glowing,
nine phase rows, a five-rung blast-radius readout, a five-bar day histogram, a
21-line command log, four transient flare toasts, and the clock/counter pair.
Two of these lose information as a consequence of their encoding rather than by
oversight.

**The nine phase bars carry only elapsed time.** Each fill is computed as
`el.fill.style.width=(count/p.total*100)+'%'` — normalized against *its own*
total, over a `count` that is itself a linear interpolation between the phase's
`first` and `last` fractions. So every bar is a ramp from its own start to its
own end, and all nine are redundant clocks. `evasion` (6 actions) and `dropper`
(6,972) render the identical bar: a 1,161× magnitude difference expressed
nowhere but a small numeral. The bar-length channel was already spent on
progress, because progress is where the borrowed time axis went.

**Calendar-day bins hide a 1.7× rate difference.** Day 2 logged 1,135 actions
and Day 5 logged 1,130 — within 0.5%, so the two bars read as equal. But the
window opens at 02:28 and closes at 14:14, making Day 2 a full 24 hours and Day 5
only 14.2. As rates that is ~47 versus ~79 actions per hour. The chart cannot
show it, because rate is per unit time and the chart bins by date.

A third property is a data limitation rather than an encoding one, and any
sonification inherits it: the model knows each phase's total plus its first and
last timestamps, and interpolates linearly between them. Real per-phase temporal
shape is unavailable. The daily counts are the only genuine intensity profile in
the data, which makes them load-bearing for the design below. The nine phase
totals also sum to 16,521 of 17,613 actions, leaving 1,092 (6.2%) outside every
phase — volume the phase panel cannot represent at all.

### Finding 2 — the mapping: six layers over one deterministic model

Every layer is driven from the existing `render(t)`; nothing needs data the page
does not already carry.

1. **Clock bed.** One soft tick per simulated hour, accented at midnight. At 1×
   the ratio is 6,466 minutes over 46 seconds = ~141 simulated minutes per real
   second, so an hour is 0.427 s (~140 bpm) and day boundaries fall 10.2 s
   apart. A metric grid, so every other sound is dated by ear without reading
   the clock.
2. **Action rate as [granular](/beliefs/glossary/granular-synthesis.md) density.**
   One grain per action-cluster, rate proportional to d(count)/dt. Below roughly 20 events/s the grains are
   discrete clicks; above it they fuse and rate reads as roughness and
   brightness instead. That crossover is the design's centerpiece rather than an
   artifact of it: it is precisely where "thousands of small decisions" becomes
   "machine speed", which is the presentation's own thesis. Day 3 peaks near 750
   actions/s at 1×. The 1,092 unphased actions get untimbred grains so
   unclassified volume stays audible.
3. **Phases as concurrent streams, split by rate.** Nine will not
   [segregate](/beliefs/glossary/auditory-stream-segregation.md) — the reliable
   ceiling for tracked concurrent auditory streams is around three or four (training knowledge, unchecked; the auditory-scene-analysis
   literature is where this would be grounded). So: the three engine phases
   (`recon` 6,191 · `rce` 2,911 · `dropper` 6,972 — 91% of classified actions)
   become three sustained pitched voices in separate registers, amplitude
   proportional to instantaneous rate, forming the bed. The six escalation
   phases (`exfil` 56 · `c2` 114 · `evasion` 6 · `k8s` 87 · `supply-chain` 69 ·
   `tailscale` 115 — 447 actions total) are far too rare for drones and take one
   distinct [earcon](/beliefs/glossary/earcon.md) each: exfil as a downward glissando panned outward into wet
   reverb (leaving); c2 as a two-note call-and-response; k8s as a metallic
   cluster; supply-chain as a lock-click; tailscale as a rising interval that
   resolves, after which a mesh drone joins the bed permanently; evasion as a
   bandpass sweep that briefly muffles the whole mix (packing).
   **Cross-modulate the drone amplitudes with the daily volume profile** rather
   than driving them from the linear interpolation directly — otherwise they
   reproduce the phase bars' defect as nine smooth ramps and Day 3's spike
   averages away.
4. **Blast radius as harmonic and spatial state.** The five rungs (sandbox →
   HF pod at 0.498 → HF cluster at 0.5169 → internal net at 0.6209 → source
   control at 0.8599) each add a lower octave to the drone and widen the reverb:
   mono and dry inside the sandbox, wide and roomy once the mesh is joined. The
   room grows as containment fails, and nothing is ever removed. A bass octave
   that persists for the remaining 40 seconds *is* irreversibility in a way a
   label changing from orange to red is not.
5. **Topology as azimuth and depth.** Node `x` maps to pan, so Stage 1
   (`n1`→`n2`→`n3`→`n4`, all at y=88) becomes a literal left-to-right sweep
   matching the map's own horizontal layout. Node `y` (88 → 470, perimeter to
   deep interior) maps to lowpass cutoff and reverb send, so further in sounds
   further away. Each ignition leaves a sustained presence tone, so nine
   footholds accrete into a nine-note chord and "how bad is it now" is a single
   gestalt at any instant. The dashed read-back edge (`n5`→`n4`, active from
   0.498 to the end) becomes a continuous whisper between two spatial positions
   — an audible leak running under everything else.
6. **Narrated events and flares.** Each of the 21 log events fires its phase
   gesture, boosted, plus a short keystroke burst. Each of the four flares ducks
   the mix, fires a stinger, and returns — with *speech* for the flare text,
   because non-speech audio is bad at propositions and "One 200. Blast radius:
   one sandbox → the internal network." wants a voice. Containment at t=1 hard-
   gates every layer and leaves only the enlarged reverb tail decaying: cut off,
   not petered out.

### Finding 3 — the tempo constraint, and why it argues for slower speeds

46 seconds is too fast for auditory detail. Rhythm perception fuses somewhere
around 8–10 events/s (training knowledge, unchecked), and Day 3 runs at ~750. So
1× survives only as a texture pass — the arc, not the events. A sonified default
wants roughly 3–4 minutes: at 240 s the ratio falls to 27 simulated minutes per
real second, putting the 447 escalation actions near 1.9/s and making them
individually legible. The change is to extend the existing speed control
*downward* (add 0.25× and 0.1× beside the current 0.5×) rather than to replace
it — the two ends then correspond to two genuinely different readings, overview
gestalt and event-level replay.

### Finding 4 — what the ear buys, ranked

1. **Parallelism without foveation.** Vision is serial and
   [foveal](/beliefs/glossary/foveal-vision.md); nine panels
   update simultaneously for 46 seconds and a reader can fixate one. The page is
   already fighting this — pulses, glows, autoscroll, and 3.8-second toasts all
   exist to grab a gaze that can only be in one place. Audition delivers three
   or four streams at once with nothing to aim.
2. **Rarity inverts salience.** Because the bars discard magnitude (Finding 1),
   `evasion: 6` and `dropper: 6972` look identical. In a dense texture a rare
   unusual timbre is *more* salient the rarer it is. The six actions a responder
   most wants to notice go from invisible to unmissable on unchanged data — the
   auditory system is a novelty detector, and the encoding that buries rare
   events is exactly the one it inverts.
3. **Rate is ear-native.** Judging acceleration from an incrementing counter is
   guesswork; judging it from a click train is immediate, and humans resolve
   temporal intervals far more finely than they compare lengths (training
   knowledge, unchecked). The presentation's thesis is a claim about *speed*,
   currently rendered as a number going up and five static bars.
4. **Time stops competing for space.** This is the general case of which
   Finding 1 is the instance: handing the time series to the ear lets the bar
   channel encode relative volume instead of re-encoding elapsed time nine
   times.
5. **Irreversible state feels irreversible.** Accumulation is cheap in audio and
   expensive on screen — nine simultaneously lit, still-legible boxes is roughly
   the map's ceiling, which is why it dims and glows rather than layering.
6. **Eyes-free and non-visual access.** The whole argument currently lives in
   animated SVG state with no textual equivalent, so it is largely unavailable
   to a blind reader, and it cannot be monitored while doing something else —
   which is what an operations context actually wants.
7. **Memorability.** "Quiet day, then the Day 3 roar, then the floor drops and
   the room opens up" is a figure people retell. Charts are not.

### Finding 5 — where the screen keeps winning, and the disciplines that follow

Audio has poor absolute precision: nobody reads "6,972" off a drone, so the
numerals stay. And it has no random access — the `#<frac>` deep-link freezes a
readable instant, whereas a frozen instant of audio is a static chord. The
mitigation is a ~600 ms state arpeggio on scrub, sweeping the accumulated node
chord plus the current blast-radius bass, so a frozen moment still has a
signature.

Two disciplines follow, and both are load-bearing. **Publish an audio legend** —
hover-to-hear on each existing phase row, plus a short cast-of-sounds preamble —
because an undocumented mapping is undecodable, while the visual already labels
itself. And **bind every audible parameter to a variable**: an unbound tension
pad turns an incident report into a thriller trailer and spends the credibility
the piece exists to earn. A stinger on a flare is legitimate because it marks a
real datum; atmosphere added for effect is not.

### Feasibility

The Space is static and client-side, the substrate is the
[Web Audio API](/beliefs/glossary/web-audio-api.md), and the timeline model is
fully deterministic and closed-form, so the whole piece can be pre-scheduled on the
audio clock at `play()`. The clean version inverts the master clock: `loop(ts)`
currently integrates `performance.now()` deltas and would instead read
`t = (ctx.currentTime - t0) / DUR * speed`, making audio the timebase and
eliminating drift. Drones are three oscillators with `setValueCurveAtTime` gain
envelopes; grains are buffer sources up to the fusion threshold and a filtered
noise source above it (the crossover is perceptually invisible, which is what
makes the switch safe); earcons are six short prerendered buffers panned by node
`x`; blast radius is a per-rung bass oscillator plus a convolver whose wet send
steps up; flares are a scheduled dip on the master gain. One conflict: the page
auto-starts playback 900 ms after load, and Web Audio requires a user gesture —
so the play button becomes the audio unlock, or the auto-start becomes a single
"play with sound" affordance.

### Relation to the bundle's standing sonification work

[Media-production synergies](/meta/analysis/media-production-domain-synergies.md)
frames [sonification](/beliefs/glossary/sonification.md) as "a **perceptual gate for temporal data**: mechanical to
produce, human to consume, sensitive precisely where visual inspection is weak",
and names "anything in the bundle with a timeline" as the candidate subject
class. This page is that subject class arriving from outside the bundle, and it
supplies something the internal candidates do not: an encoding whose weaknesses
are measurable against its own source, so the "weak precisely where vision is
weak" claim gets a worked instance instead of an assertion.

[Declared cadence for agent swarms](/meta/analysis/declared-cadence-swarm-auditability.md)
develops the musical-texture-to-topology mapping for orchestration audit; the
phase-stream and density layers here are that vocabulary pointed at an
adversarial timeline rather than a cooperative one, which suggests the mapping
generalizes across the two by *rate structure* rather than by domain. Both would
render through the deterministic
[NRT path](/knowledge/media-production/audio-synthesis/supercollider-nrt-rendering.md)
if built as artifacts rather than as live Web Audio — the live case trades
reproducibility for interactivity, and an incident replay wants both, which is
an unresolved tension rather than a settled choice.

The survey tier already holds the closest external prior art:
[SoNSTAR](/survey/bookmarks.md) (PLOS One), which "uses audio representations of
TCP/IP traffic to help network administrators detect anomalies with reduced
cognitive load" — network-intrusion sonification with a published evaluation,
surveyed but not yet ingested. The perceptual thresholds this analysis leans on
(stream-count ceiling, fusion threshold, interval discrimination) are marked
unchecked throughout and are what a promotion pass would ground.

**The layer split is the same one the brain already runs.**
[Fit each layer to its purpose](/meta/doctrine/fit-each-layer-to-its-purpose.md)
applies channel-wise here: sound takes relations and change, screen takes values
and random access, and the failure mode in both cases is one layer being asked
to do the other's job.

## Recommendation

Treat the finding as two separable deliverables. The **critique** stands on its
own and needs no audio: the self-normalized phase bars and the partial-day bins
are defects derivable from the page's data, and the general lesson — a display
that spends both spatial axes on topology will borrow its time axis back from
whatever channel is left, at the cost of magnitude and rate — transfers to any
timeline-over-topology visualization, including ones this bundle might build.
The **sonification** is a prototype-shaped proposition: implementable in a
single self-contained file against the model above, with the audio-as-master-
clock inversion as its one structural change.

Open questions for ratification:

1. **Live or rendered?** Web Audio buys interactivity (scrub, speed, deep-link)
   and loses the reproducible-artifact property the NRT path exists to
   guarantee. An incident replay arguably wants a rendered canonical track *and*
   a live mode, which is two implementations rather than one.
2. **Does the legend requirement sink the accessibility argument?** A mapping
   that needs a training preamble is worse for a first-time reader than a
   labeled chart, and better for a repeat one. Whether the crossover lands
   before or after a single visit is an empirical question this analysis does not
   answer.
3. **Should the tempo default change?** Making the sonified pass 3–4 minutes
   makes the events legible and makes the piece four to five times longer than
   the visual it accompanies, which is a different artifact with a different
   audience.
