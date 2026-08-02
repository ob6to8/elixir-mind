---
type: matter
title: "Sweep the todo-fold remnants in living surfaces"
description: The todo fold (PR #232) left "todos" and a /todo-skill reference in living text — README's namespace gloss and usage paragraph, the tutorials index gloss, the tooling-architecture SessionInit bullet, and two lines of the /create-pull-request skill — each reworded to matters per the fold's own vocabulary.
status: open
provenance: "Claude Fable 5, matters-redundancy research spike, 2026-08-02"
tags: [meta, matter, matters, todo-fold, staleness]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T19:06:00Z
  channel: agent-authored
  agent: "Claude Code agent, matters-redundancy research spike"
  why: "the redundancy survey found the fold's rename incomplete in living surfaces; filed per deferred-work-is-filed rather than fixed inside a scoping spike"
---

# Sweep the todo-fold remnants in living surfaces

The [todo fold](/meta/matters/todo-fold.md) retired `type: todo` and the
`/todo` skill, but five living surfaces still speak the old vocabulary
(enumerated at HEAD `6041ad1`; `lib/` and `test/` are already clean):

- `README.md:26` — the `meta/` namespace gloss lists "todos".
- `README.md:51–54` — the usage paragraph describes the digest as covering
  "todos" and points at a `/todo` skill that no longer exists.
- `meta/tutorials/index.md` — the session-init-digest entry's gloss says
  "issues, todos, active plans".
- `meta/tutorials/the-tooling-architecture.md` — the SessionInit bullet scans
  "open issues, todos, active plans".
- `.claude/skills/create-pull-request/SKILL.md:53,109` — the governance-doc
  inventory says "todos", and the handoff-context rule files into "the plan /
  todo / issue".

Reword each to matters ([living-text](/meta/policy/living-text-is-present-tense.md):
the living surface carries only what is). Mechanical — no decisions; record
layers (threads, historical plans, the todo-type glossary entry) stay as they
are. Independent of the
[retirement plan](/meta/plans/retire-priorities-and-session-init.md): these
fixes are correct whether or not it is accepted, and where the two touch the
same lines (README's usage paragraph, the tooling-architecture bullet) either
order lands clean.

**Done when** `grep -riE '\btodos?\b'` over `README.md`, `meta/tutorials/`,
and `.claude/skills/` returns only legitimate uses (the `/journal` skill's
description of journal content, historical records, and quoted material).
