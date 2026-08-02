---
type: matter
title: "Extract the model settings to a repo config surface"
description: Move the enumerated models and their dispositions out of the reference document into a repo config surface with a single ElixirMind.ModelConfig reader and a contract token that renders the roster from config, so the allowed `model:` values have a machine-readable home.
status: open
model: Claude Opus 5
plan: /meta/plans/separate-the-model-roster-concerns.md
order: 1
provenance: "Claude Opus 5, scope-unit-of-work session"
tags: [meta, matter, models, config, tooling, contract]
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work skill session"
  why: "order 1 of the roster-separation plan — the config form decides the value vocabulary both later matters bind to"
timestamp: 2026-08-02
---

# Extract the model settings to a repo config surface

The enumerated models and what each is sent are **data**, currently held as a
markdown table in [`meta/model-roster.md`](/meta/model-roster.md) — a document
typed `reference` (defined as captured external material, which this is not)
that no code can read. Move the enumeration to a config surface with one reader.
The design and the rejected alternatives are in
[the plan](/meta/plans/separate-the-model-roster-concerns.md).

**Deliver:**

1. **The config surface**, per the operator's ruling at the gate — see the
   blocker below.
2. **`lib/elixir_mind/model_config.ex`** — the only reader, mirroring
   `ElixirMind.SiteConfig` including its `@default_*` fallback so a bare
   checkout still runs: `roster/0`, `values/0`, `valid?/1`, `table/0`.
3. **A contract token.** `ElixirMind.Contract` already calls
   `SiteConfig.expand_tokens/1` at two sites; add `{{model_roster}}` → the
   rendered table so the contract's copy is *compiled from* the setting and
   cannot drift. This is the property that makes config authoritative rather
   than merely parallel.
4. **Redirect the inbound links** — the contract, `meta/index.md`,
   [`/matter`](/.claude/skills/matter/SKILL.md), and
   [`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md) all
   point at the roster document today — and retire it (recommend deletion over
   a hollow pointer doc).

**Frozen by the plan, not reopened here:** the `model:` value form stays the
**display form** (`Claude Opus 5`), matching the commit trailer. Queued register
row 12 backfills 30 docs with those strings; changing the form here would force
that backfill to be redone.

**Blocker — the operator's ruling on the config form.** Elixir application
config (`config/config.exs` + the reader) mirrors the `site_base_url` precedent
exactly and needs no new parsing; a standalone root-level settings file reads as
"settings" to a non-Elixir operator but needs a parser this repo has no
dependency for. Recommendation is Elixir config. Take the ruling at the approval
gate before writing anything.

**Verify:** `mix brain.contract --check` (the token must round-trip),
`mix brain.codemap --check`, `mix brain.verify`, `mix test
--warnings-as-errors`, plus a grep proving no live link still points at the
retired document.

## Model

`Claude Opus 5` — a boundary decision with no oracle behind it: which layer owns
the enumeration, and how the contract derives its copy. The tests catch a broken
token; nothing catches a split that puts the vocabulary in the wrong place, and
the two later matters bind to whatever this one decides.
