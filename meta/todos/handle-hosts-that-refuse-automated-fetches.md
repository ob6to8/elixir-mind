---
type: todo
title: "Give the fetching skills a stated fallback for hosts that refuse automated fetches"
description: Done when /bookmarks, /research, and /intake say what to do when a host blocks the sandbox — record the block, ask the operator to paste, and never substitute a search result for the blocked page.
status: open
tags: [meta, todo, skills, fetching, reddit, egress]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T04:30:00Z
  channel: agent-authored
  agent: "Claude Code agent, channels-register session"
  why: "Reddit blocked every fetch path during the channels-register session; the agent's recovery was improvised, and the near-miss (filing listicle results as if they were the blocked thread's contents) is the failure the skills should rule out by rule"
  from: [/meta/threads/2026-07-28-channels-register-merge-and-video-vetting.md]
---

# Give the fetching skills a stated fallback for hosts that refuse automated fetches

Some hosts refuse this sandbox outright. Reddit is the confirmed case: on
2026-07-28 it returned HTTP 403 to `WebFetch`, to `curl` against
`www.reddit.com`, `old.reddit.com`, and `api.reddit.com`, and to four redlib
mirrors (which serve Anubis proof-of-work walls). The pre-installed Chromium
could not reach the proxy at all, failing `ERR_CONNECTION_RESET` even on
`example.com`, so the browser is not a workaround.

[`/bookmarks`](/.claude/skills/bookmarks/SKILL.md),
[`/research`](/.claude/skills/research/SKILL.md), and
[`/intake`](/.claude/skills/intake/SKILL.md) all assume a URL can be fetched.
None says what to do when one cannot be, so the handling is improvised per
session.

## The failure this rules out

The dangerous move is not stopping — it is **substituting**. With the thread
unreachable, a web search returned generic "best LLM YouTube channels"
listicles. Filing those as though they were the blocked page's contents would
have put unverified material in the brain under a false `resource`, and nothing
downstream would ever have flagged it: the frontmatter would name a URL whose
contents were never read.

That is [negative findings name their
scope](/meta/policy/negative-findings-name-their-scope.md) applied to fetching —
a page that could not be read is a fact about the fetch, not a licence to
reconstruct the page from elsewhere.

## Shape of the fix

The rule is small and the same in all three skills:

- **Record the block** on the row or in the response, naming what was tried, so
  the finding is scoped rather than a bare "couldn't get it".
- **Ask the operator to paste** the content, which is what actually resolved the
  Reddit case.
- **Never substitute** search results, mirrors, or model recall for the blocked
  page. A `resource` URI asserts the content was read.

Whether this earns a line in each `SKILL.md` or a single cross-linked policy is
the open question; the skills-registry already prefers terse skills with the
reasoning elsewhere.

## Cancel condition

If the block turns out to be transient — a datacenter-IP reputation issue that
lifts, confirmed by a later successful fetch — this may be closed as
`cancelled`, since the improvised handling would then be adequate for a case
that no longer recurs. The block being *deliberate* on Reddit's side is what
makes it worth encoding.
