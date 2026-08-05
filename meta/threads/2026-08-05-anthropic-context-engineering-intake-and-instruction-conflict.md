---
type: reference
title: "Anthropic's Claude 5 context-engineering post — intake, and the instruction-conflict finding it raised"
description: An /intake of Anthropic's context-engineering post that turned into an audit of the instruction layer itself — no mechanical oracle for conflict, no override semantics despite the layered presentation, an ablation that cannot distinguish newly-redundant from never-load-bearing, and the social asymmetry that makes such a layer accrete.
tags: [thread, intake, context-engineering, claude-code, instruction-conflict, governance, oracles]
timestamp: 2026-08-05
pr: 255
session: https://claude.ai/code/session_01FB7Lcdq3rB6Wq14t91X2r8
---

# Anthropic's Claude 5 context-engineering post — intake, and the instruction-conflict finding it raised

An `/intake` of Anthropic's post announcing that over 80% of Claude Code's
system prompt was removed for the Claude 5 generation. The operator paired the
URL with the post's own admission about conflicting instructions and three
questions: what auditing prevents contradictory instruction across contextual
sources, whether a record exists, and how it went uncaught.

The intake filed the post as a `reference` (`em:0dc544`). The questions did not
resolve into a summary — they resolved into a separate `claim` (`em:ed8315`)
that grew over four exchanges as the operator pushed on each answer:

1. **No oracle at authoring.** Conflicting instructions raise no error; the
   class is found by reading transcripts. `/doctor` audits structure and
   context cost, never semantic agreement.
2. **No override semantics.** The operator challenged whether layered override
   configs are reliable. They are not — and the challenge exposed an
   overgenerous concession in the first draft. Settings merge deterministically
   in code; instruction text does not merge at all.
3. **No attribution at evaluation.** The operator proposed that the
   "smarter models" framing was cover for unvalidated instructions. The
   published evidence underdetermines it: "no measurable loss" is identical
   under *newly redundant* and *never load-bearing*, and the source reports no
   cross-generation ablation.
4. **No empirical settlement at governance.** The operator raised the
   groupthink and political dimension of a company-authored CLAUDE.md.
   Unfalsifiable claims resolve by standing; additions meet no resistance while
   deletions meet a person, so the layer accretes.

The operator also challenged the post's claim that constraints "were once
needed to avoid worst case scenarios" as a made-up thing. Anthropic's own
documentation is the witness against it: CLAUDE.md is "context, not enforced
configuration", and anything that must not happen routes to hooks and
permissions.

Closed by filing a backlog matter to audit this bundle's own contract on the
enforcement axis, bounded against the existing size-counterweight matter.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Anthropic's context-engineering post — the six shifts and the per-surface framework | closed | [new-rules-of-context-engineering-claude-5](/knowledge/SWE/agentic/context-engineering/new-rules-of-context-engineering-claude-5.md) | - |
| Instruction conflict has no mechanical oracle; the layer implements no override; the blindness recurs at eval and governance | closed | [instruction-conflict-has-no-mechanical-oracle](/knowledge/SWE/agentic/governance/instruction-conflict-has-no-mechanical-oracle.md) | - |
| Auditing this bundle's own contract for unfalsifiable rules and accreted bulk | open | [audit-the-contract-for-unfalsifiable-rules](/meta/matters/audit-the-contract-for-unfalsifiable-rules.md) | Backlog, unsequenced — no queue position stated; which of this matter and the size counterweight runs first is undecided |
| Whether the "smarter models" framing is motivated reasoning | closed | unrouted | - |
| Dedup gold row harvested from the operator's phrasing | closed | [dedup-probe](/meta/evals/dedup-probe.md) | - |

## User

<routes ref="em:0dc544 em:ed8315">
https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models

For example, when we read transcripts of our own internal usage of Claude Code, we see several conflicting messages in a single request like “leave documentation as appropriate,” or “DO NOT add comments” as our system prompt, skills, and user requests clash with each other. 

what system of auditing does anthropic maintain to prevent contradictory instruction across contextual sources? is there a record of this? how did this slip through, unless auditing has been until now (apparently) prohibitively challenging?
</routes>

## Assistant

The article is filed, and your question turned out to have a sharper answer than "they weren't looking" — so it got its own document.

