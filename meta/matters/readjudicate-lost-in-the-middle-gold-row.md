---
type: matter
title: "Re-adjudicate the lost-in-the-middle gold row"
description: The glossary term doc titled exactly "lost-in-the-middle" (em:1b3160, filed 2026-07-25) postdates the row's 2026-07-12 acceptable-id set, and plain search already surfaces it (the row's match-set of 1 is that doc) while scoring a miss — present the re-adjudication for operator sign-off per the gold doc's protocol, apply it, and regenerate the baseline.
status: open
model: Claude Sonnet 5
provenance: "Claude Fable 5, /scope-unit-of-work session"
tags: [meta, matter, dedup, recall, gold-set, adjudication]
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T04:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, /scope-unit-of-work"
  why: "the operator directed the session's open items be turned into matters; this one closes the adjudication-lag finding from the vocabulary-mismatch spike"
---

# Re-adjudicate the lost-in-the-middle gold row

Finding, from the
[vocabulary-mismatch analysis](/meta/analysis/solving-vocabulary-mismatch-offline.md):
the `lost in the middle` row's acceptable set is `em:77d68a` (the context-rot
capture) only, adjudicated 2026-07-12; the glossary concept
[`em:1b3160`](/beliefs/glossary/lost-in-the-middle.md) filed 2026-07-25 answers
the query by title and is what the plain backend already surfaces — scored as a
miss purely by adjudication lag. The
[gold doc](/meta/evals/dedup-probe.md) reserves re-adjudication for human
sign-off, so delivery is: present the options (add `em:1b3160` to the
acceptable ids — the recommendation — vs. a note-only disposition), apply the
operator's choice to the row's ids and note, and run
`mix brain.dedup_probe --update-baseline`.

## Model

Rendering an adjudication already argued in the filed analysis, on a register
row, with the change visible on sight and the baseline regenerated
mechanically — the roster's governance-prose row.
