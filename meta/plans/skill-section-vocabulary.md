---
type: plan
title: "Skill section vocabulary: ratify the headings the corpus already converged on, then gate the required set"
description: Promote the emergent SKILL.md heading vocabulary to a ratified convention — a required core of Purpose, one of Dispatch/Procedure, and Guardrails, with Rules and Notes retired as synonyms and a documented-but-unenforced optional tier — then migrate the 18 skills and gate the required set with a fence-aware checker.
status: accepted
provenance: "Claude Opus 5, scope-unit-of-work form-evaluation session"
tags: [meta, plan, skills, vocabulary, gates, tooling, elixir, convention]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work form-evaluation session"
  why: "the operator ratified all three decisions — adopt the sectioned convention, add ## Purpose, gate the required set and synonym ban only — after an A/B eval found no behavioral difference between layouts, moving the case onto maintainability"
  from: [/meta/threads/2026-08-02-skill-body-layout-ab-and-section-vocabulary.md]
---

# Skill section vocabulary

## Problem

Eighteen skills use roughly thirty distinct H2 strings for a handful of
recurring jobs, and nothing governs the choice:
[skills-registry](/meta/policy/skills-registry.md) says which skills exist and
where a new one goes, and
[policy-canonical-skill-guidance](/meta/plans/policy-canonical-skill-guidance.md)
says which *content* belongs in a skill rather than a policy — neither
constrains arrangement.

The corpus converged anyway. `Guardrails` appears in 15 of 18 skills,
`Procedure` in 10, `Dispatch` in 7 — and the remaining three skills all carry a
trailing constraints block under a *different name* (`Rules` ×2, `Notes` ×1). So
every skill already has the slot; three spell it differently, and no reader or
tool can rely on it.

**The convention is adopted on maintainability grounds, and that is a measured
claim rather than an assumed one.** The
[skill body layout A/B](/meta/evals/skill-body-layout-ab.md) ran two layouts of
one skill with the rule-set held constant across four scoping specs at two runs
each: 71/71 assertions for both, no behavioral difference, token delta inside
noise. Sectioning does not make an agent perform better. It makes the corpus
checkable, and that is the whole case.

## The vocabulary

```
REQUIRED — enforced
  ## Purpose                     what the skill does (today unheaded in 18/18)
  ## Dispatch  XOR  ## Procedure
       Dispatch  → sub-commands; each operation gets its own H2
       Procedure → single flow; steps are ### beneath it
  ## Guardrails                  the constraints block

OPTIONAL — documented vocabulary, NOT enforced
  ## When to use · ## Input · ## Where it writes · ## Output structure · ## See also

FREE — unrecognized H2s permitted
  operation sections under Dispatch, named by their verb (List, Create, Consume, …)

RETIRED — rejected by the gate
  Rules → Guardrails      Notes → Guardrails
```

**Why the optional tier is documented but unenforced.** Whether a skill *needs*
a `See also` is a semantic judgment, not a structural fact a checker can decide,
and the bundle already has the right precedent: frontmatter has a closed
required core and permits arbitrary extra keys. The gate binds the core and the
synonym ban; everything else is vocabulary a author reaches for, not a
constraint. Enforcing more would convert a naming aid into a straitjacket over
18 skills whose content legitimately differs.

## Current state → desired state

```diff
  every SKILL.md
+   ## Purpose                    # the lede, currently unheaded in all 18
    ## Dispatch | ## Procedure    # 17/18 already conform; capture is the exception
    …operation or step sections…
~   ## Guardrails                 # 15 conform; capture/render-contract say Rules, priorities says Notes
    ## See also                   # optional, unchanged
```

Per-skill work:

| Skill | Change |
|---|---|
| all 18 | add `## Purpose` over the existing lede prose (no rewriting) |
| `capture` | `Rules` → `Guardrails`; `Build the doc, in this order` → `Procedure` |
| `render-contract` | `Rules` → `Guardrails` |
| `priorities` | `Notes` → `Guardrails` |
| `scope-unit-of-work` | six numbered top-level `##` steps → `###` beneath one `## Procedure` |

## File-tree diff

