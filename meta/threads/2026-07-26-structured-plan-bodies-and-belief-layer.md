---
type: reference
title: 2026-07-26-structured-plan-bodies-and-belief-layer
description: Analyzed the pseudocode/outline plan approach (wsff.md plus the Mulroy/Horthy/Jain posts, recovered via operator screenshots after X blocked fetches), then ratified and executed a large batch — the belief layer seeded with four quoted beliefs, the structured-plan-bodies / quote-primary-sources / prefer-established-terminology policies, a pilot retrofit of the frontmatter-parser plan, and three structured-format plans (extract-into-belief skill, retrofit sweep, policy-canonical skill guidance) deferred for fresh-context dogfooding.
provenance: "Claude Code session (claude-fable-5), 2026-07-26; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, plans, program-design, pseudocode, beliefs, policy, glossary]
timestamp: 2026-07-26
session: https://claude.ai/code/session_01Ji7y7jxonnaiRBJfZjAEnH
---

# 2026-07-26-structured-plan-bodies-and-belief-layer

## Where this landed

The operator asked what four resources (HumanLayer's wsff.md essay and three X
posts by Dillon Mulroy, Dex Horthy, and Sahaj Jain) say about agents writing
plans as pseudocode/outlines, and how it could apply here. Only wsff.md was
fetchable — X returned 402 — so the operator supplied the three posts as
screenshots, which sharpened the method: plans as types/interfaces + call
stacks (including test topology), component trees as pre-plan alignment
artifacts, and a skill that prescribes the format (current/desired trees,
boundary decisions, anchors-last, decision list). The operator then directed a
batch that this session split per the plan-vs-capture discriminator:
**executed in-session** — the belief layer ratified and seeded with four
verbatim-quoted beliefs (`em:1eebdf`, `em:0c4913`, `em:6c7e85`, `em:a96688`),
the [structured-plan-bodies](/meta/policy/structured-plan-bodies.md),
[quote-primary-sources](/meta/policy/quote-primary-sources.md), and
[prefer-established-terminology](/meta/policy/prefer-established-terminology.md)
policies with contract recompile, a persist-plans amendment, and the
[frontmatter-parser plan](/meta/plans/frontmatter-parser-profile-rewrite.md)
retrofitted as the format pilot; **deferred as structured-format plans for
fresh-context dogfooding** — the
[/extract-into-belief skill](/meta/plans/extract-into-belief-skill.md), the
[retrofit sweep](/meta/plans/retrofit-plans-to-structured-bodies.md) (which
also settles Q2: the genre keeps the name "flow"), and
[policy-canonical skill guidance](/meta/plans/policy-canonical-skill-guidance.md)
(Q1: rules canonical in policy, skills quote them with markers). Landed via
this session's PR (see `pr:`), merged the same day.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| What the pseudocode/outline plan approach is (wsff.md + Mulroy/Horthy/Jain) and its adoption here | closed | [structured-plan-bodies policy](/meta/policy/structured-plan-bodies.md) | - |
| Ratify + seed the belief layer (`belief` type, /beliefs/ home, verifier exclusion) | closed | [belief-layer plan](/meta/plans/belief-type-and-beliefs-namespace.md) | - |
| The four seed beliefs, quoted verbatim with provenance | closed | [spec-length](/beliefs/spec-detail-approaches-code-length.md), [don't-review](/beliefs/dont-review-code-length-specs.md), [implicit-review-decisions](/beliefs/plan-artifacts-surface-implicit-review-decisions.md), [compress-decisions](/beliefs/plan-artifacts-compress-decisions-not-bodies.md) | - |
| /extract-into-belief skill: atomic decomposition with provenance | closed | [extract-into-belief plan](/meta/plans/extract-into-belief-skill.md) | - |
| Verbatim quotation with citation as a standing rule | closed | [quote-primary-sources policy](/meta/policy/quote-primary-sources.md) | - |
| Q1 — policy-canonical guidance vs. skill-canonical | closed | [policy-canonical-skill-guidance plan](/meta/plans/policy-canonical-skill-guidance.md) | - |
| Q2 — "flow" vs. "state-tree" naming; anti-bespoke terminology | closed | [prefer-established-terminology policy](/meta/policy/prefer-established-terminology.md) | - |
| Q3 — anchor staleness, refresh-at-execution, warn-only `mix brain.anchors` | closed | [retrofit plan](/meta/plans/retrofit-plans-to-structured-bodies.md) | - |
| Retrofit the existing plan corpus to structured bodies | closed | [retrofit plan](/meta/plans/retrofit-plans-to-structured-bodies.md) | - |
| Pilot retrofit of the frontmatter-parser plan | closed | [frontmatter-parser plan](/meta/plans/frontmatter-parser-profile-rewrite.md) | - |
| PR timing for thread-doc provenance (`attribution.from` stamping) | closed | `unrouted` (answered in chat: /create-pull-request closes it in one motion) | - |

## User

consider the way the following resources point to a sytem where "plans" output by agents are created in pseudocode or outlines. describe what this approach is exactly, and how it could be applied in this repo. describe the ramifications, and compare to prose based plans. if you cannot access any of these resources, do not skip, let me know and I will copy paste or screenshot

https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md
https://x.com/dillon_mulroy/status/2059985696148849025
https://x.com/dexhorthy/status/1998968236617199803
https://x.com/iamsahaj_xyz/status/2051385250350346264

## Assistant

Here's the full picture. Short version up front: **I could only access one of the four resources.** The GitHub document (HumanLayer's `wsff.md`, "Why Software Factories Fail") fetched completely, including its example artifacts. All three X posts returned HTTP 402 — X blocks unauthenticated fetches — and web search recovered only adjacent context, not the tweets themselves. **Please paste or screenshot the three tweets** and I'll fold them into this analysis. What follows is grounded in the wsff.md document plus the fragments search surfaced (Dex Horthy's related "a sufficiently detailed spec is code" post, and a Mario Zechner reply praising Dillon Mulroy's "call stack trick" — which suggests Dillon's tweet is about exactly the call-stack-tree technique below).

