---
type: plan
title: "Transplant the salvageable content from the surviving unmerged claude/* branches"
description: Recover the genuinely-absent content from the six surviving unmerged session branches by transplanting it onto the reorganized main (never plain-merging, which would resurrect dead paths) — four small ports, one large epistemic batch, two confirmed false orphans to delete — closing out the orphaned-branches cleanup.
status: proposed
provenance: "Claude Code session (Claude Opus 4.8), 2026-07-13 — commissioned by the operator after a per-branch content audit of the surviving unmerged branches (recorded in the triage todo)"
tags: [meta, plan, git, branches, cleanup, transplant]
timestamp: 2026-07-13
---

# Transplant the salvageable content from the surviving unmerged `claude/*` branches

## Status & provenance

**Proposed** — commissioned 2026-07-13 immediately after the content audit
recorded in the
[triage todo](/meta/todos/triage-the-six-kept-unmerged-claude-branches.md).
Executes the "port" verdicts from that audit and closes the loop opened by the
[orphaned-remote-branches issue](/meta/issues/orphaned-remote-branches-cleanup.md).

## 1. The problem

Six unmerged `claude/*` branches survived the 2026-07-13 merged-branch deletion.
An audit found real, `main`-absent content on five of them (plus one stray), but
they **cannot be plain-merged**: `main` was reorganized after they were cut
(`SWE/` → `knowledge/SWE/`, `glossary/` → `beliefs/glossary/`, hand-kept
`log.md` files retired). A straight merge would resurrect dead paths and deleted
log files. Each salvage is therefore a **transplant**: copy the useful docs onto
a fresh branch under the new layout, preserving `sb:` ids (identity survives
moves — never re-mint), file by the current tree, and let the source branch be
deleted once its content lands.

## 2. The work, per branch

Verdicts and sizing from the audit (see the triage todo for the full reasoning).

### Ports — bring the content forward

- **`ccr-architecture-notes-csbiuv`** (small) — a 60-line Chroma
  vector-database intake. Transplant to
  `knowledge/SWE/llm-engineering/` (or the nearest existing home); update that
  dir's `index.md`. `main` has no Chroma concept, only passing mentions.
- **`git-fetch-merge-skill-ke7adg`** (small) — the `/sync-branch-with-main`
  skill for merging `origin/main` into the working branch. Port the
  `.claude/skills/sync-branch-with-main/SKILL.md` and add its entry to the
  skills-registry policy; recompile the contract (`mix brain.contract`).
  **Check first** whether the skills-registry-compile plan has since changed how
  skills register.
- **`repo-skills-namespacing-htu3lc`** (small) — a ~100-line tutorial, "the
  agent's branch lifecycle across merged PRs." Transplant to `meta/tutorials/`;
  update the tutorials index. Complements the existing true-merge-reachability
  tutorial and the git-branch-deletion policy.
- **`council-review-secondbrain-oq5e8o`** (small, stray) — a 254-line analysis,
  "council-round protocol suitability" (verdict: integrate as a `/council` skill
  after four ratified bindings). Transplant to `meta/analysis/`; update the
  analysis index. **Note for the operator:** the analysis *recommends* a
  `/council` skill — that recommendation stays a separate, later decision; this
  plan only files the analysis.

### The large batch — its own session

- **`epistemic-artifact-beliefs-eirk0n`** (large) — ~57 files / ~2,240 lines
  absent from `main`: primary-source captures (Doyle 1979, de Kleer 1986, GSN
  Standard v1), layered breakdowns of five prior-art references, a
  belief-decomposition analysis + plan, and ~29 glossary terms. Feeds the active
  [epistemic-overlay plan](/meta/plans/epistemic-overlay.md). **Deferred to a
  dedicated session** — too large to fold into the small-port batch, and the
  ~29 glossary terms must be reconciled against the since-deduped glossary
  (`beliefs/glossary/`, now carrying `sense` fields per the
  glossary-sense-disambiguation plan) rather than copied blind.

### False orphans — ratify deletion, salvage nothing

- **`glossary-thread-docs-zwfk6i`** — its thread doc differs from `main`'s copy
  by one line; the rest was superseded by PR #37 and later glossary work.
- **`glossary-doctrine-policy-lkabog`** (stray) — its doctrine/policy-type
  entries, cross-linking convention, and thread all landed via PR #40 (a
  pre-policy squash merge), which is why ancestry reports "unmerged" while the
  content is present.

## 3. Build order

1. **Small ports batch** (one session): transplant the four port branches'
   content onto a fresh branch under the current layout, preserving ids, updating
   each affected `index.md`, recompiling the contract for the skill. Gates:
   `mix brain.verify`, `mix brain.registry --check`, `mix brain.route_tags`,
   `mix brain.contract --check`, `mix test`. One PR.
2. **Operator ratifies deleting** the two false orphans (`glossary-thread-docs`,
   `glossary-doctrine-policy`) and each port's source branch once its content
   lands. Agents cannot delete refs in this environment (HTTP 403) — deletion is
   an operator step.
3. **Epistemic batch** (separate dedicated session): transplant
   `epistemic-artifact-beliefs`, reconciling its glossary terms against the
   current `beliefs/glossary/` and wiring its analysis/plan to the
   epistemic-overlay plan.
4. **Close the orphaned-branches issue** once every surviving branch is
   ported-or-deleted and the "Automatically delete head branches" repo setting
   is confirmed on.

## 4. Scope boundary

This plan **recovers content and retires branches**; it does not adopt any
proposal the recovered docs contain. The `/sync-branch-with-main` skill files as
a skill (it is procedure, already scoped); the council analysis's `/council`
recommendation and the epistemic batch's plan remain separate ratification
decisions.

## Deferred

- Building the `/council` skill (a separate decision gated on the four bindings
  the council analysis names).
- Acting on the epistemic-overlay / belief-decomposition plans once their docs
  land (tracked by the epistemic-overlay plan itself).
