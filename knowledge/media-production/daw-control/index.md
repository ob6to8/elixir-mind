# daw-control

Driving a DAW from outside its GUI while it runs: the control planes a live
DAW process exposes (OSC, controller extensions, MIDI, RPC bridges) and the
shell tooling that speaks them. Complements
[audio-synthesis](/knowledge/media-production/audio-synthesis/index.md), which
renders sound with no DAW in the path — this directory is about performing on
one in realtime.

## Contents

- [bitwig](/knowledge/media-production/daw-control/bitwig/index.md) — Bitwig
  Studio's control planes: the Open Controller API, the DrivenByMoss OSC
  address space, and the Grid's parameter surface
- [Realtime OSC from the shell](/knowledge/media-production/daw-control/osc-from-the-shell.md)
  — command-line OSC senders and listeners: oscsend/oscdump, python-osc
  one-liners, and how to watch a DAW's feedback stream
