---
type: plan
title: "A CCA study program: an education/ curriculum overlay, primary-only grounding, and a mechanical /cca-practice"
description: Build a study program for the Claude Certified Architect – Foundations exam as a curriculum overlay over the existing taxonomy rather than a parallel knowledge silo — a new top-level education/ holding the course spine, structured on Anthropic's published five-domain blueprint and its 30 task statements, with an independently-authored question bank whose every item cites the bundle document grounding it and a deliberately mechanical /cca-practice skill backed by mix brain.practice.
status: accepted
provenance: "Claude Code session, 2026-07-27 — operator asked how to intake CCA course resources, whether to create an education/certification heading, and for a /cca-practice drill skill; shape ratified inline"
tags: [meta, plan, education, certification, cca, anthropic, skills, tooling]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive session on CCA certification study"
  why: "operator ratified a new top-level education/ namespace and commissioned the study program; execution is a cold-context handoff to a fresh session, so the decisions are persisted first"
  from: [/meta/threads/2026-07-27-cca-study-program-and-the-primary-source-miss.md]
---

# A CCA study program: curriculum overlay, primary-only grounding, mechanical drill

> **Cold-context handoff.** This plan is written to be executed by a fresh
> session that does not share the originating conversation. Per
> [structured-plan-bodies](/meta/policy/structured-plan-bodies.md), begin by
> re-deriving the current-state tree against `HEAD` and updating the anchors
> section before building.

## Problem

The operator wants to study toward the **Claude Certified Architect –
Foundations** exam (code `CCAR-F`) inside this brain, with "a balance of
synthesis and referencing primary documents", and to drill with a
`/cca-practice` skill presenting one scenario question at a time.

The naive shape — a folder of exam notes — fails this bundle's own rules.
Writing standalone study notes would duplicate what the brain already holds and
file the rest in the wrong place, which
[update-in-place](/meta/policy/update-in-place.md) and
[tree-is-the-taxonomy](/meta/policy/tree-is-the-taxonomy.md) both forbid.

A coverage sweep against the exam's subject matter found the brain **strong on
agent concepts and near-empty on the product surfaces the exam names**:
`agentic-loop/` (~18 docs) and `context-engineering/` (8 docs) against **zero**
documents in `anthropic/claude-code-sdk/`, none on the Claude API, and no MCP
directory at all. Those are different things, and conflating them flatters the
brain. Closing that gap is the largest phase here and has standing value
independent of the exam.

## The authoritative blueprint

