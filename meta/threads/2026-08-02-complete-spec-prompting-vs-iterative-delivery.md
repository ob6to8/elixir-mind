---
type: reference
title: 2026-08-02-complete-spec-prompting-vs-iterative-delivery
description: A GitHub-task session asked to evaluate complete-spec prompting against this repo's iterative methodology; the referenced prompt never arrived, so the evaluation ran at genre level with verified industry sources and landed as the complete-spec-prompting-vs-iterative-delivery analysis, delivered with three packet-level fold-in options.
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, methodology, specs, planning, matters, industry]
timestamp: 2026-08-03T21:05:00Z
session: https://claude.ai/code/session_01AVyQKcCnhpi7YjPdJuX8mR
---

# 2026-08-02-complete-spec-prompting-vs-iterative-delivery

## Where this landed

A cloud GitHub-task session: the operator asked how submitting a complete-spec
prompt — one up-front artifact with declared boundaries and invariants —
compares to this repo's iterative approach, across pros and cons, industry
standing, best practices, scenario-dependence, and what the genre could fold
into the workflow here. The referenced prompt's text never arrived with the
task, so the session scoped that finding (task text, working tree, session
branch, open issues, journal/inbox/survey), verified the industry evidence
from primary sources (Thoughtworks Radar and insights, GitHub Spec Kit, AWS
Kiro docs, Anthropic's Claude Code best practices), and filed the evaluation
as [the complete-spec-prompting-vs-iterative-delivery analysis](/meta/analysis/complete-spec-prompting-vs-iterative-delivery.md)
— finding neither approach industry-dominant, the choice scenario-dependent
along five axes, this repo already the hybrid both camps converge toward, and
three packet-level fold-in candidates led by standard `Deliver`/`Verify`/`Out
of scope` matter fields. After the delivered report the branch was synced
with `origin/main` (clean merge, PRs #238–#242) and the session closed via
`/create-pull-request`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Complete-spec prompting vs. this repo's iterative delivery — the evaluation | closed | [complete-spec-prompting-vs-iterative-delivery](/meta/analysis/complete-spec-prompting-vs-iterative-delivery.md) | - |
| The referenced prompt's text (absent from the task) | paused | [complete-spec-prompting-vs-iterative-delivery](/meta/analysis/complete-spec-prompting-vs-iterative-delivery.md) | operator to paste the prompt; the analysis takes a prompt-specific addendum in place |
| Packet-level fold-ins (matter `Deliver`/`Verify`/`Out of scope` fields; plan out-of-scope clause; task-scoped invariants line) | open | [complete-spec-prompting-vs-iterative-delivery](/meta/analysis/complete-spec-prompting-vs-iterative-delivery.md) | operator ratification — which, if any, to scope as matters |

## User

analyze the following prompt against what you see in this repo. evaluate the philosophy and methodology of submitting a prompt like this, a complete spec, compared to the more iterative approach taken in this repo. what are pros and cons of each, is either approach dominant vs the other in the industry, what are the best practices of each, and is it a scenario dependent call or is one approach generally thought to be better than the other. lastly, is there anything that could be learned from this prompt, the way it is structured, the declaration of boundaries and invariants etc that could be folded into the workflow here

## Assistant

The work is complete — analysis filed, gated, and pushed. Here is the full report.

---

**Orientation, in plain terms.** Your message references "the following prompt," but no prompt text arrived with the task — it ends at your questions. I searched everywhere it could plausibly have landed before concluding that, then ran the evaluation at the level your description pins down: a complete-spec prompt with declared boundaries and invariants, read against this repo's actual machinery. I verified the industry evidence from primary sources (Thoughtworks Radar, GitHub Spec Kit, AWS Kiro docs, Anthropic's Claude Code guidance), and filed the whole evaluation as a durable analysis document in the brain — committed and pushed on the session branch: [complete-spec-prompting-vs-iterative-delivery](https://github.com/ob6to8/elixir-mind/blob/claude/spec-vs-iterative-analysis-7v6ggq/meta/analysis/complete-spec-prompting-vs-iterative-delivery.md). The short version: the industry treats spec-first vs. iterative as a dial, not a contest with a winner; this repo already sits at the hybrid position both camps are converging on; and the genre still has one thing to teach the workflow here — every unit of work declaring, in its own artifact, how its deliverer knows it's done and where its edges are. Paste the prompt whenever convenient and I'll extend the same doc with a prompt-specific read.

Your questions, answered in order:

> analyze the following prompt against what you see in this repo

The prompt text did not reach me. Scope of that finding: the task description as delivered ends at your question; the working tree was clean with no untracked file; the session branch pointed at the same commit as `main` (`075dc82`); the repo has zero open GitHub issues; and a grep over `journal/`, `inbox/`, and `survey/bookmarks.md` found no pasted spec. So the analysis reads the **genre** — using the two features you named (a complete spec; declared boundaries and invariants) plus its verified industry instances — and the filed doc is built to take a prompt-specific addendum under update-in-place the moment you supply the text.

> evaluate the philosophy and methodology of submitting a prompt like this, a complete spec, compared to the more iterative approach taken in this repo. what are pros and cons of each

The philosophical split is *where the spec lives and what enforces it*. The complete-spec prompt puts everything — objective, boundaries, invariants, acceptance — in one artifact at time zero, enforced by the model's attention across a long run. This repo didn't choose "no spec"; it **factored the mega-spec into four layers** with different lifetimes and different enforcement: standing invariants in the compiled contract plus the gate suite (machine-enforced, in every session's context); per-change design in plans held at decision granularity ([structured-plan-bodies](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/structured-plan-bodies.md)); per-delivery intent in matter packets, one per PR; and the record in threads and the commit graph.

Pros of the complete spec: decisions argued where changing them is cheapest (text, before code — the same belief your plan policy already holds); autonomy and parallelism, since a self-contained spec is what lets a run go unattended; one auditable statement of intent instead of an accreting transcript; declared invariants that counter scope creep — *when something re-asserts them*.

<routes ref="em:1eebdf em:0c4913 /meta/analysis/complete-spec-prompting-vs-iterative-delivery.md">
Cons: the waterfall failure mode amplified (requirements guessed before contact with the implementation, then built wrong at volume); the **spec-detail paradox** your own belief layer captures — "a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself" ([em:1eebdf](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/spec-detail-approaches-code-length.md), quoting Dex Horthy), at which point it loses its review advantage ("so don't review those things," em:0c4913); no ratification channel for mid-run ambiguity, so the executor's interpretations land silently; review arriving end-loaded as one large diff, which is exactly the shape [verified increments](https://github.com/ob6to8/elixir-mind/blob/main/meta/doctrine/verified-increments.md) rejects; and invariants that are attention-enforced — Anthropic's own guidance states the decay: "Claude's context window fills up fast, and performance degrades as it fills."
</routes>

Pros of this repo's iterative-layered approach: review-sized increments each landing green; correction that goes forward through a new scoped unit instead of steering a polluted context; invariants living in machinery that doesn't decay; and a system shape that evolves under ratification, so requirement discovery is a feature of the process rather than a spec defect. Its costs are just as real: the operator sits in the throughput path (approval gates cap parallelism at what you can review); per-unit ceremony (matters, plans, register rows, captures); context transfer paid explicitly in artifacts; and large outcomes arriving with latency across sequential PRs.

> is either approach dominant vs the other in the industry

Neither, and the field says so explicitly. The spec-first side is productized by first-tier vendors — GitHub's Spec Kit ("Define what to build before building it"), AWS Kiro (specs as EARS-notation "structured, testable requirements" plus design and task files), Tessl at the maximal end — yet Thoughtworks Radar holds spec-driven development at **Assess** (Nov 2025), cautioning "We may be relearning a bitter lesson — that handcrafting detailed rules for AI ultimately doesn't scale," and their companion write-up concedes the resemblance you'd expect: "I've heard some people claim this is a return to waterfall — not unreasonably — but I believe this time is different." Meanwhile the iterative camp's flagship guidance is already hybrid: Anthropic's [best practices](https://code.claude.com/docs/en/best-practices) default to "Explore first, then plan, then code" with "Course-correct early and often," but escalate to a written spec for larger features — interview first, "then write a complete spec to SPEC.md," executed by a fresh session. The two camps are converging from opposite directions: spec tools are adding feedback loops and checkable acceptance; iterative practice is adding persistent artifacts. All industry claims above were verified against the live sources this session.

> what are the best practices of each

Spec-first, done well: separate the constitution (standing invariants, reusable) from the feature spec; make acceptance machine-checkable (EARS-style conditions, named test cases) and — per Anthropic, verbatim — "The most useful specs are self-contained: they name the files and interfaces involved, state what is out of scope, and end with an end-to-end verification step that proves the feature works"; gate between phases with a human (Spec Kit's specify → plan → tasks → implement is deliberately not one-shot); hold the spec at decision granularity and stop; execute in fresh context and re-assert the spec against drift — the crude-but-instructive extreme being [Ralph](https://github.com/ob6to8/elixir-mind/blob/main/knowledge/SWE/agentic/agentic-loop/ralph-infinite-bash-loop-coding-agent.md), which re-loads its spec files every cycle; and give the run an escalation clause for ambiguity, because a spec silent on that has delegated its ambiguities to chance.

Iterative, done well — which is essentially this repo's practice stated generally: review-sized increments with tests riding along, every increment green; decisions persisted between sessions as artifacts rather than chat memory; standing rules compiled into every context with machine enforcement wherever an oracle exists; shape changes ratified, autonomy inside the established shape; corrections entering as new scoped units ([scoped units, corrected forward](https://github.com/ob6to8/elixir-mind/blob/main/meta/doctrine/scoped-units-corrected-forward.md)); and a tight, cheap verification loop.

> is it a scenario dependent call or is one approach generally thought to be better than the other

Scenario-dependent, and the industry increasingly names the dial rather than picking a side. Five axes set it: **requirement certainty** (known → spec; discovered → iterate), **oracle availability** (machine-checkable acceptance is what makes a long unattended run safe), **blast radius** (reversible/sandboxed tolerates one-shot; irreversible wants ratification points), **attendance** (a human at the keyboard makes course-correction cheap; overnight runs have nobody to ask), and **review capacity** (end-loaded mega-diffs are unreviewable regardless of spec quality). Anthropic compresses the low end of the dial into one sentence: "If you could describe the diff in one sentence, skip the plan." The pure corners are both weak — one-shot complete specs collapse under the spec-detail paradox and end-loaded review except where a strong oracle and sandbox make autonomy cheap, and undocumented iteration can't steer agents at all, which is why even iterative shops now write more standing text than post-agile human teams did. For *this* repo's corner — an operator-sovereign corpus where review is the bottleneck — the layered iterative choice is the right one, and the analysis says so with the reasoning attached.

> is there anything that could be learned from this prompt, the way it is structured, the declaration of boundaries and invariants etc that could be folded into the workflow here

<routes ref="/meta/analysis/complete-spec-prompting-vs-iterative-delivery.md /.claude/skills/scope-unit-of-work/SKILL.md">
Yes — at the packet level, not the architecture. Mapping the genre's sections onto the repo's layers: constitution/invariants are already here in stronger form (machine-gated, ratification-mutable); task phasing is here and review-quantized; executor assignment (model stamps) is *beyond* the genre. The gaps are in the matter packet, and they're measured: by grep over `meta/matters/*.md` today, 8/40 docs carry a `**Deliver:**` field, 5/40 a `**Verify:**` field, 3/40 any out-of-scope language — the discipline exists as habit, not shape. Three fold-in options, filed in the analysis for your ratification:

1. **Standardize `Deliver / Verify / Out of scope` as named fields of the matter packet** (in [/scope-unit-of-work](https://github.com/ob6to8/elixir-mind/blob/main/.claude/skills/scope-unit-of-work/SKILL.md) §4), with `Verify` preferring an executable check — the packet-level form of "Give Claude a check it can run," and verified-increments extended down into the handoff artifact. Highest leverage.
2. **An explicit out-of-scope clause in the structured plan's decision list** — alternatives-rejected is adjacent to but not the same as a scope boundary; one clause makes scope creep checkable at plan review.
3. **A task-scoped invariants line in the packet** for constraints no gate covers ("no new deps," "policy Y untouched this delivery") — with the inverse lesson attached: where a gate already enforces an invariant, the packet must not restate it, because a prompt-stated copy of a machine-enforced rule is the genre's weakness, not its gift.
</routes>

---

**What I created**

| type | doc | why this type |
|---|---|---|
| `analysis` | [meta/analysis/complete-spec-prompting-vs-iterative-delivery.md](https://github.com/ob6to8/elixir-mind/blob/claude/spec-vs-iterative-analysis-7v6ggq/meta/analysis/complete-spec-prompting-vs-iterative-delivery.md) | a reasoned judgment on a question, against evidence — the governance-artifact-routing home for exactly this ask |

**What I modified**

| file | thrust of the change |
|---|---|
| `meta/analysis/index.md` | added the new analysis's gloss at the top of the Contents list |

**Actions I have taken**

| action | result |
|---|---|
| Searched for the referenced prompt (task text, working tree, session branch vs `main`, open issues, journal/inbox/survey) | absent everywhere checked; analysis proceeds at genre level |
| Verified industry sources by direct fetch (Thoughtworks Radar + insights post, Spec Kit, Kiro docs, Anthropic best practices) | all quotes verbatim-confirmed; one search-summary claim (a "three levels of SDD" taxonomy) failed verification and was excluded |
| Ran the full gate suite via pre-commit (format, xref, contract/registry/codemap checks, `brain.verify`, route tags, glossary, matters, 211 tests) | all green; one expected advisory warning — the analysis's `attribution` lacks `from` until a thread doc exists to stamp |
| Committed `64b4f4a` + `39f8081` and pushed `claude/spec-vs-iterative-analysis-7v6ggq` | branch is up on origin; no PR opened (not requested) |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Paste the actual prompt | I extend the same analysis doc in place with a prompt-specific read against the genre baseline |
| 2 | Ratify fold-in 1 (standard packet fields) | I scope it via `/scope-unit-of-work` as a matter editing the skill's §4 packet shape; fold-ins 2–3 can ride as separate matters |
| 3 | `/create-pull-request` | closes the thread: capture, glossary, `attribution.from` stamp onto the analysis (clearing the advisory warning), PR open |

*The render ends here at operator direction; the session then merged
`origin/main` into the branch (clean, bringing in PRs #238–#242) and ran the
`/create-pull-request` closing flow.*
