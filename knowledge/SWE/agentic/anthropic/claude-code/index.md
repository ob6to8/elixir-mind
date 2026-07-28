# Claude Code

Anthropic's Claude Code agent — CLI, cloud runtime, hooks, and configuration.

## Notes

- [Claude Code agent teams — peer-coordinated sessions with a shared task list and mailboxes](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md) — experimental multi-agent surface: a lead session spawns teammate sessions coordinating through a file-locked shared task list and JSON-file mailboxes, each a full Claude Code instance the operator can steer directly; distilled from the official docs with the file-based architecture and limitations list. `em:33e0c7` _(reference)_
- [Claude Code settings and permissions — the four-scope hierarchy and the merge rule](/knowledge/SWE/agentic/anthropic/claude-code/claude-code-settings-and-permissions.md) — settings resolve across managed/local/project/user by priority, but permission rules are the exception: they merge across scopes rather than override, so a managed `deny` cannot be cancelled from below. Covers the managed-only governance keys and tolerant managed-settings validation.
- [Claude Code cloud (CCR) — environment and orchestration architecture](/knowledge/SWE/agentic/anthropic/claude-code/cloud-environment-architecture.md) — sessions map to operator-defined environments backed by per-environment filesystem snapshots; baked state (incl. the cloned repo) is frozen at snapshot time, containers are ephemeral, sibling sessions interleave. Documented backbone grounded against the official docs. `em:52aefa` _(note, unverified)_
- [Observer subagent pattern (experimental, undocumented)](/knowledge/SWE/agentic/anthropic/claude-code/observer-subagent-pattern.md) — experimental Claude Code feature pairing a worker subagent with a read-only observer that watches an activity digest and may send at most one advisory, authority-free message; community-reported, unconfirmed by any official source. `em:02731b` _(reference)_

## Subdirectories

- [sources](/knowledge/SWE/agentic/anthropic/claude-code/sources/index.md) — primary-source excerpts from the official Claude Code docs used as verification grounding
