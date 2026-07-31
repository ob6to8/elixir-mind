---
type: plan
title: "Post-action read-back: confirm state changes against the source of truth"
description: Wire read-back verification into the development flow at the boundaries where it is actually missing — the git/GitHub tail of /create-pull-request and the scheduled /research run — while declining to add it in-tree, where the gate suite is already the batch read-back, and declining a /capture fidelity check outright, because the only thing it could read is material the same session wrote.
status: proposed
provenance: "Claude Code session, 2026-07-29 — designed from the operator-supplied post-action-verification quote; persisted rather than executed because the policy text is the operator's to ratify. Revised 2026-07-31 once the operator supplied the full source thread (em:b01e03) and confirmed the two beliefs' scope"
tags: [meta, plan, verification, workflow, git, github, ci, tooling, agent-output]
timestamp: 2026-07-31
attribution:
  when: 2026-07-29T20:24:35Z
  channel: agent-authored
  agent: "Claude Code agent, post-action-verification session"
  why: "the read-back prior filed as em:674c8f names a practice with no home in this repo's flow; the gap it closes is concentrated in the git/GitHub tail, and the change proposes a new contract-compiled policy, which is the operator's to ratify"
---

# Post-action read-back: confirm state changes against the source of truth

Grounded in two beliefs, and the second constrains the first:

- [a completion claim is not evidence of completion](/beliefs/completion-claims-are-not-evidence-of-completion.md)
  (`em:674c8f`) — a state-changing action is unconfirmed until a separate read
  against the system holding that state returns the expected value.
- [only what the other side produced is evidence](/beliefs/only-what-the-other-side-produced-is-evidence.md)
  (`em:01abda`) — that read counts only if the party holding the state produced
  what it reads; a check built from self-generated material is testimony, and is
  worse than no check because it fails toward *confirmed*.

The second is applied as a test to every read-back proposed below, and it
disqualifies one of them.

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

That is the read-back's absence stated as a diagnosis — and it is the harder of
the two classes the source distinguishes. An in-run read-back would catch a run
that fires and fails; it cannot catch a run that never fires, because there is no
run to hold the check. That case needs the delayed reconciliation pass described
under "the second class" below.

## The scoping decision — this is the load-bearing one

Applied literally, "after any state-changing action, do a read-back call" means
re-reading every file after every `Edit`. That would be ceremony: the edit tool
errors when it fails, and the gate suite re-derives the whole bundle from disk
before anything merges. Adding a per-edit read gains nothing and costs a tool call
on every write.

**The rule: a read-back is owed where the state is outside the working tree, or
where nothing downstream re-derives it. Where a later step already recomputes the
state from the authority, that step *is* the read-back.**

The source draws the boundary in the same place, from the other direction:

> "If you're doing codegen, it's easier. rerun the test or check the diff and you
> know. but anything that touches real systems is where it breaks. issuing a
> refund in your billing system, updating a CRM field, provisioning something,
> moving a ticket, actually sending the email. there's no cheap retry to verify
> any of that."

Almost everything this repo's flow does is the easy case — the bundle *is* the
artifact, and "rerun the test or check the diff" is the entire gate suite. The
`--check` gates are that cheap retry, industrialized. What is left over is the
handful of actions that touch real systems, and the partition is clean:

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

## The evidence test, applied — and the one read-back it kills

[`em:01abda`](/beliefs/only-what-the-other-side-produced-is-evidence.md) supplies
the test each proposed read-back has to pass: *who produced the thing this check
reads?* Running it over the candidates:

| Proposed read-back | Produced by | Evidence? |
|---|---|---|
| `git ls-remote origin <branch>` | the remote's ref advertisement | **yes** — the server's own answer about its own refs |
| `pull_request_read` → `head.sha`, `base.ref`, `state` | GitHub's PR record | **yes** |
| `pull_request_read` → `merged`, `merge_commit_sha` | GitHub, which minted the merge SHA | **yes** — an id we could not have produced |
| `list_branches` after deletion | GitHub's branch list | **yes** |
| `actions_get` → job `conclusion` | the runner | **yes** |
| `mix brain.thread_tail` on the thread doc we just wrote | **us** | **no** — see below |