**Anthropic publishes a complete 39-page exam guide, publicly.** It is linked
from the [Partner Academy certifications
catalog](https://anthropic-partners.skilljar.com/page/partner-certifications)
and served from a public S3 path — no login required:

> [Claude Certified Architect – Foundations Exam Guide](https://everpath-course-content.s3-accelerate.amazonaws.com/instructor%2F6nizmqk8tpzpfjvt6qmmav7rh%2Fpublic%2F1783542750%2FClaude+Certified+Architect+%E2%80%93+Foundations+Exam+Guide.pdf) — Version 1.0, effective July 2026

Everything below is quoted or derived from that guide and is **primary**.

| Fact | Value |
|---|---|
| Exam code | `CCAR-F` |
| Number of items | 60 |
| Item format | **multiple-choice *and* multiple-response**; each item states how many responses to select |
| Exam structure | **4 scenarios drawn from a bank of 6** |
| Time limit | 120 minutes |
| Passing score | scaled 720 on a 100–1,000 range |
| Fee | $125 USD |
| Validity | 12 months from award |
| Scoring | criterion-referenced; per-domain percent-correct reported but not used for pass/fail |
| Renewal | free non-proctored assessment on Partner Academy; a lapsed credential requires the full exam at full fee |

### The five domains

| # | Domain | Weight |
|---|---|---|
| 1 | Agentic Architecture & Orchestration | 27% |
| 2 | Tool Design & MCP Integration | 18% |
| 3 | Claude Code Configuration & Workflows | 20% |
| 4 | Prompt Engineering & Structured Output | 20% |
| 5 | Context Management & Reliability | 15% |

The guide expands these into **30 task statements**, each with explicit
*Knowledge of* and *Skills in* bullets — "Exam items are written against these
objectives." Those task statements, not the domain headings, are the real unit
of study and the natural key for question coverage.

### The six scenarios

Every item sits inside one of six production contexts: customer support
resolution agent; code generation with Claude Code; multi-agent research system;
developer productivity tooling; Claude Code in CI/CD; structured data
extraction. Each names its primary domains. Practice questions should be written
*into* these contexts rather than as free-floating trivia.

## The NDA constraint — binding on the question bank

Section 14 of the guide:

> "By accepting, you agree that all exam content, including questions, answer
> options, and scenarios, is the confidential and proprietary property of
> Anthropic, and that you will not disclose, reproduce, or distribute any
> portion of it."

Three consequences, all binding on this plan:

1. **The bank is authored from the published objectives, never reconstructed
   from real items.** The 30 task statements and six scenario descriptions are
   public and are the legitimate source; a recalled exam item is not.
2. **Third-party question banks are not ingestible.** A commercial "400-question"
   bank may itself be a reconstruction of real items. This is a second,
   independent reason to keep the prep sites quarantined in the survey tier —
   licence and NDA risk on top of the epistemic reason.
3. **The bank stays unpublished.** `education/**/practice/questions/` is excluded
   from the Pages build. This was already recommended on scraping grounds; the
   NDA makes it settled.

Anyone who sits the exam and then writes questions must be scrupulous about the
line: objectives-derived content is fine, recall is not.

## Decisions ratified in-session

1. **`education/` is a new top-level directory.** Ratified by the operator (a
   shape change under
   [taxonomy-evolution-protocol](/meta/policy/taxonomy-evolution-protocol.md)).
   `knowledge/` is *what the brain knows*; a curriculum is a *sequenced path
   through* it plus assessment machinery, and the namespace generalizes to
   future certifications and book studies.
2. **Curated question bank, not generate-on-demand** — auditable, improvable,
   linkable.
3. **Two-stage `E) Explain`.** First invocation briefs the concepts and
   re-offers the options; a second reveals the answer with full rationale.
4. **Answering happens in chat text.** Never `AskUserQuestion` — per
   [session-capture](/meta/policy/session-capture.md), dialog elements never
   enter the delivered message stream, so `/capture` would render a study
   session blank.
5. **Primary sources only.** Third-party prep sites may be surveyed, never cited
   as provenance for bundle knowledge.
6. **`/cca-practice` is mechanical.** Select, present, grade, log. The *why* of
   the program lives in `education/`, mirroring the contract's split between
   terse policies and cross-linked explanatory docs.

## The shape: two layers, deliberately separated

**Layer 1 — subject knowledge stays in the existing taxonomy**, under
already-established top-level domains (autonomous, no ratification needed):
`knowledge/SWE/agentic/mcp/`, `anthropic/claude-api/`,
`anthropic/claude-code-sdk/`, `anthropic/claude-code/`, and a new
`knowledge/SWE/prompt-engineering/`.

**Layer 2 — the course spine maps and sequences, never restates.** A per-domain
guide holds the domain's task statements, an ordered reading path of
bundle-absolute links into Layer 1, and an explicit gap list.

> **The guardrail, stated as a test:** if a domain guide starts *explaining what
> MCP is*, it has failed — that belongs in `knowledge/SWE/agentic/mcp/`. A
> domain guide stripped of its outbound links should lose almost all its
> content.

## Resource intake: the provenance quarantine

| Source class | Destination |
|---|---|
| Anthropic primary — the exam guide, Claude Code docs, Agent SDK docs, Claude API docs, MCP spec, Partner Academy | `/intake` → filed `reference` / `source` documents |
| Third-party prep sites | `/bookmarks` → `survey/bookmarks.md`, never cited |

Survey rows are non-bundle and carry **no `em:` id**. Since `verified_by` targets
must be ids that resolve, a surveyed prep site is *structurally incapable* of
grounding a claim — enforced by the verifier, not by memory.

**Sampling weights are now the published ones** (27/18/20/20/15), biased by
measured weakness from the operator's attempt log.

## Current state → desired state

```
CURRENT
  knowledge/SWE/agentic/{agentic-loop,context-engineering,...}   # strong on agent CONCEPTS
  mcp/, claude-api/, claude-code-sdk/                            # first pass filed 2026-07-27
  (no curriculum layer)                                          # no sequencing, no assessment

DESIRED
  education/                        # curriculum overlay — sequences, never restates
    └─ domain guide ──────▶ knowledge/**           (links out, Layer 1)
    └─ question ──────────▶ task statement + grounding doc em: ids
    └─ attempt log ───────▶ weakness-biased sampling over published weights
```

## File-tree diff

```
+ education/                                                  # NEW top-level (ratified)
+   index.md
+   certifications/
+     index.md
+     claude-certified-architect/
+       index.md                                              # the course entry point
+       exam-blueprint.md                                     # NEW  from the official guide
+       study-plan.md                                         # NEW  ordered path + gap list
+       domains/
+         index.md
+         agentic-architecture-and-orchestration.md           # NEW  27% — 7 task statements
+         tool-design-and-mcp-integration.md                  # NEW  18% — 5 task statements
+         claude-code-configuration-and-workflows.md          # NEW  20% — 6 task statements
+         prompt-engineering-and-structured-output.md         # NEW  20% — 6 task statements
+         context-management-and-reliability.md               # NEW  15% — 6 task statements
+       scenarios.md                                          # NEW  the six production contexts
+       practice/                                             # NON-BUNDLE (no em: ids)
+         index.md
+         attempts.md                                         # NEW  append-only attempt record
+         questions/<domain>/q-NNNN.md                        # NEW  one question per file
+
+ knowledge/SWE/prompt-engineering/index.md                   # NEW  autonomous subdir
+
+ .claude/skills/cca-practice/SKILL.md                        # NEW  mechanical
+ lib/elixir_mind/practice.ex                                 # NEW  bank load, select, log I/O
+ lib/mix/tasks/brain.practice.ex                             # NEW  CLI surface
+ test/elixir_mind/practice_test.exs                          # NEW
+
~ index.md                                                    # list education/ as a top-level domain
~ meta/policy/skills-registry.md                              # register /cca-practice → recompile
~ lib/elixir_mind/verifier.ex                                 # exempt education/**/practice/
~ config/config.exs                                           # exclude practice/questions/ from site
```

`practice/attempts.md` is deliberately **not** `log.md`:
[reserved-filenames](/meta/policy/reserved-filenames.md) bans that name.

## Question record shape

One question per file, reusing `ElixirMind.Frontmatter` — no new parser:

```
---
domain: tool-design-and-mcp-integration
task_statement: "2.2"           # ties the item to a published objective
scenario: 1                     # one of the six published contexts
format: multi-select            # single | multi-select — the exam uses both
difficulty: 2
answer: [B, D]
grounds: [em:3b0352]            # bundle docs supporting the correct answer
---

## Scenario
## Options
## Explain     <- stage-1 concept briefing, no answer revealed
## Rationale   <- stage-2, why each option does or does not hold
```

Two fields earn their place. **`grounds`** makes the explanation traceable to
filed knowledge rather than model recall, and inverts into a coverage
instrument: an ungroundable question is a gap in the brain, routing back to
`/intake`. **`task_statement`** gives coverage a denominator — 30 objectives,
so "which objectives have no question yet" is a straight query.

`format: multi-select` exists because the guide says items are "multiple-choice
and multiple-response". A bank of only single-answer items would drill the wrong
shape.

## Call/flow trees

```
PRODUCTION — /cca-practice (mechanical)
  parse arg                     → skill
  mix brain.practice --domain D → Practice.select/3
      load bank                     Practice.load_questions/1
      read attempts                 Practice.accuracy_by_domain/1
      sample                        published weights × weakness bias × recency filter
  present stem + options + E)Explain → skill  (chat text, never AskUserQuestion)
  operator answers in chat       → skill
    option(s) → grade, show Rationale, link grounds via mix brain.url
    E         → stage 1: show Explain, re-offer
                E again → stage 2: reveal answer + Rationale
  mix brain.practice --record   → Practice.append_attempt/2

TEST
  Practice.select/3 seeded with an explicit :rand seed  (determinism)
  bank + attempts read from a fixture dir, never the live tree
  the mix task boundary exercised for CLI parsing only
```

## Signatures

```elixir
@spec load_questions(root :: Path.t()) :: {:ok, [Question.t()]} | {:error, term()}

@spec select(
        questions :: [Question.t()],
        attempts :: [Attempt.t()],
        opts :: keyword()
      ) :: {:ok, Question.t()} | {:error, :empty_bank}

@spec accuracy_by_domain(attempts :: [Attempt.t()]) ::
        %{optional(String.t()) => float()}

@spec coverage_by_task_statement(questions :: [Question.t()]) ::
        %{optional(String.t()) => non_neg_integer()}

@spec append_attempt(log :: Path.t(), Attempt.t()) :: :ok | {:error, term()}
```

## Boundary decisions

- **`ElixirMind.Practice`** owns selection, log parsing, and coverage. Pure
  functions over loaded data; one I/O seam. Deterministic under an injected seed.
- **`mix brain.practice`** owns the CLI only — no selection logic.
- **`/cca-practice`** owns the dialogue: presentation, two-stage explain,
  grading. No pedagogy, no domain content (decision 6).
- **`education/`** owns the *why*: domain framing, reading paths, gap lists.
- **The verifier** owns namespace rules — `education/**/practice/` exempt from
  `em:` ids and `attribution`.
- **The site build** owns exposure — `practice/questions/` excluded (NDA).

## Build order

Phase 2 is complete; **phase 1 had a first pass only and remains the largest
open phase.** The rest is the fresh-context handoff.

1. **Fill the domain gaps.** `/intake` Anthropic primary documentation.
   Prerequisite for `grounds` — a question can only be filed once something
   exists to ground it against.

   *First pass filed (2026-07-27):*

   | Area | Filed | `em:` |
   |---|---|---|
   | MCP | architecture; tools primitive | `121acc`, `3b0352` |
   | Agent SDK | SDK overview | `b4a91a` |
   | Claude API | tool use | `038169` |
   | Claude Code | settings and permissions | `53f32a` |

   *Still unfiled:*

   - **The exam guide itself** — file as a `source` capture; it is the single
     most load-bearing primary document for this program.
   - **MCP:** resources and prompts primitives; transports; lifecycle;
     authorization; sampling and elicitation.
   - **Agent SDK:** hooks; permission callbacks; subagent/`AgentDefinition`
     configuration; session forking; custom tools.
   - **Claude API:** the Messages API proper; prompt caching; extended thinking;
     the Message Batches API; Anthropic-schema tools.
   - **Claude Code:** slash commands; skills and `.claude/rules/`; plan mode;
     memory resolution; MCP server config; CI/CD integration.
   - **Prompt engineering:** unrepresented in the brain; 20% of the exam.
     New `knowledge/SWE/prompt-engineering/`.

2. **Survey the prep landscape.** ✅ Done 2026-07-27 — four third-party sites in
   `survey/bookmarks.md`.
3. **Stand up `education/`.** Namespace, indexes, root-index entry, verifier
   exemptions.
4. **Write the blueprint, scenarios, and five domain guides** from the exam
   guide's task statements, with reading paths over phase 1's output.
5. **Build the tooling** — `ElixirMind.Practice`, `mix brain.practice`, tests,
   and the `grounds`/`task_statement` resolution checks.
6. **Write `/cca-practice`.** Thin and mechanical. Register in the
   skills-registry policy and recompile the contract.
7. **Seed the bank,** one question per task statement as the first milestone —
   30 items covering every published objective, before depth anywhere.

## Anchors

- `ElixirMind.Frontmatter` (`lib/elixir_mind/frontmatter.ex`) — reused for
  question files. Note the pending
  [parser rewrite](/meta/plans/frontmatter-parser-profile-rewrite.md): question
  frontmatter must stay inside the current profile (flat keys, inline lists).
- `ElixirMind.Verifier` (`lib/elixir_mind/verifier.ex`) — exemptions follow the
  `inbox/` and `survey/` precedent.
- `ElixirMind.SiteConfig` (`lib/elixir_mind/site_config.ex`) — the exclusion list.
- `mix brain.url` — response-side links, per
  [response-resource-links](/meta/policy/response-resource-links.md).
- [`/todo` SKILL.md](/.claude/skills/todo/SKILL.md) — the dispatch-on-subcommand
  shape `/cca-practice` should copy.

## Open questions

1. **Can an individual certify, or is Partner Network membership required?**
   Anthropic states "Any organization that is bringing Claude to market is
   eligible to join the Claude Partner Network"; the Academy catalog shows
   per-exam pricing ($99 Associate, $125 Developer, $125 Architect Foundations,
   $175 Architect Professional) and registration runs Academy → Pearson VUE. No
   primary source states whether an unaffiliated individual may register. This
   needs a human — apply, or ask Anthropic's partner team.
2. **Do the other three exam guides warrant filing?** All four are public on the
   same S3 path. The Architect – Professional guide in particular describes the
   next credential up. Recommend filing at least its blueprint.
3. **Question authoring cadence.** 30 task statements is the coverage
   denominator; whether to author breadth-first (one per objective) or
   depth-first per domain is an execution choice. Recommend breadth-first —
   it surfaces grounding gaps fastest.

## Deferred

**A source-inventory spike.** This plan's blueprint premise was wrong for one
revision because a search scoped to `anthropic.com` and `claude.com` never
reached the Partner Academy tenant. Anthropic's primary surfaces span at least
six hosts — `anthropic.com`, `claude.com`, `platform.claude.com`,
`code.claude.com`, `support.claude.com`, and
`anthropic-partners.skilljar.com` — plus `modelcontextprotocol.io`. Filing an
`analysis` that enumerates them and what each authoritatively covers would turn
future primary-source intake into a checklist rather than a search gamble. Not
required to execute this plan; recommended before the next research-heavy
program.
