---
id: em:61e46a
type: concept
title: verification ladder
description: This brain's graduated path from asserted to evidence-backed knowledge — a statement type carries `verified: false` until captures supporting it are cited in `verified_by`, which flips it to `verified: true` and lets a grounded `claim` graduate to `concept`.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, verification, epistemics, governance, provenance]
sense: repo
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-29 repo-evaluation thread, and already cited as undefined by the belief (type) and scar tissue entries"
---

# verification ladder

The rungs are the controlled types that can hold it: a
[claim](/beliefs/glossary/statement-type.md) is asserted but unchecked, and a
`concept` is established — so grounding a claim through `verified_by` is what
lets it graduate. Only agent-authored statements (`claim`, `note`, `concept`)
may stand on the ladder at all; a document storing a `resource` is a **capture**,
which is trusted evidence rather than a verifiable assertion, and
`mix brain.verify` rejects a `verified` field on it. That restriction is what
keeps the ladder from being climbed by fiat: a statement cannot cite itself as
its own support.

Two things sit deliberately **off** the ladder. A
[belief (type)](/beliefs/glossary/belief-type.md) is a value-laden decision
prior, held true enough to act on where evidence cannot settle it — one that
turns out empirically checkable is refiled as a `claim`, and the type boundary
*is* the test. Governance documents carry no `em:` id and are outside the
identity registry entirely.

The ladder's rungs are machine-enforced while its *use* is not: nothing requires
a statement to climb, so a bundle can carry a fully-specified evidence model that
almost nothing has been grounded through.

*Seen in:* [verification-grounding policy](/meta/policy/verification-grounding.md), [2026-07-29 repo evaluation against the second-brain field](/meta/threads/2026-07-29-repo-evaluation-against-the-second-brain-field.md), [re-evaluated at 615 documents](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md)

*See also:* [verified_by](/beliefs/glossary/verified-by.md), [statement (type)](/beliefs/glossary/statement-type.md), [belief (type)](/beliefs/glossary/belief-type.md)
