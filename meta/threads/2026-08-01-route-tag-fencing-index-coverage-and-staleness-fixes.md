---
type: reference
title: 2026-08-01-route-tag-fencing-index-coverage-and-staleness-fixes
description: Executed the comprehensive-review program's fix-thread hand-off — fixed route-tag regions dropping fenced code (plus a related fence-unaware log-section boundary bug it exposed), tightened the index-coverage gate against substring masking, and swept six staleness findings across code comments, a policy, and six skills' terminology — one commit per item, full gate suite green, both issues marked resolved.
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-01; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, route-tags, index-coverage, tooling, staleness, gates]
timestamp: 2026-08-01
session: https://claude.ai/code/session_01SazjGkPuNmzouued83j8WU
pr: 223
---

# 2026-08-01-route-tag-fencing-index-coverage-and-staleness-fixes

## Where this landed

This session executed the
[comprehensive-review program](/meta/plans/comprehensive-repo-review-program.md)'s
"Fix thread" hand-off verbatim: the two confirmed defects the session-1 review
filed as issues, plus its recommended staleness sweep, each as its own commit
with the full gate suite green before closing.

**Route-tag fence loss.** `parse_line/2` toggled fence state and skipped
fenced lines without appending either to an open region's content, so a
tagged region containing a code block materialized minus the code.
Re-running `mix brain.route_tags --materialize` after the fix surfaced a
second, previously invisible bug it exposed: `parse_log_section/1`'s
h1/h2 section-boundary search wasn't itself fence-aware, so a materialized
region carrying a `#`-prefixed comment line inside its own fence (a shell
comment, in the live case) truncated the block early the moment real fenced
content started round-tripping — caught by the bundle's own
"carries no route-tag failures" test going red on the live corpus, not by
the issue's reproduction. Fixed both, added the round-trip regression test
plus one for the boundary bug, and re-materialized: eleven sink docs fed by
the nine threads named in the issue regained their dropped code.

**Index-coverage substring masking.** `Links.unlisted_files/3` decided a
doc was "listed" via a bare substring check, so a longer listed filename
containing a shorter unlisted one's name as a suffix passed the hard gate
while genuinely unlisted. Tightened to require the basename appear as a
link target (right after `(` or `/`, matching how every real `index.md`
entry actually links its docs), updated the test fixture helper to write
link-style entries, and added the regression test named in the issue.

**Staleness sweep (findings 8–13).** Six small corrections: dropped a
dead exemption for `meta/dev-history.md` (no longer checked in) from
`attribution.ex`; reworded a `pages.yml` comment that referenced a
checked-in copy that no longer exists; corrected the capture skill's
narrower-than-policy claim about what `Routed to` links; brought the
resource-attribution policy's exemption list up to date with what the
verifier actually exempts (`survey/`, `journal/`) and recompiled the
contract; replaced render-contract's stale, duplicated section-list
snapshot with a pointer at the authoritative code (so it can't drift the
same way again); and swept unit-sense "concept" (meaning "document") to
"document" across six skills and the `brain.route_tags` shortdoc/moduledoc,
left over from the 2026-07-15 document/concept terminology ratification —
leaving genuine `type: concept` references and plain-English "concepts"
untouched. Regenerated `meta/code-map.md` to match.

Both issues are now `status: resolved` with a one-line resolution note each,
moved to the Resolved section of
[`meta/issues/index.md`](/meta/issues/index.md). Four commits, one per
numbered item plus one for the resolution stamp; the full gate suite
(`mix format --check-formatted`, `xref`, `brain.contract/registry/codemap
--check`, `brain.verify`, `brain.route_tags`, `brain.glossary`,
`brain.lineage --check`, `mix test --warnings-as-errors`, `brain.site`) ran
green after every commit.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Route-tag regions losing fenced code, plus the fence-unaware log-section boundary bug it exposed | closed | [route-tag-regions-lose-fenced-code](/meta/issues/route-tag-regions-lose-fenced-code.md) | - |
| Index-coverage gate substring masking | closed | [index-coverage-gate-substring-masking](/meta/issues/index-coverage-gate-substring-masking.md) | - |
| Staleness sweep: findings 8–13 of the tooling-implementation review | closed | [resource-attribution](/meta/policy/resource-attribution.md) | - |

## User

Fix the two open issues filed by the comprehensive review, plus the staleness sweep it
recommended, on a fresh branch:

1. /meta/issues/route-tag-regions-lose-fenced-code.md — fix parse_line/2 in
   lib/elixir_mind/route_tags.ex so fence lines and fenced content are appended to an
   open region's content (fence state still suppresses tag/turn matching inside
   code), add the round-trip regression test (a region containing a fence
   materializes whole), then run mix brain.route_tags --materialize and include the nine
   rewritten sink diffs in the PR.
2. /meta/issues/index-coverage-gate-substring-masking.md — tighten
   Links.unlisted_files/3 to link-target or word-boundary matching, with the
   regression test named in the issue.
3. The staleness sweep: findings 8–13 in
   /meta/analysis/tooling-implementation-review.md (two stale comments/exemptions, the
   capture and render-contract skill corrections, the resource-attribution exemption
   list + /render-contract, the unit-terminology pass over the six skills and task
   shortdocs + mix brain.codemap).

One commit per numbered item. Full gate suite green before closing. Mark both issues
status: resolved with a one-line resolution note, update meta/issues/index.md, then
/create-pull-request.

## Assistant

*(This entire turn was execution — reading the two issues and the tooling
review, fixing `parse_line/2` and the fence-unaware log-section boundary bug
it exposed, re-materializing the route-tag sinks, tightening the
index-coverage gate, sweeping the six staleness findings, marking both
issues resolved, and running the full gate suite after every commit —
carried out as tool calls with only short pre-tool narration between them,
which this capture's drop rule strips. The outcome is recorded in the four
commits on this branch, in the two issues linked from the routing ledger
above (now `status: resolved`), and in
[`meta/issues/index.md`](/meta/issues/index.md).)*
