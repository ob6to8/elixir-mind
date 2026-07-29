---
type: plan
title: "Post-action read-back: confirm state changes against the source of truth"
description: Wire read-back verification into the development flow at the boundaries where it is actually missing — the git/GitHub tail of /create-pull-request, the /capture write, and the scheduled /research run — while explicitly declining to add it in-tree, where the gate suite already re-derives state from disk and is the batch read-back.
status: proposed
provenance: "Claude Code session, 2026-07-29 — designed from the operator-supplied post-action-verification quote; persisted rather than executed because the policy text is the operator's to ratify"
tags: [meta, plan, verification, workflow, git, github, ci, tooling, agent-output]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, post-action-verification session"
  why: "the read-back prior filed as em:674c8f names a practice with no home in this repo's flow; the gap it closes is concentrated in the git/GitHub tail, and the change proposes a new contract-compiled policy, which is the operator's to ratify"
---

# Post-action read-back: confirm state changes against the source of truth

Grounded in
[a completion claim is not evidence of completion](/beliefs/completion-claims-are-not-evidence-of-completion.md)
(`em:674c8f`): a state-changing action is unconfirmed until a separate read
against the system holding that state returns the expected value.

## The problem

This repository already applies the read-back pattern with unusual rigor — but
only to state that lives **inside the working tree**. Every generated artifact is
written by one command and confirmed by a second that re-derives it from its
sources and byte-compares (`mix brain.contract` → `--check`), every excerpt log is
materialized then re-derived (`mix brain.route_tags --materialize` →
`mix brain.route_tags`), and `/capture` derives its append boundary from the file
rather than recalling it (`mix brain.thread_tail`). That is the two-step property,
implemented ten times over, and it is why the
[freshness gates](/meta/tutorials/the-gate-suite-and-where-it-runs.md) convert
"remember to re-render" from a discipline into a structural guarantee.

The pattern stops at the repository boundary. Everything the flow does to state it
cannot see — the remote, the pull request, the merge, the scheduler — is asserted
from the acting context and never read back. The
[create-pull-request flow doc](/meta/flows/create-pull-request.md) says so
outright:

> "**Mechanism + proof** → composed: the sub-flows' spines (route-tag
> materialization + checks; id → registry → verify) are pinned by their own
> scenarios; the git/GitHub tail (commit, push, PR) is external state with no
> in-repo oracle — CI on the pushed branch is its check."

CI on the pushed branch is a partial oracle at best. It proves *some* commit
reached the remote and passes the suite; it does not prove the pull request's head
is that commit, that the `pr:` stamp shipped inside the PR, that the merge landed,
or that the head branch was deleted. Each of those is currently reported from the
tool call that requested it.

**The repo has already been bitten by exactly this.** The
[daily `/research` Routine issue](/meta/issues/daily-news-routine-runs-not-landing.md)
records scheduled runs whose intended pipeline ends "commit & push" and which
produce no commit. The failure was found by the operator polling `origin/main` two
hours after the fire, and the issue records why it could not be found from inside:

> "Not fully confirmed: from inside a session it was not possible to distinguish
> *\"fired and failed\"* from *\"never fired\"*, because the query tool itself is
> gated."

That is the read-back's absence stated as a diagnosis. An automated run that ends
by reading `origin/main` back and failing loudly when its own commit is not there
would have reported the outcome on the first fire instead of on the operator's
manual audit.

## The scoping decision — this is the load-bearing one

Applied literally, "after any state-changing action, do a read-back call" means
re-reading every file after every `Edit`. That would be ceremony: the edit tool
errors when it fails, and the gate suite re-derives the whole bundle from disk
before anything merges. Adding a per-edit read gains nothing and costs a tool call
on every write.

**The rule: a read-back is owed where the state is outside the working tree, or
where nothing downstream re-derives it. Where a later step already recomputes the
state from the authority, that step *is* the read-back.**

This falls straight out of the belief's own cost bound and it partitions the flow
cleanly:

| State | Authority | Already read back? |
|---|---|---|
| generated artifacts (`CLAUDE.md`, registry, code map, lineage) | the sources on disk | **yes** — the `--check` gates re-derive and byte-compare |
| excerpt logs | the route tags | **yes** — `mix brain.route_tags` re-derives and fails on divergence |
| filed documents, ids, evidence edges | the bundle on disk | **yes** — `mix brain.verify`, `mix brain.registry --check` |
| thread-doc append boundary | the written thread doc | **yes** — `mix brain.thread_tail` |
| the thread doc's *content* after writing | the session transcript | **no** — nothing compares the render against what was delivered |
| the pushed branch | the remote ref | **no** |
| the pull request (head, base, contents) | the PR object | **no** |
| CI conclusion | the workflow job | **partly** — the skill already prefers the job over the check-run |
| the merge | the PR object + `main` | **no** — the merge SHA is reported from the merge call |
| head-branch deletion | the remote branch list | **no** — "confirm deleted" with no stated mechanism |
| a scheduled Routine's commit | `origin/main` | **no** — the failure mode already on file |