<routes ref="em:ed8315">
The short version: **there is no auditing system for instruction conflict, and there wasn't one to slip past.** Anthropic found these conflicts the way you'd find them in your own repo — a person read session transcripts and noticed the model had been handed contradictory orders. The tooling they shipped in response (`/doctor`) checks whether your config files parse, whether skills are unused, whether text duplicates what's already in the codebase. It does not check whether two loaded instructions disagree. Your instinct that auditing has been prohibitively challenging is right, and I think it's stronger than "challenging" — the check has no clean definition of correct.
</routes>

---

> what system of auditing does anthropic maintain to prevent contradictory instruction across contextual sources?

<routes ref="em:ed8315">
None that is published, on the surfaces I searched. The nearest thing is `/doctor` (alias `/checkup`), and its scope is worth stating precisely because the gap is the interesting part. Per Anthropic's configuration docs it reports "installation health, invalid settings files, unused extensions, duplicate subagent names in the same directory, and checked-in `CLAUDE.md` content Claude can derive from the codebase" — plus, per the v2.1.205 release note, unused skills/MCP servers/plugins "versus their context cost", dedup of local against checked-in `CLAUDE.md`, and slow hooks.
</routes>

Every one of those has a mechanical oracle: does it parse, is it a duplicate string, is it referenced, is it derivable. **None is a semantic-agreement check.** `/doctor` will tell you a skill is unused; it will not tell you the skill still loaded contradicts your memory file on comment policy.

The docs do name the problem — "Adherence drops when an instruction is vague enough to interpret multiple ways, when two files give conflicting direction, or when the file has grown long enough that individual rules get less attention" — but that's advice to the author, not a check that runs.

Scope of that negative, since it's load-bearing: I enumerated `code.claude.com` via its `llms.txt` page index rather than guessing URLs, then read the config-debugging page, the `/doctor` release note, the originating post, and a general web search. It's a claim about *published* mechanisms — internal eval practice isn't observable from outside.

> is there a record of this?

The blog post itself is the record, and it's unusually direct — a vendor describing the failure in its own flagship product. That's the passage you quoted. There's no incident report, postmortem, or tracking artifact behind it that I could find.

> how did this slip through, unless auditing has been until now (apparently) prohibitively challenging?

Four properties, and the fourth is the one that defeats the obvious fix:

1. **No error surface.** Both instructions are individually well-formed and individually sensible. Only the conjunction is defective, and conjunctions don't throw.
2. **The composed set is ephemeral.** It exists only inside a request. There's no build step where system prompt + skills + memory + user turn are materialized for inspection — and the user turn, one of the conflicting parties, is unknowable ahead of time.
3. **The clash is semantic, not syntactic.** "Leave documentation as appropriate" and "DO NOT add comments" share no keyword. Detecting it means the detector is itself a language model — expensive, non-deterministic, over a combinatorial number of source pairings.
4. **Conflicts are frequently intentional.** A specific instruction overriding a general default is how layered config is *supposed* to work. A checker can't separate a legitimate override from an accident without precedence intent that's almost never written down — so it would fire constantly on correct setups.

That's why they chose reduction over detection. Cutting 80% of the system prompt shrinks the space where contradictions can form without finding any particular one. It's a mitigation, not a check.

**This bites here.** Your contract is compiled from many independently-authored policy documents and loaded in full every session — structurally the same accumulation surface. Two of its rules already push the other way (`governance-artifact-routing` keeping policies terse, the `index.md` tree doing progressive disclosure), but nothing in the gate suite checks two policies for disagreement, and by the analysis above nothing cheaply could.

