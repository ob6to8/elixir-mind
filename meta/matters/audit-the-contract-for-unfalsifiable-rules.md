---
type: matter
title: "Audit the contract for unfalsifiable rules and accreted bulk"
description: Classify every rule in the compiled contract by whether a gate enforces it, an oracle could, or nothing does — then report which rules are unfalsifiable prose, which duplicate each other, and which were plausibly added because adding was cheap, so the operator can decide what to cut.
status: open
model: "Claude Opus 5"
provenance: "Claude Opus 5, /intake session on Anthropic's context-engineering post"
tags: [meta, matter, contract, governance, audit, instruction-conflict, context-engineering]
timestamp: 2026-08-05
attribution:
  when: 2026-08-05T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator /intake session on Anthropic's context-engineering post"
  why: "operator directed a matter be filed to audit the contract, after the intake established that an instruction layer with no oracle accretes and that its bulk cannot be assessed by trimming and watching for breakage"
  from: [/meta/threads/2026-08-05-anthropic-context-engineering-intake-and-instruction-conflict.md]
---

# Audit the contract for unfalsifiable rules and accreted bulk

## Why

[Instruction conflict has no mechanical oracle](/knowledge/SWE/agentic/governance/instruction-conflict-has-no-mechanical-oracle.md)
(`em:ed8315`) argues that a shared instruction artifact accretes for structural
reasons: its claims cannot be settled empirically, so disputes resolve by
standing; additions meet no resistance while deletions meet a person; and no
eval attributes outcomes to individual rules. Anthropic's own contract-shaped
artifact turned out to be **over 80% removable** once someone looked.

This bundle's contract is the same shape — compiled from many
independently-authored policy documents, loaded in full every session, growing
by ratification with no deletion pressure. The argument predicts it carries
bulk. The audit is what turns that prediction into a finding the operator can
act on.

**The trap this matter must avoid** is the one the claim doc names: trimming
the contract and observing that nothing breaks is *uninformative*, because
nothing was measuring the trimmed rule. The audit therefore classifies rules by
their **enforcement basis**, not by testing their removal.

## What to produce

A `type: analysis` under [`meta/analysis/`](/meta/analysis/index.md)
classifying every rule in `CLAUDE.md` into one of four bands:

| Band | Meaning |
|---|---|
| **Gated** | a check in the gate suite fails when it is violated — name the check |
| **Gateable** | a mechanical oracle exists or could be written, but none runs today |
| **Editorial** | no oracle is possible; the rule binds judgment and is held in review |
| **Inert** | no oracle, and no plausible mechanism by which it changes agent behavior |

The fourth band is the point. A rule that cannot be enforced and cannot be
shown to shift behavior is the contract's equivalent of the 80%.

Alongside the classification, report:

- **Duplicate pairs** — rules stated in more than one policy, per the post's
  repetition-to-concision shift.
- **Contradiction candidates** — rules that a reasonable agent could read as
  conflicting. This has no oracle either, so the finding is a list for the
  operator, never an assertion of defect.
- **Provenance skew** — whether rules cluster by the session that added them,
  which is the accretion signature.
- **Size accounting** — the contract's line count by policy, so the cost of
  each rule is visible beside its band.

## Boundary against the size counterweight

[Contract-size counterweight](/meta/matters/contract-size-counterweight.md)
covers the **quantitative** axis — a warn-only per-policy word-count trend, and
relocating prose out of the five longest policies into the tutorial layer. This
matter covers the **enforcement** axis: not how many words a rule costs, but
whether anything makes it bind.

They are complementary and neither subsumes the other — a short rule can be
inert and a long one gated. Deliver whichever comes second reading the first's
output; if both are open when either is picked up, say so rather than merging
them, since they are separately approvable
([atomic pull requests](/meta/policy/git-atomic-pull-requests.md)).

## Boundaries

- **Classify and report; cut nothing.** Removing a policy is a shape change
  under [taxonomy-evolution-protocol](/meta/policy/taxonomy-evolution-protocol.md)
  and belongs to the operator. The deliverable is the analysis; any cuts are
  separate matters emitted from its findings.
- **The `inert` verdict is a claim, not a measurement.** Nothing here can prove
  a rule has no effect. Each `inert` classification states the reasoning that
  places it there, so the operator can disagree per-rule.
- Read the contract as compiled *and* the sources under
  [`meta/policy/`](/meta/policy/index.md) — a rule's band may depend on text
  the compilation drops.

## Model

**Claude Opus 5.** Per
[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md)
and [the roster](/meta/model-roster.md), this is judgment with no oracle behind
it: every band assignment is a determination the repo cannot check, and a wrong
classification propagates into whatever cuts follow. The roster sends
contract-facing *prose* to Fable 5, but the artifact here is a classification
whose value is the judgment rather than the writing.
