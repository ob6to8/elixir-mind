---
type: analysis
title: "Anthropic's primary-source surfaces — a seven-host map, and the miss that motivated it"
description: Anthropic's authoritative documentation is spread across seven distinct hosts with almost no cross-linking, so a search scoped to the two best-known ones silently misses whole categories of primary material — as happened when a public 39-page exam guide was reported as nonexistent.
provenance: "Claude Code session, 2026-07-27 — commissioned after a primary-source miss during CCA certification research"
tags: [meta, analysis, research-methodology, anthropic, primary-sources, intake]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, interactive session on CCA certification study"
  why: "operator commissioned a source-inventory spike after the agent wrongly reported that no primary CCA blueprint or pricing existed, having searched only two of Anthropic's seven documentation hosts"
---

# Anthropic's primary-source surfaces

## The question

Where does Anthropic's authoritative documentation actually live, and why did a
competent search miss a public 39-page exam guide?

## The miss

While researching the Claude Certified Architect certification, this brain's
agent reported that no primary source stated the exam's price, domain
weightings, or structure — and filed a plan built on that premise. All three
were published by Anthropic, in a public PDF, linked from a page one click from
one the agent had already read.

The mechanics of the failure are worth stating exactly, because the lesson
generalizes past this one topic:

1. **Search scoped to the famous hosts.** Queries used
   `site:anthropic.com OR site:claude.com`. Anthropic's certification material
   lives on neither.
2. **A primary page was read, and it happened not to carry the facts.** The
   Academy's individual CCA certification page states exam *scope* but no
   pricing or blueprint. It links an "Exam guide" PDF; that link was not
   followed.
3. **Absence on checked pages was reported as absence everywhere.** The claim
   made was "no primary source states this." The claim justified was "the pages
   I checked don't state this." That gap is the whole error.

The third step is the transferable one. It is a category error an agent is
structurally prone to: search returns a finite result set, and the absence of a
fact within it feels like evidence about the world rather than about the query.

**The corrective is a rule, not more effort:** *state what was searched, and
report absence relative to that scope.* "I did not find X on the docs site or
the corporate site" is honest and actionable. "No primary source states X" is a
claim about every source, and needs an enumerated search space to be sayable —
which is what the map below provides.

## The map

Seven hosts, each authoritative for a different category, with sparse
cross-linking between them.

| Host | Authoritative for | Notes |
|---|---|---|
| `anthropic.com` | corporate news, research, policy, model announcements, `/learn` guides | the marketing/news surface; **not** where product docs live |
| `claude.com` | product marketing, the blog, `/partners`, `/resources/courses`, `/resources/certifications` | distinct from anthropic.com; certification and course *catalogs* live here |
| `platform.claude.com` | the **Claude API**: Messages, tool use, prompt caching, batches, extended thinking, Managed Agents, client SDKs | formerly `docs.claude.com`, which 301s here |
| `code.claude.com` | **Claude Code and the Agent SDK**: CLI, settings, permissions, hooks, skills, plugins, subagents, MCP config, enterprise deployment | also 301 target of old `docs.claude.com/en/docs/claude-code/*` |
| `anthropic-partners.skilljar.com` | the **Partner Academy**: certification catalog, exam guides, partner training | Skilljar is the LMS vendor; the tenant is Anthropic's. **The miss lived here** |
| `support.claude.com` | help-center articles, account/billing, compliance certifications | |
| `modelcontextprotocol.io` | the **MCP specification**, SDK docs, SEPs, registry, governance | Anthropic-originated, independently governed |

Two navigational aids repay knowing:

- **`llms.txt` indexes.** Both `code.claude.com/docs/llms.txt` and
  `modelcontextprotocol.io/llms.txt` publish a complete page index designed for
  machine consumption. Fetching one of these is strictly better than guessing
  URLs or searching, and should be the *first* move against either host.
- **Public asset paths.** Partner Academy exam guides are served from an
  `everpath-course-content.s3-accelerate.amazonaws.com/.../public/...` path with
  no authentication, even though the catalog page shows a "Sign In" control. The
  presence of a login control is not evidence that linked assets are gated.

## Findings

**1. Host sprawl is the root cause, not carelessness.** Seven hosts for one
vendor's documentation is unusual, and the split is not intuitive:
`claude.com` holds the certification *catalog* while `skilljar` holds the exam
*guides*; `platform.` and `code.` split the API from the agent harness along a
line a newcomer would not predict. A `site:`-scoped search encodes a guess about
this topology, and the guess was wrong.

**2. The redirect chain hides the topology.** `docs.claude.com` 301s to
`platform.claude.com` *or* `code.claude.com` depending on path. An agent
following redirects reaches the right page without ever learning that two
distinct hosts exist — so the knowledge needed to search well is exactly the
knowledge that redirects conceal.

**3. Program portals are a distinct category.** Certification, training, and
partner material live in an LMS tenant that no product-doc search will reach.
Any vendor with a partner program likely has this shape. The general rule:
**when researching a vendor *program* rather than a vendor *product*, find the
program's own portal first.**

**4. A stale-revision hazard sits alongside the coverage hazard.** The MCP spec's
current revision is **2025-11-25**; two documents filed into this brain the same
day captured **2025-06-18** — a revision reachable at a stable, still-live URL.
Specs with dated revision paths will serve an old revision indefinitely without
signalling staleness, so capture must record the revision *and* check for a
newer one.

## Recommendation

Adopt the map as a **checklist for primary-source intake**, not as a policy.
Concretely, when the subject is Anthropic:

1. Identify which of the seven hosts owns the subject.
2. For `code.claude.com` or `modelcontextprotocol.io`, fetch `llms.txt` first.
3. For anything about the *program* — certification, partner status, training —
   go to Partner Academy, not the product docs.
4. For a dated spec, confirm the current revision before capturing.
5. When reporting that something is unstated, name the scope searched.

This stays an `analysis` rather than becoming a `policy` deliberately. The
contract is loaded in full every session and should carry rules that must fire
unprompted; a vendor-specific source map is reference material an agent consults
when it has already decided to research Anthropic. Item 5 is the only genuinely
general rule here, and it belongs to a broader question about how agents report
negative findings — worth raising separately rather than smuggling in under a
vendor map.

## Open questions

- **Does this generalize to a `/sources` register?** Other vendors and standards
  bodies have the same sprawl. A per-subject source map could become a genre.
  Premature on one instance.
- **Should item 5 become a policy?** "Report absence relative to scope searched"
  is a real, general agent failure mode. It would need to be terse enough to
  earn contract space.

# See also

- [The Claude Certification Program](/knowledge/SWE/agentic/anthropic/certification/claude-certification-program.md)
- [CCA study program plan](/meta/plans/cca-certification-study-program.md)
