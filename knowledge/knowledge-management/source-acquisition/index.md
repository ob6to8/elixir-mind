# source-acquisition

Getting source material out of hosts that resist an ordinary fetch — the
practical techniques that stand between a URL and something distillable. The
companion to [`/intake`](/.claude/skills/intake/SKILL.md)'s link-resolution step,
which points here when a fetch returns nothing usable.

## Snippets

- [Getting a Reddit thread when every direct fetch is blocked](/knowledge/knowledge-management/source-acquisition/reddit-thread-when-fetch-is-blocked.md) — WebFetch refuses `reddit.com` and Reddit's JSON endpoints 403 a datacenter IP; route 1 is the Arctic Shift archive API (clean JSON, no challenge), falling back to a Redlib mirror whose Anubis `preact` challenge is one SHA-256, not a proof-of-work search. `em:8df8d1` _(snippet)_
- [Getting a YouTube transcript when the page fetch is blocked](/knowledge/knowledge-management/source-acquisition/youtube-transcript-when-fetch-is-blocked.md) — the working `yt-dlp` invocation after a plain fetch returns page chrome and the default extractor hits the bot check; subtitles download even when every media format is DRM-blocked.
