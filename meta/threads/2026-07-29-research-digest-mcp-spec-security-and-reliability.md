---
type: reference
title: 2026-07-29-research-digest-mcp-spec-security-and-reliability
description: The daily /research digest for 2026-07-29, covering the 17-day gap since the last run — MCP's 2026-07-28 stateless/OAuth-hardened spec, the Agent Data Injection attack class, AISI's open-weight cyber-capability-gap measurement, SlopCodeBench's iterative-degradation benchmark, and the Claude Opus 5 release — with all five featured items auto-intaken.
provenance: "Claude Code session (Claude Sonnet 5), 2026-07-29; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, research, inbox, mcp, security, agentic-loop, anthropic]
timestamp: 2026-07-29
session: https://claude.ai/code/session_01PbDTm9jmdBxdh9SvCCHp2n
---

# 2026-07-29-research-digest-mcp-spec-security-and-reliability

## Where this landed

The operator ran `/research` after a 17-day gap since the last digest
(2026-07-12). The session built the taxonomy query profile from the KB tree,
read the channels register and the last three digests for dedup, then
searched across ai-industry, SWE (agentic/mcp, security, agentic-loop,
anthropic), machine-learning, knowledge-management, and startups. Most
candidates found were either already filed or too generic to clear the
featuring gates; five survived: MCP's 2026-07-28 specification revision
(stateless core, OAuth 2.1/OIDC hardening), a new indirect-prompt-injection
subclass (Agent Data Injection, forging trusted metadata rather than
instructions), UK AISI's measurement of the open-weight/frontier cyber-
capability gap (narrowed to 4–7 months), SlopCodeBench (no agent solves an
iterative long-horizon benchmark end-to-end; code quality degrades
monotonically), and the Claude Opus 5 release. All five were auto-intaken —
filed as new `reference` documents, cross-linked to the concepts they extend
— and `inbox/2026-07-29.md` was marked with each outcome. The full gate suite
(`mix brain.verify`, `mix brain.route_tags`, `mix format --check-formatted`,
`mix test`) passed before commit; the branch was pushed. A stop-hook check
then flagged the uncommitted state was resolved, and the operator invoked
`/create-pull-request merge` to close the session out.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| MCP 2026-07-28 spec revision (stateless core, OAuth hardening) | closed | [mcp-spec-2026-07-28](/knowledge/SWE/agentic/mcp/mcp-spec-2026-07-28.md) | - |
| Agent Data Injection (ADI) — a new indirect-prompt-injection subclass | closed | [agent-data-injection](/knowledge/SWE/security/agent-data-injection.md) | - |
| AISI: open-weight/frontier cyber-capability gap narrowed to 4–7 months | closed | [open-weight-cyber-capability-gap](/knowledge/SWE/security/open-weight-cyber-capability-gap.md) | - |
| SlopCodeBench — monotonic code-quality degradation over iterative extension | closed | [slopcodebench-iterative-degradation](/knowledge/SWE/agentic/agentic-loop/slopcodebench-iterative-degradation.md) | - |
| Claude Opus 5 release | closed | [claude-opus-5](/knowledge/SWE/agentic/anthropic/claude/claude-opus-5.md) | - |
| The 2026-07-29 digest record and its auto-intake outcomes | closed | [inbox/2026-07-29](/inbox/2026-07-29.md) | - |
| Committing and pushing the session's changes | closed | `unrouted` | - |
| Opening and merging the pull request | open | `unrouted` | Awaiting this session's `/create-pull-request merge` steps 4–9 (commit verification, PR open, CI-green, true-merge). |

## User

/research

## Assistant

## What I created

| Doc | Type | Why this type |
|---|---|---|
| `inbox/2026-07-29.md` | reference (digest) | daily candidate feed, non-bundle |
| [MCP 2026-07-28 spec](/knowledge/SWE/agentic/mcp/mcp-spec-2026-07-28.md) `em:be781f` | reference | distinct spec-revision capture, sibling to the (now superseded) architecture note |
| [Agent Data Injection](/knowledge/SWE/security/agent-data-injection.md) `em:57c28a` | reference | a specific paper/attack-class capture extending the `indirect-prompt-injection` concept |
| [Open-weight cyber capability gap (AISI)](/knowledge/SWE/security/open-weight-cyber-capability-gap.md) `em:51e5f3` | reference | primary-source capture of an evaluation result |
| [SlopCodeBench](/knowledge/SWE/agentic/agentic-loop/slopcodebench-iterative-degradation.md) `em:5f9c0d` | reference | benchmark-paper capture |
| [Claude Opus 5](/knowledge/SWE/agentic/anthropic/claude/claude-opus-5.md) `em:636e39` | reference | product-release capture |

## What I modified

| File | Change |
|---|---|
| `inbox/index.md` | pointed Latest at today's digest, archived 2026-07-12 |
| `knowledge/SWE/agentic/mcp/mcp-architecture.md` | updated the "current revision" note to point at 2026-07-28 and flag itself as describing a superseded model |
| `knowledge/SWE/agentic/mcp/index.md`, `.../agentic-loop/index.md`, `.../anthropic/claude/index.md`, `SWE/security/index.md` | added entries for the 5 new docs |
| `meta/registry.md` | regenerated (`mix brain.registry`) |

## Actions I have taken

| Action | Result |
|---|---|
| Built the taxonomy query profile, read the last three digests for dedup | done |
| Searched across ai-industry, SWE/agentic (mcp, security, agentic-loop, anthropic), machine-learning, knowledge-management, startups for the 2026-07-12→29 gap | done — most candidates were already filed or too generic; 5 cleared the gates |
| Auto-intook all 5 featured items, minted ids, cross-linked | done |
| `mix brain.verify`, `mix brain.route_tags`, `mix format --check-formatted` | all pass |

Bundle stands at a clean working tree otherwise — nothing staged or committed, per the contract's scope for this skill.

## User

Stop hook feedback:
[~/.claude/stop-hook-git-check.sh]: There are uncommitted changes in the repository. Please commit and push these changes to the remote branch.

## Assistant

<routes ref="em:be781f em:57c28a em:51e5f3 em:5f9c0d em:636e39">
Pushed to `claude/research-17ueta`. Commit `d7d62f6` — 13 files, all gates green (format, xref, contract, verify, route-tags, glossary, 188 tests). No PR opened, since that wasn't requested — the branch is up for you to review or ask me to open one.
</routes>

## User

/create-pull-request merge
