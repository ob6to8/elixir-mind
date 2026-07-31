---
id: em:4f45bf
type: concept
title: madār
description: In hadith scholarship, the common transmitter a set of apparently separate isnād chains all pass through — the "pivot" whose discovery reveals that ostensibly independent corroborating reports actually share a single point of origin.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, provenance, trust, hadith]
sense: common
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T17:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-29 ISNAD claim-verification intake thread"
---

# madār

Detecting a madār matters because corroboration only raises confidence when
the corroborating chains are genuinely independent — two reports that both
trace back to the same narrator are one witness counted twice, not two. The
ISNAD framework's corroboration mechanism runs madār detection before
crediting a match, but the
[captured discussion thread](/knowledge/SWE/agentic/provenance/isnad-reddit-discussion-thread.md)'s
critique is that AI pipelines make the underlying independence far harder to
establish than the original human system did: "two chains routed through the
same base model are not independent even when the agents and prompts differ,
so correlated error arrives looking exactly like agreement" — the shared base
model is a madār detection has no clean way to see.

*Seen in:* [2026-07-29 ISNAD claim-verification intake](/meta/threads/2026-07-29-isnad-claim-verification-intake.md), [ISNAD reference](/knowledge/SWE/agentic/provenance/isnad-rijal-claim-level-provenance.md)

*See also:* [isnād](/beliefs/glossary/isnad.md), [rijāl](/beliefs/glossary/rijal.md)
