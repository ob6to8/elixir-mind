---
id: em:5a89af
type: reference
title: "When an LLM workflow should have been regex, deterministic parsers, and ML models (r/LLMDevs)"
description: An LLM absorbs uncertainty a team hasn't yet had to formalize into schemas, parsers, rules, and classifiers — but once that uncertainty is understood, leaving the whole workflow inside one probabilistic call is a stale architectural default, not a continued need for flexibility.
resource: https://www.reddit.com/r/LLMDevs/comments/1vbjwts/when_an_llm_workflow_should_have_been_regex/
provenance: "r/LLMDevs discussion thread, pasted verbatim by the operator, 2026-08-01"
tags: [llm-workflow-design, deterministic-code, architecture, cost-optimization, parsers, classifiers, task-decomposition]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pasted the Reddit thread alongside the Seldon AI-bill article as a paired capture on when LLM workflows should decompose into deterministic components"
---

# When an LLM workflow should have been regex, deterministic parsers, and ML models

## Thesis

An LLM lets a team prototype complex backend logic without up-front schemas,
parsers, rules, or classifiers — it absorbs uncertainty that would otherwise
demand real technical design. **The failure mode is that the uncertainty
resolves but the architecture doesn't move with it.** A prompt that reads a
support conversation, identifies the account, classifies the issue, normalizes
a date, checks an SLA rule, and emits JSON is describable as "an LLM
workflow," but that label hides its real structure: a parser, an entity
lookup, a classifier, a few date operations, some business rules, and a
schema validator — with perhaps one stage that still genuinely needs language
understanding. Regexes, parsers, finite rules, and classical ML remain "fast,
inspectable, testable, deterministic within their defined boundaries, and
usually inexpensive to operate," and their failure modes can be understood
*before* an incident, unlike a model that "hallucinate[s] a new date format
because it feels plausible." The recommended shape is layered: conventional
code handles the cases it can define confidently, and a model handles only
the residual cases that are genuinely ambiguous or still being discovered.

## Switch-point heuristics from the discussion

- **Can you write down the failure?** *"If I can describe exactly what a
  wrong output looks like, a parser does it cheaper and I'll know when it
  breaks. Once I can't describe it, the fuzziness is doing real work and I
  stop fighting it."* (u/Relative-Emu-1346)
- **Are you writing evals for something a parser would just guarantee?**
  *"Once the shapes stop surprising you it's worth inverting, hardcode the
  common paths and leave the model as the fallback for the tail."* One
  extraction pipeline run on that split for about a year ended with the LLM
  seeing roughly 5% of traffic. (u/ronin4001)
- **Can you attribute a wrong output to a single stage?** A megaprompt's
  failure mode is that "when a 4h SLA check is wrong, you can't tell if
  extraction, normalization, or the rule drifted" — the fix is to leave the
  model only at the unstructured-text → JSON boundary, validate the output
  (e.g. with Pydantic), then move deterministic stages (dates, SLA rules)
  into ordinary code with unit tests. (u/Soggy_Friendship9023)

## What's harder than the split itself

Two independent field reports agree the *migration itself* is not the hard
part — locating the boundary is:

- A financial-data pipeline split rule-based classification (document
  metadata, form codes) from LLM-based content extraction; the deterministic
  layer took the majority of traffic in milliseconds, the LLM handled the
  remaining 20–30% where language understanding mattered. *"The migration
  itself wasn't hard. What took time was figuring out where the boundary sat,
  which inputs were genuinely ambiguous versus just looked ambiguous because
  we hadn't written the rules yet."* (u/Positive-Buddy-1258)
- A separate report on a team that spent weeks prompt-engineering around a
  date-hallucination problem a 15-line `datetime` + regex function would have
  solved — resisted, per that commenter, because no one wanted to be the one
  who suggested dropping AI from that stage. (u/NoData4043)

## A dissenting simplification

