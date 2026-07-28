---
id: em:0b9d92
type: tutorial
title: Recreating the headless SuperCollider grid render locally
description: "Render a sample-accurate 120 BPM house beat to WAV with SuperCollider's non-realtime mode — no audio hardware, no GUI — then verify every hit sits on the grid with a stdlib Python onset detector: the full scripts, the blockSize=1 setting that makes timing exact, and the ffmpeg seams for muxing the result under picture."
provenance: "Claude Code session, 2026-07-28 — every command and measurement in the verified sections was run in the session's Ubuntu 24.04 container against SuperCollider 3.13.0 (Ubuntu package) and Python 3; macOS adaptation notes are from training knowledge and are marked as such"
tags: [projects, supercollider, nrt, ffmpeg, timing, tutorial, python, audio]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T21:10:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "operator asked for a tutorial allowing local recreation of the session's verified headless render pipeline"
---

# Recreating the headless SuperCollider grid render locally

This walkthrough produces `drums.wav` — 8 bars of four-on-the-floor kick and
backbeat snare at 120 BPM, synthesized from scratch — with **no audio device,
no soundcard, and no GUI**, then proves with a measurement that every hit sits
on the grid. Everything in the *verified* sections ran exactly as shown on
Ubuntu 24.04 with SuperCollider 3.13.0 and stock Python 3; the macOS notes are
marked where they rest on training knowledge instead.

Why SuperCollider and not a DAW: the synthesis server has a **non-realtime
(NRT) mode** — it reads a time-stamped command file, renders as fast as the CPU
allows, and writes a WAV. Renders are scriptable, deterministic, faster than
realtime, and runnable on machines with no audio stack at all. The design
context — why the grid is declared rather than measured, and what that buys the
video half — is in
[Declared grids vs. measured timelines](/projects/code-driven-av-production/declared-grid-av-production.md);
this document is only the *how*.

## 1. Install

**Linux (verified):**

```bash
sudo apt-get install --no-install-recommends \
  supercollider-server supercollider-language supercollider-common
```

This installs `sclang` (the language/scripting frontend) and `scsynth` (the
synthesis server) without the IDE.

**macOS (from training knowledge, unchecked):** install the app from
supercollider.github.io or `brew install --cask supercollider`; the CLI
binaries live inside the bundle at
`/Applications/SuperCollider.app/Contents/MacOS/sclang` (and `Resources/scsynth`).

**Headless quirk (verified, Linux-specific):** `sclang` links Qt WebEngine and
aborts at startup in a display-less container run as root, unless:

```bash
QT_QPA_PLATFORM=offscreen \
QTWEBENGINE_DISABLE_SANDBOX=1 \
QTWEBENGINE_CHROMIUM_FLAGS="--no-sandbox --disable-gpu" \
sclang render.scd
```

A normal macOS desktop session needs none of that (unchecked).

## 2. The render script

Save as `house.scd`. The grid arithmetic is the whole idea: at 120 BPM a beat
is exactly 0.5 s, a bar 2.0 s, a sixteenth 0.125 s, and each drum pattern is a
list of sixteenth-indices within the bar.

```supercollider
(
var bpm = 120, bars = 8, beat, bar, sixteenth, events, kick, snare, score, sr = 44100;

beat = 60 / bpm;          // 0.5 s
bar  = beat * 4;          // 2.0 s
sixteenth = beat / 4;     // 0.125 s

kick = SynthDef(\kick, { |out = 0, amp = 0.9|
    var env  = EnvGen.ar(Env.perc(0.001, 0.34, amp, -8), doneAction: 2);
    var fenv = EnvGen.ar(Env([190, 58, 42], [0.025, 0.14], \exp));
    var sig  = SinOsc.ar(fenv) * env;
    var clik = WhiteNoise.ar(0.35) * EnvGen.ar(Env.perc(0.0003, 0.008));
    Out.ar(out, ((sig + clik) * 1.4).tanh ! 2);
});

snare = SynthDef(\snare, { |out = 0, amp = 0.55|
    var env  = EnvGen.ar(Env.perc(0.001, 0.17, amp, -6), doneAction: 2);
    var nz   = HPF.ar(WhiteNoise.ar, 1400) * env;
    var tone = SinOsc.ar(195) * EnvGen.ar(Env.perc(0.001, 0.08, 0.45, -6));
    Out.ar(out, ((nz + tone) * 0.9) ! 2);
});

// The grid: sixteenth-indices within each bar.
events = [[0.0, [\d_recv, kick.asBytes]], [0.0, [\d_recv, snare.asBytes]]];

bars.do { |b|
    var t0 = b * bar;
    [0, 4, 8, 12].do { |ix|                       // four on the floor
        events = events.add([t0 + (ix * sixteenth), [\s_new, \kick, -1, 0, 0]]);
    };
    [4, 12].do { |ix|                             // backbeat
        events = events.add([t0 + (ix * sixteenth), [\s_new, \snare, -1, 0, 0]]);
    };
};

events = events.add([bars * bar + 1.0, [\c_set, 0, 0]]);   // tail

score = Score(events.sort { |a, b| a[0] <= b[0] });
score.recordNRT("/tmp/house.osc", "drums.wav", nil, sr, "wav", "int16",
    options: ServerOptions.new.numOutputBusChannels_(2).blockSize_(1));
"RENDER SUBMITTED".postln;
)
```

