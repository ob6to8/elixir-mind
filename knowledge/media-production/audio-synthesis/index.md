# audio-synthesis

DSP models and render backends for producing sound with code.

## Contents

- [DSP reduces to a small primitive vocabulary plus one sample of memory](/knowledge/media-production/audio-synthesis/gen-dsp-primitive-reduction.md)
  — the mental model gen~ demonstrates: two-input arithmetic, the one-sample
  `history` delay, and delay lines, made efficient by compilation
- [SuperCollider non-realtime rendering](/knowledge/media-production/audio-synthesis/supercollider-nrt-rendering.md)
  — deterministic, hardware-free WAV renders from time-stamped command files,
  and the blockSize quantisation trap
- [Wakefield — Gen course notes](/knowledge/media-production/audio-synthesis/wakefield-gen-course-notes.md)
  — primary-source extracts from gen~'s author: operator count, single-sample
  feedback, the no-triggers rule, patch-as-compiler-specification
