---
type: matter
title: "Gate model values against the configured roster"
description: Have ElixirMind.Matters check every matter doc's `model:` against ElixirMind.ModelConfig.values/0, turning the roster from a table an agent is trusted to follow into a controlled vocabulary with a mechanical oracle.
status: open
model: Claude Sonnet 5
plan: /meta/plans/separate-the-model-roster-concerns.md
order: 3
provenance: "Claude Opus 5, scope-unit-of-work session"
tags: [meta, matter, models, verifier, tooling, gates]
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work skill session"
  why: "order 3 of the roster-separation plan — the payoff that makes the machine-readable enumeration worth extracting"
  from: [/meta/threads/2026-08-02-scope-unit-of-work-skill-and-model-stamping.md]
timestamp: 2026-08-02
---

# Gate model values against the configured roster

`model:` is free text today: nothing rejects `gpt-4`, `Claude Opus Five`, or a
typo, because the allowed set lives in a markdown table no code reads. Once
[matter 1](/meta/matters/extract-model-settings-to-repo-config.md) gives the
enumeration a machine-readable home, the check becomes trivial — and until it
exists, the vocabulary is controlled only by agent diligence.

**Deliver:**

1. A `model:` validity error in `ElixirMind.Matters`' doc-shape check: present
   and a member of `ElixirMind.ModelConfig.values/0`, or the literal
   `undetermined`; absent is permitted (docs predating the stamp).
2. Tests: a valid value, an unknown value, `undetermined`, and absent.
3. The moduledoc's numbered rule list updated, then `mix brain.codemap`.

**Severity — recommend `:warn`, not `:fail`.** The
[coding standards](/meta/policy/elixir-coding-standards.md) hold that a checker
earns a gate on the standing admission rule rather than automatically, and this
one guards an advisory datum: a stale value misroutes a recommendation, it does
not corrupt the bundle. `check_landing/1` is the existing precedent for a
warn-level rule in this module. Escalating to `:fail` later costs one line;
take the operator's ruling at the gate.

**Blocked on matter 1** — `ModelConfig` must exist. A matter whose blocker is
unmet is skipped by the [`/matter`](/.claude/skills/matter/SKILL.md) consume
protocol, so this is safe to leave queued behind it.

**Verify:** `mix brain.matters`, `mix brain.codemap --check`, `mix test
--warnings-as-errors`, and a manual run against a doc carrying a deliberately
bogus value.

## Model

`Claude Sonnet 5` — well-specified execution against a decided shape: the
module's existing check structure, its `finish/3` result convention, and its
warn precedent leave no approach open, and the tests are the oracle. The one
judgment in it — warn versus fail — is settled by the operator before any code
is written.
