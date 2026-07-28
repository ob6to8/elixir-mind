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

- [Refresh the gate-suite tutorial's table to the current CI gate list](/meta/todos/refresh-gate-suite-tutorial-gate-table.md) — the tutorial numbers ten gates while CI runs fourteen, omitting `brain.glossary`, `brain.lineage --check`, `brain.dev_history --check`, and `brain.dedup_probe`, so a reader running the documented local subset under-runs the suite. `status: open`.
- [Triage what remains in `deprecated/` and decide its fate](/meta/todos/triage-what-remains-in-deprecated.md) — 33 markdown files still sit undispositioned; each ends migrated into the taxonomy, moved to the survey tier, or retired. `status: open`.
- [Surface the glossary `sense` field in the index and registry views](/meta/todos/surface-glossary-sense-in-index-and-registry.md) — the field shipped but its display surfaces were deferred inside a now-closed plan, so a reader cannot tell a standard term of art from a bundle coinage without opening each file. `status: open`.
- [Build the two proposed eval instruments under `meta/evals/`](/meta/todos/build-the-two-proposed-eval-instruments.md) — both the source-recall probe and the priorities-recitation eval are designed and unbuilt, and `meta/evals/` is read by no digest, so a proposed eval stays proposed by default rather than by decision. `status: open`.
- [Generate the channels register's `Ingested` column](/meta/todos/generate-the-channels-register-ingested-column.md) — a fully re-derivable column kept by hand, the one such view in the repo without a generator and a freshness gate. `status: open`.
- [Broaden the `invisible-degradation` glossary entry for the model-output sense](/meta/todos/broaden-invisible-degradation-for-model-output-sense.md) — decide between a second paragraph on the existing entry and a distinct term. `status: open`.
- [Decide the cross-model PR review Action's target repo and default reviewer model](/meta/todos/decide-cross-model-pr-review-action-target.md) — the Action is built and installed nowhere, blocked on two operator decisions that may be subsumed by the gate-suite hardening plan. `status: open`.
- [Confirm the empty taxonomy stub folders and the tolerated broken links](/meta/todos/confirm-taxonomy-stub-folders-and-tolerated-broken-links.md) — `claude-managed-agents/` holds only an `index.md`, and the restructure's broken links in frozen namespaces were tolerated rather than decided. `status: open`.
- [Decide whether journal entries adopt a carry-forward closing line](/meta/todos/decide-journal-carry-forward-close-convention.md) — so entries compound rather than accumulate, without touching the operator's voice. `status: open`.
- [Decide whether the Workflow fan-out execution convention graduates into a plan](/meta/todos/decide-graduating-workflow-fanout-convention-to-plan.md) — an analysis whose residue is action, invisible to `/priorities` while it stays an analysis. `status: open`.
- [Ratify or reject the thin attribution policy naming the producing model](/meta/todos/ratify-or-reject-provenance-names-producing-model.md) — the commit trailer and `attribution.agent` have since taken adjacent ground; recommendation is to reject and record it. `status: open`.
- [Build `mix brain.staleness` once dated-revision resources pass ~10 docs](/meta/todos/build-mix-brain-staleness-when-dated-resources-grow.md) — a dated-revision spec path stays live indefinitely and never signals supersession, so a capture against it goes stale silently (observed 2026-07-27: two MCP docs on `2025-06-18` while `2025-11-25` was current). The check has a clean mechanical oracle but measured exposure is 2 of 78 resource-bearing docs and it needs network, failing both halves of the [admission rule](/meta/policy/elixir-coding-standards.md); build on ~10 docs or on a stale capture actually misleading a conclusion. `status: open`.
- [Auto-wire the pre-commit hook in `session-start.sh`](/meta/todos/wire-pre-commit-hook-in-session-start.md) — set `git config core.hooksPath .githooks` in the session-start hook so fresh web-session sandboxes get the local [gate suite](/meta/tutorials/the-gate-suite-and-where-it-runs.md) automatically, instead of only discovering a red gate in CI. The [version-control audit](/meta/analysis/version-control-workflow-vs-trunk-based-reference.md)'s highest-leverage quick win. `status: open`.
- [Intake the agent-as-computer architecture evaluation as a concept](/meta/todos/intake-agent-architecture-evaluation-as-concept.md) — file the CPU/OS, pure-function, interpreter-tower, and RAM/disk/ROM analogies evaluation as a distilled concept (or decide the glossary coverage suffices and cancel). `status: open`.
- [Intake the "Second brain distinctions" ChatGPT conversation as a reference](/meta/todos/intake-second-brain-distinctions-chatgpt-conversation.md) — file the shared conversation as a lean `type: reference` capture (resource = the share URL), or decide the analysis + frozen thread transcript suffice and cancel. `status: open`.
- [Triage the six kept unmerged claude/* branches](/meta/todos/triage-the-six-kept-unmerged-claude-branches.md) — each kept branch ends up merged, superseded-and-deleted, or explicitly retired — none left in limbo. `status: open`.

## Done / Cancelled

_(none yet)_
