---
id: em:d146ff
type: reference
title: "Model-Based Agentic Software Engineering (MAGE) — framework overview"
description: James C. Davis's framework for governing AI-agent fleets in software delivery, built from a 19-week case study, arguing the bottleneck agentic development hits isn't writing code anymore but governing the conditions under which fast code can be trusted — a catalogue of constraint- and sensor-based mechanisms grown from real failures rather than hypothetical ones.
resource: https://davisjam.github.io/model-based-agentic-software-engineering/
provenance: "James C. Davis (Purdue University), \"Model-Based Agentic Software Engineering\" book/site and its companion GitHub repository, fetched 2026-08-05"
tags: [agent-governance, mage, model-driven-engineering, agentic-loop, vibe-coding, engineering-methodology, claude-skills]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# Model-Based Agentic Software Engineering (MAGE)

James C. Davis (Purdue University) frames MAGE as a response to a shift in
where agentic software delivery's bottleneck sits: "the hard part stops being
writing code and becomes governing the conditions under which fast code can
be trusted." Code generation got cheap; the scaling limit is now *churn* —
agents confidently undoing or contradicting earlier work once it exceeds
their context window.

MAGE positions itself between two failure modes: **vibe coding** (fast but
chaotic, no governing structure) and **oversight-centric development**
(rigorous but bottlenecked on a human reviewing everything). Its answer is
"velocity + guardrails grown from failure" — mechanisms earn a place in the
catalogue because a real failure motivated them, not because they sounded
prudent in the abstract.

## The two theses

- **Modeling thesis.** "Documentation, taken to its limit, is a structured
  model" — the same claim this bundle already holds at chapter granularity in
  [Models and the semantic gap](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md)
  (MAGE ch. 2.2): a typed model is the compact, checkable binding layer
  between ambiguous prose and dense code, valid only when authored
  independently of the code rather than derived from it.
- **Alignment thesis.** "Hold intent with a mechanism: prevent first, sense
  the rest" — governance mechanisms split into constraint-based ones that
  prevent a failure class outright, and sensor-based ones that detect it
  after the fact when prevention isn't cheap enough.

## Structure

The framework's "six big ideas" run: the problem (churn is the scaling
limit) → the stance (a governance-centric environment) → thesis 1 (modeling)
→ thesis 2 (alignment) → the practice (convert recurring failures into
controls) → the seat (agents take the developer role; engineers author
intent and govern the output).

The companion GitHub repository (`davisjam/model-based-agentic-software-engineering`)
holds the same content as an interactive web book plus a downloadable PDF, a
**catalogue of governance mechanisms** derived from Davis's 19-week case
study, three Claude skills (self-governance, self-operations,
self-communicate) for adopting the mechanisms directly, a quick-start guide,
and the academic paper "Cheap Code, Costly Judgment." The recommended
starting point is a small number of high-leverage mechanisms, expanded
incrementally as real failures surface — not the whole catalogue at once.

# Citations

- Source (book/site): <https://davisjam.github.io/model-based-agentic-software-engineering/>
- Source (repository): <https://github.com/davisjam/model-based-agentic-software-engineering>

# See also

- [Models and the semantic gap (MAGE, ch. 2.2)](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md) — this bundle's existing chapter-level capture of the modeling thesis

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:d146ff">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-05-reading-list-batch-intake (2026-08-05)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:d146ff`]**  (co-feeds: `em:be781f em:3d9101 em:e4d9cf em:86f6df`)

Filed the batch. Everything's committed and pushed to `claude/research-intake-links-nhi01p`; no PR opened, since that's `/create-pull-request`'s job, not `/intake`'s.

**What happened:** Of your 21 links, 4 were exact matches for documents already in the brain (Naur's paper and the Goedecke essay reading it were both already captured together; the Seldon and Dzombak posts were already filed word-for-word) — those needed no action. Three more links weren't new *documents* so much as new *angles* on things already filed — Simon Willison's take on stateless MCP, a Hacker News discussion of an existing essay, and the wider MAGE book/repo around a chapter already captured — so those got merged into the existing docs instead of creating near-duplicates. The `litestream.io` link turned out to already be sitting in the bookmark tier from an earlier session, so this intake promoted it to a filed reference. The rest — twelve documents — were genuinely new and got filed across security, several `agentic/` subdirectories, `dev-tools`, `software-design`, and one new subdirectory (`knowledge/SWE/performance/`, created autonomously since it sits under the already-established `SWE` domain). One fetch (the Reddit Jido thread) was blocked by the host; I covered the same material from the `jido.run` blog post instead and left the Reddit URL as an uncaptured citation.

---

**[`em:d146ff`]**  (co-feeds: `em:b2676a em:cdd51c em:79c1a1 em:45adfd em:f9f0d5 em:41ab78 em:86f6df em:d27de7 em:563b18 em:fab63b em:134093 knowledge/SWE/performance/index.md`)

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
