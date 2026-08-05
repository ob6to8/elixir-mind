---
id: em:ed8315
type: claim
title: "Instruction conflict across composed context sources has no mechanical oracle"
description: Contradictory instructions arriving from system prompt, skills, memory files, and the user request produce no error signal — the model silently picks one — so the defect is caught by reading transcripts rather than by validation, and the tooling that exists audits structure and cost rather than semantic agreement.
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
4. **Conflicts are frequently intentional.** A specific instruction overriding
   a general default is the mechanism by which layered configuration is
   *supposed* to work. A detector cannot distinguish a legitimate override from
   an accidental contradiction without knowing precedence intent that is
   usually unwritten.

Property 4 is the one that defeats naive tooling: a checker that flagged every
disagreement between layers would fire constantly on correct configurations.

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

## Status of this claim

Filed unverified. The negative half — that no conflict-detection auditing is
published — is scoped to what was searched: Anthropic's Claude Code
documentation host (via its `llms.txt` page index), the `/doctor` and
configuration-debugging pages, the originating blog post, and a general web
search. It is a claim about **published** mechanisms; internal evaluation
practice at any vendor is not observable from outside, and its absence from
documentation is not evidence of its absence in practice.
