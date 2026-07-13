# Claude Code

Anthropic's Claude Code agent — CLI, cloud runtime, hooks, and configuration.

_Concepts are listed by most recent `timestamp` (date modified) first; see the [collection ordering by date modified](/meta/plans/collection-ordering-by-date-modified.md) plan._

## Notes

- [Claude Code cloud (CCR) — environment and orchestration architecture](/knowledge/SWE/agentic-coding/claude-code/cloud-environment-architecture.md) — sessions map to operator-defined environments backed by per-environment filesystem snapshots; baked state (incl. the cloned repo) is frozen at snapshot time, containers are ephemeral, sibling sessions interleave. Documented backbone grounded against the official docs. `sb:52aefa` _(note, unverified)_

## Subdirectories

- [sources](/knowledge/SWE/agentic-coding/claude-code/sources/index.md) — primary-source excerpts from the official Claude Code docs used as verification grounding
