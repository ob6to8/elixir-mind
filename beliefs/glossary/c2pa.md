---
id: em:91b77a
type: concept
title: C2PA
description: The Coalition for Content Provenance and Authenticity's standard for content credentials — cryptographically signed provenance metadata attached to a media asset, recording how it was created and edited so consumers can verify its origin.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, provenance, media, standards, authenticity]
sense: common
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-30 human-writing-attribution thread"
---

# C2PA

The credential travels with the file as a signed manifest of assertions
(capture device, edits, AI involvement), verifiable by anyone holding the
standard's trust list. Its known limitation is structural: the manifest is
detachable metadata, so it survives only inside cooperating ecosystems —
stripping it (or re-encoding the asset) removes the provenance without
visibly changing the content. The
[human-writing-attribution project](/projects/human-writing-attribution.md)
treats this as the failure mode to design against, placing disclosure in the
work's frame as content rather than as a sidecar credential.

*Seen in:* [2026-07-30 human-writing-attribution thread](/meta/threads/2026-07-30-human-writing-attribution.md), [human-writing-attribution project hub](/projects/human-writing-attribution.md)
