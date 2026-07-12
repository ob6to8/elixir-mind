# Issues

Tracked operational problems, defects, and open concerns about how the brain or its
tooling and automation behave — recorded for future reference and follow-up. A
separate namespace from `policy` (the rules that compile into the contract) and
`tutorials` (the "why" explainers).

Each issue is a `type: issue` doc carrying a `status` (`open` · `resolved` ·
`wontfix`). Resolved issues stay filed as a record of what happened and how it was
fixed.

## Open

- [Daily /news Routine: automated runs not landing on `main`](/meta/issues/daily-news-routine-runs-not-landing.md) — the scheduled Routine's fresh-session runs produce no commit/push; an environment-wide tool-approval gate is the suspected cause. Workaround: run `/news` manually. `status: open`.

## Resolved

- [route_tags: materialize cannot remove orphaned excerpt blocks](/meta/issues/route-tags-materialize-leaves-orphan-blocks.md) — `materialize/1` now projects the tags in both directions, removing an unfed sink's log section unconditionally (hardening plan P1); pinned by two scenario tests. `status: resolved`.
