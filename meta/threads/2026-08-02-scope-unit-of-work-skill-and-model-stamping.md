---
type: reference
title: 2026-08-02-scope-unit-of-work-skill-and-model-stamping
description: Built the /scope-unit-of-work skill and the model roster it reads, then used the skill twice on its own output — scoping the register Model column and the roster's separation of concerns into two plans and five queued matters, with the model that should deliver each stamped per matter.
provenance: "Claude Code session (Claude Opus 5), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, skills, matters, models, config, separation-of-concerns]
timestamp: 2026-08-02
session: https://claude.ai/code/session_01RzvfWLbiQKhtrSPxV1QLYw
---

# 2026-08-02-scope-unit-of-work-skill-and-model-stamping

## Where this landed

The session built [`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md) —
a skill that turns a described unit of work into either one matter or a plan with
sequenced matters, filing it as backlog unless invoked with `sequence` — plus
[the model roster](/meta/model-roster.md) it reads to stamp each emitted matter with the
model that should deliver it. Matter docs gained a `model:` key (prospective and advisory,
distinct from `provenance`), the determination in a `## Model` body section, and
`/matter list` gained a Model column joined from the docs rather than stored in the
register, whose rows are machine-held at exactly four cells.

The skill was then exercised twice on the repo's own state, which is what verified it.
The first run scoped the register's Model column and turned up a constraint sharper than
the one that motivated it: a fifth register cell not only fails the loud shape check but
stops `parse_row/1` matching, which empties `queue_positions/1` and silently degrades the
session-start digest to reporting every queued matter as backlog. The second run evaluated
the roster the session had just filed and split it three ways — the enumeration to Elixir
application config with a contract token compiled from it, the rule to one terse absorbing
policy, the tier direction left with the existing doctrine — with the roster document
deleted rather than kept as a pointer. All three of that plan's open questions were ruled
in-session; both plans are `accepted` and their five matters queued at register rows 12-16.

The roster's tier assignments themselves remain unratified: they were drafted by the agent
that filed the roster and are now stamped on five matters. That ratification is filed into
the config-extraction matter, which is the delivery where the values become the repo's
answer.

The close then folded in the infrastructure the session's own shape had exposed. Opening
the PR halted on a concerns-gate item — the branch carried three separable intents against
[atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md) — and the operator's answer
was a working method rather than a disposition: a thread carries one scoped unit, revision
of what it delivered enters as a new `/scope-unit-of-work` unit, and the PR stands as
written. Ratified in-thread after an amendment exchange (in-flight completion and gate
failures are delivery, not revision; review-time revisions are filed before merge; artifact
count is not itself evidence of overhead — suspected bloat is scoped as an analysis of the
system) and declared as
[scoped units, corrected forward](/meta/doctrine/scoped-units-corrected-forward.md) with
[revision-enters-through-scoping](/meta/policy/revision-enters-through-scoping.md) as its
enforceable half. One rule reached beyond revisions: queueing inserts at the **head**, never
the tail, since tail-parking is the unranked case that belongs in backlog — so the register
was re-sequenced, this session's five matters taking rows 1-5 with the roster-separation
block ahead of the backfill, because the config extraction is where the roster's values get
ratified and backfilling 30 docs from placeholder values would rewrite all 30.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| The `/scope-unit-of-work` skill: dispatch, shape test, per-matter model stamping | closed | [scope-unit-of-work](/.claude/skills/scope-unit-of-work/SKILL.md) | - |
| The model roster: available models and what each is sent | open | [model-roster](/meta/model-roster.md) | tier assignments are agent-drafted and unratified; ratified at the config-extraction delivery |
| `model:` on matter docs — prospective stamp vs retrospective provenance | closed | [controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md) | - |
| `/matter list` gains a Model column joined from the docs | closed | [matter skill](/.claude/skills/matter/SKILL.md) | - |
| The register Model column and the silent digest-degradation hazard | closed | [model-column-in-the-matter-register](/meta/plans/model-column-in-the-matter-register.md) | - |
| Separating the roster's concerns: config, policy, doctrine | closed | [separate-the-model-roster-concerns](/meta/plans/separate-the-model-roster-concerns.md) | - |
| Queueing the five emitted matters, re-sequenced to rows 1-5 at the head | closed | [matter register](/meta/matters.md) | - |
| The working method: one scoped unit per thread, revision as a following unit | closed | [scoped-units-corrected-forward](/meta/doctrine/scoped-units-corrected-forward.md) | - |
| Its enforceable rules, including head-insertion for all queueing | closed | [revision-enters-through-scoping](/meta/policy/revision-enters-through-scoping.md) | - |
| Whether the method holds once the work is substantially code | open | [scoped-units-corrected-forward](/meta/doctrine/scoped-units-corrected-forward.md) | untested; the write-run-fix exemption is the hypothesis, revisited rather than abandoned if insufficient |
| Route tags weaken as threads become atomic by construction | open | [excerpt-log discipline](/meta/matters/excerpt-log-discipline.md) | an input that matter should weigh, not yet weighed |
| Whether `model:` presence earns a warn-level check | open | [gate-model-values-against-the-roster](/meta/matters/gate-model-values-against-the-roster.md) | warn vs fail severity, ruled at that matter's approval gate |
| Interaction with the queued settle-model-attribution matter | paused | [model-stamping-policy](/meta/matters/model-stamping-policy.md) | if model-attribution is retracted or folded, the prospective/retrospective clause is written against whatever survives |

## User

<routes ref=".claude/skills/scope-unit-of-work/SKILL.md meta/model-roster.md">

create a new skill, /scope-unit-of-work, which will scope out a new unit of work, which is either a plan with sequenced matters, or a single matter. running the skill would take everything following '/scope-unit-of-work as the spec for the unit of work. the unit of work should be listed as unsequenced in the registry, UNLESS '/scope-unit-of-work sequence' is run. if matters are created as members of a plan, they will however always be sequenced within that plan, and that order followed if and when they are committed to the matters' list/registry. one aspect of scoping the unit(s) of work should be evaluating which model, according to a user preference of available models for this repo stored somewhere, should be used to do each individual matter. in the case of this repo, the models available are Anthropic models including fable. '/matter list' should be revised so that the model to do the work is added to the printed table. what model the matter should use should live in frontmatter, i am undecided on where the body of the model determination analysis should live (frontmatter vs body of document)

</routes>

## Assistant

<routes ref=".claude/skills/scope-unit-of-work/SKILL.md">

The skill is built and pushed. In plain terms: you can now hand over a description of some work, and the agent decides whether it's one deliverable chunk or a whole sequence of them, writes the handoff docs, and notes which model should do each piece. Nothing gets committed to the delivery queue unless you say `sequence`. I also added a file listing which models this repo uses and what each one is sent — the tier assignments in it are my proposal, not something I could look up, so that file is the main thing to review.

## What the skill does

[`/scope-unit-of-work`](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/.claude/skills/scope-unit-of-work/SKILL.md) takes everything after the invocation as the spec, refreshes against `HEAD` first, then picks the shape on the independence test already in the atomic-PR policy — *could you want to merge one part and reject another?* One intent with a decided approach files as a single matter; several separately-approvable intents, or decisions worth recording first, file as a plan whose build order emits matters carrying that plan's `order`.

**Sequencing.** Default is unsequenced: matter docs land in `meta/matters/` with no register row, which is exactly the existing backlog state. `/scope-unit-of-work sequence` is the ratification to queue — rows append at the register tail in the plan's internal order, and `mix brain.matters` already fails on a queue that inverts a plan's order, so that constraint is machine-held, not just written down.

**Model determination** runs per matter, not per plan — a plan's decision step and its mechanical execution belong at different tiers (and that divergence is itself a signal they're two matters). `model:` in frontmatter, determination in a `## Model` body section.

