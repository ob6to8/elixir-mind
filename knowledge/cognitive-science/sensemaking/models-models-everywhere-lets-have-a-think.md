---
id: em:d34a32
type: reference
title: "Models, Models Everywhere, So Let's Have a Think (Lorin Hochstein)"
description: "Formal methods and resilience engineering, despite opposite analytic/synthetic temperaments, converge on the same move — building small, deliberately partial explicit models not for completeness but for the insight forced by having to specify what would otherwise stay implicit."
resource: https://surfingcomplexity.blog/2025/03/31/models-models-every-where-so-lets-have-a-think/
provenance: "Lorin Hochstein, Surfing Complexity essay, published 2025-03-31"
tags: [formal-methods, resilience-engineering, mental-models, sensemaking, model-checking, work-as-done]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Models, Models Everywhere, So Let's Have a Think

Lorin Hochstein notices his two recurring subjects — formal methods and
resilience engineering — draw from opposite temperaments (formal methods
"analytic," resilience engineering "synthetic," a contrast he traces to
Leslie Lamport's dismissal of a biological view of software versus Richard
Cook's deliberate borrowing from biology) yet "both recognize the value of
creating explicit models of aspects of systems that are not typically
modeled."

## Formal methods: a small model, exhaustively specified

A formal model is deliberately partial — "typically only a very small part of
the system," usually the part "humans aren't particularly good at reasoning
about unaided, such as concurrent or distributed algorithms" — because
building and validating a model costs effort that scales with its size. The
payoff isn't completeness but forced attention: "the act of creating an
explicit model and observing its behavior with a model checker gives you a
new perspective on the system being modeled, because the explicit modeling
forces you to think about aspects that you likely wouldn't have considered.
You won't say 'I never imagined X could happen' when building this type of
formal model" — because within the model's narrow scope, "you have to
exhaustively specify the thing within the scope you've defined: there's no
place to hide."

## Resilience engineering: models of minds and models of work

Resilience engineering treats models two ways. First, it stresses their
limits: "every model is incomplete in potentially dangerous ways, and every
incident can be seen through the lens of model error: some model that we had
about the behavior of the system turned out to be incorrect in a dangerous
way." Second, and more distinctively, it builds explicit models of things
"frequently ignored by traditional analytic perspectives" — mental models and
models of work. Asking "how did the decision make sense at the time?" during
an incident review is an attempt to build "a deeper understanding of someone
else's state of mind... a model of a mental model, because we're trying to
reason about how somebody else reasoned about events that occurred in the
past." Separately, resilience engineering distinguishes work-as-imagined from
**work-as-done** — the documented process is not "an accurate model of how
work actually happens," and the gap between the two is generally successful,
"which is why it persists" — motivating the questions incident reviewers ask
to surface how work really happens.

## The shared conclusion

Neither field's models are, or aim to be, complete: "there's no way we can
build complete models of people's mental models, or generate complete
descriptions of how they do their work. But that's ok." What both share is
the goal underneath the modeling effort: "the goal is not completeness, but
insight. Whether we're building a formal model of a software system, or
participating in a post-incident review meeting, we're trying to get the
maximum amount of insight for the modeling effort that we put in."

Reads as the epistemics companion to
[how to make sense of AI](/knowledge/cognitive-science/sensemaking/how-to-make-sense-of-ai.md)
and
[letter to a young person worrying about AI](/knowledge/cognitive-science/sensemaking/letter-to-a-young-person-worrying-about-ai.md):
all three treat a small, deliberately incomplete model — a field report
interrogated by four fixed questions, a formal spec of one concurrent
algorithm, a reconstructed mental model of one decision — as the unit that
buys insight, rather than treating completeness or prediction as the goal.

# Citations

- Source: <https://surfingcomplexity.blog/2025/03/31/models-models-every-where-so-lets-have-a-think/>
