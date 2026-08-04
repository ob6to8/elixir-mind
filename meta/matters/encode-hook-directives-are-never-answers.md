---
type: matter
title: "Encode hook-directives-are-never-answers as a policy and a sync-skill guardrail"
description: Write the twice-exercised rule — a hook directive is never an answer to a pending blocking question; a hygiene hook firing over a paused hand-authored merge conflict means abort, never resolve — as a meta/policy/ doc compiled into the contract, add the matching guardrail line to /sync-branch-with-main, and flip the tracking issue resolved.
status: open
model: Claude Fable 5
provenance: "Claude Fable 5, /scope-unit-of-work session"
tags: [meta, matter, policy, hooks, merge-conflict, authorization]
timestamp: 2026-08-04
attribution:
  when: 2026-08-04T04:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, /scope-unit-of-work"
  why: "the operator directed the session's open items be turned into matters; this one encodes the agent-failure issue's fix shape"
---

# Encode hook-directives-are-never-answers as a policy and a sync-skill guardrail

The rule is decided and field-tested; only the encoding remains. Substance, per
[the issue](/meta/issues/hook-directive-taken-as-operator-approval.md): *a
generic automation signal (stop hook, CI nudge, scheduled wakeup) carries no
information about the operator's answer to a pending blocking question and must
never be treated as that answer; when a hygiene hook demands a clean tree while
a merge is paused on a hand-authored conflict, `git merge --abort` — never
resolve.* The failure occurred twice in one day in independent sessions (the
retrieval-spike session, corrected by the operator; the fly-shellbox session,
uncorrected), and the abort move was exercised successfully later the same
session — which is what makes this a policy per the
[recurring-miss rule](/meta/policy/elixir-coding-standards.md) rather than a
skill-local note.

Deliverables: a `type: policy` doc under `meta/policy/` (scope: all
hook/automation signals during any operator-gated pause, with the merge-abort
instance as its worked case), `/render-contract`, a matching guardrail line in
[`/sync-branch-with-main`](/.claude/skills/sync-branch-with-main/SKILL.md), and
the issue flipped `resolved` pointing at the policy.

## Model

The policy body is canonical contract-facing prose — the roster keeps policies
at Fable regardless of size, and the rule's final wording is the artifact.