One constraint worth knowing: I did **not** add a Model column to `meta/matters.md`. `ElixirMind.Matters.check_register_shape` requires exactly four cells per row and would fail on a fifth. `/matter list` joins `model:` from the docs at render time instead, rendering `—` for the 37 existing matters that predate the stamp.

## What I created

| type | doc | why this type |
|---|---|---|
| skill | [`.claude/skills/scope-unit-of-work/SKILL.md`](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/.claude/skills/scope-unit-of-work/SKILL.md) | the requested operational surface |
| reference | [`meta/model-roster.md`](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/meta/model-roster.md) | operator preference data, authored not derived — a register at the `meta/` root beside `matters.md`, not a policy (it churns every model generation, and the contract loads in full every session) |

## What I modified

| file | thrust |
|---|---|
| `.claude/skills/matter/SKILL.md` | `list` renders `# · matter · Type · Order · Model`; `create` stamps `model:` + `## Model`; points at the new skill for whole units |
| `meta/policy/controlled-type-vocabulary.md` | the `matter` entry gains `model` — prospective/advisory, distinct from `provenance`, binding matters scoped from ratification onward |
| `meta/policy/skills-registry.md` | the `/scope-unit-of-work` entry |
| `meta/index.md` | lists the roster |
| `CLAUDE.md` | recompiled from the two policy edits |

## Actions I have taken

| action | result |
|---|---|
| `mix brain.verify` · `brain.matters` · `brain.contract --check` | green (the `cb-eval-export` index warnings are pre-existing and advisory) |
| full pre-commit gate suite + `mix test` | 211 tests, 0 failures |
| commit + push to `claude/scope-unit-of-work-skill-n1fvci` | pushed; no PR opened |

## Questions you need to answer