```
meta/policy/skill-section-vocabulary.md        # NEW — the ratified rule, terse; compiles into CLAUDE.md
meta/policy/skills-registry.md                 # MODIFIED — drop the interim "convention, not yet a rule" note
CLAUDE.md                                      # MODIFIED — regenerated (rides its policy change)
.claude/skills/*/SKILL.md                      # MODIFIED — 18 files; Purpose everywhere, 4 structural fixes
lib/elixir_mind/skill_sections.ex              # NEW — the fence-aware parser + conformance rules
lib/mix/tasks/brain.skill_sections.ex          # NEW — the gate task
test/elixir_mind/skill_sections_test.exs       # NEW — fence hazard, synonym rejection, XOR, missing-required
.github/workflows/*.yml                        # MODIFIED — join the gate suite
meta/code-map.md                               # MODIFIED — regenerated from the new moduledocs
```

## Signatures

```elixir
@type finding :: {:missing_required, Path.t(), String.t()}
              | {:retired_synonym, Path.t(), String.t(), replacement :: String.t()}
              | {:shape_conflict, Path.t()}      # both Dispatch and Procedure, or neither

@spec headings(source :: binary()) :: [binary()]
@spec check(path :: Path.t()) :: [finding()]
@spec check_all(root :: Path.t()) :: [finding()]
```

`headings/1` is the load-bearing one: it must strip fenced regions before
scanning. `capture/SKILL.md` carries two heading-like lines inside code fences —
`## Routing` and `# pr: <N>` in a fenced frontmatter example — and a naive
`^#{1,6} ` scan misreads both. Two independent eval runs caught this hazard
where the author's own grep did not, twice.

## Boundary decisions

- **The rule is a policy, the enforcement is a gate.**
  [elixir-coding-standards](/meta/policy/elixir-coding-standards.md) routes any
  standard with a mechanical oracle to a gate; this one has an oracle, so the
  policy states the vocabulary tersely and the checker owns conformance. The
  policy text stays short because it compiles into `CLAUDE.md` and
  [contract size is already a filed concern](/meta/matters/contract-size-counterweight.md).
- **The parser owns fence-stripping**, not the caller — every future consumer of
  a skill's headings inherits the fix.
- **Migration lands before the gate**, so the gate joins CI already green
  (the `mix xref --fail-above 0` precedent) rather than as a warn-then-escalate
  stage. Building the checker first would fail its own matter's CI run against
  the not-yet-migrated corpus.

## The sequence

| Order | Matter | Intent |
|---|---|---|
| 1 | [Ratify the skill section vocabulary](/meta/matters/ratify-skill-section-vocabulary.md) | write the terse policy, recompile the contract |
| 2 | [Migrate the skills onto the section vocabulary](/meta/matters/migrate-skills-onto-section-vocabulary.md) | apply `## Purpose` ×18 and the four structural fixes |
| 3 | [Gate skill section conformance](/meta/matters/gate-skill-section-conformance.md) | fence-aware checker, tests, join the gate suite |

## Decisions

- **Recommended shape:** required core of three, unenforced optional tier of
  five, synonyms retired, unrecognized headings permitted. Operator-ratified in
  the originating session.
- **`## Purpose`, not `## INSTRUCTION`.** The whole file is instructions, so
  `INSTRUCTION` names the document rather than the section; `Purpose` is the
  established term
  ([prefer-established-terminology](/meta/policy/prefer-established-terminology.md)).
  Same reason `Input` beats `SIGNATURE`, which means a type everywhere else.
- **Title Case, not ALL-CAPS.** Markdown headings already render salient, and the
  caps register pushes toward the rigidity Anthropic's own skill-authoring
  guidance flags.
- **Rejected — enforcing the optional tier.** Considered and declined: it would
  bind a semantic judgment with a structural check.
- **Rejected — gate first, migrate second.** Ships a red CI stage or a
  warn-then-escalate dance the green-boundary rule makes unnecessary.
- **Open question for matter 1:** the new policy's `section:`/`order:`
  frontmatter placement within the contract's compiled ordering. Recommend the
  `skills` section immediately after `skills-registry`; confirm against
  `contract.ex` at delivery.
- **Open question for matter 3:** whether the checker should also *warn* on an
  unrecognized H2. Recommend silence — the free tier is deliberate, and a warn
  channel that fires on legitimate content trains readers to ignore it.
- **Model stamps carry a known caveat.** Matters 1 and 3 sit on the exact
  boundary that
  [the session-dependent determination issue](/meta/issues/model-determination-is-session-dependent.md)
  documents; each stamp here is the majority of four independent scopings, not a
  single session's call, and the dissent is recorded in each matter's `## Model`.