| Type | Doc | Why this type |
|---|---|---|
| `reference` | [new-rules-of-context-engineering-claude-5.md](https://github.com/ob6to8/elixir-mind/blob/claude/anthropic-instruction-auditing-x87wly/knowledge/SWE/agentic/context-engineering/new-rules-of-context-engineering-claude-5.md) `em:0dc544` | Captured and distilled external material; layered breakdown per the technical-source rule |
| `claim` | [instruction-conflict-has-no-mechanical-oracle.md](https://github.com/ob6to8/elixir-mind/blob/claude/anthropic-instruction-auditing-x87wly/knowledge/SWE/agentic/governance/instruction-conflict-has-no-mechanical-oracle.md) `em:ed8315` | My synthesis, not independently verified — `verified: false`, no `resource`. True regardless of this brain, so it files in the taxonomy rather than as governance |

| File | Change |
|---|---|
| `context-engineering/index.md` | Listed the new reference |
| `governance/index.md` | Listed the new claim |
| `meta/evals/dedup-probe.md` | Harvested your phrasing as a gold row |
| `meta/registry.md` | Regenerated for the two new ids |

| Action | Result |
|---|---|
| Fetched the post twice | First fetch returned a summary, not the source's words; re-fetched demanding verbatim spans before quoting anything |
| Dedup sweep, synonym-expanded | No duplicate; nearest neighbour `em:988147` is a third-party post on a personal CLAUDE.md |
| Gate suite + commit + push | All green; `debcfde` on `claude/anthropic-instruction-auditing-x87wly` |

Two notes on judgment calls I made:

**I filed a second document you didn't ask for.** `/intake` scope was the article; the claim doc is your question's answer promoted to a filed artifact. I judged it worth filing because it's exactly the kind of finding that gets re-derived otherwise, and it landed in an existing directory so no ratification was needed. Say the word and I'll drop it.

**`provenance` on the claim reads "model undisclosed."** Your `model-attribution` policy wants the model named; this environment forbids putting the model identifier in pushed artifacts. The policy anticipates exactly that case and prescribes `model undisclosed`, so I took it — but you should know the field is honest-but-empty rather than filled in. A small live instance of the very thing the document is about.

| # | Option | What it entails |
|---|---|---|
| 1 | Open a PR | Not done — you didn't ask, and `/intake` doesn't authorize it |
| 2 | Audit the contract against the post's concision thesis | An `analysis` measuring where the compiled contract duplicates or contradicts itself; sizeable, and the post gives it a defensible basis |
| 3 | Drop the claim doc | If you read it as scope creep on a plain intake |

## User

are layered override configs 100% reliable? if not, and i fail to see how they are, this seems kind of like a bad idea

## Assistant

You've found a real hole — and it's in my document, not just in Anthropic's design. Let me check the primary source on this before I answer, because the distinction turns out to matter.

The answer is no, and Anthropic says so in writing. But the reason is sharper than "not 100%": **there are two different layers here, and only one of them is a config system at all.**

<routes ref="em:ed8315">
**Settings are a real override system.** Permissions, hooks, env — those merge deterministically in code before the model sees anything. Per the config docs: "Managed settings always win when present. Among the rest, the closer scope overrides the broader one in the order local, then project, then user." One value survives the merge. That is reliable, because it's a function.
</routes>

<routes ref="em:ed8315">
**Instructions are not an override system.** There is no merge step. `/context` shows what occupies the window "broken down by category: system prompt, system tools, MCP tools, custom subagents..., memory files, skills, and conversation messages" — all of it, coexisting. Nothing is resolved away. Every layer's text arrives simultaneously and the model arbitrates on the fly. There is no documented precedence rule saying a skill beats CLAUDE.md, because there is no code that would implement one.
</routes>

So "layered override config" describes the settings half accurately and the instruction half not at all. The instruction half is prompt concatenation wearing a config system's clothes — scopes, file hierarchies, precedence-flavored documentation — which invites exactly the expectation it cannot meet.

Anthropic draws this line themselves, and it's the most useful sentence I found in their docs:

> CLAUDE.md and permissions solve different problems. CLAUDE.md tells Claude how your project works so it makes good decisions. Permissions and hooks enforce limits regardless of what Claude decides. Use CLAUDE.md for "we do it this way here." Use permissions or hooks for security boundaries and anything that must never happen, where you need a guarantee instead of guidance.

**Guarantee versus guidance.** That's the whole thing. The instruction layer is explicitly not claimed to be reliable, and when reliability matters you're told to leave it entirely.

Is it a bad idea? The layering isn't — you need *some* way to express org defaults plus project specifics. What's bad is the affordance mismatch, and it has a concrete cost: adding a layer to fix behavior in one place can silently degrade it elsewhere, with no error and no diff to inspect. That's also why "delete 80% of it" is a coherent response. If you can't resolve conflicts, reduce the number of things that can conflict.

Your point sharpens property 4 of the doc I filed, which was too generous — let me fix it, since no PR is open and this is still in-flight.

## Assistant

**No, they aren't reliable — and your "bad idea" read is closer to right than my document was.**

The correction is committed (`b91a70c`) and pushed. Property 4 originally said override was "the mechanism by which layered configuration is *supposed* to work," which credited the instruction layer with semantics it doesn't implement. That was the wrong concession to make.

What's now in the document:

| | Settings (permissions, hooks, env) | Instructions (system prompt, memory files, skills, user turn) |
|---|---|---|
| Resolution | deterministic merge, in code, before the model runs | **none** — every layer's text coexists in the window |
| Precedence | documented and total | undocumented; no rule says a skill beats a memory file |
| Losing value | discarded by the merge; never reaches the model | still present, still read, still competing |
| Failure mode | overridden as specified | the model arbitrates, silently, per request |

The sharpened property 4: the ambiguity that defeats a *detector* is the same one that defeats the *model* — neither can separate an intended override from an accidental contradiction, because the intent is nowhere encoded. That's a stronger claim than the original and it follows from your question rather than around it.

**One thing I'd push back on slightly.** The layering isn't itself a bad idea — org defaults plus project specifics has to live somewhere, and the settings half does it correctly. What's bad is that the instruction half wears the same clothes: scopes, file hierarchies, precedence-flavored docs, none of it backed by a resolution function. That mismatch is what makes people write more emphatic instructions expecting more binding behavior, which is a strategy with no mechanism behind it.

The design rule that fell out, now in the doc: reliability is bought by moving a rule to a layer that can enforce it, never by wording it more emphatically. Which is what this repo already does — mechanical oracles gate, prose conventions stay editorial. You'd arrived at the same fork independently.

| Action | Result |
|---|---|
| Rewrote property 4 | Removed the override concession; ambiguity now framed as defeating detector and model alike |
| Added "Layered instructions are not an override system" | Two-layer table, the guidance-vs-guarantee quote from the config docs, and the design rule |
| Updated description + index gloss | Both reflect the widened scope |
| Gate suite, commit, push | Green; `b91a70c` on the branch |

| # | Option | What it entails |
|---|---|---|
| 1 | Leave it here | The intake and its correction are both landed; no PR opened (you haven't asked for one) |
| 2 | Promote the design rule to a `belief` | "Reliability is bought by moving a rule to the enforcing layer" is a decision prior you already act on — it'd be citable from policy rather than buried in a claim doc |
| 3 | Audit the contract for the same mismatch | Which of its rules assume binding force they can't have, and which have a gate behind them |

## User

could this possibly imply that the whole "these smarter models are now so smart they don't need claude.md guidance as much" is really cover for the fact that they got busted with conflicting orders by a vendor and realized they had overengineered a bunch of instructions that they had no real idea were working, let alone well together, and its better to just delete them, but that's embarassing to say "this stuff never completely worked" and better to say "now with smarter models..."?

## Assistant

**Partly. The substance of your read holds; the "cover story" framing overshoots — and there's a version of your point that's sharper than the cynical one.**

<routes ref="em:ed8315">
Here's the hinge, which I just checked. The post's load-bearing evidence is that deleting 80% produced "no measurable loss on our coding evaluations." That result is **identical under both hypotheses**:
</routes>

- **(a)** The model got smart enough that the instructions became unnecessary.
- **(b)** The instructions were never doing measurable work in the first place.

An eval that doesn't move when you delete something tells you the something wasn't contributing *now*. It says nothing about whether it ever was. To separate (a) from (b) you need the counterfactual — run the same deletion against an older model and show *that* one regresses.

The post doesn't report it. I asked the source directly for any ablation, cross-generation comparison, or eval methodology, and there is none. The nearest thing is an assertion that the constraints "were once needed to avoid worst case scenarios," offered without the experiment that would establish it. So the causal story — *the models changed, therefore the instructions became redundant* — is asserted, not demonstrated. Your instinct that they had "no real idea whether they were working" is not just plausible; it's the reading the published evidence underdetermines.

And it's worse than an oversight. It's **entailed by what we filed earlier**: with no oracle for instruction conflict and no per-instruction attribution in evals, there was never a mechanism by which anyone could have known which instructions were load-bearing or whether they cohered. Not a lapse in diligence — an absence of instrumentation.

**Where I'd push back.** A cover story doesn't usually volunteer the damning detail. They didn't have to write that they read their own transcripts and found their system prompt, skills, and user requests clashing. That admission is the single most incriminating fact in the post, and it's in the post, unprompted. Concealment and voluntary disclosure of the worst fact don't sit together comfortably.

What I think actually happened is more ordinary than a cover-up and less flattering than the headline: the framing is **emphasis, not concealment**. Title and thesis point forward (new models, new rules) because that's what a product blog does; the backward-facing fact is present but not the lede. That's marketing gravity, not a lie.

**Also, your binary may be too clean.** The removed 80% was almost certainly heterogeneous — some genuinely load-bearing for weaker models, some redundant from day one, some actively harmful through conflict. "Which was it?" may have no single answer, and the honest post would have said *we don't know the split, and we lacked the instrumentation to find out*. That sentence would have been more useful than either story.

The generalizable lesson, which is worth more than adjudicating Anthropic's motives: **a deletion that doesn't move your evals is not evidence the deleted thing was obsolete — it's evidence your evals never measured it.** That applies to your contract too, if you ever trim it and nothing appears to break.

| # | Option | What it entails |
|---|---|---|
| 1 | File the underdetermination point as a `belief` | "A no-loss ablation cannot distinguish newly-redundant from never-load-bearing" — a reusable prior for evaluating any prompt trim, including your own contract's |
| 2 | Add it as a section to `em:ed8315` | Cheaper; keeps the eval-blindness argument beside the no-oracle argument it follows from |
| 3 | Leave it in conversation | I'd advise against — per your own `deferred-work-is-filed`, this is exactly the kind of finding that evaporates |

I'd take **2**: it's the same argument one step further (no oracle at authoring time → no attribution at eval time), and splitting it across two docs would fragment it. But this is a new unit beyond the intake this thread carries, so it's your call rather than mine to make unilaterally.

## User

"And while these constraints were once needed to avoid worst case scenarios, we have since found we can delete many of them and let the model use surrounding context and judgement instead."

in what way does "guidance" for a non-deterministic model avoid "worst case scenarios"? that sounds like a made up thing. i mean, has anthropic ever advised people to write claude.md's to "avoid worst case scenarios"?

I think they HAD to reveal the conflict event and then pivot to position it as a proactive measure, the bug became a feature. that said, i don't think its a conspiracy, because my bet is its mostly unconscious

no one even discusses the groupthink and political implications of a company-created claude.md

2, agree

## Assistant

Your instinct is right, and their own documentation is the witness.

<routes ref="em:ed8315">
**No — Anthropic has never advised CLAUDE.md for worst-case avoidance. They advise the opposite, repeatedly and explicitly.** From the memory docs: CLAUDE.md and auto memory are "context, not enforced configuration. To block an action regardless of what Claude decides, use a PreToolUse hook instead." And on the org-wide deployment page: "Settings rules are enforced by the client regardless of what Claude decides to do. CLAUDE.md instructions shape Claude's behavior but are not a hard enforcement layer." There's even a routing table sending "Block specific tools, commands, or file paths" to managed settings and leaving CLAUDE.md with style and "behavioral instructions."
</routes>

> in what way does "guidance" for a non-deterministic model avoid "worst case scenarios"? that sounds like a made up thing.

It can't, and the retroactive claim is doing something the docs deny. An instruction shifts a distribution; it cannot bound a tail. "Avoiding worst cases" is a claim about the tail — precisely the thing you're told to use hooks for. The blog was describing the *system prompt* rather than CLAUDE.md, but that distinction doesn't rescue it: the system prompt is the same non-deterministic guidance layer with no enforcement power.

So the sentence retroactively assigns a guarantee-role to a layer their documentation says has never had one. Whether the constraints ever prevented anything is unmeasurable in principle — you'd need the counterfactual distribution over the bad outcomes, which nobody has.

One more thing surfaced in those docs that strengthens the whole picture: "if two rules contradict each other, Claude may pick one arbitrarily." They know. Documented. And the prescribed remedy is that you should "review your CLAUDE.md files... periodically to remove outdated or conflicting instructions" — unaided human review, which is the absence of auditing stated as a user responsibility.

> I think they HAD to reveal the conflict event and then pivot to position it as a proactive measure, the bug became a feature. that said, i don't think its a conspiracy, because my bet is its mostly unconscious

I think this is right, and the "unconscious" qualifier is what makes it right. The mechanism doesn't need anyone to decide to spin. They had to reveal *something*: you cannot ship `/doctor` — a tool that rightsizes your context — without a story about what's wrong with current context. The conflict finding is the product's justification, so it had to appear. What makes it read as a pivot is that the causal arrow gets reversed on the way out: *we found our instructions were incoherent* becomes *models improved, so instructions became unnecessary*. Same facts, and the second framing requires the counterfactual nobody ran.

Motivated reasoning explains this fully without anyone lying. The people writing the post believe the models got better — they'd have plenty of evidence for that independently — and that belief supplies a ready explanation that happens to be flattering, so the unflattering one never gets tested. That's ordinary, and it's why the missing ablation matters more than anyone's intent.

> no one even discusses the groupthink and political implications of a company-created claude.md

This is the least-explored thing in the whole conversation, and I think it's the most consequential.

<routes ref="em:ed8315">
A company CLAUDE.md is a normative document with three properties that rarely co-occur:
</routes>

**It binds everyone but appears in no diff.** It shapes every PR in the org while being invisible in every PR. The influence is total and the attribution is nil.

**Its claims are unfalsifiable, so disputes resolve politically.** This follows directly from the no-oracle finding. "Should we keep *always write tests first*?" has no experiment behind it. Nobody can run the A/B. So the question is settled by whoever has standing — seniority, tenure, force of argument — and the outcome gets encoded as if it were a technical fact. The document launders preference into policy.

<routes ref="em:ed8315">
**It ratchets.** Adding a line is cheap and socially rewarded — you're helping. Removing one means arguing that a colleague's contribution was worthless, against no evidence either way, since none exists. Additions face no resistance and deletions face a person. Monotonic growth is the equilibrium.
</routes>

Put those together and you don't need bad actors to arrive at 80% removable. You need only a document that can't be measured, can't be attributed, and is socially expensive to cut. That is a mechanism, and it predicts the outcome Anthropic reported.

The compounding effect: everyone's agent gets the same priors, so approach diversity across a codebase collapses toward whoever wrote the file. Model compliance then reads as validation — the agent follows the rule, which *feels* like the rule working, when compliance and benefit are unrelated. And a governance document that isn't code, isn't docs, and isn't policy has no review cadence, no owner, and no staleness signal.

Adding the approved section now.

## Assistant

Landed as `d0b6394`. The claim doc now runs the argument through three layers, each following from the same missing instrument:

| Layer | What's missing | Consequence |
|---|---|---|
| Authoring | conflict detection | contradictions ship silently |
| Evaluation | per-instruction attribution | an ablation that moves nothing is uninformative about what it removed |
| Governance | any empirical settlement | disputes resolve by standing; additions ratchet |

That third row is your groupthink point, and I went ahead and included it — it turned out to be causally continuous with the other two rather than a separate subject, and splitting it into its own doc would have fragmented one argument across two files. If you'd rather it stood alone, say so and I'll lift it out.

| What I modified | Change |
|---|---|
| `em:ed8315` | Added "The eval is blind in the same way the authoring was" and "Why the layer accretes"; scoping section now carries both negative halves separately |
| `governance/index.md` | Gloss extended to cover the evaluation and governance layers |

| Action | Result |
|---|---|
| Checked the "worst case scenarios" claim against `memory.md` | Anthropic advises the opposite — CLAUDE.md is "context, not enforced configuration"; anything that must not happen routes to hooks/permissions |
| Queried the post for a cross-generation ablation | None reported; recorded as a separately-scoped negative |
| Gate suite, commit, push | Green; `d0b6394` |

Two things I did **not** put in the document, because they're about motive rather than mechanism: the "had to reveal it" reading and the unconscious-pivot hypothesis. Those are inferences about why Anthropic wrote what they wrote, and I can't ground them — the mechanism stands on its own without needing anyone's intent to be established. The doc argues the accretion is structural, which is the stronger and more portable claim anyway.

One flag on the environment: `Cloudflare_Developer_Platform` and `alphaXiv` need authorization before their tools work, and this session can't run the OAuth flow. For claude.ai connectors that's your connector settings; otherwise `claude mcp` or `/mcp` in an interactive session. Nothing in this thread needed them.

| # | Option | What it entails |
|---|---|---|
| 1 | Open a PR | Still not done — three commits sitting on the branch, and you haven't asked |
| 2 | Audit the contract against its own argument | Which rules have a gate behind them, which are unfalsifiable prose, and which got added because adding was cheap |
| 3 | Promote the two transferable rules to `belief`s | "Reliability is bought by moving a rule to the enforcing layer" and "a no-loss ablation is evidence about your evals, not the deleted thing" — both are priors you'd cite from policy |

## User

create a matter to audit the contract
/create-pull-request  merge

## Assistant

Matter filed and verified. Before the close, I inventoried what's still open per `concerns-block-the-close` — nothing blocking. The groupthink section I flagged last turn you moved past, gates are green, and no checks were skipped. One scope note goes in the report rather than halting the flow.

Running the close.
