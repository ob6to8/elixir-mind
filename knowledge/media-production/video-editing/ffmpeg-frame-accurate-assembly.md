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
