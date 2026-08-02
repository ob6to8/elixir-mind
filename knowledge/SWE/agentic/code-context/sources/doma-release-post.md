---
id: em:f65f82
type: source
title: "doma release post — \"All my homies hate `grep`\" (r/LLMDevs)"
description: Verbatim capture of the r/LLMDevs announcement of doma — the author's motivation (Claude "grepping wildly all over the place"), the single-binary no-dependency stance, the sibling doyo, and the CLAUDE.md integration advice — plus both comments present at capture, including the author's doma-vs-ripgrep positioning.
resource: https://www.reddit.com/r/LLMDevs/comments/1vd6d2b/all_my_homies_hate_grep/
provenance: "u/HornyNarwahl on r/LLMDevs, posted 2026-08-02T02:53:29Z; recovered verbatim via the Arctic Shift archive API because reddit.com and its mirrors refuse fetches from this environment (route recorded in the Reddit source-acquisition snippet)"
tags: [source, reddit, doma, bm25, search, agent-tooling, release-post]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T09:30:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "the operator asked for the release post on file alongside the doma reference"
---

# doma release post — "All my homies hate `grep`" (r/LLMDevs)

The announcement post for [doma](/knowledge/SWE/agentic/code-context/doma.md),
kept verbatim as the primary source for the author's motivation and claims.
Reddit's export backslash-escapes are normalized; wording is otherwise
untouched.

## The post

> Jk, they fucking love grep, which is why I have made
> [doma (DOcument MAtcher)](https://github.com/L34Z/doma), a small and fast
> single binary [BM25](https://en.wikipedia.org/wiki/Okapi_BM25) search over
> your code and docs with no\* external dependencies, written in Odin.
>
> I made it because I wanted Claude to stop grepping wildly all over the place.
> It significantly faster than `grep` from my testing but it also significantly
> reduces search misses since you get semantically relevant results.
>
> It was also quite important to me that it was fast with a low footprint,
> lacking in NodeJS bullshit, MCP servers, etc., etc.
>
> Sick of all of these supply chain vulnerabilities and huge dependency bloat
> everywhere smh
>
> I used Claude Code through the entire development of it and it's sibling
> [doyo (DOcument YOinker)](https://github.com/L34Z/doyo) which shares
> philosophy and handles the document acquisition side of things, though it
> isn't quite as elegant as doma imo.
>
> I hope you find it helpful!
>
> I strongly recommend putting doma instructions in your per project
> [CLAUDE.md](http://CLAUDE.md) telling it how to use it, and to actually use
> it. Let me know if you do, I'm curious if others find it as helpful as I
> have.
>
> \*soft git dep, optional

## Comments at capture

**u/jorgejoppermem** (2026-08-02T03:35:31Z):

> Any metrics? How does it perform compared to parallel grep tools like
> ripgrep?

**u/HornyNarwahl** (the author, 2026-08-02T03:46:41Z):

> There are some basic metrics at the bottom of the README but I intend to add
> some more comprehensive numbers soon.
>
> I'll add a case for rg specifically but I suspect it would probably blow past
> doma in throughput. However they solve different concerns, doma's biggest
> strength is semantic indexing as well as the rapid query times. If you need
> the exact bytes of a specific file very fast rg will almost certainly win,
> but as far as finding the correct file in the first try when you don't know
> where the content lives doma will probably be much more fit to purpose.

## Capture state

Captured 2026-08-02T09:21Z, roughly six hours after posting: score 1, flair
"Tools", two comments (both above). The claim to read carefully is
"semantically relevant results" / "semantic indexing": the doma README's own
scope list excludes stemming, stopwords, fuzzy matching, and "embeddings or
models of any kind", so the mechanism is ranked lexical matching throughout —
see the [doma reference](/knowledge/SWE/agentic/code-context/doma.md) for that
reading.
