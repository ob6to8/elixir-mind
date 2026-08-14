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
- [Bitwig shell control](/projects/bitwig-shell-control.md) — a shell-first
  realtime control surface for Bitwig Studio: transport, mixer, device and
  Grid parameters, clips, and live notes driven from a terminal over the
  DrivenByMoss OSC address space, with an ergonomic `bw` CLI to follow
  ([docs](/projects/bitwig-shell-control/index.md))
- [Code-driven AV production](/projects/code-driven-av-production.md) — a
  scriptable music-and-video pipeline: ffmpeg picture cuts and SuperCollider
  non-realtime sound rendered from one declared timing grid, run on the
  operator's local machine
  ([docs](/projects/code-driven-av-production/index.md))
- [Elixir agent memory](/projects/elixir-agent-memory.md) — a BEAM-native
  recall-and-dedup sidecar for file-canonical knowledge bundles and agent
  fleets: derived, disposable FTS5+embedding indexes over canonical markdown,
  benchmarked on recall gold sets; the tier-2 dedup engine this brain's own
  recall analysis specified, built outside it
  ([docs](/projects/elixir-agent-memory/index.md))
- [Dvorak vim](/projects/dvorak-vim.md) — a layout-aware vim reference and drill
  system for Dvorak typists: every binding shown as the command character plus
  the QWERTY keycap that produces it, served inside the editor, paired with
  latency-graded drills for the isolated character-to-key association prose
  typing never trains
  ([docs](/projects/dvorak-vim/index.md))
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
