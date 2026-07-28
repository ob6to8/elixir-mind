---
id: em:dfadfb
type: methodology
title: "The phantom sketch artist method"
description: "An elicitation playbook distilled from Gregor Hohpe's metaphor: the person with the knowledge usually cannot express it, so draw the system back to them from what you heard and let them correct the drawing — 'that's wrong' is the signal the method is working, and the deliverable is something they recognize but could never have produced."
provenance: "Distilled by a Claude Code agent from Gregor Hohpe's account on the Beyond Coding podcast (2026-01-21), 2026-07-28"
tags: [elicitation, technical-communication, visualization, requirements, facilitation, methodology, interviewing]
timestamp: 2026-07-28T18:39:50Z
attribution:
  when: 2026-07-28T18:39:50Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "the episode carried a repeatable elicitation procedure worth using independently of the capture it came from"
---

# The phantom sketch artist method

A repeatable way to extract a system model from the people who hold it,
distilled from a metaphor Gregor Hohpe uses in
[the architect-as-amplifier episode](/knowledge/SWE/software-design/the-architect-as-amplifier.md).

## The premise: knowing and expressing are different skills

Before CCTV was everywhere, a police sketch artist drew a suspect from witness
descriptions. Hand a witness the pencil instead and you get a stick figure with
a money bag — they saw the face perfectly and cannot render it. The sketch
artist has the inverse problem: full expressive skill, zero knowledge of the
subject.

The output depends on both halves being present and held by *different* people.
That is the whole method: you supply expression, they supply knowledge, and
neither is trying to be the smarter party.

## The procedure

1. **Ask them to describe the system**, and start drawing while they talk.
   Do not wait until you understand it.
2. **Draw back what you heard**, including the parts you are unsure of. Commit
   to lines: a diagram cannot hedge the way prose can, and it is the commitment
   that makes the error visible.
3. **Treat "that's wrong" as the success signal.** Hohpe's favourite response
   to his own sketch is exactly that — "oh, I drew a line here. No, no, this is
   not how it works" — because a wrong drawing is far easier to correct than a
   blank page is to fill.
4. **Iterate on the correction, not the concept.** Wider nose, different
   connection, extra component. Each pass is cheap and specific.
5. **Stop at recognition** — when they say that is exactly it. The test of a
   finished sketch is that they recognize it completely and could never have
   drawn it themselves.

## Why it works

- **It inverts who does the retrieval.** A direct question ("how does this
  work?") asks them to both recall and structure. A wrong diagram asks only for
  recognition, which is a much cheaper cognitive operation and far more
  reliable.
- **It removes the status contest.** Neither party is instructing the other.
  You are not lecturing, prescribing, or ruling; you are playing back knowledge
  they already had in a format they can now use. Both sides gain — you learn the
  system, they get a clearer view of their own trade-offs.
- **It leaves the ownership where it belongs.** They walk away with an artifact
  of their own knowledge, not your prescription.

## The prerequisite: know the anatomy

The metaphor carries a constraint that is easy to skip. A police sketch artist
studies human anatomy — bone structure, posture, facial architecture — because
you cannot render a face convincingly without understanding what is underneath.

The analogue is that this method is not a substitute for domain competence. It
is not about drawing a beautiful rectangle; it is about understanding the
anatomy well enough that the rectangles you draw represent the relationships
people are describing. Someone without the underlying knowledge produces
drawings that are pretty and semantically empty — which is also why the
expression half cannot be delegated to a graphics person: they do not know the
model's semantics, so they do not know what may be changed.

## Applicability

The method generalizes past architecture to any situation where someone holds
tacit structure they cannot articulate: requirements elicitation, incident
reconstruction, onboarding into an unfamiliar codebase, and an agent building a
model of an operator's intent. In each case, a specific, confidently wrong
first draft outperforms an open-ended question.

It pairs with
[escalating-example exposition](/knowledge/knowledge-management/technical-communication/escalating-example-exposition.md):
that method is for *presenting* an idea the author already holds, this one is
for *extracting* one the author does not.
