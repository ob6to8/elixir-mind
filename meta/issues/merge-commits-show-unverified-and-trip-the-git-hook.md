---
type: issue
title: "GitHub merge commits show Unverified and trip the stop hook on every PR"
description: Merge commits created by the GitHub merge button are committed as GitHub <noreply@github.com> and carry no session trailer, so the stop hook reports them as unverified and proposes amending them — a remedy that would rewrite published history the merge-strategy policy protects, on a condition that same policy already classifies as expected.
status: open
tags: [meta, issue, git, hooks, merge-strategy, provenance, false-positive]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "the hook fired on a merge commit mid-session and its proposed remedy would have rewritten main; recorded so a future session recognizes the pattern instead of complying"
  from: [/meta/threads/2026-07-27-secure-financial-agent-and-projects-namespace.md]
---

# GitHub merge commits show Unverified and trip the stop hook on every PR

## Summary

Every PR merged through the GitHub merge button produces a commit like:

```
a522eb6  parents: f46b7b9 6b5fab3
         author:    <the operator>
         committer: GitHub <noreply@github.com>
         "Merge pull request #156 from ob6to8/claude/…"
```

GitHub renders it **Unverified**, and the session stop hook flags it and
proposes `git commit --amend --no-edit --reset-author`, or a rebase for earlier
commits, followed by a push.

## Why the proposed remedy must not be run

Three independent reasons, any one sufficient:

- **It rewrites published history.**
  [merge-strategy](/meta/policy/merge-strategy.md) states *"Never rewrite shared
  history."* The flagged commit is already on the default branch.
- **It breaks the provenance layer it appears to defend.** Merge SHAs are cited
  by thread docs, PR bodies, and session reports. Rewriting them orphans every
  citation — the same failure the policy invokes to ban squash-merging. Running
  the fix would do by hand what the merge method exists to prevent.
- **It is not the agent's commit to re-author.** The merge commit is authored
  under the operator's identity and committed server-side by GitHub.

## The condition is already sanctioned

[merge-strategy](/meta/policy/merge-strategy.md) names this case among its known
coverage gaps: *"auto-generated merge commits (`git merge` default messages, the
GitHub merge button) — the harness injects the trailer only into commit messages
Claude authors."* The compensating anchor is documented alongside it — the PR
body carries the session URL, and the thread's `pr:` stamp links back.

So the hook reports a condition the contract classifies as normal. Agent-authored
commits are unaffected: all seven authored in the originating session carried
`noreply@anthropic.com` and the `Claude-Session` trailer.

## Why this is worth tracking

A recurring false positive is not harmless. It fires on **every** PR merge, and
its instruction is specific, imperative, and destructive — a session that
complies rather than checking would force-push a rewritten `main`. The risk is
not the unverified badge; it is a plausible-looking remedy arriving with the
authority of a hook.

## Candidate fixes

Not a decision — the two axes are independent and either, both, or neither may
be worth doing.

| Axis | Shape | Notes |
|---|---|---|
| **Make merges verified** | Enable signed commits for the merge button in repository settings, or merge locally with a signing key rather than through the API | Repository configuration; touches no existing commit. Local merging costs the convenience of the API path that `/create-pull-request` uses |
| **Teach the hook to skip merge commits** | Exempt commits with more than one parent, or committed by `noreply@github.com` | The hook is outside this repo (`~/.claude/`), so it is operator-side and not fixable from here |

The second is the narrower fix and addresses the actual harm — the misleading
instruction — while the first addresses the badge.

## Scope

Observed on this repository's PR-merge path. Whether other hooks propose
similarly destructive remedies on sanctioned conditions is **unexamined**; this
issue does not survey them.
