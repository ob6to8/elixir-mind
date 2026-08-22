---
id: em:d33aaa
type: reference
title: "Git worktrees are great until you forget which one you're running (Wicksipedia)"
description: "A debugging war story — twenty minutes chasing a fix that wasn't taking effect because the app was running from the main checkout, not the Claude Code worktree holding the change — resolved with an fzf-based worktree switcher and a SessionStart hook that auto-creates the matching branch."
resource: https://wicksipedia.com/blog/git-worktrees-are-great-until-you-forget-which-one-youre-running
provenance: "Wicksipedia (Matt Wicks), wicksipedia.com essay, published 2026-03-06"
tags: [git, worktrees, zsh, claude-code, developer-tooling, fzf]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Git worktrees are great until you forget which one you're running

A practitioner's account of the sharp edge underneath git worktrees: "a
worktree is just a directory. There's no magic." The author spent twenty
minutes debugging a fix that appeared not to work — tests passed, the code
looked right, but the running app kept showing the old broken behavior —
because the app was launched from the main repo root while Claude Code's
worktree feature had made the actual edit in
`.claude/worktrees/pricing-calculation-qty-changes`. Every restart just
reloaded unchanged code from `main`. "The code was fine. I was the bug."

## Why worktrees don't "switch" like branches

"With branches, you `git switch` and you're done. Worktrees don't work like
that because each one is its own path on disk, and 'switching' just means
remembering which directory to `cd` into." `git worktree list` surfaces every
worktree, but as a wall of absolute paths sharing one long common prefix —
cheap to produce, expensive to scan.

## The fix: an fzf-backed switcher and a matching hook

A three-line zsh function piping `git worktree list` through `fzf` and
`cd`-ing to the selected path was the first cut; the author then used `git
worktree list --porcelain` (structured, parseable output) to render branch
name and relative path instead of the raw absolute paths, and packaged the
result as a standalone zsh plugin (`git-worktree-switcher`, installable via
Zinit/Oh My Zsh/Antigen or a raw `source`). A second gap — Claude Code's
worktree feature creates the isolated directory but not a matching git
branch — was closed with a `SessionStart` hook that detects a session
starting inside a `/worktrees/` path and runs `git switch -c <dirname>`
(creating the branch if it doesn't already exist), so the worktree directory
name and the branch name stay in lockstep automatically.

The essay's own frame for the detour: "the yak shave is the point" — the tool
exists because the same navigation friction recurred every time a Claude Code
task ran in a worktree, and now costs one `wt` plus a fuzzy pick instead of
manually recalling and typing a long path.

This is a practitioner's UX layer on top of the mechanics already filed as
[git worktrees for parallel AI agents](/knowledge/SWE/version-control/git/git-worktrees-for-parallel-agents.md)
— that document explains what a worktree *is* and why it isolates concurrent
agents; this one is about the specific failure mode of forgetting *which*
isolated directory you are actually standing in, and losing time to it.

# Citations

- Source: <https://wicksipedia.com/blog/git-worktrees-are-great-until-you-forget-which-one-youre-running>
- Plugin repository: <https://github.com/wicksipedia/git-worktree-switcher>
