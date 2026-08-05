---
id: em:ed8315
type: claim
title: "Instruction conflict across composed context sources has no mechanical oracle"
description: Contradictory instructions arriving from system prompt, skills, memory files, and the user request produce no error signal — the model silently picks one — so the defect is caught by reading transcripts rather than by validation; the tooling that exists audits structure and cost rather than semantic agreement, and the instruction layer implements no override despite presenting as layered configuration, so anything that must hold belongs in the deterministic layer instead; the same blindness recurs at evaluation time, where an ablation that moves no metric cannot distinguish newly-redundant from never-load-bearing, and at governance time, where unfalsifiable claims resolve by standing and the layer accretes.
provenance: "Claude Code session, model undisclosed — synthesized from Anthropic's context-engineering post and the Claude Code configuration docs"
tags: [agentic, governance, context-engineering, instruction-conflict, claude-code, oracles, verification, claude-md, skills]
timestamp: 2026-08-05
verified: false
attribution:
  when: 2026-08-05T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator /intake session on Anthropic's context-engineering post"
  why: "operator asked what auditing prevents contradictory instruction across contextual sources and how the conflicts Anthropic reported went uncaught; the answer generalizes past that one vendor"
---

# Instruction conflict has no mechanical oracle

## The claim

An agent's instructions are **composed at runtime from independently-authored
sources** — a vendor system prompt, an organization's skills, a repository
memory file, a user's request, tool descriptions. No single author sees the
assembled set, and the assembly exists as an artifact at no point where anyone
reviews it. When two of those sources disagree, **nothing fails**: the model
resolves the contradiction silently and proceeds. There is no parse error, no
type error, no failing test.

That absence of a signal is the whole problem. A defect class with no oracle
cannot be gated, so it is discovered only by a human reading transcripts and
noticing the model was arguing with itself.

## The evidence

Anthropic's own report of the failure is the strongest available data point,
because it is a vendor describing its own flagship deployment:

> For example, when we read transcripts of our own internal usage of Claude
> Code, we see several conflicting messages in a single request like "leave
> documentation as appropriate," or "DO NOT add comments" as our system prompt,
> skills, and user requests clash with each other.

— [The new rules of context engineering for Claude 5 generation models](/knowledge/SWE/agentic/context-engineering/new-rules-of-context-engineering-claude-5.md)

Two properties of that sentence carry the claim. The discovery method is
**"when we read transcripts"** — retrospective, manual, human. And the sources
named — system prompt, skills, user requests — are authored by *different
parties on different schedules*, which is why no review pass covers them
jointly.

## What the available tooling actually audits

Claude Code's `/doctor` (aliased `/checkup`) is the productized response, and
it is worth being precise about its scope, because the gap is instructive.
Per Anthropic's configuration documentation, it reports **"installation health,
invalid settings files, unused extensions, duplicate subagent names in the same
directory, and checked-in `CLAUDE.md` content Claude can derive from the
codebase, with proposed fixes"**, and the release note adds finding unused
skills, MCP servers and plugins **"versus their context cost"**, deduplicating
local `CLAUDE.md` files against checked-in ones, and flagging slow hooks.

Every one of those is a **structural or cost** check with a mechanical oracle:
does the file parse, is the name duplicated, is the extension referenced, is
this text derivable from the repository. **None is a semantic-agreement check.**
`/doctor` will tell you a skill is unused; it will not tell you that the skill
still loaded contradicts your memory file about comment policy.

The docs come closest to the issue in guidance rather than tooling, naming
conflict as one cause among several of poor adherence: **"Adherence drops when
an instruction is vague enough to interpret multiple ways, when two files give
conflicting direction, or when the file has grown long enough that individual
rules get less attention."** That is advice to the author, not a check.

## Why it is hard, not merely neglected

The natural reading — that auditing was neglected — understates it. Four
properties make the check genuinely resistant:

1. **No error surface.** Contradiction is not a malformed input. Both
   instructions are individually well-formed and individually reasonable; only
   their conjunction is defective.
2. **The composed set is ephemeral.** It exists only inside a request. There is
   no build step at which the union of system prompt, skills, memory, and user
   turn is materialized for inspection — and the user turn, one of the
   conflicting parties, is unknowable before runtime.
3. **Contradiction is semantic, not syntactic.** *"Leave documentation as
   appropriate"* and *"DO NOT add comments"* share no keyword. Detecting the
   clash requires understanding both, which means the detector is itself a
   language model — an expensive, non-deterministic gate over a combinatorial
   number of source pairings.
4. **Conflicts are frequently intentional — and the layer cannot tell.** A
   specific instruction overriding a general default is what an author usually
   *means* by layering. But the instruction layer implements no override, so
   the ambiguity that defeats a detector is the same ambiguity that defeats the
   model at runtime: neither can separate an intended override from an
   accidental contradiction, because the intent is nowhere encoded.

Property 4 is the one that defeats naive tooling: a checker that flagged every
disagreement between layers would fire constantly on correct configurations.

## Layered instructions are not an override system

The phrase "layered configuration" conflates two mechanisms with opposite
reliability, and the conflation is the trap.

| | Settings (permissions, hooks, env) | Instructions (system prompt, memory files, skills, user turn) |
|---|---|---|
| Resolution | deterministic merge, executed in code before the model runs | **none** — every layer's text coexists in the context window |
| Precedence | documented and total: managed wins; otherwise local, then project, then user | undocumented; no rule states that a skill beats a memory file |
| Losing value | discarded by the merge; never reaches the model | still present, still read, still competing |
| Failure mode | a value is overridden as specified | the model arbitrates, silently, per request |

