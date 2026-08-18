---
id: em:3da9e6
type: source
title: "Programming as Theory Building (Peter Naur, 1985)"
description: Naur's 1985 argument that the true product of programming is the programmer team's mental theory of the program — not the code or its documentation — with the corollary that a program's "death" (loss of its theory-holding team) makes revival from documentation alone impossible.
resource: https://pages.cs.wisc.edu/~remzi/Naur.pdf
provenance: "Peter Naur, essay published in BIT 25 (1985); PDF scan hosted via a UW-Madison CS course page"
tags: [theory-building, mental-models, naur, program-comprehension, tacit-knowledge, philosophy-of-programming]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing; this paper is the primary source the existing programming-with-ai-agents-as-theory-building essay and glossary term build on"
---

# Programming as Theory Building

Peter Naur's 1985 thesis: the essential product of programming work is not
the program text but a **theory** — the living understanding, held by the
programmer team, of how and why the program solves the problem it solves.
Code and documentation are residue of that theory, not substitutes for it.

**A note on sourcing:** the primary PDF is a scanned image with no
machine-extractable text layer, so the quotations below were cross-checked
against three independent secondary sources that quote the original
verbatim (a paper-notes page, a field-atlas entry, and a Hacker News
discussion), rather than extracted directly from the primary scan. They
recur consistently across all three, but a direct spot-check against the
PDF is worth doing before treating them as machine-verified.

## What "theory" means

Naur borrows the term from Gilbert Ryle's distinction between "knowing how"
and "knowing that." A programmer's theory of a system is knowing-how:
practical competence that lets them act on the system intelligently and
explain, justify, and answer questions about those actions — not a checklist
of propositions that could be handed to someone else and read into
equivalent understanding. Two people can read the same source and
documentation and still not possess the same theory, the way two chess
players can know the same rules without possessing the same feel for the
game.

## The theory is built in the team, not on paper

Naur frames the construction of the program and the construction of its
theory as one act: "the building of the program is the same as the building
of the theory of it by and in the team of programmers." The consequence is
structural — a program is not "finished" independent of the people who
understand it, because the artifact that actually does the work of
programming is the theory, which lives only in minds.

## Program death and the impossibility of revival

The sharpest, most-cited consequence: "the death of a program happens when
the programmer team possessing its theory is dissolved." Once that happens,
Naur holds that recovering the theory from what's left behind cannot work:
"program revival, that is reestablishing the theory of a program merely from
the documentation, is strictly impossible." A new team reading the code and
docs can construct *a* theory, but not reliably *the* theory the original
authors held — a rewrite by a fresh team building its own theory from
scratch is often more viable than "reviving" an orphaned system, even though
it looks like the more expensive option on a naive text-manipulation
accounting of cost.

## Why this cuts against "code as the artifact"

The corollary: treating program modification as cheap because it's "just
text editing" mistakes the medium for the message. Changes are cheap only
when the editor already holds the theory that makes the edit correct.
Without it, edits accumulate as decay rather than improvement.

## Where this bundle uses it

[Programming (with AI agents) as theory building](/knowledge/SWE/agentic/expertise/programming-with-ai-agents-as-theory-building.md)
reads this thesis directly against agentic coding: AI agents show real
theory-building behavior session-to-session but cannot retain a theory
across sessions, so the durable theory stays with the human reviewing their
output. [You can't design software you don't work on](/knowledge/SWE/software-design/you-cant-design-software-you-dont-work-on.md)
applies the same claim to design authority specifically.

# Citations

- Source (scanned PDF, primary): <https://pages.cs.wisc.edu/~remzi/Naur.pdf>
- Mirror: <https://gwern.net/doc/cs/algorithm/1985-naur.pdf>
- Secondary sources the verbatim quotes above were cross-checked against:
  <https://embeddedartistry.com/fieldatlas/programming-as-theory-building/>,
  <https://ratfactor.com/papers/naur1>,
  <https://news.ycombinator.com/item?id=10833278>
