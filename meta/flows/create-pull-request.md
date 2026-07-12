---
type: note
title: Create-pull-request — capture, glossary, commit, push, PR, in one motion
description: The end-to-end flow for a /create-pull-request run — the skill-to-skill composition (/capture, then /add-to-glossary over its thread doc, then git and the PR), why the ordering makes the session record ship inside the PR it describes, the touch-sequence, actor boundaries, and which parts of the spine are pinned by delegated scenarios versus external to any offline oracle.
tags: [meta, governance, pull-request, capture, glossary, git, flow, workflow]
timestamp: 2026-07-12
---

# Create-pull-request — capture, glossary, commit, push, PR, in one motion

The connective doc for the brain's shipping flow: how a working session's
changes, its frozen record, and the glossary terms it introduced leave the
sandbox as **one** pull request. This is the flow that makes the others
durable — `/capture` writes the record, but `/create-pull-request` is what
gets it onto `main`. It narrates the composition and points at the artifacts;
the procedure lives in the skill.

> **The artifacts (point, don't restate):**
> - **Rules** → [merge-strategy](/meta/policy/merge-strategy.md) (true merge,
>   never squash/rebase — the commit graph is a provenance layer) ·
>   [session-capture](/meta/policy/session-capture.md) ·
>   [persist-plans](/meta/policy/persist-plans.md).
> - **Procedure** → the [`/create-pull-request`
>   skill](/.claude/skills/create-pull-request/SKILL.md), composing
>   [`/capture`](/.claude/skills/capture/SKILL.md) and
>   [`/add-to-glossary`](/.claude/skills/add-to-glossary/SKILL.md).
> - **Delegated mechanism + proof** → the capture flow's spine is pinned by
>   [`test/second_brain/capture_scenario_test.exs`](/test/second_brain/capture_scenario_test.exs)
>   (see [the capture flow doc](/meta/flows/session-capture.md)); glossary
>   files land in the ordinary id gates.
> - **Why true merges** → [why a true merge keeps cited commits
>   reachable](/meta/tutorials/why-a-true-merge-keeps-cited-commits-reachable.md).

---

## 1. The problem

A session that ends with only a diff loses its own story: the thread record
lives in a reclaimable sandbox, the new terms live in the agent's head, and a
PR opened "later" for the capture trails the change it describes. The flow
exists to make one invariant hold: **everything a session produced — the
change, the frozen record of the conversation that produced it, and the
glossary terms it coined — ships in the same PR.** Invoking the skill *is* the
authorization to open that PR; there is no second confirmation gate.

## 2. The pipeline — a composition of skills, then git

```
   /create-pull-request
          │
          ▼
   ┌──────────────┐  step 1 — the full /capture skill, to completion:
   │   /capture    │  thread doc + routing ledger + route tags,
   └──────┬───────┘  then route_tags --materialize && route_tags
          │  meta/threads/YYYY-MM-DD-<slug>.md (+ sink logs, threads index)
          ▼
   ┌───────────────┐  step 2 — /add-to-glossary over that thread doc:
   │/add-to-glossary│  new/updated per-term concepts + hub + index
   └──────┬────────┘  (then brain.id / brain.registry for new ids)
          │  glossary/*.md, glossary.md
          ▼
   ┌──────────────┐  steps 3–5 — survey (status/diff), commit with
   │  git          │  trailers on the designated feature branch, push
   └──────┬───────┘  with backoff on network failure only
          ▼
   ┌──────────────┐  step 6 — template detection, GitHub MCP
   │  open the PR  │  create_pull_request; report URL + thread-doc name;
   └──────────────┘  merge (if asked) is a true merge, never squash
```

The ordering is the design: capture runs **before** git so its output is part
of the working changes; glossary runs over the *just-written* thread doc so
the terms and their source ship together.

## 3. The touch-sequence (a canonical run)

| # | Actor | Action | Files touched | Checked by |
|---|-------|--------|---------------|------------|
| 1 | operator | Invoke `/create-pull-request` (this *is* the PR authorization) | — | — |
| 2 | agent | Run `/capture` to completion (its own full touch-sequence — see [the capture flow](/meta/flows/session-capture.md)); skip only if nothing substantive to capture | `meta/threads/…`, sink concepts' excerpt logs, `meta/threads/index.md` | delegated scenario + `brain.route_tags` |
| 3 | agent | Run `/add-to-glossary` over the step-2 thread doc; a no-op is legitimate if no term clears the bar | `glossary/*.md`, `glossary.md`, `glossary/index.md` | id gates (`brain.id` → `brain.registry` → `brain.verify`) |
| 4 | agent | Survey: `git status` / `git diff`; confirm the branch is the designated feature branch, never a default | — | editorial |
| 5 | agent | Commit (explicit paths; atomic; trailers per the environment) | git objects | convention |
| 6 | agent | Push `-u origin <branch>`; backoff-retry network failures only | remote | convention |
| 7 | agent | Detect a PR template; open the PR via the GitHub MCP tools; report the URL **and** the thread doc's assigned name | GitHub PR | editorial |
| 8 | operator | Review; optionally ask to merge → **true merge commit** (`merge_method: "merge"`) | `main` ancestry | policy + editorial |
| 9 | agent | Offer (don't start) PR watching via `subscribe_pr_activity` | — | editorial |

## 4. Actor boundaries

| Actor | Does |
|-------|------|
| **Operator** | invokes (= authorizes the PR); reviews; decides merge and watching |
| **Agent** | captures, glossaries, commits, pushes, opens and reports the PR; merges only when asked, and only with a true merge |
| **CI** | runs the full gate suite on the pushed branch — the PR is mergeable only green |

## 5. Invariants

- **One PR carries the change, its record, and its terms.** Capture and
  glossary run before the commit, never after the push.
- **Invocation is authorization** — for the PR only. It does not authorize a
  merge; merging is a separate operator ask.
- **Never commit to a default branch; never squash- or rebase-merge.** Cited
  SHAs must stay reachable; session trailers must survive.
- **Honest no-ops.** An empty session skips capture; a term-less thread skips
  glossary — neither is padded to show activity.
- **Report the record's name.** The operator ends the flow knowing the
  `meta/threads/…` path without digging.

## 6. Verify — a delegating spine

This flow adds almost no mechanism of its own; its spine is **borrowed**, and
so is the proof. The capture half is pinned by the capture scenario and the
`brain.route_tags` gate; the glossary half lands in the id gates like any
filed concept; the pushed branch must pass the entire CI suite before the PR
can merge. What has *no* offline oracle is the git/GitHub half — branch
discipline, template detection, the true-merge method — which is exactly why
those live as skill guardrails and policy (checked editorially, and by the
operator at review) rather than as an ExUnit scenario. A scenario for this
flow would test a mock of GitHub, proving little; the real enforcement point
is CI-on-the-branch plus the merge-strategy policy at the moment of merge.

**Reference instance.** Any merged PR on this repo is a worked instance; the
merge commits on `main` (`git log --first-parent`) each trace to a session
whose thread doc shipped inside the PR it records.
