---
type: plan
title: "Rename the mix task namespace: brain.* → mind.*"
description: Retire the brain.* mix-task namespace — deliberately kept by the elixir-mind rename plan as domain-neutral — in favor of mind.*, via one canonical big-bang flip (task modules, skills, CI, hooks, policies, and live doc references) with thin brain.* delegating shims kept for one deprecation window, mirroring the verifier-atomic pattern of the id-namespace migration.
status: proposed
provenance: "Claude Code session (2026-07-27) — operator directed the plan's creation, reversing the rename plan's keep-brain.* scope decision"
tags: [meta, plan, tooling, rename, mix-tasks, migration]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator dialogue on the code-cleanliness-trust branch"
  why: "operator directed: create plan to move brain to mind — the task-namespace alignment the elixir-mind rename deliberately deferred"
  from: [/meta/analysis/scar-tissue-drift-defenses-and-persistence.md, /meta/plans/rename-second-brain-to-elixir-mind.md]
---

# Rename the mix task namespace: `brain.*` → `mind.*`

## Motivation

The [elixir-mind rename plan](/meta/plans/rename-second-brain-to-elixir-mind.md)
explicitly scoped the task namespace **out**: "`mix brain.*` task names —
already repo-name-agnostic and domain-neutral," so the second-brain →
elixir-mind rename left ~15 `mix brain.*` tasks untouched. The operator has
now directed the opposite: the repo's identity is *mind*, and the tooling's
user-facing surface should say so. This plan reverses that one scope
decision — nothing else from the rename plan reopens.

## Shape of the change

**One canonical big-bang flip with a thin compatibility window** — not an
alias-first double migration, which would churn every doc surface twice. The
precedent is the `sb:` → `em:` id migration: one deterministic pass, made
safe by the gates rather than by gradualism.

1. **Task modules**: `lib/mix/tasks/brain.<name>.ex` →
   `lib/mix/tasks/mind.<name>.ex`; `Mix.Tasks.Brain.<X>` →
   `Mix.Tasks.Mind.<X>`. (Library modules are already `ElixirMind.*` and do
   not move.)
2. **Compatibility shims**: each old `Mix.Tasks.Brain.<X>` becomes a one-line
   delegator to its `Mind` twin, `@shortdoc`-marked deprecated. Removed after
   the window (below).
3. **Live references** — grep is the worklist, per the rename plan's own
   method. Known surfaces: `.claude/skills/*/SKILL.md` (many tasks named in
   procedure steps), `.github/workflows/ci.yml` and `pages.yml`,
   `.githooks/pre-commit`, `.claude/hooks/session-start.sh`,
   `meta/policy/*.md` (**policy edits → `mix mind.contract` recompile of
   `CLAUDE.md` in the same commit**), `meta/tutorials/*`, `meta/flows/*`,
   `meta/evals/*`, plan/analysis bodies with live task mentions, and
   `mix.exs`/`README.md`.
4. **Frozen surfaces stay frozen** — thread bodies and route-tag *prose* are
   never edited. Exception, per rename-plan Decision 3 precedent: `<routes
   ref="… lib/mix/tasks/brain.<x>.ex">` **path refs** must be updated if any
   exist, because `mix mind.route_tags` fails CI on unresolved paths (audit
   during execution; the id-migration handled the same case).
5. **Generated artifacts** regenerate, never hand-edited: contract, registry,
   code-map, dev-history, lineage, route-tag logs.

## Scope boundaries

- **No library-module changes** (`ElixirMind.*` already correct).
- **No id or namespace-prefix changes** (`em:` untouched).
- **No skill renames** (skills are named by function, not by the task
  namespace).

## Open questions (for ratification)

- **Window length** for the `brain.*` shims — one merged PR later? A dated
  window? (Proposal: remove in the PR that follows the flip, once the
  operator has run a session against `mind.*` without friction.)
- **External callers**: do any Routines, hooks, or automation outside this
  repo invoke `mix brain.*` by name? (The session-start hook and CI are
  in-repo and covered; the `/research` Routine's prompt should be audited.)
- **`mix brain.contract` in muscle memory**: keep a permanent `brain.contract`
  → `mind.contract` alias for the single most-typed task, or clean break?

## Build order

1. Ratify (operator) — including the open questions above.
2. Flip task modules + shims; update `lib/` internal references; tests green.
3. Grep-driven live-reference sweep (skills, CI, hooks, policies, docs);
   regenerate all artifacts; route-tag path-ref audit.
4. Full gate suite; merge; open the shim-removal follow-up.
