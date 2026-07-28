---
type: todo
title: "Diagnose why meta/dev-history.md fell six PRs behind"
description: Diagnosed and closed — the lag's cause is the shallow-clone silent no-op, established from the merge graph, but the drift turned out to be within design tolerance rather than a defect, and the committed view was ultimately removed; see the issue it graduated to.
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

> **This todo describes an arrangement that no longer exists.** It was written
> believing `meta/dev-history.md` was a committed view whose check tolerated
> exactly one PR of lag, kept current by a regeneration step in
> [`/create-pull-request`](/.claude/skills/create-pull-request/SKILL.md). All
> three are now false: the check was never bounded, the regeneration step is
> gone, and the view is no longer committed at all. The premises are left as
> written — this is the record of a task, not a live description — and what
> replaced them is in
> [the issue](/meta/issues/dev-history-regeneration-silently-skipped-on-shallow-clones.md).

`meta/dev-history.md` was a generated-but-committed view of the default branch's
merge graph. A branch cannot contain its own merge commit, and the
[staleness analysis](/meta/analysis/dev-history-staleness-and-ci-regeneration.md)
was read as making `mix brain.dev_history --check` tolerant of precisely that
one-PR gap, with `/create-pull-request` step 4 keeping it there: every PR
regenerated the file, so the checked-in copy would never drift past the
unavoidable lag.

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
rather than resolved here. That issue then closed **`resolved`**: measurement
showed the check was unbounded rather than one-PR-bounded and the deployed page
was already re-derived on every push, so the committed copy was carrying no
guarantee — and it was removed entirely rather than patched.
