---
type: reference
title: 2026-07-27-cca-study-program-and-the-primary-source-miss
description: Designed a CCA study program as an education/ curriculum overlay and filled the pillar knowledge gaps, then discovered mid-session that Anthropic publishes a complete public exam guide the agent had reported as nonexistent — producing a source-surface analysis, a negative-findings policy, an /intake amendment, and a proposed eval that could falsify all three.
provenance: "Claude Code session, 2026-07-27; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, cca, certification, education, evals, research-methodology, primary-sources]
timestamp: 2026-07-27
session: https://claude.ai/code/session_01Ri7NUzzCx6Pb7Jb2vrmU2a
---

# 2026-07-27-cca-study-program-and-the-primary-source-miss

## Where this landed

The session began as a status question about Anthropic's Claude Certified
Architect program and became, in its second half, a post-mortem on the agent's
own research method.

The first half designed a study program: a ratified new top-level `education/`
namespace holding a *curriculum overlay* — sequencing and mapping into the
existing taxonomy rather than duplicating it — with a curated question bank
whose every item cites the bundle document grounding it, and a deliberately
mechanical `/cca-practice` skill. Phase 1 filled genuine gaps: MCP, the Agent
SDK, the Claude API, and Claude Code configuration were near-empty in a brain
otherwise strong on agent *concepts*.

The turn came when the operator asked whether the Partner Academy was an
official Anthropic site. It was — and its catalog links a **complete 39-page
exam guide on a public S3 path**, containing everything the agent had reported
as unavailable: pricing, the five weighted domains, 30 task statements, six
scenarios. The agent had searched `site:anthropic.com OR site:claude.com`, never
reached the Skilljar tenant, and reported "no primary source states this" when
the justified claim was "the pages I checked don't state this."

Three artifacts followed, each narrower than the last: an `analysis` mapping
Anthropic's seven primary-source hosts; a `policy` requiring negative findings
to name their scope; an `/intake` amendment adding a primary-source step. Then,
at the operator's challenge — *is this trying to solve hallucination, beyond the
scope of admonitions?* — a fourth: a **proposed source-recall eval whose
falsification condition would retire the map and revert the amendment**. None of
the session's three errors were hallucinations; all were verifiable-in-principle
process failures, which is what makes them addressable at all.

A `mix brain.staleness` task was designed and then *not built*: measured
exposure was 2 of 78 resource-bearing documents, failing the repo's own
admission rule. It is filed as a todo behind an explicit trigger.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| CCA program status, credentials, industry reaction | closed | [claude-certification-program](/knowledge/SWE/agentic/anthropic/certification/claude-certification-program.md) | - |
| The CCAR-F blueprint: domains, task statements, scenarios | closed | [cca-foundations-exam-blueprint](/knowledge/SWE/agentic/anthropic/certification/cca-foundations-exam-blueprint.md) | - |
| Study-program design; `education/` ratification | closed | [cca-certification-study-program](/meta/plans/cca-certification-study-program.md) | - |
| MCP knowledge gap | open | [mcp-architecture](/knowledge/SWE/agentic/mcp/mcp-architecture.md), [mcp-tools-primitive](/knowledge/SWE/agentic/mcp/mcp-tools-primitive.md) | resources, prompts, transports, lifecycle, auth still unfiled; captured revision 2025-06-18 lags current 2025-11-25 |
| Agent SDK knowledge gap | open | [claude-agent-sdk-overview](/knowledge/SWE/agentic/anthropic/claude-code-sdk/claude-agent-sdk-overview.md) | hooks, permission callbacks, subagent config, session forking unfiled |
| Claude API knowledge gap | open | [claude-api-tool-use](/knowledge/SWE/agentic/anthropic/claude-api/claude-api-tool-use.md) | Messages API proper, caching, batches, extended thinking unfiled |
| Claude Code configuration gap | open | [claude-code-settings-and-permissions](/knowledge/SWE/agentic/anthropic/claude-code/claude-code-settings-and-permissions.md) | slash commands, skills, rules, plan mode, CI/CD unfiled |
| Third-party prep quarantine | closed | [survey/bookmarks.md](/survey/bookmarks.md) | - |
| The primary-source miss; Anthropic's host topology | closed | [anthropic-primary-source-surfaces](/meta/analysis/anthropic-primary-source-surfaces.md) | - |
| Reporting negative findings relative to scope | closed | [negative-findings-name-their-scope](/meta/policy/negative-findings-name-their-scope.md) | - |
| Measuring whether the map and policy do anything | open | [source-recall-probe](/meta/evals/source-recall-probe.md) | instrument not built; A/B harness undesigned |
| Dated-revision staleness checking | paused | [build-mix-brain-staleness-when-dated-resources-grow](/meta/todos/build-mix-brain-staleness-when-dated-resources-grow.md) | waiting on ~10 dated resources, or a stale capture misleading a conclusion |
| Can an individual certify without Partner Network membership? | paused | `unrouted` | no primary source states it; needs the operator to apply or ask Anthropic |
| A skill carrying the source map (name collides with `/research`) | paused | `unrouted` | operator floated it; four options offered, none chosen |
| Prompt engineering: 20% of the exam, unrepresented in the brain | open | `unrouted` | `knowledge/SWE/prompt-engineering/` not yet created |

---

## User

what is the current status on the CCA claude certified architect program, and what is the general reaction of the industry

## Assistant

<routes ref="em:bdfa05">
Here's the current picture as of late July 2026.

## Program status

The **Claude Certified Architect (CCA)** is Anthropic's first official technical certification, launched **March 12, 2026** alongside the [Claude Partner Network](https://www.anthropic.com/news/claude-partner-network), which Anthropic backed with a **$100M investment for 2026**. The certification validates the ability to design and ship production-grade Claude applications — covering the Claude API, Agent SDK, MCP, and Claude Code.

