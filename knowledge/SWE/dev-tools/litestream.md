---
id: em:86f6df
type: reference
title: "Litestream — streaming SQLite replication"
description: A standalone process (by Ben Johnson) that streams SQLite's write-ahead log to cheap object storage with no code changes to the application, so a single-server app gets continuous, cheap disaster recovery without a multi-server database.
resource: https://litestream.io/
provenance: "Litestream project site (litestream.io), fetched 2026-08-05"
tags: [sqlite, database-replication, disaster-recovery, single-server-deployment, ben-johnson, fly-io]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing; the URL was already parked in the survey tier (bookmarks.md), so this intake promotes it"
---

# Litestream

Litestream is a standalone replication tool for SQLite, created by Ben
Johnson (maintained at `benbjohnson/litestream` on GitHub, currently at
v0.5.x). It runs as a separate process alongside the application — "no code
changes" required — and continuously streams SQLite's changes to a cloud
object store or local files.

## The problem it solves

Litestream lets an application "safely run your application on a single
server" instead of standing up a multi-server database for durability. If the
server dies, the application restores from "your most recent replicated
transaction" against the object store, giving single-server deployments
disaster recovery without the operational cost of running a distributed
database.

## Why it's cheap

Because it rides on ordinary object storage rather than a second database
server, Litestream is described as "dirt cheap" — on the order of pennies a
day for continuous, worry-free backup, with support for multiple storage
backends.

## Where this sits in the brain

Already referenced in passing in
[Fly.io](/knowledge/SWE/agentic/execution-environments/fly-io.md) as the
recommended pattern for a small BEAM app's durable state on a single VM:
"SQLite + Litestream replicating to object storage for small apps," and as
the open-source, Fly-independent substitute for Fly's managed LiteFS/volumes
in a roll-your-own deployment.

# Citations

- Source: <https://litestream.io/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:86f6df">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-05-reading-list-batch-intake (2026-08-05)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:86f6df`]**  (co-feeds: `em:be781f em:3d9101 em:e4d9cf em:d146ff`)

Filed the batch. Everything's committed and pushed to `claude/research-intake-links-nhi01p`; no PR opened, since that's `/create-pull-request`'s job, not `/intake`'s.

**What happened:** Of your 21 links, 4 were exact matches for documents already in the brain (Naur's paper and the Goedecke essay reading it were both already captured together; the Seldon and Dzombak posts were already filed word-for-word) — those needed no action. Three more links weren't new *documents* so much as new *angles* on things already filed — Simon Willison's take on stateless MCP, a Hacker News discussion of an existing essay, and the wider MAGE book/repo around a chapter already captured — so those got merged into the existing docs instead of creating near-duplicates. The `litestream.io` link turned out to already be sitting in the bookmark tier from an earlier session, so this intake promoted it to a filed reference. The rest — twelve documents — were genuinely new and got filed across security, several `agentic/` subdirectories, `dev-tools`, `software-design`, and one new subdirectory (`knowledge/SWE/performance/`, created autonomously since it sits under the already-established `SWE` domain). One fetch (the Reddit Jido thread) was blocked by the host; I covered the same material from the `jido.run` blog post instead and left the Reddit URL as an uncaptured citation.

---

**[`em:86f6df`]**  (co-feeds: `em:b2676a em:cdd51c em:79c1a1 em:45adfd em:f9f0d5 em:41ab78 em:d146ff em:d27de7 em:563b18 em:fab63b em:134093 knowledge/SWE/performance/index.md`)

**What I created**

| Doc | Type | Why this type |
|---|---|---|
| [Normalization of Deviance in AI](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/security/normalization-of-deviance-in-ai.md) | reference | captured external analysis |
| [Claude Fable is relentlessly proactive](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/anthropic/claude-code/fable-is-relentlessly-proactive.md) | reference | captured external analysis |
| [Proofreader prompt](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/prompt-design/proofreader-prompt-pattern.md) | snippet | a reusable prompt template, not a distilled argument |
| [LLM — multi-provider CLI/library](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/dev-tools/llm-cli-tool.md) | reference | product docs + its 0.32 release notes, combined |
| [OpenAI's accidental cyberattack against Hugging Face](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/security/openai-cyberattack-huggingface.md) | reference | captured external analysis |
| [Profiling Rust NIFs in Elixir](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/performance/profiling-rust-nifs-in-elixir.md) | reference | captured how-to writeup |
| [Litestream](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/dev-tools/litestream.md) | reference | promoted from the survey/bookmarks tier |
| [Model-Based Agentic Software Engineering (MAGE) — framework overview](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/governance/model-based-agentic-software-engineering-mage.md) | reference | whole-framework granularity beside the existing chapter capture |
| [METR's AI Productivity Study is Really Good](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/expertise/metr-ai-productivity-study-is-really-good.md) | reference | captured external analysis |
| [Analysis of vibecoded outputs (MostAwesomeDude)](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/expertise/vibecoded-outputs-analysis-mostawesomedude.md) | reference | captured external analysis |
| [UML — introduction](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/software-design/unified-modeling-language-introduction.md) | reference | encyclopedia-style capture |
| [Jido Assembly — a Slack clone](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/frameworks/jido-assembly-slack-clone.md) | reference | captured case study |

Plus `knowledge/SWE/performance/index.md` for the new subdirectory, and every touched directory's `index.md` (`security`, `claude-code`, `prompt-design`, `dev-tools`, `governance`, `expertise`, `software-design`, `frameworks`, top-level `SWE`).