Seven rows say "in-tree, covered by a gate". Five say "external, taken on the
acting call's word". The work is entirely in the second group.

## Current-state tree — the `/create-pull-request` tail

Steps 5–9 of [the skill](/.claude/skills/create-pull-request/SKILL.md), with what
each step currently treats as confirmation:

```
5. git commit                    → confirmation: the command exited 0
6. git push -u origin <branch>   → confirmation: the command exited 0
7. create_pull_request(...)      → confirmation: a URL came back
   ├─ report the PR URL          → the URL the call returned
   └─ stamp pr: <N>, commit, push → confirmation: exit 0
                                    (claim: "so it ships inside this PR")
8. offer to watch
9. merge (opt-in)
   ├─ poll get_check_runs        → ~read-back present: prefer actions_get on the
   │                                job when the check-run looks non-terminal
   ├─ merge_pull_request(merge)  → confirmation: the call returned
   ├─ report the merge SHA       → the SHA the merge call returned
   └─ "confirm the head branch deleted" → mechanism unstated
```

Step 9's check-run rule is the one place the pattern already appears — "*its
`status`/`conclusion` and per-step timings are authoritative*" is a read-back
against a more authoritative source, written to fix precisely a stale-read
failure. It is prior art for generalizing, not an exception.

## Desired-state tree

```diff
  5. git commit
+    ↳ read back: git log -1 --format=%H, git status --porcelain
+       assert: HEAD subject is this commit; no intended path left unstaged
  6. git push -u origin <branch>
+    ↳ read back: git ls-remote origin refs/heads/<branch>
+       assert: remote SHA == local HEAD   ← the remote, not the exit code
  7. create_pull_request(...)
+    ↳ read back: pull_request_read(get)
+       assert: head.sha == the SHA just confirmed on the remote;
+               base.ref == default branch; state == open
     stamp pr: <N>, commit, push
+    ↳ read back: pull_request_read(get_files)
+       assert: the thread doc appears in the PR's file list
  9. merge
     poll CI
~      ↳ read back: actions_get(get_workflow_job) on any non-terminal check-run
     merge_pull_request(merge_method: "merge")
+    ↳ read back: pull_request_read(get)
+       assert: merged == true; record merge_commit_sha from THIS read
+    ↳ read back: list_branches
+       assert: the head branch is absent (else delete it, then re-read)
+    report: the SHA and status the read-backs returned, never the merge call's
```

Every added line is a distinct call, issued after the action, against the object
that holds the state, and every one can come back with the wrong answer.

The two smaller flows:

```diff
  /capture, after writing meta/threads/YYYY-MM-DD-<slug>.md
+   ↳ read back: mix brain.thread_tail <path>
+      assert: the printed final block matches the session's last delivered block
+      (the same command already used to find the append boundary — run it after
+       the write as well as before, and compare against the transcript)

  /research, scheduled fresh-session run, after commit & push
+   ↳ read back: git ls-remote origin refs/heads/main  (or the PR object)
+      assert: the digest commit is reachable; on failure, report loudly rather
+      than concluding the run succeeded
```

## File-tree diff

```
meta/policy/
  post-action-readback.md              # NEW — the contract-compiled rule (P1)
  index.md                             # MODIFIED — gloss for the new policy
CLAUDE.md                              # MODIFIED — regenerated by mix brain.contract
.claude/skills/create-pull-request/
  SKILL.md                             # MODIFIED — read-back steps at 5,6,7,9 (P2)
.claude/skills/capture/
  SKILL.md                             # MODIFIED — post-write tail read-back (P2)
.claude/skills/research/
  SKILL.md                             # MODIFIED — landed-on-main read-back (P2)
meta/flows/
  create-pull-request.md               # MODIFIED — the "no in-repo oracle" line
                                       #   is superseded; record what now checks it
meta/issues/
  daily-news-routine-runs-not-landing.md  # MODIFIED — note the read-back step as
                                       #   the detection mechanism this lacked
beliefs/
  completion-claims-are-not-evidence-of-completion.md  # NEW — em:674c8f (done)
```

No new `lib/` module and no new gate in P1–P2. That is a decision, not an
omission — see the rejected alternatives.

## Boundary decisions

- **Which layer holds the rule**: `meta/policy/`, not a skill. Per
  [governance-artifact-routing](/meta/policy/governance-artifact-routing.md), a
  rule that must fire *unprompted, mid-work* — where an agent would not know to go
  looking — belongs in a policy, because only policies compile into `CLAUDE.md`
  and reach every fresh session. A read-back obligation that lived only in
  `/create-pull-request` would be inert for every ad-hoc push.
