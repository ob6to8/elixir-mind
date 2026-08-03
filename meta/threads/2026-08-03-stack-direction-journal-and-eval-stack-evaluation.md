---
type: reference
title: 2026-08-03-stack-direction-journal-and-eval-stack-evaluation
description: The operator files a hybrid journal entry — a snapshot of the stack-and-direction decision, the Claude Code app workflow pulling toward all-in Anthropic adoption against the BEAM's fit for agent-swarm evals — and commissions a pros-and-cons evaluation; the session files it per /journal with the two-part response persisted, grounded in the standing BEAM/Jido, agent-teams, and Inkling swarm-eval analyses, and recommends keeping the brain in Elixir, developing in the app, and building the eval instrument on the BEAM with Anthropic's surfaces as subjects and adapters.
provenance: "Claude Code session (Claude Fable 5), 2026-08-03; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [thread, journal, stack-direction, beam, evals]
timestamp: 2026-08-03
session: https://claude.ai/code/session_01ENUwpNe88mYwwE4JmbjhNs
---

# 2026-08-03-stack-direction-journal-and-eval-stack-evaluation

A journal session: the operator dictated a stack-and-direction snapshot — the
integrated Claude Code app workflow (matters, the register queue, sandboxed
VMs, persisted threads) pulling toward going all-in on the Anthropic ecosystem,
against a stated preference for Elixir and the BEAM's fit for agent-swarm
evals — and, inside the same entry, commissioned a read-up of the repo's
material and a pros-and-cons evaluation of the two eval-stack scenarios. The
session filed the entry at [journal/2026-08-03.md](/journal/2026-08-03.md) per
`/journal` (mechanical cleanup only; one dropped-word fix reported), read the
standing analyses (the BEAM/Jido evaluation, the managed-agents and agent-teams
comparisons, the Jido caveats, the Inkling swarm-eval substrate spike and its
ratified harness plan, the bias-taxonomy plan), and delivered the two-part
response — editorial read, then the evaluation — persisted verbatim under the
entry's `## Response` heading. The evaluation's shape: the decision decomposes
into development harness (settled — the app), analysis layer (Python behind the
plan's JSONL boundary), and the instrument, where instrument neutrality,
determinism/replay, and reversibility asymmetry favor the BEAM path already
ratified in the harness plan, with Anthropic's multi-agent surfaces treated as
subjects and adapters rather than the apparatus. Three questions were left
open for the operator; the entry landed in one commit with gates green, and
the operator closed with `/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| The 2026-08-03 journal entry, filed with its two-part response | closed | [journal/2026-08-03.md](/journal/2026-08-03.md) | - |
| Eval-instrument stack decision (BEAM/OTP vs Anthropic-native) | open | [journal/2026-08-03.md](/journal/2026-08-03.md) | the three carried-forward questions: models-in-swarms or the Claude product; cross-vendor subjects in year one; outsider reproducibility |

## User

/journal the last journal entries have been oriented towards technical writing and program design, and have been more abstract and high level. i considered entering the following as a normal prompt and having it land as an analysis, but i think its more useful as a journal entry - a snapshot of a time and decision about the stack and direction, and even the purpose of the repo. as a result, this is a bit of a hybrid of expository writing and direct requests for action by you, the agent

first, read up in this repo about the beam evals testing swarm behaviors, running jido 2, calling inference via api, either to the claude agents sdk or to some other model

then consider this repo and that its elixir

then consider an alternate scenario, where this repo is written in another more common language, say javascript or python, but the goals are generally the same - build and maintain a knowledge system and development methodology with a focus on checkable determinism, guarantees, guardrails, DRY, and running evals, specifically working with cognitive biases and their applications to agents, and specifically, agent swarms

as i work with the claude code app on a deeper level I am drifting further from seeing why I might want to continue to work locally, whether warp or zed or herdr, at least for what I'm doing. I have a strong flow going with the app and ui, specifically in managing threads. It is working quite well with the new move to matters and the matter registry queue, and now scoping a pr to only be the unit of work plus follow up matters for revisions, this all being in an archivable thread that can be grouped in the app sidebar and persisted, as well as correlated directly to the claude app therad with the git trailer,.

also, each unit of work occurring in a sandboxed vm that is provisioned and torn down with no friction, it has become a seemless part of my workflow I have come to expect, and it has grown increasingly elegant. whereas before i would seem to need to wrangle the agent to get Elixir installed correctly, it now is able to do it pretty my flawlessly every time.

some detail on the claude app from a research spike:

"Cloud persistence and remote access, natively. The cloud runtime (CCR) maps each session to an operator-defined environment, provisions a VM from a per-environment filesystem snapshot, and — per the official docs quoted in this bundle's grounded note — "Cloud sessions stop after a period of inactivity and the underlying environment is reclaimed" (Claude Code cloud (CCR) — environment and orchestration architecture, em:52aefa, verified: false — grounded against Anthropic's docs but still carrying unverified forensic detail). So cloud persistence is real but bounded — reclaimed on inactivity — unlike herdr's own-server session, which stays alive as long as the operator's box does.

Background/remote control surface, observed directly this session. This session's own tool roster is itself evidence: scheduled wake-ups (ScheduleWakeup, CronCreate), a Monitor tool for streaming background process events, and mcp__Claude_Code_Remote__* tools for creating, listing, firing, and updating Routines (scheduled triggers that resume a session or spawn a fresh one) — Anthropic's own answer to "reattach and get notified remotely," architecturally distinct from herdr's SSH/thin-client reattachment but functionally adjacent."

so my development workflow is feeling quite integrated, and I do not miss the days of working locally, managing dependencies, dealing with the clunky aspects of the claude code tui, the far inferior nature of the ui, the concerns about permissions and security or needing to handle sandboxing myself, or the ephemeral nature of the threads themselves outside of the locally created jsonl, which I am not interested in trying to persist manually in a way that would mirror what the claude code app does

this workflow may be developed in order to trap me in the anthropic ecosystem, but if it continues apace, it may not be the worst place to be "trapped". I am starting to look at it like AWS vs bare metal, or vercel vs aws - a host of technical concerns removed, and in this case, pro-rated as anthropic seemingly seeks to penetrate the enterprise market by driving adoption.

alongside the certifications they have announced, and the depth of the claude agents sdk, along with the following feature:

"Multi-agent coordination, Claude-only. Agent teams (experimental) let several full Claude Code sessions coordinate as peers through a shared, file-locked task list and JSON mailboxes, messaging each other by name and remaining individually steerable by the operator (Claude Code agent teams, em:33e0c7). This is Claude Code's structural analog to herdr's multi-pane view — but it coordinates only Claude Code instances; there is no documented surface for teaming a Claude Code session with a Codex or Cursor session the way herdr's panes can sit side by side regardless of vendor."

is making me start to think that I need to more aggressively justify WHY I would not go all in on developing completely in the claude ecosystem, and possibly, porting this repo, and focus on eval, in js or python.

I can imagine running agents in herdr, working with different providers and harnesses, and emulating the sandboxed vm approach of the claude app by using fly.io or something like shellbox, for development, and there are advantages:

"Claude code extensibility is prompt/config-level, not session-level. Hooks, skills, subagents, MCP servers, and slash commands extend what one agent does; none of them multiplex a different agent binary the way herdr's plugin ecosystem and socket API do." And, I would add, having total control over the sandboxed vms

I think the question here is: "are the advantages of multiplexing different agent binaries one that I should weigh favorably against the unified convenience of adopting the anthropic ecosystem." which leads to, "well what are you going to do that may or may not need the flexibility of that approach." and, to be fair, I don't really know yet how much my general trajectory of focusing on evals will affect that answer.

I prefer Elixir, and there is no question in anyone's mind (that I've seen) that the beam is the superior technical substrate for agents. and it certainly seems like there are compounding advantages to running agentic swarm evals on it, vs less naturally suitable stacks.

the question becomes, how do the size of the respective ecosystems, and the infrastructural questions that come with it, affect the decisionmaking process.

imagine running evals in Elixir using Jido 2 components on the beam, accessing inference via the anthropic messages api (i assume) and handrolling everything else. or imagine running the same evals in the anthropic ecosystem, focusing on the new multi-agent coordinating features, working in python or js using the claude agents api.

help me evaluate the pros and cons of either approach

## Assistant

The claude-api reference confirms the harness/deployment split I need (Agent SDK = harness-only, Python/TS; CMA = harness+deployment; Messages API = one endpoint). Two quick checks — where the entry's quoted spike passages live, and the exact persisted-response heading format used in earlier journal files — then I'll write.

No filed document matches the spike's distinctive phrases — the quoted research spike lives only in a session, which is relevant for the editorial read. I have everything needed. Writing today's journal file now: the entry transcribed with only mechanical cleanup, then the two-part response persisted beneath it.

Filed and pushed. The entry is at [journal/2026-08-03.md](https://github.com/ob6to8/elixir-mind/blob/claude/stack-workflow-architecture-rpl314/journal/2026-08-03.md), transcribed faithfully with mechanical cleanup only (casing of proper nouns and acronyms, typo fixes: "therad" → "thread", "seemless" → "seamless", stray `,.` → `.`). One cleanup was more than mechanical and you should know the reading I chose: **"it now is able to do it pretty my flawlessly"** → **"pretty much flawlessly"** — the only plausible intent I could see; say the word if you meant something else. Your pasted spike quotes are untouched, including their inner casing. The response below is persisted verbatim under the entry's `## Response — Claude (2026-08-03)` heading.

---

In plain terms before the detail: the entry frames one big choice — go all-in on Anthropic's ecosystem, or build the eval work in Elixir. My read after doing the requested review is that it is actually three choices, two of which are already settled, and the repo's own filed analyses have largely adjudicated the third. The workflow you love (the Claude Code app) and the substrate the evals should run on (the BEAM) are separable — you can keep both — and the strongest argument for the Elixir side is one the entry itself supplies: for a research practice about agent biases, the multi-agent fabric is the measuring instrument, and an instrument that only measures one vendor's agents cannot answer a vendor-general question.

## Editorial read

The entry's most persuasive material is testimony rather than argument: "provisioned and torn down with no friction," "I do not miss the days of working locally," the Elixir setup that now works "pretty much flawlessly every time." That is revealed preference, concrete and datable — exactly what a snapshot entry is for. And "it may not be the worst place to be 'trapped'" is the thesis in one clause; the scare quotes carry the ambivalence more honestly than a paragraph of hedging would.

The question is posed three times, and the formulations are not equivalent. First: "are the advantages of multiplexing different agent binaries one that I should weigh favorably against the unified convenience of adopting the Anthropic ecosystem" — a values question. Then: "well what are you going to do that may or may not need the flexibility of that approach" — the load-bearing empirical question, which the entry answers with admirable honesty ("I don't really know yet"). Then: "how do the size of the respective ecosystems … affect the decision-making process" — a cost question. By the closing paragraphs the third has quietly stood in for the second. The second is the decision variable; naming that would sharpen the close, because ecosystem size only matters once you know which layers of the work it touches.

The AWS/bare-metal and Vercel/AWS analogy carries the pro-adoption case, and it has a hidden premise: that the adopted thing sits *under* the differentiated work, the way a hosting substrate sits under an application. Two paragraphs later the entry quotes the disanalogy without marking it as one: agent teams "coordinates only Claude Code instances." Hosting does not change your experimental results; the coordination fabric of a swarm eval does — it is the apparatus, not the rack it sits in. The entry contains both halves of this collision and files them in separate paragraphs.

One conflation blurs the middle: "porting this repo … in JS or Python." Two artifacts travel under "this repo": the brain (a markdown bundle plus a small, proven Elixir toolchain) and the eval system (which does not live here yet — the projects namespace is designed precisely for it to incubate and break out). The porting question is real only for the second, and the second is not yet written in any language. Similarly, the workflow praise concerns the *development harness* while the stack question concerns the *runtime substrate* of the evals; the entry treats them as one decision, and most of the felt tension dissolves once they are split.

A craft note on the hybrid form: it works, and the pasted spike passages are cleanly fenced. One archival observation — a grep across the bundle for two of the spike's distinctive phrases ("Multi-agent coordination, Claude-only", "prompt/config-level") finds no filed document, so within that search space this entry is the spike's only durable record. That retroactively strengthens the choice to file it as a journal snapshot rather than leave it in chat.

## Substantive follow-up

**What the repo already holds.** The read-up you directed turns out to be substantial — five analyses and a ratified plan bear directly on tonight's question, written across three weeks of exactly this deliberation:

- **The BEAM/Jido 2 base evaluation** — the standing "not now" for the *brain's* runtime, with the tiered future path and the verified Jido 2 baseline (single reducer, `AgentServer`, Elixir 1.17+/OTP 26+ floor).
- **Managed minds, owned machinery** — the two-plane rule: "rent the minds, own the machinery," with the owned write-gatekeeper at the seam.
- **The agent-teams comparison** — agent teams read structurally: "a hand-rolled actor system built from JSON files, file locks, and terminal panes, with no runtime underneath." Its verdict is by regime: "Unattended, standing, event-reactive, or dense → BEAM/Jido," a regime it calls "outside agent teams' design envelope entirely — not weakly served, unserved."
- **Jido's two structural caveats** — single-node ceiling; `req_llm` as one throat for all cognition.
- **The Inkling/BEAM swarm-eval spike and its ratified plan** — a designed four-layer stack (OTP harness, deterministic inference, Python training behind a JSONL boundary) with an M0–M5 build ladder, M0 committed. Two design points matter tonight: "Jido itself is optional at this scale; plain OTP suffices for a first build," and the HTTP client is Req/Finch — the harness deliberately takes no LLM-framework dependency.
- **The two-sided bias taxonomy plan** — the research program the eval work would serve, whose D1 requires the agentic register to hold "strictly agent evidence" with a controlled evidence base.

**The decision decomposes into three, and two are settled.** (1) The *development harness* — where you and the agents do the work — is the Claude Code app, settled by your own revealed preference, and it is indifferent to the repo's language: this session developed an Elixir repo end-to-end inside it. (2) The *analysis and training layer* is Python regardless — the inkling plan already draws that boundary as two file formats (JSONL out, adapters in), so the Python ecosystem's stats and training tooling is available without the instrument being Python. (3) The open question is only the *instrument*: the thing that spawns swarm members, wires their topology, injects faults, records every message, and replays trajectories.

**The head-to-head, on the instrument only:**

| Axis | BEAM/OTP instrument (inference via API) | Anthropic-native (Agent SDK / agent teams, Python or JS) |
|---|---|---|
| Subjects it can measure | any HTTP-reachable model or agent binary — Claude, open weights, other vendors | Claude only (agent teams coordinates only Claude Code instances; the Agent SDK is Claude Code as a library) |
| Topology as experimental variable | supervision trees, router seam, arbitrary graphs — the independent variable is yours | one flat team, fixed lead, no nesting |
| Determinism and replay | own scheduler, seeds, message log; bitwise replay attainable with owned inference | stochastic harness on a moving experimental surface; no replay |
| Fault injection | native (`Process.exit/2`, suspend, delay, partition) | none documented |
| Trace capture | every inter-agent message by construction | session transcripts and file mailboxes, session-scoped |
| Build cost | HTTP client + tool loop + trace store + scorers, handrolled | near zero — the coordination ships free |
| Free harness features | you own everything | context management, tools, sandboxes, permissions, teams, all evolving without your effort |
| Ecosystem depth | thin (Req/Finch; Jido optional; stats exported to Python) | deep — eval frameworks, reference implementations, worked examples (from memory, unchecked: inspect-ai and its peers are all Python) |
| Drift exposure | Messages API, the stablest surface Anthropic ships | agent teams is experimental and, per the filed analysis, "moving version-by-version" |

Three arguments decide it for me, given your stated research focus.

*The instrument argument.* Your subject is cognitive biases in agents and swarms — a claim about agents in general. Agent teams can only convene Claude; an instrument built on it measures "biases of Claude swarms under Anthropic's coordination fabric," with model behavior and harness behavior confounded in every observation. The bias plan's own D1 — separate registers, strict evidence bases — is a demand for controlled provenance that a black-box, single-vendor apparatus cannot supply. The entry's multiplexing question answers itself here: for this research, multiplexing agent binaries is sample diversity in the study population, and it belongs on the instrument-requirements list rather than the convenience list.

*The determinism argument.* "Checkable determinism" is in your own statement of the goals. The inkling analysis is blunt about where that lives: replay-and-ablate "is the product — it is what no closed-API swarm setup can offer." CCR sessions are reclaimed on inactivity; agent teams is experimental with documented races; even perfect model-side determinism would be laundered through a harness you cannot pin. An owned OTP harness pins the harness half today and, with owned inference (the Inkling path), the model half too.

*The asymmetry argument.* The two paths are not symmetric in reversibility. An Elixir instrument can take Anthropic's products as *subjects*: everything on that side is reachable over HTTP from any language — the Messages API directly (your assumption is right, and checked against the bundled claude-api reference: it is one endpoint, `POST /v1/messages`, tools included, so the "handrolled" agent loop is a small HTTP loop, with the SDK's tool-runner conveniences as the main thing forgone since the official SDKs have no Elixir), and equally Claude Code headless or Managed Agents sessions driven as eval subjects from the harness. So the BEAM path keeps the Anthropic surfaces available as adapters and subjects — including measuring agent teams itself as an artifact under test. The reverse migration — an instrument built inside agent teams' shape later gaining vendor neutrality, owned topology, or replay — is a rewrite. Meanwhile the certifications and enterprise push you cite raise the value of *knowing* those surfaces, which the subjects-and-adapters posture preserves in full.