| # | question | my recommendation |
|---|---|---|
| 1 | Frontmatter or body for the model determination? | **Body**, under `## Model` — implemented that way. Frontmatter is the queryable datum layer (`/matter list` reads `model:` and prints it); a paragraph of reasoning in YAML is prose in a field nothing can query, and it mirrors how `status`/`plan` already sit in frontmatter with their rationale in the plan's body. Flipping it later means moving one section. |
| 2 | Are the roster's tier assignments right? | Review and edit them. I derived them from the doctrine's weight categories and from what this repo's docs show Fable being used for; I have no verified basis for a Fable-vs-Opus ordering, so those rows are a placeholder standing in for your actual preference. The roster is authored-not-derived precisely so you overwrite it. |

## Your options from here

| # | option | what it entails |
|---|---|---|
| 1 | Backfill `model:` onto the 37 existing matter docs | a mechanical pass; until then they render `—` in `/matter list` |
| 2 | Add a warn-level `model:` presence check to `ElixirMind.Matters` | mirrors the existing landing-metadata warn; touches `lib/` + tests, so it's its own matter |
| 3 | Open the PR | `/create-pull-request` |

</routes>

## User

/scope-unit-of-work how to enable this functionality "One constraint worth knowing: I did not add a Model column to meta/matters.md. ElixirMind.Matters.check_register_shape requires exactly four cells per row and would fail on a fifth. /matter list joins model: from the docs at render time instead, rendering — for the 37 existing matters that predate the stamp."

## Assistant

<routes ref="meta/plans/model-column-in-the-matter-register.md">

Scoped and filed as a plan with two sequenced matters, unqueued.

In plain terms: adding a Model column to the queue file is blocked by a check that insists each row has exactly four cells. Scoping it turned up a second, quieter problem behind the loud one — so the work is now a design record plus two pieces of work a fresh thread can pick up. Nothing was added to the delivery queue, because you didn't pass `sequence`.

## The finding that shaped the scope

The four-cell guard is the *safe* half of the constraint. `parse_row/1` matches a four-element list; a fifth cell makes every row fall through to the catch-all with `pos: nil`, `queue_positions/1` drops nil-positioned rows, and `ElixirMind.SessionInit` consumes exactly that map to mark which matters are queued. A register edited without the parser change produces a session-start digest that reports **every queued matter as backlog**, with no error and no warning — `mix brain.matters` would still pass its other checks. That is why the code change and the register rewrite are one commit and not two, and it's the reason matter 2 is stamped at a higher tier than its diff size suggests.

## Shape: plan + 2 matters

Two independently approvable intents — you can take the stamps and decline the column, or take the column over a partial backfill — plus cross-matter decisions worth recording (projected-vs-authored cell, fail-vs-warn on divergence, which half lands first). That is a plan, not one matter.

| Order | Matter | Model | Determination |
|---|---|---|---|
| 1 | [Backfill model stamps on the open matter docs](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/meta/matters/backfill-model-stamps-on-matter-docs.md) | Claude Sonnet 5 | 30 near-identical edits against a decided rubric; advisory output, cheap to revise |
| 2 | [Register Model column and its agreement check](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/meta/matters/register-model-column-and-agreement-check.md) | Claude Opus 5 | a `lib/` shape change whose failure mode no oracle covers — the digest degrades silently |

Backfill leads because `/matter list` already joins `model:` at render time, so those stamps pay off the day they land, and because the column otherwise ships showing `-` in all 11 rows with nothing for the agreement check to check.

## What I created

| type | doc | why this type |
|---|---|---|
| plan | [model-column-in-the-matter-register](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/meta/plans/model-column-in-the-matter-register.md) | two separately-approvable intents plus decisions to record before either runs |
| matter | backfill-model-stamps-on-matter-docs | order 1 |
| matter | register-model-column-and-agreement-check | order 2 |

## What I modified

| file | thrust |
|---|---|
| `meta/matters/index.md` | both matters listed under Open |
| `meta/plans/index.md` | the plan listed under Proposed |

## Actions I have taken

| action | result |
|---|---|
| Refreshed anchors against `HEAD` | `parse_row/1:116`, catch-all `:127`, `scan_docs/3:188`, `row_shape_errors/1:244`, `agreement_errors/2:348`, `queue_positions/1:76` — recorded in the plan's Anchors section |
| Searched for a pre-existing artifact | none covers this; `generate-the-channels-ingested-column` is a different register |
| Measured the corpus | 37 matter docs — 30 open (11 queued), 7 done, 0 stamped |
| `mix brain.verify` · `brain.matters` · full pre-commit suite · 211 tests | green; the plan's `attribution` warns for a missing `from`, which `/create-pull-request` stamps once the thread doc exists |
| Committed + pushed to `claude/scope-unit-of-work-skill-n1fvci` | `d31069f` |

## Questions you need to answer

