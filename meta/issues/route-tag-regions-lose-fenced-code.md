---
type: issue
title: "Route-tag regions lose fenced code: materialized sink excerpts drop every code block, and the fidelity gate cannot see it"
description: The region parser never appends fence lines to an open region's content, so nine threads' tagged regions materialize into their sink logs without their code blocks — while the log-fidelity check compares against the same lossy derivation and stays green.
status: resolved
provenance: "Claude Code session (Claude Fable 5), 2026-08-01 — comprehensive repo review"
tags: [meta, issue, route-tags, fidelity, record-layer, tooling]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T10:15:00Z
  channel: agent-authored
  agent: "Claude Code agent, comprehensive-review session"
  why: "confirmed by reproduction during the tooling review; the record layer is silently dropping content the route-tagging policy says is lifted whole"
  from: [/meta/threads/2026-08-01-comprehensive-repo-review-session-1.md]
---

# Route-tag regions lose fenced code

## Resolution (2026-08-01)

Fixed: `parse_line/2` now appends fence-delimiter and fenced-content lines to
an open region via a shared `append_if_open/2` helper (fence state still
suppresses tag/turn matching); `parse_log_section/1`'s h1/h2 boundary search
was made fence-aware too, since a materialized region's own `#`-prefixed
comment lines were tripping it once fences stopped being dropped. Re-run of
`mix brain.route_tags --materialize` rewrote the eleven affected sink docs
fed by the nine threads named below; the round-trip regression test pins it.

## Summary

`ElixirMind.RouteTags.parse_regions/1` is fence-aware so that `<routes>`
syntax *inside* a code block does not count as a tag — but the implementation
drops the fenced lines from the region entirely. In `parse_line/2`
(`lib/elixir_mind/route_tags.ex:153-207`), the branch that toggles fence state
and the branch that skips fenced lines both return without appending the line
to the open region's content. A tagged region containing a code block
therefore parses as the region *minus the code*, and everything derived from
the parse inherits the loss.

## Reproduction

A minimal body — a `<routes ref="em:abcdef">` region containing prose, a
three-line ` ```elixir ` fence, and closing prose — parses to
`region.content` of `["Before the code.", "", "", "After the code."]`: the
fence delimiters and the fenced line are gone.

## Blast radius

Nine live threads carry fences inside tagged regions (scan of
`meta/threads/*.md` for ` ``` ` between `<routes` and `</routes>`,
2026-08-01): `2026-07-09-github-pages-knowledge-base-site`,
`2026-07-09-news-routine-issue-and-featuring`,
`2026-07-13-branch-lifecycle-tutorial-and-main-catchup`,
`2026-07-13-resource-attribution-property-spec-and-build`,
`2026-07-17-vercel-eve-comparison-and-jido-host-plan`,
`2026-07-26-living-text-present-tense-policy`,
`2026-07-28-code-driven-av-production-and-declared-cadence`,
`2026-07-29-elixir-comprehension-tutorial`,
`2026-07-31-survey-batch-intakes-and-review-pr-skill-audit`. Every sink log
those threads feed holds excerpts missing their code blocks, against the
[route-tagging policy](/meta/policy/route-tagging.md)'s "each block lifting
the tagged regions whole".

## Why the gate is blind

`check_log_fidelity/2` compares each materialized block against a
re-derivation by the same parser, so both sides of the comparison lack the
code and the check passes. The structural guarantee the gate provides —
"the log is generated, not hand-kept" — is intact; the guarantee it cannot
provide is that the generation is lossless. `demote_headers/1` already
tracks fence state *inside* region content, which shows the derivation side
was written expecting fences to be present.

## Fix shape

Append the line to the open region's content in both fence branches (fence
state continues to suppress tag/turn matching), then run
`mix brain.route_tags --materialize` once — the nine threads' sinks rewrite
with their code restored, and the PR diff is the review point. Add the
missing regression test: a region containing a fence round-trips whole.
