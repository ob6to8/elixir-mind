---
id: em:4a590f
type: concept
title: concept (type)
description: Controlled type for a definition or mental model — in practice two speech acts sharing a name (term definition vs accepted proposition), a tension whose ratified resolution narrows it to definitions alone and takes its verification flag away.
provenance: "Agent-distilled glossary definition, pointer to the defining policy"
verified: false
tags: [glossary, types, vocabulary]
sense: repo
timestamp: 2026-08-01
attribution:
  when: 2026-07-15T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced while replicating the concept/document terminology split from PR 71"
---

# concept (type)

The controlled `type` for "a definition or mental model (established/accepted)",
defined by the
[controlled-type-vocabulary policy](/meta/policy/controlled-type-vocabulary.md).
It is one of the three [statement types](/beliefs/glossary/statement-type.md)
(`claim`/`note`/`concept`) that may carry a `verified` field, and the graduation
target a grounded [claim](/beliefs/glossary/statement-type.md) may reach.

In practice the type is **two speech acts under one name**: *term definition*
(what the glossary machinery mass-produces — one per term, source-independent,
almost always unverified) and *accepted proposition* (the graduation target of a
verified claim). The parenthetical "(established/accepted)" is enforced by
nothing and false for ~98% of the corpus. The
[concept-terminology plan](/meta/plans/concept-terminology-and-type-redefinition.md)
records both that tension and the ruling that settles it (ratified 2026-08-01,
execution pending): types become pure content-kinds, so this one keeps only the
defining sense, sheds the parenthetical and the graduation path, and — being
not [truth-apt](/beliefs/glossary/truth-apt.md) — stops being eligible for
`verified` at all, leaving `claim` and `note` as the propositional pair.
Distinct from [document (OKF)](/beliefs/glossary/document-okf.md), the *unit* the
OKF spec calls a "concept document" (any frontmatter-plus-body file, regardless
of type).

*Seen in:* [2026-07-15 concept→document replication thread](/meta/threads/2026-07-15-replicate-concept-document-terminology-from-pr-71.md), [concept-terminology plan](/meta/plans/concept-terminology-and-type-redefinition.md), [2026-08-01 schema-formalization thread](/meta/threads/2026-08-01-schema-formalization-and-span-attribution-plans.md)