- **Which layer holds the per-boundary mechanics**: the skills. The policy states
  *that* a read-back is owed and what counts as one; the exact command per
  boundary (`git ls-remote`, `pull_request_read`, `list_branches`) is procedure and
  belongs where the procedure lives, per the flow docs' rules/procedure/mechanism
  split.
- **Who detects a divergence**: the acting session, before the close. A read-back
  that disagrees with the action is a **blocking** item under
  [concerns-block-the-close](/meta/policy/concerns-block-the-close.md) — the flow
  halts and asks, rather than reporting the divergence after the merge.
- **Who owns the reported value**: the read-back. The ledger's *Actions I have
  taken · result* column carries what was read, not what was returned. This is the
  state-change instance of
  [assertions-name-their-basis](/meta/policy/assertions-name-their-basis.md): for
  an action, "checked" means read back from the authority.
- **What stays out**: in-tree state. The gate suite is the batch read-back and is
  not duplicated per-edit.

## Build order

**P1 — the policy (no code).** Write `meta/policy/post-action-readback.md`, run
`/render-contract`, update the policy index gloss. Terse, per the contract's own
brevity constraint; the reasoning lives here and in the belief. This alone
captures most of the value, because it binds every session including ad-hoc ones.

**P2 — the skill steps (no code).** Add the read-backs above to
`/create-pull-request`, `/capture`, and `/research`, quoting the policy verbatim
with a `canonical:` marker per the
[policy-canonical-skill-guidance plan](/meta/plans/policy-canonical-skill-guidance.md)
if that plan has landed by then. Update the flow doc's superseded "no in-repo
oracle" line in the same motion, per
[living-text-is-present-tense](/meta/policy/living-text-is-present-tense.md).

**P3 — deferred: derive the close-out ledger instead of recalling it.** The
work-report tables (*What I created* / *What I modified*) are today composed from
the session's memory of what it did — a recall surface, and
[a surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md).
A `mix brain.changes` reporting task (offline, deterministic, in the
`mix brain.session_init` mold rather than a gate) could print the branch's
created/modified files against `origin/main`, grouped by kind, with each
document's title read from frontmatter — turning the ledger into a derivation.

Build P3 only if P1–P2 leave an observed gap. It is listed here rather than built
because its justification is a hypothesis about recall errors that has not been
measured, and the admission rule asks for signal before upkeep.

## Decisions

**Recommended shape**: one new policy + three skill edits, no new gate, no new
module. The scoping rule (external state only) is what keeps it that size.

**Alternatives rejected:**

- *Make the read-back a gate.* Rejected: the state in question is external
  (GitHub, the remote, a scheduler), which fails the offline half of the
  [admission rule](/meta/policy/elixir-coding-standards.md), and a gate runs
  *before* the action it would need to follow. Gates cover in-tree state and
  already do.
- *Re-read every file after every write.* Rejected as ceremony — the scoping rule
  above.
- *Treat green CI on the pushed branch as the tail's read-back.* Rejected as
  insufficient: it establishes that a commit reached the remote and passes, not
  that the PR head is that commit, that the stamp shipped, or that the merge
  landed. It is a read-back of one row in the table, presented as covering five.
- *Fold the rule into `assertions-name-their-basis`.* Rejected: that policy
  governs how a *delivered assertion* marks its basis; this governs what an
  *agent must do after acting*. Merging them would bury an action obligation
  inside a communication rule, where mid-work it would not fire.
- *File as a doctrine rather than a policy.* Rejected on the routing test: this is
  an enforceable rule with a concrete trigger and a concrete required action, not
  a standing direction that shapes judgment.

**Open questions for ratification:**

1. **Does a failed read-back block the close, or is reporting it enough?**
   Recommendation: block. A divergence between what an action claimed and what the
   authority says is precisely the class
   [concerns-block-the-close](/meta/policy/concerns-block-the-close.md) exists to
   stop from landing in a post-merge report.
2. **Should the `/capture` read-back compare content, or only the tail?** The tail
   comparison is cheap and mechanical; a full content comparison against the
   transcript has no oracle and would be editorial. Recommendation: tail only,
   and say so, rather than implying more coverage than exists.
3. **Should `em:674c8f` be decomposed into atomic beliefs** (the two-step
   property; the observability-does-not-substitute claim; the report-the-read-back
   corollary) once
   [`/extract-into-belief`](/meta/plans/extract-into-belief-skill.md) is built?
   Recommendation: yes, but after that skill exists — hand-splitting now would
   pre-empt the decomposition protocol it is meant to enforce.
4. **P3's fate.** Recommendation: leave deferred until a recall error in a closing
   ledger is actually observed, then build it against that case.
