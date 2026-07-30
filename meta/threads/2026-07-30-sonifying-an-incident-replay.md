---
type: reference
title: 2026-07-30-sonifying-an-incident-replay
description: "Designed a six-layer sonification of the Hugging Face frontier-lab agent-intrusion replay and audited what audio buys over its visual encoding; reading the page's own inline data model surfaced two structural encoding losses (self-normalized phase bars carrying only elapsed time; calendar-day bins hiding a 1.7x rate difference), and the operator chose to file the result as an analysis."
provenance: "Claude Code session (Opus 5), 2026-07-30; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, sonification, data-visualization, multimodal-interfaces, security, accessibility]
timestamp: 2026-07-30
session: https://claude.ai/code/session_01MDrq5iTcxA7sFjtauriwqH
---

# 2026-07-30-sonifying-an-incident-replay

## Where this landed

A single-question session. The operator pointed at a Hugging Face Space that
replays a five-day frontier-lab agent intrusion as a 46-second animation and
asked what sonifying it would look like, and what the ear would buy over the
strictly visual presentation.

The design work was done against the page's **own inline data model** — `NODES`,
`ZONES`, `EDGES`, `PHASES`, `DAYS`, `EVENTS` read out of the source rather than
inferred from the rendered view — which is what turned a mapping exercise into a
critique with checkable numbers. Two of the page's encodings lose information
structurally: its nine phase bars are each normalized to their own total
(`el.fill.style.width=(count/p.total*100)+'%'`), so all nine are redundant clocks
and a 1,161x magnitude difference between `evasion` (6 actions) and `dropper`
(6,972) survives only as small print; and its day histogram bins by calendar date
while the window opens 02:28 and closes 14:14, so two ~1,130-action days read as
equal bars at roughly 47 versus 79 actions per hour. The general cause named: a
display that needs both spatial axes for network topology borrows its time axis
back from whatever channel is left, and the borrowing costs magnitude and rate.

The delivered answer carried a six-layer mapping (clock bed, granular action-rate
density, three engine drones plus six escalation earcons, blast radius as an
accreting bass octave and widening reverb, topology as azimuth-and-depth, speech
for the four flares), the tempo constraint that argues for extending the speed
control *downward* to 0.1x, seven ranked advantages with rarity-inverts-salience
as the strongest, the limits that keep absolute values and random access on
screen, and a Web Audio feasibility sketch whose one structural change is making
audio the master clock.

The operator picked option 2 from the closing table — file it as an analysis —
and closed the thread with `merge`. Options 1 (build a working prototype), 3
(promote the SoNSTAR bookmark), and 4 (ground the psychoacoustic figures in
`type: source` captures) were not taken and are recorded as open in the ledger
below; the analysis carries the first as a prototype-shaped proposition and the
last two as its grounding gap.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Sonification design for the intrusion replay, and what audio buys over its visual encoding | closed | [sonifying-an-incident-replay](/meta/analysis/sonifying-an-incident-replay.md) | - |
| The page's two structural encoding losses (self-normalized bars, partial-day bins) and the general topology-vs-time collision | closed | [sonifying-an-incident-replay](/meta/analysis/sonifying-an-incident-replay.md) | - |
| Build a working Web Audio prototype (option 1) | open | [sonifying-an-incident-replay](/meta/analysis/sonifying-an-incident-replay.md) | Live Web Audio or a rendered NRT artifact — an incident replay arguably wants both, which is two implementations |
| Ground the psychoacoustic thresholds (stream ceiling, fusion threshold, interval discrimination) as `type: source` captures (option 4) | open | `unrouted` | Which primary sources; and whether promoting the surveyed SoNSTAR bookmark (option 3) supplies the evaluated anchor first |

*The first two `## Assistant` blocks below are harness error text, not agent
responses — the opening request hit two `529 Overloaded` failures before the
third attempt ran, which is why the operator's question appears twice in the
render. Retained rather than stripped, so the duplication is legible.*

## User

what might it look like to sonify this presentation? what advantages might there be compared to the strictly visual presentation?

https://huggingface-anatomy-of-frontier-lab-model-intrusion.static.hf.space/index.html

## Assistant

