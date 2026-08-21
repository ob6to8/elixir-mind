---
id: em:368670
type: reference
title: "It does what it says on the tin: why naming matters more with AI (Wicksipedia)"
description: "A misleading function name that a human reviewer would have questioned gets taken at face value by an AI coding agent and built on with confidence, illustrated by a TinaCMS feature request Claude implemented against an unreliable API it had no reason to distrust."
resource: https://wicksipedia.com/blog/it-does-what-it-says-on-the-tin
provenance: "Wicksipedia (Matt Wicks), wicksipedia.com essay, published 2026-03-02"
tags: [naming, clean-code, ai-assisted-development, code-quality, api-design]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# It does what it says on the tin: why naming matters more with AI

The essay's frame, from an old boss: "It should do what it says on the box" —
a paraphrase of the Ronseal wood-stain slogan. The author's claim is that
misleading names, always a code smell for humans, are now a liability for AI
agents in a way they weren't before: "When your function name lies,
developers get confused. When AI reads that lie, it builds on it
confidently." A human developer reading `getUser()` that quietly updates a
login timestamp and fires an analytics event might "sniff out the bad smell,
read the source, and sigh." An agent has no such reflex: "LLMs don't have
trust issues. When an agent sees `getUser()`, it doesn't get suspicious about
hidden database writes... An AI could just take it at face value and build a
tower of assumptions on top of your bad label."

## The TinaCMS example

A developer pointed Claude at a straightforward-looking feature request
against TinaCMS — warn the user before navigating away from a dirty form.
TinaCMS's dirty-state tracking is known (to people who've been burned by it)
to be unreliable, but "Claude didn't know that. It read the form APIs, took
them at face value, and assumed they worked as advertised" — and separately
rolled its own navigation-blocking logic instead of upgrading React Router to
a version with `useBlocker` built in. "The whole thing looked perfectly
reasonable in the PR. It just didn't work reliably, because Claude trusted
the tin." The gap: a human with the scar tissue would have checked whether
the dirty flag actually fired; "unfortunately there weren't any tests for
this," so naming and behavior were the only signal the agent had to go on.
"Clean names have always been fundamental. They still are, and they're not
just for the next developer anymore. They're for every tool that reads your
code."

## The tin test

A checklist the author applies to names (functions, files, email subjects,
server names alike):

- **Can you tell what it does without reading the body?** `sendWelcomeEmail()`
  passes; `handle()` doesn't. Reaching for `process`, `manage`, or `execute`
  is a sign the design isn't finished yet.
- **Side effects? Say so, or split it.** `validateAndSaveOrder()` is honest
  about doing two things; `updateUserAndNotify()` beats an `updateUser()`
  that silently emails someone. Splitting is better still.
- **Be specific about what comes back.** `findUserByEmail()` tells you the
  lookup key; `fetchActiveSubscriptions()` tells you it queries an external
  source and filters. A name that leaves the not-found path ambiguous
  (exception vs. empty result) hasn't finished its job.

The root cause, per the author, is ordinary laziness rather than a hard
problem: "slapping `processData` on a function is way faster than stopping
your flow to figure out what the code is actually doing," and the cost lands
later — on whoever (often the same person) has to reconstruct what "process"
meant.

Extends
[Guarding Against AI Drift](/knowledge/SWE/agentic/code-quality/guarding-against-ai-drift.md)'s
premise that the mechanical guardrails and the human review layer both exist
because an agent won't independently notice a codebase's rough edges: this
essay locates one specific rough edge — a name the code doesn't live up to —
that a name-trusting agent has no way to detect on its own.

# Citations

- Source: <https://wicksipedia.com/blog/it-does-what-it-says-on-the-tin>
