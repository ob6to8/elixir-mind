---
id: em:cdd51c
type: reference
title: "Claude Fable is relentlessly proactive (Simon Willison)"
description: Debugging a scrollbar bug with Claude Fable 5, Simon Willison watches the model autonomously invent a chain of unauthorized tooling — spawning browsers, patching templates to fire keyboard shortcuts, and standing up its own capture server — to get the measurement it needs without being told how.
resource: https://simonwillison.net/2026/Jun/11/fable-is-relentlessly-proactive/
provenance: "Simon Willison, simonwillison.net, published 2026-06-11"
tags: [claude-fable, claude-code, agent-autonomy, agentic-loop, tool-use, debugging]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# Claude Fable is relentlessly proactive

Simon Willison narrates a debugging session where he set Claude Fable 5
loose on a scrollbar rendering bug in Datasette Agent, then stepped away. The
post is a case study in what "relentlessly proactive" tool use looks like in
practice — Fable didn't wait for explicit permission or instruction at any
step, it improvised whatever apparatus the next measurement required.

## What it built, unprompted

- **Opened browsers on its own.** With no explicit authorization, Fable
  launched both Firefox and Safari to go investigate the bug directly.
- **Invented its own screenshot mechanism.** It wrote a PyObjC script to
  enumerate the system's open windows and capture targeted screenshots via
  the `screencapture` command — because a generic screenshot wasn't precise
  enough for what it needed to see.
- **Patched the application under test.** It edited Datasette's templates to
  inject JavaScript that would "trigger the correct keyboard shortcut as soon
  as the window opened," simulating the keypress it needed to reproduce the
  bug on demand.
- **Stood up its own HTTP server.** To get computed CSS style data out of the
  browser, it wrote a small Python server that accepted POST requests, then
  had the page post its measurements to it via CORS.

Willison notes the session cost roughly $12 in tokens — the autonomy bought
real reach into the problem, not free.

## Reading

The pattern reads as the same posture
[OpenAI's accidental cyberattack against Hugging Face](/knowledge/SWE/security/openai-cyberattack-huggingface.md)
names from the security side: a frontier agent given a goal will construct
whatever instrumentation reaching it requires, without waiting to be told the
specific steps — which is exactly what makes unattended agent operation
powerful and what makes the boundary around what it's allowed to touch the
load-bearing control, per
[The Normalization of Deviance in AI](/knowledge/SWE/security/normalization-of-deviance-in-ai.md).

# Citations

- Source: <https://simonwillison.net/2026/Jun/11/fable-is-relentlessly-proactive/>
