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
  from: [/meta/threads/2026-08-02-scope-unit-of-work-skill-and-model-stamping.md]
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

1. **The enumeration in `config/config.exs`**, beside `site_base_url` and
   `repo_url`: each model's name, its `model:` value, and its one-line
   disposition (what it is sent, what it is not).
2. **`lib/elixir_mind/model_config.ex`** — the only reader, mirroring
   `ElixirMind.SiteConfig` including its `@default_*` fallback so a bare
   checkout still runs: `roster/0`, `values/0`, `valid?/1`, `table/0`.
3. **A contract token.** `ElixirMind.Contract` already calls
   `SiteConfig.expand_tokens/1` at two sites; add `{{model_roster}}` → the
   rendered table so the contract's copy is *compiled from* the setting and
   cannot drift. This is the property that makes config authoritative rather
   than merely parallel.
4. **Redirect the inbound links and delete the roster document.** The contract,
   `meta/index.md`, [`/matter`](/.claude/skills/matter/SKILL.md), and
   [`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md) all
   point at it today. It is deleted, not left as a pointer.

**The values themselves are unratified — ratify them here.** The roster's tier
assignments (which motion each model is sent) were drafted by the agent that
filed the roster and have never been ratified; five matter docs already carry
`model:` stamps derived from them. This delivery is the moment to settle them,
because writing them into config is what makes them the repo's answer: present
the proposed table at the approval gate and take the operator's edits before
committing. The *form* is frozen (below); the *content* is not.

**Settled before delivery — constraints, not gate questions.** The config form
is **Elixir application config**, on the `site_base_url` precedent and the
zero-dependency stance; the roster document is **deleted**; and the `model:`
value form stays the **display form** (`Claude Opus 5`), matching the commit
trailer. That last one matters operationally: queued register row 12 backfills
30 docs with those strings, and changing the form here would force that backfill
to be redone.

**Verify:** `mix brain.contract --check` (the token must round-trip),
`mix brain.codemap --check`, `mix brain.verify`, `mix test
--warnings-as-errors`, plus a grep proving no live link still points at the
retired document.

## Model

`Claude Opus 5` — a boundary decision with no oracle behind it: which layer owns
the enumeration, and how the contract derives its copy. The tests catch a broken
token; nothing catches a split that puts the vocabulary in the wrong place, and
the two later matters bind to whatever this one decides.
