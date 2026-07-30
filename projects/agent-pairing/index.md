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
- [Observability as compliance](/projects/agent-pairing/compliance-and-governance-observability.md) —
  the broker's decision records as authorization-grade evidence of human
  oversight, and the two failure modes (rubber-stamping, event-stream
  incompleteness) that would hollow the attestation out _(analysis)_
- [A real-time sonification layer](/projects/agent-pairing/realtime-sonification-layer.md) —
  an auditory client for the broker stream: ambient texture for activity,
  earcons for decisions, per-agent voices for fleet listening — the
  supervision tier below visual attention _(analysis)_
- [The broker on the BEAM, and Jido 2](/projects/agent-pairing/beam-jido-integration.md) —
  the broker as the first workload in this brain's orbit that fits OTP; Jido
  as chassis iff thin; and BEAM-native agents as born-supervisable subjects
  that close the ingest gaps structurally _(analysis)_
