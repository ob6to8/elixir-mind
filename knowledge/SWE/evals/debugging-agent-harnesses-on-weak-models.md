---
id: em:7309de
type: methodology
title: Debugging an agent harness on weak models
description: Run the agent product's eval suite against the cheapest models on the roster, because a frontier model silently works around harness defects that a weak model fails on immediately — then triage each failure into harness bug, model ceiling, or provider quirk.
resource: https://archestra.ai/blog/we-debug-our-ai-harness-on-weak-models-on-purpose
provenance: "Distilled from Arseny Kravchenko's Archestra blog post (2026-07-20) and the r/LLMDevs discussion thread it spawned, both fetched/pasted 2026-07-28"
tags: [evals, agents, harness, testing, tool-design, model-selection, differential-testing]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T08:13:44Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pasted the Archestra weak-models post and its r/LLMDevs thread to capture the practice"
---

# Debugging an agent harness on weak models

The capability that makes a frontier model worth paying for — recovering from a
malformed tool result, inferring the required parameter that the schema called
optional, picking the right tool out of two near-identical ones — is exactly the
capability that conceals whether the harness around it is any good. The model
absorbs the defect and finishes the task, so the defect never produces a
failing observation. "Strong models are excellent at hiding product bugs."

A weak model has no such margin. "Weaker models are less forgiving. When the
tools, prompts, or runtime are wrong, they fail quickly, which makes them useful
for debugging." Running the same suite on the cheap end of the roster therefore
converts silent harness defects into visible failures, at a fraction of the
token cost. The transferable analogy the post reaches for is the developer
laptop: "Then you try to run that same app on an old IBM ThinkPad with the red
TrackPoint and a spinning hard drive, and it falls apart instantly."

## The practice

"We run Archestra Chat (our built-in chat interface for working with agents and
MCP tools) on weaker models on purpose, record the full trajectory, and
investigate the failures they expose."

The harness that makes this cheap to run is an end-to-end product benchmark, not
a model benchmark. Per the post, each run starts a fresh backend on a new port,
migrates a fresh database, seeds providers, skills, MCP servers and the agent
surface, drives chat sessions through the product, grades the answers out of
band, and tears the instance down. The assistant submits its final answer
through a dedicated channel, and answers are checked for correctness only after
submission, using deterministic code rather than an LLM judge. It runs nightly
in CI against that day's deployed build across a roster of roughly ten models.

Three properties do the work:

- **The suite runs the real product**, so a defect in file handling or sandbox
  tooling is reachable — a model-level eval would never touch it.
- **The full trajectory is recorded**, so a failure is diagnosable rather than
  merely counted. A binary pass/fail cannot distinguish an agent that hit a
  wrapped inner error and re-planned from one that retried the same command a
  hundred times.
- **Grading is deterministic and out of band**, so the scoreboard does not
  inherit a judge model's own blind spots — the
  [test oracle](/beliefs/glossary/test-oracle.md) is code.

The roster spans both ends deliberately. The article's per-model table names, on
the frontier side, Claude Opus 4.8, Claude Sonnet 5, Claude Fable 5 and GPT-5.6;
on the cheap and open-weight side, Claude Haiku 4.5, Qwen3.7 Plus, Qwen3.6 27B,
DeepSeek V4 Flash, Gemma 4 31B and Xiaomi MiMo v2.5. The cheap tier is what does
the bug-finding; the frontier tier establishes that the task is achievable at
all, so a weak-model failure is attributable to the harness rather than to an
impossible task.

The scoreboard is the nominal output and the secondary one: "If I'm honest, the
benchmark's biggest contribution so far hasn't been the scoreboard. It's been a
bug-finding machine, and most of those bugs were ours, not the models'."

## What it surfaces

"This approach has found defects in file handling, sandbox tooling, provider
schemas, and our agent runtime." The post's own table of found-and-fixed defects
(paraphrased here; the article renders it as a table):

| Area | Defect | Fix |
|---|---|---|
| File handling | binary uploads crashed LLM requests | keep files as sandbox references instead of inlining them |
| Sandbox output | NUL bytes crashed Postgres persistence | strip NULs before saving output |
| Sandbox tools | no `zip`/`unzip` available | add the archive-inspection tools |
| Agent runtime | the same tool call repeated hundreds of times | detect loops and impose a ceiling |
| Provider backend | unrecognized `finish_reason` strings | preserve arbitrary provider reasons |
| Benchmark harness | database and connectivity noise | isolate lanes, dedicated Postgres |
| Sandbox engine | engine panics and orphaned processes | treat panics as retryable, reap processes |

Note what class these are. Almost none is a prompt-engineering problem; they are
plumbing — encoding, missing binaries, unhandled enum values, absent loop
guards. A strong model routes around each of them, which is precisely why they
survived to be found this way.