## What the approach actually is

The wsff.md essay argues that fully-automated "lights-off" code generation fails because models degrade codebase quality over time — RL training rewards "tests pass," with "no penalty for eroding codebase maintainability." The remedy is front-loading human alignment through a phased pipeline: **product review → system architecture → program design → vertical slices**. The relevant phase for your question is **program design**, which the author calls "criminally underemphasized": before any implementation, the agent drafts the *shape* of the change as three compact, structured artifacts, and the human argues with them:

1. **Call-stack trees** for control-flow changes, in diff syntax:
```diff
 entrypoint
   runCommand
+    handleCreateResource
+      ResourceClient.create(input)
+        POST /resources
+      renderResult
-    legacyCreateFlow
```

2. **File-tree diffs**, so the reviewer stays in touch with where things will live:
```diff
 src
 └── resource
+    ├── resource-client.ts      # NEW - wraps API contract calls
+    ├── resource-client.test.ts # NEW
~    └── resource-route.ts      # MODIFIED - wires create action into UI
```

3. **Types and method signatures** for the key new functions — "too internal for an architecture doc but that an agent might still get wrong."

<routes ref="em:6c7e85">
The stated rationale: "none of these take long to produce (the model drafts them, you argue with it), and every one of them is a decision you'd otherwise be making implicitly during code review — at the most expensive possible time to change your mind." Hence the thesis "30 minutes of planning saves hours of review."
</routes>

<routes ref="em:1eebdf em:0c4913 em:a96688">
Two boundaries matter. This is **outline-level pseudocode, not full pseudocode**: Dex's adjacent post makes the constraint explicit — "a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself — so don't review those things." The artifacts compress the *decisions* (interfaces, layout, call order) while leaving function bodies to the agent. And it's not prose-free: the artifacts sit inside a narrative doc; they replace the *ambiguous* part of prose, not the rationale.
</routes>

## How it maps onto this repo

Your plans are already the right vehicle — `type: plan` docs under `meta/plans/` with a "shape of the change" section (per the persist-plans policy). Looking at a representative one, [compile-skills-registry-from-skill-frontmatter](/meta/plans/compile-skills-registry-from-skill-frontmatter.md), the "shape" section is pure prose: "A skills scanner (`ElixirMind.Skills` or similar): enumerate `.claude/skills/*/SKILL.md`, parse each frontmatter's `name` + `description`…". That's exactly the material wsff would render structurally instead:

