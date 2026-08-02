---
type: matter
title: "Gate skill section conformance with a fence-aware checker"
description: Build ElixirMind.SkillSections and mix brain.skill_sections to enforce the required heading set and the retired synonyms across the skills, stripping fenced regions before scanning, and join the gate suite green against an already-migrated corpus.
status: open
model: Claude Opus 5
plan: /meta/plans/skill-section-vocabulary.md
order: 3
provenance: "Claude Opus 5, scope-unit-of-work form-evaluation session"
tags: [meta, matter, skills, tooling, elixir, verifier, ci, gates]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work form-evaluation session"
  why: "the vocabulary has a mechanical oracle, and the coding standards route any such standard to a gate rather than to contract prose"
  from: [/meta/threads/2026-08-02-skill-body-layout-ab-and-section-vocabulary.md]
---

# Gate skill section conformance

Build the checker for
[the ratified vocabulary](/meta/plans/skill-section-vocabulary.md) and join the
gate suite. Runs last: the corpus conforms after matter 2, so this lands green
rather than as a warn-then-escalate stage
(the `mix xref --fail-above 0` precedent).

**Shape:**

```elixir
@type finding :: {:missing_required, Path.t(), String.t()}
              | {:retired_synonym, Path.t(), String.t(), replacement :: String.t()}
              | {:shape_conflict, Path.t()}      # both Dispatch and Procedure, or neither

@spec headings(source :: binary()) :: [binary()]
@spec check(path :: Path.t()) :: [finding()]
@spec check_all(root :: Path.t()) :: [finding()]
```

**What it enforces** — the required set and the synonym ban, and nothing else:
`## Purpose` present; exactly one of `## Dispatch` / `## Procedure`;
`## Guardrails` present; `Rules` and `Notes` rejected with `Guardrails` named as
the replacement. Unrecognized H2s pass silently — the free tier is deliberate.

**The hazard this matter exists to handle correctly.** `headings/1` must strip
fenced regions before scanning. `capture/SKILL.md` carries two heading-like
lines inside code fences — `## Routing` and `# pr: <N>` in a fenced frontmatter
example — and a naive `^#{1,6} ` scan misreads both. This was found empirically:
two independent eval runs caught it where an ad-hoc `grep '^## '` did not, twice.
Fence-stripping belongs in the parser, not the caller, so every future consumer
of a skill's headings inherits the fix.

**Tests** (`test/elixir_mind/skill_sections_test.exs`), through the module API
and the task boundary: a heading inside a fence is not a heading; an unclosed
fence does not swallow the rest of the file; each retired synonym is rejected
with its replacement named; both-shapes and neither-shape are conflicts; a
conforming corpus produces no findings.

**Decisions already made:**

- **Zero dependencies, offline, plain `mix` task** — the admission rule in
  [elixir-coding-standards](/meta/policy/elixir-coding-standards.md) and
  [why the toolchain runs offline](/meta/tutorials/why-the-toolchain-runs-offline.md).
- **Hard-fail, not warn.** The corpus is already conforming when this lands, so
  a warn stage would have nothing to warn about and would train readers to
  ignore the channel.
- **Regenerate `meta/code-map.md`** — it compiles from moduledocs, and the
  freshness gate catches the miss.

**Open question:** whether to also warn on an unrecognized H2. Recommend
silence, per the free-tier decision.

**Verify:** the new tests, `mix brain.skill_sections` against the live corpus,
`mix brain.codemap --check`, and the full suite.

## Model

`Claude Opus 5` — new `lib/` tooling whose failure mode is silent in both
directions: a parser that mis-handles fences either greenlights a
non-conforming skill or fails a conforming one, and nothing downstream catches
either. That is the roster's Opus row (tooling changes to `lib/` where a wrong
shape propagates). Three of four independent scopings of this unit stamped
Opus; the dissent read the CI wiring as well-specified execution and stamped
Sonnet — a reading that holds for the wiring but not for `headings/1`, which is
where the correctness risk actually sits. The split is filed as
[an issue](/meta/issues/model-determination-is-session-dependent.md).
