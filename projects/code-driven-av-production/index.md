# Code-driven AV production — documents

Design records for [code-driven AV production](/projects/code-driven-av-production.md).
Project-scoped by construction: anything true regardless of this system files to
[knowledge](/knowledge/index.md) instead, per the
[projects-namespace policy](/meta/policy/project-namespace.md).

## Design records

- [Recreating the headless SuperCollider grid render locally](/projects/code-driven-av-production/headless-supercollider-grid-render.md)
  — the runnable walkthrough: install SuperCollider, render a sample-accurate
  120 BPM beat to WAV with no audio hardware, verify it against the grid, wire
  it into ffmpeg; scripts included verbatim. _(tutorial)_
- [Declared grids vs. measured timelines](/projects/code-driven-av-production/declared-grid-av-production.md)
  — why the timeline is declared rather than recovered by onset detection, the
  measured error budget across scsynth and ffmpeg, and the boundary where
  counting stops and listening starts. _(analysis)_
- [A gen~-inspired music-programming DSL](/projects/code-driven-av-production/gen-inspired-music-dsl.md)
  — what the *Generating Sound & Organizing Time* reductions offer a timing
  DSL versus a DSP DSL; recommends building the timing half with MIDI,
  SuperCollider NRT, and ffmpeg as compilation targets. _(analysis)_
