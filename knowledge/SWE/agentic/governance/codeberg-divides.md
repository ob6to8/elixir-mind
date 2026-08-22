---
id: em:7f0244
type: reference
title: "Codeberg Divides (Armin Ronacher)"
description: "Ronacher's critique of Codeberg's policy excluding projects 'largely written with generative AI' — an unenforceable threshold that trades a broad, dependable Open Source alternative to GitHub for a narrower, more ideologically coherent community."
resource: https://lucumr.pocoo.org/2026/7/24/codeberg-divides/
provenance: "Armin Ronacher, lucumr.pocoo.org essay, published 2026-07-24"
tags: [open-source-governance, ai-authored-code, codeberg, github, community-policy]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Codeberg Divides

Codeberg — a nonprofit, democratically-governed alternative to GitHub —
changed its terms "to exclude projects that are largely written with
generative AI." Armin Ronacher, wanting GitHub to face real competition,
argues the policy is a mistake even though Codeberg is fully entitled to make
it.

## Democratic process isn't the property that matters

"Codeberg is entirely within its rights to do this. It is an association
with members and a democratic process, and that process produced a result.
But democracy is a way of making a decision, not a guarantee that the
decision is inclusive, wise, or even good for the people already depending on
it." What Ronacher wants from hosting infrastructure isn't democratic
governance but predictability: "I need it to be predictable, dependable, and
reasonably neutral towards the legal Open Source software hosted on it. A
democratic provider without a clear constitution can be worse at those things
than a corporation."

## The line can't be enforced

The policy prohibits projects that "mostly consist of code written by
generative AI tools." Ronacher: "In an actively developed codebase, what does
'mostly' mean, and who can still tell? I could not reliably assign authorship
percentages to many of my own recent projects. The line is open to
interpretation precisely where it needs to be enforceable." He argues a
sharper rule would serve better than a vague one: "If Codeberg wants no LLM
involvement, it should say so. If it wants to prevent autonomous repository
spam and abusive resource consumption, it should write rules for those
instead. The current middle ground delegates too much of the policy to
moderators and community norms" — which he expects to enforce a harsher
social boundary than the letter of the rule states.

## The broader stakes

Ronacher reads the split as a symptom of a wider fracture: "It is a real
shame that the Open Source and Free Software communities are splitting this
deeply over LLMs and agents. There are serious questions about copyright,
labor, energy use, slop, and maintainers drowning in generated contributions.
But these tools are also becoming part of how software is made. The Open
Source world needs to figure out how to engage with that future, not just
divide into camps." He goes further, framing LLMs as potentially emancipatory
infrastructure rather than only a threat: "They could be used to reclaim
control and power, away from large corporations and institutions." As a
European project he wanted to see succeed as a broad GitHub alternative,
Codeberg's choice reads to him as picking a smaller, more ideologically
defined community over that ambition: "I wish Codeberg were more
forward-looking here: willing to host the Open Source software of tomorrow,
not only software made in the ways its community approves of today."

Reads as a live instance of the open-source-governance question
[Instruction conflict across composed context sources has no mechanical oracle](/knowledge/SWE/agentic/governance/instruction-conflict-has-no-mechanical-oracle.md)
raises in miniature: a policy expressed in prose ("mostly consist of") with
no mechanical way to check compliance pushes enforcement onto human judgment
calls the rule itself never specifies.

# Citations

- Source: <https://lucumr.pocoo.org/2026/7/24/codeberg-divides/>
