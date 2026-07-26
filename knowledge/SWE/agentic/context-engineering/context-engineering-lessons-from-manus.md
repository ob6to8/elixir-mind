---
id: em:b4440a
type: reference
title: "Context engineering for AI agents — lessons from building Manus (Yichao 'Peak' Ji)"
description: Six field-tested rules for shaping an agent's context — design around the KV-cache, mask tools instead of removing them, offload to the file system, recite the plan, keep failures visible, and avoid few-shot ruts — captured with an inline-defined walkthrough for readers new to agents and a 2026 currency check on how each rule has aged.
resource: https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus
provenance: "Distilled from Yichao 'Peak' Ji, Manus, 2025-07-18"
tags: [context-engineering, ai-agents, kv-cache, agentic-loop, tool-use, agent-memory, llm-inference, currency-check]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked for the Manus context-engineering post filed with a dated aging analysis up front and the body rewritten with every technical term defined inline for someone new to agents"
---

# Context engineering for AI agents — lessons from building Manus (Yichao 'Peak' Ji)

**Yichao 'Peak' Ji**, Manus, 2025-07-18.
*(Distilled, not transcribed — the original post is at the resource link. Section
ordering follows the operator's ask: the aging analysis comes first, then a
walkthrough written for a reader new to agents, then the compressed technical
version.)*

## 2026 currency check

Researched **2026-07-25**, roughly **twelve months** after publication.
**Verdict: the framing has aged extremely well and has largely been absorbed
into platform primitives — but two of the six lessons have been materially
qualified, and one has had its recommended *mechanism* superseded while its
underlying principle held.** Nothing in the post has been refuted.

**The discipline itself won.** In July 2025 "context engineering" was a
freshly-coined phrase that the post had to argue for. A year on it is the
standard name for the activity, with a canonical vendor treatment —
Anthropic's [Effective context engineering for AI
agents](/knowledge/SWE/agentic/agentic-loop/effective-context-engineering-for-agents.md)
(2025-09-29) — that arrives at a near-identical position from the model
provider's side, and an academic literature that now argues about compaction
policy rather than about whether context curation matters. The post's opening
bet, that an agent's behavior is shaped more by what you put in its context than
by which model you fine-tune, is no longer a contrarian claim.

**Lesson 1 (design around the KV-cache) — principle intact, numbers stale,
tooling now helps.** Prefix caching went from an optimization you configured to
table stakes across every major provider, including longer cache lifetimes that
blunt the penalty for a slow-moving prefix. More directly, Anthropic's
[Context Editing API](/knowledge/SWE/agentic/context-engineering/claude-context-editing-and-memory-tool.md)
(2025-09-29) does server-side, **cache-preserving** removal of stale tool
results — precisely the "prune without invalidating the prefix" move the post
said you had to hand-engineer around. Treat the specific per-MTok prices in the
original as of their era (the model lineup has turned over several times); the
order-of-magnitude gap between cached and uncached input, which is the only
thing the advice rests on, still holds.

**Lesson 2 (mask, don't remove) — the mechanism has been superseded; the
constraint it protected has not.** This is the biggest change. The post's rule
was: never mutate the tool array mid-loop, because tool definitions sit near the
front of the context and editing them invalidates everything after — mask logits
instead. In November 2025 Anthropic shipped the **Tool Search Tool** with
`defer_loading`, which does the apparently forbidden thing: it withholds tool
definitions from the context and pulls them *in* on demand. Reported effects are
large — roughly an 85% reduction in tool-definition tokens on real catalogs, and
internal MCP evaluations improving from 49% → 74% (Opus 4) and 79.5% → 88.1%
(Opus 4.5). The reconciliation is instructive rather than embarrassing: deferred
loading *appends* definitions later in the context instead of rewriting the
prefix, so it honors the post's real invariant (append-only, stable prefix)
while breaking its literal instruction (freeze the tool array). The same year's
move toward invoking tools from a code sandbox rather than as individual
function calls sidesteps definition bloat from the other direction. Read
lesson 2 today as "never *edit* what the cache has already seen" — not "never
change what tools are available." (This capture was filed by a session running
deferred tool loading, which is about as direct a demonstration as the point
gets.)

