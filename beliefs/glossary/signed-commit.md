---
id: em:0762a7
type: concept
title: signed commit
description: A git commit carrying a cryptographic signature (GPG, SSH, or S/MIME) that verifiably ties it to the holder of a signing key — establishing who answers for the change while asserting nothing about the change's quality.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, git, security, provenance, trust]
sense: common
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-30 human-writing-attribution thread"
---

# signed commit

Hosts verify the signature against registered keys and badge the commit
"Verified"; an unsigned or mis-signed commit still functions, it just carries
no accountability anchor. The separation of concerns is what makes it a
useful trust-model reference: the signature converts "is this good?" into
"who stands behind it?" — the model the
[human-writing-attribution project](/projects/human-writing-attribution.md)
borrows for attesting authorship, and a lighter-weight cousin of this repo's
unsigned-but-attributed `Claude-Session` [git trailer](/beliefs/glossary/git-trailer.md).

*Seen in:* [2026-07-30 human-writing-attribution thread](/meta/threads/2026-07-30-human-writing-attribution.md)
