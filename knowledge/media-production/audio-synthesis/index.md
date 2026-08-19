# audio-synthesis

DSP models and render backends for producing sound with code.

## Contents

- [Generating Sound & Organizing Time: Thinking with gen~ (Book 1)](/knowledge/media-production/audio-synthesis/generating-sound-organizing-time.md)
  — Wakefield & Taylor's per-sample DSP book, captured at chapter level from
  the publisher's table of contents: ramp-based time, unit shaping, chaos,
  binary/Euclidean sequencing, filters, delays, modulation, wavetables,
  granular time
- [DSP reduces to a small primitive vocabulary plus one sample of memory](/knowledge/media-production/audio-synthesis/gen-dsp-primitive-reduction.md)
  — the mental model gen~ demonstrates: two-input arithmetic, the one-sample
  `history` delay, and delay lines, made efficient by compilation
- [SuperCollider non-realtime rendering](/knowledge/media-production/audio-synthesis/supercollider-nrt-rendering.md)
  — deterministic, hardware-free WAV renders from time-stamped command files,
  and the blockSize quantisation trap
- [Wakefield — Gen course notes](/knowledge/media-production/audio-synthesis/wakefield-gen-course-notes.md)
  — primary-source extracts from gen~'s author: operator count, single-sample
  feedback, the no-triggers rule, patch-as-compiler-specification
- [loopmaster / groovemaster: livecoding music in the browser via WASM DSP](/knowledge/media-production/audio-synthesis/loopmaster-groovemaster-livecoding-dsp.md)
  — function-call signal generators compiled to a WebAssembly DSP engine, no
  install
- [Rust audio DSP ecosystem: rust.audio and the awesome-audio-dsp list](/knowledge/media-production/audio-synthesis/rust-audio-dsp-ecosystem.md)
  — the community hub and its 19-category curated list of DSP libraries,
  cookbooks, and plugin-dev resources (language-agnostic, not Rust-only)
- [serum2gen: a CLI/Python toolkit for Xfer Serum 2 preset files](/knowledge/media-production/audio-synthesis/serum2-preset-toolkit.md)
  — reverse-engineered .SerumPreset editing plus optional VAE-based preset
  generation; unrelated to gen~ despite the name
