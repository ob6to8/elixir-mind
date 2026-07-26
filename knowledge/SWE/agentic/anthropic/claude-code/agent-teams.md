---
id: em:33e0c7
type: reference
title: "Claude Code agent teams — peer-coordinated sessions with a shared task list and mailboxes"
description: Anthropic's experimental multi-agent surface for Claude Code — a lead session spawns teammate sessions that coordinate through a shared, file-locked task list and JSON-file mailboxes, message each other directly, and remain individually steerable by the operator — distilled from the official docs, including the file-based architecture and the limitations list.
resource: https://code.claude.com/docs/en/agent-teams
provenance: "Official Claude Code documentation (docs as of v2.1.178+), fetched and distilled 2026-07-26"
tags: [claude-code, anthropic, multi-agent, agent-teams, orchestration, harness, task-coordination, messaging]
timestamp: 2026-07-26T00:00:00Z
attribution:
  when: 2026-07-26T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to intake the agent-teams doc and evaluate it against the same architecture on the BEAM using Jido 2"
---

# Claude Code agent teams

**Agent teams** (experimental, off by default — `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`)
let multiple full Claude Code sessions work together: one session is the **team
lead** that spawns teammates, populates a shared task list, and synthesizes
results; **teammates** are separate, fully independent Claude Code instances with
their own context windows. Unlike [subagents](/knowledge/SWE/agentic/anthropic/claude-code/observer-subagent-pattern.md)
— which run inside one session and only report back to their caller — teammates
**message each other directly** and self-coordinate, and the operator can talk to
any teammate individually without going through the lead.

## Architecture

Four components: **team lead** (the main session), **teammates** (spawned
sessions), a **shared task list**, and a **mailbox** messaging system. The
coordination fabric is *files on the local machine*:

- **Mailboxes are JSON files** at `~/.claude/teams/{team-name}/inboxes/{agent-name}.json`.
  Entries are validated on read; malformed entries are reported and removed
  (before v2.1.207 one malformed entry blocked the whole mailbox). Delivery is
  automatic — the lead does not poll.
- **Task list** lives under `~/.claude/tasks/{team-name}/`. Tasks have three
  states (pending / in progress / completed) plus dependencies; completing a task
  unblocks its dependents automatically. **Task claiming uses file locking** to
  prevent races when teammates self-claim concurrently.
- **Team config** (`~/.claude/teams/{team-name}/config.json`) holds runtime state
  (member names, agent ids, session ids, tmux pane ids); it is generated and
  overwritten by the runtime, not user-authored. The team name is derived from
  the session id. Config is deleted at session end; the task directory persists
  locally for resumed sessions.

Coordination behaviors: the lead assigns tasks or teammates **self-claim** the
next unblocked task; idle teammates notify the lead automatically (and, as of
v2.1.198, report API-error failures instead of appearing to finish); teammates
discover each other from the config's `members` array and message each other **by
name**. There is no broadcast — reaching everyone means one message per
recipient.

## Sessions as members, and the harness around them

- Each teammate loads full project context on spawn — CLAUDE.md, MCP servers,
  skills — plus a spawn prompt from the lead; the lead's conversation history
  does **not** carry over.
- Teammates can be spawned from **subagent definitions** (reusing a role's
  `tools` allowlist and `model`; its body is appended to the system prompt). The
  `skills`/`mcpServers` frontmatter fields are ignored for teammates.
- **Permissions**: teammates inherit the lead's permission mode at spawn;
  teammate permission prompts bubble up to the lead's terminal for the *human* to
  approve. A message from another agent is marked as agent-originated — a
  teammate cannot approve permissions or relay consent on the operator's behalf.
- **Plan approval**: a teammate can be required to plan in read-only mode; the
  *lead* approves or rejects the plan autonomously (criteria steerable by
  prompt) — the designed exception to human-only approval.
- **Hooks as quality gates**: `TeammateIdle`, `TaskCreated`, `TaskCompleted` fire
  at coordination events; exit code 2 blocks the event and feeds text back
  (e.g. keep a teammate working until its gate passes).
- **Display**: in-process (agent panel in one terminal) or split panes via tmux /
  iTerm2; the operator can open any teammate's transcript, message it, or
  interrupt it.

## Intended use and costs

Best for parallelizable work with real independence: parallel research/review,
competing debugging hypotheses (explicitly adversarial "disprove each other"
prompts), cross-layer features with per-teammate file ownership. Token usage
scales linearly with teammates (each is a full Claude instance); guidance is 3–5
teammates and 5–6 tasks per teammate, with file conflicts avoided by ownership
partitioning, not merging. For sequential or tightly-coupled work, a single
session or subagents are preferred.

## Limitations (as documented)

- **No session resumption for in-process teammates** — `/resume`/`/rewind` do not
  restore them; the lead may message ghosts.
- **Task status can lag** (teammates fail to mark completion, blocking
  dependents); manual nudging is the fix.
- **Teammates may stop on errors** rather than recover; remedy is direct
  instruction or spawning a replacement.
- **One team per session; no nested teams** (teammates cannot spawn teammates);
  **the lead is fixed** for the session's lifetime — no promotion or handoff.
- **Shutdown is cooperative and can be slow** (teammates finish current work; a
  shutdown request can be rejected).
- Permission modes are set at spawn (changeable after, not per-teammate at
  spawn); split panes require tmux or iTerm2.

# Citations

- Official docs: <https://code.claude.com/docs/en/agent-teams> (fetched
  2026-07-26; page states behavior as of v2.1.178 with per-version notes through
  v2.1.207). Related pages: sub-agents, hooks (`TeammateIdle`/`TaskCreated`/
  `TaskCompleted`), costs (agent-team token costs).
- Analyzed against BEAM/Jido 2 in
  [agent teams vs. BEAM/Jido](/meta/analysis/agent-teams-vs-beam-jido.md).

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:33e0c7">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-26-agent-teams-intake-and-beam-jido-comparison (2026-07-26)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:33e0c7`]**  (co-feeds: `meta/analysis/agent-teams-vs-beam-jido.md`)

Intake complete — two documents filed and pushed to `claude/agent-architecture-comparison-7xwd2o` (branch blob links; Pages URLs go live on merge):

- **[Claude Code agent teams](https://github.com/ob6to8/elixir-mind/blob/claude/agent-architecture-comparison-7xwd2o/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md)** — `reference`, `em:33e0c7`, filed under the existing `claude-code/` directory. Summarized capture of the official docs page (fetched in full), keeping the URL as `resource`.
- **[The actor model without its runtime: agent teams vs. BEAM/Jido 2](https://github.com/ob6to8/elixir-mind/blob/claude/agent-architecture-comparison-7xwd2o/meta/analysis/agent-teams-vs-beam-jido.md)** — `analysis`, joining the existing family (Managed Agents, Dynamic Workflows, the base Jido evaluation, the caveats expansion). Jido facts inherit the verified 2026-07-12 baseline, with two fresh spot-checks today: `jido_cluster` is *still* unpublished on hex (404), and jido.run confirms the coordination primitives are intra-node signals + parent-child hierarchies + a DAG planner.

Both indexes and the registry were regenerated; `mix brain.verify`, `brain.route_tags`, and `brain.contract --check` all pass. A gold row ("agent teams" → `em:33e0c7`) was harvested and the dedup baseline refreshed — no recall regression.
