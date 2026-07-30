# Projects

Systems built **outside** this repo that incubate here. Each project is a
`type: project` hub doc beside a directory holding its architecture, threat
model, and design records — see the
[projects-namespace policy](/meta/policy/project-namespace.md).

Findings that are true regardless of the project file to
[knowledge](/knowledge/index.md) instead, and the hub links out to them; a
project accrues research to the brain rather than to one repo.

## Active

- [Agent pairing](/projects/agent-pairing.md) — a supervision layer that renders
  a coding agent's work into the operator's live editor at human pace and lets
  them gate, amend, and correct edits before they land; broker plus thin editor
  clients, Neovim first
  ([docs](/projects/agent-pairing/index.md))
- [Code-driven AV production](/projects/code-driven-av-production.md) — a
  scriptable music-and-video pipeline: ffmpeg picture cuts and SuperCollider
  non-realtime sound rendered from one declared timing grid, run on the
  operator's local machine
  ([docs](/projects/code-driven-av-production/index.md))
- [Human writing attribution](/projects/human-writing-attribution.md) — a
  provenance system for human-authored writing: publish each piece with its
  declared sources and LLM threads plus a quotation-vs-synthesis overlap
  report, so readers evaluate the human judgment directly instead of
  inferring authorship from style
  ([docs](/projects/human-writing-attribution/index.md))
- [Secure financial agent](/projects/secure-financial-agent.md) — a locally-hosted
  agentic system for processing sensitive financial documents (taxes, bank
  statements) with no data egress and a typed capability boundary
  ([docs](/projects/secure-financial-agent/index.md))
