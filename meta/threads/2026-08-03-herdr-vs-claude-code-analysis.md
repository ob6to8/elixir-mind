---
type: reference
title: 2026-08-03-herdr-vs-claude-code-analysis
description: Compare-and-contrast analysis of herdr against the Claude Code app, expanded with a concrete build for approximating CCR's architecture using herdr plus Fly.io/Shellbox; then a `/sync-branch-with-main` merge and a declined-remediation investigation into a stop hook's commit-signature warning.
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-02–2026-08-03; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped; parsed from the host session log"
tags: [meta, thread, analysis, claude-code, herdr, fly-io, shellbox, git, comparison]
timestamp: 2026-08-03
session: https://claude.ai/code/session_01WnQUE5PtV3SgAwqwbzQVWW
---

# 2026-08-03-herdr-vs-claude-code-analysis

## Where this landed

The operator asked for a compare-and-contrast analysis of herdr (a terminal
multiplexer for coding agents) against the Claude Code app, filed as
[`meta/analysis/herdr-vs-claude-code-app.md`](/meta/analysis/herdr-vs-claude-code-app.md):
herdr is a self-hosted, vendor-agnostic multiplexer that already lists Claude
Code as one of its native backends rather than a rival, so the two overlap on
capability more than they compete on category. The operator then asked to
expand it with the infra needed to approximate the Claude Code app's cloud
(CCR) architecture using herdr plus Fly.io and Shellbox; the analysis grew a
concrete build — splitting compute into an always-on herdr control-plane node
plus disposable per-session VMs cloned from a shared base image (Shellbox
`duplicate` or a Fly Machine/Sprite clone) — mapping each of CCR's four
load-bearing primitives onto a Shellbox/Fly.io equivalent and naming what has
no off-the-shelf answer (org-managed settings injection, native cross-vendor
agent-teaming, CCR's own credential-custody trust boundary). Both passes were
committed and pushed directly to the session branch (no PR yet). The operator
then asked to merge `main` into the branch (`/sync-branch-with-main`): a clean
merge, no conflicts, gates still green. A stop hook then flagged a run of
commits — including the new merge commit — as likely to show "Unverified" on
GitHub; the agent investigated rather than following the hook's suggested
remedy verbatim, found the git identity was already correct and that fixing
it would mean rewriting other sessions' already-published, cited-by-SHA
history (forbidden by this bundle's own merge-strategy policy) for no real
gain, explained that to the operator, and pushed as-is.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Herdr vs. Claude Code app comparison, expanded with a CCR-approximation build (herdr + Fly.io/Shellbox) | closed | [Herdr vs. the Claude Code app](/meta/analysis/herdr-vs-claude-code-app.md) | - |
| Sync branch with main (`/sync-branch-with-main`) | closed | `unrouted` | - |
| Stop-hook commit-signature warning — investigated, remediation declined | closed | `unrouted` | - |

## User

create an analysis compare and contrasting herdr https://herdr.dev/ with the anthropic claude code app

## Assistant

<routes ref="meta/analysis/herdr-vs-claude-code-app.md">
I filed and pushed the analysis comparing herdr and the Claude Code app.

| What I created | Type | Why this type |
|---|---|---|
| [`meta/analysis/herdr-vs-claude-code-app.md`](https://github.com/ob6to8/elixir-mind/blob/claude/herdr-vs-claude-analysis-u1ihhs/meta/analysis/herdr-vs-claude-code-app.md) | `analysis` | a reasoned comparison against evidence (herdr.dev fetched directly; Claude Code facts grounded in this bundle's existing docs), not a plan or a captured reference |

| What I modified | Thrust of the change |
|---|---|
| `meta/analysis/index.md` | added the new analysis to the contents list |

**Bottom line of the analysis:** herdr is a self-hosted, vendor-agnostic terminal multiplexer (persistent PTY sessions, remote/mobile reattachment, a pane UI, a JSON socket API) that can host *any* CLI coding agent; the Claude Code app is one vendor's agent with its own first-party harness (CLI, Anthropic-hosted cloud runtime, desktop/mobile, IDE extensions, experimental peer "agent teams") that already ships persistence and remote access for its own sessions. They overlap on capability (persistence, remote reach, multi-session visibility) more than they compete on category — herdr lists Claude Code as one of its native integrations, so the likelier real-world shape is Claude Code sessions running *inside* herdr rather than one replacing the other.

Commit `521acb7` passed the full gate suite (format, xref, contract/registry/codemap freshness, `brain.verify`, route-tags, glossary, matters, lineage, tests) and is pushed to `claude/herdr-vs-claude-analysis-u1ihhs`. No PR opened — say the word if you'd like one (or want me to run `/capture` first to freeze this session as a thread doc).
</routes>

## User

expand the analysis to describe exactly what you would need to do to get a workflow with herdr and infra that would approximate the primary architecture of the claude code app, possibly using:
https://fly.io/
https://shellbox.dev/#synopsis

## Assistant

<routes ref="meta/analysis/herdr-vs-claude-code-app.md">
I expanded the analysis with a concrete build for approximating Claude Code's cloud architecture using herdr plus infra, and pushed it.

| What I modified | Thrust of the change |
|---|---|
| `meta/analysis/herdr-vs-claude-code-app.md` | added "Approximating CCR's architecture with herdr + infra" — a two-VM-role design (always-on herdr control-plane node + disposable per-session VMs), a table mapping each of CCR's four load-bearing primitives onto a Shellbox or Fly.io equivalent, a 7-step build order, an honest list of what has no off-the-shelf answer, and a Shellbox-vs-Fly comparison for the session-VM role; expanded frontmatter (description, provenance, tags) and source notes accordingly |
| `meta/analysis/index.md` | updated the entry to reflect the expanded scope |

**The core design:** split compute the way CCR actually does but doesn't expose — one small always-on box running herdr's server (the reattach/status layer), plus one disposable VM per agent session cloned from a shared "golden" image. Shellbox's `duplicate` (instant COW clone) or a Fly Machine/Sprite clone stands in for CCR's environment-snapshot→session mechanic; Shellbox's default stop-after-idle mode or Fly's Sprite standby stands in for "reclaimed after inactivity." Three things stay genuinely unreproduced without bespoke work: Anthropic's org-managed settings-injection layer, native cross-vendor agent-teaming (agent teams is Claude-only; herdr's socket API could fake it), and CCR's credential-custody trust boundary — forwarding your own SSH keys into a third-party vendor's VM is a weaker posture than Anthropic's own sandbox guarantee, even where the mechanics look similar.

One grounding gap worth flagging: Fly's own Sprites page returned only a CLI-install stub on every fetch (looks like a JS app shell this tool can't render), so every Sprites-specific claim (checkpoint/restore latency, free standby, Claude Code preinstalled) is sourced from secondary press coverage, not Fly's own docs — called out inline and in the source notes rather than stated as checked.

Commit `2e91d01` passed the full gate suite and is pushed to `claude/herdr-vs-claude-analysis-u1ihhs`. Still no PR opened — let me know if you'd like one.
</routes>

## User

merge main into thread

## Assistant

Merged `origin/main` into this branch — clean, no conflicts (65 files, mostly other sessions' work: the new `scope-unit-of-work` skill, model-roster/matter-register additions, several new matters/plans/threads, a MAST glossary term). `CLAUDE.md` is still current and `mix brain.verify` still passes with only the same pre-existing advisory warnings from before. Not pushed yet — say the word if you'd like this pushed to the branch.

## User

Stop hook feedback:
[~/.claude/stop-hook-git-check.sh]: There are commit(s) on branch 'claude/herdr-vs-claude-analysis-u1ihhs' that GitHub will show as Unverified (missing signature, or committer email is not noreply@anthropic.com):
7a36104 N noreply@anthropic.com
684530d E noreply@github.com
56c5220 N noreply@anthropic.com
4cb6a0c N noreply@anthropic.com
d93d3bd N noreply@anthropic.com
993329a E noreply@github.com
8874610 N noreply@anthropic.com
9ad747e N noreply@anthropic.com
0c2804a N noreply@anthropic.com
acba4a0 N noreply@anthropic.com
0497d0e E noreply@github.com
e895da8 N noreply@anthropic.com
0c0bbd2 N noreply@anthropic.com
24a4e8f E noreply@github.com
bb2d870 N noreply@anthropic.com
cf348c6 N noreply@anthropic.com
5e084d0 N noreply@anthropic.com
26dde42 E noreply@github.com
034d232 N noreply@anthropic.com
d2c95e5 N noreply@anthropic.com
4f5d655 N noreply@anthropic.com
8e5189c N noreply@anthropic.com
2994550 N noreply@anthropic.com
f5aefb2 N noreply@anthropic.com
06ad4fc N noreply@anthropic.com
52e37ea N noreply@anthropic.com
8e13a45 N noreply@anthropic.com
075dc82 E noreply@github.com
e53dc5a N noreply@anthropic.com
86dc3fa N noreply@anthropic.com
3bcff2e N noreply@anthropic.com
a83535e N noreply@anthropic.com
c0f9d15 N noreply@anthropic.com
cae71fa N noreply@anthropic.com
7326b6a N noreply@anthropic.com
53721cc N noreply@anthropic.com
d31069f N noreply@anthropic.com
7a96311 N noreply@anthropic.com
Please run 'git config user.email noreply@anthropic.com && git config user.name Claude', then 'git commit --amend --no-edit --reset-author' for the tip commit, or 'git rebase --exec "git commit --amend --no-edit --reset-author" origin/claude/herdr-vs-claude-analysis-u1ihhs' for earlier commits, then push.

## Assistant

I looked into this before acting on it — the suggested fix conflicts with hard rules I follow, and turned out to be unnecessary anyway.

**What I checked:**
- `git config user.name`/`user.email` are already `Claude <noreply@anthropic.com>`, both locally and globally — the hook's first suggested step is already satisfied, nothing to change.
- The merge commit I made (`7a36104`) has that same identity, identical to my two earlier commits this session (`521acb7`, `2e91d01`) — which are **not** in the hook's flagged list, even though all three are locally unsigned (`git verify-commit` shows no signature on any of them; this sandbox has no signing key, matching this bundle's own documented note that "credentials and signing keys are never inside the sandbox" and signing is deferred to push time).
- That strongly suggests the difference isn't authorship — it's that `2e91d01` was already pushed and picked up a verified signature server-side on push, while `7a36104` is a brand-new local commit that hasn't been pushed yet.

**Why I'm not running the suggested remedy:** the rest of the flagged list is almost entirely pre-existing shared history — other sessions' commits already merged into `main` (`684530d` is the GitHub merge-button commit for PR #242, which will always show `noreply@github.com`; the rest predate this session and are already public). Rebasing to "fix" them would rewrite already-published, cited-by-SHA history across the whole repo — exactly what this repo's own merge-strategy policy forbids ("never rewrite shared history... cited SHAs stay reachable forever"), and I won't do that without you explicitly asking for it. There's also no config change actually needed, so that part of the hook's suggestion was moot here.

I'm going to push the branch as-is and let the same push-time mechanism that verified my earlier commits handle this one too.

Pushed. If GitHub still shows `7a36104` as unverified after this, that's an environment-level signing limitation (not something a config tweak here fixes) rather than a reason to rewrite shared history — let me know if you want me to look further.
