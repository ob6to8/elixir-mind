# Agent pairing — design records

Supporting documents for the [agent pairing](/projects/agent-pairing.md)
project: a supervision layer that renders a coding agent's work into the
operator's live editor at human pace and lets the operator gate, amend, and
correct edits before they land.

Findings true regardless of this system are filed in the knowledge taxonomy and
linked from the hub; what lives here is true only *for this system*.

## Contents

- [Architecture and build order](/projects/agent-pairing/architecture-and-build-order.md) —
  the broker-plus-thin-clients shape, three build tiers from filesystem-follow
  to a full acknowledgement protocol, the harness gaps the design must close
  itself, and the deferred extensions _(plan, proposed)_
- [Is there an unoccupied position, and where is the moat?](/projects/agent-pairing/opportunity-assessment.md) —
  each planned capability against what ships today; the defensible work is
  placement and governance rather than capture _(analysis)_
- [Comparison with herdr and cmux](/projects/agent-pairing/comparison-herdr-cmux.md) —
  complementary at the substrate level, competitive over attention routing,
  superseding only the sidebar's role as primary queue _(analysis)_
