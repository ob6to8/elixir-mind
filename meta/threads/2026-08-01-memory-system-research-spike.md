---
type: reference
title: 2026-08-01-memory-system-research-spike
description: "/intake of mex and SuperLocalMemory seeding a memory-systems research spike: two background sweeps (field landscape, Elixir gap check), the 2026 landscape reference, the strategy analysis (adopt retrieval, decline auto-formation), the elixir-agent-memory project with its build plan, a GrapeRoot follow-up intake that left the verdicts standing, a main merge with one operator-resolved conflict, and the close via /create-pull-request merge."
provenance: "Claude Code session (Claude Fable 5), 2026-08-01 to 2026-08-03; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped; parsed from the host session log"
tags: [meta, thread, intake, agent-memory, landscape, retrieval, elixir, projects]
timestamp: 2026-08-03
session: https://claude.ai/code/session_01T38LBFJw6gPyLPC6YcJfUp
---

# 2026-08-01-memory-system-research-spike

## Where this landed

The operator pointed `/intake` at two memory repos (mex, SuperLocalMemory)
with a four-part ask: research the agent-memory landscape (hype vs proven),
analyze this repo against the strategy, consider an Elixir-native port, and
plan it if advised, viable, and a gap. The session filed both seeds, ran two
background research sweeps, and landed six documents across three commits:
the [2026 landscape reference](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md)
(the field converged on git-versioned files in 2026; the LoCoMo benchmark
wars; memory-injection research), the
[strategy analysis](/meta/analysis/agent-memory-strategy-for-elixir-mind.md)
(adopt the retrieval tier, decline auto-formation), and the
[elixir-agent-memory project](/projects/elixir-agent-memory.md) with its
[design-and-build-order plan](/projects/elixir-agent-memory/design-and-build-order.md)
— a file-canonical recall sidecar, positioned by a scoped gap sweep of the
Elixir ecosystem. A follow-up `/intake` of GrapeRoot tested the analysis and
left its verdicts standing (addendum recorded). `origin/main` was merged in
on operator request, with one hand-kept conflict (dedup gold set) resolved
by the operator's call (union) and the registry re-derived. Closed via
`/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| mex intake — codebase wiki + code graph with drift detection | closed | [mex](/knowledge/SWE/agentic/code-context/mex.md) | - |
| SuperLocalMemory intake — maximalist local-first memory engine | closed | [superlocalmemory](/knowledge/SWE/agentic/agent-memory/superlocalmemory.md) | - |
| Agent-memory landscape research spike (hype vs proven) | closed | [memory-systems-landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md) | - |
| Strategy analysis — what this repo gains/declines from the field | closed | [agent-memory-strategy-for-elixir-mind](/meta/analysis/agent-memory-strategy-for-elixir-mind.md) | - |
| Elixir-native engine — gap check, project hub, build plan | open | [elixir-agent-memory](/projects/elixir-agent-memory.md) | working name (engram?) awaits operator ratification before the engine repo is created |
| GrapeRoot follow-up intake — does it change the analysis? | closed | [graperoot](/knowledge/SWE/agentic/code-context/graperoot.md) | - |
| Dedup gold-set harvest and baselines across the session | closed | [dedup-probe gold set](/meta/evals/dedup-probe.md) | - |
| Merge origin/main into the branch; conflict resolution | closed | `unrouted` | - |

## User

<command-message>intake</command-message>
<command-name>/intake</command-name>
<command-args>
<routes ref="em:a0fbd5 em:fe3522 em:dd64c2 em:6733b4">
https://github.com/mex-memory/mex
https://github.com/qualixar/superlocalmemory
then

* do a research spike into alternatives, the landscape, learnings, what is hype what is proven etc
* do an analysis of this repo with respects to this strategy - what could be gained, and what might be tradeoffs, if there are any
* consider porting these concepts to an elixir native solution (if one does not already exist)
* if that idea is advised, viable, and its a gap in the market, create a plan
</routes>
</command-args>

## Assistant

Status while the two research agents finish their sweeps:

<routes ref="em:a0fbd5 em:fe3522">
**Done so far** — both repos are fetched and filed as `reference` docs (verbatim spans re-confirmed against the raw READMEs before quoting):

- `knowledge/SWE/agentic/code-context/mex.md` — mex turns out to be a Tree-sitter+SQLite code graph fused to a version-controlled markdown wiki with drift detection; filed beside GitNexus and Codebase-Memory, which share its genre. Its philosophy ("Markdown is the durable interface.") is this bundle's own bet applied to codebase knowledge.
- `knowledge/SWE/agentic/agent-memory/superlocalmemory.md` — a solo-authored, AGPL, maximalist local-first memory engine (five retrieval channels, self-reported LoCoMo scores, "sheaf cohomology" branding). Filed with vendor claims quoted verbatim and marked as vendor-run; its own README scopes the headline 87.7% to a single conversation.
</routes>

**Groundwork for the analysis** — the bundle's priors are stronger than expected: the 2026-07-10 second-brain field comparison, the 615-doc re-evaluation (retrieval graded C−), the vector-DB recall analysis with its tier-1/tier-2 framework, and the two-tier-memory/GenServer BEAM analyses. Checked live: the dedup probe currently scores plain 8/28 with no regression against baseline — the tier-2 embedding trigger has formally not fired, which frames exactly where the mex/SLM strategy could and couldn't help this repo.

**In flight** — one agent is sweeping the memory-systems landscape (Letta/Mem0/Zep/benchmark disputes/community reception of the two seed repos), another is running the Elixir-ecosystem gap check with an enumerated search space. When they report back I'll write the landscape reference, the `meta/analysis` doc, and — if the gap and viability hold up — the `projects/` hub and plan, then mint ids, update indexes, run the gate suite, and commit and push to `claude/memory-system-research-jan4n8`.

## Assistant

First tranche is committed and pushed. Commit `5663627` on `claude/memory-system-research-jan4n8` carries the two seed references (`mex.md` with id `em:a0fbd5`, `superlocalmemory.md` with `em:fe3522`), their index entries, the refreshed registry and dedup baseline (plain recall 8/28, unchanged — no regression to escalate). The full pre-commit gate suite ran green: format, xref, contract/registry/code-map freshness, verify, route tags, glossary, lineage, and 201 tests. The two advisory link warnings point at the landscape doc that lands with the next tranche.

Still in flight: the landscape research agent and the Elixir gap-check agent. When their reports arrive I'll write the landscape reference, the `meta/analysis` read of this repo against the strategy, and — if the verdict holds — the `projects/` hub and plan, then commit and push the second tranche.

## Assistant

<routes ref="em:6733b4 em:50bbc3">
The Elixir gap check is back, and it sharpens the thesis: the niche is not empty — ~15 single-author experiments appeared in the last six months (jido_memory, mnemosyne, jiyi, recollect, graphonomous, plus Arcana as a mature RAG substrate) — but every entrant is a store-canonical memory database in the Mem0 mold, none has credible evaluation, and none is file-canonical. The differentiated open slot is exactly what this brain would want: a derived-index recall sidecar where markdown stays the source of truth. All building blocks confirmed active (anubis_mcp as de-facto MCP standard, Bumblebee text embeddings, exqlite with FTS5 compiled in, pgvector/sqlite-vec/hnswlib). mex turns out to be TypeScript at ~1.2k stars; SuperLocalMemory is Python at ~201 stars.
</routes>

That verdict clears the bar for the project hub and plan. Writing those now while the landscape agent finishes.

Second tranche is pushed (`01b70de`): the `projects/elixir-agent-memory` hub (`em:6733b4`) and its design-and-build-order plan (`em:50bbc3`), listed in the projects index, full gate suite green. The remaining advisory link warnings all point at the two docs still to come.

One artifact stream remains: the landscape research agent is still sweeping the memory-systems field (Letta/Mem0/Zep, the benchmark disputes, community reception of the seed repos). When it reports, I'll write the landscape reference, the strategy analysis (`meta/analysis/agent-memory-strategy-for-elixir-mind.md`), fold reception facts into the two repo docs, harvest the dedup gold row, and ship the final tranche.

## Assistant

The landscape sweep is back and it reframes everything sharply: the field's proven end converged on exactly this bundle's architecture in 2026 (Letta pivoted its coding-agent memory to git+files in February; LangChain shipped a markdown-wiki OpenWiki in July; every first-party memory is a file directory), the benchmark wars are dirtier than expected (LoCoMo has ~6.4% wrong gold answers; Mem0 and Zep each accuse the other of misconfiguration; Letta's plain files+grep baseline beat Mem0's graph variant), and memory-injection attacks (MINJA, MemGhost) make write-gating and provenance — this repo's whole posture — the emerging defense. Writing the landscape reference and the strategy analysis now.

All four asks are delivered, committed, and pushed to `claude/memory-system-research-jan4n8` in three gate-green commits (`5663627`, `01b70de`, `76d877d`). No pull request was opened — that stays with you via `/create-pull-request`.

<routes ref="em:dd64c2 em:6733b4">
**In plain terms:** I read and filed both repos you pointed at, then ran two background research sweeps — one across the whole memory-tools field, one across the Elixir ecosystem. The headline from the field sweep is good news for this repo: during 2026 the leading memory vendors moved *toward* what this brain already is — Letta rebuilt its coding-agent memory on git-versioned markdown files, LangChain shipped a markdown-wiki memory, and every first-party memory feature (Claude Code, the Anthropic API memory tool) is a file directory. The one place the field is genuinely ahead of this repo is search quality over what's stored — a weakness this brain had already graded (C−) and designed a fix for (the "tier-2" embedding dedup) without ever building it. So the Elixir idea landed in a reshaped form: not a port of either repo, but a small standalone Elixir engine that builds disposable search indexes over a markdown bundle while the files stay the source of truth — with this brain as its first customer. I opened that as a project with a full build plan.
</routes>

**The judgment calls, with their basis:**

<routes ref="em:dd64c2">
- **Hype vs proven.** The field's benchmark of record (LoCoMo) has ~6.4% wrong gold answers per an independent audit, and Mem0 and Zep each published accusations that the other misconfigured their comparison; Letta measured plain files+grep at 74.0% beating Mem0's graph variant at 68.5% on that same benchmark. Production-proven: first-party file-based memory and curated-file practice. Contested: vendor-run benchmark claims and graph-memory premiums. All quoted from both sides with URLs in the [landscape reference](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md).
</routes>
<routes ref="em:a0fbd5 em:fe3522">
- **The seeds.** [mex](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/knowledge/SWE/agentic/code-context/mex.md) is substance-leaning (curated markdown + deterministic code graph + drift detection, on-trend with the field's convergence) filed beside GitNexus in `code-context/`; its maker is unnamed on its own site and no HN thread was found in the sweep's queries. [SuperLocalMemory](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/knowledge/SWE/agentic/agent-memory/superlocalmemory.md) is the maximalist counter-example — five retrieval channels, "sheaf cohomology" branding, self-authored preprints, a 1-point Show HN — filed with every claim quoted verbatim and marked vendor-run.
</routes>
<routes ref="/meta/analysis/agent-memory-strategy-for-elixir-mind.md">
- **What this repo gains, and declines.** The [strategy analysis](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/meta/analysis/agent-memory-strategy-for-elixir-mind.md) adopts the retrieval tier (BM25 headroom first, embeddings after, both as an external sidecar so `deps: []` holds), raises the epistemic-overlay plan's priority (temporal validity is the one field-named property this bundle lacks), and declines auto-formation on three evidence streams: the community's junk-drawer failures, the ACE context-collapse finding, and the memory-injection attacks (MINJA, MemGhost) whose emerging defenses — provenance, audit, write confirmation — are this repo's existing machinery. Checked live today: dedup probe plain 8/29, expanded 24/29, no regression — the tier-2 trigger has not formally fired.
</routes>
<routes ref="em:6733b4 em:50bbc3">
- **The Elixir verdict.** Gap: real but not empty — the sweep enumerated ~35 hex.pm searches, GitHub, Elixir Forum, and both awesome-lists, finding ~15 single-author 2026 experiments, all store-canonical, none above 30 stars, no Mem0 port, no official MCP-org Elixir SDK, and no file-canonical eval-first entrant. Viable: anubis_mcp 1.14.0, Bumblebee 0.7.1, exqlite with FTS5 compiled in, pgvector at ~1M downloads. Advised: yes, as the [elixir-agent-memory project](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/projects/elixir-agent-memory.md) with a [structured plan](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/projects/elixir-agent-memory/design-and-build-order.md) — FTS5 tier and eval harness first, adoption into `/intake` gated on a side-by-side gold-set measurement, with the crowding risk stated (fifteen entrants in six months; the plan's refresh rule re-checks the incumbent map before build).
</routes>

**What I created**

| type | doc | why this type |
|---|---|---|
| reference | `knowledge/SWE/agentic/code-context/mex.md` (`em:a0fbd5`) | external repo captured and distilled |
| reference | `knowledge/SWE/agentic/agent-memory/superlocalmemory.md` (`em:fe3522`) | external repo captured; vendor claims quoted, marked |
| reference | `knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md` (`em:dd64c2`) | multi-source field survey, true regardless of this repo |
| analysis | `meta/analysis/agent-memory-strategy-for-elixir-mind.md` | a question judged against evidence, ending in a recommendation |
| project | `projects/elixir-agent-memory.md` (`em:6733b4`) | a system to be built outside this repo, incubating here |
| plan | `projects/elixir-agent-memory/design-and-build-order.md` (`em:50bbc3`) | deferred cold-context work; decisions must survive the session |

**What I modified**

| file | thrust |
|---|---|
| `agent-memory/index.md`, `code-context/index.md`, `projects/index.md`, `meta/analysis/index.md` | listed the six new docs; created `projects/elixir-agent-memory/index.md` |
| `meta/evals/dedup-probe.md` | gold row harvested from your spike phrasing → `em:dd64c2`; baseline regenerated (expanded 24/29, plain 8/29) |
| `meta/registry.md` | recompiled for the five new ids |

**Actions I have taken**

| action | result |
|---|---|
| Fetched both repos, re-fetched for verbatim figure spans | all quoted numbers confirmed against raw READMEs |
| Two background research sweeps (field landscape; Elixir gap with enumerated search space) | findings distilled into the landscape doc and analysis |
| `mix brain.dedup_probe` before and after | plain recall unchanged — no regression to escalate |
| Three commits pushed, full gate suite each time | 201 tests, verify/route-tags/glossary/contract all green |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | `/create-pull-request` | closes the session: captures the thread, stamps the analysis's pending `attribution.from` (the one expected advisory warning), opens the PR |
| 2 | Ratify the engine's name | the plan's open question — `engram` returned zero hits on hex.pm in the sweep; decision needed only before the engine repo is created |
| 3 | Re-prioritize the epistemic-overlay plan | the analysis's recommendation #2; supersession is the one field-named property this bundle lacks structurally |

## User

<command-message>intake</command-message>
<command-name>/intake</command-name>
<command-args>https://github.com/kunal12203/graperoot
and analyze against above. does this change your analysis?</command-args>

## Assistant

**Short answer to your question: no — the verdicts stand, and GrapeRoot actually sharpens one of them.** Filed, tested against the analysis, committed, and pushed (`dc9f369`, all gates green).

<routes ref="em:c71155">
**What GrapeRoot is:** not a memory system in the Mem0 sense and not a curated wiki in the mex sense — it's a context *pre-loading* engine (Python, ~969 stars): a semantic code graph ranks and pre-packs code into the prompt before the model sees it, weighted by what you've touched in the session ("Compounding Context for AI Coding Assistants"). Two structural facts matter more than its features: the launcher is Apache-2.0 but "The `graperoot` graph engine (PyPI): proprietary", and its cross-session memory (`context-store.json`, "Persistent decisions/tasks/facts across sessions") lives in a gitignored directory — outside version control entirely. Its benchmark table ($0.49→$0.27 per prompt, 11.7→3.5 turns, "10 out of 10 prompts" cost wins over "50+ engineering prompts") is vendor-run with methodology hosted on its own site and no model named in the README; one web search found no HN or Reddit threads, only the vendor's surfaces and testimonials.
</routes>

**Why the analysis doesn't move, recorded as a same-day addendum in the [analysis doc](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/meta/analysis/agent-memory-strategy-for-elixir-mind.md):**

<routes ref="em:c71155 em:dd64c2 /meta/analysis/agent-memory-strategy-for-elixir-mind.md">
1. **It's orthogonal to the sidecar plan.** GrapeRoot optimizes token economics — pre-packing a prompt cheaply — while the engine plan answers recall quality — can intake find the document a new item should merge into. Different corpus (code vs knowledge bundle), different objective, Python with a closed core, so the Elixir gap claim and the plan's incumbent map are untouched. The one connection: the plan's deferred session-start router now has a second exemplar alongside mex's.
2. **Its memory design is a counter-exemplar that strengthens the decline.** Keeping cross-session decisions in gitignored JSON — unversioned, unreviewable, provenance-free — is the exact polarity Letta abandoned when it moved memory *into* git. One 2026 entrant on the far side doesn't reverse the convergence; it clarifies what the convergence is about: not files as a format, but memory that is versioned, reviewable, and attributable — the property this repo's governance enforces.
3. **One genuine refinement to the [landscape](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md):** retrieval posture is a three-way axis, now written in — agentic pull (Claude Code's bet), external index (the Milvus position), and graph pre-load (GrapeRoot productizes it) — with the leading coding agent on the first pole and the other two carrying the burden of proof.
</routes>

**What I created**

| type | doc | why this type |
|---|---|---|
| reference | [`code-context/graperoot.md`](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/knowledge/SWE/agentic/code-context/graperoot.md) (`em:c71155`) | external repo captured; filed beside mex/GitNexus — its genre is code-context, not agent-memory |

**What I modified**

| file | thrust |
|---|---|
| `memory-systems-landscape.md` | the retrieval-posture bullet recast as the three-way axis, GrapeRoot linked |
| `agent-memory-strategy-for-elixir-mind.md` | dated addendum: verdicts unchanged, two refinements, basis stated |
| `code-context/index.md`, `meta/registry.md` | GrapeRoot listed with its id; registry recompiled |

**Actions I have taken**

| action | result |
|---|---|
| Fetched README + repo page, then re-fetched for verbatim spans | benchmark rows, license split, and storage lines confirmed character-exact |
| One reception web search | no third-party threads located (scoped in the doc) |
| Dedup grep, id mint, baseline refresh, gate suite, push | no duplicates; plain recall 8/29, unchanged — no regression; `dc9f369` pushed |

No gold row this time — your phrasing described the task ("does this change your analysis"), not the material, so per the harvest rule it was skipped. The standing options from the previous report (close via `/create-pull-request`, ratify the engine name, re-prioritize the epistemic overlay) are unchanged.

## User

merge main into thread

## Assistant

The merge of `origin/main` (now at `684530d` — it picked up several days of other sessions' work, including a `/todo` → `/matter` register migration) is mid-flight, paused on one conflict that needs your call.

**Resolved autonomously:** `meta/registry.md` — generated artifact, so I discarded both sides and recompiled it from the merged tree with `mix brain.registry` (the sync skill's sanctioned path). Everything else auto-merged, including the analysis index (my strategy-analysis entry now sits beside main's new TDD and matters-vs-plans entries).

**Blocked on you:** `meta/evals/dedup-probe.md`, where both branches appended a gold-set row at the same table position — hand-kept content, which the sync skill routes to the operator even when it looks trivially resolvable:

```
<<<<<<< HEAD (this branch)
| research spike into alternatives, the landscape, learnings, what is hype what is proven | em:dd64c2 | …
=======  (origin/main)
| the berkeley multi-agent-failure taxonomy paper | em:ec728d | … harvested at intake 2026-08-03 |
>>>>>>>
```

The second conflicted hunk in the same file is the `## Baseline` table (8/29 vs 8/30) — that section is generated by `mix brain.dedup_probe --update-baseline`, so it gets re-derived after resolution regardless of which side stands.

