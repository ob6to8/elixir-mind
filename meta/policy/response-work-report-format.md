---
type: policy
title: Report work in tables, not prose
description: The delivered-response format for a turn that produces or modifies artifacts or reaches a decision point — created/modified tables, actions already taken reported in the past tense, blocking questions and non-blocking options as separate tables — with prose reserved for reasoning and the confirm-before-irreversible boundary explicitly preserved.
section: filing
order: 14
status: active
tags: [meta, governance, responses, format, workflow, permissions]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, version-control-audit session"
  why: "operator found the audit's What-I-created table more comprehensible than prose and asked to enshrine the shape as a formalized workflow across work topics; written as a policy rather than a plan so it reaches fresh sessions automatically"
  from: [/meta/threads/2026-07-26-version-control-audit-and-response-format-policies.md]
---

**When a turn produces work, report it as a ledger.** A response that creates or
modifies artifacts, or reaches a decision point, closes with tabular sections
rather than narrating the same facts in prose. Tables make what-happened and
what's-open scannable; prose buries them.

**Applies when** the turn created/modified files, took consequential actions, or
needs an operator decision. **Does not apply** to conversational turns, quick
factual answers, or single trivial edits — five empty tables are ceremony. Include
only the sections that have content.

| Section | Holds | Columns |
|---|---|---|
| **What I created** | new artifacts | type · doc · why this type |
| **What I modified** | changed files | file · thrust of the change (one line) |
| **Actions I have taken** | what was already done | action · result |
| **Questions you need to answer** | **blocking** — work cannot proceed without an answer | # · question · my recommendation |
| **Your options from here** | **non-blocking** — directions the operator may pick | # · option · what it entails |

**The rules that make it work:**

- **Prose still carries judgment.** Tables are the ledger of *what happened* and
  *what's open*; analysis, reasoning, and recommendations stay in prose. Never
  compress an argument into a cell.
- **Questions and options are different tables.** A question is *blocking* — the
  agent is stuck without an answer. An option is *non-blocking* — the agent could
  proceed and is offering a direction. Collapsing them hides which one it is.
- **Report in the past tense, not the future.** Work the agent is authorized to do
  is **done before the response**, then reported as completed with its result —
  not announced as an intention ("I'll now…") that makes the operator wait a turn
  for nothing.
- **Past-tense reporting never widens authorization.** The act-then-report rule
  applies only to already-authorized work. Anything irreversible, outward-facing,
  or outside what the operator asked for still requires asking **first** — and per
  [session-capture](/meta/policy/session-capture.md), that ask is ordinary chat
  text, never a UI dialog element.
- **State every recommendation.** Each question carries the agent's recommended
  answer, so the operator can ratify rather than re-derive.
- **No duplication.** A matter appears in exactly one section — a blocking
  question is not restated as an option, and a completed action is not repeated in
  prose above the table.
