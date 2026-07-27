---
type: plan
title: "A CCA study program: an education/ curriculum overlay, primary-only grounding, and a mechanical /cca-practice"
description: Build a study program for the Claude Certified Architect exam as a curriculum overlay over the existing taxonomy rather than a parallel knowledge silo — a new top-level education/ holding the course spine, structured on Anthropic's own four-pillar scope statement, with a curated question bank whose every item cites the bundle document grounding it and a deliberately mechanical /cca-practice skill backed by mix brain.practice.
status: accepted
provenance: "Claude Code session, 2026-07-27 — operator asked how to intake CCA course resources, whether to create an education/certification heading, and for a /cca-practice drill skill; shape ratified inline"
tags: [meta, plan, education, certification, cca, anthropic, skills, tooling]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive session on CCA certification study"
  why: "operator ratified a new top-level education/ namespace and commissioned the study program; execution is a cold-context handoff to a fresh session, so the decisions are persisted first"
---

# A CCA study program: curriculum overlay, primary-only grounding, mechanical drill

> **Cold-context handoff.** This plan is written to be executed by a fresh
> session that does not share the originating conversation. Per
> [structured-plan-bodies](/meta/policy/structured-plan-bodies.md), begin by
> re-deriving the current-state tree against `HEAD` and updating the anchors
> section before building.

## Problem

