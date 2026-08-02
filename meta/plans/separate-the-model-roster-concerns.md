---
type: plan
title: "Separate the model roster's concerns: settings, rule, and judgment"
description: The roster is three artifacts wearing one type — an enumerated settings table, a determination procedure, and schema rules already triplicated into the contract and two skills — so extract the settings to a repo config surface, absorb the rules into one terse policy, and leave the standing direction with the existing doctrine.
status: accepted
provenance: "Claude Opus 5, scope-unit-of-work session"
tags: [meta, plan, models, config, policy, separation-of-concerns, matters]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work skill session"
  why: "operator asked whether the model settings belong in repo config rather than a reference OKF document, and whether the remainder is a policy"
  from: [/meta/threads/2026-08-02-scope-unit-of-work-skill-and-model-stamping.md]
---

# Separate the model roster's concerns

## Problem

[`meta/model-roster.md`](/meta/model-roster.md) was filed as one document one
session ago. It holds four distinguishable things:

| Concern | What it is | Read by |
|---|---|---|
| The enumerated models and their `model:` values | data — a controlled vocabulary | nothing mechanical |
| Which motion each model is sent | operator preference/judgment | an agent, at scoping time |
| The four-question determination procedure | a repeatable how-to | an agent, at scoping time |
| `model:` vs `provenance`; undetermined-is-stated | rules about the frontmatter schema | an agent, everywhere |

Three consequences follow, and each is a defect on its own terms.

**The type is a misfit.** `reference` is defined in the contract as *"external
material you have **captured and summarized** (article, doc, video, thread)"*.
The roster is authored here and captures nothing. The bundle has precedent for
registers reusing `type: reference`
([`meta/matters.md`](/meta/matters.md), the `inbox/` digests), so this is a
systemic looseness rather than a unique error — but the roster is the case where
a better home exists, because part of its content is not prose at all.

**Nothing can enforce the vocabulary.** `model:` is free text today. Nothing
stops `model: gpt-4`, `model: Claude Opus Five`, or a silent typo, because the
allowed set lives in a markdown table no code reads. A controlled vocabulary
without a machine-readable source cannot be gated — and this repo's answer to
exactly that, per the [coding standards](/meta/policy/elixir-coding-standards.md),
is that a standard with a mechanical oracle becomes a gate.

