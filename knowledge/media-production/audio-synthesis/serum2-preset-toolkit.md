---
id: em:f988c6
type: reference
title: "serum2gen: a CLI/Python toolkit for Xfer Serum 2 preset files"
description: A reverse-engineered CLI and Python toolkit for reading, editing, and generating Xfer Serum 2's proprietary .SerumPreset binary format, with 150+ human-readable parameter aliases and an optional VAE-based latent-space preset generator — despite the name, it has no relationship to Cycling '74's gen~ or Max/MSP.
resource: https://github.com/dougwithseismic/serum2gen
provenance: "dougwithseismic, serum2gen (GitHub), fetched 2026-08-18"
tags: [media-production, audio-synthesis, synthesizer, presets, serum, reverse-engineering, machine-learning]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# serum2gen: a CLI/Python toolkit for Xfer Serum 2 preset files

**Despite the name, this has no connection to gen~ or Max/MSP** — checked
directly against the repository's README, not inferred from the name.
"gen" here is unrelated to Cycling '74's gen~ environment already documented
in this bundle
([DSP reduces to a small primitive vocabulary](/knowledge/media-production/audio-synthesis/gen-dsp-primitive-reduction.md)):
serum2gen is exclusively about Xfer Serum 2's own native preset format.

## What it does

A reverse-engineered implementation of Serum 2's proprietary `.SerumPreset`
binary format — a combination of XferJson, CBOR, and Zstandard compression
— with full read/write support, exposed through both a CLI (30+ commands:
list, inspect, search, get/set parameters) and a Python API. 150+
human-readable parameter aliases let a user address preset fields by name
instead of raw CBOR paths. It can browse the factory wavetable and sample
library (288 wavetables, 900+ samples), edit modulation/effects/envelope
settings, and generate seed-based preset variations for reproducible
randomization. An optional ML feature trains a VAE on the factory preset
corpus and samples its latent space to generate novel presets.

## Status at capture

Early-stage, low-adoption: a handful of GitHub stars, few commits, no forks,
no pull requests, despite comparatively complete documentation and feature
breadth for that stage. Treat as a functioning but unvetted personal tool
rather than an established one.

# Citations

- <https://github.com/dougwithseismic/serum2gen>