Run it:

```bash
timeout 120 sclang house.scd      # plus the Qt env vars on headless Linux
```

**Exit behavior (verified):** `recordNRT` hands the score to `scsynth` and
returns; `sclang` then idles rather than exiting, so wrap the call in `timeout`
(the render itself completes in seconds — the 17 s file appeared well before the
wrapper fired). `recordNRT` also accepts an `action:` callback in SC 3.13 where
`{ 0.exit }` would close the interpreter on completion (from training
knowledge, unchecked).

Mechanically, `recordNRT` writes the time-stamped OSC command file
(`/tmp/house.osc`) and invokes `scsynth -N` on it — the two-step form is worth
knowing because the `.osc` file is a build artifact any language can generate;
`sclang` is only needed here because `SynthDef` compilation is easiest in it.

## 3. The setting that makes timing exact: `blockSize_(1)`

`scsynth` schedules events on control-block boundaries, and the default block
is 64 samples. Measured consequence (clicks rendered at deliberately off-block
target times, onset positions read back from the WAV):

| `blockSize` | target 4410 | target 8825 | target 13240 | error |
|---|---|---|---|---|
| 64 (default) | 4352 | 8768 | 13184 | −56 to −58 samples (≈ −1.3 ms), always early |
| 1 | 4410 | 8825 | 13240 | 0 samples |

Events snap *down* to the preceding block boundary. 1.3 ms is invisible against
picture (0.04 of a frame at 24 fps) but audible as flam/comb-filtering the
moment a block-quantised render is layered against sample-placed one-shots —
so NRT renders set `blockSize_(1)`. The realtime CPU cost objection does not
apply: nothing is realtime here.

To reproduce the measurement, render the same three clicks at both block sizes
(`blocktest.scd`):

```supercollider
(
var click, mk, times;
click = SynthDef(\click, { Out.ar(0, EnvGen.ar(Env.perc(0.0001, 0.002), doneAction:2) ! 2) });
times = [0.10000, 0.20011337868, 0.30022675737];   // deliberately off-grid, non-multiples of 64 samples
mk = { |bs, out|
    var ev = [[0.0, [\d_recv, click.asBytes]]];
    times.do { |t| ev = ev.add([t, [\s_new, \click, -1, 0, 0]]) };
    ev = ev.add([0.5, [\c_set, 0, 0]]);
    Score(ev).recordNRT("/tmp/bt_%.osc".format(bs), out, nil, 44100, "wav", "int16",
        options: ServerOptions.new.numOutputBusChannels_(2).blockSize_(bs));
};
mk.(64, "bs64.wav");
mk.(1,  "bs1.wav");
"SUBMITTED".postln;
)
```

and read the onset sample positions back (`blockcheck.py`, stdlib only):

```python
import wave, array
targets = [0.10000, 0.20011337868, 0.30022675737]
for f in ("bs64.wav", "bs1.wav"):
    w = wave.open(f); sr, ch, n = w.getframerate(), w.getnchannels(), w.getnframes()
    a = array.array('h'); a.frombytes(w.readframes(n))
    mono = a[0::ch]
    on, i = [], 0
    while i < len(mono):
        if abs(mono[i]) > 3000:
            on.append(i); i += 200
        else: i += 1
    print(f, "onset samples:", on)
    for t, s in zip(targets, on):
        want = t*sr
        print(f"   target {want:10.2f}  actual {s:6d}  err {s-want:+7.2f} samples ({(s-want)/sr*1000:+.3f} ms)")
```

## 4. Verify the beat against the grid

`check.py` runs the same 5 ms-RMS onset detection the predecessor video
pipeline used, over the render, and compares every detected kick to the ideal
grid:

```python
import wave, array, math
w = wave.open("drums.wav")
sr, ch, n = w.getframerate(), w.getnchannels(), w.getnframes()
raw = array.array('h'); raw.frombytes(w.readframes(n))
mono = [ (raw[i*ch]+raw[i*ch+1])/2.0 for i in range(n) ]
print(f"sr={sr} ch={ch} frames={n} dur={n/sr:.3f}s peak={max(abs(x) for x in mono)/32768:.3f}")

hop = int(sr*0.005)                      # 5 ms slices
rms = []
for i in range(0, n-hop, hop):
    s = sum(x*x for x in mono[i:i+hop])/hop
    rms.append(math.sqrt(s))
onsets, prev = [], 0.0
for i, v in enumerate(rms):
    if v > 400 and v > prev*3.0:         # sudden loudness jump
        onsets.append(i*hop/sr)
    prev = v
print(f"detected {len(onsets)} onsets")
expected = sorted({b*2.0 + ix*0.125 for b in range(8) for ix in (0,4,8,12)})
err = []
for e in expected:
    near = min(onsets, key=lambda o: abs(o-e))
    err.append((near-e)*1000)
print("max |error| vs 120bpm grid: %.1f ms" % max(abs(x) for x in err))
```

