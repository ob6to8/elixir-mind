---
id: em:763ec8
type: project
title: Human writing attribution
description: A provenance system for human-authored writing — every published piece ships with its declared inputs (third-party sources and the LLM threads it was worked out in) plus a mechanical overlap report marking literal quotation versus the author's own synthesis, so readers evaluate the human judgment directly instead of inferring authorship from style.
status: incubating
tags: [projects, writing, attribution, provenance, ai-authorship, transparency, reputation]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed filing session"
  why: "operator proposed the system in chat and directed incubating it as a project hub alongside the belief it rests on"
---

# Human writing attribution

A provenance system for human-authored writing. Every piece of original
writing is published with its process disclosed: the third-party sources and
LLM threads that fed it, and a mechanical analysis of the finished text
against those declared inputs marking what is literal quotation and what is
the author's own synthesis. AI is disclosed as research assistant and
brainstorming partner; the attested deliverable is the human synthesis, with
the author's reputation staked on its claims.

## The premise

The default reader posture on the open web is now suspicion: assume AI wrote
it, hunt for LLM tells, discount everything after the first hit. That is
stylometric inference — unverifiable, and an arms race the reader loses as
the tells train away. The premise, held as the belief
[the value of writing is the human synthesis behind it](/beliefs/value-of-writing-is-human-synthesis.md),
is that the reader's real question is about the *process*, not the text:
whose judgment does this piece express, and does a human stand behind it?
This system answers that question structurally instead of leaving it to
style-reading.

## The trust model

The attestation is self-issued — nothing prevents an author from stamping
"human synthesis" on machine output. What the system changes is that the
claim becomes **falsifiable**: an author who publishes their LLM threads and
sources has handed the reader the material to check the claim against, and a
"synthesis" that is a light paraphrase of a disclosed thread is convicted by
that thread. The system does not prove honesty; it makes dishonesty
auditable, and it makes the reputational stake concrete because there is now
a specific record to be caught against. This is the trust model of signed
commits: the signature establishes who answers for the work, and the cost of
a false attestation is borne by a named reputation.

The design lesson from C2PA content credentials: provenance shipped as
detachable sidecar metadata gets stripped or ignored, and only works inside
cooperating ecosystems. Here the disclosure is part of the published work's
frame — the citation graph and process record are content — so it cannot be
separated from the piece without visibly changing it.

## Shape

```
declared inputs                        published artifact
───────────────                        ──────────────────
third-party sources ─┐                 the piece itself
                     ├─ human writes ─ + citation graph (sources and threads)
LLM threads ─────────┘        │        + overlap report (quotation vs synthesis)
                              │              ▲
                              └─ overlap analysis: literal-span matching
                                 of the finished text against every
                                 declared input
```

## Decisions so far

| Decision | Choice | Rationale |
|---|---|---|
| Attested unit | ownership of the judgment | sentence-level originality is unverifiable after heavy brainstorming (the author's words are shaped by the thread either way) and is not what carries the value |
| Overlap report's claim | discloses literal quotation only | paraphrase detection is mushy enough that certifying the residue as "purely human" would overclaim; the report is plagiarism detection inverted — surfacing overlap instead of hiding it |
| Disclosure placement | in the work's frame, as content | the C2PA failure mode above: detachable provenance metadata gets stripped |
| Anti-gaming stance | publish the raw process record, a self-assessed label is insufficient | if "transparent human synthesis" becomes a desirable badge it gets gamed; threads and sources are expensive to fabricate convincingly, a label is free |
| Substrate | this brain's existing machinery | thread docs with `session:` URLs, `source` captures, and the [quote-primary-sources](/meta/policy/quote-primary-sources.md) boundary discipline already produce the expensive half of the disclosure as a by-product of normal operation |

## Open questions

- **Publication format.** What the disclosure frame looks like on an actual
  published page — inline citation graph, appendix, or a linked bundle of
  sources and threads — and how much of it a casual reader meets versus can
  drill into.
- **Thread redaction.** LLM threads contain material the author may not want
  public (tangents, private context, half-formed positions). What a
  redaction story looks like, and whether a redacted thread still carries
  enough evidentiary weight to make the attestation falsifiable.
- **The overlap tool.** A `mix brain.*`-style task that takes a piece plus
  its declared inputs and emits the quotation/synthesis report —
  literal-span matching first; whether any paraphrase signal can be included
  without crossing into overclaiming.
- **Scope of "sources".** Whether the declared-input set is only what the
  author consciously drew on, or is expanded toward everything consulted —
  and who bears the cost of the difference when a reader finds undisclosed
  overlap.

## Knowledge this project draws on

- [The value of writing is the human synthesis behind it](/beliefs/value-of-writing-is-human-synthesis.md)
  — the prior the whole design operationalizes
- [Quote primary sources](/meta/policy/quote-primary-sources.md) — the
  inward-facing form of the same discipline: a marked, checkable boundary
  between quotation and synthesis
- [Session capture](/meta/policy/session-capture.md) — the thread-doc
  machinery that makes the LLM-collaboration record durable and citable

## Documents

- [Project docs](/projects/human-writing-attribution/index.md)
