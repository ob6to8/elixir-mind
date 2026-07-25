---
type: reference
title: 2026-07-25-manus-context-engineering-intake-and-currency-check
description: "Intake of Yichao 'Peak' Ji's Manus context-engineering post to the operator's specification — a dated currency check leading the doc, the six lessons rewritten with every technical term defined inline for a reader new to agents, and 19 new glossary terms — plus an answer to the operator's question about a supposed 'analysis' skill (it's three separate things: /summarize-technical, type: analysis, and /elaborate)."
provenance: "Claude Code session (Opus 5), 2026-07-25; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, context-engineering, currency-check, glossary, manus]
timestamp: 2026-07-25T18:35:00Z
session: https://claude.ai/code/session_01CWRX8GSaMFJBvkv3eKcHbj
---

# 2026-07-25-manus-context-engineering-intake-and-currency-check

## Where this landed

A single `/intake` with a bespoke specification. The operator asked for Yichao
'Peak' Ji's "Context Engineering for AI Agents: Lessons from Building Manus"
(2025-07-18, already parked as a surveyed bookmark) to be filed three ways at
once: prefaced by a dated analysis of how the post has aged, rewritten so every
technical term is qualified and defined inline for someone new to agents, and
with every term not yet in the glossary added there. They also asked what the
"analysis" skill for technical articles is — the answer being that no such
skill exists; it conflates `/summarize-technical` (the layered-breakdown skill),
`type: analysis` (a document type under `meta/analysis/`), and `/elaborate` (the
phrase-scale sibling). The aging analysis reused the bundle's existing
`## 2026 currency check` pattern (from the Anthropic context-engineering essay
capture) rather than a new genre. Everything landed in
[context-engineering-lessons-from-manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md)
(`em:b4440a`): currency-check verdict — nothing refuted, four lessons stand,
lesson 2's masking mechanism superseded by deferred tool loading (which honors
its append-only invariant), lesson 5 qualified by compaction practice to
"verbatim while task-relevant, retire once resolved." The glossary gained 19
entries (core LLM-plumbing vocabulary the brain lacked — context window,
context engineering, fine-tuning, prefix caching, logit masking, and more) and
5 existing entries gained citations. The survey-tier bookmark row was promoted.
All gates green; dedup-probe plain recall unchanged at 5/14; no gold row (the
ask carried a URL, not a subject phrasing). After the report, the operator said
"proceed", which ran this capture and the PR that anchors it.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| "Analysis skill" question — no such skill; three-way conflation explained | closed | `unrouted` | - |
| Manus post intake: currency check + inline-defined walkthrough | closed | [context-engineering-lessons-from-manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md) | - |
| Glossary: 19 new terms, 5 merged citations | closed | [glossary index](/beliefs/glossary/index.md) | - |
| Survey-tier bookmark promoted to filed reference | closed | [bookmarks register](/survey/bookmarks.md) | - |

## User

/intake https://medium.com/@peakji/context-engineering-for-ai-agents-lessons-from-building-manus-71883f0a67f2

I believe their is an "analysis" skill for creating technical articles - what is it and what does it do?

my goal here is to intake this article in a specific way - first, preface it with a dated analysis describing how well it has aged and what has changed in the status quo since it was written.

then, I would like the article presented in a way where each technical term is qualified and defined inline in the text itself - so essentially rewriting the article for someone new to agents.

along the way, I would like any term that is not currently in the glossary to be added there

## Assistant

<routes ref="em:b4440a">
Pushed. Here's what landed.

## Your question about the "analysis" skill

There isn't one — that's a conflation of three things:

- **`/summarize-technical`** is the skill for technical articles. It produces a three-part layered breakdown: plain-language summary → key terms → technical summary reusing those terms. `/intake` calls it automatically for substantial technical sources.
- **`type: analysis`** is a *document type* (not a skill) for point-in-time evaluations under `meta/analysis/` — a question investigated against evidence, yielding a recommendation.
- **`/elaborate`** is the phrase-scale sibling: it unpacks one technical mouthful rather than a whole document.

For an aging assessment there's also an established in-bundle pattern I followed rather than inventing one: a **`## 2026 currency check`** section inside the reference doc itself, as used in [effective-context-engineering-for-agents](https://ob6to8.github.io/elixir-mind/knowledge/SWE/agentic/agentic-loop/effective-context-engineering-for-agents.html).

## What I filed

[**context-engineering-lessons-from-manus.md**](https://github.com/ob6to8/elixir-mind/blob/claude/article-intake-aging-analysis-t4nwxp/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md) (`em:b4440a`, `type: reference`), promoted from the survey-tier bookmark row you'd already parked.

One framing note: rather than reproduce the article with insertions, I wrote the walkthrough as original distilled prose covering all six lessons with every term defined inline at first use — which is what the brain's own "capture the knowledge, cite the source" rule requires anyway, and keeps us clear of reproducing the source. Short quotes only where Ji's exact coinage matters; both URLs cited.

**Currency check (researched today, 12 months on).** The headline: nothing refuted, four lessons unmodified, but two moved.

- **Lesson 2 ("mask, don't remove") is the big one.** Its rule was *never mutate the tool array mid-loop*. Anthropic's Tool Search Tool (Nov 2025) with `defer_loading` does exactly the forbidden thing — ~85% fewer tool-definition tokens, MCP evals 49%→74% (Opus 4) and 79.5%→88.1% (Opus 4.5). The reconciliation is the interesting part: deferred loading *appends* definitions instead of rewriting the prefix, so it honors Ji's real invariant while breaking his literal instruction. Read it today as "never *edit* what the cache has seen." This session runs deferred tool loading, so the demonstration is right here.
- **Lesson 5 ("keep the wrong stuff in") is genuinely qualified** — it's in direct tension with compaction. Current consensus: keep failures *verbatim while task-relevant*, retire once resolved. "Verbatim" is load-bearing — paraphrasing a concrete error string destroys the agent's ability to match on it.
- Lesson 3 is the most vindicated (Memory Tool, markdown-file convergence); its SSM speculation is playing out only as *hybrid* attention/state-space architectures, not file-native agents. Lesson 4 became a product feature. Lesson 6 held, but the field's fix shifted from serialization noise to subagent isolation.

## Glossary

**19 new entries** — the brain turned out to have a real hole in core LLM-plumbing vocabulary (no `context window`, no `context engineering`, no `fine-tuning`): kv-cache hit rate, prefix caching, logit masking, response prefill, context window, lost-in-the-middle, recitation, context offloading/isolation/compaction, deferred tool loading, error recovery, few-shot prompting, state-space model, deterministic serialization, vLLM, context engineering, fine-tuning, in-context learning.

**5 merged** with new citations and cross-links: kv-cache, function calling, append-only, agent memory, context rot.

Gates all clean — `verify`, `glossary --materialize`, `route_tags`, `registry`, `contract`. Dedup-probe plain recall unchanged at 5/14, no regression; no gold row harvested since the intake carried a URL rather than a subject phrasing in your words.

No PR opened — say the word (or `/create-pull-request`) if you want one.
</routes>

## User

hello?
proceed

## Assistant

Hello — I'm here. The intake itself is done, committed, and pushed. Taking "proceed" as the go-ahead for the remaining step I left open: the pull request. Per the contract that means running the full `/create-pull-request` flow — capture this session as a thread doc, glossary it, then open the PR.

*(The session then ran `/create-pull-request`: this capture, the glossary pass over it, and the PR that anchors this thread.)*