The program has since expanded into a [four-credential family](https://claude.com/blog/four-role-based-claude-certifications):

| Credential | Code | Audience |
|---|---|---|
| Claude Certified Associate – Foundations | CCAO-F | Consultants, project leads, daily Claude users |
| Claude Certified Developer – Foundations | CCDV-F | Engineers building on the API/tool use/agents |
| Claude Certified Architect – Foundations | CCAR-F / CCA-F | Solution architects designing agent systems |
| Claude Certified Architect – Professional | CCAR-P | Enterprise-scale integration, governance, evaluation |

Key operational facts:

- **Exam**: proctored, identity-verified, ~60 questions for the Foundations tier; badges issued via Credly. Prep courses live in Anthropic Partner Academy (free for partners); certification is currently **open to Claude Partner Network organizations**, and reported pricing is around **$125** (free via partner employers).
- **Delivery moved to Pearson VUE** around **June 30, 2026** ([Pearson VUE's Anthropic page](https://www.pearsonvue.com/us/en/anthropic.html) now lists all four exams), bringing a formal retake policy (up to 4 attempts per rolling 12 months, with 14/30/90-day waits) and a 12-month certification term with free renewal.
- **Uptake**: as of the latest official numbers, **36,000+ consultants across 1,300+ organizations** have earned a certification, and more than 40,000 firms applied to join the Partner Network since March.
- **Roadmap**: advanced Architect specializations (security, enterprise integration, multimodal) are slated for later in 2026, with existing CCA holders getting priority access.

## Industry reaction

**The consulting industry has embraced it at enormous scale.** The Global Premier partners made headline certification commitments — **Accenture 50,000, PwC 30,000, Capgemini 20,000, DXC 20,000, Deloitte 15,000, KPMG 15,000, Cognizant 10,000** — and several firms are reportedly prioritizing the credential in hiring. This is the strongest signal: the big SIs are treating it like the early AWS certification wave, a way to signal delivery capacity to enterprise buyers.

**Individual developer sentiment is positive but with real caveats:**

- *Pro*: it's the only credential backed by the model vendor itself, it forces breadth across the full stack (Claude Code + Agent SDK + API + MCP, where most practitioners have blind spots), and "experience building with Claude" is showing up as an explicit hiring requirement. Reviewers generally rate it as [most valuable for client-facing solution architects and career transitioners](https://www.claudecertifiedarchitects.com/blog/claude-certified-architect-certification-worth-it/), who benefit from third-party-validated proof of competence.
- *Con*: the recurring skepticism is **shelf life** — the AI stack moves so fast that exam content could feel stale in 6–9 months (the 12-month term with free renewal is partly Anthropic's answer to that). Some also note the partner-gated access limits who can take it, and the Pearson VUE move raised the fee and dropped the practice exam.

The overall read: enterprises and consultancies are treating CCA as the emerging standard credential for the Claude ecosystem, while independent developers see it as worthwhile mainly if their role involves selling or architecting Claude solutions rather than as a general-purpose résumé item.
</routes>

## User

see a reference like this https://www.claudecertifiedarchitects.com/

how might we /intake the many resources related to these courses? should we create an education/certification heading and then file this underneath it? in this case, i would also like to create a course to begin study towards passing the exams. see https://www.claudecertifiedarchitects.com/cca-exam-guide/ - imagine this created here in elixir-mind, but with references to resources also held here. there could be a balance of synthesis and referencing primary documents. I would like to start a practice of running a skill /cca-practice which would then show me a practice question the likes of the practice tests here https://www.claudecertifiedarchitects.com/ but based on your own research and understanding of both the actual tests as well as the content that underlies them. I would imagine /cca-practice to present the question with the option of "explain" as the last option in case i have no idea

lets discuss both what this approach might look like as well as how the info should be persisted

## Assistant

I've got enough to make a concrete proposal. One finding reframes the whole thing, so let me lead with it.

## The brain already holds about half the syllabus

I mapped the five exam domains against the existing tree (501 bundle docs):

| Domain | Weight | Existing coverage | Verdict |
|---|---|---|---|
| Agentic Architecture | 27% | `agentic-loop/` (~18 docs), `frameworks/`, `multi-model/`; 38 docs mention orchestration, 22 subagents | **Strong** |
| Context Management | 15% | `context-engineering/` (8 docs), 3 on prompt caching | **Strong** |
| Claude Code Configuration | 20% | 29 docs mention `CLAUDE.md`, 11 permissions — but `anthropic/claude-code/` is mostly cloud-env sources | **Moderate** |
| Tool Design & MCP | 18% | 25 incidental MCP mentions, **no** dedicated dir, **zero** on tool schema design | **Weak** |
| Prompt Engineering | 20% | **2** docs mention it; `llm-engineering/` is vector-DB and KV-cache material | **Weakest** |

So ~42% of the exam is already well covered, and the two weak domains are 38% of it. That has a design consequence: **the study effort should be a targeted intake program against real gaps in the brain, not a parallel silo of exam notes.** If we build "education/prompt-engineering.md" as a standalone study note, we've fragmented — the contract's [update-in-place](https://ob6to8.github.io/elixir-mind/meta/policy/update-in-place.html) rule and "the tree *is* the taxonomy" both push against it.

## The approach: a curriculum overlay, not a knowledge silo

Two layers, deliberately separated:

**Layer 1 — subject knowledge stays in the existing taxonomy.** Prompt engineering gets `knowledge/SWE/prompt-engineering/`; MCP gets `knowledge/SWE/agentic/mcp/`. Both are subdirectories under already-established top-level domains, so per the taxonomy-evolution protocol I can create those **autonomously** — no ratification needed. Filling them is ordinary `/intake` work against Anthropic's primary docs.

**Layer 2 — the course is a spine that maps and sequences, never restates.** A per-domain study guide holds: what the exam expects, an ordered reading path of bundle-absolute links into Layer 1, the exam-specific framing that *isn't* in the knowledge docs, and an explicit gap list. If a domain guide starts explaining what MCP is, it has failed — that belongs in `knowledge/SWE/agentic/mcp/`. This is the main failure mode to guard against, and it's worth writing into the skill as a guardrail.

The payoff: the course stays thin and current, and every hour of study is also an hour of permanent brain improvement.

## Intaking the resources — split by source quality

The CCA prep web is largely SEO/affiliate content of uneven reliability (claudecertifiedarchitects.com, certdemand, claudecertificationguide, the Udemy courses). The [link-processing policy](https://ob6to8.github.io/elixir-mind/meta/policy/link-processing.html) already has the right answer:

- **Primary sources → `/intake` as filed `reference`/`source` docs.** Anthropic's partner-network announcement, the four-certifications blog post, Pearson VUE's exam page, Anthropic Academy course pages, and — most importantly — the official Claude Code docs, Agent SDK docs, MCP spec, and prompt engineering guide. These become the grounding.
- **Third-party prep sites → `/bookmarks` (survey tier).** Fetched, one-line-summarized, tagged. They're useful as *signal about the exam's shape*, not as authority. Promote one to a filed `reference` only if it earns it.

There's a live instance of this already. **The domain weightings I quoted you in my last message — 27/20/20/18/15, 720/1000, 120 minutes — came from claudecertifiedarchitects.com, not from Anthropic or Pearson.** Neither official page states them. So the blueprint doc should be filed as `type: claim` with `verified: false` until we ground it, and then either graduate via `verified_by` pointing at official `source` captures, or stay an explicitly-marked third-party reconstruction. That's exactly what [verification-grounding](https://ob6to8.github.io/elixir-mind/meta/policy/verification-grounding.html) is for, and it keeps us honest about studying to an unofficial blueprint.

## The question bank — the piece worth getting right

The idea I'd push hardest: **every question cites the bundle document(s) that ground its correct answer.**

That single constraint does a lot of work. The "explain" option becomes genuinely good — it links to real filed knowledge instead of model recall, which is the difference between a practice tool and a hallucination generator. It makes questions auditable and improvable rather than disposable. And it inverts into a coverage instrument: a question you can't ground is a gap in the brain, which routes straight back to `/intake`. The bank becomes a test of the brain as much as of you.

Shape: one file per domain (`questions/tool-design-and-mcp.md`), each question carrying stem, options, answer, explanation, grounding refs, and a difficulty tag. Non-bundle — no `em:` ids. A practice question isn't a distilled concept, and 400 of them would drown the registry; the `survey/bookmarks.md` register is the precedent for a structured non-bundle store.

I'd seed the bank by hand-authoring against the knowledge docs and let `/cca-practice` also generate fresh questions on demand, with an option to promote a good generated one into the bank — mirroring the survey → intake → bundle promotion path already in the brain.

## `/cca-practice` flow

```
/cca-practice                → one question, sampled by domain weight,
                               biased toward weak domains, avoiding recent repeats
/cca-practice mcp            → domain-scoped
/cca-practice exam           → timed 60-question simulation
/cca-practice review         → per-domain accuracy from the practice log
```

Presentation: scenario stem, options A–D, then **E) Explain** as the last option.

Two design points worth your input:

**Answering happens in chat text, never in a question box.** The [session-capture policy](https://ob6to8.github.io/elixir-mind/meta/policy/session-capture.html) is explicit that anything raised through `AskUserQuestion` never enters the delivered message stream, so `/capture` loses it — a whole study session would render as blank. Plain `## Assistant` text keeps every question and answer in the thread record.

**What E) does.** My recommendation is two-stage: the first E gives a concept briefing with links to the grounding docs and re-offers A–D so you can still attempt it; a second E reveals the answer with full rationale. A single-stage instant reveal is simpler but throws away the retrieval attempt, which is where the learning actually is.

Attempts append to a dated non-bundle practice log — same record-layer posture as `journal/`. That's what makes weak-domain weighting and later spaced repetition possible without putting mutable counters in question frontmatter.

## On tooling

Weighted-random selection with recency avoidance and log parsing is deterministic work that reads badly as agent judgment, and pulling a 400-question bank into context every session is expensive. A small `mix brain.practice` task that prints one selected question keeps the skill cheap and the selection honest. It's zero-dependency and offline, so it clears the contract's admission bar. `mix brain.verify` will also need a rule exempting the questions and log from `em:` ids and attribution — a real but small integration cost.

## Proposed persistence shape

```
education/                                   # NEW TOP-LEVEL — needs your ratification
  index.md
  certifications/claude-certified-architect/
    index.md
    exam-blueprint.md        # type: claim, verified: false until grounded
    study-plan.md            # the spine: ordered path, domain → bundle docs, gap list
    domains/*.md             # 5 guides: expectations + reading paths + gaps (links, not restatement)
    questions/*.md           # non-bundle bank, grounded refs per question
    practice-log.md          # non-bundle, append-only attempt record

knowledge/SWE/prompt-engineering/            # autonomous — fills the 20% gap
knowledge/SWE/agentic/mcp/                   # autonomous — fills the 18% gap
.claude/skills/cca-practice/SKILL.md
lib/mix/tasks/brain.practice.ex
```

`education/` is a new top-level directory — a change to the shape of the brain — so I'm proposing it and waiting. My reasoning for a new top-level rather than nesting under `knowledge/`: `knowledge/` is *what the brain knows*, and a curriculum is a *sequenced path through* what it knows, plus assessment machinery. It also generalizes cleanly to future certs and book studies. The counter-argument is real though — `knowledge/education/` would need no ratification and keeps the top level small.

Once you've settled the shape, this is a cross-session build with an explicit order, so I'd persist it as a `type: plan` under `meta/plans/` with structured artifacts before building anything.

### Questions you need to answer

| # | Question | My recommendation |
|---|---|---|
| 1 | Ratify a new top-level `education/`, or nest it as `knowledge/education/`? | **New top-level `education/`** — a curriculum is a path through knowledge plus assessment, not domain knowledge itself, and it generalizes to future certs |
| 2 | Persist a curated question bank, or generate questions fresh each time? | **Curated bank + on-demand generation with promotion** — grounding refs are what make explanations trustworthy and turn the bank into a coverage instrument |
| 3 | Does E) Explain reveal the answer immediately, or brief-then-re-offer? | **Two-stage** — the retrieval attempt is where the learning is |
| 4 | Ground the blueprint against primary sources first, or start studying on the third-party numbers? | **Ground first** — it's one intake pass, and studying to unverified weightings misallocates all the effort downstream |

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Persist the plan, then build in phases | I write the `type: plan` doc with structured artifacts, you review, then we build spine → gap-fill → bank → skill |
| 2 | Bootstrap the gaps first | Skip straight to `/intake` on Anthropic's prompt-engineering and MCP docs — the 38% of exam weight the brain is weakest on — and defer the course scaffolding |
| 3 | Prove the skill on a thin slice | Build `/cca-practice` against ~15 hand-authored questions in the two *strong* domains only, where grounding docs already exist, and see if the flow feels right before committing to the structure |
| 4 | Survey the prep landscape first | Run `/bookmarks` over the third-party CCA sites so we can see what the exam's shape actually looks like across sources before fixing a blueprint |

## User

agree with intaking the resources, primary sources and the 3rd party prep sites. Not interested in filing 3rd party prep sites as provenance for any claims in the knowledge base - all info should be primary from anthropic

cca-practice should be mechanical - it should not be the source of truth for the why of the project. this should live in the proposed education dir

agree that answering happens in chat text.
agree to two-stage E
agree practice log appending

1. agree education new top level
2. curated bank

3. two stage

## Assistant

Ratified — and the "mechanical" constraint is a good sharpening: the skill stays procedural, the pedagogy lives in `education/`. That mirrors how the contract keeps policies terse and pushes reasoning into cross-linked docs.

Shape is settled, so the next step is the plan doc I flagged. Let me check conventions first.

## User

4. ground first - NO third party numbers

Options order, i would think - 2, 4, then author plan in 1 which will be run in a fresh context. disregard 3, can just build the skill and tweak later

## Assistant

Confirmed — Anthropic publishes only one statement of scope, and it isn't the five domains I quoted earlier:

> "tests foundational knowledge across Claude Code, the Claude Agent SDK, the Claude API, and Model Context Protocol (MCP)"

The authoritative blueprint is an **Exam guide PDF** linked from the Anthropic Academy page, behind Partner Network access. Let me re-key the coverage sweep to Anthropic's four pillars instead of the third-party domains.

## Assistant

<routes ref="em:121acc em:3b0352 em:b4a91a em:038169 em:53f32a">
That changes the picture materially. Re-keyed to Anthropic's own scope statement, the brain is far thinner than my earlier figure suggested — **that 42% was keyed to the third-party blueprint and to conceptual overlap, and it overstated readiness.** The real position:

| Anthropic-named pillar | Filed knowledge | Verdict |
|---|---|---|
| Claude Code | 8 docs in its dir (mostly cloud-env sources); ambient mentions everywhere | thin on configuration specifics |
| Claude Agent SDK | **0 docs** in its dir, 11 passing mentions | near-empty |
| Claude API | **~0** — no filed knowledge on the API surface | empty |
| MCP | no dedicated dir, 25 incidental mentions | near-empty |

The brain is strong on agentic *concepts* and near-empty on the four *product surfaces* the exam actually names. That makes your ordering (gaps first) clearly right. Rewriting the plan against primary-sourced structure:
</routes>

## Assistant

Options 2 and 4 are done, and the plan is authored for fresh-context execution.

The one thing worth flagging before the tables: **"no third party numbers" invalidated more than the weightings.** The five-domain taxonomy itself came from the same prep sites, so I re-checked what Anthropic actually publishes and found a single sentence — the exam "tests foundational knowledge across Claude Code, the Claude Agent SDK, the Claude API, and Model Context Protocol (MCP)". The course is now structured on those four pillars. The authoritative blueprint is an Exam guide PDF on the Anthropic Academy page, behind Partner Network access.

Re-keying the coverage sweep to those pillars also corrected my earlier "42% covered" figure downward. That number measured conceptual overlap against a third-party blueprint; measured against the surfaces Anthropic names, `claude-code-sdk/` held zero documents and the API had none at all. The brain was strong on agent *concepts* and thin on *product surfaces* — which is exactly why your ordering was right.

### What I created

| Type | Doc | Why this type |
|---|---|---|
| `plan` | cca-certification-study-program | cold-context handoff with an explicit build order — the plan-vs-capture escalation case |
| `reference` | MCP architecture `em:121acc` | captured spec material, carries `resource` |
| `reference` | MCP tools primitive `em:3b0352` | same |
| `reference` | Claude Agent SDK overview `em:b4a91a` | same — first doc in a previously empty directory |
| `reference` | Claude API tool use `em:038169` | same — new `claude-api/` subdir |
| `reference` | Claude Code settings and permissions `em:53f32a` | same |

### What I modified

| File | Thrust |
|---|---|
| `survey/bookmarks.md` | four third-party CCA prep sites surveyed, with the blueprint figures marked as absent from every Anthropic and Pearson source |
| `agentic/index.md`, `anthropic/index.md`, `claude-code/index.md`, `claude-code-sdk/index.md` | register the new `mcp/` and `claude-api/` subdirs and the new documents |
| `meta/plans/index.md`, `meta/registry.md` | plan listed under Accepted; registry recompiled |

### Actions I have taken

| Action | Result |
|---|---|
| Verified exam scope against Anthropic and Pearson primary sources | only the four-pillar sentence is published; no official weighting, pass mark, or question count exists publicly |
| Synonym-expanded dedup pass before filing | no overlap — glossary had term definitions for MCP and the Agent SDK, no docs on the product surfaces |
| `mix brain.id` / `registry` / `verify` | 5 ids minted, registry recompiled, bundle verifies |
| Committed and pushed to `claude/cca-program-status-13fx6c` | all gates green; 183 tests, 0 failures. No PR opened — you haven't asked for one |

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | `/create-pull-request` | captures this session, glossaries it, stamps `attribution.from` on the plan (the one advisory warning outstanding), and opens the PR |
| 2 | Deepen phase 1 before moving on | the four pillars have one doc each; MCP resources/prompts/transports, Agent SDK hooks and permissions detail, and prompt engineering are still unfiled |
| 3 | Hand the plan to a fresh session | phases 3–7: stand up `education/`, write the pillar guides, build `mix brain.practice` and `/cca-practice` |
| 4 | Pursue Partner Network access | the official Exam guide PDF is the only primary blueprint; until then the course rests on one sentence. This one is yours to decide, not mine |

## User

are all these phases documented in the plan? expand on option 4

## Assistant

Pushed.

## Are all the phases documented?

Phases 3–7 were, and options 1 and 3 map cleanly onto them. **Option 2 was not, and the plan was actively wrong about it** — it stated phases 1–2 were "executed in the originating session" when phase 1 had only a first pass. A fresh session would have read phase 1 as complete and gone straight to seeding a question bank with almost nothing to ground it against, which defeats the `grounds` mechanism the whole design rests on.

Fixed: phase 1 now carries a table of what was filed with ids, and an explicit list of what remains. That remainder is substantial:

- **MCP** — resources and prompts primitives, transports, lifecycle, authorization, sampling/elicitation
- **Agent SDK** — hooks in depth, permission callbacks, subagent config, session forking, custom tools
- **Claude API** — the Messages API proper, prompt caching, extended thinking, Anthropic-schema tools
- **Claude Code** — slash commands, hooks, memory resolution, MCP config, skills and plugins
- **Prompt engineering** — still unrepresented; not a named pillar but load-bearing across all four

Option 4 was already in the plan as open question 2, but thinly. Now expanded with the research below.

## Option 4 — Partner Network access

What Anthropic actually publishes:

> "Any organization that is bringing Claude to market is eligible to join the Claude Partner Network."

Membership is **free**, applications are open at [claude.com/partners](https://claude.com/partners), and members receive the Partner Portal, Anthropic Academy training (free for partners), and certification access. Both the [certification post](https://claude.com/blog/four-role-based-claude-certifications) and [Pearson VUE](https://www.pearsonvue.com/us/en/anthropic.html) state exams are "currently available to Claude Partner Network members" / "open to organizations in the Claude Partner Network", with registration running through Anthropic Partner Academy.

**The gap that matters to you: nothing primary says whether an individual can join or sit the exam.** The eligibility language is written in terms of organizations throughout. `claude.com/partners` publishes no tier table, no eligibility criteria, and no individual path — it names three partnership categories (cloud deployment, services, "Powered by Claude") and a "Log in to access resources" portal, nothing more. The widely-repeated **$125 individual price is third-party only** and appears in no Anthropic or Pearson source, so under your constraint it can't be treated as fact.

Why this is worth resolving before investing much further: the Exam guide PDF is the only primary blueprint in existence, and it sits behind this gate. Everything else — five domains, weightings, pass mark, duration — is prep-site reconstruction.

The good news is it isn't blocking. Phases 1 and 3–7 build knowledge and machinery, not exam-shaped guesswork, so they proceed unchanged on the four-pillar sentence. Access changes *what the blueprint doc can say*, not whether the program can be built. The deliberate thinness of that doc is the design working — it stays honest rather than padded.

Resolving it takes a human: submit the partner application, or contact Anthropic's partner team and ask directly whether an individual may certify. Both are outward-facing actions I shouldn't take on your behalf.

| # | Option | What it entails |
|---|---|---|
| 1 | Continue phase 1 | the largest remaining work and the prerequisite for a grounded question bank — I'd start with the Messages API and prompt engineering, the two thinnest areas |
| 2 | `/create-pull-request` | captures the session, glossaries it, stamps `attribution.from` (the outstanding advisory warning), opens the PR |
| 3 | Hand phases 3–7 to a fresh session | viable now, but the bank seeded in phase 7 will be thin until phase 1 finishes |
| 4 | Pursue partner access yourself | free application at claude.com/partners; ask directly about individual eligibility |

## User

is this not an official anthropic site? https://anthropic-partners.skilljar.com/page/partner-certifications

## Assistant

Yes — that's official Anthropic. Skilljar is just the LMS vendor; `anthropic-partners.skilljar.com` is Anthropic's own Partner Academy tenant. I already treated it as primary: the four-pillar scope sentence in the plan is cited from that domain.

What I claimed was gated is narrower — the **Exam guide PDF** linked from the certification page. Let me check whether that's actually true, since if the catalog page is public the PDF may be too.

## User

there are prices on that page

## Assistant

<routes ref="em:bdfa05">
Confirmed — and those prices are now **primary-sourced**, which retires my earlier caveat. From Anthropic's own Partner Academy catalog:

| Certification | Price |
|---|---|
| Claude Certified Associate – Foundations | $99 (does not count toward Partner Network tier eligibility) |
| Claude Certified Developer – Foundations | $125 |
| Claude Certified Architect – Foundations | $125 |
| Claude Certified Architect – Professional | $175 |

The PDF downloaded but didn't parse as text. Reading it directly:
</routes>

## User

you claimed the prices were third party only. so you were unable to surface this page in your searches?

## Assistant

You're right, and that's my error. Let me own it precisely.

I fetched the Academy's *individual* CCA certification page, which doesn't show pricing, and my `site:` searches were scoped to anthropic.com and claude.com — so they never touched the skilljar tenant at all. I then concluded "no primary source states the price" from "the primary pages I happened to check don't state it." That's an absence-of-evidence overreach, and it's exactly the error the quarantine discipline was supposed to prevent: I misclassified a fact as third-party-only when Anthropic publishes it on a public catalog page one link away from a page I had already read.

The quarantine *logic* was sound; my classification of one fact was wrong. The plan now records that wrong claim and needs correcting. Let me get the blueprint first — the extraction hit font-subset encoding.

## User

what else have you failed to surface, if this is in fact the case? could it be worth a research spike?

## Assistant

<routes ref="em:214aa4">
Yes — official. Skilljar is the LMS vendor; `anthropic-partners.skilljar.com` is Anthropic's own Partner Academy tenant. And it doesn't just have prices — **the complete 39-page exam guide is public on that page**, served from an S3 `/public/` path with no login. That was the single largest open question in the plan, and it was one link from a page I had already read.

## What went wrong, precisely

I fetched the Academy's *individual* CCA certification page, which states scope but no pricing or blueprint. My `site:` searches were scoped to `anthropic.com` and `claude.com`, so they never touched the skilljar host at all. I then concluded "no primary source states the price" from "the primary pages I happened to check don't state it."

That's absence of evidence asserted as evidence of absence — and it's the exact failure the quarantine discipline exists to prevent. The discipline was sound; my classification of the facts was wrong, in the more damaging direction: I told you real primary data was third-party.

## What the guide actually says

All primary now, and it corrects the third-party record in two ways that matter for building:

| | |
|---|---|
| Code / version | `CCAR-F`, v1.0, effective July 2026 |
| Items | 60 — **multiple-choice *and* multiple-response** (prep sites say "one correct answer" — wrong) |
| Structure | **4 scenarios drawn from a bank of 6** (prep sites say 6 — wrong) |
| Time / cut score | 120 min · scaled 720 on 100–1,000 · criterion-referenced |
| Fee / validity | $125 · 12 months · free non-proctored renewal, lapse = full retake |

Domains: Agentic Architecture & Orchestration 27%, Claude Code Configuration & Workflows 20%, Prompt Engineering & Structured Output 20%, Tool Design & MCP Integration 18%, Context Management & Reliability 15% — expanded into **30 task statements**, each with explicit *Knowledge of* / *Skills in* bullets. The guide says items "are written against these objectives," which makes task statements the real unit of study and gives question coverage a denominator.

**One finding changes the project's constraints.** Section 14 binds candidates to an NDA covering "all exam content, including questions, answer options, and scenarios." So the bank must be authored from the published objectives, never reconstructed from recalled items; third-party question banks become *not ingestible* (they may themselves be reconstructions); and excluding the bank from the public site moves from prudent to settled. That's now written into the plan as binding design input.
</routes>

## Assistant

## What else I likely missed

Honestly: I don't know the full extent, which is itself the answer. Concretely visible gaps:

- **Three more public exam guides** on the same S3 path — Associate, Developer, Architect Professional. The Professional guide describes the next credential up and I haven't read it.
- **Anthropic Academy's free courses** (`claude.com/resources/courses`) — the official prep track, never checked.
- **Certification Terms & Conditions and Candidate Handbook**, referenced in the guide's registration steps.
- **The `code.claude.com` and `platform.claude.com` doc trees** — I read three pages between them and filed four documents against surfaces spanning hundreds.

The systemic issue: Anthropic's primary sources span at least six hosts — `anthropic.com`, `claude.com`, `platform.claude.com`, `code.claude.com`, `support.claude.com`, `anthropic-partners.skilljar.com` — plus `modelcontextprotocol.io`. I searched two and generalized.

## On the spike — yes, worth it

But scoped as a **source inventory**, not open-ended research: enumerate Anthropic's primary surfaces and what each authoritatively covers, filed as an `analysis`. It converts primary-source intake from a search gamble into a checklist, and it's cheap — an afternoon of enumeration against a permanent reduction in exactly this failure mode. I've recorded it under a `## Deferred` heading in the plan rather than filing it, since a standalone artifact should wait until you decide to run it.

I'd sequence it **before** the rest of phase 1, since phase 1 is precisely "find and file Anthropic primary documentation" and doing it against a known map beats doing it against search luck.

## User

pursue the concretely visible gaps
i wonder if we should creat a /research skilll that could include your discovery about anthropic sites

1. run the spick
2. yes
3. no
4. when this is finished, let me know, and i will invoke

## Assistant

On the `/research` idea — flagging a collision before I build anything: this repo **already has `/research`** (the daily inbox feed). What you're describing is a different thing. I'll come back to it with options once the spike is done.

Starting with the enumerable gaps. Both doc hosts expose `llms.txt` indexes — that's exactly the checklist the spike needs.

## Assistant

Done — ready for you to invoke `/create-pull-request`.

## What the spike found

Anthropic's authoritative docs span **seven hosts**, and the split isn't intuitive:

| Host | Owns |
|---|---|
| `anthropic.com` | corporate news, research, policy, `/learn` |
| `claude.com` | product marketing, blog, `/partners`, `/resources/courses`, `/resources/certifications` |
| `platform.claude.com` | the Claude API — Messages, tool use, caching, batches, Managed Agents |
| `code.claude.com` | Claude Code **and** the Agent SDK |
| `anthropic-partners.skilljar.com` | Partner Academy — certification catalog and **all four exam guides** |
| `support.claude.com` | help center, billing, compliance |
| `modelcontextprotocol.io` | the MCP spec, SEPs, registry, governance |

Two findings I didn't expect. **The redirect chain hides the topology** — `docs.claude.com` 301s to *either* `platform.` or `code.` depending on path, so an agent following redirects lands correctly while never learning two hosts exist. The knowledge needed to search well is exactly what the redirects conceal. And **both doc hosts publish `llms.txt` indexes** — a complete machine-readable page index. Fetching one is strictly better than searching, and should be the first move against either host.

I filed this as an `analysis`, not a policy. The contract loads in full every session and should carry rules that fire unprompted; a vendor source map is consulted once you've already decided to research Anthropic. The one genuinely general rule — *report absence relative to the scope searched* — I left as an open question rather than smuggling it in under a vendor map. It's the actual lesson and deserves its own decision.

## The gaps, closed

All four exam guides recovered. They're **different roles, not tiers of one syllabus**:

| | Items | Fee | Domains | Heaviest domain |
|---|---|---|---|---|
| `CCAO-F` Associate | 60 | $99 | 7 | Output Evaluation & Validation 21% |
| `CCDV-F` Developer | 53 | $125 | 8 | Applications & Integration 33.1% |
| `CCAR-F` Architect–F | 60 | $125 | 5 | Agentic Architecture & Orchestration 27% |
| `CCAR-P` Architect–P | 63 | $175 | 7 | Integration 19% |

The sharpest contrast: **only `CCAR-F` treats Claude Code configuration as a major domain — 20%, against the Developer exam's 3.1%.** And Architect Professional trades orchestration and tool design for governance, stakeholder communication, and lifecycle management. Worth knowing before choosing a target credential.

Two corrections to my own work this session: the count is **30** task statements, not 29 — I asserted it before summing the per-domain counts (7+5+6+6+6), and the auto-numbering caught it. And the **MCP spec's current revision is 2025-11-25**; the two MCP docs I filed captured 2025-06-18. Dated revision paths stay live indefinitely without signalling staleness, so both now carry an explicit captured-revision note and re-verification is in the plan.

## On the `/research` idea

`/research` is already taken — it's this repo's daily inbox feed. What you're describing is a different thing, and I'd frame the choice as: **is the source map a skill at all?**

My read is mostly no. The map is *reference material* — an agent researching Anthropic should read it, which the analysis already enables via a link. What might deserve automation is the narrower, genuinely general behavior: fetching `llms.txt` first, and reporting absence relative to scope searched. That's closer to an amendment to `/intake` or a short policy than a new skill.

| # | Option | What it entails |
|---|---|---|
| 1 | Amend `/intake` | add a primary-source step: identify the owning host, fetch `llms.txt` first, check spec revisions. Cheapest, fires where it matters |
| 2 | A terse policy on scope-bounded negative claims | "report absence relative to what was searched" — general, contract-worthy, fires unprompted. My pick if only one |
| 3 | A new `/sources` skill | per-subject source maps as a genre. Premature on one instance |
| 4 | Leave it as the analysis | it's linked from the certification docs; an agent researching this hits it naturally |

## User

1 and 2 both

## Assistant

Both landed.

## The policy

The rule in one line: **a claim that something does not exist is a claim about a search space, so it names the space actually searched.** With an escalation clause — when the finding is load-bearing (it justifies building something, or telling you a thing is unavailable), enumerate the search space first or say plainly that you didn't. That's the clause that would have caught this session's error: I let an unscoped negative justify an entire plan's premise.

One thing worth flagging: the name sits close to the existing **negate-only-explicit-cases**, and I nearly created a confusing pair. They govern genuinely different things — that one is about *rhetorical* negation (does a negative sentence have an anchor the reader can see), this one is about *epistemic* negation (has a negative claim been earned). I wrote the distinction into the policy body so a future agent hitting both in the contract isn't left guessing which applies.

I kept it to ~30 lines. The contract loads in full every session, so the reasoning and the worked example live in the linked analysis rather than in the rule.

## The `/intake` amendment

Five checks in the gather step, ordered by what actually failed:

- **Go to the owning host before searching** — a `site:`-scoped search encodes a guess about topology that fails silently when wrong
- **Prefer an index over a search** — fetch `llms.txt` where it exists; enumeration beats guessing
- **A program is not a product** — certification and partner material live in the program portal, which no product-doc search reaches. Includes the specific trap: *a login control on the page is not evidence its linked assets are gated*
- **Dated specs: confirm the revision** — from the MCP 2025-06-18 vs 2025-11-25 catch
- **Report absence relative to scope**, linking the new policy

Each of these is a mistake I made today, not a hypothetical.

## User

the five checks represent evidence for agent behavior failure modes. could these be springboards into evals? should we create a working db within evals? could these act at all for instructions for future agents, or is this trying to literally solve for "hallucination", a general purpose problem, beyond the scope of a series of admonitions?

## Assistant

Taking the hardest question first, because it determines the answer to the other two.

## Were any of today's errors hallucinations?

No — none of the three. That's the crux, and it's worth being precise:

| Error | What actually happened | Kind |
|---|---|---|
| "No primary source states the price" | A **true** statement about my search, generalized to a claim about the world | scoping |
| MCP spec at 2025-06-18 | A **real** revision at a **live** canonical URL | currency |
| 29 task statements | Arithmetic on data I had **correctly** extracted | computation |

Zero fabrications. Nothing was invented — every input was real and every intermediate step was sound. The failures happened at the *reporting* and *currency* boundaries, not the generation boundary.

That distinction decides tractability. Hallucination is a property of how the model generates under uncertainty, and you cannot admonish it away. What happened here is closer to forgetting to check `git status` before committing: a discrete, checkable action at an identifiable moment. So this isn't a doomed attempt to solve a general-purpose problem — but only because it *isn't that problem*.

## The taxonomy that matters: facts vs. judgment

The five checks are not the same kind of thing, and lumping them is what makes the whole set look like exhortation.

**Checks 1–4 supply a missing fact.** "Anthropic's docs live on seven hosts." "Fetch `llms.txt` first." "The program portal is separate." "Dated spec paths serve stale revisions silently." An agent that fails these fails from *not knowing*, not from poor reasoning. Handing over a host map is no more "solving hallucination" than a lookup table is solving arithmetic — it's ordinary engineering knowledge, and encoding it is uncontroversial.

**Check 5 asks for better judgment.** "Report absence relative to scope searched" supplies no fact. It asks the agent to notice, mid-composition, that it is about to overclaim. That is the one closest to a general cognitive property, and — not coincidentally — the only one with no artifact to check.

So my honest concession: **check 5 may well be theater, and the other four are not.** I'd rather say that plainly than defend the set as uniform.

## Eval-ability, by the repo's own rule

The coding standards already settle the test — a standard with a mechanical oracle becomes a gate, one without gets written as policy. Applying it:

| Check | Oracle | Verdict |
|---|---|---|
| 4 — confirm spec revision | deterministic, on any doc whose `resource` is a dated path | a **tool**, not an eval — but it needs network, which breaks the offline-toolchain invariant, so on-demand rather than a gate |
| 3 — program ≠ product | yes, as **recall against a known-complete source set** | the **one genuine eval** |
| 1 — owning host | partial; folds into 3's measurement | subsumed |
| 2 — prefer the index | process, leaves no artifact trace | admonition only |
| 5 — scope your negatives | property of a *response*, and responses aren't committed | admonition; LLM-judge at best, noisy |

One tool, one eval, three admonitions. That's a much less impressive haul than "five springboards" — and I think it's the real count.

## The one eval worth building

A **source-recall probe**, the direct analogue of dedup-probe: a gold set of `(research question → known-complete source set)`, scoring whether an agent's search surfaces them.

Today hands you the first gold row for free, and an honest one — it records a failure that already happened rather than a case constructed to pass.

What makes this the right eval rather than a proxy: **source recall is upstream of both failure modes.** If recall is high, the agent has the facts and scoping becomes a reporting discipline. If recall is low, no admonition can help — you're asking a model to caveat around a gap it can't see. It measures the thing that determines whether the admonitions are even addressable.

And the deeper point, which is really the answer to your framing: **the eval's job isn't to fix agent cognition — it's to falsify our own policy.** Without one, rule #18 joins a ~7,000-word contract with entirely unmeasured adherence, and we accumulate governance nobody can disprove. This repo already understands that — priorities-recitation-vs-harness-reminders proposes exactly this shape for a different rule, with an explicit falsification condition: "no measurable difference appears."

## On a "working DB"

I'd push back on the noun and accept the thing. A database breaks the zero-dependency, offline, markdown-plus-generated-artifacts stance the toolchain is built on. But you don't need one — `dedup-probe` **is** the pattern already: a gold-set table in markdown, a mix task that parses it, a committed baseline, the trend living in git history.

So: a second probe in the same mold, not a new storage layer. If a third and fourth appear, *then* the shared-harness question becomes real and worth answering on evidence.

| # | Option | What it entails |
|---|---|---|
| 1 | File the source-recall probe as a `proposed` eval | design the instrument and falsification condition in the recitation-eval mold; seed the gold set with today's miss. Cheap, and it's the honest test of whether any of this works |
| 2 | Build `mix brain.staleness` | check 4 has a real oracle — dated `resource` paths vs. current revision. On-demand, network-dependent, so not a gate |
| 3 | Both | they're independent; 2 is mechanical, 1 needs design |
| 4 | Neither, for now | the checks stand as admonitions and we accept they're unmeasured. Defensible — but then we should stop adding to them |

My recommendation is 1, then 2 if it proves worth it. Option 4 is the one I'd argue against, though not strongly: unmeasured governance is survivable at this scale, but "stop adding to it" then has to be real, and this session added three items to it.

## User

proceed according to your recs

## Assistant

Done. Ready for `/create-pull-request`.

## Two judgment calls worth surfacing

**The eval is a behavioral A/B, not a `mix` task.** I'd framed it earlier as "the direct analogue of dedup-probe," and that was half wrong. `dedup_probe` works because it scores a *deterministic lexical backend* offline. Source recall scores *agent behavior* — non-deterministic, network-dependent, one agent run per row. So it lands in the recitation-eval genre instead. There is a cheap mechanical proxy (check each filed doc's `resource` host against the canonical host for its subject), and I documented it alongside why it isn't the instrument: it can only see sources that were already found, which excludes the entire quantity of interest.

**The falsification condition points at this session's own output.** If the map-equipped arm scores no better than the unaided one, then the source map is decoration and the `/intake` amendment should be *reverted*, not kept as unmeasured ceremony. I wrote that in deliberately — you raised the theater question, and the honest response is an instrument that can find against the work I just did. Two other outcomes are specified: both arms high means recall was never the bottleneck and the policy carries the whole load; both arms low means the admonition layer is the wrong instrument entirely and the effort belongs in tooling.

On `mix brain.staleness` — I recommended it "if it proves worth it," and on measurement it doesn't yet. Two documents, both already carrying revision notes, against a check that necessarily makes network calls and so breaks the offline-toolchain property. That fails both halves of the repo's admission rule. The todo carries an explicit trigger: ~10 dated-revision resources, or one stale capture observed to actually *mislead* a conclusion rather than merely lag.
