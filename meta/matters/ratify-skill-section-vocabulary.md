---
type: matter
title: "Ratify the skill section vocabulary as a terse policy"
description: Write the operator-ratified SKILL.md heading vocabulary as a short policy under meta/policy/ — required Purpose, one of Dispatch/Procedure, Guardrails; Rules and Notes retired; an optional tier that is documented and unenforced — and recompile the contract.
status: open
model: Claude Fable 5
plan: /meta/plans/skill-section-vocabulary.md
order: 1
provenance: "Claude Opus 5, scope-unit-of-work form-evaluation session"
tags: [meta, matter, skills, policy, vocabulary, contract]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work form-evaluation session"
  why: "operator ratified the vocabulary, the ## Purpose heading, and the required-set-only gate scope; the rule needs a canonical home before the migration or the checker can cite it"
---

# Ratify the skill section vocabulary

Write `meta/policy/skill-section-vocabulary.md` stating the vocabulary fixed in
[the plan](/meta/plans/skill-section-vocabulary.md), then recompile the contract
(`mix brain.contract`, or [`/render-contract`](/.claude/skills/render-contract/SKILL.md)).

**The rule to state**, and nothing beyond it:

- **Required:** `## Purpose`; exactly one of `## Dispatch` / `## Procedure`;
  `## Guardrails`.
- **Retired synonyms:** `Rules` and `Notes` both mean `Guardrails`.
- **Optional, documented, unenforced:** `When to use` · `Input` ·
  `Where it writes` · `Output structure` · `See also`.
- **Free:** unrecognized H2s are permitted — operation sections under
  `Dispatch` are named by their verb.

**Decisions already made** (do not re-litigate):

- `## Purpose`, not `INSTRUCTION`; `Input`, not `SIGNATURE`; Title Case, not
  ALL-CAPS — all three per
  [prefer-established-terminology](/meta/policy/prefer-established-terminology.md).
- The optional tier is **not** gated: whether a skill needs a `See also` is a
  semantic judgment, and the bundle's own closed-core-plus-extra-keys
  frontmatter is the precedent.
- Enforcement is a gate, not contract prose
  ([elixir-coding-standards](/meta/policy/elixir-coding-standards.md)), so this
  policy states the vocabulary and stops. It compiles into `CLAUDE.md`, where
  [size is a filed concern](/meta/matters/contract-size-counterweight.md) —
  terseness is load-bearing, and the reasoning belongs in the plan and
  [the eval](/meta/evals/skill-body-layout-ab.md), not here.

**In the same commit:** drop the interim paragraph now at the end of
[skills-registry](/meta/policy/skills-registry.md) ("A skill body's section
structure is convention, not yet a rule…") — it exists only until this policy
lands, and leaving it would be a second, staler statement of the same rule.

**Open question:** the policy's `section:`/`order:` frontmatter, which sets its
place in the compiled contract. Recommend the `skills` section immediately after
`skills-registry`; confirm against `lib/elixir_mind/contract.ex`.

**Verify:** `mix brain.contract --check` and `mix brain.verify`.

## Model

`Claude Fable 5` — canonical policy prose that compiles into the contract and
becomes the source every future skill author derives from; the output *is* the
artifact, which is the roster's Fable row. Three of four independent scopings of
this unit stamped Fable; the dissent read it as a boundary decision the other
matters bind to and stamped Opus. Both are defensible, and that ambiguity is
itself filed as
[an issue](/meta/issues/model-determination-is-session-dependent.md) — the
majority is recorded here rather than one session's reading.