**Lesson 3 (use the file system as context) — the most thoroughly vindicated.**
Anthropic's Memory Tool shipped a file-based memory directory as an API
primitive; Claude Code's on-disk instruction and skill files do the same thing
by convention; and the pattern of dumping token-heavy tool output to a file and
keeping only the path in the message history is now the default answer to
context growth rather than a Manus peculiarity. The bundle already tracks the
[independent convergence on plain markdown files for agent
memory](/knowledge/SWE/agentic/context-engineering/ai-agent-memory-management-markdown-files.md).
Manus itself generalized the lesson in a later interview (2025-10-15), splitting
what this post called "file system as context" into a five-way vocabulary —
offloading, reduction, retrieval, isolation, and caching — which is the same
insight with more joints. Two sub-notes: the post's "128K is not enough" framing
is now conservative (million-token windows ship), but
[context rot research](/knowledge/SWE/agentic/context-engineering/context-rot-chroma-research.md)
means the bigger windows did not remove the need for offloading, so the
conclusion survives its own premise being outdated. And the post's speculation
that state-space models might beat Transformers if they could lean on external
file-based memory is *partly* playing out, but not in the shape guessed:
2025–2026 shipped **hybrid** attention/state-space architectures (Jamba and
successors, various Mamba-attention hybrids) whose payoff has been long-context
cost and latency, not a new class of file-native agent.

**Lesson 4 (manipulate attention through recitation) — vindicated and
productized.** Rewriting a `todo.md` to keep the goal in recent context was an
idiosyncratic trick in this post; it is now a first-class feature of mainstream
coding agents, which maintain explicit plan/todo state and rewrite it as steps
complete. No revision needed.

**Lesson 5 (keep the wrong stuff in) — materially qualified.** This is the one
lesson in genuine tension with what the field built next, because compaction —
periodically pruning or summarizing the context — necessarily deletes some of
the failure evidence the post says to preserve. The 2026 consensus is a refined
version rather than a reversal: keep a failure **verbatim while it is still
task-relevant**, and retire it once resolved or superseded. Two riders matter.
First, *verbatim* is load-bearing: summarizing a concrete error string into "a
database connection error" destroys the agent's ability to match or search on
it, so errors should be kept exactly or dropped entirely, never paraphrased.
Second, the compaction literature has independently found that repeated
summarization can quietly erode constraints an agent was given early on, which
is the same failure mode the post warns about generalized beyond errors. So:
keep unresolved failures, keep them exact, and let resolved ones go.

**Lesson 6 (don't get few-shotted) — quietly held, least discussed.** The
observation that a context full of near-identical action/observation pairs makes
a model repeat the pattern past the point of usefulness has not been challenged,
but the field's preferred fix has shifted. Where the post injects controlled
variation into serialization and phrasing, the more common 2026 answer is
structural — give each unit of work a fresh or isolated context (subagents)
rather than de-patterning a shared one. Complementary, not contradictory.

**The company, for context on the source's authority.** Manus scaled
substantially over the year: **Wide Research** (announced July 2025) runs 100+
parallel subagents on a single task, which is lesson 3's context-isolation
corollary turned into a product; **Manus 1.5** (October 2025) and **1.6** (early
2026) followed, the former reported to cut average task completion time from
~15 minutes to under 4. Third-party estimates (Sacra) put revenue run-rate
around $125M as of December 2025 — an estimate, not a company disclosure. The
post's credibility as field-tested rather than speculative has, if anything,
strengthened.

## Summary — the six lessons, with terms defined as they arrive

Written for a reader who has used a chatbot but never built an agent. Every
technical term is defined where it first appears.

An **agent**, in the sense used here, is a loop rather than a single answer: the
model is given a goal and a set of **tools** (functions it can call — run a
shell command, fetch a URL, write a file), and it repeats a cycle of choosing a
tool, receiving that tool's result, and choosing again, until the goal is met.
Everything the model can see at any point in that loop — the instructions, the
tool descriptions, and the whole accumulated history of what it tried and what
came back — is its **context**. The context is a flat sequence of **tokens**
(the sub-word chunks models actually read), and it has a hard size limit, the
**context window**. A single Manus task averages around **50 tool calls**, so
that history gets long fast. **Context engineering** is the practice of
deciding what occupies that space and in what shape, as opposed to changing the
model itself.

The post's framing decision comes first, and it is a bet about the industry
rather than a technique: Manus chose to build **in-context** — shaping what goes
into a general-purpose model's context — rather than **fine-tuning** (further
training a model on your own task data to bake in the behavior). The reasoning
is shipping speed. A fine-tune couples every improvement to a retraining cycle
measured in weeks; an in-context change ships in hours. The author reports
rewriting the agent's framework **five times** in the months after launch, which
is only survivable if changes are cheap.

