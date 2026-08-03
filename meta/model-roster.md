---
type: reference
title: "Model roster — the available models and what each is sent"
description: The operator's roster of models available to this repo and the motion each is sent, serving as the run-time binding table that capability-matched-model-selection deliberately refuses to hardcode; read by /scope-unit-of-work when it stamps a matter's model, and edited by the operator as the model generation turns over.
provenance: "Claude Opus 5, scope-unit-of-work session — the tier assignments are operator preference data, held here to be edited rather than derived"
tags: [meta, models, delegation, orchestration, matters, preference]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work skill session"
  why: "/scope-unit-of-work must evaluate which model should deliver each matter, and the doctrine deliberately binds no model names — the roster is the instance layer that judgment reads"
  from: [/meta/threads/2026-08-02-scope-unit-of-work-skill-and-model-stamping.md, /meta/threads/2026-08-02-skill-body-layout-ab-and-section-vocabulary.md]
---

# Model roster

The **operator's preference data**: which models this repo may spend, and what
each is sent. This is the instance layer beneath
[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md),
which states the direction — *"Match the model tier to the epistemic weight of
the motion, not to habit or availability"* — and deliberately declines to name
models, because *"the mapping goes stale with every model generation, while the
principle … survives them all"*. That doctrine tells an agent to *"[apply] the
direction against whatever tiers exist at run time"*; this file is what "exist
at run time" resolves to.

It is **authored, not derived**. The operator edits it; an agent proposes
changes and waits, exactly as with any shape change. Nothing regenerates it.

## The roster

Models available to this repo are Anthropic's. The **Send here** column is the
operator's standing preference, not a claim about the models' relative
capability.

| Model | Value for `model:` | Send here | Not here |
|---|---|---|---|
| Fable 5 | `Claude Fable 5` | Canonical prose where the writing *is* the artifact — policy and doctrine text, analyses, plan decision sections, contract-facing revisions | Mechanical sweeps; work an oracle already checks |
| Opus 5 | `Claude Opus 5` | Judgment with no oracle behind it — design decisions, verification verdicts, taxonomy calls, tooling changes to `lib/` where a wrong shape propagates | Bulk extraction; index upkeep |
| Sonnet 5 | `Claude Sonnet 5` | Well-specified execution against a decided shape — a matter whose packet leaves no decisions, gated by `mix brain.verify`/the suite | Anything whose approach is still open at delivery |
| Haiku 4.5 | `Claude Haiku 4.5` | High-volume, low-stakes-per-item passes — candidate sweeps, format transforms, listing regeneration | Canonical bodies; any judgment call |

**Governance-prose edits — skills, indexes, glosses, registers — are Sonnet
work by default.** A `SKILL.md` body, an `index.md` gloss, a register row: prose
on a governance surface, read to act rather than to establish a truth.
**Policies and doctrine are not in this row** — they are canonical bodies that
compile into the contract and stay Fable's, however small the edit. It fits
none of the four rows cleanly — it is not a canonical body (Fable), carries no
open decision (Opus), is not bulk (Haiku), and no oracle checks its content, so
Sonnet's "gated by `mix brain.verify`/the suite" qualifier does not literally
apply either. Send it to **Sonnet 5** anyway: the failure mode is visible on
sight and cheap to correct, which is the property that actually distinguishes
the delegable tiers.

**The boundary that makes this row usable:** if the edit's *content* is a fresh
decision rather than the rendering of one already made, it is the decision, not
the prose — stamp it by the decision's weight. Writing a policy that states an
already-ratified rule is governance prose; choosing what the rule should say is
a taxonomy call. The same edit can be either, and which one it is depends on
what the packet leaves open.

**Effort level is the second lever, and it is orthogonal.** Per
[effort level](/beliefs/glossary/effort-level.md), model choice is *which*
reasoner; effort is *how hard* that reasoner thinks. A matter that is hard but
well-specified is often a lower tier at high effort, not a higher tier. The
roster stamps the model; effort stays a runtime choice.

## How a matter's model is determined

The determination runs per matter — not per plan — because a plan's steps
rarely share one epistemic weight. Ask what the delivering session actually
does:

1. **Does the output become canonical?** A policy, doctrine, concept body, or
   plan's decisions become the source others derive from → top of the roster.
2. **Is a judgment rendered with no oracle behind it?** Design trade-offs,
   routing calls, verdicts → top of the roster.
3. **Would a mistake be caught mechanically?** A gate, a verifier, or the test
   suite bears the correctness burden → delegate down.
4. **Is the motion derivational or bulk?** Re-rendering a view, index upkeep,
   a format sweep → delegate down; a wrong derivation is re-derived.

A matter that splits across these (a decision *plus* its mechanical execution)
is usually two matters, per
[atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md); when it is
genuinely one intent, stamp the weight of its **hardest** motion.

## `model:` vs `provenance` — prospective vs retrospective

Two fields name a model, in opposite tenses, and conflating them corrupts both:

- **`model:` on a matter doc is prospective** — the roster's recommendation for
  the session that will *deliver* the matter. It is advisory: a delivering
  session may run a different model, and the stamp is the recommendation it
  departed from.
- **`provenance` is retrospective** — the model that *produced the document*,
  per [model-attribution](/meta/policy/model-attribution.md). On a matter doc
  scoped by an agent, `provenance` names the scoping model and `model:` names
  the recommended delivering one; they routinely differ, and both are correct.

## Maintenance

- **The operator edits this file.** Model generations turn over; a roster row
  goes stale the day a model is retired or added. An agent that notices drift
  proposes the edit and waits.
- **A missing model is stated, never guessed.** A matter whose weight the
  scoping session cannot determine carries `model: undetermined` with the
  reason in its body — omission would be indistinguishable from an unremarkable
  matter, the failure [model-attribution](/meta/policy/model-attribution.md)
  names for its own field.
