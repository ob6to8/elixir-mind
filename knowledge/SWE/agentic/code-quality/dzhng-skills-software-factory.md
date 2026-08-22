---
id: em:c1773c
type: reference
title: "dzhng/skills — a software-factory skill library for autonomous agent runs"
description: An MIT-licensed, harness-agnostic library of composable Claude Code/Codex/Cursor skills implementing a map-unknowns-then-spec-then-build-unattended loop, with review gates (choices ledger, screenshot critique) standing in for reading the diff.
resource: https://github.com/dzhng/skills
provenance: "dzhng/skills README, fetched 2026-08-21"
tags: [agentic-coding, skills, spec-driven-development, autonomous-agents, code-review, claude-code]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# dzhng/skills — a software-factory skill library

Danny Zhang's personal library of domain-agnostic agent skills, reused across
projects and installed with `npx skills add dzhng/skills` into any harness
that supports skills — Claude Code, Codex, opencode, Cursor, and, per the
README, "70+ others." MIT-licensed. The framing is explicit about the shift
it targets: "Software is moving from tasks to **factories**: agents that
pursue a goal autonomously until the output can be trusted. The hard part
isn't breaking the goal into tasks — it's breaking it into **independently
verifiable pieces**, and knowing where the pieces even are."

## The governing metaphor: fog of war

Treat an unscoped feature as unmapped terrain: map it, carve it into
territories that build and verify in isolation, and recursively re-slice
whatever the mapping still hides. Planning does not stop when the spec is
written — "the spec is a living document, updated and re-sliced mid-implementation
whenever the work teaches the agent that the plan is stale." Every sliced
piece proves itself — architecture review, code review, visual review against
a baseline — before the loop advances, so each iteration gets "less wrong"
rather than more code.

## The full loop

Four stages, chained for a large feature:

1. **`/explore-unknowns`** — interviews the operator quadrant by quadrant,
   returning rendered options and decision tables to react to rather than
   asking the operator to imagine the feature unprompted.
2. **`/write-spec`** — mostly transcription of decisions already made in step
   1, breaking the feature into independently verifiable, human-reviewable
   slices with API seams and playable checkpoints; genuinely new decisions get
   asked about rather than assumed.
3. **Build** — `/goal /implement-spec specs/<feature>` puts the harness into
   unattended loop mode; the spec drives implementation slice by slice, with
   `/review`, `/screenshot-critique`, and `/compare-screenshots` firing
   automatically on each slice and the plan re-slicing itself when
   implementation proves it stale. One unattended Codex run is cited pursuing
   a single goal for 1 day 16 hours on this loop.
4. **Review the choices, not the diff.** The run consolidates
   `specs/<feature>/choices.md` — every decision the agent made where the
   spec was silent, ranked least-confident first — as the actual review
   surface. "Every time the AI writes code, you audit what it chose," not the
   line-by-line diff.

Stated budget: 30 minutes to a few hours on the bookend steps (explore, write
the spec, and the final choices review); the middle runs unattended, scaling
from a couple of hours for a small feature to two or three days for a large
one.

## À la carte use

Individual skills fire standalone outside the full loop: `/explore-unknowns`
to sweep for angles at the end of an ordinary discussion, or `/review`
(refactor-clean → code-review → write-docs) followed by `/audit-choices` on
any ad hoc change that touched more than expected — "when the diff is too big
to read, the choices ledger is how you still understand what is now in your
codebase."

## The skill catalog

Four categories:

- **Engineering** — the loop's own skills (`explore-unknowns`, `write-spec`,
  `implement-spec`, `close-spec`, `refactor-clean`, `write-tests`,
  `audit-performance`, `write-docs`, `code-review`, `audit-choices`, `eli5`,
  `review`) plus two second-agent-as-reviewer skills (`codex`, `claude`) and a
  `marketing-pages` rulebook.
- **Visual review** — `compare-screenshots` ("judge which image is *less
  wrong* against a target you establish"), `screenshot-critique` (an unprimed
  subagent as a second set of eyes, mandatory before declaring a visual bug
  fixed), `preview-shots`.
- **Authoring** — `write-skills` and `eval-skills`, for keeping the skill
  library itself sharp (triggers, progressive disclosure, blind-run evals
  against golden cases).
- **Graphics** — a `renderer` skill for WebGPU/three.js work.

## Reading against this bundle

The loop's shape — map unknowns, write a spec as a living document, build
unattended behind review gates, audit choices instead of diffs — parallels
this bundle's own
[agent development methodology](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md)
(test-first, atomic PRs, review-gated) and the operator's structured-plan-body
discipline: both treat the spec as the artifact worth reviewing and the diff
as downstream of it. The `write-skills`/`eval-skills` pair is a second
data point (alongside this bundle's own
[skill body layout evaluation](/meta/evals/skill-body-layout-ab.md)) for
treating a skill's own prompt design as something to author and eval
deliberately rather than write once and leave.

# Citations

- dzhng/skills README — <https://github.com/dzhng/skills>
