---
id: em:31fed1
type: snippet
title: "Getting a YouTube transcript when the page fetch is blocked"
description: The working `yt-dlp` invocation for pulling a video's transcript and metadata after an ordinary web fetch returns only page chrome and the default extractor hits YouTube's bot check — subtitles survive because they need no media format.
provenance: "Derived in-session 2026-07-28 while intaking a conference talk; every command below was run and its failure mode observed first-hand"
tags: [snippet, source-acquisition, intake, yt-dlp, youtube, transcripts, fetching]
timestamp: 2026-07-28T09:50:00Z
attribution:
  when: 2026-07-28T09:50:00Z
  channel: agent-authored
  agent: "Claude Code agent, /intake session"
  why: "the working incantation existed only in a session transcript after the ordinary fetch path failed; filed so the next blocked video fetch does not re-derive it"
---

# Getting a YouTube transcript when the page fetch is blocked

## The problem

`WebFetch` on a `youtube.com/watch?v=…` URL returns the page's **footer and
navigation chrome** — no title, no description, no transcript. The video data is
client-rendered, so there is nothing in the fetched HTML to distill. Treating this
as "the source is unavailable" is the wrong conclusion; the source is fine, the
fetch shape is wrong.

## Cheap metadata: the oembed endpoint

For title and channel alone, no tooling is needed — oembed is public and returns
JSON:

```
https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=<ID>&format=json
```

This is enough to identify a video, but it carries **no description and no
transcript**, so it does not support a distilled capture on its own.

## Full transcript and metadata

```bash
yt-dlp --js-runtimes node \
       --extractor-args "youtube:player_client=web_embedded,tv" \
       --ignore-no-formats-error \
       --skip-download --write-auto-subs --write-subs \
       --sub-langs "en.*" --sub-format "vtt/srv3/best" \
       --write-description --write-info-json \
       -o "talk" "https://www.youtube.com/watch?v=<ID>"
```

Each flag answers a failure observed in sequence — the plain invocation fails,
and so does each intermediate fix:

| Symptom | Cause | Flag that clears it |
|---|---|---|
| `HTTP Error 429`, then `Sign in to confirm you're not a bot` | default extractor path is rate-limited and bot-checked | `--extractor-args "youtube:player_client=web_embedded,tv"` — alternate player clients |
| `No supported JavaScript runtime could be found` | extraction now needs JS execution; only `deno` is enabled by default | `--js-runtimes node` (node is present in this environment) |
| `ERROR: This video is DRM protected` | the `tv` client may serve DRM-protected media formats | `--ignore-no-formats-error` |

**The load-bearing insight is the last row.** Subtitle tracks, the description,
and the metadata JSON are *not* media formats, so they download fine even when
every video format is DRM-blocked. `--ignore-no-formats-error` stops yt-dlp
aborting on the unusable formats and lets the artifacts you actually want through.
Combined with `--skip-download`, no video is ever fetched.

## VTT to plain text

Auto-generated captions repeat each line as the caption rolls, so a naive strip
yields heavy duplication. Drop timing lines and inline tags, then suppress
consecutive repeats:

```python
import re
lines = open('talk.en.vtt').read().splitlines()
out, prev = [], None
for ln in lines:
    if '-->' in ln or ln.strip() in ('', 'WEBVTT') or ln.startswith(('Kind:', 'Language:')):
        continue
    txt = re.sub(r'<[^>]+>', '', ln).strip()
    if txt and txt != prev:
        out.append(txt); prev = txt
open('transcript.txt', 'w').write(' '.join(out))
```

## Filing the result

The transcript is **raw source material**, not the document. Per
[capture the knowledge, cite the source](/meta/policy/capture-knowledge-cite-the-source.md),
distill it and keep the video URL in `resource` and under `# Citations`; the
`.vtt` and `.info.json` files belong in the scratchpad, not the bundle. The
description often carries chapter timestamps worth reading before distilling —
they are the speaker's own outline of the argument.

**Scope of what was verified:** this path was exercised against one public talk on
2026-07-28 in this container. It is not a claim about every video — an
age-restricted, members-only, or genuinely private video needs credentials this
recipe does not supply.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:31fed1">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-ontology-guardrails-intake-and-jido-comparison (2026-07-28)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:31fed1`]**

Checked rather than recalled. The substantive work is entirely persisted: working tree clean, `git log origin/main..HEAD` returns zero commits, both PRs in `main`'s history. Two things are not — the conversation turns since the last commit (a work report, timer cleanup, this exchange), none carrying knowledge not already in the merged artifacts; and the scratchpad, which dies with the container by design since the source URL is in `resource` and the load-bearing quotes are in the reference and analysis bodies.

One genuine small gap: the yt-dlp incantation that defeated YouTube's bot check exists nowhere durable. The plain fetch returned only page chrome, and the working path is recorded only in this conversation. Re-deriving it next time costs a few minutes of trial and error.

Running `/create-pull-request` is clear but would produce a capture-only PR, since the tree is clean. The one argument for it is that the render currently ends on an operator instruction with no assistant response after it.

---

**[`em:31fed1`]**

The ledger-upkeep issue needs no decision here. It's already persisted as a `type: issue` under `meta/issues/`, `status: open`, with all three candidate fixes written into the body. It's not a plan and shouldn't be one — per the routing policy a plan commits to work, and nothing is committed yet; when you pick a fix, *that* becomes the plan. It surfaces automatically via `/issue` and `/priorities`, and the repo's precedent matches (the dev-history and policy-index issues both carry weighed-but-unchosen fixes). Nothing is lost by closing this thread.

For the yt-dlp recipe: the right home is a `type: snippet` in the taxonomy (durable, has an `em:` id, queryable) **plus a pointer in `/intake`'s link-resolution step** — because that step is what's in an agent's context at the moment a fetch fails, which is the only moment the recipe matters.
