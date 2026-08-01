---
type: plan
title: "Two-level methodological guidance for agents: canonical in the brain, vendored into repos"
description: Give the operator's stricter development methodology (TDD-first, atomic reviewed PRs) a two-tier storage design — the canonical methodology doc lives in this brain as ratified knowledge, a lean compiled block of it is vendored into each consuming repo's CLAUDE.md, and each repo keeps its own specifics beneath the block — because user-level memory does not reach cloud sessions and only repo files bind every agent everywhere.
status: accepted
provenance: "Claude Code session (Claude Fable 5), 2026-08-01 — designed from the TDD research spike, the dzombak captures, and the current Claude Code memory-hierarchy documentation"
tags: [meta, plan, methodology, agent-guidance, claude-md, tdd, atomic-prs, distribution]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T18:05:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "the operator asked to figure out how to create two levels of methodological guidance for agents and where and how each should be stored"
---

# Two-level methodological guidance for agents

## Problem

The operator is adopting a stricter development methodology for agent-driven
work — TDD-first, smaller and better-reviewed pull requests (the current
pattern is "large and somewhat reviewed") — and it must bind **every** agent
session across repos, not just sessions in this repo. Today there is no home
for that guidance: this brain's contract governs only this repo; other repos
carry ad-hoc `CLAUDE.md` files or nothing; nothing global exists.

Three facts constrain the design:

- **User-level memory does not reach cloud sessions.** `~/.claude/CLAUDE.md`
  loads only on the local machine; Claude Code on the web loads managed policy
  and the repo's own files (current memory docs, checked 2026-08-01). The
  operator works substantially in cloud sessions, so a global tier stored only
  in user-level memory is silently absent exactly where supervision is
  thinnest. Only files *in the repo* bind everywhere.