```diff
 lib/elixir_mind
+├── skills.ex          # NEW — scanner: enumerate .claude/skills/*/SKILL.md
 ├── contract.ex        # MODIFIED — §7 renders from Skills.scan/0
 test
+└── skills_test.exs    # NEW
```
```elixir
@spec scan(skills_dir :: Path.t()) :: [%{name: String.t(), description: String.t()}]
@spec render_section(skills :: [skill()]) :: iodata()
```

Elixir is unusually well suited here — `@spec` is already a first-class, conventionalized artifact in your coding standards ("name `@spec` arguments whose type doesn't reveal their role"), so the plan's signature block and the eventual code share a literal syntax.

There's also a fit the essay's authors wouldn't have anticipated: **your "codebase" is partly the bundle, and the bundle is a tree.** The tree-is-the-taxonomy policy means a plan proposing taxonomy or genre changes can carry a *directory-tree diff of the bundle* (new dirs, new `index.md` files, moved docs) with the same diff syntax, and frontmatter-schema changes can carry a before/after field table — the governance-side analogue of a type signature. So the technique generalizes beyond `lib/` to the knowledge-shape changes that dominate your plan backlog.

Concretely, adoption would be an amendment to `meta/policy/persist-plans.md` ("What it holds" gains: *for code-touching plans, the shape section includes a file-tree diff, call-stack tree where control flow changes, and signatures for key new functions; for bundle-shape plans, a tree diff of the affected namespace*), recompiled via `/render-contract`. That's a policy change, so it's operator-ratified — which is you, so it's a decision, not a blocker. A lighter-touch alternative is a `methodology` doc on plan authoring, referenced from the policy without hardening it into a rule. I'd keep enforcement editorial: a post-hoc mechanical oracle technically exists (diff the plan's file-tree against the merged implementation), but by your own gate-admission rule its signal wouldn't beat its upkeep.

## Ramifications

**The big win is exactly your plan-vs-capture discriminator: cold-context handoff.** Your policy already identifies plans as "the context-transfer vehicle" for fresh agents who "may re-land on a worse answer." Prose transfers intent but leaves the shape to be re-derived; a signature block and file-tree diff transfer the shape exactly, collapsing the fresh agent's degrees of freedom where they matter (interfaces, layout, call order) while leaving implementation freedom where it's cheap. Several of your proposed plans (frontmatter-parser rewrite, derived-index-listings, `mix brain.strands`) are precisely deferred-execution tooling plans that would benefit.

**Second win: review economics.** You review plans as the ratification gate. A diff-syntax tree is scannable in seconds and forces decisions ("does the scanner live in `contract.ex` or its own module?") to surface at ratification instead of implicitly at PR review — wsff's "most expensive possible time" point.

**The costs:**

- **Pseudocode carries no *why*.** Your persist-plans policy requires plans to hold "decisions *and their rationale*," and your plan corpus is genuinely rationale-heavy — alternatives weighed, open questions for ratification, provenance. Pure-pseudocode plans would gut that. The approach only works here as a hybrid: prose skeleton (problem, decisions, alternatives, open questions) with structured artifacts embedded in the shape section. wsff itself is that hybrid.
- **Staleness bites harder.** Many of your plans sit in `proposed` for weeks while `main` moves. Prose intent survives refactors; a file-tree diff binds to concrete module names and rots. Mitigation: keep artifacts at outline granularity and treat a refresh-against-current-`main` as the first execution step (your transplant plan already models "scope shrank on filing" — same discipline).
- **The over-specification trap.** The failure mode Dex names: the plan's pseudocode creeps toward full pseudocode, at which point you're reviewing code twice, in a worse format. The artifacts must stay at the signature/tree/stack level — decisions, not implementations.
- **Coverage is partial.** A pure policy or doctrine change ("the belief layer," "concept terminology") has no call stack. Tree diffs and schema tables cover some of it; the rest stays prose, correctly.

## Prose vs. pseudocode plans, head to head

| | Prose | Pseudocode/outline artifacts |
|---|---|---|
| Rationale, alternatives, open questions | Native strength | Silent — must be supplied by surrounding prose |
| Exactness of the intended shape | Ambiguous; each reader (and each fresh agent) re-derives it | Exact — interfaces, layout, and order are the artifact |
| Review cost | Reader simulates the change mentally | Diff-scannable; disagreements are pointable |
| Robustness to codebase drift | High — intent survives renames | Low — binds to concrete names; rots in long-deferred plans |
| Token/length economy for agent consumption | Verbose relative to information | Dense; but degenerates to code-length if over-specified |
| Fit for governance/policy plans | Full | Partial (tree diffs, schema tables only) |

The honest conclusion is that these aren't competitors — the wsff approach is a *discipline for the shape section* of a prose plan, not a replacement genre. Your plan format already has the slot; today it's filled with prose descriptions of structure that would be strictly better as the structures themselves. Adopting it means one policy amendment and a habit change, and the highest-leverage place to pilot it is the next deferred tooling plan you ratify.

Send over the three tweets when you can — if Dillon's is the call-stack-trick post and Sahaj's/Dex's add workflow specifics (e.g., how the artifacts thread into the agent loop, or Dillon's Socratic context-buildup), I'll revise the application section accordingly.