The last row fails, and it fails in the direction the belief warns about. The
thread doc is a file this session wrote from its own context; re-reading its tail
confirms the bytes reached the disk and nothing more. It cannot detect the failure
the check would exist to catch — a capture that silently dropped exchanges —
because the dropped material is absent from both the render and the reader. It is
the same shape as donk8r's admission about his own logs, which lands squarely on
this brain's record layer:

> "Our session logs are append only and complete, and they're still only the
> agent's account of its own actions, which is precisely the thing you can't verify
> with."

**Consequence for the plan**: the `/capture` step is *not* proposed as a fidelity
check. The session transcript is the only authority for what was delivered, and it
is not readable by the agent — the thread's `session:` URL points at it precisely
because it is "*account-bound … unreadable by agents*"
([session-capture](/meta/policy/session-capture.md)). So capture fidelity has **no
available oracle**, and the honest design is `em:01abda`'s third state rather than
a check that would always pass: the flow reports the file as *written*, never as
*faithful*, and says which of the two it means. This also settles the plan's
earlier open question 2 on principle rather than on cost.

## The second class: actions with no read path, and the run that never fires

Inline verification covers actions that happened and left a trace to read. The
source bounds two cases it cannot cover — "*async writes that aren't visible yet,
and side effects with no read path at all*" — and prescribes "*a delayed
reconciliation pass against the source of truth rather than inline
verification*."

This repo has exactly one instance, and it is the `/research` Routine. A run that
never fires cannot contain its own read-back, and the issue records that even a
*later* session could not settle it, because the query tool was itself gated. The
reconciliation therefore has to be positive and external:

- **Positive, not error-absence.** Ask "is today's digest on `origin/main`?" — a
  fact the remote produced — rather than "did anything report a failure?" Silence
  from a scheduler that never ran is indistinguishable from silence from a
  scheduler that succeeded, which is `em:01abda`'s zero-POST case exactly.
- **External to the run.** The check belongs to something that runs whether or not
  the Routine did. `mix brain.session_init` already runs at session start and
  already reads the bundle; a "no digest for the last N days" line there costs
  nothing and is read by a session that exists.

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

Every added line is a distinct call, issued after the action, against an object
**GitHub or the remote produced**, and every one can come back with the wrong
answer. That is the evidence test passing on all six.

The two smaller flows — note that `/capture` gets vocabulary, not a check:

```diff
  /capture, after writing meta/threads/YYYY-MM-DD-<slug>.md
+   ↳ NO fidelity read-back is available — the transcript is the only authority
+      for what was delivered, and it is not readable by the agent.
+   ↳ report the file as WRITTEN, never as FAITHFUL, and say which is meant.
+      (mix brain.thread_tail stays where it is — deriving the *append boundary*
+       before writing, which is a different job it does correctly.)

  /research, scheduled fresh-session run, after commit & push
+   ↳ read back: git ls-remote origin refs/heads/main
+      assert: the digest commit is reachable; on failure, report loudly rather
+      than concluding the run succeeded
+   ↳ AND, outside the run: mix brain.session_init reports "no digest for N days"
+      — positive evidence, checked by something that runs when the Routine didn't
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
  SKILL.md                             # MODIFIED — written-vs-faithful vocabulary,
                                       #   and why no fidelity check is offered (P2)
.claude/skills/research/
  SKILL.md                             # MODIFIED — landed-on-main read-back (P2)
lib/elixir_mind/
  session_init.ex                      # MODIFIED — "no digest for N days" line,
                                       #   the out-of-run reconciliation pass (P2)
meta/flows/
  create-pull-request.md               # MODIFIED — the "no in-repo oracle" line
                                       #   is superseded; record what now checks it
meta/issues/
  daily-news-routine-runs-not-landing.md  # MODIFIED — record that an in-run check
                                       #   cannot cover a run that never fires
beliefs/
  completion-claims-are-not-evidence-of-completion.md  # NEW — em:674c8f (done)
  only-what-the-other-side-produced-is-evidence.md     # NEW — em:01abda (done)
```

