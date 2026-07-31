# Supervision

How a human stays in the loop over agent-produced work: the postures available,
the consoles built for them, and what makes agent activity legible enough to
act on.

## Contents

- [Agent-as-driver: the pair-programming inversion](/knowledge/SWE/agentic/supervision/agent-as-driver-pairing-inversion.md) —
  the driver/navigator split applied to agentic coding, and why the shipped
  tooling is asynchronous diff review rather than the pairing it is named after
- [Ambient agent observability](/knowledge/SWE/agentic/supervision/ambient-agent-observability.md) —
  why the binding constraint on agent oversight is salience rather than
  recording, and what a rendering owes its reader once it is trusted
- [Agent supervision consoles](/knowledge/SWE/agentic/supervision/agent-supervision-consoles.md) —
  the tools that multiplex concurrent agents into one attention surface:
  terminal multiplexers, workspace managers, task boards, and session recorders
- [Normative records vs. descriptive traces](/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md) —
  a trace says what the agent did; a decision record says what was authorized,
  by whom, with what reason — the artifact oversight obligations ask for, and
  the two failure modes that hollow it out
- [Your agent says "done." You check and nothing actually happened. — r/AgentsOfAI](/knowledge/SWE/agentic/supervision/reddit-agent-says-done-reconciliation-patterns.md) —
  practitioner discussion of silent completion failures and validation patterns: write-verify separation, read-back verification, and reconciliation against system of record `em:7c4f3e` _(reference)_
- [Typed actions are born supervisable](/knowledge/SWE/agentic/supervision/typed-actions-are-born-supervisable.md) —
  agents whose actions are typed data admit supervision by interposition;
  opaque tool calls force retrofit hooks — the action representation sets the
  supervision ceiling

## Related

- [editor-integration](/knowledge/SWE/agentic/editor-integration/index.md) — the
  editor as one surface a supervising human watches
