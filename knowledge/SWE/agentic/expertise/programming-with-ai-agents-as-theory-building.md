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

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:69cd30">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-04-goedecke-expertise-essays-intake (2026-08-04)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:69cd30`]**  (co-feeds: `em:3d9101 em:457a88 em:abdca2 em:ccee99 knowledge/SWE/agentic/expertise/index.md`)

All quotes are now verified with exact spans. Now for the filing decision — articles 1, 2, 3, and 5 form a coherent cluster on how AI-assisted development interacts with the human engineer's expertise (its leverage, formation, retention, and distribution); no existing `agentic/` subdirectory covers that, so I'll create `knowledge/SWE/agentic/expertise/` (a subdirectory under an established domain — autonomous per the taxonomy protocol). Article 4 is a pure software-design essay and files into the existing `software-design/`. Let me check the id-minting task, then write.

---

**[`em:69cd30`]**  (co-feeds: `em:3d9101 em:457a88 em:abdca2 em:ccee99`)

Your five links were all new to the brain — none were already filed or parked in the survey tier. Four of them turned out to be one coherent subject: how AI-assisted development interacts with the human engineer's expertise — where it stays the leverage point, how it forms, whether agents can hold it, and what happens to the ability distribution. No existing directory covered that, so I created a new subdirectory for it under the established agentic domain, [`knowledge/SWE/agentic/expertise/`](https://github.com/ob6to8/elixir-mind/blob/claude/ai-software-engineering-expertise-tat4rl/knowledge/SWE/agentic/expertise/index.md) — a within-domain subdirectory, so created autonomously per the taxonomy protocol rather than held for ratification. The fifth essay is a pure software-design piece and filed into the existing `software-design/` directory. Every quote in the filed docs was verified verbatim against the source in a second fetch pass before being quoted; the commit passed the full gate suite and is pushed to the session branch. No PR was opened — that stays with `/create-pull-request`.