**The honest cons of the Elixir path**, so the recommendation isn't a cheerleading exercise: you write and maintain the loop, the trace store, and the scorers yourself; the reference implementations, eval-set formats, and worked examples in the literature are Python (from memory, unchecked) and you will occasionally reimplement one; Jido 2 remains young with the two filed caveats, which is exactly why the ratified harness plan makes it optional and starts from plain OTP; and if the eval subjects ever need to *execute code* at scale, sandbox provisioning becomes your problem — though for M0–M3 the swarm members are API calls, and rented sandboxes (CCR, Managed Agents, Fly-style machines — the last from memory, unchecked) can be driven from the harness when that day comes.

**When the answer flips.** If the research question narrows from "models-in-swarms" to "the Claude product line's swarm behavior as deployed" — an ecologically valid study of the artifact people actually run — then the Anthropic ecosystem *is* the instrument, Python/TS is the right glue, and the BEAM adds a layer of unrepresentative machinery. The same holds if distribution becomes a goal: evals meant for others to reproduce ship easiest in Python. Those are the conditions to watch, and they are empirical, which is why your "I don't really know yet" on question two is the honest crux.

**Bottom line.** Keep the brain in Elixir — porting a markdown bundle plus a working, gated toolchain buys nothing and forfeits a proven verifier. Keep developing in the Claude Code app — that decision is orthogonal and already made in practice. Build the eval instrument on the BEAM per the plan this repo already ratified, starting at M0, with inference over plain HTTP (Messages API for Claude subjects, OpenAI-compatible endpoints for open weights) and Anthropic's multi-agent surfaces treated as subjects and adapters rather than as the apparatus. This is also what the repo's own layered verdict already concluded from the other direction: the agent-teams analysis assigns attended, session-scoped work to Anthropic's fabric and the unattended, dense, event-reactive regime to the BEAM — and a thousand-rollout swarm eval is the second regime almost by definition.

