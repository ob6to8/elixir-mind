---
id: em:4599c9
type: concept
title: state-space model
description: A sequence architecture that carries a fixed-size recurrent state forward instead of attending over the whole history, giving linear-time inference and flat memory use at the cost of weaker recall of distant detail.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, model-architecture, long-context, mamba, transformers, llm-inference]
timestamp: 2026-07-25
attribution:
  when: 2026-07-25T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /intake"
  why: "term surfaced by the Manus context-engineering post intaken 2026-07-25"
---

# state-space model

The trade against attention is structural rather than incidental. Attention can
reach any earlier token exactly, but pays quadratically in sequence length and
must keep a
[KV-cache](/beliefs/glossary/kv-cache.md) that grows with it; a state-space model
compresses history into a bounded state, so cost per token stops depending on how
much came before — and anything squeezed out of that state is simply gone. The
combination is tantalizing for long-horizon agents, whose sequences are long and
whose need for exact distant recall might be absorbed by
[context offloading](/beliefs/glossary/context-offloading.md) to external files.
What actually shipped through 2025–2026, though, was overwhelmingly **hybrid** —
architectures interleaving state-space and attention layers, which recover
long-range recall while keeping much of the cost advantage — rather than pure
state-space agents. Mamba and its successors are the canonical line.

*Seen in:* [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md), <https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus>