API Error: 529 Overloaded. This is a server-side issue, usually temporary — try again in a moment. If it persists, check https://status.claude.com.

## User

Continue from where you left off.

## Assistant

API Error: 529 Overloaded. This is a server-side issue, usually temporary — try again in a moment. If it persists, check https://status.claude.com.

## User

what might it look like to sonify this presentation? what advantages might there be compared to the strictly visual presentation?

https://huggingface-anatomy-of-frontier-lab-model-intrusion.static.hf.space/index.html

## Assistant

## Orientation

The page is a 46-second automated replay of a five-day intrusion: a network map where boxes light up as the attacker reaches them, nine phase counters ticking upward, a scrolling command log, a five-bar daily volume chart, a clock, and a running total to 17,613 actions. All of it moves at once, and you have one pair of eyes.

Sonifying it means giving the ear the parts that change over time — how fast actions are arriving, which attack phases are running concurrently, how far the compromise has spread — and leaving the eye the parts that are spatial and propositional: the topology, the command text, the exact numbers. The argument isn't audio *instead of* the visuals. It's that this particular page is asking its two spatial axes to hold network topology **and** asking the same visual channels to hold a five-day time series, and one of those two jobs can be handed to a sense that is natively temporal and natively parallel.

I read the page source rather than only the rendered view, so the numbers below are from its actual data model (`NODES`, `PHASES`, `DAYS`, `EVENTS` in the inline script).

---

## What the page currently encodes

| Channel | Carries | Live simultaneously? |
|---|---|---|
| Agent dot + pulse | frontier node (highest-frac live node) | yes |
| Edge draw-on (8 edges) | traversal, one per boundary crossing | yes |
| Zone glow (5 zones) | which trust boundaries are breached | yes |
| Phase panel (9 rows) | per-phase progress bar + running count | yes |
| Blast-radius readout | 5-rung escalation ladder + color | yes |
| Day histogram (5 bars) | actions per calendar day | yes |
| Log stream | 21 narrated commands with output | yes |
| Flare toast | 4 turning points, 3.8s each | transient |
| Clock + counter | UTC time, cumulative actions | yes |

Two structural facts fall out of reading the code, and they set up most of what follows.

**The phase bars are nine redundant clocks.** Each fill is `count/p.total * 100%` — normalized to *its own* total. So `evasion` (6 actions) and `dropper` (6,972 actions) draw identical bars. The bar channel is entirely spent re-encoding elapsed time; all magnitude information survives only as a small numeral. A 1,161× difference in volume is invisible by construction.

**The histogram's equal-looking bars are not equal intensities.** Day 2 = 1,135 actions, Day 5 = 1,130 — within 0.5%, visually identical. But the window starts 02:28 and ends 14:14, so Day 2 spans 24 hours and Day 5 spans 14.2. As rates: ~47 actions/hour vs ~79 — a 1.7× difference the chart cannot show, because it bins by calendar day and rate is per unit time. Sonification has no binning decision to get wrong: density *is* events per second.

---

## The sonification design

Six layers, all driven from the same `render(t)`.

**1 — Clock bed.** One soft tick per simulated hour, accented at midnight. At 1× (6,466 minutes over 46 s = 141 sim-min per real second) an hour is 0.427 s → ~140 bpm, with day boundaries 10.2 s apart. A metric grid, so every other sound is *dated* by ear without reading the clock.

**2 — Action rate as granular density.** One grain per action-cluster, rate ∝ d(count)/dt. Below ~20/s you hear discrete clicks; above that the grains fuse and rate reads as roughness and brightness instead. That crossover is a feature: it's where "individual decisions" becomes "machine speed," which is the lede's whole claim. Day 3 peaks at ~750 actions/s at 1× — solid roar. Day 2 is a hole in the texture. The 1,092 actions (6.2%) that fall outside all nine phases — the phase totals sum to 16,521 of 17,613 — get untimbred grains, so unclassified volume stays audible instead of vanishing.

**3 — Phases as concurrent streams.** Nine won't segregate; the reliable limit for tracked concurrent auditory streams is around three or four (recalled, unchecked). Split by frequency:

