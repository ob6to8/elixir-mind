---
id: em:31e85b
type: reference
title: "GitLord — git as the storage engine for agent orchestration"
description: A Python framework that uses git itself (not a database) as the source of truth for multi-agent execution — sessions and subagents are branches, turns are commits, and rewind is a first-class checkout-and-continue operation.
resource: https://github.com/yashneil75/gitlord
provenance: "Distilled from the GitLord GitHub README and the author's announcement thread on r/AgentsOfAI, fetched 2026-07-29"
tags: [agentic, git, agent-framework, agent-memory, orchestration, mcp, subagents, python]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pasted the GitLord repo and its Reddit announcement thread describing a git-backed alternative to a database for multi-agent execution history"
---

# GitLord — git as the storage engine for agent orchestration

GitLord repurposes git as the persistent store for autonomous-agent execution
history, rather than a per-agent JSON blob or an SQL table. The framework's own
framing: every agent action becomes "a version-controlled event — inspectable,
replayable, forkable." This is git as **storage engine**, not "git for version
control of your code" — no working tree or staging area is involved in writing
the log.

## Data model — branches for lineage, commits for turns

- **Sessions and subagents are branches.** `refs/agents/<session-id>` roots a
  session; spawning a subagent creates a branch off the parent's current tip,
  `refs/agents/<session-id>/<subagent-id>`, nestable to arbitrary depth.
- **Turns are commits.** Every user message, assistant reply, tool call, and
  tool result is committed as a JSON blob carrying structured trailers (turn
  number, role, agent id, token counts, a linked workspace commit). `git log`
  on a branch is the execution trace directly, not a log file rendered from one.
- **Subagents link back rather than merge back.** A finished subagent's final
  commit SHA is written into a `Subagent-Result:` trailer on the parent's next
  commit — full traceability with no merge-conflict surface, since the child
  branch is never merged into the parent.
- **Rewind is a first-class operation.** `agent rewind <session> --to <sha>
  --run "..."` checks out a new branch at the target commit and continues from
  there; the original branch and everything after it stay intact and
  reachable, so several alternative continuations from the same past commit
  can coexist and be compared.
- **Concurrency without locking.** Commits are built with git plumbing
  (`hash-object`, `mktree`, `commit-tree`) rather than the working tree or
  index, so parallel subagent writers on different branches never contend;
  ref updates use compare-and-swap.

## Two repositories

A **log repository** (no working-tree checkout — pure object/ref store for the
turn history above) is kept separate from a **workspace repository** holding
actual project files. Each subagent gets an isolated
[git worktree](/knowledge/SWE/version-control/git/git-worktrees-for-parallel-agents.md)
on the workspace repo for concurrent file edits, cross-referenced back into the
log by commit SHA — reusing the same worktree-per-agent isolation pattern
documented there, applied to the workspace side rather than the log side.

## Retrieval, tools, and model routing

- **Vector index is derived, not authoritative.** A Chroma index is built from
  the git log for semantic search over past executions; it is explicitly
  rebuildable and disposable — delete it and regenerate from the log if it
  breaks.
- **Context management happens only at read time.** Deduplication and
  summarization occur when assembling context for the next LLM call; the log
  itself stays full-fidelity forever, so a session can always be replayed
  exactly rather than through a summary.
- **Tools are pluggable via MCP servers** — filesystem, browser, search, fetch,
  or custom additions — one config entry per tool, no core-framework changes.
- **Model routing is via LiteLLM**, so parent and subagents can run different
  models (e.g. a cheap model for a subagent grinding through file reads, a
  frontier model for the orchestrator).

## Meta

Language: Python. License: MIT. Author: yashneil75. ~50 GitHub stars at time of
capture (unverified beyond the fetch). CLI surfaces session management (`run`,
`log`, `tree`), inspection (`show`, `diff`), and control (`rewind`, `trim`).

## Relation to other framework references

Sits beside [Archestra](/knowledge/SWE/agentic/frameworks/archestra-open-source-enterprise-ai-platform.md)
and [sagents](/knowledge/SWE/agentic/frameworks/sagents-elixir-agent-orchestration.md)
in this bundle's framework survey, but targets a narrower problem than either:
not a full platform (Archestra) or an Elixir-process-based agent runtime
(sagents), just the storage/history layer underneath any agent loop. It is the
same structural idea this bundle's own contract applies to itself — the
[merge-strategy policy](/meta/policy/merge-strategy.md) already treats the
commit graph as "a provenance layer, not an implementation detail," with
session-authored commits carrying a session trailer and durable docs citing
commits by SHA — except GitLord generalizes that stance from "one commit per
merged change" down to "one commit per turn," and adds branch-per-agent and
rewind-as-checkout on top.

# Citations

- GitLord repository — <https://github.com/yashneil75/gitlord>
- Author's announcement thread, r/AgentsOfAI — <https://www.reddit.com/r/AgentsOfAI/comments/1v159x5/i_stopped_building_a_database_for_my_ai_agents/>
