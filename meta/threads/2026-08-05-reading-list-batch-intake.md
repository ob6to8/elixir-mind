---
type: reference
title: 2026-08-05-reading-list-batch-intake
description: "Batch /intake of a 21-link operator reading list — twelve new references/snippets filed across security, several agentic/ subdirectories, dev-tools, and software-design, one new knowledge/SWE/performance/ subdirectory, a bookmark promotion, three merges into existing docs, and four exact-duplicate skips; closed with /create-pull-request merge."
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-05; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, ai-security, agentic, elixir, expertise, mcp]
timestamp: 2026-08-05T16:10:00Z
session: https://claude.ai/code/session_01CVX5YYV2eF84Hcd2e1JbEu
pr: 256
---

# 2026-08-05-reading-list-batch-intake

## Where this landed

A single-matter intake session: the operator pasted a 21-link reading list
after `/intake`. Synonym-expanded dedup found four exact matches already
filed (Naur's paper and the Goedecke essay reading it, already captured
together; the Seldon AI-bill post and Dzombak's CLAUDE.md post, both filed
word-for-word) — no action needed. Three more links were new angles on
already-filed subjects rather than new documents, so they were merged in
place: Simon Willison's stateless-MCP commentary into the existing MCP
2026-07-28 spec capture, a Hacker News discussion into the existing
"LLMs reward expertise" essay capture, and the wider MAGE book/repo into a new
whole-framework overview doc cross-linked from the existing chapter-2.2
capture. `litestream.io` was already parked in the survey tier from an
earlier session and got promoted to a filed reference. The remaining twelve
links were genuinely new and filed across `security/`, several `agentic/`
subdirectories (`anthropic/claude-code`, `prompt-design`, `governance`,
`expertise`, `frameworks`), `dev-tools/`, `software-design/`, and one new
subdirectory — `knowledge/SWE/performance/` — created autonomously since it
sits under the already-established `SWE` domain. One fetch (the Reddit Jido
thread) was blocked by the host; the same material was covered from the
`jido.run` blog post instead, with the Reddit URL left as an uncaptured
citation. Twelve ids minted, registry regenerated, the full gate suite ran
clean, and the batch was committed (`239764e`) and pushed to
`claude/research-intake-links-nhi01p`. The session closed with
`/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Intake: AI-security & agentic-safety pieces (normalization of deviance, OpenAI↔Hugging Face cyberattack, Fable's proactive tool-use) | closed | [normalization-of-deviance-in-ai](/knowledge/SWE/security/normalization-of-deviance-in-ai.md) (+2 siblings, see the [security index](/knowledge/SWE/security/index.md)) | - |
| Intake: LLM tooling & MCP (llm CLI + its 0.32 release, Litestream promotion, stateless-MCP merge, proofreader prompt) | closed | [llm-cli-tool](/knowledge/SWE/dev-tools/llm-cli-tool.md) (+3 siblings) | - |
| Intake: agent-governance & expertise cluster (MAGE framework overview, METR study, HN discussion merge, vibecoded-outputs gist) | closed | [model-based-agentic-software-engineering-mage](/knowledge/SWE/agentic/governance/model-based-agentic-software-engineering-mage.md) (+3 siblings) | - |
| Intake: Elixir/software-design odds and ends (Rust-NIF profiling + new `performance/` subdirectory, UML intro, Jido Assembly Slack clone) | closed | [profiling-rust-nifs-in-elixir](/knowledge/SWE/performance/profiling-rust-nifs-in-elixir.md) (+2 siblings) | - |
| Dedup matches needing no action (Naur's paper, "Programming as theory building," Seldon's AI-bill post, Dzombak's CLAUDE.md post) | closed | unrouted | - |
| Session close via `/create-pull-request merge` | open | unrouted | PR not yet opened or merged as of this capture |

## User

*(invoked `/intake` with a 21-URL reading list)*

```
https://embracethered.com/blog/posts/2025/the-normalization-of-deviance-in-ai/
https://simonwillison.net/2026/Jun/11/fable-is-relentlessly-proactive/
https://simonwillison.net/guides/agentic-engineering-patterns/prompts/#proofreader
https://llm.datasette.io/en/stable/index.html
https://simonwillison.net/2026/Jul/22/openai-cyberattack/
https://simonwillison.net/2026/Jul/31/stateless-mcp/
https://simonwillison.net/2026/Aug/4/new-release-of-llm/
https://blog.smaller-infinity.com/posts/profiling-rust-nifs-in-elixir/
https://litestream.io/
https://davisjam.github.io/model-based-agentic-software-engineering/
https://github.com/davisjam/model-based-agentic-software-engineering
https://seldon-ai.com/blog/ai-bill-as-a-management-discipline
https://www.dzombak.com/blog/2025/12/streamlining-my-user-level-claude-md/
https://www.seangoedecke.com/impact-of-ai-study/
https://news.ycombinator.com/item?id=49161518
https://pages.cs.wisc.edu/~remzi/Naur.pdf
https://gist.github.com/MostAwesomeDude/560185c24f959f6fec229739cb5a6735#no-like-analysis-of-the-vibecoded-outputs
https://www.seangoedecke.com/programming-with-ai-agents-as-theory-building/
https://www.geeksforgeeks.org/system-design/unified-modeling-language-uml-introduction/
https://www.reddit.com/r/elixir/comments/1veq0pv/jido_assembly_a_slack_clone_built_with_jido_and/
https://jido.run/blog/jido-assembly-slack-clone
```

## Assistant

<routes ref="em:be781f em:3d9101 em:e4d9cf em:d146ff em:86f6df">
Filed the batch. Everything's committed and pushed to `claude/research-intake-links-nhi01p`; no PR opened, since that's `/create-pull-request`'s job, not `/intake`'s.

**What happened:** Of your 21 links, 4 were exact matches for documents already in the brain (Naur's paper and the Goedecke essay reading it were both already captured together; the Seldon and Dzombak posts were already filed word-for-word) — those needed no action. Three more links weren't new *documents* so much as new *angles* on things already filed — Simon Willison's take on stateless MCP, a Hacker News discussion of an existing essay, and the wider MAGE book/repo around a chapter already captured — so those got merged into the existing docs instead of creating near-duplicates. The `litestream.io` link turned out to already be sitting in the bookmark tier from an earlier session, so this intake promoted it to a filed reference. The rest — twelve documents — were genuinely new and got filed across security, several `agentic/` subdirectories, `dev-tools`, `software-design`, and one new subdirectory (`knowledge/SWE/performance/`, created autonomously since it sits under the already-established `SWE` domain). One fetch (the Reddit Jido thread) was blocked by the host; I covered the same material from the `jido.run` blog post instead and left the Reddit URL as an uncaptured citation.
</routes>

<routes ref="em:b2676a em:cdd51c em:79c1a1 em:45adfd em:f9f0d5 em:41ab78 em:86f6df em:d146ff em:d27de7 em:563b18 em:fab63b em:134093 knowledge/SWE/performance/index.md">
## What I created

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
</routes>

<routes ref="em:be781f em:3d9101 em:e4d9cf survey/bookmarks.md">
## What I modified

| File | Change |
|---|---|
| [The MCP 2026-07-28 specification](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/mcp/mcp-spec-2026-07-28.md) | added a "Practitioner reception" section from Willison's stateless-mcp post |
| [LLMs reward expertise](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/expertise/llms-reward-expertise.md) | added the HN discussion's counterexamples and its non-technical-user nuance |
| [Models and the semantic gap (MAGE, ch. 2.2)](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md) | cross-linked to the new whole-framework overview doc |
| `survey/bookmarks.md` | flipped the litestream.io row to `status: promoted → …` |
</routes>

<routes ref="meta/registry.md">
## Actions I have taken

| Action | Result |
|---|---|
| Dedup search (synonym-expanded) against the bundle before filing each item | 4 exact matches found and skipped; 3 more merged into existing docs rather than duplicated |
| Minted stable `em:` ids, regenerated the registry | 12 ids minted, `meta/registry.md` regenerated |
| Full gate suite (format, xref, contract, registry, codemap, verify, route-tags, glossary, matters, lineage, tests) | all green — pre-commit hook passed clean |
| Committed and pushed | branch `claude/research-intake-links-nhi01p`, commit `239764e` |
</routes>

## Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Ask me to run `/create-pull-request` (recommended) | opens a PR for this batch so it can be reviewed and merged |
| 2 | Review the filing decisions first (esp. the new `performance/` subdirectory and the MAGE two-doc split) before opening a PR | no action from me until you say go |

## User

*(invoked `/create-pull-request merge` — the closing flow that produced this document)*
