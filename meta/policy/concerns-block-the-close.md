---
type: policy
title: Concerns block the close
description: Once the operator invokes a closing flow (/create-pull-request), any concern the session still holds — process irregularity, improvisation, skipped check, open decision — is a blocker; the flow halts before the irreversible step and the operator chooses the disposition, so a merged close introduces nothing new.
section: communication
order: 7
status: active
tags: [meta, governance, communication, session-workflow, close]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T09:40:00Z
  channel: agent-authored
  agent: "Claude Code agent, communication-guidance session"
  why: "the operator flagged the recurring pattern of closing reports introducing new findings after the merge, and ratified treating them as merge blockers"
  from: [/meta/threads/2026-07-28-communication-guidance-and-banned-phrases.md, /meta/threads/2026-08-02-todo-fold-into-matters.md]
---

**A closing flow ends clean or not at all.** Invoking
[`/create-pull-request`](/.claude/skills/create-pull-request/SKILL.md) is the
operator closing the thread. From that moment, every concern the session
still holds — a process irregularity, an improvisation no policy sanctions, a
check that was skipped, a judgment call left open — is a **blocker**: the
flow halts before the irreversible step and the concern is put to the
operator, instead of surfacing in the report after the merge ("one thing I'd
flag…", "two notes on how I worked…"), which converts a finished close back
into an open thread.

- **The test: would the closing report present it as something the operator
  must react to?** Then it blocks now. Before opening the PR — and again
  before merging, for anything that emerged in between — inventory such
  items; if any exist, stop the flow and present them as blocking questions
  with recommendations, per
  [response-work-report-format](/meta/policy/response-work-report-format.md).
- **The disposition is the operator's.** Fix it now, file it as an
  issue/matter, or proceed accepting it — the agent recommends but does not
  choose. Unilaterally filing an issue and mentioning it post-merge is the
  pattern this policy exists to stop.
- **The session's driving question is answered before the close, not after.**
  When the operator's ask has a success criterion ("does a fresh session now
  see it?"), verifying it is part of the work: it runs before `/capture`, so
  the answer lands in the thread doc and the PR. A post-merge "the answer is
  now yes" is work delivered outside every record.
- **Post-capture chat is outside every record — so the close persists or
  points, never deposits.** The closing report postdates the thread capture:
  nothing said only there is discoverable later, and the operator's memory is
  exactly what this system exists to offload. Beyond the completion facts,
  every sentence in a closing report must point at a durable home — the plan,
  a matter, an issue, the thread doc. Next-session context ("for whenever you
  pick this up, step 2 is…") is the failure signature: that content belongs in
  the artifact [`/priorities`](/.claude/skills/priorities/SKILL.md) reads,
  filed before the close, with the close at most pointing at it. A statement
  with no durable home that doesn't warrant one goes unsaid. The operator
  never has to ask "is this persisted, or does it only exist in this thread?"
- **Merged means done.** The post-merge report announces the completed close —
  PR number, merge SHA, thread doc name — and introduces nothing new. A
  trailing wakeup (a CI wait timer, a stray notification) that fires after
  the merge and only confirms completion is cleared silently, with no report
  at all when nothing is actionable.
- **Scope.** Operator-invoked closing flows. Mid-session reporting keeps its
  existing shape — findings raised while work is still open are ordinary
  content, and raising them *early* is exactly what this policy rewards.