**1. Design around the KV-cache.** Each time a model generates a token it must
attend to every earlier token, which would mean re-processing the entire context
from scratch on every step. The **KV-cache** avoids that by storing the
intermediate values already computed for each token, so a new token only needs
the cached values plus its own work. Providers expose this as **prefix
caching**: if the beginning of your context is byte-for-byte identical to the
previous request, the cached computation for that prefix is reused, and you are
billed at a steeply discounted rate — on the model the post used, roughly a
tenfold difference between cached and uncached input tokens. The **KV-cache hit
rate** — what fraction of your input arrives cached — is therefore the metric
the post calls the single most important one for a production agent, because it
moves both latency and cost directly. It matters unusually much for agents
specifically because of their shape: an agent's context grows every turn while
its replies stay short, giving Manus roughly a **100:1 ratio of input to output
tokens**. Almost all the money is in the input, so almost all the savings are in
caching it. Three practical consequences follow. Keep the **prompt prefix**
(the system instructions and tool definitions at the very front) stable — the
cache matches on an exact prefix, so a single changed token, famously a
timestamp, invalidates everything downstream of it. Keep the context
**append-only**: add new turns at the end, never edit or reorder earlier ones,
since past actions and their results are part of the prefix for every future
step. And make your **serialization** — the conversion of structured data into
the text the model sees — **deterministic**, because many JSON libraries do not
guarantee stable key ordering, and a silently reshuffled key breaks the byte
match as thoroughly as a deliberate edit. When self-hosting, the post notes
enabling prefix caching in the inference server (**vLLM**, a widely used
open-source serving engine) and routing a conversation's requests consistently
via a session identifier so they land on a worker that actually holds the cache.

**2. Mask, don't remove.** As an agent gains capabilities, its tool list grows,
and the obvious instinct is to load only the tools relevant to the current step.
The post argues that dynamically adding and removing tool definitions mid-task
is a mistake for two reasons. First, cache: tool definitions sit near the front
of the context, so changing the set invalidates the cache for everything after
them. Second, coherence: the earlier history still *mentions* tools you have now
withdrawn, and a model asked to reconcile a transcript referencing a tool that
no longer exists will either get confused or emit a call that fails validation —
a **schema violation**, output that does not match the declared shape of any
available tool. The alternative exploits how generation actually works. At each
step the model produces **logits**, a raw score for every token in its
vocabulary, which are then converted into the probabilities it samples from.
**Logit masking** forces chosen tokens to be impossible by driving their scores
to negative infinity before sampling. So the full tool set stays in context
untouched — cache intact, history coherent — and availability is enforced at
decode time by masking the tokens that would begin a disallowed tool call. Two
supporting details: providers typically expose coarse modes over this (the post
cites the Hermes function-calling format's *auto* / *required* / *specified* —
the model may call a tool, must call one, or must call one from a named subset),
and a **response prefill**, seeding the beginning of the model's reply, narrows
the space further. This is where the post's advice on tool **naming** pays off:
give related tools a shared prefix (`browser_`, `shell_`) and constraining the
agent to a whole family becomes a prefix match on the first few tokens rather
than an enumeration. Manus decides which family is legal using a **state
machine** — a small piece of ordinary code tracking which phase the task is in
and which actions that phase permits — so the constraint logic lives outside the
model rather than being negotiated with it in the prompt.

