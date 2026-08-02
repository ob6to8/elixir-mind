# failure-modes

How single LLM agents fail — operational failure modes, their mechanics, and
their relation to documented human cognitive biases: what a behavioral
mapping licenses, where the mirrored biases come from, and the evidence for
each production channel. Human-side anchors live under
[cognitive-science](/knowledge/cognitive-science/index.md); the eval-facing
procedure under
[evals](/knowledge/SWE/evals/porting-cognitive-bias-paradigms-into-agent-evals.md).

## Framework

- [Mapping agent failure modes to cognitive biases](/knowledge/SWE/agentic/failure-modes/mapping-agent-failure-modes-to-cognitive-biases.md) —
  the mapping is a similarity relation over behaviors, not an identity over
  mechanisms: where it holds (Marr's levels), the four channels that produce
  the mirror, the discriminating experiments, what the mapping buys and
  costs, and the naming rule. `em:5b4eda` _(note)_
- [Premise-retraction persistence in append-only agent contexts](/knowledge/SWE/agentic/failure-modes/premise-retraction-persistence.md) —
  a frame formed early keeps steering output after its premise is explicitly
  retracted: retraction is an addition, the blast radius of a withdrawn
  premise is not computable without justification edges, and the missing
  faculty is classical truth maintenance. `em:1b6809` _(note)_

## Claims — one per production channel

- [Instruction tuning can amplify cognitive biases in LLMs](/knowledge/SWE/agentic/failure-modes/instruction-tuning-can-amplify-cognitive-biases.md) —
  decoy, certainty, and belief biases show a stronger presence in
  instruction-tuned variants: the preference-optimization channel.
  `em:43a737` _(claim)_
- [LLM reasoning shows human-like content effects](/knowledge/SWE/agentic/failure-modes/llm-reasoning-shows-human-like-content-effects.md) —
  models answer logical problems more accurately when semantic content
  supports the inference: the distributional-inheritance channel.
  `em:e71983` _(claim)_
- [Long-context use is position-biased (lost in the middle)](/knowledge/SWE/agentic/failure-modes/long-context-use-is-position-biased.md) —
  performance is highest at the beginning and end of the context and
  degrades in the middle: the architectural channel, and the standing
  caution against inferring shared mechanism from behavioral resemblance.
  `em:dc4bb0` _(claim)_

## Subdirectories

- [sources](/knowledge/SWE/agentic/failure-modes/sources/index.md) —
  primary-source captures backing the claims above
