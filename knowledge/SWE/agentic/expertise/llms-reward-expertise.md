---
id: em:3d9101
type: reference
title: "LLMs reward expertise (Sean Goedecke)"
description: "Goedecke's argument that domain expertise, not prompting technique, is what LLM use rewards — specifying the desired solution and judging what comes back is the bottleneck, illustrated by Terence Tao's expert-mode ChatGPT usage."
resource: https://www.seangoedecke.com/llms-reward-expertise/
provenance: "Sean Goedecke, seangoedecke.com essay, published 2026-07-24"
tags: [ai-assisted-development, expertise, prompting, domain-knowledge, human-ai-collaboration]
timestamp: 2026-08-04T07:05:00Z
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

# Citations

- Source: <https://www.seangoedecke.com/llms-reward-expertise/>
