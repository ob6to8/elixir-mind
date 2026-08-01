---
type: issue
title: "The index-coverage gate matches by substring, so a longer listed filename masks a shorter unlisted one"
description: Links.unlisted_errors decides a doc is listed via String.contains?(index, basename), so a doc whose name is a suffix of another listed filename passes the hard gate while genuinely unlisted — eight live maskable pairs exist in the tree today.
status: resolved
provenance: "Claude Code session (Claude Fable 5), 2026-08-01 — comprehensive repo review"
tags: [meta, issue, links, index, gates, tooling]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T10:15:00Z
  channel: agent-authored
  agent: "Claude Code agent, comprehensive-review session"
  why: "found reading Links.unlisted_errors during the tooling review; the hard gate's guarantee has live false-negative capacity"
  from: [/meta/threads/2026-08-01-comprehensive-repo-review-session-1.md, /meta/threads/2026-08-01-route-tag-fencing-index-coverage-and-staleness-fixes.md]
---

# The index-coverage gate matches by substring

## Resolution (2026-08-01)

Fixed: `unlisted_files/3` now requires the basename to appear as a link
target — immediately after `(` or `/` — instead of anywhere in the index
content, so a longer listed filename can no longer mask a shorter unlisted
sibling; the regression test named below (`agentic-git.md` masking `git.md`)
pins it.

## Summary

`ElixirMind.Links.unlisted_files/3` (`lib/elixir_mind/links.ex:184-189`)
checks whether a filed doc is listed in its directory's `index.md` with
`String.contains?(content, basename)`. Any listed filename that *contains*
the candidate's basename satisfies the check, so a doc can be genuinely
unlisted while the hard gate stays green. The moduledoc acknowledges the
looseness for the foreign-corpus directory case ("substring match is
satisfied by any mention"); the filename-masking case is the same mechanism
working against the gate's own purpose.

## Live exposure

Eight maskable pairs exist in the tree as of 2026-08-01 (scan of every
indexed directory for basenames that are suffixes of a sibling's basename):

- `knowledge/knowledge-management/design-rationale/`: `design-rationale.md`
  maskable by `llms-recovering-design-rationale.md`
- `beliefs/glossary/`: `artifact.md` ⊂ `generated-artifact.md`,
  `assumption.md` ⊂ `open-world-assumption.md` / `unique-name-assumption.md`,
  `belief-network.md` ⊂ `deep-belief-network.md`,
  `digest.md` ⊂ `session-init-digest.md`,
  `prompt-injection.md` ⊂ `indirect-prompt-injection.md`,
  `recall.md` ⊂ `source-recall.md`,
  `source-of-truth.md` ⊂ `single-source-of-truth.md`

The seven glossary pairs are re-covered by `mix brain.glossary`'s index-sync
check (which compares the `## Terms` section against an exact re-derivation),
so the one pair currently carrying real exposure is the design-rationale
directory. All eight docs are in fact listed today — the hole is capacity,
not a live omission (scope: this scan checks name-maskability, not listing
state; listing state was confirmed by the gate itself being green plus the
glossary sync check).

## Fix shape

Match on the link-target form instead of the bare basename — e.g. require
`(<basename>` or `/<basename>` (the index convention links every entry), or
a word-boundary regex. Zero migration cost while the gate is green. Add the
regression test: an index listing only `agentic-git.md` fails for an
unlisted sibling `git.md`.
