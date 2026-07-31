---
id: em:428854
type: reference
title: "Graph engineering and verification skills for multi-agent graphs"
description: A practitioner walkthrough contrasting single-loop "loop engineering" with fan-out "graph engineering" (nodes as isolated-context agents, edges as data routing), and working through layered verification — built-in Claude Code skills plus custom standalone/embedded/orchestrated review skills built with Skill Creator — as the fix for a graph's core failure mode, where one bad node silently corrupts the merged result.
resource: https://www.youtube.com/watch?v=H7t3uUp3HVw
provenance: "AI LABS (YouTube channel), \"Anthropic Just Fixed Graph Engineering's Greatest Flaw\"; distilled from the video's transcript and description"
tags: [agents, agentic-loop, multi-agent, graph-engineering, claude-code, verification, skills, code-review, orchestration]
timestamp: 2026-07-31T01:15:00Z
attribution:
  when: 2026-07-31T01:15:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator passed three AI Engineer conference talk URLs to /intake for capture into the brain"
---

# Graph engineering and verification skills for multi-agent graphs

## Summary

The video's framing: "loop engineering" — one agent looping toward a goal
through straight-line work-then-verify steps, each waiting on the last even
when unrelated — is being superseded by "graph engineering": splitting a
task across many agents (nodes) running concurrently, wired together by
edges that route each node's output to the next. A graph is faster (parallel
coverage of the work) and can be cheaper per node (route cheap sub-tasks to
cheap models), but burns far more tokens overall than a single agent, to the
point the video warns API-metered graphs get expensive fast and
subscription-plan usage limits arrive much sooner than users are used to. A
Claude Code "dynamic workflow" is, in this framing, already a graph. The two
named shapes are the **diamond** (fan out to sub-agents, then narrow back
into one agent that synthesizes a single answer) and **fan-in at a barrier**
(the same problem sent to several agents each judging from a different
angle; nothing proceeds until every agent has reported).

The problem graphs have that loops mostly don't: one bad node silently
corrupts the merged output, and because only the finished result is visible,
tracing which node caused it is hard. The video's answer is layered
verification, moving from what Claude Code already does automatically up to
what the practitioner has to build themselves.

## Key terms

- **Node / edge** — a node is one agent doing one sub-task in its own
  isolated context window and reporting back; an edge is what routes one
  node's output to the next node(s), so every node ties into the graph.
- **Standalone skill** — a heavyweight, deep-pass review invoked manually
  once a body of work is finished — example given: a "thermonuclear code
  review" that fans multiple agents over the same code, each checking a
  different security angle, merging every finding into one place.
- **Embedded skill** — a review that fires automatically as part of an
  existing workflow step (e.g. "verify the feature after every
  implementation"), gating completion on passing.
- **Orchestrator skill** — a skill whose only job is running other skills:
  it spins up one agent per review skill, lets them all review in parallel
  in separate context windows, and merges their findings into a single
  report — so a graph node only has to invoke the orchestrator to get a
  multi-angle review fanned out beneath it.
- **Second opinion** — launching a fresh Claude Code session (the `-p` flag)
  carrying none of the building session's context, specifically so the
  review isn't biased by the same reasoning that produced the work; the
  video recommends explicitly pinning this session to Opus since review
  quality is the entire point of the exercise.

## Technical summary

The video's concrete evidence for why the *reviewing* model matters as much
as the graph structure: on the presenter's own community-website build, a
verification skill run on Haiku returned a long list of findings, and the
same skill run on Opus returned far fewer — but reading the reasoning
showed most of Haiku's findings were things left in the code deliberately,
which Opus correctly inferred from surrounding context and Haiku did not.
Inside a graph this gap compounds: a fleet of nodes each running a cheap
reviewer would burn tokens "fixing" things that were never broken, with no
easy way to attribute which node started the cascade — "the node that does
the judging is the one place where saving tokens costs you everything."

Built-in layers in Claude Code, in ascending order of what they catch: every
agent implicitly verifies via tests/error output (catches breakage, not
style or maintainability); the **Verify** skill (an end-to-end behavioral
check); **tool chaining** (Claude runs the project's own check commands,
worth documenting in `CLAUDE.md` so they don't have to be rediscovered each
time); and an optional **code review** skill checking output against a
standards document. Beyond those, the video's recommended build path is the
**Skill Creator** plugin, installed at user scope so it's available across
projects, used to generate a standalone, embedded, or orchestrator skill
depending on when the review should fire. For UI verification specifically,
the video recommends **Chrome Headless Shell** over full
Chrome/Puppeteer/Playwright for a faster repeated check inside a workflow.
Per the video, Anthropic's own team chains four review angles — Code
Review, Simplify, Verify, and a Design skill (checked against a `design.md`
decision record) — behind a single orchestrator skill, so invoking one skill
name is enough for a graph node to get a four-angle review underneath it.

This sits downstream of the existing loop-engineering lexicon in this
bundle —
[the art of loop engineering](/knowledge/SWE/agentic/agentic-loop/the-art-of-loop-engineering.md)
and
[loop engineering went mainstream](/knowledge/SWE/agentic/agentic-loop/loop-engineering-went-mainstream.md) —
as the explicit next step the video names: from one verified loop to many
concurrent nodes, where verification quality becomes the graph's single
point of failure rather than one property among several. See also
[guarding against AI drift](/knowledge/SWE/agentic/code-quality/guarding-against-ai-drift.md)
for the underlying code-review-quality theme this reuses.

What the bad-node failure mode implies for this bundle's own fan-out plans —
where the readiness gate partitions files but not matters — and how the
reviewer-model finding grounds
[capability-matched model selection](/meta/doctrine/capability-matched-model-selection.md)
is analyzed in
[three agent-substrate talks read against this brain](/meta/analysis/agent-substrate-talks-read-against-this-brain.md).

**Scope note.** The video's title and framing attribute a "fix" to
Anthropic, and the description references "Anthropic's article," but no
specific Anthropic blog post or documentation page is linked anywhere in
the video or its description — the searched space here is the video and its
own description only. What is concretely sourced to Anthropic in the
transcript is the practice of chaining Code Review, Simplify, Verify, and a
design skill, attributed to "Anthropic's own team." The rest (loop vs.
graph terminology, the diamond/fan-in shapes, the Haiku/Opus comparison) is
the presenter's own synthesis and experience, not a claim independently
verified against a primary Anthropic source.

# Citations

- Video: AI LABS, "Anthropic Just Fixed Graph Engineering's Greatest Flaw"
  (YouTube): <https://www.youtube.com/watch?v=H7t3uUp3HVw>
- Channel: <https://www.youtube.com/@AILABS-393>