The [Claude Certified Architect](https://www.pearsonvue.com/us/en/anthropic.html)
(CCA) exam is Anthropic's first technical certification. The operator wants to
study toward it inside this brain, with "a balance of synthesis and referencing
primary documents", and to drill with a `/cca-practice` skill presenting one
scenario question at a time.

The naive shape — a folder of exam notes — fails this bundle's own rules, and
the naive *structure* fails a sharper one. Most published CCA blueprints
(five weighted domains, a scaled pass mark, a question count) come from
third-party prep sites, not from Anthropic. **The operator's standing constraint
is that no third-party number enters the bundle.** Anthropic's own public
statement of scope is a single sentence:

> "tests foundational knowledge across Claude Code, the Claude Agent SDK, the
> Claude API, and Model Context Protocol (MCP)"
>
> — [Anthropic Academy, CCA Foundations](https://anthropic-partners.skilljar.com/claude-certified-architect-foundations-certification)

So the course is structured on **those four pillars**, and on nothing else,
until the official **Exam guide PDF** (linked from that page, behind Claude
Partner Network access) is obtained.

A coverage sweep re-keyed to those four pillars shows the brain is much thinner
than a concept-level reading suggests:

| Pillar | Filed knowledge today | Verdict |
|---|---|---|
| Claude Code | 8 docs under `anthropic/claude-code/`, mostly cloud-environment sources; ambient mentions repo-wide | thin on configuration specifics |
| Claude Agent SDK | **0 docs** in `anthropic/claude-code-sdk/`; 11 passing mentions | near-empty |
| Claude API | **~0** — no filed knowledge of the API surface | empty |
| MCP | no dedicated directory; 25 incidental mentions, 6 using the full name | near-empty |

The brain is strong on agentic **concepts** — `agentic-loop/` (~18 docs),
`context-engineering/` (8 docs), `frameworks/`, `multi-model/` — and near-empty
on the four **product surfaces** the exam names. Those are different things, and
conflating them is what makes a concept-level coverage estimate flatter the
brain. Filling the product-surface gap is the largest phase of this plan and has
standalone value even if the exam never happens.

## Decisions ratified in-session

1. **`education/` is a new top-level directory.** Ratified by the operator (a
   shape change under
   [taxonomy-evolution-protocol](/meta/policy/taxonomy-evolution-protocol.md)).
   Rationale: `knowledge/` is *what the brain knows*; a curriculum is a
   *sequenced path through* what it knows plus assessment machinery, and the
   namespace generalizes to future certifications and book studies.
2. **Curated question bank, not generate-on-demand.** Questions are authored and
   filed so they are auditable, improvable, and linkable.
3. **Two-stage `E) Explain`.** First invocation briefs the concepts and
   re-offers A–D; a second reveals the answer with full rationale. The retrieval
   attempt is where the learning is.
4. **Answering happens in chat text.** Never `AskUserQuestion` — per
   [session-capture](/meta/policy/session-capture.md), dialog elements never
   enter the delivered message stream, so `/capture` would render a study
   session blank.
5. **Primary sources only, and no third-party numbers anywhere.** Third-party
   prep sites may be *surveyed*, never cited. No weighting, pass mark, duration,
   question count, or domain taxonomy enters the bundle or the tooling config
   unless Anthropic states it.
6. **`/cca-practice` is mechanical.** The skill selects, presents, grades, and
   logs. It is not the source of truth for the *why* of the program — that lives
   in `education/`. This mirrors the contract's split between terse policies and
   cross-linked explanatory docs.

## The shape: two layers, deliberately separated

**Layer 1 — subject knowledge stays in the existing taxonomy.** The pillar gaps
get proper homes under already-established top-level domains, so they are created
autonomously without further ratification:

- `knowledge/SWE/agentic/anthropic/claude-code-sdk/` — exists, empty; fill it
- `knowledge/SWE/agentic/anthropic/claude-api/` — new
- `knowledge/SWE/agentic/mcp/` — new
- `knowledge/SWE/agentic/anthropic/claude-code/` — exists, thin on configuration

**Layer 2 — the course spine maps and sequences, never restates.** A per-pillar
study guide holds: what Anthropic says the pillar covers, an ordered reading path
of bundle-absolute links into Layer 1, and an explicit gap list.

> **The guardrail, stated as a test:** if a pillar guide starts *explaining what
> MCP is*, it has failed — that belongs in `knowledge/SWE/agentic/mcp/`. A pillar
> guide stripped of its outbound links should lose almost all its content.

The payoff: the course stays thin and current, and every hour of study is also a
permanent improvement to the brain.

## Resource intake: the provenance quarantine

Decision 5 needs *structural* enforcement, not discipline. The survey tier
supplies one.

| Source class | Destination | Why |
|---|---|---|
| Anthropic primary — Claude Code docs, Agent SDK docs, Claude API docs, MCP spec, certification and partner-network posts, Pearson VUE exam page, the official Exam guide PDF | `/intake` → filed `reference` / `source` documents under `knowledge/` | authoritative; eligible to ground claims and questions |
| Third-party prep sites — claudecertifiedarchitects.com, certdemand, claudecertificationguide, Udemy listings | `/bookmarks` → `survey/bookmarks.md` | signal about the exam's *shape*, never authority |

Survey-tier rows are **non-bundle: they carry no `em:` id**. Since `verified_by`
targets must be stable ids that resolve, a surveyed prep site is *structurally
incapable* of grounding a claim. The quarantine is enforced by the existing
verifier, not by an agent remembering the rule.

**The blueprint doc states primary facts only** — the four credentials, proctored
delivery via Pearson Professional Assessments, Credly badging, the retake ladder
and 12-month term, partner-network eligibility, and Anthropic's four-pillar scope
sentence quoted verbatim. It records the official Exam guide PDF as the
**outstanding grounding target**, with acquiring Partner Network access as the
prerequisite. It states no weighting, no pass mark, no duration, and no question
count.

**Sampling carries no imported numbers either.** With no published weighting, the
practice tool samples **uniformly across the four pillars, biased toward measured
weakness** derived from the operator's own attempt log. That is a property of the
operator's performance, not a claim about the exam — so it stays inside the
constraint. If Anthropic later publishes weightings, they become a config value
and nothing needs retracting.

## Current state → desired state

```
CURRENT
  knowledge/SWE/agentic/{agentic-loop,context-engineering,...}   # strong on agent CONCEPTS
  anthropic/{claude-code-sdk,claude-api,mcp}                     # three of four PILLARS near-empty
  (no curriculum layer)                                          # no sequencing, no assessment

DESIRED
  education/                        # curriculum overlay — sequences, never restates
    └─ pillar guide ──────▶ knowledge/**            (links out, Layer 1)
    └─ question ──────────▶ grounding doc em: ids   (every item cites its source)
    └─ attempt log ───────▶ weakness-biased sampling
  knowledge/SWE/agentic/anthropic/claude-code-sdk/   # filled from Anthropic primary
  knowledge/SWE/agentic/anthropic/claude-api/        # filled from Anthropic primary
  knowledge/SWE/agentic/mcp/                         # filled from Anthropic primary
```

## File-tree diff

```
+ education/                                                  # NEW top-level (ratified)
+   index.md                                                  # namespace intro; bundle + non-bundle split
+   certifications/
+     index.md
+     claude-certified-architect/
+       index.md                                              # the course entry point
+       exam-blueprint.md                                     # NEW  primary-sourced facts ONLY
+       study-plan.md                                         # NEW  the spine: ordered path + gap list
+       pillars/                                              # Anthropic's four named pillars
+         index.md
+         claude-code.md                                      # NEW  scope + reading path + gaps
+         claude-agent-sdk.md                                 # NEW      ""
+         claude-api.md                                       # NEW      ""
+         model-context-protocol.md                           # NEW      ""
+       practice/                                             # NON-BUNDLE (no em: ids)
+         index.md
+         attempts.md                                         # NEW  append-only attempt record
+         questions/<pillar>/q-NNNN.md                        # NEW  one question per file
+
+ knowledge/SWE/agentic/mcp/index.md                          # NEW  autonomous subdir
+ knowledge/SWE/agentic/anthropic/claude-api/index.md         # NEW  autonomous subdir
+
+ .claude/skills/cca-practice/SKILL.md                        # NEW  mechanical: select/present/grade/log
+ lib/elixir_mind/practice.ex                                 # NEW  bank load, weighted select, log I/O
+ lib/mix/tasks/brain.practice.ex                             # NEW  CLI surface
+ test/elixir_mind/practice_test.exs                          # NEW  selection + log parsing
+
~ index.md                                                    # list education/ as a top-level domain
~ meta/policy/skills-registry.md                              # register /cca-practice → recompile contract
~ lib/elixir_mind/verifier.ex                                 # exempt education/**/practice/ from id+attribution
~ config/config.exs                                           # exclude practice/questions/ from the site build
```

`practice/attempts.md` is deliberately **not** named `log.md`:
[reserved-filenames](/meta/policy/reserved-filenames.md) bans that name bundle-wide.

## Question record shape

One question per file, reusing the existing `ElixirMind.Frontmatter` parser — no
new parser, clean diffs, trivially appendable:

```
---
pillar: model-context-protocol
difficulty: 2
answer: C
grounds: [em:xxxxxx, em:yyyyyy]     # bundle docs supporting the correct answer
---

## Scenario
<production-context stem>

## Options
A. …   B. …   C. …   D. …

## Explain
<stage-1 concept briefing — no answer revealed>

## Rationale
<stage-2 — why C, and why each distractor fails>
```

**`grounds` is the load-bearing field.** It makes the explanation traceable to
filed knowledge rather than model recall, and it inverts into a coverage
instrument: a question that cannot be grounded is a gap in the brain, routing
straight back to `/intake`. A build-time check that every `grounds` id resolves
is the natural gate.

## Call/flow trees

```
PRODUCTION — /cca-practice (mechanical)
  parse arg                     → skill
  mix brain.practice --pillar P → Practice.select/3
      load bank                     Practice.load_questions/1
      read attempts                 Practice.accuracy_by_pillar/1
      sample                        uniform over pillars × weakness bias × recency filter
  present stem + A–D + E)Explain → skill  (chat text, never AskUserQuestion)
  operator answers in chat       → skill
    A–D  → grade, show Rationale, link grounds via mix brain.url
    E    → stage 1: show Explain, re-offer A–D
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

@spec accuracy_by_pillar(attempts :: [Attempt.t()]) ::
        %{optional(String.t()) => float()}

@spec append_attempt(log :: Path.t(), Attempt.t()) :: :ok | {:error, term()}
```

## Boundary decisions

- **`ElixirMind.Practice` owns selection and log parsing.** Pure functions over
  loaded data; a single I/O seam for reading the bank and appending an attempt.
  Sampling is deterministic under an injected seed.
- **`mix brain.practice` owns the CLI only.** Argument parsing and printing; no
  selection logic.
- **`/cca-practice` owns the dialogue.** Presentation, the two-stage explain, and
  grading conversation. It carries **no pedagogy and no pillar content** —
  decision 6.
- **`education/` owns the *why*.** Pillar framing, reading paths, rationale, gaps.
- **The verifier owns the namespace rules.** `education/**/practice/` is exempt
  from `em:` ids and `attribution`; the rest of `education/` is a normal bundle
  namespace.
- **The site build owns exposure.** `practice/questions/` is excluded from
  publication (open question 1).

## Build order

Phase 2 is complete; **phase 1 had a first pass only and is still the largest
open phase.** The rest is the fresh-context handoff.

1. **Fill the pillar gaps.** `/intake` Anthropic primary documentation across the
   four pillars. Independently valuable, and a prerequisite for `grounds` — a
   question can only be filed once something exists to ground it against.

   *First pass filed (2026-07-27), one document per pillar:*

   | Pillar | Filed | `em:` |
   |---|---|---|
   | MCP | architecture; tools primitive | `121acc`, `3b0352` |
   | Agent SDK | SDK overview | `b4a91a` |
   | Claude API | tool use | `038169` |
   | Claude Code | settings and permissions | `53f32a` |

   *Still unfiled — the remainder of phase 1:*

   - **MCP:** resources and prompts primitives; transports (stdio, streamable
     HTTP); lifecycle and initialization; authorization; sampling and elicitation.
   - **Agent SDK:** hooks in depth; the permission callback surface; subagent
     configuration; session forking; custom tools via in-process MCP servers.
   - **Claude API:** the Messages API proper (blocks, streaming, stop reasons);
     prompt caching; extended thinking; batch; Anthropic-schema tools
     (memory, bash, text editor); the `tool_search` surface.
   - **Claude Code:** slash commands; hooks; memory and `CLAUDE.md` resolution;
     MCP server configuration; skills and plugins.
   - **Prompt engineering:** unrepresented in the brain and not one of the four
     pillars by name, but load-bearing across all of them — Anthropic's prompt
     engineering guide is the primary source, filing into a new
     `knowledge/SWE/prompt-engineering/` (autonomous subdir).

2. **Survey the prep landscape.** ✅ Done 2026-07-27 — four third-party CCA sites
   surveyed into `survey/bookmarks.md`, blueprint figures explicitly marked as
   absent from every Anthropic and Pearson source.
3. **Stand up `education/`.** Namespace, indexes, root-index entry, verifier
   exemptions. Everything after this depends on it.
4. **Write the blueprint and the four pillar guides.** Primary facts only;
   reading paths over phase 1's output; explicit gap lists.
5. **Build the tooling.** `ElixirMind.Practice`, `mix brain.practice`, tests, and
   the `grounds`-resolution check.
6. **Write `/cca-practice`.** Thin and mechanical. Register in the
   skills-registry policy and recompile the contract.
7. **Seed the bank,** starting with whichever pillar phase 1 grounded most
   thoroughly — this validates the `grounds` mechanism before the bank scales.

## Anchors

- `ElixirMind.Frontmatter` (`lib/elixir_mind/frontmatter.ex`) — reused verbatim
  for question files; no new parser. Note the pending
  [parser rewrite](/meta/plans/frontmatter-parser-profile-rewrite.md) — question
  frontmatter must stay inside the current profile (flat keys, inline lists).
- `ElixirMind.Verifier` (`lib/elixir_mind/verifier.ex`) — namespace exemptions
  follow the existing `inbox/` and `survey/` precedent.
- `ElixirMind.SiteConfig` (`lib/elixir_mind/site_config.ex`) — the exclusion list.
- `mix brain.url` — every response-side link to a bundle doc, per
  [response-resource-links](/meta/policy/response-resource-links.md).
- [`/bookmarks`](/.claude/skills/bookmarks/SKILL.md) and the
  [survey-tier plan](/meta/plans/bookmarks-survey-tier.md) — the pattern the
  provenance quarantine reuses.
- [`/todo` SKILL.md](/.claude/skills/todo/SKILL.md) — the dispatch-on-subcommand
  shape `/cca-practice` should copy.

## Open questions

1. **Should the question bank be published to the Pages site?** The site is
   public. Recommend **excluding `practice/questions/`** from the build — a
   public bank invites scraping, and questions modeled on a live commercial
   certification are better kept unpublished. The course spine still publishes.
2. **Acquiring the official Exam guide PDF — and with it, exam access.** This is
   the plan's largest external dependency, and it is an operator decision, not an
   agent one.

   *What Anthropic states:* "Any organization that is bringing Claude to market
   is eligible to join the Claude Partner Network"
   ([announcement](https://www.anthropic.com/news/claude-partner-network)).
   Membership is free, applications are open at
   [claude.com/partners](https://claude.com/partners), and members get the
   Partner Portal, Anthropic Academy training, and certification access. The
   [certification post](https://claude.com/blog/four-role-based-claude-certifications)
   states exams "are currently available to Claude Partner Network members",
   with prep courses free for partners; Pearson VUE's
   [Anthropic page](https://www.pearsonvue.com/us/en/anthropic.html) likewise
   says the exams are "open to organizations in the Claude Partner Network" and
   that registration runs through Anthropic Partner Academy.

   *What is not stated anywhere primary:* whether an **individual practitioner
   or sole proprietor** can join or sit the exam without an organization. The
   eligibility sentence is written in terms of organizations throughout, and
   `claude.com/partners` publishes no tier table, eligibility criteria, or
   individual path. The widely-repeated **$125 individual price is third-party
   only** and appears in no Anthropic or Pearson source — it must not be treated
   as fact.

   *The consequence for this plan:* the Exam guide PDF is the only primary
   blueprint, and it sits behind that gate. Until it is obtained the course
   stands on the four-pillar sentence alone — which is sufficient for phases 1
   and 3–7, since those build knowledge and machinery, not exam-shaped
   guesswork. The blueprint doc stays deliberately thin rather than being
   padded with third-party structure.

   *Resolving it takes a human:* submit the partner application, or contact
   Anthropic's partner team, and ask directly whether an individual may certify.
   Both channels are outside what an agent should do unprompted.
3. **One file per question, or one file per pillar?** Recommend per-question
   (free parsing, clean diffs) despite the file count; per-pillar would need a
   bespoke record parser.
4. **Does the bank need a `sources` field distinct from `grounds`?** `grounds`
   points at bundle documents. If a question is written from an Anthropic doc not
   yet filed, that is a signal to file it rather than to add a second field.
   Recommend no second field — keep the forcing function.
5. **Renewal cadence.** The certification carries a 12-month term. Whether the
   spine tracks renewal, and whether questions expire when the underlying
   Anthropic docs change, is deferred until after the first sitting.
