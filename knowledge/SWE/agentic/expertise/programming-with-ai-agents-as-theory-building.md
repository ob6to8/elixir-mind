---
id: em:69cd30
type: reference
title: "Programming (with AI agents) as theory building (Sean Goedecke)"
description: "Naur's thesis that the engineer's theory of the program — not the code — is the primary artifact, read against agentic coding: agents demonstrably build theories in-session but cannot retain them, so the human's retained theory stays the durable output."
resource: https://www.seangoedecke.com/programming-with-ai-agents-as-theory-building/
provenance: "Sean Goedecke, seangoedecke.com essay, published 2026-04-03"
tags: [theory-building, mental-models, naur, agentic-coding, code-comprehension, agent-memory]
timestamp: 2026-08-04T07:05:00Z
attribution:
  when: 2026-08-04T07:05:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted five seangoedecke.com essays on AI and engineering expertise for filing"
---

# Programming (with AI agents) as theory building

Sean Goedecke reads Peter Naur's 1985 paper *Programming as Theory Building*
against agentic coding. Naur's thesis, as the essay states it: "the core
output of software engineers is not the program itself, but the theory of how
the program works" — "the knowledge inside the engineer's mind is the primary
artifact of engineering work, and the actual software is merely a by-product
of that." The practical form of the claim: "you cannot make a change to a
program simply by having the code" — you first have to read it carefully
enough to build a mental model.

## Does agentic coding erode the theory?

Delegating to agents plausibly thins the engineer's mental model, and the
[skill-formation literature](/knowledge/SWE/agentic/expertise/how-does-ai-impact-skill-formation.md)
supports some version of that. Goedecke's counter is that every theory is
already partial — "every mental model glosses over some fine details" — so the
question is where the glossing happens, not whether.

His own workflow keeps the theory-building with the human: he runs several
agents, reviews their output against his mental model of the system, and
accepts a fraction — "only 10% of agent output is actually making its way into
_my_ output." Reviewing against a theory exercises the theory; the risk
appears when acceptance outruns comprehension, which is where
[capability growth relocates agentic risk into the operator's own mental model](/beliefs/capability-growth-relocates-risk-to-operator-epistemics.md).

## Agents build theories but cannot keep them

Agent logs show genuine theory-building behavior — making hypotheses about how
the system works and trying to confirm or disprove them. The binding
limitation is retention: "they can't _retain_ theories of the codebase. They
have to build their theory from scratch every time. Given that, it's kind of a
minor miracle that AI agents are as effective as they are." A human engineer
amortizes theory across years; an agent re-derives it per session. That
retention gap is precisely the target of
[agent-memory systems](/knowledge/SWE/agentic/agent-memory/index.md).

# Citations

- Source: <https://www.seangoedecke.com/programming-with-ai-agents-as-theory-building/>
- Peter Naur, "Programming as Theory Building" (1985):
  <https://pages.cs.wisc.edu/~remzi/Naur.pdf>