| # | question | my recommendation |
|---|---|---|
| 1 | Absent marker in the register — `-` or `—`? | `-`, matching the Order cell's existing convention and keeping the parser on ASCII; `/matter list` can still render an em dash in its own output |
| 2 | Does the backfill cover the 7 `done` docs? | No — `model:` is prospective, so stamping a recommendation onto delivered work is retro-fiction, and no done matter has a register row. Held in matter 1's packet; it does not gate matter 2 |

Both are recorded as open questions in the plan, so answering them later at a `/matter` approval gate costs nothing now.

## Your options from here

| # | option | what it entails |
|---|---|---|
| 1 | Queue the unit | `/scope-unit-of-work sequence …`, or state positions and I append rows 12–13 in plan order |
| 2 | Leave it backlog | findable via `/matter list`, picked up whenever |
| 3 | Accept the plan | flip `status: proposed` → `accepted` |

One caveat on the model stamps: they come from [the roster](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/meta/model-roster.md), whose tier assignments are still the placeholder I wrote earlier this session and you haven't ratified. If you edit the roster, both stamps are one-line changes.

</routes>

## User

1
and make sure the plan links back to this thread doc
i will respond after re: the roster

## Assistant

Queued at rows 12–13, plan accepted, pushed (`53721cc`).

> and make sure the plan links back to this thread doc

The link is `attribution.from` on the plan — the sanctioned form, since [provenance-lives-in-metadata](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/provenance-lives-in-metadata.md) bars naming the originating thread in body prose. It cannot be written yet: the thread doc doesn't exist until `/capture` runs, and `mix brain.verify` fails a `from` pointing at a missing file. `mix brain.verify` is already warning about the gap on this plan, which is the tracking mechanism:

```
[warn] meta/plans/model-column-in-the-matter-register.md: `attribution` lacks
       `from` — link the thread or doc this plan was extracted from
```

`/create-pull-request` stamps it at close, along with the two matter docs and the model roster, all created this session. I'll verify the warning clears before opening the PR rather than assume the stamp landed.

## Actions I have taken

| action | result |
|---|---|
| Appended rows 12–13 to the register | backfill (order 1), then the column (order 2) — the queue tail, contiguous |
| `mix brain.matters` | 13 rows well-formed; plan-order inversion check confirms the queue preserves the plan's internal order |
| Flipped the plan `proposed` → `accepted` | committing its matters to the delivery queue is the acceptance |
| Full pre-commit suite + 211 tests | green |
| Pushed | `53721cc` |

Both matters are now queued behind 11 existing rows. Standing by on the roster.

## User

/scope-unit-of-work evaluate the roster and determine how we might separate concerns. the model settings arguably belong in a config for the repo, not inside a reference okf document. then would the remainder be a policy document?

## User

metaphor

## Assistant

<routes ref="meta/plans/separate-the-model-roster-concerns.md">

Scoped as a plan with three matters, filed as backlog (no `sequence`).

Your instinct holds, and the evaluation found a sharper reason for it than the one you gave. The roster isn't just a settings table in the wrong file — it's three different kinds of thing sharing one document, and each is misplaced differently.

> the model settings arguably belong in a config for the repo, not inside a reference okf document

Yes, and the type is a genuine misfit: the contract defines `reference` as "external material you have **captured and summarized**", and the roster captures nothing — it's authored here. But that's the cosmetic defect. The load-bearing one is that **nothing can enforce the vocabulary**. `model:` is free text today; `gpt-4`, `Claude Opus Five`, or a typo all pass, because the allowed set lives in a markdown table no code reads. A controlled vocabulary with no machine-readable source can't be gated — and the repo's own coding standards say a standard with a mechanical oracle becomes a gate.

There's an exact precedent to copy: `site_base_url` lives in `config/config.exs`, `ElixirMind.SiteConfig` reads it, and `ElixirMind.Contract` expands a `{{site_base_url}}` token so the contract's copy is *compiled from* the setting rather than kept parallel to it. A `{{model_roster}}` token does the same job here.

> then would the remainder be a policy document?

Yes — with one correction that changes how the matter must be written. The remainder is **already stated four times**: the roster, the `matter` entry in controlled-type-vocabulary, `/matter`, and `/scope-unit-of-work`. I created three of those copies over the last two turns. So the policy has to be an **absorption** that deletes its predecessors in the same commit; a policy landing beside four copies makes the drift worse, not better.

And part of the remainder isn't policy at all. *Which motion deserves which tier* is already [capability-matched-model-selection](https://github.com/ob6to8/elixir-mind/blob/main/meta/doctrine/capability-matched-model-selection.md), which stands untouched. So the split is three layers, not two: **config** owns the enumeration, **policy** owns the rule, **doctrine** owns the direction.

## The sequence

