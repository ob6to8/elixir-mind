# bitwig

Bitwig Studio's programmatic control planes — what a running instance exposes
to external processes, and how far each plane reaches.

## Contents

- [Bitwig's programmatic control surfaces](/knowledge/media-production/daw-control/bitwig/bitwig-control-surfaces.md)
  — the four planes: Open Controller API extensions, the DrivenByMoss OSC
  bridge, plain MIDI mapping, and WebSocket JSON-RPC, with the realtime
  character and reach of each
- [DrivenByMoss OSC](/knowledge/media-production/daw-control/bitwig/drivenbymoss-osc.md)
  — the de-facto OSC server for Bitwig: setup, the documented address space
  (transport, tracks, device parameters, clips, notes), and the feedback
  channel
- [The Grid's programmability boundary](/knowledge/media-production/daw-control/bitwig/the-grid-programmability-boundary.md)
  — parameter-addressable, not patch-addressable: what external control can
  and cannot reach inside a Grid patch
