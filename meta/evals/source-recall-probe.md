---
type: reference
title: "Source recall probe"
description: A proposed eval measuring whether an agent researching a subject surfaces its known-complete primary-source set — the upstream measurement that determines whether scope-reporting admonitions are even addressable, with the falsification condition that a map-equipped agent scores no better than one without.
provenance: "Claude Code session, 2026-07-27 — designed after a primary-source miss during CCA certification research, at operator direction"
status: proposed
tags: [meta, eval, source-recall, research-methodology, agent-behavior, primary-sources]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, CCA certification session"
  why: "the operator asked whether the five primary-source checks could become evals; source recall is the one of the five with a constructible ground truth, and it measures whether the accompanying policy and skill amendment do anything"
---

# Source recall probe — gold set

## Question

When an agent researches a subject, does its search surface the **complete set
of primary sources** that subject has? And — the reason this matters more than
it first appears — does handing the agent a *source map* improve that recall
over searching unaided?

This is the upstream measurement. A downstream reporting rule
([negative-findings-name-their-scope](/meta/policy/negative-findings-name-their-scope.md))
asks an agent to caveat what it did not find. That rule is only addressable if
the agent can, in principle, know what it missed. If source recall is high, the
scoping failure is a reporting discipline and an admonition can plausibly fix
it. If source recall is low, the admonition is asking a model to caveat around
a gap it cannot see — and the fix belongs in tooling, not in prose.

## Hypothesis

Recall improves materially when the agent is given an enumerated host map and
an index-first instruction, because the dominant failure is **topology
ignorance**, not reasoning: a `site:`-scoped query encodes a guess about where
documentation lives, and a wrong guess returns nothing while never surfacing
the guess.

The competing hypothesis, which the eval must be able to confirm: modern search
already routes around topology, the map is decoration, and the
[`/intake`](/.claude/skills/intake/SKILL.md) amendment adds ceremony without
signal.

## Method (proposed instrument)

Unlike the [dedup probe](/meta/evals/dedup-probe.md) — which scores a
*deterministic* lexical backend offline — source recall scores **agent
behavior**: non-deterministic, network-dependent, one agent run per row. It is
therefore a behavioral eval in the mold of the
[recitation A/B](/meta/evals/priorities-recitation-vs-harness-reminders.md),
not a `mix brain.*` gate.

**Arm A — unaided.** A fresh agent receives the question alone and researches
it. Score which gold sources appear in its output or tool calls.

**Arm B — map-equipped.** Same question, with the
[source-surface map](/meta/analysis/anthropic-primary-source-surfaces.md) and
the amended `/intake` gather step in context.

Both arms are scored against the row's **required sources**. Because ground
truth is a *set* rather than a single target, the natural score is per-row
recall (fraction of required sources surfaced), averaged across rows.

**A cheap mechanical proxy, worth noting and not confusing for the real
instrument:** for filed documents, check whether each `resource` host is the
canonical host for its subject per the map. This is deterministic and offline,
but it only scores documents that were *already filed* — it cannot see the
sources an agent never found, which is the entire quantity of interest. Useful
as a hygiene check, useless as a recall measurement.

## How the probe reads this doc

The **`## Gold set`** table below is the durable artifact and is useful
immediately as a manual checklist, before any harness exists.

| Column | Holds |
|--------|-------|
| **question** | the research question an agent would be given — the thing under test |
| **required sources** | the primary sources a complete answer must reach; recall is scored against this set |
| **hosts** | which surfaces they live on — the topology the agent must discover |
| **band** | `complete` (every source required) · `partial` (a stated subset suffices) |
| **note** | provenance of the row, especially whether it records a real observed miss |

Rows recording **observed misses** are the most valuable kind: they are honest
by construction, where a row invented to be hard risks being calibrated to
whatever the author already knew.

## Gold set

| question | required sources | hosts | band | note |
|---|---|---|---|---|
| What does the Claude Certified Architect exam cost, and what is on it? | the four exam-guide PDFs; the Partner Academy certifications catalog | `anthropic-partners.skilljar.com` (+ its public S3 asset path) | complete | **observed miss, 2026-07-27** — an agent searching `site:anthropic.com OR site:claude.com` found none of these and reported that no primary source stated the price or blueprint |
| How does Claude Code resolve settings across scopes, and how do permission rules combine? | the Claude Code settings page | `code.claude.com` | complete | reachable only via a `docs.claude.com` redirect or direct knowledge of the host |
| What are MCP's tool-definition fields and its error-reporting split? | the current-revision Tools spec page | `modelcontextprotocol.io` | complete | tests revision currency: a dated path serves 2025-06-18 indefinitely while 2025-11-25 is current |
| What official courses does Anthropic publish, and do they cover certification prep? | the courses catalog; the certifications page | `claude.com` | complete | the catalog lives on the product-marketing host, not the docs hosts |

## Falsification

**Arm B scores no better than Arm A** → the host map is decoration, search
already routes around topology, and the `/intake` primary-source amendment
should be reverted rather than left as unmeasured ceremony. That negative result
retires an open question cheaply and is a finding, not a failure.

**Both arms score high** → recall was never the bottleneck; the scoping failure
is purely a reporting discipline, and
[negative-findings-name-their-scope](/meta/policy/negative-findings-name-their-scope.md)
is carrying the whole load and should be measured on its own terms.

**Both arms score low** → the admonition layer is the wrong instrument
altogether. An agent that cannot find the sources cannot meaningfully caveat
their absence, and the effort belongs in tooling — enumerable source registers,
index-first fetching — rather than in contract prose.

Each outcome changes what this brain does next, which is the property a proposed
eval most needs.

## Upkeep

Harvest a gold row whenever a research session **discovers a primary source it
had previously missed**, or whenever a source set is enumerated to completion.
Record observed misses verbatim rather than reconstructing a tidier version —
the miss is the signal.

Do not harvest a row for a source that was simply hard to read. This probe
measures *finding*, not *parsing*.

## Prior art

- [Dedup recall probe](/meta/evals/dedup-probe.md) — the gold-set-in-markdown
  pattern this reuses; scores a deterministic backend rather than agent behavior.
- [Priorities recitation vs harness task reminders](/meta/evals/priorities-recitation-vs-harness-reminders.md)
  — the behavioral-A/B genre, including the discipline of writing the
  falsification condition before the instrument.
- [Is the corpus-maintenance failure space rich content for evals?](/meta/analysis/eval-suitability-of-the-corpus-maintenance-failure-space.md)
  — why ground truth is constructible here at all.
- [Anthropic's primary-source surfaces](/meta/analysis/anthropic-primary-source-surfaces.md)
  — the map under test, and the post-mortem that motivated it.