- **Engine phases** — `recon` 6,191 · `rce` 2,911 · `dropper` 6,972, together 91% of classified actions — get three sustained pitched voices in separate registers, amplitude ∝ instantaneous rate. These are the bed.
- **Escalation phases** — `exfil` 56 · `c2` 114 · `evasion` 6 · `k8s` 87 · `supply-chain` 69 · `tailscale` 115, 447 actions total — are far too rare for drones and get one distinct gesture each: exfil as a downward glissando panned outward into wet reverb (leaving); c2 as a two-note call-and-response; k8s as a metallic cluster; supply-chain as a lock-click; tailscale as a rising interval that resolves, after which the mesh drone joins the bed; evasion as a bandpass sweep that briefly muffles the entire mix (packing).

One correction to make honestly: the page only knows each phase's total plus its first/last timestamps, and interpolates linearly between them. Drone amplitudes driven straight off that would be nine smooth ramps — the same defect as the bars. The fix is to redistribute each phase's total across the window weighted by the daily volume profile, so Day 3's spike appears in every concurrent stream rather than being averaged away.

**4 — Blast radius as harmonic and spatial state.** The five rungs (sandbox → HF pod 0.498 → HF cluster 0.5169 → internal net 0.6209 → source control 0.8599) each add a lower octave to the drone and widen the reverb — mono and dry inside the sandbox, wide and roomy once the mesh is joined. The room literally gets bigger as containment fails. Nothing ever gets removed. An added bass octave that never leaves for the remaining 40 seconds *is* irreversibility, in a way that a text label changing from orange to red is not.

**5 — Topology as azimuth and depth.** Node `x` → pan. Stage 1 (n1→n2→n3→n4, all at y=88) becomes a literal left-to-right sweep, matching the visual's own horizontal layout. Node `y` (88 → 470, outward to deep interior) → lowpass cutoff and reverb send, so "further in" sounds further away. Each ignition leaves a sustained presence tone, so nine footholds accrete into a nine-note chord: at any instant, "how bad is it now" is one gestalt, no reading required. The dashed read-back edge (n5→n4, active from 0.498 to the end) is a continuous whisper between two spatial positions — a leak you can hear running under everything else.

**6 — Narrated events and flares.** Each of the 21 log events fires its phase gesture, boosted. Each of the 4 flares ducks the whole mix, fires a stinger, and returns — plus speech for the flare text itself. Non-speech audio is bad at propositions; "One 200. Blast radius: one sandbox → the internal network" wants a voice, not an earcon. Containment at t=1 hard-gates everything and leaves only the enlarged reverb tail decaying. Cut off, not petered out.

**The tempo problem.** 46 seconds is too fast for auditory detail — rhythm perception fuses somewhere around 8–10 events/s (recalled, unchecked), and Day 3 runs at 750. So 1× survives only as a texture pass: you hear the arc, not the events. The sonified default wants ~3–4 minutes (240 s → 27 sim-min/s, putting the 447 escalation actions near 1.9/s). That means extending the existing speed control *downward* — add 0.25× and 0.1× beside the current 0.5×–4×.

---

## What the ear gets that the eye doesn't

1. **Parallelism without foveation.** Vision is serial and foveal; eight panels update simultaneously for 46 seconds and you can fixate one. The design is already fighting this — pulses, glows, and autoscroll all exist to grab a gaze that can only be in one place. Audition delivers three or four streams at once with nothing to aim.

2. **Rarity inverts salience.** The bars discard magnitude entirely (above), so `evasion: 6` and `dropper: 6972` look the same. In a dense texture, a rare unusual timbre is *more* salient the rarer it is. The six actions a responder most wants to notice go from invisible to unmissable, on the same data.

3. **Rate is ear-native.** "Is this accelerating?" from an incrementing counter is guesswork; from a click train it's immediate. Humans resolve temporal intervals far better than they compare lengths (recalled, unchecked). The piece's thesis is a claim about *speed*, currently rendered as a number going up and five static bars.

4. **Time stops competing for space.** The map needs both spatial axes for topology. Handing the time series to the ear frees the visual to stop encoding elapsed time nine times over in bars that could be showing relative volume instead.

