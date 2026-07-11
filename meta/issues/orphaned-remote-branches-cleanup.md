---
type: issue
title: "Orphaned remote branches: 12 merged undeleted, 9 unmerged untriaged"
description: The remote carries 21 lingering claude/* session branches predating the git-branch-deletion policy — 12 merged (safe to delete on sight) and 9 holding unmerged work that needs operator triage, including the never-merged todo-type work.
status: open
provenance: "Claude Code session (2026-07-11) — follow-up to the git-branch-deletion policy"
tags: [meta, issue, git, branches, cleanup]
timestamp: 2026-07-11
---

# Orphaned remote branches: 12 merged undeleted, 9 unmerged untriaged

## Summary

Before the [git-branch-deletion policy](/meta/policy/git-branch-deletion.md)
existed, merged PR head branches were never deleted, and several sessions pushed
branches whose PRs never merged. As of a pruned fetch on **2026-07-11**, the
remote carries **21** lingering `claude/*` branches (plus `main` and the branch
this issue ships on).

## Merged — delete on sight (12)

Fully contained in `main`'s history; per policy, deleting them loses nothing:

- `claude/add-to-glossary-skill-jz1ewh`
- `claude/concept-collection-live-render-nvx07g`
- `claude/daily-news-inbox-routine-uj0ipu`
- `claude/elixir-testing-methodology-v4ftag`
- `claude/flows-paths-documentation-b6mzee`
- `claude/github-pages-knowledge-base-cytl3h`
- `claude/home-news-filter-inbox-wxqlpj`
- `claude/move-code-deprecated-l4z8y2`
- `claude/news-routine-setup-75q3w0`
- `claude/okf-capture-ledger-tags-4hicil`
- `claude/remove-email-operating-contract-k1sm9g`
- `claude/vector-db-recall-eval-pv7psw`

## Unmerged — operator triage required (9)

These carry commits **not** in `main`; per policy the agent must not delete them.
Each needs a decision: open/revive a PR and merge, or ratify deletion.

- `claude/ccr-architecture-notes-csbiuv`
- `claude/code-review-docs-audit-j9ckd6`
- `claude/epistemic-artifact-beliefs-eirk0n`
- `claude/git-fetch-merge-skill-ke7adg`
- `claude/glossary-thread-docs-zwfk6i`
- `claude/merge-commit-tutorial-u1wnzo`
- `claude/meta-todos-skill-j42my8` — **notable**: contains the `todo` type,
  `meta/todos/` genre, `/todo` skill, and a gate-suite tutorial (3 commits,
  2026-07-10) that never landed on `main`. The vocabulary on `main` has no
  `todo` type — this stranded branch is the only place that work exists.
- `claude/repo-skills-namespacing-htu3lc`
- `claude/second-brain-repo-eval-n9s8tz`

## Also: enable auto-delete

The repository setting **Settings → General → "Automatically delete head
branches"** is not enabled (operator-only; agents cannot change repo settings).
Enabling it makes the policy's merge-time deletion mechanical for all future PRs.

## Resolution criteria

Resolve when: (1) the 12 merged branches are deleted; (2) each of the 9 unmerged
branches is either merged or its deletion operator-ratified — the
`meta-todos-skill` branch decided explicitly (the `todo` type addition would also
need vocabulary ratification); and (3) the auto-delete setting is enabled. Then
set `status: resolved`, note the outcome here, and move the entry from **Open**
to **Resolved** in [the issues index](/meta/issues/index.md).
