---
type: issue
title: "Policy index glosses drift silently when a policy's rule changes"
description: A policy edit that changes the rule leaves its one-line gloss in meta/policy/index.md advertising the superseded version — maintain-reserved-files only covers filing a new doc, and no gate compares a gloss against the policy it describes, so the index can hand an orienting session a rule that no longer exists.
status: open
tags: [meta, issue, policy, index, staleness, generated-artifacts]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "the defect occurred in-session — a branch-deletion policy edit shipped with its index gloss still describing the old rule, and neither policy nor gate caught it"
  from: [/meta/threads/2026-07-27-secure-financial-agent-and-projects-namespace.md]
---

# Policy index glosses drift silently when a policy's rule changes

## Summary

[`meta/policy/index.md`](/meta/policy/index.md) carries a one-line gloss per
policy. When a policy's **substance** changes, nothing requires or checks that
its gloss follows, so the index keeps advertising the superseded rule.

The index is a **living surface** — a session orienting itself reads the glosses
before, or instead of, the policy bodies — which makes a stale gloss exactly the
failure
[living-text-is-present-tense](/meta/policy/living-text-is-present-tense.md)
exists to prevent, and the same class as the hand-kept `log.md` files this
bundle purged: it goes stale quietly and is then retrieved and trusted as
current.

## Why nothing catches it

Two gaps, each verified against the tree:

- **[maintain-reserved-files](/meta/policy/maintain-reserved-files.md) is scoped
  to filing.** Its rule is *"after filing, update the directory's `index.md`"* —
  it addresses **adding** a document, not **editing** one whose gloss then no
  longer matches. An edit-in-place leaves the gloss out of scope entirely.
- **No gate compares a gloss to its policy.** The only index-sync check in
  `lib/` is `ElixirMind.Glossary`'s, which re-derives the glossary hub's
  `## Terms` from the term files. Nothing equivalent exists for
  `meta/policy/index.md`, and the freshness gates
  (`contract`/`registry`/`codemap`/`lineage`/`dev_history`) all check *generated*
  artifacts — the policy index is hand-kept, so it is outside every one of them.

## Observed instance

The [git-branch-deletion](/meta/policy/git-branch-deletion.md) policy was
rewritten to scope branch deletion to deliberate cleanup sessions. The policy
body and its frontmatter `description` were updated; the index gloss was not,
and shipped still describing the superseded "deleted on sight" rule. It was
caught only by a later manual read, one PR after the fact.

## Candidate fixes

Listed as alternatives, not a decision — choosing among them is the work this
issue tracks.

| Shape | What it costs | What it leaves open |
|---|---|---|
| **State the rule** in `maintain-reserved-files` — an edit that changes a doc's substance updates its index gloss in the same motion | one policy edit | editorial only; no oracle, so it fails the same way any unenforced rule does |
| **Add a check** — flag a gloss whose policy's `timestamp` is newer than the gloss line's last change | a new gate, git-archaeology in the verifier | noisy: a typo fix bumps `timestamp` without invalidating the gloss |
| **Generate the gloss** from each policy's `description`, as the glossary hub generates `## Terms` | a `mix brain.policyindex --materialize`/`--check` pair | glosses are currently hand-written and richer than `description`; generating them means accepting `description` as the gloss, or adding a dedicated field |

The third is favoured by
[a surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md):
the first two leave the obligation with memory, which fails silently, while
generation removes the obligation entirely. That prior — not an appeal to
consistency — is why this bundle's answer to structural freshness has
consistently been to generate rather than hand-keep. It is also the largest
change, and it forces a decision about whether `description` is allowed to *be*
the gloss.

## Scope

This issue is about `meta/policy/index.md` specifically, where the drift was
observed. Whether the same defect affects other hand-kept `index.md` glosses
across the tree is **unexamined** — that survey is part of the work, not an
assumption of it.