Only the first column is an override system. The second is prompt
concatenation presenting as configuration — it has scopes, file hierarchies,
and precedence-flavored documentation, which invites an expectation of
deterministic resolution that nothing implements. Claude Code's own
documentation states the split plainly, and states which side carries a
guarantee:

> CLAUDE.md and permissions solve different problems. CLAUDE.md tells Claude
> how your project works so it makes good decisions. Permissions and hooks
> enforce limits regardless of what Claude decides. Use CLAUDE.md for "we do it
> this way here." Use permissions or hooks for security boundaries and anything
> that must never happen, where you need a guarantee instead of guidance.

**The design rule that follows:** anything that must hold goes in the
deterministic layer — hooks, permissions, a gate suite, generated artifacts
checked with `--check`. The instruction layer is advisory by construction, and
treating it as binding is a category error regardless of how the instruction is
worded or where it is placed. Reliability is bought by moving a rule to a layer
that can enforce it, never by phrasing it more emphatically.

## The transferable rule

Where a property has no mechanical oracle, the alternatives are **prose
standards held in review**, or **reduction of the surface** so conflicts have
fewer places to arise. Anthropic chose the second: removing over 80% of the
system prompt shrinks the space in which a contradiction can form, without
detecting any particular one. Reduction is a mitigation, not a check — it
lowers the conflict rate and leaves the class undetected.

This bundle reached the same fork independently in its
[coding standards](/meta/policy/elixir-coding-standards.md), which route every
standard with a mechanical oracle into a gate and write the rest down as
editorial conventions. The
[semantic gap](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md)
framing applies directly: a governance check must fire where the property
becomes legible, and instruction conflict becomes legible only at the level of
the fully-composed request — a level no current tool materializes.

## The eval is blind in the same way the authoring was

The no-oracle problem does not stop at authoring time. It recurs at evaluation
time, and the second occurrence is what makes the first uncorrectable.

Anthropic's stated evidence for the deletion is that removing over 80% of the
system prompt produced **"no measurable loss on our coding evaluations."** That
result is identical under two incompatible hypotheses:

- **(a) Newly redundant** — the instructions were load-bearing for earlier
  models and stopped being so.
- **(b) Never load-bearing** — the instructions were not doing measurable work
  at any point.

An ablation that does not move a metric shows the ablated thing is not
contributing **now**. It carries no information about whether it ever did.
Separating (a) from (b) requires the cross-generation counterfactual: apply the
same deletion to the older model and show *that* one regresses. The post does
not report such an experiment, an ablation, or any eval methodology beyond the
headline result — checked by querying the source directly for one. Its causal
claim, that the constraints **"were once needed to avoid worst case
scenarios"**, is therefore asserted rather than demonstrated.

**The retroactive necessity claim is also the wrong shape for the layer.** An
instruction shifts a distribution; it cannot bound a tail. "Avoiding worst
cases" is a claim about the tail — exactly the property the guidance layer is
documented not to have, and exactly what users are told to route to hooks and
permissions instead. Whether the deleted constraints ever prevented anything is
unmeasurable in principle, not merely unmeasured: it would require the
counterfactual distribution over bad outcomes that never happened.

**The transferable rule:** *a deletion that does not move your evals is not
evidence the deleted thing was obsolete — it is evidence your evals never
measured it.* Prompt content is not attributed in aggregate benchmarks, so the
instrument that would have caught bloat at authoring time is the same one
missing at deletion time. This applies to any compiled instruction artifact,
including this bundle's own contract: trimming it and observing nothing break
is uninformative unless something was measuring the trimmed rule.

## Why the layer accretes

The absence of an oracle has a social consequence, and it is the mechanism that
produces removable bulk without anyone acting badly.

A shared instruction file is a normative document whose claims **cannot be
settled empirically**. No experiment adjudicates "always write tests first", so
the question resolves by standing — seniority, tenure, persuasiveness — and the
outcome is then encoded in a form indistinguishable from a technical fact.
Preference is laundered into policy.

The asymmetry compounds it. **Adding a line is cheap and socially rewarded**;
removing one means arguing that a colleague's contribution was worthless,
against no evidence in either direction, because none exists. Additions meet no
resistance, deletions meet a person, and monotonic growth is the equilibrium.
Compliance completes the loop: an agent visibly following a rule reads as
validation, though compliance and benefit are unrelated quantities.

Three further properties make the document hard to govern. It binds every
change while **appearing in no diff**, so its influence is total and its
attribution nil. It homogenizes — every engineer's agent inherits the same
priors, collapsing approach diversity toward whoever wrote the file. And it is
neither code, docs, nor policy, so it has no test, no reader who would notice
staleness, and no review cadence.

None of this requires bad actors. A document that cannot be measured, cannot be
attributed, and is socially expensive to cut will accumulate until something
forces a reckoning — which is the outcome actually observed.

## Status of this claim

Filed unverified. Two negative halves, each scoped to what was actually
searched:

- **No conflict-detection auditing is published** — scoped to Anthropic's
  Claude Code documentation host (enumerated via its `llms.txt` page index),
  the `/doctor` release note, the configuration-debugging and memory pages, the
  originating blog post, and a general web search.
- **No cross-generation ablation is reported** — scoped to the originating blog
  post, queried directly for any experiment, ablation, generational
  comparison, or eval methodology.

Both are claims about **published** artifacts. Internal evaluation practice at
any vendor is not observable from outside, and absence from documentation is
not evidence of absence in practice. The accretion argument is mechanistic
rather than measured: it predicts the observed outcome but no attempt was made
here to confirm it against any organization's instruction-file history.