**The rules are already triplicated.** The prospective/retrospective
distinction and the stamping rule now appear in the roster, in
[controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md)'s
`matter` entry, and in both
[`/matter`](/.claude/skills/matter/SKILL.md) and
[`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md). Four
copies of a rule drift; the
[policy-canonical-skill-guidance plan](/meta/plans/policy-canonical-skill-guidance.md)
already rules that behavioral rules are canonical in `meta/policy/` and skills
quote them.

**The answer to the operator's question is therefore: yes to both halves, with
a correction.** The settings do belong in a config surface. The remainder *is*
policy — but it must be written as an **absorption** of the existing copies,
not a fourth statement of them, or the split trades one defect for a worse one.
And one part of the remainder is not policy at all: which motion a tier
deserves is already
[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md),
which stands unchanged.

## Current state → desired state

```diff
  meta/model-roster.md              # type: reference, authored, read by an agent
- ├── the roster table              # data: model → value → send here → not here
- ├── effort-level note             # explanatory
- ├── determination procedure       # 4 questions
- ├── model: vs provenance          # schema rule (also in contract + 2 skills)
- └── maintenance rules             # undetermined-is-stated (also in 1 skill)

+ config/config.exs                 # data: the enumerated models + dispositions
+ meta/policy/model-stamping.md     # the rule, absorbing the existing copies
+ meta/doctrine/capability-matched-model-selection.md   # unchanged — the direction
- meta/model-roster.md              # DELETED
```

Reader module, mirroring `ElixirMind.SiteConfig`:

```diff
  config/config.exs
+   config :elixir_mind, models: [...]

+ lib/elixir_mind/model_config.ex
+   roster/0        → the enumerated models
+   values/0        → the allowed `model:` strings
+   table/0         → the markdown table the contract token expands to
```

## File-tree diff

```
config/config.exs                      # MODIFIED — the model list
lib/elixir_mind/model_config.ex        # NEW — the one reader; the SiteConfig analog
lib/elixir_mind/contract.ex            # MODIFIED — expand a {{model_roster}} token,
                                       #   exactly as {{site_base_url}} is expanded today
lib/elixir_mind/matters.ex             # MODIFIED — `model:` ∈ values/0 check (matter 3)
meta/policy/model-stamping.md          # NEW — the absorbed rule
meta/policy/controlled-type-vocabulary.md  # MODIFIED — the `matter` entry's model
                                       #   paragraph shrinks to a link
meta/model-roster.md                   # DELETED
.claude/skills/matter/SKILL.md         # MODIFIED — quote the policy, drop the restatement
.claude/skills/scope-unit-of-work/SKILL.md  # MODIFIED — same
meta/index.md, CLAUDE.md, meta/code-map.md  # MODIFIED — listings and regenerations
```

## Signatures

```elixir
@spec roster() :: [%{name: String.t(), send: String.t(), avoid: String.t()}]
@spec values() :: [String.t()]
@spec valid?(model :: String.t()) :: boolean()
@spec table() :: String.t()
```

`table/0` is what makes the config authoritative rather than merely parallel:
the contract renders the roster from config at compile time, so the contract's
copy cannot drift from the setting — the property
`ElixirMind.SiteConfig.expand_tokens/1` already gives the base URL.

## Boundary decisions

- **Config owns the enumeration; policy owns the rule; doctrine owns the
  direction.** One sentence each, no overlap: *which models exist* is data,
  *every matter carries one of them and states its determination* is a rule,
  *match the tier to the motion's epistemic weight* is a standing direction that
  already exists.
- **The contract compiles the list in; it never restates it.** The
  `{{site_base_url}}` precedent, applied unchanged.
- **`ElixirMind.ModelConfig` is the only reader.** `Matters` asks it whether a
  value is allowed; `Contract` asks it for the table. Nothing parses the
  markdown.
- **The skills quote, they do not restate**
  ([policy-canonical-skill-guidance](/meta/plans/policy-canonical-skill-guidance.md)).

## The sequence

| Order | Matter | Intent |
|---|---|---|
| 1 | [extract the model settings to a repo config surface](/meta/matters/extract-model-settings-to-repo-config.md) | Choose the config form, move the enumeration, add `ElixirMind.ModelConfig` + the contract token, retire the roster's data half |
| 2 | [the model-stamping policy](/meta/matters/model-stamping-policy.md) | One terse policy absorbing the rule from the roster, the type-vocabulary entry, and both skills |
| 3 | [gate `model:` values against the roster](/meta/matters/gate-model-values-against-the-roster.md) | `ElixirMind.Matters` checks each `model:` against `ModelConfig.values/0` |

**Sequencing rationale.** Matter 1 first because it decides the *form* of the
allowed values, which both later matters bind to: the policy quotes the
vocabulary's home, and the check reads its set. Matter 3 last because it is the
only one with no independent value — a gate over an unsettled vocabulary would
be rewritten. Matter 2 sits between them and is genuinely order-free; it is
placed second because a policy written after the config exists can point at it
instead of describing a plan.

**Cross-plan hazard — this unit touches queued row 12.** The
[Model-column plan](/meta/plans/model-column-in-the-matter-register.md)'s
backfill (register row 12) stamps `model:` onto 30 docs. If matter 1 changes the
*form* of the value — display names (`Claude Opus 5`) to model ids
(`claude-opus-5`) — that backfill is redone. **Decision taken here to de-risk
it: the value form is frozen as the display form**, matching the commit
trailer, so the two units are order-independent. Any later move to ids becomes
its own migration with its own rename pass, and matter 1 inherits that
constraint rather than reopening it.

## Decision list

**Ratified shape**: the enumeration lives in **Elixir application config**
(`config/config.exs` + `ElixirMind.ModelConfig`), the rule becomes **one new
terse policy** that the `matter` type-vocabulary entry links to, the doctrine is
untouched, and `meta/model-roster.md` is **deleted** rather than left as a
pointer. All three were open at filing and are settled; the matters carry them
as constraints, not as gate questions.

**Alternatives rejected:**

- **Leave it as one document.** Rejected on the three defects above — the type
  misfit is cosmetic, but the unenforceable vocabulary and the four-copy rule
  are not.
- **Move everything to policy.** Rejected: the enumeration is data that turns
  over with every model generation, and the contract loads in full every
  session — putting a churning table in it works against the terseness rule and
  the open [contract-size counterweight](/meta/matters/contract-size-counterweight.md).
- **Move everything to config.** Rejected: a rule that must fire unprompted
  mid-work has to be in the contract to reach a fresh agent
  ([governance-artifact-routing](/meta/policy/governance-artifact-routing.md):
  persistence and reach are different axes). A rule in a config file is inert.
- **Folding the rule into the existing `matter` type-vocabulary entry rather
  than writing a new policy.** A live contender — it keeps the contract from
  gaining an entry. Rejected because the rule also governs `## Model` body
  sections and the prospective/retrospective boundary, which are not facts about
  the `matter` type.
- **A standalone settings file** (root-level `models.yml`), editable without
  touching Elixir and reading as "settings" to a non-Elixir operator. Rejected
  on the `site_base_url` precedent and the zero-dependency stance: this repo has
  no YAML dependency for a root settings file, while Elixir config is read by
  the toolchain with no new parsing.
- **Keeping `meta/model-roster.md` as a pointer document.** Rejected — a
  document holding nothing but redirects is the surface
  [living-text-is-present-tense](/meta/policy/living-text-is-present-tense.md)
  warns about. Inbound links (the contract, `meta/index.md`, and both skills)
  are redirected in matter 1's commit.

**Open questions:**

1. **Interaction with [settle model-attribution](/meta/matters/settle-model-attribution.md)**
   (queued row 6): if that matter retracts or folds
   [model-attribution](/meta/policy/model-attribution.md), the
   prospective/retrospective half of this policy loses its counterpart. Whichever
   lands second reconciles; neither is blocked.

## Anchors

Current as of `HEAD`, 2026-08-02 — re-derive before executing:

- `config/config.exs` — two settings today (`site_base_url`, `repo_url`).
- `lib/elixir_mind/site_config.ex` — the reader-module pattern to copy, including
  the `@default_*` fallback that keeps a bare checkout working.
- `lib/elixir_mind/contract.ex:60` and `:123` — where `expand_tokens/1` is
  called; a `{{model_roster}}` token joins there.
- `meta/policy/controlled-type-vocabulary.md` — the `matter` entry's `model`
  paragraph.
- `.claude/skills/matter/SKILL.md` (Create step) and
  `.claude/skills/scope-unit-of-work/SKILL.md` §3 — the two skill copies.
- `lib/elixir_mind/matters.ex:188` — `scan_docs/3`, where `model` is read for
  matter 3's check.
