---
type: todo
title: "Diagnose why meta/dev-history.md fell six PRs behind"
description: The dev-history view is designed to lag by exactly one PR and its CI check skips silently on a shallow clone, which is what web sessions get; the observed lag reached six PRs, and whether that is the silent skip, the regeneration step being missed, or both is undiagnosed.
status: done
provenance: "Claude Code session (2026-07-28) — observed while regenerating dev-history from an unshallowed clone"
tags: [meta, todo, dev-history, generated-artifacts, ci, shallow-clone, gates]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, Kimi K3 weight-release intake session"
  why: "the lag was cleared but its cause was not established, and recording a guess would put a wrong cause into the record"
  from: [/meta/threads/2026-07-28-kimi-k3-weight-release-implications.md]
---

# Diagnose why `meta/dev-history.md` fell six PRs behind

[`meta/dev-history.md`](/meta/dev-history.md) is a generated-but-committed view of
the default branch's merge graph. By design it lags by **exactly one PR** — a
branch cannot contain its own merge commit — and the
[staleness analysis](/meta/analysis/dev-history-staleness-and-ci-regeneration.md)
makes `mix brain.dev_history --check` tolerant of precisely that one-PR gap.
[`/create-pull-request`](/.claude/skills/create-pull-request/SKILL.md) step 4 is
what keeps it there: every PR regenerates the file, so the checked-in copy never
drifts past the unavoidable lag.

On 2026-07-28 the file was **six PRs behind** — stale back through PR #152, missing
#148 and #153 through #158 — and regenerating it from an unshallowed clone produced
39 lines of backlog.

**The suspicious mechanism.** Both `mix brain.dev_history` and its `--check` refuse
to run on a **shallow clone**, and they refuse *quietly*: the task prints
`shallow clone — refusing to derive a truncated dev history` and the check prints
`shallow clone — dev-history check skipped`, then passes. Web-session sandboxes
clone shallowly, so in that environment the regeneration step no-ops and the gate
meant to catch the resulting drift is structurally blind. This is the
[self-referential lag](/beliefs/glossary/self-referential-lag.md) problem meeting a
silent skip — but it is a hypothesis, not a finding.

**Task.** Establish the actual cause before changing anything:

- Check whether the PRs in the gap were opened from web sessions (shallow) or
  local ones, and whether their diffs touch `meta/dev-history.md` at all — a PR
  that ran step 4 successfully would show the file changing.
- Determine whether the shallow refusal is the whole story or whether step 4 is
  also being skipped outright in sessions that *could* have run it.
- Establish whether `git fetch --unshallow` is reliably available in the session
  sandbox (it worked here), since that decides whether "unshallow first" is a
  viable fix or only an occasional one.

**Then choose the fix**, which is a design decision and not part of this task:
make the skip loud (warn visibly, or fail when the clone is shallow *and* the
working tree is a PR branch), have `/create-pull-request` unshallow before step 4,
or move regeneration to a scheduled job against a full clone.

**Done.** The diagnosis ran on 2026-07-28 against the merge graph from an
unshallowed clone. The cause is established: the outcome clusters perfectly by
session rather than by PR, and the one session that changed behavior mid-flight
did so exactly when it unshallowed. That confirms a defect whose fix is a
separate design decision, so the finding and its three candidate fixes are filed
as [dev-history regeneration silently no-ops on shallow clones](/meta/issues/dev-history-regeneration-silently-skipped-on-shallow-clones.md)
rather than resolved here.
