---
type: policy
title: Which governance artifact to file
description: The discriminator for choosing among the governance types once work is worth persisting — analysis for a reasoned judgment, tutorial for a durable explainer, issue for a problem, matter for work to deliver, plan for a proposed change needing design — sitting downstream of plan-vs-capture's prior question of whether to persist at all.
section: filing
order: 13
status: active
tags: [meta, governance, filing, routing, issues, matters, plans, analysis, tutorials]
timestamp: 2026-08-02
attribution:
  when: 2026-07-26T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, version-control-audit session"
  why: "operator asked whether the file-an-issue-vs-todo-vs-plan decision flow was spelled out anywhere; it was distributed across the type vocabulary with no single procedure, and the decision fires mid-work so it belongs in always-loaded contract context"
  from: [/meta/threads/2026-07-26-version-control-audit-and-response-format-policies.md]
---

**Choosing the artifact is a second question, not the first.**
[plan-vs-capture](/meta/policy/plan-vs-capture.md) answers *whether* to persist
anything: when this session holds the context and can finish the work, the commit
and the thread capture are the record, and a doc is a redundant third copy. Only
once persistence is warranted does this policy apply — *which* governance type.

**The discriminator.** Ask what the thing fundamentally **is**, not how big it is:

| If the thing is… | File it as | Lives in |
|---|---|---|
| a reasoned judgment answering a question, against evidence | `analysis` | [`meta/analysis/`](/meta/analysis/index.md) |
| a durable explainer meant to be read start to finish | `tutorial` | [`meta/tutorials/`](/meta/tutorials/index.md) |
| something *wrong* — a defect, or a live concern about how the brain behaves | `issue` | [`meta/issues/`](/meta/issues/index.md) |
| work to deliver — a plain task or a whole PR-shaped unit, approach already decided | `matter` | [`meta/matters/`](/meta/matters/index.md) |
| a *proposed change* whose design/decisions must be recorded before executing | `plan` | [`meta/plans/`](/meta/plans/index.md) |
| a standing *direction* that shapes judgment without prescribing an action | `doctrine` | [`meta/doctrine/`](/meta/doctrine/index.md) |
| an enforceable *rule* for how the brain operates | `policy` | [`meta/policy/`](/meta/policy/index.md) |

**The pairs that actually get confused:**

- **issue vs. matter** — an issue is a *problem to diagnose* (something behaves
  wrongly; the fix may not be known). A matter is *work to do* (the approach is
  known; it just needs doing). "Merges keep conflicting" is an issue; "wire the
  hook in the session-start script" is a matter.
- **matter vs. plan** — if the *approach* needs deciding, it is a plan; if only
  the *doing* remains, it is a matter. A plan that would contain no decisions is
  a matter.
- **analysis vs. plan** — an analysis concludes with a *judgment* ("X is the
  better shape, and here is why"); a plan commits to *work* ("build X in this
  order"). An analysis whose residue is action may be retyped as a plan rather
  than duplicated.
- **plan vs. policy** — a plan is a *one-off intended change*; a policy is a
  *standing rule*. If it should bind future sessions, it is a policy.

**Persistence and reach are different axes — choose deliberately.** A `policy`
compiles into `CLAUDE.md` and is therefore in **every** fresh agent's context
automatically; every other governance type is discovered only when something goes
looking ([`/priorities`](/.claude/skills/priorities/SKILL.md),
[`/issue`](/.claude/skills/issue/SKILL.md), [`/plan`](/.claude/skills/plan/SKILL.md),
or a link). So a rule that must fire **unprompted, mid-work** — where an agent
would not know to go looking — belongs in a policy; filing it as a plan or tutorial
leaves it inert. Conversely, keep policies **terse**: the contract is loaded in
full every session, so put the rule in the policy and the reasoning, worked
examples, and background in a cross-linked `tutorial` or `analysis`.

**One artifact per matter.** Per [update-in-place](/meta/policy/update-in-place.md),
search before filing: extend the existing doc when one already covers the matter,
rather than creating a near-duplicate in a different genre.
