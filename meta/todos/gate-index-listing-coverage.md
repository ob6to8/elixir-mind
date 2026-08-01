---
type: todo
title: "Gate index-listing coverage: promote the existing advisory check to a hard mix brain.verify failure"
description: A directory whose index.md already exists but omits a doc or subdirectory filed beside it is now a hard mix brain.verify failure, not an advisory warning; a wholly absent index.md stays advisory per OKF conformance, and evals/ (an imported eval-snapshot corpus already outside the taxonomy) is excluded, matching Registry's existing precedent.
status: done
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-01 — surfaced during a terse-brain evaluation that read ElixirMind.Links and found the index-coverage half of it already existed but was non-binding by design"
tags: [meta, todo, tooling, elixir, verifier, index, ci, gates]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, terse-brain-evaluation session"
  why: "operator selected this action from the terse-brain evaluation's options, recommending it as the cheapest, most durable idea the evaluation found"
  from: [/meta/threads/2026-08-01-terse-brain-evaluation-and-index-coverage-gate.md]
---

# Gate index-listing coverage

`ElixirMind.Links` already ran an index-coverage pass as part of
`mix brain.verify`'s output, but both of its findings — a directory with no
`index.md` at all, and a directory whose `index.md` omits something filed
beside it — were purely advisory, by a documented stance ("index coverage is
ultimately editorial"). Running `mix brain.verify` at the start of the
[terse-brain evaluation](/meta/analysis/terse-lang-terse-brain-evaluation.md)
that surfaced this showed the check was live: 13 warnings, all "no `index.md`
at all," concentrated in `evals/` — an imported eval-snapshot corpus with its
own `README`/`LICENSE`/`MANIFEST`, already outside the taxonomy (`Registry`
already excludes it from the stable-identity scan).

**Done when.** A directory's *existing* `index.md` omitting a filed doc or
subdirectory is a hard failure; a wholly absent `index.md` stays advisory
(matching the [OKF-conformance policy](/meta/policy/okf-conformance.md)'s
explicit tolerance); `evals/` is excluded from the hard check.

**What shipped.**

- `ElixirMind.Links` split: `check/1` now covers only link resolution and
  "no `index.md` at all" (both stay advisory); a new `unlisted_errors/1`
  covers "doc/subdirectory filed but not listed in an *existing* `index.md`"
  (hard), excluding `evals/`.
- `ElixirMind.Verifier.run/2` gained rule 9, folding `Links.unlisted_errors/1`
  into its pass/fail result — `mix brain.verify` now fails on a stale index
  listing.
- `mix brain.verify`'s and `ElixirMind.Links`'s moduledocs, `ElixirMind.SessionInit`'s
  docs-freshness section, and the
  [gate-suite tutorial](/meta/tutorials/the-gate-suite-and-where-it-runs.md) /
  [three-bundle-scanners tutorial](/meta/tutorials/the-three-bundle-scanners.md)
  updated to describe the new split — the latter's "the verifier adds no new
  files to look at" claim no longer held once rule 9 opened a second scan
  surface (`Links.doc_paths/1`, differently scoped from `Registry.scan/1`), so
  its architecture diagram and closing sentence were corrected too.
- `ElixirMind.LinksTest` updated: the two "unlisted" cases moved from
  advisory to hard assertions, plus a new case confirming `evals/` is out of
  scope for the hard check.
- Full local gate suite re-run green after the change: compile
  (`--warnings-as-errors`), format, xref (`--fail-above 0`), test (189
  passing), `mix brain.verify` (still exits `0` — the 13 live warnings are all
  in the still-advisory "no index at all" class), `mix brain.contract
  --check`, `mix brain.registry --check`, `mix brain.codemap --check` (both
  regenerated after the docstring edits), `mix brain.route_tags`, `mix
  brain.site`.