No new module and no new gate in P1–P2 — the only code is a reporting line added
to the existing `session_init`. That is a decision, not an omission — see the
rejected alternatives.

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
- **What counts as an authority**: whatever produced the artifact being read, per
  [`em:01abda`](/beliefs/only-what-the-other-side-produced-is-evidence.md). A
  check reading material this session generated does not qualify, and the policy
  states that as a disqualifier rather than a caution — it is the failure that
  fails toward *confirmed*.
- **What the ledger says when no authority exists**: a third value. Where a
  confirmation is unobtainable, the result is reported as *unverified* with the
  reason, never rounded up to done — and the policy makes that state cheap to
  reach, since a grudging middle value collapses back to two.
- **What stays out**: in-tree state. The gate suite is the batch read-back and is
  not duplicated per-edit.

## Build order

**P1 — the policy (no code).** Write `meta/policy/post-action-readback.md`, run
`/render-contract`, update the policy index gloss. Terse, per the contract's own
brevity constraint; the reasoning lives here and in the belief. This alone
captures most of the value, because it binds every session including ad-hoc ones.

**P2 — the skill steps, plus one reporting line.** Add the six read-backs to
`/create-pull-request`; give `/capture` the written-vs-faithful vocabulary and a
sentence saying why no fidelity check is offered; add the landed-on-`main` check
to `/research`. Quote the policy verbatim with a `canonical:` marker per the
[policy-canonical-skill-guidance plan](/meta/plans/policy-canonical-skill-guidance.md)
if that plan has landed by then. Update the flow doc's superseded "no in-repo
oracle" line in the same motion, per
[living-text-is-present-tense](/meta/policy/living-text-is-present-tense.md).

The one code change belongs here rather than in P3: a **"no digest for the last N
days"** line in `session_init`. It is the out-of-run half of the `/research`
reconciliation, and without it the skill-side check covers only the failure mode
that is already the easier one.

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

**Recommended shape**: one new policy + three skill edits + one reporting line,
no new gate and no new module. The scoping rule (external state only) is what
keeps it that size; the evidence test is what keeps it honest, by removing a
check rather than adding one.

**Alternatives rejected:**

- *Make the read-back a gate.* Rejected: the state in question is external
  (GitHub, the remote, a scheduler), which fails the offline half of the
  [admission rule](/meta/policy/elixir-coding-standards.md), and a gate runs
  *before* the action it would need to follow. Gates cover in-tree state and
  already do.
- *Re-read every file after every write.* Rejected as ceremony — the scoping rule
  above.
- *Add a `/capture` fidelity check against the written thread doc.* Rejected on
  the evidence test, having been proposed in this plan's first draft: the reader
  and the writer are the same context, so the check cannot fail in the case it
  exists for, and a check that always passes is
  [worse than none](/beliefs/only-what-the-other-side-produced-is-evidence.md).
  Replaced by vocabulary — *written*, not *faithful*.
- *Detect a missing `/research` run with an in-run read-back.* Rejected as
  insufficient rather than wrong: it covers fire-and-fail, and the observed
  failure may be never-fire, which no in-run check can reach. Hence the
  `session_init` line, which runs when the Routine did not.
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
2. ~~Should the `/capture` read-back compare content, or only the tail?~~
   **Settled by the evidence test** — neither. Both readings are self-produced, so
   no amount of comparison makes the check evidential. `/capture` gets the
   *written*/*faithful* distinction instead.
3. **Does the third state need a name in the ledger, or is prose enough?** The
   *Actions I have taken · result* column would carry `unverified — <reason>`
   alongside read-back values. Recommendation: name it, because the source's own
   finding is that an unnamed middle state gets rounded up to success under
   pressure. Whether this amends
   [response-work-report-format](/meta/policy/response-work-report-format.md) or
   stays inside the new policy is the open half.
4. **Should `em:674c8f` be decomposed into atomic beliefs** (the two-step
   property; the observability-does-not-substitute claim; the report-the-read-back
   corollary) once
   [`/extract-into-belief`](/meta/plans/extract-into-belief-skill.md) is built?
   Recommendation: yes, but after that skill exists — hand-splitting now would
   pre-empt the decomposition protocol it is meant to enforce. `em:01abda` was
   filed separately rather than folded in because it is a different author's
   different rule, not a conjunct of the first.
5. **P3's fate.** Recommendation: leave deferred until a recall error in a closing
   ledger is actually observed, then build it against that case.
