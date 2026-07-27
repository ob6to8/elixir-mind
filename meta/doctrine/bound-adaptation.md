---
type: doctrine
title: "Bound adaptation: no local fix becomes standing behavior unratified"
description: The standing direction that every material adaptation to agent behavior must be bound to its trigger, tested, and revalidated against the behavioral contract before it becomes standing behavior — quoted verbatim from the GSD-era commentary on agent scar tissue, with this bundle's one amendment, that the contract is ratification-mutable rather than immutable, so learning and drift are distinguished by who approves.
resource: https://www.reddit.com/r/AgentsOfAI/comments/1uz8m6s/i_ran_an_agent_autonomously_for_300_hours_the_way/
provenance: "Reddit comment by u/MacFall-7 on the 300-hour-run post (captured as em:60242a); ratified as doctrine by the operator, 2026-07-27"
tags: [meta, doctrine, adaptation, drift, ratification, direction, agents]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator dialogue on the code-cleanliness-trust branch"
  why: "operator ratified filing the MacFall-7 invariant as a standalone quote-seeded doctrine, per the scar-tissue analysis's recommendation"
  from: [em:60242a, /meta/analysis/scar-tissue-drift-defenses-and-persistence.md]
---

# Bound adaptation: no local fix becomes standing behavior unratified

This is a **standing direction** — the *why* behind the bundle's adaptation
governance, citable by plans, analyses, and priority rankings the way
[engineer-as-orchestrator](/meta/doctrine/engineer-as-orchestrator.md) already
is. It is not itself an enforceable rule; the policies listed below implement
it. It is quoted verbatim so the direction survives the session that adopted
it.

## The direction (verbatim source)

> Persistent state and locally approved fixes accumulate into a new effective
> policy unless every material adaptation is bound, tested and revalidated
> against an immutable behavioral contract.
>
> — u/MacFall-7, commenting on the 300-hour autonomous-run post
> ([captured as em:60242a](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md))

## The amendment

This bundle adopts the invariant with one substitution: its behavioral
contract is not immutable but
[**ratification-mutable**](/beliefs/glossary/ratification-mutable.md) —
immutable to agent adaptation, mutable through exactly one channel, operator
ratification. A truly immutable contract cannot learn; an freely mutable one
cannot resist [scar tissue](/beliefs/glossary/scar-tissue.md). The direction
is therefore: **change to standing behavior is distinguished from drift by
who approved it**, never by whether it looked locally rational.

## What it commits the brain to

- **Every adaptation is bound.** A change to standing behavior carries its
  trigger — the receipt — at the moment it is made, not reconstructed later.
- **Every adaptation is revalidated against the contract**, unconditionally
  and on every change, not only when something breaks.
- **No adaptation channel is silent.** Any pathway by which an agent's local
  fix could become standing behavior without the operator's approval is a
  defect in the brain's design, to be closed or gated when found.

## Implementations

The policies and machinery that make this direction operational:

- The [taxonomy-evolution protocol](/meta/policy/taxonomy-evolution-protocol.md)
  and the ratified [type vocabulary](/meta/policy/controlled-type-vocabulary.md) —
  shape changes pass the operator.
- The [compiled contract](/CLAUDE.md) and its `--check` gate — standing rules
  have exactly one provenance-tracked source; a stale artifact cannot merge.
- The [resource-attribution policy](/meta/policy/resource-attribution.md) —
  the receipt, machine-required and write-once.
- The [merge-strategy policy](/meta/policy/merge-strategy.md) — the receipt
  chain stays reachable forever.

## Related directions

The escape-rate plan's *measured trust before scaled autonomy* (argued in the
[tier-3/4 analysis](/meta/analysis/tier-3-4-interface-and-trust-determination.md))
is this direction's forward face: bound adaptation governs how behavior may
*change*; measured trust governs how confidence in unchanged behavior may
*grow*. Both refuse the same shortcut — treating what merely happened as if
it had been approved.

# Citations

- u/MacFall-7, comment on "I ran an agent autonomously for 300 hours…,"
  r/AgentsOfAI, 2026 — via the
  [scar-tissue capture](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md)
  (`em:60242a`); analyzed in
  [the defenses analysis](/meta/analysis/scar-tissue-drift-defenses-and-persistence.md).
