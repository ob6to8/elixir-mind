---
id: em:3d9101
type: reference
title: "LLMs reward expertise (Sean Goedecke)"
description: "Goedecke's argument that domain expertise, not prompting technique, is what LLM use rewards — specifying the desired solution and judging what comes back is the bottleneck, illustrated by Terence Tao's expert-mode ChatGPT usage."
resource: https://www.seangoedecke.com/llms-reward-expertise/
provenance: "Sean Goedecke, seangoedecke.com essay, published 2026-07-24"
tags: [ai-assisted-development, expertise, prompting, domain-knowledge, human-ai-collaboration]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-04T07:05:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted five seangoedecke.com essays on AI and engineering expertise for filing"
---

# LLMs reward expertise

Sean Goedecke argues against the framing of LLMs as skill democratizers: "the
most important skill in prompting is expertise in the domain you're prompting
for." Models are now good enough that a generalist gets adequate output, but
"the human is the bottleneck, not the model" — "the difficult part is in
communicating to the model exactly what kind of solution the human wants," and
knowing what to ask for, and how to judge what comes back, is domain knowledge
rather than prompt technique.

## The Tao example

The essay's centerpiece is Terence Tao's published ChatGPT conversation probing
a potential counterexample to the Jacobian conjecture. Tao's usage looks
nothing like novice usage: his messages are short and dense; "By signalling
expertise, Tao shunts the model into 'talking-to-mathematicians' mode, not
'explaining-to-amateurs' mode"; and instead of following the model's lead he
makes independent suggestions, pulls the one relevant idea out of a
multi-paragraph response, and notices when something "looks weird." Each of
those moves requires the mathematics itself — the technique cannot be
replicated by prompting tips alone.

## Why expertise keeps its value

The transfer to engineering: intimate familiarity with a codebase is what lets
an engineer steer an agent effectively — the same claim
[programming as theory building](/knowledge/SWE/agentic/expertise/programming-with-ai-agents-as-theory-building.md)
grounds in Naur, and the reason
[strong and weak engineers use these tools so differently](/knowledge/SWE/agentic/expertise/ai-makes-weak-engineers-less-harmful.md).
Goedecke expects the bottleneck to survive model improvement, since it lives in
the human side of the exchange: specifying the solution wanted. To the
objection that labs' models now surface discoveries on their own, he responds
that "OpenAI do have a team of expert mathematicians that checked and filtered
the model's suggested discoveries, and that you cannot currently skip that
step."

From the delegation side,
[It's not empowering to hand off the details](/knowledge/SWE/agentic/adoption/its-not-empowering-to-hand-off-the-details.md)
makes the same gate explicit: only someone already expert can judge what is
safe to hand to the model.

## HN discussion

The [Hacker News thread](https://news.ycombinator.com/item?id=49161518) on
this essay surfaced counterexamples the essay itself doesn't address:
commenters reported non-technical people successfully building a Telegram
bot and installing Linux with a free Gemini tier, and non-technical
colleagues shipping working apps with Claude Desktop — suggesting motivation
and tinkering curiosity can substitute for domain vocabulary in at least some
cases, and that tool choice matters (purpose-built tools like Lovable were
reported as more forgiving for complete beginners than a generic chatbot).
The thread's synthesis: non-technical users can produce *working*
prototypes without expertise, but the architecture underneath tends to be
worse — expertise still gates the ceiling even where it doesn't gate getting
something running at all.

# Citations

- Source: <https://www.seangoedecke.com/llms-reward-expertise/>
- HN discussion: <https://news.ycombinator.com/item?id=49161518>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:3d9101">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-04-goedecke-expertise-essays-intake (2026-08-04)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:3d9101`]**  (co-feeds: `em:69cd30 em:457a88 em:abdca2 em:ccee99 knowledge/SWE/agentic/expertise/index.md`)

All quotes are now verified with exact spans. Now for the filing decision — articles 1, 2, 3, and 5 form a coherent cluster on how AI-assisted development interacts with the human engineer's expertise (its leverage, formation, retention, and distribution); no existing `agentic/` subdirectory covers that, so I'll create `knowledge/SWE/agentic/expertise/` (a subdirectory under an established domain — autonomous per the taxonomy protocol). Article 4 is a pure software-design essay and files into the existing `software-design/`. Let me check the id-minting task, then write.

---

**[`em:3d9101`]**  (co-feeds: `em:69cd30 em:457a88 em:abdca2 em:ccee99`)

Your five links were all new to the brain — none were already filed or parked in the survey tier. Four of them turned out to be one coherent subject: how AI-assisted development interacts with the human engineer's expertise — where it stays the leverage point, how it forms, whether agents can hold it, and what happens to the ability distribution. No existing directory covered that, so I created a new subdirectory for it under the established agentic domain, [`knowledge/SWE/agentic/expertise/`](https://github.com/ob6to8/elixir-mind/blob/claude/ai-software-engineering-expertise-tat4rl/knowledge/SWE/agentic/expertise/index.md) — a within-domain subdirectory, so created autonomously per the taxonomy protocol rather than held for ratification. The fifth essay is a pure software-design piece and filed into the existing `software-design/` directory. Every quote in the filed docs was verified verbatim against the source in a second fetch pass before being quoted; the commit passed the full gate suite and is pushed to the session branch. No PR was opened — that stays with `/create-pull-request`.