**3. Use the file system as context.** Even a large context window is too small
for real work: a single fetched web page or PDF can consume a large fraction of
it, and the ceiling is not the only problem — model accuracy degrades well
before the window is full, and long input costs money even when cached. Naively
truncating or summarizing old turns to make room is dangerous, because an agent
cannot know which detail from step 6 will turn out to matter at step 40, and
information dropped by a summary is gone. The post's answer is to treat the
sandbox's **file system** as the agent's real memory: unlimited in size,
persistent across steps, and — the key property — *directly operable by the
agent itself*, since it already has read and write tools. This makes compression
**restorable**: drop a fetched document's body from the context but keep its
path or URL, and the agent can read it back on demand. Nothing is destroyed, so
aggressive shrinking stops being a gamble. The context becomes an index into
external memory rather than the memory itself. The post closes the section with
a speculation: **state-space models**, an architecture that processes sequences
by carrying a fixed-size running state forward instead of attending over the
whole history, are much cheaper on long sequences but historically weak at
recalling distant detail — and if externalized file memory removes the need to
hold that detail in-context, the architecture's weakness might stop mattering.

**4. Manipulate attention through recitation.** Over dozens of steps a model
tends to lose the thread — partly the **lost-in-the-middle** effect, the
well-documented tendency to attend more reliably to the beginning and end of a
long input than to its middle, so an objective stated once at the start
gradually stops steering behavior. Manus's fix is deliberately unsubtle: the
agent maintains a `todo.md` and **rewrites** it as it works, checking off
finished items and restating what remains. Because a rewrite appends to the end
of the context, the current goal is repeatedly re-injected into the most
recently attended region. This is **recitation**: using the agent's own output
to bias its attention toward the objective, with no change to the architecture
or the prompt — natural language pushed into recent context to keep the plan in
view.

**5. Keep the wrong stuff in.** Agents fail constantly — tools error, commands
return nonsense, the model hallucinates a call. The tempting cleanup is to strip
failures from the context and retry, leaving a tidy transcript. The post argues
this is actively harmful, because the failure *is* the signal: a model that can
see its stack trace updates its approach implicitly, while a model whose
mistakes were erased has no evidence anything went wrong and will cheerfully
repeat them. The stronger claim is definitional — **error recovery**, adapting
after a failed action, is one of the clearest indicators that a system is
genuinely agentic rather than merely executing a plan. Most benchmarks measure
success under ideal conditions and so miss it entirely. Hiding errors behind
retries or sampling tweaks treats the symptom and removes the information the
model needed.

**6. Don't get few-shotted.** **Few-shot prompting** — putting worked examples
in the context so the model imitates their pattern — is a foundational technique
for one-shot tasks, and a trap in a loop. An agent's context naturally fills
with near-identical action/observation pairs of its own making, which function
as few-shot examples whether or not you intended them: having done the same
thing nineteen times, the model does it a twentieth, even after it has stopped
being the right move. The failure modes the post names are **drift**
(sliding off the actual objective), **overgeneralization** (applying a pattern
outside where it works), and outright **hallucination**. The countermeasure is
controlled variation: vary the serialization templates, the phrasing, the
ordering — small deliberate noise that keeps the context from reading as a
rhythm to continue. As the post puts it, uniform context invites uniform
behavior.

## Key terms

- **[Context](/beliefs/glossary/context-window.md) / context window** — the
  token sequence a model sees when generating, and the hard limit on its size.
- **[KV-cache](/beliefs/glossary/kv-cache.md)** — stored intermediate attention
  values for already-processed tokens, so each new token is computed against the
  cache instead of re-processing the sequence.
- **[Prefix caching](/beliefs/glossary/prefix-caching.md)** — reusing that cache
  across requests when the start of the context matches exactly, billed at a
  discount; the exact-match requirement is what makes prefix stability
  load-bearing.
- **[KV-cache hit rate](/beliefs/glossary/kv-cache-hit-rate.md)** — the fraction
  of input tokens served from cache; the post's headline production metric.
- **[Append-only context](/beliefs/glossary/append-only.md)** — the discipline of
  only adding at the end, never editing earlier turns, so the cached prefix stays
  valid.