| Order | Matter | Model | Determination |
|---|---|---|---|
| 1 | [Extract the model settings to a repo config surface](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/meta/matters/extract-model-settings-to-repo-config.md) | Claude Opus 5 | a boundary decision with no oracle — which layer owns the vocabulary, and the two later matters bind to it |
| 2 | [The model-stamping policy](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/meta/matters/model-stamping-policy.md) | Claude Fable 5 | contract-facing prose whose whole difficulty is compression: four statements into one that loses nothing |
| 3 | [Gate `model:` values against the roster](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/meta/matters/gate-model-values-against-the-roster.md) | Claude Sonnet 5 | execution against a decided shape, tests as the oracle |

**One hazard I closed rather than left open.** Queued row 12 backfills `model:` onto 30 docs. If matter 1 changed the *value form* — display names to model ids — that backfill would be redone. The plan freezes the form as the display form, matching the commit trailer, so the two units are order-independent. A later move to ids becomes its own migration.

## What I created

| type | doc | why this type |
|---|---|---|
| plan | [separate-the-model-roster-concerns](https://github.com/ob6to8/elixir-mind/blob/claude/scope-unit-of-work-skill-n1fvci/meta/plans/separate-the-model-roster-concerns.md) | three separately-approvable intents plus decisions worth recording; the evaluation lives in its decision list rather than a duplicate analysis |
| matter ×3 | orders 1–3 above | one reviewable intent each |

## What I modified

| file | thrust |
|---|---|
| `meta/matters/index.md` | three entries under Open |
| `meta/plans/index.md` | the plan under Proposed |

## Actions I have taken

| action | result |
|---|---|
| Read `config/config.exs`, `SiteConfig`, `Contract` | confirmed the config → reader → contract-token precedent is exact and reusable |
| Searched for a pre-existing artifact | none; the adjacent [settle model-attribution](https://github.com/ob6to8/elixir-mind/blob/main/meta/matters/settle-model-attribution.md) (queued row 6) is cross-referenced in both the plan and matter 2 |
| `mix brain.verify` · `brain.matters` · full suite · 211 tests | green |
| Pushed | `7326b6a` |

## Questions you need to answer

| # | question | my recommendation |
|---|---|---|
| 1 | Which config form — Elixir application config, or a standalone settings file? | Elixir config, on the `site_base_url` precedent and the zero-dependency stance. You said "config" loosely, so I read it as *a settings surface*, not necessarily `config/config.exs` — a root-level `models.yml` reads better to a non-Elixir editor but needs a parser this repo has no dependency for |
| 2 | New policy, or expand the `matter` type-vocabulary entry? | New terse policy (~120 words) that the type entry links to — the rule governs body structure and the attribution boundary, which aren't facts about the `matter` type. The counter-argument (don't add a contract entry) is real |
| 3 | Does `meta/model-roster.md` survive as a pointer? | Delete it. A document holding nothing but redirects is the surface `living-text-is-present-tense` warns about |

Both 1 and 2 are recorded as open questions in the plan and as gate blockers in the matters, so they cost nothing to answer later. Nothing was queued — say the word and I'll append rows 14–16.

</routes>

## User

1. agree
2. agree
3. agree

## Assistant

<routes ref="meta/matters/extract-model-settings-to-repo-config.md">

All three rulings recorded and pushed (`cae71fa`).

Each moved out of the plan's open list in two directions: the chosen option into the ratified shape, the rejected one into the rejected-alternatives list with its reason, so a fresh session reads *why* the settings file and the pointer doc were declined rather than re-proposing them. In the matters, they moved from gate blockers into stated constraints — matters 1 and 2 now open with nothing to ask before work starts.

I flipped the plan to `accepted`: every decision it held is settled. Queued-ness stays separate — the three matters are still backlog, since register membership is what commits work, never a status.

## What I modified

| file | thrust |
|---|---|
| `meta/plans/separate-the-model-roster-concerns.md` | `accepted`; ratified shape replaces the recommendation; three rulings become rejected-alternative entries; desired-state and file-tree diffs collapse to the single config form and outright deletion |
| `meta/matters/extract-model-settings-to-repo-config.md` | deliverable 1 names `config/config.exs` concretely; blocker replaced by the settled constraints |
| `meta/matters/model-stamping-policy.md` | "open at the gate" → new policy, settled |
| `meta/plans/index.md` | gloss carries the rulings instead of the open questions |

## Actions I have taken

| action | result |
|---|---|
| `mix brain.verify` · `brain.matters` · full suite · 211 tests | green |
| Pushed | `cae71fa` |

One open question survives in the plan, and it wasn't one of the three: if [settle model-attribution](https://github.com/ob6to8/elixir-mind/blob/main/meta/matters/settle-model-attribution.md) (queued row 6) retracts or folds the `model-attribution` policy, the new policy's prospective/retrospective clause loses its counterpart. Whichever lands second reconciles; neither blocks the other.

## Your options from here

| # | option | what it entails |
|---|---|---|
| 1 | Queue the three matters | rows 14–16 in plan order |
| 2 | Leave them backlog | they sit behind the 13 queued rows until picked up |
| 3 | Close the session | `/create-pull-request` — captures the thread, stamps `attribution.from` on both plans, five matters, and the roster, then opens the PR |

</routes>

## User

1, and queue the earlier matters as well ("Order	Matter	Model	Determination
1	Backfill model stamps on the open matter docs	Claude Sonnet 5	30 near-identical edits against a decided rubric; advisory output, cheap to revise
2	Register Model column and its agreement check	Claude Opus 5	a lib/ shape change whose failure mode no oracle covers — the digest degrades silently")

## Assistant

<routes ref="meta/matters.md">

The two you quoted were already queued — I appended them at rows 12–13 when you answered "1" two turns ago, so this turn added only the three roster-separation matters. Nothing duplicated; the register's duplicate-queue check would have failed if I'd re-added them.

The queue tail now reads:

| # | Matter | Plan | Order | Model |
|---|---|---|---|---|
| 12 | Backfill model stamps on matter docs | model-column | 1 | Claude Sonnet 5 |
| 13 | Register Model column and its agreement check | model-column | 2 | Claude Opus 5 |
| 14 | Extract the model settings to a repo config surface | roster-separation | 1 | Claude Opus 5 |
| 15 | The model-stamping policy | roster-separation | 2 | Claude Fable 5 |
| 16 | Gate model values against the configured roster | roster-separation | 3 | Claude Sonnet 5 |

(The Model column here is the render-time join; the register file itself still holds four cells until row 13 lands.)

Both plans' internal orders are preserved and non-interleaved, which `mix brain.matters` confirms. Rows 12–13 and 14–16 are order-independent of each other because the plan froze the `model:` value form as the display form — otherwise the config extraction at row 14 could have invalidated row 12's 30 stamps.

## Actions I have taken

| action | result |
|---|---|
| Appended rows 14–16 in plan order | 16 queue rows, contiguous |
| `mix brain.matters` | register shape, agreement, and plan-order inversion all green |
| Full pre-commit suite + 211 tests | green |
| Pushed | `c0f9d15` |

Five queued matters came out of this session, behind the 11 that were already there. Whenever you want the session closed, `/create-pull-request` captures the thread, stamps `attribution.from` on both plans, all five matters, and the roster, and opens the PR.

</routes>

## Assistant

Capture, glossary, and stamping are committed and pushed (`a83535e`). Halting before the PR — the concerns gate turned up one item that's yours to disposition, not mine.

## The blocker

This branch carries **three separable intents**, and [atomic-pull-requests](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/git-atomic-pull-requests.md) says a session holding several finished matters "says so and hands the remainder to the operator instead of silently widening the open PR":

1. the `/scope-unit-of-work` skill, the model roster, and the `model:` stamp (commits `7a96311`, `d31069f` partly);
2. the Model-column plan and its two matters;
3. the roster-separation plan and its three matters.

By the policy's own independence test you could plausibly approve (1) and reject (3) — indeed (3) *revises* what (1) filed. So on a literal reading this is three PRs.

**My recommendation: open one PR anyway.** The three are causally chained rather than merely batched — (2) and (3) exist because the skill was built and run, and running it twice is what verified it; every artifact is a scoping document, so there's no code in (2) or (3) a reviewer could reject independently in practice. Splitting now would mean branch surgery to carve commits into three heads, for a review boundary you were already inside turn by turn. The alternative, if you'd rather have the record clean: I split at the commit boundaries into three stacked branches and open three PRs in dependency order.

## Questions you need to answer

| # | question | my recommendation |
|---|---|---|
| 1 | One PR for all three intents, or split into three? | **One PR.** The chain is causal, nothing in it is independently rejectable in practice, and the split costs branch surgery |

Everything else in the closing inventory has a durable home already: the unratified roster values are filed into the config-extraction matter (not left as a chat deferral), the open severity question sits in the gate matter, and the `settle-model-attribution` interaction is the surviving open question in the roster-separation plan. Nothing is waiting to be said only in a post-merge message.

## Actions I have taken

| action | result |
|---|---|
| `/capture` | `meta/threads/2026-08-02-scope-unit-of-work-skill-and-model-stamping.md` — 12 exchanges rendered from the session log with the drop rule applied mechanically; the mid-turn "metaphor" message recovered from the queued-command record; 9-row routing ledger; path-ref route tags (this session fed no `em:` sinks) |
| `/add-to-glossary` | one new term — `model roster` (`em:f0582b`, `sense: repo`) — plus the `model:`/`provenance` distinction merged into `matter`; registry and glossary index regenerated |
| `attribution.from` stamping | both plans, all five matters, and the roster; both `brain.verify` warnings cleared |
| Full gate suite + 211 tests | green |
| Pushed | `a83535e` |

Say the word on question 1 and I'll open the PR (or the three).

## User

<routes ref="meta/doctrine/scoped-units-corrected-forward.md meta/policy/revision-enters-through-scoping.md">

yes, this is a new workflow I am going to try where I either execute 

1. a matter, or 

2./scope-unit-of-work with a description (which is how this thread would have started had that skill existed) to either be peristed or executed there.

in the case of 1, or 2 and executed in thread, I am going to try keeping the PR as written. then, for any feedback or revisions, i will provide it as /scope-unit-of-work , as i have done here, and generally sequence it. so, the following PRs would be the execution of the follow up matters/plans.

the reason being, 
1 - this forces a scoping discipline to threads and PRs and they can only spawn new atomic threads, its not possible to lead to sprawling threads where many topics and units of work are being executed across domains in ways that need to be untangled later via route-tagging
2 - it further tightens all dev scope to matters/PRs
3 - rather than focus on specific changes to generated artifacts, I am trying to leverage decisions across all instances of a changed type in the codebase, where applicable. 

in other words, i'd rather accept some inefficiency or bloat in a PR then actively address it in a following PR, than narrate an arbitrary string of instructions to change in the thread

I don't know if this process will hold up long term when I start editing the code, but for now it conceptually seems much cleaner to me

levy your opinion, and once we find agreement, this should be declared into doctrine/policy

at that point we should be ready to close this thread

</routes>

## Assistant

<routes ref="meta/policy/revision-enters-through-scoping.md">

I agree with the workflow, with three amendments — one of them load-bearing enough that without it the rule breaks the first time a test fails.

The short version: routing revisions through scoping closes the last big hole in this brain's record-keeping. Every other class of decision already has a durable home — deferrals get filed, close-time concerns block the close, plans persist decisions — but *revision instructions* have stayed pure chat, and they're the highest-frequency decision type there is. This fixes that, and it does it by making the thread's shape match the PR's shape at the front instead of reassembling it afterward.

> 1 - this forces a scoping discipline to threads and PRs and they can only spawn new atomic threads

Right, and this session is the evidence for it: I halted a moment ago precisely because this thread carries three separable intents, which is the failure the rule prevents. Under it, this would have been three threads. One precision though — it prevents *unrelated* topics, not depth. My second `/scope-unit-of-work` invocation still fanned into an evaluation, three matters, and a plan. Atomicity of *intent*, not of size.

> 3 - rather than focus on specific changes to generated artifacts, i am trying to leverage decisions across all instances of a changed type in the codebase, where applicable

This is the strongest of the three and the least obvious. In-thread revision naturally produces instance-level patches ("fix this doc"); a scoped matter naturally asks "what's the rule, and which instances does it touch?" That's exactly how the backfill matter came out covering all 30 open docs rather than the two I'd just made. It's the same move the coding standards already make for agent misses — *"A recurring agent miss is fixed by updating this policy and recompiling the contract, never only in the offending change"* — generalized from agent behavior to artifacts.

> I don't know if this process will hold up long term when I start editing the code

My read is the opposite of your worry: it holds up *better* for code, because code has a mechanical oracle. A delivered code matter is verifiably done, so a later request is more plausibly genuine new scope. What breaks is the inner loop — you cannot scope-and-defer through a failing test. Hence amendment 1.

## The three amendments

**1. In-flight completion is not revision.** While a matter is being delivered — before its PR opens — correcting work *inside its approved scope*, and fixing anything the gate suite rejects, is part of delivering it. The test is one question: was it in the approved scope and done wrong (fix now, it's incomplete delivery), or outside it (scope it)? Without this, a red CI run becomes a new matter, which is absurd, and the write→run→fix loop for code becomes impossible.

**2. A revision identified at review time is filed before the PR merges.** "Keep the PR as written and correct forward" only works if the forward correction actually exists as an artifact. Otherwise it's merge-and-forget, and the accepted bloat becomes permanent bloat. This is [concerns-block-the-close](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/concerns-block-the-close.md) extended one step past the open.

**3. File the cheapest artifact that carries the intent.** The real failure mode of this workflow isn't inefficiency — it's *scoping inflation*: the governance layer growing faster than the work. This session produced two plans, five matters, and a glossary term for what is substantively one skill and a table. Most feedback should be a three-line matter; a plan only when there are decisions to record. The skill already says "a plan that would contain no decisions is a matter" — the policy should say it about feedback specifically.

One smaller point, not an amendment: "generally sequence it" shouldn't harden into "always at the tail." A one-line correction to something that just landed shouldn't sit behind fifteen rows; the register lets you state a position, and this rule shouldn't quietly remove that.

## An implication you may want to notice

If threads become atomic by construction, **route tags weaken as a mechanism**. You described route-tagging as the untangling layer for sprawling threads — this workflow prevents the sprawl instead of untangling it, which means one thread routes to roughly one sink and the excerpt log approaches a copy of the thread. The [excerpt-log discipline matter](https://github.com/ob6to8/elixir-mind/blob/main/meta/matters/excerpt-log-discipline.md) (queued, row 4, already measuring the logs at ~20% of knowledge-corpus lines) is where that should be weighed. I'm not proposing anything here — just noting the input it should carry.

## Proposed artifacts — the actual text

Both, per [governance-artifact-routing](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/governance-artifact-routing.md): the direction shapes judgment (doctrine), the rules must fire unprompted mid-work in every fresh session (policy, so it compiles into the contract). Same pairing as capability-matched-model-selection ↔ model-attribution.

**`meta/doctrine/scoped-units-corrected-forward.md`** — the direction:

> Work enters a thread as one scoped unit and leaves as one PR. Imperfection in a delivered unit is corrected by a *following* unit, not by narrated revision inside the thread that produced it. Accepting bloat in a landed PR and scoping its correction is preferred to steering mid-thread, because a narrated instruction leaves no artifact, has no review boundary, and reaches one instance where a scoped correction reaches the type.

**`meta/policy/revision-enters-through-scoping.md`** — the rules, terse:

1. A working thread begins with exactly one entry point: `/matter`, or `/scope-unit-of-work <spec>` (persisted, or executed in-thread). It does not take on a second unit.
2. Revision of delivered work enters through `/scope-unit-of-work` as a new unit. The PR stands as written.
3. **In-flight completion is not revision** — inside the approved scope, and any gate failure, is delivery. Outside it, scope it.
4. A revision identified at review time is **filed before the PR merges**.
5. File the cheapest artifact carrying the intent — usually a one-line matter.
6. Position in the queue is the operator's; a correction need not go to the tail.

## Questions you need to answer

| # | question | my recommendation |
|---|---|---|
| 1 | Accept the three amendments as written? | Yes — 1 is required for code work at all; 2 keeps "correct forward" from becoming "forget"; 3 is the guard against scoping inflation |
| 2 | Doctrine + policy pair, or policy alone? | The pair. Policy alone loses the *why*, and the why is what an agent needs to judge an unlisted case — but I'd hear the argument for policy-only given the contract-size pressure |

## Actions I have taken

| action | result |
|---|---|
| Held the PR unopened | your "yes" answered my blocking question — one PR, kept as written |
| Nothing filed yet | the doctrine and policy text above is a draft for your ratification, not committed |

On your "yes": say the word on the two questions and I'll write both artifacts, recompile the contract, and run the close — PR opened, `pr:` stamped into `2026-08-02-scope-unit-of-work-skill-and-model-stamping.md`, handed back to you unmerged.

</routes>

## User

<routes ref="meta/doctrine/scoped-units-corrected-forward.md meta/matters.md">

"Right, and this session is the evidence for it: I halted a moment ago precisely because this thread carries three separable intents, which is the failure the rule prevents. Under it, this would have been three threads. One precision though — it prevents unrelated topics, not depth. My second /scope-unit-of-work invocation still fanned into an evaluation, three matters, and a plan. Atomicity of intent, not of size." - yes, i would say that this entire thread landing in a single pr is topic canonical - it is a single matter, described and then implemented, with subsequent revision matters authored and persisted. then, infrastructure which depends on the context (what we're describing now) folded in. what does NOT happen (ie. the invariants/guardrails) are:

1. No new matter is executed, or defined that does not naturally extend from revisions to the initial matter implementation or infra related to the thread
2. No direct feedback given for changes to be made to the work that has been done in the thread


re: amendments
1 . yes agree that fixing brokeness is within scope

2. yes, why i consider the atomic pr to necessarily include revision matters
3. this is governance inflation only if you can concretely identify duplication or inefficiency. if its all necessary, according to the bounds of this system, then its necessary, and reduction could only happen by addressing the system itself. if suspicious, this wouldmean scoping a new matter to analyze the system according to these concerns


I think default sequencing position should be at the head, and should be the case here. i don't think anything should ever be scoped to the tail unless the item specifically requires all items that preceed it to be done. sequencing in the register carries implicit info regarding prioritization, sequencing at the end is a weak sort of "I don't want to forget this but i don't know how to prioritize it". that should be an unsequenced matter. if you only sequence at the head, save for matters that require specific ordering, then you know that the entire sequenced list was added either as the top priority or as top as it could get with dependencies listed before

1 - see above
2 - agree

</routes>

## Assistant

Right on amendment 3 — I was proposing an instance-level fix (suppress artifacts in the moment) for what your own point 3 says is a type-level question. Reframing it as: artifact count is not itself evidence of overhead; suspected bloat becomes a scoped analysis of the system.

Head-sequencing changes the register here, so let me check the policy conventions and then write.