A parallel list from a practitioner in the discussion thread names the
interface-quality defects the same technique exposed for them: "tool
descriptions that are ambiguous but get rescued by the tool name, params
documented as optional that are really required, error strings that say what
went wrong without saying what to do next, and pairs of tools similar enough
that choosing between them takes judgement."

That last set is the more general lesson: the quality of a tool interface is
unobservable while a model with enough judgement is papering over it. "A strong
model silently repairs your contract violations, so the actual quality of your
tool interface stays invisible until something weaker runs it. Same reason you
test against a strict parser instead of a forgiving one."

## Triaging a weak-model failure — the discipline that keeps it honest

Fixing every failure a weak model produces is the failure mode of the technique:
it converges on prompts written down to the weakest model on the roster, which
every stronger model then pays tokens to read. Three categories, and only the
first is a bug in the harness:

| Category | Test | Where the fix belongs |
|---|---|---|
| **Contract bug** | the fix makes an implicit contract explicit | the harness — fix it |
| **Model ceiling** | the fix explains a concept the model lacks | model selection, not the prompt |
| **Provider quirk** | the fix generalizes to neither model nor harness | nowhere; do not encode it |

The contract/ceiling discriminator is stated in the thread as: "The rule we
settled on is whether the fix makes a contract explicit or explains a concept.
Explicit contract means it was our bug. Explaining the concept means it was the
model's limit and the fix belongs in model selection instead."

The third category was added in the same thread and is the one an automated
loop mishandles most readily — the same model behind two endpoints behaves
differently, and "the fix looks local and reasonable right up until you move
providers." The Archestra author reports a reflection agent that "started
offering weird 'fixes' for exact failures of exact openrouter providers,
non-generalizable at all."

The defence against both traps is the same and is structural: run **several**
weak models rather than one. A provider quirk shows up on one; a genuine
contract bug shows up on all of them. That reduces the technique to
[differential testing](/beliefs/glossary/differential-testing.md) with the model
as the varied implementation — "differential testing with extra steps, which is
a good sign rather than a bad one" — and it also forecloses fully automating the
loop: a human filter sits between the failure and the fix.

## Limits

- **Observability covers part of the ground, and only part.** A counter on tool
  failures finds some of these defects more cheaply. It misses the ones where
  nothing failed: the tool succeeded and wrapped a legitimate inner error, and
  the difference between a good and a bad agent is what it did next — re-plan,
  or retry the identical command indefinitely. It also cannot be proactive for a
  self-hosted product, where the deployments that would generate the telemetry
  belong to enterprises the vendor cannot instrument.
- **Cross-model behavioral divergence cuts both ways.** If behavior changes
  sharply between models, an unreplicated failure can send you after the wrong
  root cause — an argument for holding the trajectory record, not just the
  verdict.
- **It measures the floor, not the ceiling.** The output is a claim about
  harness robustness. The complementary question is the one the post closes on:
  "Ask, 'What's the cheapest model that can still handle our actual work?'" —
  a harness hardened this way widens the set of models that can answer it.

## Why this belongs in this brain

The [testing methodology](/knowledge/SWE/testing/elixir-mind-testing-methodology.md)
here already holds that a check earns its place when its signal beats its
upkeep, and that every standard with a mechanical oracle becomes a gate. This
technique is the agent-facing analogue: the mechanical oracle is a cheap model,
and what it gates is the ergonomics of the surface agents actually touch —
skill instructions, `mix brain.*` error strings, tool descriptions. Any of those
could be ambiguous today and invisible, because the models that read them are
strong enough not to complain.

# Citations

- Arseny Kravchenko, *We Debug Our AI Harness on Weak Models on Purpose*,
  Archestra blog, 2026-07-20 —
  <https://archestra.ai/blog/we-debug-our-ai-harness-on-weak-models-on-purpose>
- r/LLMDevs discussion, *Debugging on weaker models is more informative; top
  models cover your harness bugs*, 2026-07 —
  <https://www.reddit.com/r/LLMDevs/comments/1v7zcob/debugging_on_weaker_models_is_more_informative/>
  (quoted comments by `donk8r`, `arsenyinfo`, `Smallpaul`, `rockstarRobin`)
- [Archestra — open-source enterprise AI platform](/knowledge/SWE/agentic/frameworks/archestra-open-source-enterprise-ai-platform.md)
  — the product whose harness this practice was developed against.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:7309de">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-debugging-agent-harnesses-on-weak-models (2026-07-28)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:7309de`]**

Filed [debugging-agent-harnesses-on-weak-models](/knowledge/SWE/evals/debugging-agent-harnesses-on-weak-models.md) (`em:7309de`, `type: methodology`) under `knowledge/SWE/evals/` — the practice of running an agent product's eval suite against the cheapest models on the roster because a frontier model silently works around harness defects that a weak model fails on immediately, distilling the article's found-and-fixed bug table (file handling, sandbox tooling, provider schemas, agent runtime), the r/LLMDevs thread's contract-bug/model-ceiling/provider-quirk triage rule, and the multi-weak-model defence against provider-specific overfitting.
