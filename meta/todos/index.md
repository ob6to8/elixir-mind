# Todos

Lightweight actionable task items — plain things to be done, tracked until finished.
A separate namespace from `issues` (problems to diagnose and track) and `plans`
(design/decision records for proposed changes): a todo is just a *task to complete*.

Each todo is a `type: todo` doc carrying a `status` (`open` · `done` · `cancelled`).
Todos are added and listed with the [`/todo`](/.claude/skills/todo/SKILL.md) skill.
Done and cancelled todos stay filed as a record of what was on the list and its
outcome. Entries within each section are ordered by `timestamp`, most recent first
(see the [collection-view-by-date plan](/meta/plans/collection-view-by-date.md)).

## Open

- [Build `mix brain.staleness` once dated-revision resources pass ~10 docs](/meta/todos/build-mix-brain-staleness-when-dated-resources-grow.md) — a dated-revision spec path stays live indefinitely and never signals supersession, so a capture against it goes stale silently (observed 2026-07-27: two MCP docs on `2025-06-18` while `2025-11-25` was current). The check has a clean mechanical oracle but measured exposure is 2 of 78 resource-bearing docs and it needs network, failing both halves of the [admission rule](/meta/policy/elixir-coding-standards.md); build on ~10 docs or on a stale capture actually misleading a conclusion. `status: open`.
- [Auto-wire the pre-commit hook in `session-start.sh`](/meta/todos/wire-pre-commit-hook-in-session-start.md) — set `git config core.hooksPath .githooks` in the session-start hook so fresh web-session sandboxes get the local [gate suite](/meta/tutorials/the-gate-suite-and-where-it-runs.md) automatically, instead of only discovering a red gate in CI. The [version-control audit](/meta/analysis/version-control-workflow-vs-trunk-based-reference.md)'s highest-leverage quick win. `status: open`.
- [Intake the agent-as-computer architecture evaluation as a concept](/meta/todos/intake-agent-architecture-evaluation-as-concept.md) — file the CPU/OS, pure-function, interpreter-tower, and RAM/disk/ROM analogies evaluation as a distilled concept (or decide the glossary coverage suffices and cancel). `status: open`.
- [Intake the "Second brain distinctions" ChatGPT conversation as a reference](/meta/todos/intake-second-brain-distinctions-chatgpt-conversation.md) — file the shared conversation as a lean `type: reference` capture (resource = the share URL), or decide the analysis + frozen thread transcript suffice and cancel. `status: open`.
- [Triage the six kept unmerged claude/* branches](/meta/todos/triage-the-six-kept-unmerged-claude-branches.md) — each kept branch ends up merged, superseded-and-deleted, or explicitly retired — none left in limbo. `status: open`.

## Done / Cancelled

_(none yet)_