Verified result: 17.001 s stereo file, max grid deviation **5.2 ms — which is
the detector's own 5 ms analysis-hop quantisation floor, not render error**
(the `blockSize` measurement above is the sub-millisecond proof). Expect the
same shape of number locally; a materially larger one means the render is
wrong.

## 5. Wiring into ffmpeg

The audio side above meets the picture side at three seams, each with one
failure mode:

- **Exact seek:** `-ss` *before* `-i` snaps to the nearest keyframe (up to
  ~500 ms off — a full beat at 120 BPM); put `-ss` *after* `-i` for
  frame-exact cuts, or pre-transcode sources to all-intra proxies.
- **Concat uniformity:** the `concat` demuxer requires matching fps,
  resolution, pixel format, and SAR across chunks — one normalize pass per
  source into a proxy directory settles it permanently.
- **Layering audio:** `amix=inputs=N:duration=longest:normalize=0` — without
  `normalize=0`, amix scales every input down by 1/N and the mix comes out
  mysteriously quiet.

(ffmpeg seam behaviors are from training knowledge; the container run stopped
at the audio half.) The mux itself:

```bash
ffmpeg -i picture.mp4 -i drums.wav -i guide.wav \
  -filter_complex "[1:a][2:a]amix=inputs=2:duration=longest:normalize=0[a]" \
  -map 0:v -map "[a]" -c:v copy final.mp4
```

## 6. Adapting it

| Change | Where |
|---|---|
| tempo / length | `bpm`, `bars` — everything else derives |
| patterns | the sixteenth-index lists (`[0,4,8,12]`, `[4,12]`) — swing is `+0.5` on an index, ratchets are extra fractional indices |
| sounds | swap the `SynthDef`s; for **sample playback** the score needs `\b_allocRead` events loading each file into a buffer before the first `\s_new` that plays it (from training knowledge, unchecked — verify before relying on it) |
| section over a guide track | offset every event time by the section start; the grid stays authoritative |

The reasoning for *why* patterns should eventually be one ramp rather than
index lists — swing, polymeter, and picture cuts as arithmetic on a single
phase function — is the subject of
[the DSL analysis](/projects/code-driven-av-production/gen-inspired-music-dsl.md).

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:0b9d92">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-code-driven-av-production-and-declared-cadence (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:0b9d92`]**  (co-feeds: `em:ff1ed5`)

**SuperCollider, locally: yes — verified**

Everything below I ran in this container just now.

Installed SuperCollider 3.13.0 from Ubuntu's repos (`supercollider-server`, `supercollider-language`, no GUI packages). It needs two environment variables to start headless as root, or `sclang` aborts on Qt WebEngine:


Then I rendered 8 bars of the exact beat from my last message — synthesized kick and snare, four on the floor with backbeat, 120 BPM — via `Score.recordNRT`, which drives `scsynth` in **non-realtime mode**: no audio device, no soundcard, no clock. It renders as fast as the CPU allows and writes a file.

Result: `drums.wav`, 17.001 s, 44.1 kHz stereo, peak 1.000. I then ran the same 5 ms-RMS onset detector from your video pipeline over the render and compared every detected hit to the ideal 120 BPM grid — **max deviation 5.2 ms, which is the 4.99 ms analysis-hop quantisation floor, not render error.**

**The setting that matters**

`scsynth` schedules events to control-block boundaries, and the default block is 64 samples. I tested this by rendering clicks at deliberately off-block times and measuring where they actually landed:

| `blockSize` | Target 4410 | Target 8825 | Target 13240 | Error |
|---|---|---|---|---|
| 64 (default) | 4352 | 8768 | 13184 | **−1.27 to −1.32 ms** |
| 1 | 4410 | 8825 | 13240 | **0 samples** |

Every event lands *early*, snapped down to the preceding block. For picture sync 1.3 ms is nothing — 0.04 of a frame. For audio it isn't: layer a block-quantised SC render against a sample-placed one-shot bus and you get flam and comb filtering that you'll hear as a phasey kick and never diagnose. Set `ServerOptions.blockSize = 1` for NRT renders. It costs CPU you aren't using anyway, since nothing is running in realtime.

**How it slots into the video render**


Both branches consume the same ramp, so the drums and the cuts cannot disagree — there's no sync step to get wrong. And SC renders faster than realtime, so a full re-render after a parameter change is seconds.