- **[Deterministic serialization](/beliefs/glossary/deterministic-serialization.md)**
  — emitting structurally identical data as byte-identical text (notably stable
  JSON key order), without which the cache silently misses.
- **[Logit masking](/beliefs/glossary/logit-masking.md)** — constraining
  generation by forcing chosen tokens' scores to negative infinity before
  sampling, restricting the action space without editing the context.
- **[Response prefill](/beliefs/glossary/response-prefill.md)** — seeding the
  start of the model's reply to constrain what can follow.
- **[Function calling](/beliefs/glossary/function-calling.md)** — the interface by
  which a model emits a structured request to invoke a declared tool; the
  post uses the Hermes format's auto/required/specified modes as the coarse
  control layer over masking.
- **[vLLM](/beliefs/glossary/vllm.md)** — the open-source inference server named
  as where you turn prefix caching on when self-hosting.
- **[Context offloading](/beliefs/glossary/context-offloading.md)** — moving bulky
  content out of the context into external storage (here, the sandbox file
  system) and keeping only a reference, making compression restorable.
- **[Agent memory](/beliefs/glossary/agent-memory.md)** — the durable store an
  agent reads and writes across steps; the file system in this post's design.
- **[Lost-in-the-middle](/beliefs/glossary/lost-in-the-middle.md)** — degraded
  attention to material in the middle of a long input relative to its start and
  end; the failure recitation counters.
- **[Recitation](/beliefs/glossary/recitation.md)** — repeatedly rewriting the
  plan into the end of the context so the objective stays in the recently
  attended region.
- **[Error recovery](/beliefs/glossary/error-recovery.md)** — adapting behavior
  after a failed action, which the post treats as a defining marker of agentic
  behavior rather than an edge case.
- **[Few-shot prompting](/beliefs/glossary/few-shot-prompting.md)** — supplying
  worked examples to induce imitation; in a loop the agent's own history becomes
  an unintended example set.
- **[State-space model](/beliefs/glossary/state-space-model.md)** — a sequence
  architecture carrying a fixed-size running state instead of attending over full
  history; cheap on long sequences, weak on distant recall, and the subject of the
  post's closing speculation.
- **[Context compaction](/beliefs/glossary/context-compaction.md)** — periodic
  pruning or summarization of accumulated context; the practice that later
  qualified lesson 5.
- **[Deferred tool loading](/beliefs/glossary/deferred-tool-loading.md)** —
  withholding tool definitions from context and retrieving them on demand; the
  2025-11 mechanism that superseded lesson 2's specific advice while preserving
  its invariant.
- **[Context isolation](/beliefs/glossary/context-isolation.md)** — giving each
  unit of work its own context, typically via subagents; the field's preferred
  answer to lesson 6 and the basis of Manus's Wide Research.

## Technical summary

Manus is built as an in-context agent over frontier models rather than a
fine-tune, on an explicit shipping-velocity argument: framework iteration
(five rewrites post-launch) decouples from model retraining. The post derives six
operational rules from that stance.

**KV-cache hit rate is the primary production metric**, justified by the agentic
token profile — an input:output ratio near 100:1 over an average ~50 tool calls
per task, with an order-of-magnitude cached/uncached input price delta. This
makes three invariants mandatory: byte-stable prompt prefix (no per-request
timestamps or other prefix churn), append-only context (no retroactive edits to
prior actions or observations), and deterministic serialization (stable JSON key
ordering). Self-hosted deployments enable prefix caching in vLLM and pin
sessions to cache-holding workers via a session identifier.

**Tool availability is enforced at decode time, not in the context.** Because
tool definitions occupy the cached prefix and prior turns reference them
anyway, mutating the tool array both invalidates cache and induces schema
violations. Manus instead keeps definitions static and applies logit masking —
`-inf` on disallowed token paths — layered over the Hermes format's
auto/required/specified modes and response prefill, with a context-aware state
machine outside the model computing the legal action set per phase. Consistent
tool-name prefixes (`browser_`, `shell_`) reduce family-level constraints to
prefix matching.

