---
id: em:87b2dd
type: reference
title: "feedpaper — turning RSS subscriptions into an e-ink newspaper"
description: A Homebrew CLI that converts unread Feedbin RSS items into an EPUB for a screenless e-ink reader, replacing phone-based feed reading.
resource: https://heyjonny.dev/posts/rss-to-eink-newspaper/
provenance: "heyjonny.dev, fetched 2026-08-18; surfaced via Hacker News"
tags: [rss, e-ink, reading-workflow, epub, feedbin, personal-tools]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# feedpaper — turning RSS subscriptions into an e-ink newspaper

feedpaper is a small Homebrew-installable tool that turns an RSS subscription
list into a disconnected reading session. It talks to the
[Feedbin](https://feedbin.com) API to pull unread posts, filters out formats
that don't survive translation to e-ink (YouTube-channel feeds,
JavaScript-rendered blogs), marks the pulled items as read in Feedbin, and
compiles the remainder into a single EPUB file. That file is transferred to a
small e-ink device — the author uses the Xteink X4, a 4.3" reader running the
open-source **Crosspoint** firmware — for reading away from a phone or
laptop.

## Design choice

The notable choice is what it doesn't do: no in-device network stack, no
browser, no notifications. The EPUB is a snapshot, generated on demand, read
offline. This trades freshness (you must resync to get new posts) for the
actual goal — a reading session with no path back to a screen that also does
everything else.

## Caveats from discussion

The approach depends on feeds publishing full content (not summaries/
excerpts), since there's no browser fallback for images or truncated text;
and it inherits Feedbin as a paid backend dependency rather than being
feed-source-agnostic. Alternative stacks mentioned in discussion: Instapaper
+ Kobo via IFTTT, KOReader's built-in news downloader, and a competing
web-based Kindle RSS reader (inkfeed.xyz).

# Citations

- Source: <https://heyjonny.dev/posts/rss-to-eink-newspaper/>
