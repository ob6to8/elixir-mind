---
type: issue
title: "Generated/shared artifacts are recurring merge-conflict magnets across parallel sessions"
description: Worktree isolation prevents working-tree collisions but not merge-level ones — parallel sessions that each regenerate the same generated artifact (CLAUDE.md, registry.md, code-map.md, derived index.md files) 3-way-conflict at merge time, as seen in PRs #97/#98; the fix is to rebuild these files on merge rather than merge them line-by-line, and to lane sessions by domain where they are independent.
status: resolved
provenance: "Claude Code session (2026-07-26) — surfaced by the version-control workflow audit"
tags: [meta, issue, git, merge, generated-artifacts, ci, parallel-sessions]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, version-control-audit session"
  why: "the audit identified a recurring merge-conflict class worth tracking as a problem, distinct from the recommended fix"
  from: [/meta/threads/2026-07-26-version-control-audit-and-response-format-policies.md, /meta/threads/2026-08-02-retrieval-spike-doma-intake-and-static-embeddings.md]
---

# Generated/shared artifacts are recurring merge-conflict magnets

## Summary

Sessions run in isolated worktrees, which prevents *working-tree* collisions but
not *merge-level* ones. When two sessions each touch a **generated or shared
artifact**, the second PR to merge conflicts. The prime magnets are the files
every session tends to regenerate:

- `CLAUDE.md` (compiled from `meta/policy/*.md`)
- [`meta/registry.md`](/meta/registry.md) (compiled from on-disk ids)
- `meta/code-map.md` (compiled from `lib/` docstrings)
- derived `index.md` listings

This is not hypothetical: PRs **#97** (`pr-64-merge-conflicts`) and **#98**
(`pr-70-merge-conflicts`) exist specifically to resolve this class. It maps
directly to the "give each AI its own lane / merge-conflict hell" advice weighed in
the [version-control audit](/meta/analysis/version-control-workflow-vs-trunk-based-reference.md).

## Why it happens

These files are **re-derivations**, not hand-authored source. Two sessions that both
run `mix brain.registry` produce two *correct* but textually different registries
against a moving id set; git has no way to know the right resolution is "re-derive
from the merged inputs," so it reports a line conflict. Merging them by hand is
busywork and error-prone — the freshness `--check` gates will reject a hand-merge
that does not match the true re-derivation anyway.

## Candidate fixes (a plan should pick among these before implementation)

1. **Rebuild-on-merge.** A `.gitattributes` merge driver for the generated files
   that runs the generator and takes its output, instead of 3-way-merging text. The
   merge just re-derives the artifact from the merged inputs.
2. **Regenerate-in-CI postsubmit.** Let the conflict resolve to either side, then a
   post-merge job runs the generators and commits the corrected artifacts. Simpler to
   wire; costs an extra trunk commit per conflicting merge.
3. **Lane by domain.** Where sessions are genuinely independent, scope them so they
   do not touch the same source inputs — the "own lane" advice. Reduces frequency but
   does not eliminate the class (any two sessions that add ids both move the registry).

Options 1 and 2 are the structural fixes; 3 is complementary. Design and build order
belong in the
[gate-suite hardening plan](/meta/plans/gate-suite-hardening-review-depth.md) or a
dedicated plan when this is picked up.

## Resolution condition

`status: resolved` once conflicts on the generated artifacts no longer require a
hand-merge — a merge driver or a post-merge regeneration step is in place and pinned
by a test or a demonstrated conflicting-merge that resolves cleanly.

## Resolution (2026-08-04) — candidate fix 1, rebuild-on-merge

Implemented as the merge-driver shape, operator-directed after this class hit
the same session twice in one day (and a parallel session independently, on
the same gold-set table):

- **`.gitattributes`** (committed) assigns the five whole-file generated
  artifacts — `CLAUDE.md`, `meta/registry.md`, `meta/code-map.md`,
  `meta/flows/lineage.md`, `beliefs/glossary/index.md` — a **`regen`** merge
  driver: resolve as `ours` at merge time, then re-derive. Correctness is not
  the driver's job: the pre-commit/CI **freshness gates already reject a merge
  commit whose generated artifacts are stale**, so the driver only removes the
  useless hand-merge, and the re-derivation restores truth.
- **`mix brain.regen`** (new task) re-derives all committed generated
  artifacts in one motion — contract, registry, code map, lineage views,
  glossary index, route-tag excerpt logs, dedup-probe baseline — the
  post-merge step the driver assumes.
- **The issue's "derived `index.md` listings"** get git's built-in **`union`**
  driver (no configuration needed): the observed conflict is always two
  sessions inserting entries at the same anchor, and union keeps both sides'
  lines. A same-line double-edit would duplicate rather than conflict — a
  visible-in-review failure accepted in exchange for eliminating the common
  case.
- **Wiring:** the `regen` driver needs per-clone config; the SessionStart hook
  (`.claude/hooks/session-start.sh`) sets `merge.regen.driver=true` beside its
  existing `core.hooksPath` config, so every web session has it. A clone
  without the config falls back to git's default text merge — no worse than
  before. The [sync skill](/.claude/skills/sync-branch-with-main/SKILL.md)'s
  conflict step now names the driver and the `mix brain.regen` follow-through.
- **Pinned by the demonstrated conflicting merge** the resolution condition
  asks for: a scratch repo with both sides appending different lines to a
  `merge=regen` registry and a `merge=union` index — previously two conflicts —
  merges with exit 0, the registry resolved as ours and the index holding both
  entries.

Out of scope, deliberately: `meta/evals/dedup-probe.md` (a hand-kept gold set
whose single-line `attribution.from` list collides as a same-line edit, where
union would duplicate a YAML key) and `meta/matters.md` (row order is
semantic). Their append conflicts remain the sync skill's ask-the-operator
case. Candidate fix 2 (postsubmit CI regeneration) was declined — it spends a
trunk commit per conflict for what the driver does at merge time; fix 3
(laning) remains complementary and unbuilt.
