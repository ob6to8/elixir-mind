---
id: em:e59bab
type: concept
title: proof of work
description: A scheme that makes a client demonstrate it spent measurable computation — typically by searching for an input whose hash meets a difficulty target — so issuing requests at scale costs the requester something.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, security, bot-mitigation, hashing, source-acquisition]
timestamp: 2026-07-29T03:00:47Z
attribution:
  when: 2026-07-29T03:00:47Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "the mechanism the Anubis bot check in front of a Redlib mirror advertises"
---

# proof of work

The asymmetry is the whole design: finding an acceptable input requires many
trials, checking one requires a single hash, so the server's cost stays
negligible while the client's scales with the difficulty parameter. Bot-check
gateways adopted it to price scraping rather than to identify anyone — no
credential is involved and nothing is proven about who the client is.

Not every challenge advertising a difficulty performs a search. Some methods
require only a single hash of a server-supplied string and use the difficulty as
a display delay, so the gate tests whether a client can execute the page's
JavaScript at all rather than whether it will spend anything — a distinction that
decides whether the challenge is cheap or expensive to satisfy from a script
(see [getting a Reddit thread when every direct fetch is blocked](/knowledge/knowledge-management/source-acquisition/reddit-thread-when-fetch-is-blocked.md)).

*Seen in:* [Getting a Reddit thread when every direct fetch is blocked](/knowledge/knowledge-management/source-acquisition/reddit-thread-when-fetch-is-blocked.md), [2026-07-29 thread](/meta/threads/2026-07-29-graphrag-serialization-claim-and-its-critic.md)