One heavily-upvoted reply reduces the whole discussion to a lookup table by
signal type, without an intermediate heuristic: **parser** — word/character
matching suffices; **LLM** — deep semantic understanding *and* a complex
output are both needed; **BERT-style classifier** — deep semantic
understanding suffices but the output is a single scalar (0–1) score; other
**classical classifiers** — semantic depth isn't required but plain word
matching is too brittle. (u/WolfeheartGames)

## Related in this brain

- [model cascade](/beliefs/glossary/model-cascade.md) — the adjacent cost
  pattern of routing between *models* by difficulty, rather than replacing a
  stage with non-model code entirely.
- [When to roll your own advisor-pattern harness](/meta/analysis/when-to-roll-your-own-advisor-harness.md) —
  a related build-vs-buy decision one layer up: which parts of an
  orchestration stack are worth owning outright.
- [The AI bill is becoming a management discipline](/knowledge/SWE/agentic/workflow-decomposition/ai-bill-as-a-management-discipline.md) —
  the same decomposition argument made from a cost-governance angle: workflows
  mature from frontier-model exploration to deterministic-plus-fallback
  production.

# Citations

- r/LLMDevs, "When an LLM workflow should have been regex, deterministic
  parsers and ML models" —
  <https://www.reddit.com/r/LLMDevs/comments/1vbjwts/when_an_llm_workflow_should_have_been_regex/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:5a89af">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-01-llm-workflow-decomposition-intake (2026-08-01)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:5a89af`]**  (co-feeds: `em:7d4960`)

https://seldon-ai.com/blog/ai-bill-as-a-management-discipline
https://www.reddit.com/r/LLMDevs/comments/1vbjwts/when_an_llm_workflow_should_have_been_regex/

here is the reddit thread copy:

When an LLM workflow should have been regex, deterministic parsers and ML models
[Discussion](https://www.reddit.com/r/LLMDevs/?f=flair_name%3A%22Discussion%22)
One of the more useful properties of an LLM is that it allows us to prototype complex backend logic quickly without worrying about infra and deep technical design.
The model absorbs a great deal of uncertainty that would otherwise require schemas, parsers, rules, classifiers, and rather more thought than the feature may initially deserve.
The problem begins when the uncertainty disappears but the architecture does not change.
Consider a prompt that reads a support conversation, identifies the customer account, classifies the issue, normalizes a date, checks an SLA rule, and emits a JSON record. We can describe this as an LLM workflow, but that description hides more than it reveals.
An experienced developer looking at the same workflow may see a parser, an entity lookup, a classifier, a few date operations, some business rules, and a schema validator. Perhaps one stage still benefits from language understanding. It does not follow that every stage should remain inside one probabilistic model call.
There is a tendency in current AI development to treat regexes, parsers, finite rules, conventional search, and classical machine learning as obsolete techniques. In practice, they retain the same virtues they always had. They are fast, inspectable, testable, deterministic within their defined boundaries, and usually inexpensive to operate. More importantly, their failure modes can often be understood before an incident occurs.
A regular expression is not intelligent, but it does not hallucinate a new date format because it feels plausible. A parser does not occasionally reinterpret the schema. A lookup table does not become less accurate after a provider updates its model. A well-calibrated classifier may be less impressive in a demo, but much easier to reason about in production.
None of this implies that LLMs should be replaced wholesale. They remain unusually effective when the task is ambiguous, open-ended, or still being discovered. The more interesting architecture is often a layered one: conventional software handles the cases it can define confidently, while a model handles the residual cases that genuinely require flexible reasoning.
I'm curious whether others have seen this transition in production. Have you replaced parts of an LLM workflow with parsers, rules, classical models, or ordinary backend code? What made the change worthwhile, and which part of the migration turned out to be harder than expected?

Comments Section

[Relative-Emu-1346](https://www.reddit.com/user/Relative-Emu-1346/) •1d ago
The switch point I use is whether I can write down the failure. If I can describe exactly what a wrong output looks like, a parser does it cheaper and I'll know when it breaks. Once I can't describe it, the fuzziness is doing real work and I stop fighting it.

[The_Noble_Lie](https://www.reddit.com/user/The_Noble_Lie/) •1d ago
One of the best posts I've read here ever.

[NoData4043](https://www.reddit.com/user/NoData4043/) •1d ago
Been saying this for a while now but people get weirdly defensive about it. There's something almost addictive about the "just throw it at the LLM" approach because it works well enough in the demo and then you never have to think about edge cases until 3am when it randomly decides October has 42 days.
The date parsing example hits close to home. Watched a team spend weeks trying to prompt-engineer their way out of a hallucination problem that would've been a 15-line Python function with datetime and a couple regex patterns. But nobody wanted to be the one who said "let's just not use AI for this part" because it felt like admitting defeat somehow.
The layered architecture you described is exactly where things get interesting though. Figuring out which parts actually benefit from the flexibility versus which parts are just deterministic problems wearing a probabilistic trenchcoat is a skill that's gonna matter more and more.

[Ok_Philosophy_4031](https://www.reddit.com/user/Ok_Philosophy_4031/) •1d ago
I think one part is that there is a kind of mental regression that befalls some people who over-rely on ChatGPT, Claude Code and other AI tools when they begin to outsource thinking.
The other is that LLM based workflow can take some effort to untangle once things get complex, and there is a lack of good tooling for this untangling at the moment.

[mirageofstars](https://www.reddit.com/user/mirageofstars/) •3h ago
Ha! Was someone tellong the team "just prompt harder"?

[johnerp](https://www.reddit.com/user/johnerp/) •1d ago
My solution is that I've built a mock llm which Claude creates regex rules to simulate, I've literally now moved this into an LLM proxy layer and is now an operational efficiency layer, it means I keep my harness consistent and intercept an llm call and respond deterministically. It's dynamic enough the extract data from the prompt to push back into the response (eg json).
Yes it would be more efficient to directly code this but it complicates a great workflow.

[Positive-Buddy-1258](https://www.reddit.com/user/Positive-Buddy-1258/) •23h ago
Did this split on a financial data pipeline. Deterministic layer runs rule-based classification off document metadata and form codes, handles the majority of traffic in milliseconds. LLM only kicks in for content extraction where language understanding matters, somewhere around 20-30% of volume.
The migration itself wasn't hard. What took time was figuring out where the boundary sat, which inputs were genuinely ambiguous versus just looked ambiguous because we hadn't written the rules yet.

[TheOdbball](https://www.reddit.com/user/TheOdbball/) •23h ago
Yeah I've been on this wave :: my model carries its own deterministic system. A single .agent folder & inside it a mini Linux env
LLM models make up 5% of my setup
Outside is the harness and receipt tracking and to keep it t all alive I have a single systemd script boot up a BEAM OTP runtime , then everything downline can only call within that file
Nothing , not even me manually , can call sudo on the Event stream. All internal events are BLAKE3 hashed and this image is the receipt chain I use which is cheaper and semantically better than jsonL across the board

[ronin4001](https://www.reddit.com/user/ronin4001/) •1d ago
My tell is when I start writing evals to check something a parser would just guarantee. Once the shapes stop surprising you it's worth inverting, hardcode the common paths and leave the model as the fallback for the tail. Ran an extraction pipeline on that split for about a year and the LLM ended up seeing maybe 5% of the traffic, the rest was boring code that couldn't drift.

[Soggy_Friendship9023](https://www.reddit.com/user/Soggy_Friendship9023/) •23h ago
The megaprompt failure mode is attribution: when a 4h SLA check is wrong, you can't tell if extraction, normalization, or the rule drifted. I usually leave the model at the support-message -> JSON boundary, validate with Pydantic v2, then move dates and SLA into normal code with pytest cases.

[WolfeheartGames](https://www.reddit.com/user/WolfeheartGames/) •20h ago
This whole post and comment section is some were fever dream. A bunch of wasted words for things people know, and no depth beyond the surface. Like all llm written.
Parser: when what you need can be determined by word or character matching.
Llm: when you need deep semantic understanding. And need a complex output.
BERT: when you need deep semantic understanding, and a scalar 0-1 is enough signal. Its a classifier.
Other classifiers: when you dont need deep semantic understanding but word matching is too brittle.

---

**[`em:5a89af`]**  (co-feeds: `em:7d4960`)

I'll start by fetching the Seldon blog post, then work through dedup search and filing for both pieces.

IDs are minted (`em:5a89af`, `em:7d4960`) and the registry is refreshed. Now update the index.md placeholders and the parent indexes, then verify.

Bundle verifies cleanly; the warnings are pre-existing and unrelated to this intake. Now the dedup gold-set harvest step, since the operator gave natural phrasing in their paste (the article/thread pointers themselves — no distinct request phrasing beyond the URLs). Let me check the gold set format.

No regression (plain recall unchanged at 8/28, matching baseline). Since the paste carried no natural phrasing to harvest (bare URLs + a copied thread), I'm skipping the gold-row harvest per the skill's own rule. Let's check what changed in the dedup-probe.md file (the baseline update) and stage everything.

Pushed to `claude/llm-workflows-deterministic-o0asti`. No PR was requested, so I left it there rather than opening one.

I filed the two pasted sources — a Seldon blog post and a Reddit thread the operator copied in full — into the brain, since both argue the same thing: an LLM workflow that made sense to build as one big prompt while its shape was still uncertain should shed stages into ordinary deterministic code (parsers, rules, classifiers) once that uncertainty resolves. Neither source duplicated anything already in the bundle, so both landed as new documents rather than merges.

**What I created**

| Doc | Type | Why this type |
|---|---|---|
| [when-llm-workflows-should-be-deterministic.md](https://github.com/ob6to8/elixir-mind/blob/claude/llm-workflows-deterministic-o0asti/knowledge/SWE/agentic/workflow-decomposition/when-llm-workflows-should-be-deterministic.md) (`em:5a89af`) | reference | captured, distilled external material (Reddit thread + top comments) |
| [ai-bill-as-a-management-discipline.md](https://github.com/ob6to8/elixir-mind/blob/claude/llm-workflows-deterministic-o0asti/knowledge/SWE/agentic/workflow-decomposition/ai-bill-as-a-management-discipline.md) (`em:7d4960`) | reference | captured, summarized external article (too long to copy verbatim, so summarized with `resource` link + quotes) |
| `knowledge/SWE/agentic/workflow-decomposition/` (new subdirectory) | — | no existing directory covered "when should an LLM stage become deterministic code"; created autonomously since it's a subdirectory of the already-established `SWE/agentic/` domain, no ratification needed |

**What I modified**

| File | Change |
|---|---|
| `knowledge/SWE/agentic/index.md` | added the new `workflow-decomposition` subdirectory entry |
| `meta/registry.md` | regenerated after minting the two new ids |

**Actions I have taken**

| Action | Result |
|---|---|
| Fetched the Seldon article | Too long to capture in full — wrote a faithful summary with the source link and verbatim quotes preserved |
| Synonym-expanded dedup search (FinOps, token accounting, model cascade, task decomposition, etc.) | No existing duplicate; found and cross-linked two related-but-distinct docs: `model-cascade` glossary term and the advisor-harness analysis |
| Ran `mix brain.verify`, `mix brain.contract --check`, `mix brain.registry --check`, full test suite (198 tests), route-tag and glossary checks | All pass; only pre-existing, unrelated advisory warnings |
| Ran `mix brain.dedup_probe --update-baseline` | Recall unchanged (8/28 plain) vs. committed baseline — no regression, no gold row harvested (the paste was bare URLs/a raw copy, no natural operator phrasing to harvest per the skill's own rule) |
| Synced branch with `origin/main` before push | Clean merge, no conflicts |
| Committed and pushed to `claude/llm-workflows-deterministic-o0asti` | Pushed; no PR opened (not requested) |

Nothing is awaiting ratification — the new subdirectory was autonomous under the taxonomy-evolution protocol, and no new `type` was needed.