**The sandbox file system is the memory tier.** Window ceilings, pre-ceiling
accuracy degradation, and per-token cost on long input make in-context retention
untenable; irreversible truncation/summarization is rejected because relevance
is not predictable at drop time. The design keeps compression **restorable** —
evict payloads, retain paths and URLs — reducing the context to an index over
externalized state. The post speculates that state-space models, whose weakness
is long-range in-context recall rather than throughput, could become viable
agent backbones if file-based memory absorbs that requirement.

**Attention is steered by recitation.** A continuously rewritten `todo.md`
re-emits the global plan into the context's tail on every update, mitigating
lost-in-the-middle drift over long horizons through output rather than
architecture or prompt changes.

**Failure evidence is retained.** Failed actions, observations, and stack traces
stay in context so the model implicitly updates its priors; error recovery is
framed as a defining agentic capability that ideal-conditions benchmarks fail to
measure, and retry/temperature manipulation is rejected as symptom-treatment
that discards the informative signal.

**Uniform context is treated as an attack surface on the model's own
behavior.** Self-generated homogeneous action/observation sequences act as
unintended few-shot demonstrations, producing drift, overgeneralization, and
hallucination; the mitigation is injected structural diversity across
serialization templates, phrasing, and ordering.

As of 2026-07, four rules stand unmodified, lesson 2's mechanism has been
superseded by deferred tool loading (which satisfies the append-only invariant
it was protecting), and lesson 5 has been refined to "retain unresolved failures
verbatim, retire them once resolved" under the compaction practices that
followed. See the currency check above.

## Relation to other captures

Reaches the same conclusions as Anthropic's
[Effective context engineering for AI agents](/knowledge/SWE/agentic/agentic-loop/effective-context-engineering-for-agents.md)
from the application side, roughly ten weeks earlier — that essay's compaction,
structured note-taking, and sub-agent techniques map onto lessons 3, 4, and the
2026 answer to 6. The
[Context Editing API and Memory Tool](/knowledge/SWE/agentic/context-engineering/claude-context-editing-and-memory-tool.md)
productize lessons 1 and 3 as API primitives.
[Context rot](/knowledge/SWE/agentic/context-engineering/context-rot-chroma-research.md)
supplies the empirical basis for lesson 3's claim that accuracy degrades before
the window fills, and for why larger windows did not obsolete it.
[AI agent memory management — when markdown files are all you need](/knowledge/SWE/agentic/context-engineering/ai-agent-memory-management-markdown-files.md)
documents the independent convergence on lesson 3's file-based memory, Manus
included.
[Conversation tree architecture](/knowledge/SWE/agentic/context-engineering/conversation-tree-architecture.md)
and
[routing non-linear work sessions](/knowledge/SWE/agentic/context-engineering/routing-non-linear-work-sessions.md)
attack lesson 6's uniformity problem structurally, by separating contexts rather
than de-patterning one.

# Citations

