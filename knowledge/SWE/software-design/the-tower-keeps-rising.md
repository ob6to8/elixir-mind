---
id: em:3dd12f
type: reference
title: "The Tower Keeps Rising (Armin Ronacher)"
description: "Ronacher's argument that AI coding agents remove the coordination friction that used to force engineers to share a mental model of a system, so large codebases can keep 'rising' even after that shared understanding has quietly collapsed."
resource: https://lucumr.pocoo.org/2026/7/13/the-tower-keeps-rising/
provenance: "Armin Ronacher, lucumr.pocoo.org essay, published 2026-07-13"
tags: [agentic-coding, team-coordination, software-architecture, shared-mental-models, ai-assisted-development]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# The Tower Keeps Rising

Armin Ronacher reads Bruegel's *Tower of Babel* against "vibecoded software"
that "changes somewhat randomly and unexpectedly." In Genesis the builders
share one language, and "the source of their power is coordination. They
share a language and with that shared language they can combine their work
into something no one of them could build alone." God doesn't remove their
bricks or their skill — "He takes away their ability to understand one
another, and construction stops."

## The claim

"Large software projects have never been limited only by how quickly an
individual can produce code. They are limited by how well people can
coordinate their understanding of the system they are changing." That shared
language isn't English or Python: "it is the common understanding of what its
concepts mean, where the boundaries are, which invariants matter, who owns
what, and why the system has the shape it does" — held partly in docs and
code, but mostly in "code review, conversations, arguments, and the
experience of having to explain a change to somebody else."

Before agents, this understanding was maintained by friction: "If I wanted to
change your storage layer, I usually had to read your code, ask you
questions, and perhaps coordinate with another team whose service depended on
it." Much of that slowness was waste, "but not all of it was. Some of it was
the process by which your understanding became mine, and by which both of us
discovered whether we still agreed about how the system worked. This friction
synchronizes people."

## What agents remove

Agents let each engineer act alone in parts of the system that used to
require other people: "I can ask an agent to add OAuth, you can ask one to
add caching, and somebody else can ask one to rebuild the database from first
principles and make the UI pink. Each change can be reasonable in isolation.
The code can compile, the tests can pass, and the explanations can be
generated on demand. None of us necessarily has to talk to the others, or
even acquire the part of the shared model that the change once would have
forced us to learn." Ronacher's framing: "agents do not feel pain, only
humans do" — so agents now absorb work in codebases and organizational
boundaries where a human doing the same work "would have revolted."

## Why it doesn't announce itself

The essay's turn on the Babel story is that the failure mode looks nothing
like the original: "it's not the biblical story. At Babel, the loss of common
language stops construction whereas in AI-assisted engineering, construction
can continue after shared understanding has already collapsed. The lack of an
immediate failure is what makes it curious and a bit disorienting. The tower
does not fall, and so we do not notice what was lost. It just keeps rising."
Every developer has "a tireless translator that can explain a corner of the
tower and make whatever local alteration they ask of it" — so the codebase
becomes Babel "not because nobody can communicate, but because nobody needs
to."

The claim pairs with
[you can't design software you don't work on](/knowledge/SWE/software-design/you-cant-design-software-you-dont-work-on.md):
both locate real design knowledge in engineers who have engaged with a
system's concrete details, and both read agent-mediated delegation as a way
to skip that engagement while still producing code that compiles.

# Citations

- Source: <https://lucumr.pocoo.org/2026/7/13/the-tower-keeps-rising/>