Questions worth carrying forward: (1) Is the object of study models-in-swarms or the Claude product? — this single answer settles most of the rest. (2) Will the first year of eval work need non-Claude subjects, and which ones? (3) Do you want the evals reproducible by outsiders, and if so, does that pressure the instrument's language or only its artifact formats?

---

**What I created**

| type | doc | why this type |
|---|---|---|
| `note` (journal) | [journal/2026-08-03.md](https://github.com/ob6to8/elixir-mind/blob/claude/stack-workflow-architecture-rpl314/journal/2026-08-03.md) | dated operator entry per `/journal`; response persisted beneath it under the marked heading |

**What I modified**

| file | thrust of the change |
|---|---|
| `journal/index.md` | new entry listed first with its one-line description |

**Actions I have taken**

| action | result |
|---|---|
| Read-up per the entry's directive | six core docs read: the BEAM/Jido evaluation, managed-agents and agent-teams comparisons, the Jido caveats, the Inkling swarm-eval spike + plan, the bias-taxonomy plan; current Agent SDK/Messages API facts checked against the bundled claude-api reference |
| `mix brain.verify` | green — "ids, edges, and grounding all check out" (advisory warnings pre-existing, in `meta/evals/`, untouched) |
| Commit + push | `5e084d0` on `claude/stack-workflow-architecture-rpl314`, full pre-commit gate suite green (211 tests, 0 failures) |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Graduate tonight's evaluation into a filed `analysis` | `/scope-unit-of-work` (or ask directly) — the journal response stays as-is; an analysis doc would make the judgment citable from plans and give it an `em:`-linkable home |
| 2 | Answer the three carried-forward questions | a follow-up entry or chat turn; answering (1) alone — models-in-swarms vs the Claude product — settles most of the stack question |
| 3 | Start the eval work where the repo already pointed | the inkling harness plan's M0 (determinism canary) is the committed first rung and needs only a budget ceiling from you |
| 4 | Nothing further | the snapshot stands as filed |

## User

/create-pull-request merge