Yichao 'Peak' Ji, "Context Engineering for AI Agents: Lessons from Building
Manus", Manus blog, 2025-07-18 —
<https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
(also published on Medium —
<https://medium.com/@peakji/context-engineering-for-ai-agents-lessons-from-building-manus-71883f0a67f2>)

Currency-check sources, researched 2026-07-25:

- Anthropic, "Tool search tool", Claude Platform Docs —
  <https://platform.claude.com/docs/en/agents-and-tools/tool-use/tool-search-tool>
- Lance Martin, "Context Engineering in Manus", 2025-10-15 —
  <https://rlancemartin.github.io/2025/10/15/manus/>
- "Manus: Context Engineering for Production AI Agents at Scale", ZenML LLMOps
  Database — <https://www.zenml.io/llmops-database/context-engineering-for-production-ai-agents-at-scale>
- "Governance Decay: How Context Compaction Silently Erases Safety Constraints
  in Long-Horizon LLM Agents", arXiv — <https://arxiv.org/pdf/2606.22528>
- "Less Context, Better Agents: Efficient Context Engineering for Long-Horizon
  Tool-Using LLM Agents", arXiv — <https://arxiv.org/pdf/2606.10209>
- VentureBeat, "Manus is launching 'Wide Research' that spins up 100+ agents" —
  <https://venturebeat.com/ai/youve-heard-of-ai-deep-research-tools-now-manus-is-launching-wide-research-that-spins-up-100-agents-to-scour-the-web-for-you>
- Sacra, "Manus revenue, funding & news" (third-party revenue estimates) —
  <https://sacra.com/c/manus/>
- AI21, "Attention was never enough: Tracing the rise of hybrid LLMs" —
  <https://www.ai21.com/blog/rise-of-hybrid-llms/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:b4440a">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-25-manus-context-engineering-intake-and-currency-check (2026-07-25)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:b4440a`]**

Pushed. Here's what landed.

**Your question about the "analysis" skill**

There isn't one — that's a conflation of three things:

- **`/summarize-technical`** is the skill for technical articles. It produces a three-part layered breakdown: plain-language summary → key terms → technical summary reusing those terms. `/intake` calls it automatically for substantial technical sources.
- **`type: analysis`** is a *document type* (not a skill) for point-in-time evaluations under `meta/analysis/` — a question investigated against evidence, yielding a recommendation.
- **`/elaborate`** is the phrase-scale sibling: it unpacks one technical mouthful rather than a whole document.

For an aging assessment there's also an established in-bundle pattern I followed rather than inventing one: a **`## 2026 currency check`** section inside the reference doc itself, as used in [effective-context-engineering-for-agents](https://ob6to8.github.io/elixir-mind/knowledge/SWE/agentic/agentic-loop/effective-context-engineering-for-agents.html).

**What I filed**

[**context-engineering-lessons-from-manus.md**](https://github.com/ob6to8/elixir-mind/blob/claude/article-intake-aging-analysis-t4nwxp/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md) (`em:b4440a`, `type: reference`), promoted from the survey-tier bookmark row you'd already parked.

One framing note: rather than reproduce the article with insertions, I wrote the walkthrough as original distilled prose covering all six lessons with every term defined inline at first use — which is what the brain's own "capture the knowledge, cite the source" rule requires anyway, and keeps us clear of reproducing the source. Short quotes only where Ji's exact coinage matters; both URLs cited.

**Currency check (researched today, 12 months on).** The headline: nothing refuted, four lessons unmodified, but two moved.

- **Lesson 2 ("mask, don't remove") is the big one.** Its rule was *never mutate the tool array mid-loop*. Anthropic's Tool Search Tool (Nov 2025) with `defer_loading` does exactly the forbidden thing — ~85% fewer tool-definition tokens, MCP evals 49%→74% (Opus 4) and 79.5%→88.1% (Opus 4.5). The reconciliation is the interesting part: deferred loading *appends* definitions instead of rewriting the prefix, so it honors Ji's real invariant while breaking his literal instruction. Read it today as "never *edit* what the cache has seen." This session runs deferred tool loading, so the demonstration is right here.
- **Lesson 5 ("keep the wrong stuff in") is genuinely qualified** — it's in direct tension with compaction. Current consensus: keep failures *verbatim while task-relevant*, retire once resolved. "Verbatim" is load-bearing — paraphrasing a concrete error string destroys the agent's ability to match on it.
- Lesson 3 is the most vindicated (Memory Tool, markdown-file convergence); its SSM speculation is playing out only as *hybrid* attention/state-space architectures, not file-native agents. Lesson 4 became a product feature. Lesson 6 held, but the field's fix shifted from serialization noise to subagent isolation.

**Glossary**

**19 new entries** — the brain turned out to have a real hole in core LLM-plumbing vocabulary (no `context window`, no `context engineering`, no `fine-tuning`): kv-cache hit rate, prefix caching, logit masking, response prefill, context window, lost-in-the-middle, recitation, context offloading/isolation/compaction, deferred tool loading, error recovery, few-shot prompting, state-space model, deterministic serialization, vLLM, context engineering, fine-tuning, in-context learning.

**5 merged** with new citations and cross-links: kv-cache, function calling, append-only, agent memory, context rot.

Gates all clean — `verify`, `glossary --materialize`, `route_tags`, `registry`, `contract`. Dedup-probe plain recall unchanged at 5/14, no regression; no gold row harvested since the intake carried a URL rather than a subject phrasing in your words.

No PR opened — say the word (or `/create-pull-request`) if you want one.