| # | question | my recommendation |
|---|---|---|
| 1 | How should the dedup-probe gold-set conflict resolve? | **Union — keep both rows** (mine and main's MAST row; they're independent harvests from different intakes, and dropping either loses a real gold row), then regenerate the baseline, run the gate suite, and push the merge |

Say the word and I'll finish the merge that way — or name a different resolution and I'll apply that instead.

## Assistant

The tree is intentionally mid-merge: the working state can't be committed until the `meta/evals/dedup-probe.md` conflict is resolved, and per the sync skill that resolution is your call, not mine — the blocking question from my last message stands (my recommendation: keep **both** gold rows, regenerate the baseline, then commit and push the merge). As soon as you answer, I'll complete the merge, run the gates, and push; nothing else is outstanding.

## User

1 agree

## Assistant

Merge complete and pushed. The branch now contains everything on `origin/main` up to `684530d`, merged as a true merge commit `d3a9c4a` (git's default merge message, per the sync skill).

- **Gold-set conflict** — resolved as agreed: both rows kept (your memory-spike row `em:dd64c2` and main's MAST-taxonomy row `em:ec728d`), then the `## Baseline` table regenerated from the merged corpus — plain recall now 9/31 with the probe reporting no regression.
- **Registry** — recompiled from the merged tree rather than hand-merged, per the generated-artifact rule.
- **Gates** — the full pre-commit suite ran green on the merge commit, including the checks main added while this branch was out (the new `mix brain.matters` register gate, 211 tests up from 201).

One observation from the merge, for when you close this thread: main retired the `todo` type and `/todo` skill in favor of the matter register while this branch was out — this branch's documents don't reference todos, so nothing here needed conforming. The branch diff against main is now purely this session's memory-spike work, ready for `/create-pull-request` whenever you want it landed.

## User

<command-message>create-pull-request</command-message>
<command-name>/create-pull-request</command-name>
<command-args>merge</command-args>