Sources: [wsff.md — Why Software Factories Fail](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md) · [Dex Horthy on spec-detail ≈ code](https://x.com/dexhorthy/status/2033980486813684181) · [Mario Zechner reply re Dillon's call-stack trick](https://x.com/badlogicgames/status/2080195860659396860) · [Dex Horthy on RPI methodology (Dev Interrupted)](https://linearb.io/dev-interrupted/podcast/dex-horthy-humanlayer-rpi-methodology-ralph-loop) · [PGPO: pseudocode-style planning for agents (arXiv)](https://arxiv.org/pdf/2506.01475)

## User

*[Three screenshots: (1) Dillon Mulroy's post — "my 'plans' largely look like pseudo code composed of mostly types/interfaces, how they compose, and their boundaries. ive recently started including call stacks - been very helpful for both me and agents when implementing" — with a "Final call graph" image showing separate Production and Tests call trees; (2) Dex Horthy's post — "have been prompting claude to make me component trees like this when refactoring components and eliminating complex state and too many useEffects. super helpful for mental alignment with the agent (and with the team) before writing the actual plan" — with an annotated React component tree; (3) Sahaj Jain's post — "plan mode outputs suck, so I made this skill instead" — showing a "UX Flow Plan" skill: restate goal, current-state flow tree, desired-state flow tree, boundary decisions, anchors after the trees, closing decision list.]*

ok, here are the other assets:
2026-07-23-dev-history-drift-and-regeneration-flow.md

## Assistant

All three tweets received and read, plus the thread doc. Here's the revised picture — the tweets sharpen the approach considerably beyond what wsff.md alone gave, and the thread doc turns out to be a good worked example of where this would bite in your repo.

## What the tweets add

**Dillon Mulroy** states the format thesis in one line: *"my 'plans' largely look like pseudo code composed of mostly types/interfaces, how they compose, and their boundaries… ive recently started including call stacks — been very helpful for both me and agents when implementing."* The screenshot adds a detail wsff doesn't have: his final call graph is written **twice — once for production, once for tests** — with the test tree showing exactly which layers get substituted (`LinkCatalogStore.layerMemory` in place of the SQL executor). The test *topology* is a planned artifact, not something discovered during implementation.

**Dex Horthy's** post is about component trees — each node annotated with its state, props, callbacks, hotkeys, and package placement (`[packages/ui — pure page component]`) — with two points that matter. First, timing: the tree is drafted for *"mental alignment with the agent (and with the team) **before writing the actual plan**"* — it's a pre-plan negotiation artifact, cheaper to argue about than either prose or code. Second, his reply nails *why* prose plans fail review: *"it's really hard to look at an implementation plan and know if it's going to look good — i can say things like 'good this uses our design system' and 'good this doesn't rely on too much useEffect' but i don't know if it will."* Prose plans hide the structure that quality predicates apply to; trees expose it, so the reviewer can actually evaluate rather than just approve.

**Sahaj Jain's** post is the most operationally complete: *"plan mode outputs suck, so I made this skill instead"* — a skill that *prescribes the plan format itself*. Its steps: (1) restate the goal in product terms; (2) render the **current-state** flow as a tree (user action → system behavior → architectural layer → function/file anchor); (3) render the **desired-state** flow as a second tree; (4) enumerate the boundary decisions (which layer detects the condition, owns side effects, updates UI, persists state); (5) **attach implementation anchors after the trees, not before** — function names, file paths, existing abstractions to reuse, tests that should cover the flow; (6) end with a decision list — recommended architecture, **alternatives rejected**, open questions and assumptions.

## The synthesized approach

<routes ref="/meta/policy/structured-plan-bodies.md">
Across all four sources the method is now crisp. A plan's body is **trees and signatures, with prose demoted to a thin frame**:

- **Interface/type signatures** — what the units are and their boundaries (Dillon, wsff)
- **Call/flow trees** — how they compose at runtime, *including the test wiring* (Dillon, wsff)
- **Structural trees** — where things live and what state/props each node owns (Dex, wsff)
- **The delta encoding** — either diff syntax on one tree (wsff) or a current-state/desired-state tree pair (Sahaj)
- **A closing decision list** — rationale, rejected alternatives, open questions (Sahaj)

Plus two disciplines: anchors-last (behavior trees before file paths, so the plan isn't anchored to incidental existing code), and Dex's timing rule (trees are the alignment artifact you argue over *before* the full plan exists).
</routes>

Notably, Sahaj's step 6 confirms what I argued last time: even the strongest pseudocode-plan advocates keep an explicit rationale/alternatives/open-questions section. The approach doesn't abolish prose plans — it abolishes prose *descriptions of structure*, which is precisely the content your plans' "shape of the change" sections currently carry as paragraphs.

## Updated application to this repo

Three things change from my earlier assessment:

**1. The adoption vehicle should be a skill, not just a policy amendment.** Sahaj's insight is that the format lives where the plan is *authored*. Your repo is skill-driven and already has the read-only `/plan` lister; the natural move is a plan-authoring step (a `/plan create` subcommand, or a `plan-authoring` methodology doc that persist-plans references) prescribing Sahaj's sequence adapted to this repo: current-state tree → desired-state tree → boundary decisions → anchors (module names, file paths, existing `lib/elixir_mind` abstractions to reuse, the scenario tests that should cover the flow) → decision list. The persist-plans policy amendment then just points at it. Skill additions you make autonomously; the policy edit is ratified — again, by you.

<routes ref="/meta/plans/retrofit-plans-to-structured-bodies.md">
**2. You already have the "current-state tree" genre: `meta/flows/`.** Sahaj's step 2 — render the current-state flow before proposing the desired one — is exactly what your flow docs are (per-flow touch-sequence records backed by scenario tests). A plan changing a flow can therefore *cite the flow doc as its current-state tree* and only author the desired-state tree or a diff against it. That's a structural advantage most codebases lack: half of Sahaj's format is already maintained and CI-tested here.
</routes>

**3. The thread doc you attached is the worked example.** In the 2026-07-23 session, the fix was "fold `mix brain.dev_history` into `/create-pull-request`'s commit step" — a control-flow change to a skill, negotiated across five prose exchanges. In this format, the proposal would have been one diff-tree:

```diff
 /create-pull-request
   /capture → /add-to-glossary → stamp attribution.from
+  mix brain.dev_history        # regenerate before commit, same discipline
+                               # as CLAUDE.md / registry / codemap
   commit → push → open PR
```

plus a decision list ("rejected: CI auto-commit bot — no session provenance, writes to main outside PR flow, self-referential lag remains"). That session was correctly executed in-session without a plan doc (per plan-vs-capture — the executor shared the context), and the analysis doc it filed captures the rationale well. But it shows the pattern: the structural half of that negotiation compresses to a five-line tree, and had the work been *deferred* to a cold session, that tree plus the decision list would have been the whole plan. Dillon's production-vs-tests dual graph also maps cleanly onto your testing methodology — a plan for a new `mix brain.*` task can show the task's call tree and, beside it, the scenario-test tree with its substituted seams.

## What this revises in the ramifications

- **The review argument is stronger than I credited.** Dex's point isn't just "cheaper review" — it's that certain judgments (*does this respect the compile-coupling gate? does the new module avoid reaching into internals the testing methodology forbids?*) are **only possible** against a structural artifact. Your repo has unusually many such predicates (xref coupling gate, narrowest-public-surface testing, tree-is-the-taxonomy), so structured plans convert more of your review from trust to verification than they would in a typical codebase.
<routes ref="/meta/plans/retrofit-plans-to-structured-bodies.md">
- **Anchors-last mitigates the staleness risk I flagged.** If the trees are behavior-first and file paths are attached last, a plan that sits in `proposed` while `main` moves rots only in its anchor layer — cheap to refresh at execution start — rather than in its core structure.
</routes>
- **The comparison table stands**, with one amendment: "prose carries rationale, pseudocode is silent on it" is resolved by construction, since the format itself ends with the decision list. The real remaining trade-off is coverage (pure governance/doctrine plans stay prose) and the over-specification trap (which Sahaj's outline-level trees, like wsff's, deliberately stay above).

If you want to act on this, the sequence would be: draft the plan-authoring methodology/skill adapted from Sahaj's template, amend `meta/policy/persist-plans.md` to reference it, `/render-contract`, and pilot it on the next deferred tooling plan you ratify (the frontmatter-parser rewrite is the obvious candidate — it's exactly a types-interfaces-boundaries problem). Say the word and I'll build it on this branch.

## User

<routes ref="em:1eebdf em:0c4913 em:6c7e85 em:a96688">
add the following to the belief list, with a link to the dex article as provenance:
""a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself" and then a belief that depends on that belief: "so don't review those things.""
also: "every one of them is a decision you'd otherwise be making implicitly during code review" (define "every one")
"The artifacts compress the decisions (interfaces, layout, call order) while leaving function bodies to the agent" - provenance will be this thread (does this mean we should open the pull request now to get the thread doc to tie all these to for provenance?
</routes>

<routes ref="/meta/plans/extract-into-belief-skill.md">
create a /extract-into-belief skill, that would take something like :

"Prose transfers intent but leaves the shape to be re-derived; a signature block and file-tree diff transfer the shape exactly, collapsing the fresh agent's degrees of freedom where they matter (interfaces, layout, call order) while leaving implementation freedom where it's cheap."

and turn it into:
"Prose transfers intent"
"Prose leaves the shape to be re-derived"
"a signature block transfers the shape exactly"
"a file-tree diff transfers the shape exactly"
"a signature block collapses the fresh agent's degrees of freedom where they matter" (example prop: interfaces, layout, call order)"
"a file-tree collapses the fresh agent's degrees of freedom where they matter" (example prop: interfaces, layout, call order)"
"a signature block leaves implementation freedom where it's cheap"
"a file tree leaves implementation freedom where it's cheap"

tracing provenance back to the artifact it was extracted from
</routes>

explain "but by your own gate-admission rule its signal wouldn't beat its upkeep" - but in general I agree with the amendment and policy change

<routes ref="/meta/plans/retrofit-plans-to-structured-bodies.md">
create a plan to retrofit all existing plans to the format defined here, including "frontmatter-parser rewrite, derived-index-listings, mix brain.strands"
</routes>

<routes ref="/meta/policy/quote-primary-sources.md">
this sentence: 'Your policy already identifies plans as "the context-transfer vehicle" for fresh agents who "may re-land on a worse answer."' is a great example of quoting primary sources verbatim so there is no question whether it is a synthesis or new assertion. Ideally this would also be followed by the artifact it is quoted from. lets make this a policy (assuming policy is the best place to put it)
</routes>

<routes ref="/meta/plans/policy-canonical-skill-guidance.md">
1 - should it live in the skill as the canonical guidance? or should these decisions be encoded as policy, compiled or copied (with qualifications that they are duplicate statements, along with provenance to the source) into the skill? intuitively it feels to me to be the latter, which would then imply the rest of the skllls would need to be ported to the same. if you agree, we should author a plan
</routes>

<routes ref="/meta/policy/prefer-established-terminology.md">
2 - should we change the name from "flow" to "state-tree"? in general i want to avoid bespoke terminology where possible (could be encoded as a policy.) should we revisit current flow documents and rewrite them to absorp whatever new syntax we adopt?
</routes>

<routes ref="/meta/plans/retrofit-plans-to-structured-bodies.md">
3 - seems that we might want to run a check on any change of directory structure or codebase against all existing plans and documentation that use file trees/signature blocks to make sure their references do not go stale? what does "cheap to refresh at execution start" look like?
</routes>

proceed with: "draft the plan-authoring methodology/skill adapted from Sahaj's template, amend meta/policy/persist-plans.md to reference it, /render-contract, and pilot it on the next deferred tooling plan you ratify (the frontmatter-parser rewrite is the obvious candidate — it's exactly a types-interfaces-boundaries problem)."

also, this is covering a number of surfaces. if anything should be compiled into a plan in this thread to be run in a fresh context, lets do it - and that process may provide some good dogfooding as well

## Assistant

The belief plan is `proposed` and your instruction to file beliefs is its ratification — I'll execute its build order (vocabulary entry, `/beliefs/` index rewrite, seed beliefs, verifier regression test) as part of this batch. Setting up task tracking since this spans many surfaces, then continuing recon.

Recon complete. Now checking section/order numbering for the new policies, then I'll start writing.

One design call I'm making based on your Q1 answer (policy as canonical home): the plan-format guidance lands as a **policy** (`structured-plan-bodies`) rather than inside a skill — persist-plans references it, and there's no plan-authoring skill to duplicate into since plan persistence stays inline per the contract.

## User

again, we could feasibly make plans for all of these items which would allow dogfooding as well

## Assistant

Good — that matches where I've landed: I'll keep in-session only the foundations (the belief layer + beliefs you directly asked to file, the policies that *define* the format everything else dogfoods, and the pilot retrofit that validates it), and everything else becomes structured-format plans for fresh contexts: the `/extract-into-belief` skill build, the full retrofit sweep, and the skills→policy canonicalization port. Updating the task list to match, then executing.

All done and pushed — four commits on `claude/pseudocode-agent-plans-n80bua`, all gates green (182 tests, verifier, route-tags, glossary, contract/registry drift checks). Here's what landed, followed by answers to your questions.

## Executed in-session (foundations only)

<routes ref="em:1eebdf em:0c4913 em:6c7e85 em:a96688">
- **Belief layer ratified and seeded.** Your "add to the belief list" instruction was the ratification the [belief-layer plan](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/plans/belief-type-and-beliefs-namespace.md) was waiting on, so I executed its build order: `belief` type in the vocabulary (with the epistemic/teleological filing test), [`/beliefs/`](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/beliefs/index.md) rewritten as the layer's home, and a verifier regression test pinning that `verified` on a `belief` is rejected. Four seed beliefs, each quoting its source verbatim: the Dex spec-length thesis (`em:1eebdf`), **"so don't review those things"** (`em:0c4913`, carrying `depends_on: [em:1eebdf]` — the dependency you specified), the wsff quote with **"every one of them" resolved in the body** to its referent (call-stack trees, file-tree diffs, type signatures — `em:6c7e85`), and my synthesis about compressing decisions (`em:a96688`).
</routes>
- **Three policies**, contract recompiled: [structured-plan-bodies](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/policy/structured-plan-bodies.md) (the canonical format: trees → file-tree diffs → signatures → boundary decisions → anchors-last → decision list, bounded by the spec-length belief, with a refresh-at-execution rule), [quote-primary-sources](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/policy/quote-primary-sources.md), and [prefer-established-terminology](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/policy/prefer-established-terminology.md). persist-plans now references the format.
<routes ref="/meta/plans/frontmatter-parser-profile-rewrite.md">
- **The pilot**: the [frontmatter-parser plan](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/plans/frontmatter-parser-profile-rewrite.md) gained a "The shape, structured" section — file-tree diff, the read/write-surface `@spec`s with the ordered-pairs representation, production and test call trees, boundary decisions, anchors. Its prose was untouched; the artifacts made one real design decision visible that the prose left implicit (order lives only in the internal `pairs` type, so `parse/1`'s 16 call sites stay frozen).
</routes>

## Deferred to plans, per your mid-turn message (the dogfooding)

Three plans authored **in** the format, for fresh-context execution: the [/extract-into-belief skill](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/plans/extract-into-belief-skill.md) (your worked example is embedded verbatim and fixes the granularity rule: one subject + one predicate, conjunctions fan out, parentheticals become example props; filing its eight beliefs is the acceptance test), the [retrofit sweep](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/plans/retrofit-plans-to-structured-bodies.md) (triage table over all ~16 active plans including derived-index-listings and `mix brain.strands`; `done`/`superseded` excluded — rewriting a historical record falsifies it), and [policy-canonical-skill-guidance](https://github.com/ob6to8/elixir-mind/blob/claude/pseudocode-agent-plans-n80bua/meta/plans/policy-canonical-skill-guidance.md).

## Your questions

**The PR/provenance question — no, don't open the PR early.** The linkage is designed to land in one motion: `/create-pull-request` runs `/capture` first (creating the thread doc), then stamps the thread's path into `attribution.from` of every governance doc this session touched, so the thread, the beliefs it routes to, and the stamps all ship in the same PR. The belief docs already name the session in `provenance`; the mechanical links (route tags into the belief bodies, `from` on the three plans — currently advisory warnings in `mix brain.verify`, as expected) arrive at capture time. Invoke `/create-pull-request` whenever you're ready and it all closes at once.

<routes ref="/meta/plans/retrofit-plans-to-structured-bodies.md">
**"Signal wouldn't beat its upkeep"** — I was applying the elixir-coding-standards admission rule: "a check earns a gate when its **signal beats its upkeep**." A *hard* CI gate diffing plan trees against the implemented codebase would fire almost entirely false positives, because a prospective plan drifts from `HEAD` *by design* — you'd spend more effort pacifying the gate than it would save. That reasoning killed only the hard gate. A **warn-only** `mix brain.anchors` sweep (extract path refs from tree/diff blocks in active plans and flow docs, warn on ones that don't resolve, excluding `# NEW` entries) is a different proposition, and the retrofit plan records it as a deferred phase — to be built only if the retrofit sweep actually observes stale anchors misleading an executing session. Signal before machinery.

**"Cheap to refresh at execution start"** (Q3) concretely: step 1 of executing any structured plan is *re-derive the current-state tree against `HEAD`, diff it against the plan's, update anchors*. It's cheap **because of the anchors-last discipline** — file paths and function names are segregated into the trees and the anchors block rather than woven through prose, so staleness is confined to a greppable layer you regenerate mechanically, while the decisions (the prose and the tree *shapes*) rarely need touching. This is now codified as the policy's refresh rule, and the continuous-check version is the deferred `mix brain.anchors` above.
</routes>

<routes ref="/meta/plans/policy-canonical-skill-guidance.md">
**Q1** — agreed, and with one boundary worth keeping: the [compile-skills-registry plan](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/compile-skills-registry-from-skill-frontmatter.md) correctly makes `SKILL.md` canonical for a skill's *identity* (name/description compile skill→contract). Your instinct applies to *rules*: behavioral decisions become canonical in `meta/policy/`, and skills quote them verbatim with a greppable `(duplicate statement — canonical: /meta/policy/….md)` marker — your qualification requirement, implemented via the new quotation policy. The two compiles run in opposite directions over disjoint content. The plan pilots on `/capture` (heaviest rule-carrier) and defers a mechanical include-compiler until the markers prove the shape.
</routes>

<routes ref="/meta/policy/prefer-established-terminology.md">
**Q2** — recommend **keeping "flow"**: it's the established term (UX flow, control flow — Sahaj's own skill is literally "UX Flow Plan"), while "state-tree" would be the bespoke coinage, and slightly wrong (the trees encode action sequences and structure, not state machines). Your anti-bespoke preference is now the prefer-established-terminology policy, which itself settles this question. Rewriting flow docs to absorb the tree syntax: yes, where a tree beats the prose step-list — that's phase 3 of the retrofit plan, no rename involved.
</routes>

One editorial flag: the retrofit plan's triage table suggests the glossary-single-overview plan may belong in Done (its index entry says it was executed); the retrofit's refresh step will confirm rather than assume. When you're ready, `/create-pull-request` ships all of this plus the captured thread.

## User

/create-pull-request merge
