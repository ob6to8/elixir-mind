---
id: em:507eb9
type: note
title: "ffmpeg frame-accurate assembly: the three seams that silently break"
description: "The three defaults that undermine scripted, frame-accurate video assembly — keyframe-snapped seeks when -ss precedes -i, concat over non-uniform streams, and amix's silent level normalization — and the one-line fix for each."
verified: false
provenance: "Training knowledge, collated 2026-07-28; consistent with a working measured-timeline pipeline but not re-verified by in-session runs"
tags: [media-production, ffmpeg, video-editing, timing, scripting]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T21:40:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "the picture-side failure modes of a scripted AV pipeline, filed beside the audio-side facts they pair with"
---

# ffmpeg frame-accurate assembly: the three seams that silently break

ffmpeg is frame-accurate and scriptable, which makes it the assembly layer for
computed edits — many exact cuts concatenated and muxed under layered audio.
Three of its defaults work against that use, each with a one-line remedy:

- **Seeking.** `-ss` placed *before* `-i` seeks by keyframe: fast, but the cut
  lands on the nearest keyframe, up to hundreds of milliseconds off — at
  120 BPM, potentially a full beat. `-ss` *after* `-i` decodes to the exact
  frame. For bulk cutting, pre-transcoding sources to all-intra proxies makes
  every frame a keyframe, restoring fast *and* exact seeks (and speeding the
  whole render).
- **Concatenation.** The `concat` demuxer assumes uniform streams; chunks
  differing in fps, resolution, pixel format, or sample aspect ratio produce
  errors or corrupted output. One normalization pass per source into a proxy
  directory settles it for the project's lifetime.
- **Audio layering.** `amix` scales each of its N inputs by 1/N by default, so
  mixes come out mysteriously quiet;
  `amix=inputs=N:duration=longest:normalize=0` preserves levels (leaving
  headroom management to the caller).

A structural choice sits above the seams: rendering one chunk per cut and
concatenating is slower than a single large `filter_complex`, but each chunk is
individually inspectable — when cut 37 is wrong, chunk 37 shows why — which is
the right default for computed edits that will be revised.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:507eb9">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-code-driven-av-production-and-declared-cadence (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:507eb9`]**

Two gotchas that will bite:

- **Seek accuracy.** `-ss` *before* `-i` is fast but snaps to the nearest keyframe — potentially 500 ms off, a full beat at this tempo. Use `-ss` after `-i` for exact seeking, or transcode all-intra proxies first (which also makes the render far faster overall).
- **Stream uniformity.** `concat` of mismatched fps / resolution / pixel format / SAR either errors or produces garbage. One normalize pass per source into a proxy directory fixes it permanently.

Assembly: chunk-per-cut then `concat` demuxer is slower than a single monster `filter_complex`, but it's the right default because it's *debuggable* — when cut 37 looks wrong you can open chunk 37 and see why.

**4. Mux**

Guide track + drum bus + optionally the clips' own audio. Decide the last one explicitly — jaw harp performance audio at low level adds realism, but if the guide already contains the recorded take it's flam and phase mush. Use `amix=inputs=2:duration=longest:normalize=0`; without `normalize=0`, amix silently halves everything and you'll wonder why the render is quiet.
