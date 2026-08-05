---
id: em:0dc544
type: reference
title: "The new rules of context engineering for Claude 5 generation models (Anthropic, 2026-07)"
description: Anthropic removed over 80% of Claude Code's system prompt for Claude Opus 5 and Fable 5 with no measurable eval loss, and reframes context engineering as six shifts — constraints to judgment, examples to interface design, upfront loading to progressive disclosure, repetition to concision, manual to auto memory, and simple specs to rich references.
resource: https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models
provenance: "Thariq Shihipar, member of technical staff, Anthropic — claude.com blog, 2026-07-24"
tags: [context-engineering, claude-code, claude-md, skills, system-prompt, progressive-disclosure, agent-guidance, anthropic, instruction-conflict]
timestamp: 2026-08-05
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator intook the post alongside a question about what auditing prevents contradictory instruction across contextual sources, and how the conflicts it describes went uncaught"
---

# The new rules of context engineering for Claude 5 generation models

## Plain-language summary

Older models needed to be told a great deal: rules, examples, repeated
warnings. Anthropic's position is that this is now counterproductive. They
stripped **"over 80% of Claude Code's system prompt for models like Claude Opus
5 and Claude Fable 5 with no measurable loss on our coding evaluations."**

The argument is that elaborate instruction sets were **compensating for model
weaknesses that no longer exist**, and that the compensation now costs
something. Instructions written for a weaker model become clutter for a
stronger one — and, worse, they accumulate from independent authors until they
disagree with each other.

The post's most concrete evidence is an admission about Anthropic's own usage:

> For example, when we read transcripts of our own internal usage of Claude
> Code, we see several conflicting messages in a single request like "leave
> documentation as appropriate," or "DO NOT add comments" as our system prompt,
> skills, and user requests clash with each other.

The remedy offered is to say **less**, and to place what remains where it is
actually needed. The productized form is the `/doctor` command:
**"We've put these best practices in `claude doctor;` use the command /doctor
in Claude Code to rightsize your skills, and CLAUDE.md files."**

## Key terms

- **Unhobbling** — the post's framing for removing scaffolding that was
  constraining a model rather than helping it. Instructions added to patch a
  weakness keep binding after the weakness is gone.
- **Progressive disclosure** — loading information at the moment it is needed
  rather than up front. Verification guidance moved out of the system prompt
  and into callable skills; some tools use *deferred loading*, where the model
  searches for a tool definition before using it.
- **Interface design over examples** — rather than demonstrating correct usage
  in prose, shape the tool's parameters and surface so correct usage is the
  obvious one.
- **Rich references** — supplying high-fidelity source material (a test suite,
  a real HTML artifact, actual code, a rubric) instead of a markdown
  description of that material.
- **Auto memory** — Claude saving relevant memories itself, displacing manual
  curation of CLAUDE.md.
- **Rightsizing** — trimming a skill or memory file to the content that is
  neither derivable from the codebase nor already embodied by the product.

## The six shifts

| From | To |
|---|---|
| Constraints | Judgment — guidance like *"Write code that reads like the surrounding code: match its comment density, naming, and idiom"* over rigid rules |
| Examples | Interface design — clearer tool parameters that hint at appropriate use |
| Upfront loading | Progressive disclosure — guidance in callable skills, deferred tool loading |
| Repetition | Concision — remove duplicate instructions across system prompt and tool descriptions |
| Manual memory | Auto memory |
| Simple specs | Rich references — test suites, artifacts, real code, rubrics |

## Where each surface should carry weight

The post's applied framework assigns a distinct job to each layer, which is the
part that transfers directly to any agent deployment:

- **System prompt** — defines the product context; rarely modified.
- **CLAUDE.md** — kept lightweight; gotchas and codebase peculiarities, not a
  rulebook.
- **Skills** — team-specific opinions and best practices, with progressive
  disclosure for anything lengthy.
- **References** — high-fidelity resources: code, mockups, specifications.

## Read against this brain

This bundle's [operating contract](/CLAUDE.md) is a large compiled artifact
loaded in full every session, so the concision shift is a live tension rather
than an abstract one. Two of the contract's own rules already move in the
post's direction, and were adopted independently of it:
[governance-artifact-routing](/meta/policy/governance-artifact-routing.md)
requires policies stay terse with reasoning relegated to cross-linked
tutorials, and [link-processing](/meta/policy/link-processing.md) plus the
`index.md` tree implement progressive disclosure over the knowledge itself.

The conflict finding cuts the other way, and is the sharper one: a contract
compiled from many independently-authored policy documents is *exactly* the
accumulation surface the post describes. See
[instruction conflict has no mechanical oracle](/knowledge/SWE/agentic/governance/instruction-conflict-has-no-mechanical-oracle.md)
for why that class of defect is caught by transcript reading rather than by
validation.

Compare [Streamlining my user-level CLAUDE.md](/knowledge/SWE/agentic/context-engineering/streamlining-user-level-claude-md.md),
which reaches the trim-to-what-the-product-doesn't-already-do conclusion from
practitioner observation seven months earlier, and
[Brevity constraints reverse performance hierarchies](/knowledge/SWE/agentic/prompt-design/brevity-constraints-reverse-performance-hierarchies.md),
which finds the same verbosity-hurts-larger-models effect on the output side.

# Citations

- Thariq Shihipar, "The new rules of context engineering for Claude 5
  generation models", Anthropic, 2026-07-24 —
  <https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models>
- Section headings as published: *Unhobbling Claude* · *Then and now* ·
  *Applying this to your context* · *Try simplifying*

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:0dc544">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-05-anthropic-context-engineering-intake-and-instruction-conflict (2026-08-05)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:0dc544`]**  (co-feeds: `em:ed8315`)

https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models

For example, when we read transcripts of our own internal usage of Claude Code, we see several conflicting messages in a single request like “leave documentation as appropriate,” or “DO NOT add comments” as our system prompt, skills, and user requests clash with each other. 

what system of auditing does anthropic maintain to prevent contradictory instruction across contextual sources? is there a record of this? how did this slip through, unless auditing has been until now (apparently) prohibitively challenging?