5. **Irreversible state feels irreversible.** Accumulation is trivial in audio and expensive on screen — nine simultaneously-lit, still-legible boxes is roughly the map's ceiling, which is why it dims and glows rather than layering.

6. **Eyes-free and non-visual access.** The entire argument currently lives in animated SVG state with no textual equivalent, so it's largely unavailable to a blind reader. It also can't be monitored while doing something else, which is what an actual SOC wants.

7. **Memorability.** "Quiet day, then the Day 3 roar, then the floor drops and the room opens up" is a musical figure people retell. Charts aren't.

**Where the visual keeps winning:** absolute values (you will never read "6,972" off a drone — keep the numerals), and random access. The `#<frac>` deep-link freezes a readable instant; a frozen instant of audio is a static chord. Mitigation is a ~600 ms "state arpeggio" on scrub — sweep the accumulated node chord plus the current blast-radius bass — so a frozen moment still has a signature. Two further disciplines: publish an audio legend (hover-to-hear on each existing phase row, plus a 20-second cast-of-sounds preamble), or nobody can decode the mapping; and bind *every* audible parameter to a variable, since an unbound tension pad turns an incident report into a thriller trailer and costs it credibility.

---

## Feasibility

It's a static Space, all client-side, and the model is fully deterministic and closed-form — so the whole piece can be pre-scheduled on the audio clock at `play()`. The clean version inverts the current master clock: `loop(ts)` currently integrates `performance.now()` deltas, and would instead read `t = (ctx.currentTime - t0) / DUR * speed`, making audio the timebase and killing drift. Drones are three oscillators with `setValueCurveAtTime` gain envelopes; grains are buffer sources up to the fusion threshold and a filtered noise source above it (the crossover is perceptually invisible, which is why it's safe); earcons are six short prerendered buffers panned by node `x`; blast radius is a per-rung bass oscillator plus a convolver whose wet send steps up; flares are a scheduled dip on the master gain.

One conflict: the page auto-starts playback 900 ms after load, and Web Audio can't start without a user gesture. The play button becomes the audio unlock — either auto-start visuals and arm audio on first click, or replace the auto-start with a single "▶ with sound" affordance.

---

## Prior art already in the brain

- [media-production-domain-synergies](https://github.com/ob6to8/elixir-mind/blob/main/meta/analysis/media-production-domain-synergies.md) — Finding 1 frames sonification as "a **perceptual gate for temporal data**: mechanical to produce, human to consume, sensitive precisely where visual inspection is weak," and names "anything in the bundle with a timeline" as candidate subjects. This presentation is exactly that subject, from outside the bundle.
- [declared-cadence-swarm-auditability](https://github.com/ob6to8/elixir-mind/blob/main/meta/analysis/declared-cadence-swarm-auditability.md) — its sonification channel maps agent-swarm pathology to musical texture; the phase-stream and density layers above are the same mapping vocabulary pointed at an adversarial timeline instead of an orchestration one.
- [`survey/bookmarks.md`](https://github.com/ob6to8/elixir-mind/blob/main/survey/bookmarks.md) already holds SoNSTAR (PLOS One), which "uses audio representations of TCP/IP traffic to help network administrators detect anomalies with reduced cognitive load" — network-intrusion sonification with a published evaluation, currently surveyed but not ingested.

## Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Build a working prototype | Fork the page's data model into a standalone HTML file with the six-layer Web Audio engine, audio as master clock, 0.1×–4× speeds, and an audio legend. Self-contained, publishable as an artifact. |
| 2 | File this as an `analysis` | `meta/analysis/` per the routing table — a reasoned judgment on where audio beats this visual, cross-linked to the two analyses above. It would also carry the two encoding defects I found in the page's own data (self-normalized bars, partial-day bins). |
| 3 | Promote the SoNSTAR bookmark | `/bookmarks promote` → a filed `reference`, giving the sonification claims an evaluated external anchor instead of my recalled psychoacoustics. |
| 4 | Ground the perceptual figures | The stream limit, fusion threshold, and interval-discrimination numbers above are training knowledge. Grounding them in `type: source` captures would let a filed claim carry `verified: true`. |

## User

2 then /create-pull-request merge