- **Guidance must stay lean.** Official guidance caps a `CLAUDE.md` near 200
  lines with the cut test "Would removing this cause Claude to make
  mistakes?"; [Gorman](/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md)
  makes the same point from the context side (rule-stuffing exhausts effective
  context); [Dzombak's streamlining](/knowledge/SWE/agentic/context-engineering/streamlining-user-level-claude-md.md)
  is the worked example — keep principles the product doesn't already embody,
  drop restatements of built-in behavior.
- **The methodology itself is knowledge and should live where knowledge
  lives.** Rationale, evidence, and the full prescriptive text belong in the
  brain (ratified, id-carrying, queryable, one update point) — repos should
  consume a *derived* condensed form, per
  [fit each layer to its purpose](/meta/doctrine/fit-each-layer-to-its-purpose.md)
  and [derived views stay disposable](/meta/doctrine/derived-views-stay-disposable.md).

## Current state

```
guidance today
├── elixir-mind ............ CLAUDE.md compiled from meta/policy/ (this repo only)
├── other repos ............ ad-hoc CLAUDE.md or none; no methodology tier
├── ~/.claude/CLAUDE.md .... whatever it holds binds local sessions only
└── cloud sessions ......... repo files + managed policy only; no operator tier
```

## Desired state

```
guidance after
├── elixir-mind (canonical tier — the source of truth)
│   ├── knowledge/SWE/agentic/code-quality/
│   │   └── agent-development-methodology.md ... type: methodology, em: id
│   │       ├── full prescription + rationale links (the readable doc)
│   │       └── ## The vendorable block ......... fenced, ≤60 lines, versioned
│   └── meta/plans/two-level-agent-methodology-guidance.md (this plan)
├── each consuming repo (global tier, vendored + repo tier, authored)
│   └── CLAUDE.md
│       ├── ## Development methodology (global tier vN) .. pasted block, verbatim
│       │     (version line names source em: id + date — drift is detectable)
│       └── ## Repo specifics ........ test/build commands, layer map, deviations
└── operator's machines (optional local backstop)
    └── ~/.claude/CLAUDE.md ......... same block, for repos not yet vendored
```

## The tier split — what belongs where

| Belongs in the **global block** | Belongs in the **repo tier** |
|---|---|
| The TDD loop: red before green, one behavior at a time; tests are the spec | The commands: how to run tests, lint, format, build *here* |
| Tests are load-bearing: never weaken, skip, or special-case a test to pass; a wrong test is fixed with its reason stated | The test-layer map: which suites exist, what's fast/slow, purity conventions (`async`, fixtures) |
| Test architecture: test features/contracts, not internals; mock IO boundaries, never your own code (matklad tier) | Which mocking/property libraries are in play (Mox, StreamData) and their seams |
| Atomic delivery: one concern per PR; every commit compiles and passes tests; small reviewable diffs | Branch/PR conventions, review checklist, CI gate list |
| Stop-and-reassess discipline (bounded attempts, document failures) | Known project gotchas |
| Explicit-deviation rule: a repo may override a global rule only by naming it | The deviations themselves, each naming the global rule it overrides |

The global block is language-agnostic; an **Elixir annex** (a few lines:
ExUnit loop flags, Mox explicit-contracts stance, doctests, StreamData) is
part of the canonical doc and vendored only into Elixir repos.

## Boundary decisions

- **The brain owns content; repos own bindingness.** The methodology doc is
  ratified knowledge here; a repo's pasted block is what actually binds its
  sessions. The version line is the joint between them.
- **Vendor into `CLAUDE.md`, not `.claude/rules/`** (recommended): one file
  works identically across local, cloud, and other agent harnesses that read
  `CLAUDE.md`/`AGENTS.md`; rules-file layout is a per-repo refinement, not the
  default.
- **No mechanism restates product behavior.** The block carries only what the
  product doesn't do: TDD is exactly the practice current Claude Code docs
  don't scaffold (verification-driven, never test-first — checked 2026-08-01),
  so it earns its lines; plan-mode mechanics, codebase exploration, and
  tooling detection don't.
- **Drift handling is versioned-vendoring first, tooling later.** Phase 1 is a
  hand-pasted block with a version line (drift visible by comparing versions).
  A `mix brain.methodology` compile + `--check` gate is deferred until the
  block actually churns — per the coding-standards admission rule, a gate
  earns its keep by signal over upkeep.
- **elixir-mind itself is exempt from vendoring.** Its contract already
  governs its sessions; the methodology doc cross-links the
  [repo testing methodology](/knowledge/SWE/testing/elixir-mind-testing-methodology.md)
  rather than layering a second rule surface here. Whether this repo's own
  contract should additionally adopt an atomic-PR policy is an open question
  below, decided separately.

## Build order

1. ~~Ratify this plan and the methodology doc~~ — **done 2026-08-01**
   (operator ratified both; the
   [methodology doc](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md)
   is the canonical tier).
2. ~~Record the direction and the home-repo rule~~ — **done 2026-08-01**:
   the [verified-increments doctrine](/meta/doctrine/verified-increments.md)
   and the [atomic-pull-requests policy](/meta/policy/git-atomic-pull-requests.md)
   bind this repo now; this repo is the methodology's first live test bed,
   since no second repo is currently active enough to pilot.
3. When a consuming repo becomes active (or is created), the operator pastes
   the vendorable block into its `CLAUDE.md` and adds that repo's specifics
   beneath it — the deferred pilot.
4. Operator installs the same block into `~/.claude/CLAUDE.md` on local
   machines (optional backstop for unvendored repos).
5. Fold observed misses back into the canonical doc (bump the block version;
   re-paste into consuming repos).
6. Deferred: `mix brain.methodology` emitting the block from the canonical
   doc, plus a freshness check — only if version churn or multi-repo drift is
   actually observed.

## Decisions

- **Recommended:** canonical `type: methodology` doc in this brain + lean
  versioned block vendored into each repo's `CLAUDE.md` + repo-specific tier
  beneath it + optional user-level backstop locally.
- **Rejected — global tier in `~/.claude/CLAUDE.md` alone:** invisible to
  cloud sessions, the highest-risk surface.
- **Rejected — managed policy as the global carrier:** an org-admin surface,
  wrong fit for a personal methodology and not operator-editable per repo.
- **Rejected — full methodology text vendored into repos:** violates the
  lean-context constraint; repos get the block, the brain keeps the prose.
- **Open questions — all resolved by operator ratification, 2026-08-01:**
  1. Vendored form: **`CLAUDE.md` section** (ratified as recommended).
  2. This repo's contract: **yes** — ratified and executed as the
     [atomic-pull-requests policy](/meta/policy/git-atomic-pull-requests.md),
     shaped per the operator's direction that the matter is the unit and line
     counts never force artificial splits, plus the
     [verified-increments doctrine](/meta/doctrine/verified-increments.md)
     above it.
  3. Pilot repo: **none yet** — no second repo is currently active; the
     pilot moved to build-order step 3, triggered when one exists. Until
     then, this repo (under the policy) is the methodology's live test bed.
