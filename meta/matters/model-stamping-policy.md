---
type: matter
title: "The model-stamping policy"
description: Absorb the model-stamping rule — every matter carries a `model:` from the roster, the determination lives in a `## Model` body section, prospective stamp versus retrospective provenance, undetermined is stated not guessed — into one terse policy, deleting the three existing copies rather than adding a fourth.
status: open
model: Claude Fable 5
plan: /meta/plans/separate-the-model-roster-concerns.md
order: 2
provenance: "Claude Opus 5, scope-unit-of-work session"
tags: [meta, matter, models, policy, contract, deduplication]
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work skill session"
  why: "order 2 of the roster-separation plan — the rule half of the split, written as an absorption so the split does not leave four copies"
timestamp: 2026-08-02
---

# The model-stamping policy

The stamping rule currently exists in four places: the
[roster document](/meta/model-roster.md), the `matter` entry of
[controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md), and
both [`/matter`](/.claude/skills/matter/SKILL.md) and
[`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md). Give it
one home.

**Deliver a single terse policy** — target ~120 words of rule text — stating:

- every matter doc carries `model:`, valued from the configured roster;
- the determination lives in a `## Model` body section, not in frontmatter;
- `model:` is **prospective and advisory** (who should deliver);
  `provenance` is **retrospective** (who wrote the doc) — they routinely differ
  and both are correct;
- `model: undetermined` is stated with its reason, never guessed.

**Then delete the copies in the same commit** — the type-vocabulary paragraph
shrinks to a link, and each skill quotes the policy with a `canonical:` marker
per the
[policy-canonical-skill-guidance plan](/meta/plans/policy-canonical-skill-guidance.md).
A policy that lands beside its duplicates has made the problem worse, so
deletion is not a follow-up; it is the matter.

**Keep it terse deliberately.** The contract loads in full every session and the
[contract-size counterweight](/meta/matters/contract-size-counterweight.md) is
open on exactly this pressure. Rule text here; reasoning, worked examples, and
the tier guidance stay in
[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md),
which this policy implements and does not restate.

**Settled before delivery:** this is a **new policy**, not an expansion of the
`matter` type-vocabulary entry. The rule governs `## Model` body structure and
the prospective/retrospective attribution boundary, neither of which is a fact
about the `matter` type; the type entry shrinks to a link.

**Watch:** [settle model-attribution](/meta/matters/settle-model-attribution.md)
(queued row 6) may retract or fold
[model-attribution](/meta/policy/model-attribution.md); if it lands first, the
prospective/retrospective clause is written against whatever survives.

**Verify:** `mix brain.contract` (recompile), `mix brain.verify`, and a grep
confirming exactly one statement of the rule remains.

## Model

`Claude Fable 5` — contract-facing canonical prose whose whole difficulty is
compression: four existing statements collapse into one that must lose nothing
load-bearing while getting shorter, in a document every future session loads.
The output *is* the artifact, and no oracle checks whether the absorption
dropped something.
