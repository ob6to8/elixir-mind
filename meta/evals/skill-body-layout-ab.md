---
type: reference
title: "Skill body layout A/B — does sectioning a SKILL.md change what an agent produces?"
description: A run instrument comparing two layouts of one skill with its rule-set held byte-identical — running prose with numbered top-level steps versus labeled sections — across four scoping specs at two runs each; the 2026-08-02 execution returned 71/71 assertions for both layouts, a null result that moved the house-convention question onto maintainability grounds and surfaced a session-dependent `model:` stamp as a side effect.
provenance: "Claude Opus 5, scope-unit-of-work form-evaluation session — instrument designed, run, and graded in one session; the eight runs were Claude Sonnet 5 subagents"
tags: [meta, eval, skills, prompt-format, agent-behavior, models, roster, ab-test]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work form-evaluation session"
  why: "the operator asked whether a labeled-section rewrite of a skill body would be more effective than the prose original, and no published measurement isolates skill-body layout — so the question was answerable only by building the instrument"
  from: [/meta/threads/2026-08-02-skill-body-layout-ab-and-section-vocabulary.md]
---

# Skill body layout A/B

## The question

Does the **arrangement** of a `SKILL.md` body change what an agent does with it,
holding the rules constant? Specifically: running prose with numbered top-level
steps (the repo's incumbent form) against labeled sections that aggregate every
rule of a kind under one heading.

This matters because the answer decides whether a house section vocabulary is a
**performance** intervention or a **maintainability** one — and those justify
very different amounts of migration cost across the skills.

## Why an eval and not a gate

[elixir-coding-standards](/meta/policy/elixir-coding-standards.md) routes any
standard with a mechanical oracle to a gate. "Which layout works better" has no
oracle: it is a property of agent behavior, not of the repo. The *conformance*
question downstream of it does have one, which is why this eval's finding feeds
a gate while the eval itself stays an instrument.

## What governs skill design — the gap this eval was run into

No policy or doctrine governs a skill body's **structure**. Searched:
every `meta/policy/*.md` and `meta/doctrine/*.md` for skill/heading/section
rules, plus a full read of the registry policy. What exists is adjacent:

| Doc | Governs | Not |
|---|---|---|
| [skills-registry](/meta/policy/skills-registry.md) | which skills exist, where a new one is added; compiled into the contract | anything about a body's arrangement |
| [policy-canonical-skill-guidance](/meta/plans/policy-canonical-skill-guidance.md) (accepted) | *which content* belongs in a skill vs. a policy — rules canonical in `meta/policy/`, quoted into skills | how that content is laid out |
| [compile-skills-registry-from-skill-frontmatter](/meta/plans/compile-skills-registry-from-skill-frontmatter.md) | a skill's *identity* (`name`/`description`) as canonical, compiled into the contract | the body beneath it |
| [fit each layer to its purpose](/meta/doctrine/fit-each-layer-to-its-purpose.md) | the standing direction a skill body serves — read to act, so fit to acting | a structural rule |
| [elixir-coding-standards](/meta/policy/elixir-coding-standards.md) | the gate-vs-editorial admission rule any resulting check must clear | skills specifically |

So the corpus converged on a vocabulary with nothing enforcing it — `Guardrails`
in 15 of 18 skills, `Procedure` in 10, `Dispatch` in 7, with `Rules` and `Notes`
as unratified synonyms for the first. That is the gap the eval was run to size.

## Method

**Treatment.** Two layouts of [`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md),
pinned in this directory:

- `variant-a.skill.txt` — the skill as it stood at `075dc82`: prose lede,
  `## Dispatch`, six numbered top-level steps, `## Guardrails`.
- `variant-b.skill.txt` — the same rule-set under labeled sections
  (`INSTRUCTION` · `ARGUMENTS` · `DISPATCH` · `DELIVERABLES` · `ARTIFACTS` ·
  `PROCEDURE` · `REMEMBER`).

**Content is held constant, deliberately.** No rule is added or removed between
them, and wording is carried over verbatim wherever the arrangement allows.
Duplicate *statements* of one rule collapse to a single instance in B, because
aggregation inherently dedups — that collapse **is** the treatment, not a
content change. Both variants carry byte-identical frontmatter, so triggering is
held constant and only the body varies. Improvements the author wanted to make
(an `order`-vs-`sequence` disambiguation) were withheld from B so they could not
contaminate the comparison.

**Runners.** Eight `general-purpose` subagents, one per (spec × variant), each in
its own git worktree, unattended, forbidden to commit or push, instructed to
follow the variant file and not to read the repo's own copy of the skill.

**Model: Claude Sonnet 5 for all eight**, not the session's Opus. Per
[debugging agent harnesses on weak models](/knowledge/SWE/evals/debugging-agent-harnesses-on-weak-models.md),
a frontier model silently works around harness defects a weaker model fails on
immediately, so the weaker model is the sensitive instrument for a layout
question. A tie at Opus would have been uninformative; a tie at Sonnet is
evidence.

**Specs.** Four, chosen to exercise different branches of the skill:

| Eval | Spec | Discriminates |
|---|---|---|
| 1 single-matter | one decided intent (`/plan show <slug>`) | avoids manufacturing a plan; no `plan`/`order` keys |
| 2 plan-shaped | three separable intents (a skill heading vocabulary) | plan + ordered matters; register untouched without `sequence` |
| 3 sequence | eval 2's spec, invoked `sequence` | head insertion, ascending order, four-cell rows |
| 4 collision | a spec already covered by an open matter | extends rather than duplicates |

**Scoring.** `grade.py` in this directory, run over the copied output files
rather than the agents' self-reports wherever a file can show the fact.
Assertions: frontmatter completeness, `type: matter`, `model:` within the
roster's value set, `## Model` section present, no `em:` id minted,
`status: open`, per-eval shape rules, and — for eval 3 — the register's insert
point and exact cell count parsed from the copied register.

## Results — 2026-08-02

**71/71 for both variants.** No assertion separated them.

| Eval | variant A | variant B |
|---|---|---|
| 1 single-matter | 10/10 | 10/10 |
| 2 plan-shaped | 28/28 | 28/28 |
| 3 sequence | 30/30 | 30/30 |
| 4 collision | 3/3 | 3/3 |

Both `sequence` runs inserted at the **head** and renumbered the existing 16
rows to 4–19, correctly applying
[revision-enters-through-scoping](/meta/policy/revision-enters-through-scoping.md),
which had merged to `main` hours earlier and appears in neither variant's
authorship history. Both collision runs found the existing matter and filed
nothing.

Cost, the only efficiency measure worth reading here:

| Eval | A tokens | B tokens | Δ |
|---|---|---|---|
| 1 single-matter | 175,332 | 191,346 | +9.1% |
| 2 plan-shaped | 306,682 | 294,301 | −4.0% |
| 3 sequence | 378,218 | 293,725 | −22.3% |
| 4 collision | 193,821 | 179,629 | −7.3% |
| **total** | **1,054,053** | **959,001** | **−9.0%** |

B is cheaper in three of four and the total reads as a 9% saving, but the
per-eval spread runs +9.1% to −22.3% and a sign test on 3-of-4 gives p ≈ 0.31.
**Not an effect.** Wall-clock favored B by 14% and is unusable: all eight runs
contended for one capped scheduler, so elapsed time measures queueing.

## Findings

**1. Null result on layout.** At this scale, with rules held constant, body
arrangement did not change what a Sonnet-tier agent produced. The house-vocabulary
decision therefore rests on maintainability, not performance — and any future
claim that a layout "reads better to the model" owes evidence this instrument can
produce.

**2. The `model:` stamp is session-dependent.** Four runs scoped the identical
unit into ratify → migrate → gate and agreed 4/4 on the mechanical matter while
splitting 3–1 on both judgment-weighted ones, each citing repo precedent. Filed
as [an issue](/meta/issues/model-determination-is-session-dependent.md); a single
scoping run could not have surfaced it, which is the argument for running specs
in replicate even when the headline comparison ties.

**3. Two runs out-measured the eval's own author** on the fenced-heading hazard:
`capture/SKILL.md` carries two heading-like lines inside code fences (`## Routing`,
and `# pr: <N>` in a fenced frontmatter example). The author's ad-hoc `grep '^## '`
counted the first as a real section and structurally could not see the second. Any
heading checker must be fence-aware.

**4. Independent convergence on the vocabulary.** Three runs surveyed all 18
skills unprompted and derived substantially the enum the author had derived
separately — required `Guardrails` plus one of `Procedure`/`Dispatch`, synonyms
collapsed. They diverged on how much a gate should *bind*, with the
better-reasoned position being that the optional tier stays documented vocabulary
and only the required set plus the synonym ban is enforced — mirroring the
bundle's own closed-core-plus-extra-keys frontmatter shape.

## Re-running

```
python3 meta/evals/skill-body-layout-ab/grade.py     # scores an iteration directory
```

The grader expects `iteration-<N>/<eval>/<variant>/{run.json,outputs/}` beside
itself and writes `grading.json`. To re-run the whole instrument, spawn the eight
worktree-isolated subagents against the two pinned variant files with the four
specs above, have each copy its created/modified files into its output directory,
then grade. `runs.json` holds the 2026-08-02 execution's per-run records and
timing verbatim; `grading.json` holds its assertion-level results.

**Timing data is capturable only once.** Token and duration figures arrive in the
subagent completion notification and are persisted nowhere else — write them down
as each run lands or they are gone.

## Scope of the finding

**The labels tested are not the labels adopted.** Variant B used
`INSTRUCTION` · `ARGUMENTS` · `DELIVERABLES` · `ARTIFACTS` · `REMEMBER`; the
convention ratified from this result uses `Purpose` · `Dispatch`/`Procedure` ·
`Guardrails`
([skill-section-vocabulary](/meta/plans/skill-section-vocabulary.md)). What was
measured is *sectioned versus prose*, not those particular strings, and the
null result is only claimed at that grain. A reader should not cite this eval
as evidence for the specific vocabulary — the vocabulary was chosen from corpus
convergence, and the eval's contribution was to remove the performance argument
from the decision, not to supply one.

Four specs, one skill, one model tier, one roster revision, two runs per cell. The
null result is a null result *at this power*: two runs per cell cannot detect a
small effect, and nothing here establishes that layout never matters — only that
it did not matter enough to move any of 71 assertions on this skill. A larger
finding would need more replicates, a weaker model, or a skill whose body is long
enough that retrieval within it is plausibly the bottleneck.
