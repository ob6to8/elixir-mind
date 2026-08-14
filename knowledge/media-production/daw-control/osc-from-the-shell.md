---
id: em:b91fe3
type: snippet
title: "Realtime OSC from the shell"
description: "Command lines that speak OSC over UDP — oscsend/oscdump from liblo-tools, and python-osc one-liners as the portable fallback — with the invocation shapes for driving and observing a DAW such as Bitwig behind DrivenByMoss."
provenance: "Claude Fable 5 — commands composed from the cited documentation plus training knowledge where marked; not executed against a live DAW in the authoring session"
tags: [media-production, daw-control, osc, shell, cli, snippet]
timestamp: 2026-08-14
attribution:
  when: 2026-08-14T22:35:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive web session"
  why: "the smallest working vocabulary for shell-to-DAW OSC, filed so recipes and plans can cite commands instead of restating them"
---

# Realtime OSC from the shell

OSC rides single UDP datagrams, so "shell control" needs no daemon — each
command line is one packet. Two tool families cover send and observe.
(Command syntax below is from training knowledge — the Debian manpage fetch
failed in the authoring session — so verify locally with `man oscsend`;
addresses and value ranges are from the
[DrivenByMoss register](/knowledge/media-production/daw-control/bitwig/drivenbymoss-osc.md).)

## liblo-tools: oscsend / oscdump

Install: `apt install liblo-tools` (Debian/Ubuntu) · `brew install liblo`
(macOS). Shape: `oscsend <host> <port> <address> [<typetags> <args…>]` with
typetags `i` (int32), `f` (float32), `s` (string).

```sh
# transport — DrivenByMoss OSC listening on localhost:8000
oscsend localhost 8000 /play i 1          # start
oscsend localhost 8000 /stop              # stop
oscsend localhost 8000 /tempo/raw f 128.0 # set BPM

# selected device: first remote-control slot (range 0–127 at default resolution)
oscsend localhost 8000 /device/param/1/value i 96

# play middle C on channel 1 at velocity 100, then release
oscsend localhost 8000 /vkb_midi/1/note/60 i 100
oscsend localhost 8000 /vkb_midi/1/note/60 i 0

# a 5-second filter sweep at ~50 Hz control rate
for v in $(seq 0 127); do
  oscsend localhost 8000 /device/param/1/value i "$v"; sleep 0.04
done
```

Observe the DAW's feedback stream (DrivenByMoss sends state to its
configured client port, here 9000):

```sh
oscdump 9000            # prints every message: /play 1, /track/3/volume …, /update …
oscdump 9000 | grep --line-buffered '/device/param'   # watch one surface
```

## python-osc: the portable fallback

Where liblo is awkward (Windows, restricted machines), `pip install
python-osc` gives the same packet from any Python:

```sh
python3 -c 'from pythonosc.udp_client import SimpleUDPClient;
SimpleUDPClient("127.0.0.1", 8000).send_message("/device/param/1/value", 96)'
```

## The two habits that make this work

- **Integers vs floats matter.** A server may bind an address to one numeric
  type; when a value seems ignored, retry with the other typetag (`i 64` ↔
  `f 0.5`) before assuming the address is wrong.
- **Ports come in pairs.** One port receives commands, a different one
  carries feedback ("Send and receive ports must be different" — DrivenByMoss
  docs); point the observer at the *send-to* port, the sender at the
  *receive* port.

## Citations

- [liblo](https://github.com/radarsat1/liblo) (oscsend/oscdump ship as its tools)
- [python-osc on PyPI](https://pypi.org/project/python-osc/)
- [DrivenByMoss OSC register](https://github.com/git-moss/DrivenByMoss-Documentation/blob/master/Generic-Tools-Protocols/Open-Sound-Control-(OSC).md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:b91fe3">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-14-bitwig-shell-control-incubation-and-agentic-daw-fit (2026-08-14)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:b91fe3`]**  (co-feeds: `em:4a51b2 em:bb3021`)

**The ten-minute path** (commands composed from the cited docs, unexecuted here): install DrivenByMoss from mossgrabers.de, add its **Open Sound Control** controller in Bitwig's settings, note the receive/send ports, then:

```sh
oscsend localhost 8000 /play i 1                  # transport starts
oscsend localhost 8000 /device/param/1/value i 96 # selected Grid patch, slot 1 moves
oscsend localhost 8000 /vkb_midi/1/note/60 i 100  # play middle C into it
oscdump 9000                                      # watch Bitwig's state stream back
```
