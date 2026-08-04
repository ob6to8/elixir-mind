---
id: em:457a88
type: reference
title: "How does AI impact skill formation? (Sean Goedecke)"
description: "Goedecke's reading of the Anthropic Fellows skill-formation study — the no-speedup headline hides a retyping confound (AI users were 25% faster without it), reduced learning-per-task is real but engineers are paid to deliver rather than to learn, and higher task volume may offset it."
resource: https://www.seangoedecke.com/how-does-ai-impact-skill-formation/
provenance: "Sean Goedecke, seangoedecke.com essay, published 2026-01-31"
tags: [skill-formation, learning, deskilling, ai-assisted-development, developer-productivity, anthropic-research]
timestamp: 2026-08-04T07:05:00Z
attribution:
  when: 2026-08-04T07:05:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted five seangoedecke.com essays on AI and engineering expertise for filing"
---

# How does AI impact skill formation?

Sean Goedecke's commentary on the Anthropic Fellows study *How AI Impacts
Skill Formation*, pushing back on the popular reading that it proves AI makes
developers slower and dumber.

## The speed finding hides a confound

The study's headline is that AI users were not faster overall. Goedecke's
objection: some participants manually retyped AI-generated code instead of
pasting it, and "If you ignore the people who spent most of their time
retyping, the AI-users were 25% faster." Since retyping is not how anyone
works, the aggregate masks a real speedup.

## Learning less per task is real — and priced in

He grants the study's core: "Nobody seriously believes that typing 'build me a
todo app' into Claude Code means you'll learn as much as if you built it by
hand." Two counterpoints follow:

- **Delivery is the job.** "software engineers are not paid to learn about the
  codebase" — "We are paid to deliver business value (typically by delivering
  working code)." Professions that require ongoing study budget dedicated time
  for it, outside task delivery. The opposing view — that the pre-delegation
  grind is exactly where the expertise that makes delegation safe comes from —
  is [Williams's hand-off argument](/knowledge/SWE/agentic/adoption/its-not-empowering-to-hand-off-the-details.md);
  what the thinned-out per-task learning erodes is the engineer's
  [theory of the program](/knowledge/SWE/agentic/expertise/programming-with-ai-agents-as-theory-building.md).
- **Volume may compensate.** Less learning per task times more tasks — across
  more systems — can still net out to more learning in breadth.

He also questions the study's model choice: it used GPT-4o, though "This study
was funded by Anthropic, who have much better models."

## What would settle it

Long-term studies of whether reduced learning-per-task is offset by increased
completion rates: "It's probably too early to answer these questions — strong
coding agents have only been around for a handful of months — but the answers
may determine what it's like to be a software engineer for the next decade."

# Citations

- Source: <https://www.seangoedecke.com/how-does-ai-impact-skill-formation/>
- The study under discussion: Anthropic Fellows, "How AI Impacts Skill
  Formation" — <https://www.anthropic.com/research/AI-assistance-coding-skills>
