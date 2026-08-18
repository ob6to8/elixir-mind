---
id: em:e307c9
type: reference
title: "Boids without locality — a force-field swarm variant (Wolfram Community)"
description: A modified boids flocking simulation using continuous attraction-repulsion forces (a la Lennard-Jones) instead of neighbor-radius rules, showing that global-range interaction alone still produces coherent, mergeable swarm clumps.
resource: https://community.wolfram.com/groups/-/m/t/122095
provenance: "Wolfram Community, posted by Simon Woods (2012); surfaced via Hacker News, fetched 2026-08-18"
tags: [agent-based-modeling, boids, swarm-intelligence, emergent-behavior, simulation, wolfram]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Boids without locality — a force-field swarm variant

Craig Reynolds' original 1986 boids model produces flocking from three local
rules — separation, alignment, cohesion — applied only among neighbors
within a fixed radius; locality is a load-bearing assumption of the model.
This Wolfram Community write-up implements a variant that replaces the three
rules with a single continuous force law between every pair of agents:
attraction at longer range, repulsion at short range, with the repulsive
term regularized (treating each agent as a small "cloud" rather than a
point) so the force doesn't blow up as two agents approach zero distance —
the same technique used in vortex-particle fluid simulations, and
structurally the same shape as the Lennard-Jones potential governing atomic
interactions.

## The core update rule

```
x = 0.995x + 0.02*f[p] - 0.01*f[q]
```

1,000 particles, each randomly assigned one "friend" (p) and one "enemy"
(q), contract slightly toward center each timestep, move a larger step
toward their friend, and a smaller step away from their enemy, with periodic
random reassignment of friend/enemy pairs; forces attenuate with proximity
to prevent runaway clustering.

## The notable result

This model still produces coherent swarm/flocking behavior — clumping,
coordinated movement — **without any neighbor-radius or locality assumption
at all**: every agent interacts with every other agent, all the time, and
organized structure still emerges from the force balance alone. Separate
clumps of agents stay independently cohesive once formed, but a nearby
clump's field can perturb a smaller group enough to trigger re-merging into
a larger swarm — an attractor-basin-like dynamic rather than a purely local
rule-following one.

Community members built on it with 3D variants, alternate parameters
producing ring formations, larger-scale renders, velocity-based coloring,
and spherical projections.

## Relation to this bundle's material

This is an adjacent but distinct family from the population/distribution-based
search methods this bundle already tracks under
[evolutionary-computation](/knowledge/machine-learning/evolutionary-computation/index.md):
emergent coordination from pairwise local (or, here, global) rules — no
fitness function, no selection, no generational structure — closer to
multi-agent systems and complex-systems modeling than to optimization.

# Citations

- "Dancing with friends and enemies: boids' swarm intelligence" (2012), Wolfram Community — <https://community.wolfram.com/groups/-/m/t/122095>
