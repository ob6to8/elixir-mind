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
