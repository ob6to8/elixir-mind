---
type: reference
title: 2026-07-31-turbofieldfare-intake
description: Intake of the TurboFieldfare GitHub repo — a Swift/Metal runtime that streams MoE expert weights from SSD to run Gemma 4 26B-A4B in ~2GB RAM on Apple Silicon — filed as a reference alongside the existing local-inference-stack and hardware-tier documents.
provenance: "Claude Code session (Claude Sonnet 5), 2026-07-31; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, llm-inference, apple-silicon]
timestamp: 2026-07-31
pr: 204
session: https://claude.ai/code/session_01WkiQP7bW1Q6YTuEkwL2u5r
---

# 2026-07-31-turbofieldfare-intake

## Where this landed

The operator ran `/intake` with a bare link to the TurboFieldfare GitHub repo.
No natural phrasing accompanied it, so the work was fetch, dedup-check, file,
and report. The repo's README and GitHub description were fetched and
cross-checked; a dedup search across the bundle (title terms, "Gemma 4", "MoE
expert streaming", "fieldfare") turned up no existing document, and the two
Gemma-4-related items in `survey/bookmarks.md` describe an unrelated,
multimodal Gemma 4 12B model. The existing `llm-engineering/` directory
already held sibling documents on serving stacks and workstation hardware
tiers, so the new document was filed there autonomously — no new directory or
type was needed.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| TurboFieldfare — Swift/Metal runtime streaming MoE experts from SSD to run Gemma 4 26B-A4B on 8GB Apple Silicon Macs | closed | [turbofieldfare-gemma4-apple-silicon](/knowledge/SWE/llm-engineering/turbofieldfare-gemma4-apple-silicon.md) | - |

## User

/intake https://github.com/drumih/turbo-fieldfare

## Assistant

<routes ref="em:96a4d0">
I filed the linked GitHub repo as a new reference document in the brain and pushed the branch. No PR was opened since that wasn't requested.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| reference | [`knowledge/SWE/llm-engineering/turbofieldfare-gemma4-apple-silicon.md`](https://github.com/ob6to8/elixir-mind/blob/claude/turbo-fieldfare-intake-j9k13u/knowledge/SWE/llm-engineering/turbofieldfare-gemma4-apple-silicon.md) (`em:96a4d0`) | captured/summarized external project material, not the operator's own claim |

**What I modified**

| File | Change |
|---|---|
| `knowledge/SWE/llm-engineering/index.md` | added listing for the new doc |
| `meta/registry.md` | regenerated after minting the id |

**Actions I have taken**

| Action | Result |
|---|---|
| Fetched the repo's GitHub page and README | got project purpose, architecture, benchmarks, licensing |
| Dedup search (turbofieldfare, Gemma 4, MoE expert streaming, fieldfare) | no existing doc on this project — two Gemma-4-related survey bookmarks exist but are unrelated (a different, multimodal Gemma 4 12B model) |
| Filed into existing directory `knowledge/SWE/llm-engineering/` | fits alongside the existing local-inference-stacks and hardware-tier docs; no new directory needed |
| `mix brain.id` / `mix brain.registry` / `mix brain.verify` | id minted, registry rebuilt, bundle verifies clean |
| `mix brain.dedup_probe --update-baseline` | 6/19 plain recall, no regression vs. committed baseline |
| Committed and pushed | commit `e9dc15c` on `claude/turbo-fieldfare-intake-j9k13u` |
</routes>

No new type or top-level directory was needed, so nothing is awaiting ratification. Since a bare URL paste carries no natural operator phrasing, the dedup gold-set harvest step (§8) was skipped as instructed.

## User

/create-pull-request merge
