---
type: reference
title: 2026-07-31-gitlord-git-backed-agent-orchestration-intake
description: Intake of GitLord — a git-backed agent orchestration framework where sessions/subagents are branches and turns are commits — filed as one reference after confirming its GitHub repo and its author's Reddit announcement describe the same project.
provenance: "Claude Code session (Claude Sonnet 5), 2026-07-31; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, git, agentic, agent-framework, orchestration]
timestamp: 2026-07-31
session: https://claude.ai/code/session_011fV17PPQvsJJDaGS4yrbNY
---

# 2026-07-31-gitlord-git-backed-agent-orchestration-intake

## Where this landed

The operator invoked `/intake` with two pasted items: the GitHub repo
`yashneil75/gitlord` and its author's Reddit announcement thread. Fetching the
repo confirmed both describe the same project, so they were filed as one
`reference` rather than two. A synonym-expanded dedup search (git+agent,
subagent, orchestration, rewind, `refs/agents`, LiteLLM) found no existing
coverage, so the new doc landed autonomously in the already-established
`knowledge/SWE/agentic/frameworks/` directory beside the Archestra and sagents
references, cross-linked to the git-worktrees-for-parallel-agents concept and
to this bundle's own merge-strategy policy (the same "commit graph as
provenance layer" idea, generalized from one-commit-per-merge to
one-commit-per-turn). The bundle verified clean; the dedup gold-set baseline
was refreshed with no regression (32%, unchanged) and no new row was harvested
(the paste carried no distinct natural operator phrasing to seed one). The
change was committed and pushed to `claude/git-agent-orchestration-isj1fb`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| GitLord intake — git-backed agent orchestration framework | closed | [gitlord-git-backed-agent-orchestration](/knowledge/SWE/agentic/frameworks/gitlord-git-backed-agent-orchestration.md) | - |

## User

*(invoked `/intake` with the following pasted content:)*

https://github.com/yashneil75/gitlord
https://www.reddit.com/r/AgentsOfAI/comments/1v159x5/i_stopped_building_a_database_for_my_ai_agents/

reddit thread:

I stopped building a database for my AI agents and just used git. Turns out git already solved most of the hard problems.
[I Made This 🤖](https://www.reddit.com/r/AgentsOfAI/?f=flair_name%3A%22I%20Made%20This%20%F0%9F%A4%96%22)
If you've built anything with multi-agent systems, you've hit these walls:

* Agent state lives in some ad-hoc JSON blob or a Postgres table nobody trusts
* You can't "undo" a bad turn without nuking everything after it
* Subagents spawn, do work, and their reasoning trail disappears into a summary
* Debugging "why did the agent do that" means grepping logs, not actually seeing the decision tree
* Every framework reinvents branching, history, and diffing — badly

So I built an orchestration framework where every session, every subagent, every single turn is a git commit. Not "git for version control of your code" — git as the actual storage engine and source of truth for agent execution history.
How it works

* Sessions and subagents are branches. `refs/agents/<session-id>` is the root. Spawn a subagent, get a branch off the parent's current tip: `refs/agents/<session-id>/<subagent-id>`. Nest as deep as you want.
* Turns are commits. Every user message, assistant reply, tool call, and tool result is a JSON blob, committed with structured trailers (turn number, role, agent id, token counts, linked workspace commit). `git log` on any branch is your execution trace.
* Subagents don't merge back; they just link back. When a subagent finishes, its final commit SHA gets written into a trailer on the parent's next commit (`Subagent-Result: <sha>`). Full traceability, zero merge-conflict nonsense.
* Rewind is a first-class operation, not a hack. `agent rewind <session> --to <sha> --run "try again"` checks out a new branch at that point and continues from there. The original branch and everything after it stay intact and reachable. You can explore five different futures from the same past without losing any of them.
* Concurrent subagents don't fight over a lock. Commits are built with plumbing (hash-object, mktree, commit-tree) — no working tree, no staging area — so parallel subagent writers on different branches never contend. Ref updates use compare-and-swap.
* A separate workspace repo holds actual project files, with `git worktree` giving each subagent an isolated checkout for concurrent file edits, cross-referenced back into the log via commit SHA.

Why is this bigger than "agent memory"

* Auditability for free. Every decision an agent made is a diffable, signable, timestamped git object. Compliance and debugging stop being an afterthought.
* Retrieval without extra infrastructure. A vector index (Chroma) is derived from the git log — rebuildable at any time, never the source of truth. If it breaks, delete it and rebuild.
* Context management that doesn't destroy history. Deduplication and summarization happen only at read time, when assembling context for the next LLM call. The log itself stays full-fidelity forever — you can always go back and see exactly what was said.
* Model-agnostic by default. Calls route through LiteLLM, so parent and subagents can run on completely different models (a cheap model for a subagent grinding through file reads, a frontier model for the orchestrator).
* Tools are pluggable, not hardcoded. MCP servers handle tool access (filesystem, browser, search, fetch, whatever you add). New tool = one config entry, no core changes.
* No proprietary format, no vendor lock-in. It's a git repo. `git log`, `git show`, `git diff` All just work. Clone it, grep it, back it up with infrastructure you already trust.

This isn't a "yet another agent framework" niche play; it's useful for anyone building single agents, multi-agent pipelines, coding assistants, research agents, or long-running autonomous workflows who is tired of losing history, trust, and debuggability the moment things get complex.

## Assistant

<routes ref="em:31e85b">
Pushed. Here's a plain summary: I filed one new document — the two paste items (the GitHub repo and its Reddit announcement) turned out to describe the same project, GitLord, so they became a single filed concept rather than two.
</routes>

**What I created**

<routes ref="em:31e85b">
| Doc | Type | Why this type |
|---|---|---|
| [gitlord-git-backed-agent-orchestration.md](https://github.com/ob6to8/elixir-mind/blob/claude/git-agent-orchestration-isj1fb/knowledge/SWE/agentic/frameworks/gitlord-git-backed-agent-orchestration.md) (`em:31e85b`) | `reference` | External tool, captured and summarized — fits the existing `knowledge/SWE/agentic/frameworks/` directory alongside Archestra and sagents |
</routes>

**What I modified**

| File | Change |
|---|---|
| `knowledge/SWE/agentic/frameworks/index.md` | Added the GitLord entry |
| `meta/registry.md` | Regenerated (new id) |

**Actions I have taken**

<routes ref="em:31e85b">
| Action | Result |
|---|---|
| Fetched both links, confirmed they describe one project | GitHub README + Reddit thread → one concept, not two |
| Synonym-expanded dedup search (git+agent, subagent, orchestration, rewind, refs/agents, LiteLLM) | No existing doc on this tool; genuinely new |
| Minted id, recompiled registry, ran `mix brain.verify` | Clean |
| Cross-linked to git-worktrees-for-parallel-agents and noted the parallel to this bundle's own merge-strategy policy | — |
</routes>

| Action | Result |
|---|---|
| Dedup gold set | No natural operator phrasing to harvest (bare URL/thread paste) — skipped per the skill's own carve-out; refreshed baseline, no regression (32%, unchanged) |
| Committed and pushed to `claude/git-agent-orchestration-isj1fb` | All pre-commit gates green (format, xref, contract, registry, verify, route-tags, glossary, lineage, tests) |

Nothing needs ratification — the directory and type both already existed. No PR opened, since `/intake` doesn't invoke that step; say the word if you want `/create-pull-request` run next.

## User

*(invoked `/create-pull-request merge`)*
