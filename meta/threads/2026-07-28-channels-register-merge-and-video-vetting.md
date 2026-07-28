---
type: reference
title: 2026-07-28-channels-register-merge-and-video-vetting
description: Built a channels source register, vetted the video channels from an r/LLMDevs thread down to five on output evidence, then reconciled it against the register PR #146 had landed on main in parallel — keeping main's ratified table shape and folding in the ingested-documents join.
provenance: "Claude Code session (Opus 5), 2026-07-26 to 2026-07-28; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, channels, survey, sources, provenance, merge-conflict]
timestamp: 2026-07-28
pr: 152
session: https://claude.ai/code/session_01RH6XAeSrdkLp3wWAwkJ6xh
---

# 2026-07-28-channels-register-merge-and-video-vetting

## Where this landed

The session set out to build a "channels" document — a register of the sources the
brain draws from, each linked to the documents ingested from it — and to seed it from
an r/LLMDevs thread recommending non-hype YouTube channels.

Two things shaped the outcome. First, Reddit refuses automated fetches from this
sandbox (403 to direct, JSON, and mirror endpoints; the pre-installed Chromium cannot
reach the proxy at all), so the thread's contents arrived only when the operator
pasted them. The register was built from real data in the meantime — the resource URIs
of all 70 filed documents carrying one, resolved into roughly 35 channels. Second, a
parallel session had already landed `survey/channels.md` on main via PR #146, with a
different design: a forward-looking table of what to monitor and what access it costs,
ratified by the `channel` glossary concept and wired into `/research` as its first
per-domain search step.

The merge kept main's shape, on the grounds that it was ratified and had a live
consumer, and folded this branch's content into it: 33 further channels with access
notes added to fit, the five vetted video channels, and an `Ingested` column carrying
the source-to-document join that neither version had alone. The operator confirmed the
column should stay, so the register's design statement and the `channel` concept were
both widened to claim it — a row now runs in both directions, prospective and
retrospective, with the yield serving as the evidence for continued attention.

The video vetting is the part worth remembering. Sixteen nominations became five,
judged on each channel's actual recent uploads read from its RSS feed rather than on
its self-description or the strength of the comment recommending it. The two sources
disagreed often enough to reverse two calls: Protorikis, a bare name-drop, turned out
to publish the most rigorous benchmarking of the set, while House of El and Mo Bitar,
nominated as anti-hype, publish collapse-and-panic commentary. The eleven rejects were
first recorded with their reasons, then dropped at the operator's direction with the
reasoning left in git history.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Channels register: shape, placement, and the merge with the version PR #146 landed | closed | [channels register](/survey/channels.md) | - |
| The `channel` concept widened to cover the register's retrospective half | closed | [channel](/beliefs/glossary/channel.md) | - |
| Video-channel vetting: sixteen nominations judged on RSS output, five kept | closed | [channels register](/survey/channels.md) | - |
| Reddit is unfetchable from this sandbox; the thread was pasted by the operator instead | paused | `unrouted` | Worth a tracked issue if `/research` or `/bookmarks` ever needs Reddit as a source? |
| Register is hand-maintained; the `Ingested` column is re-derivable but not generated | paused | [channels register](/survey/channels.md) | Should a `mix brain.channels` generator own the column, as contract/registry/code-map do? |

## User

lets create a "channels" document, which stores all channels/sources (video, blog posts, articles, reddit, etc) and links to whatever documents have been ingested that relate. To this, i would like to add the sources on this thread (include this link as a note, ie. sourced from this, though do NOT actually ingest this link:)

https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/recommended_nonbs_youtube_channels/

## Assistant

Built and pushed to `claude/channels-document-sources-f2qjvu`.

**[survey/channels.md](https://github.com/ob6to8/elixir-mind/blob/claude/channels-document-sources-f2qjvu/survey/channels.md)** — the source register.

Where `bookmarks.md` tracks individual links awaiting intake, `channels.md` tracks the *sources* behind them: each channel gets a medium (`blog` · `papers` · `docs` · `repo` · `video` · `forum` · `reference-work` · `pdf`), a status (`ingested (N)` / `known`), tags, a one-line characterization, and bundle-absolute links to every document ingested from it. Every filed doc already records its own origin in `resource`; this is the inverse join — what a channel has produced.

I seeded it from the real data rather than leaving it empty: all 70 filed documents carrying a `resource` URI, resolved to ~35 channels across six sections. Densest: Claude Code docs (6), arXiv (10), GitHub (6), *Artificial Intelligence* journal (4), Simon Willison (3), Wikipedia (3).

Filed in `survey/` as a second register — non-bundle namespace, no `em:` id, outside the taxonomy — so no shape change needed. Both indexes updated. `mix brain.verify`, `route_tags`, format and compile are green; all 76 internal links resolve.

**The Reddit sources are not in it, and I didn't invent them.** Reddit returns 403 to every automated fetch from this environment — direct, `.json`, `old.reddit`, `api.reddit`, and four redlib mirrors (Anubis proof-of-work walls) — and the pre-installed Chromium can't reach the proxy at all (`ERR_CONNECTION_RESET`, including on `example.com`, so that's an environment limit, not a Reddit one). A web search surfaced generic "best LLM YouTube channels" listicles, not that thread; filing those as if they were the thread's recommendations would have put unverified content in the brain under a false provenance.

So the thread is recorded exactly as you asked — a pointer, deliberately not ingested — as a `known` entry heading the Video section, with r/LLMDevs itself registered as a channel. The section carries an explicit **Pending** line naming why the list is absent.

Could you paste the channel list from that thread? Handles or names are enough — I'll fetch each channel, write the one-line characterization, and fill in the Video section in a follow-up commit on the same branch.

Two smaller notes:
- The register is hand-maintained and will drift as documents are filed. I documented the re-derivation `grep` in a Maintenance section so drift is checkable, but this is a natural candidate for a `mix brain.channels` generator later — say the word and I'll file it as a todo rather than assume it.
- If you'd rather this be a top-level `channels/` directory than a register under `survey/`, that's a change to the shape of the tree and needs your ratification; the move is cheap while it's one file.

## User

here is the copy from the reddit thread:

Recommended Non-BS Youtube Channels
[Help Wanted](https://www.reddit.com/r/LLMDevs/?f=flair_name%3A%22Help%20Wanted%22)
Do you have any suggestions of Youtube Channels that are not click-bait BS ones?
A good test for it today: one that hasn't published "Opus 5 is AGI" or "Opus 5 is Fable-like" (the same apply to other statements regarding models from other companies).
I'm looking for an actual technical channel that is doing (or communicating) independent testings of released models, instead of parroting vendor's PR stunts. Thanks in advance for any tips!
Upvote11Downvote10Go to commentsRepostShare
[adobe](https://www.reddit.com/user/adobe/)•[Promoted](https://www.reddit.com/user/adobe/)
[Frame it how you like it. With Photoshop's enhanced Frame tool, you can now frame an image in a custom shape or triangle. Plus, generate assets inside a shape.](https://alb.reddit.com/cr?za=z6LxB1589G1R3TCXxT-7E6lh0c8Ai9myk6ThuSi6p3jGKG1x14j0D1uNO8kEFROuGP_8RL6xVplY3rtZh2DXkpbZmg2JajMKC2nloJHv8C5dYuT9_lkoOo1WGGv_O_LjkfY0MwlLThKcb344b3hIgphGx6xInFttzEefogkyyNEmB7a7Umfjir4myGTYnbaFHQmsoGaxcEBKtsHmnD4xYC8WPKSJjfsb6XuDjS6r7NNFDC8Z-DyHkvOBnDA1zI18OhT7xeUWMwNrrR-ZxSVc4XrZ-YFLbCCwbIyhzFe9J1jkG5x816EqI-yVPIhGyKewHs_a4MyOQ39dEpY6D8gZgI8QNI3Uksr-Yjd3GKIopHoc2jEgDaEa5R3FC1n6BlTKsLgjAUZoAIv_6ahItRkAtl_PUzKl_ILtN6CVGpbzRKi1dUzP7cbxgTf7AqJgwqIikyGhpiOtDB8h2c9nHAgyzKreRDjrJ1zUbBcB64G-oo6qrhbbb7n5Z2tht3Z0fn_oemuc5q7kk94eCN0PI4Lhj1QiA6uUqqYEaEKpCP1_oBHP1rFC6orEIaElUj7xJ55kann60GPvHsgXJOJQXiyM7zW-49qx_jk34XPKBtIbpgOWatJfKliIA2tdJRUv71e_CmPSBJj2h-t4VWRBMN-5WahIQWaHg_EGgZE-1AsPsxBKfq0pPbUPsyH71y7flJdQrg989yyrmdVKuazUbIZAKqdWlXVATZYh_boygIfmILPovaU4w4N3_gsFKoPoxd7i-ih8k3UhDz2-Q15H3A6Ib4LEIne8wsKYu6A753Gp4C_Y4CFVyrv1MqiVyL7HmU81efW-gB06MZlXay3Tu81I1jPi40RjbmylgYsMleX6ohGZ-gVY8d3MnKKsURSIyGuaI2hwDoNwCTDx1ZprVjoTW5bcGuCzeOj0epueCJBkZ4hmy8_lr2NZxrslDAUnDYckqBfVRjtxFuq2QCXrpiWm2IEK6mjX0wrkbhXJ37NRn2T8nlafBofmjEhYWDAxNdF5BFPnxYUYfI7e569DghUdwdygCSh2jORBYWFpig&zp=QeLBIdJr3UIFVh1oAxJf9J6aXUSEsBT8atheuO5gl4g7lztMHEVHnzo70tDhDlY7-yyqjcMNxnUWnckySMJ08T5m61JAYkrRMn3jfeT1KEXbB3cQ5eU0RWTkBJiXXHb_FRTrIThXFcFx9Nq25VEtmnkMBkgLmdNw1VeQEklNOIZ-Ph5KMy18T5gx1Wov4vdh-OP8pwzKH-I-S7M6KHmuqweECCnkIKs4uBxHjdG1EkNS8wDhpNdER84QRCNOKt6BwAEgkuEwn-dfOpKdxopzCi1pnebuZMubaiL9mCdsznnuhTESkX45FpZjbyysBWUWQKhjLeO_bX-L0xiYnSMM&a=2966&b=2962&be=2962&c=2962&d=2966&e=2962&ea=2962&eb=2962&f=2962&r=4&g=1&i=1785105227405&t=1785105230371&o=1&q=1&h=188&w=732&sh=982&sw=1512)
[Learn More](https://alb.reddit.com/cr?za=z6LxB1589G1R3TCXxT-7E6lh0c8Ai9myk6ThuSi6p3jGKG1x14j0D1uNO8kEFROuGP_8RL6xVplY3rtZh2DXkpbZmg2JajMKC2nloJHv8C5dYuT9_lkoOo1WGGv_O_LjkfY0MwlLThKcb344b3hIgphGx6xInFttzEefogkyyNEmB7a7Umfjir4myGTYnbaFHQmsoGaxcEBKtsHmnD4xYC8WPKSJjfsb6XuDjS6r7NNFDC8Z-DyHkvOBnDA1zI18OhT7xeUWMwNrrR-ZxSVc4XrZ-YFLbCCwbIyhzFe9J1jkG5x816EqI-yVPIhGyKewHs_a4MyOQ39dEpY6D8gZgI8QNI3Uksr-Yjd3GKIopHoc2jEgDaEa5R3FC1n6BlTKsLgjAUZoAIv_6ahItRkAtl_PUzKl_ILtN6CVGpbzRKi1dUzP7cbxgTf7AqJgwqIikyGhpiOtDB8h2c9nHAgyzKreRDjrJ1zUbBcB64G-oo6qrhbbb7n5Z2tht3Z0fn_oemuc5q7kk94eCN0PI4Lhj1QiA6uUqqYEaEKpCP1_oBHP1rFC6orEIaElUj7xJ55kann60GPvHsgXJOJQXiyM7zW-49qx_jk34XPKBtIbpgOWatJfKliIA2tdJRUv71e_CmPSBJj2h-t4VWRBMN-5WahIQWaHg_EGgZE-1AsPsxBKfq0pPbUPsyH71y7flJdQrg989yyrmdVKuazUbIZAKqdWlXVATZYh_boygIfmILPovaU4w4N3_gsFKoPoxd7i-ih8k3UhDz2-Q15H3A6Ib4LEIne8wsKYu6A753Gp4C_Y4CFVyrv1MqiVyL7HmU81efW-gB06MZlXay3Tu81I1jPi40RjbmylgYsMleX6ohGZ-gVY8d3MnKKsURSIyGuaI2hwDoNwCTDx1ZprVjoTW5bcGuCzeOj0epueCJBkZ4hmy8_lr2NZxrslDAUnDYckqBfVRjtxFuq2QCXrpiWm2IEK6mjX0wrkbhXJ37NRn2T8nlafBofmjEhYWDAxNdF5BFPnxYUYfI7e569DghUdwdygCSh2jORBYWFpig&zp=QeLBIdJr3UIFVh1oAxJf9J6aXUSEsBT8atheuO5gl4g7lztMHEVHnzo70tDhDlY7-yyqjcMNxnUWnckySMJ08T5m61JAYkrRMn3jfeT1KEXbB3cQ5eU0RWTkBJiXXHb_FRTrIThXFcFx9Nq25VEtmnkMBkgLmdNw1VeQEklNOIZ-Ph5KMy18T5gx1Wov4vdh-OP8pwzKH-I-S7M6KHmuqweECCnkIKs4uBxHjdG1EkNS8wDhpNdER84QRCNOKt6BwAEgkuEwn-dfOpKdxopzCi1pnebuZMubaiL9mCdsznnuhTESkX45FpZjbyysBWUWQKhjLeO_bX-L0xiYnSMM)
[adobe.com](https://alb.reddit.com/cr?za=z6LxB1589G1R3TCXxT-7E6lh0c8Ai9myk6ThuSi6p3jGKG1x14j0D1uNO8kEFROuGP_8RL6xVplY3rtZh2DXkpbZmg2JajMKC2nloJHv8C5dYuT9_lkoOo1WGGv_O_LjkfY0MwlLThKcb344b3hIgphGx6xInFttzEefogkyyNEmB7a7Umfjir4myGTYnbaFHQmsoGaxcEBKtsHmnD4xYC8WPKSJjfsb6XuDjS6r7NNFDC8Z-DyHkvOBnDA1zI18OhT7xeUWMwNrrR-ZxSVc4XrZ-YFLbCCwbIyhzFe9J1jkG5x816EqI-yVPIhGyKewHs_a4MyOQ39dEpY6D8gZgI8QNI3Uksr-Yjd3GKIopHoc2jEgDaEa5R3FC1n6BlTKsLgjAUZoAIv_6ahItRkAtl_PUzKl_ILtN6CVGpbzRKi1dUzP7cbxgTf7AqJgwqIikyGhpiOtDB8h2c9nHAgyzKreRDjrJ1zUbBcB64G-oo6qrhbbb7n5Z2tht3Z0fn_oemuc5q7kk94eCN0PI4Lhj1QiA6uUqqYEaEKpCP1_oBHP1rFC6orEIaElUj7xJ55kann60GPvHsgXJOJQXiyM7zW-49qx_jk34XPKBtIbpgOWatJfKliIA2tdJRUv71e_CmPSBJj2h-t4VWRBMN-5WahIQWaHg_EGgZE-1AsPsxBKfq0pPbUPsyH71y7flJdQrg989yyrmdVKuazUbIZAKqdWlXVATZYh_boygIfmILPovaU4w4N3_gsFKoPoxd7i-ih8k3UhDz2-Q15H3A6Ib4LEIne8wsKYu6A753Gp4C_Y4CFVyrv1MqiVyL7HmU81efW-gB06MZlXay3Tu81I1jPi40RjbmylgYsMleX6ohGZ-gVY8d3MnKKsURSIyGuaI2hwDoNwCTDx1ZprVjoTW5bcGuCzeOj0epueCJBkZ4hmy8_lr2NZxrslDAUnDYckqBfVRjtxFuq2QCXrpiWm2IEK6mjX0wrkbhXJ37NRn2T8nlafBofmjEhYWDAxNdF5BFPnxYUYfI7e569DghUdwdygCSh2jORBYWFpig&zp=QeLBIdJr3UIFVh1oAxJf9J6aXUSEsBT8atheuO5gl4g7lztMHEVHnzo70tDhDlY7-yyqjcMNxnUWnckySMJ08T5m61JAYkrRMn3jfeT1KEXbB3cQ5eU0RWTkBJiXXHb_FRTrIThXFcFx9Nq25VEtmnkMBkgLmdNw1VeQEklNOIZ-Ph5KMy18T5gx1Wov4vdh-OP8pwzKH-I-S7M6KHmuqweECCnkIKs4uBxHjdG1EkNS8wDhpNdER84QRCNOKt6BwAEgkuEwn-dfOpKdxopzCi1pnebuZMubaiL9mCdsznnuhTESkX45FpZjbyysBWUWQKhjLeO_bX-L0xiYnSMM)
Sort by:Best
Search CommentsExpand comment search
Comments Section
[Super_Percentage_205](https://www.reddit.com/user/Super_Percentage_205/)
•[12h ago](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/comment/ozueezj/)
I've found that the best way to avoid that hype cycle is to just ignore channels that post more than twice a week, they're all chasing the algo. You want someone who'd rather read a paper than make a thumbnail
the channels I trust tend to have like 5k subs and a voice that could cure insomnia but their methodology is rock solid
ReplyShare
[Physical_Concert_625](https://www.reddit.com/user/Physical_Concert_625/)
•[12h ago](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/comment/ozuf7rb/)
That's great adivice. Any channel you particularly recommend?
ReplyShare
[davidSenTeGuard](https://www.reddit.com/user/davidSenTeGuard/)
•[9h ago](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/comment/ozuygb6/)
https://www.youtube.com/@SenTeGuard
Trying to improve my craft and make it more watchable. Based on https://www.letters.senteguard.com/
ReplyShare
[bmcutright](https://www.reddit.com/user/bmcutright/)
•[11h ago](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/comment/ozuior0/)
Codacus is niche to local LLM hosting, very informative on the most basic stuff
ReplyShare
[Physical_Concert_625](https://www.reddit.com/user/Physical_Concert_625/)
•[9h ago](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/comment/ozv8ish/)
This seems to be a gem, thanks a lot! Just subscribed there.
ReplyShare
[tuoier](https://www.reddit.com/user/tuoier/)
•[10h ago](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/comment/ozure1w/)
sadly, if you are a top ai youtuber, you have to say that today...
ReplyShare
[PracticlySpeaking](https://www.reddit.com/user/PracticlySpeaking/)
•[6h ago](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/comment/ozvyvkg/)
Protorikis
ReplyShare
[u/OpenAI](https://www.reddit.com/user/OpenAI/)•[Promoted](https://www.reddit.com/user/OpenAI/)
[3 Codex plugins you should install now from Dominik Kundel — DX Engineer, OpenAI](https://alb.reddit.com/cr?za=PXIKpJkCUF5ivm-T0UHTTaiY8eAUc2eb_GIXo7BQZTRq_4cJ3XDH_sZaVURgs7y-SuHUOEiNx2gUld0iDih5RJyTStyzkJHAjXJCskjbwQTCvNuytCzLshyM3DBOa9gvd2fuWkfTqIhbgk7hRivyDHMXX1lCzd9hvoFgq7ximrbsbLPjgbVzgP7KPzk4q6vUvKZUHfI7n_pbwBr-nmYqzc-xaFshRng1u4jH-qPvGHtqGqkB3SdOK0zrFUXbDb27Cp1e5lqniKB6Wq9SUwp3YBwTCT3XqzVREgJexfckAMHuGo5k9o-aodbNoRJm-XZ7nM00g-Qw_n8oZsM5XZM2L4XtsB3UPCbEgFmUJzhq0w773CXEoNbp3YiCgZUrTVgGnfaONbZQWsirg622ufIKYWq0NKPqTVUwhCkj_Xcyi9ENeYC7uPSfXJ2-ZWeKnyEbo2szVWJNplflSEFLM7pAPG_5BgIwLG600JV2PLZ1ED6hU_NV-kB9jjxM4ku7Ck4v6uLQHPaCrHotmpyO_iuZo5vBxE1K1VIxxYw_Z-iWxAbEo_6TJij08VJ8Sij_NQlwkph1va02grcUzOegFKHM-K4TitU_RWc4Ns54k72FvMnWd_u0abgqbYFTDAjZNmF_rUhtYqIwLaqyZ_2bl0CCPFrMOGIFlqizeEVek8u2msXy0_K-tqecvVJ1tGgKWDu_iEe4fpvyvjUd8yQ7UnvA9T8mI_oPHgIr4Q&zp=ccfXnvXUtxwpqCpYoiz14WpNMHt2aoqjl0Ty5NyiOAJNc39g2cfJvTQF3919sOShIs2uDQSxMWCZTOtgnviL65R70ABdPG2fCooomQ1zDndoOmcdzxcO6vMytZsYro9Yp-CbkXISU4i5WOixsvkuAz80-yFIuogk1-C5km4sT4Iqp05R805KL_UIEYk2NJWv49pVgaTphS8fbFH9aM8udyQNhEM6ZDujcxSoTpN5kgnlxESMUkis3HuUmegKcelmfvlYzuRcjceEIynqKBwGjaj3j6lUlIqlXkcFZeudjK_LY-kfPdXExSfC2E-tZ7U8dE7GIlq_wxGKLCHu9zaPJwOQn_WIcBoteQPdXUmiTE95P4F93MYhEcRsdbyaIlLn8H8PQIbAqnCdZ4Brgkzxk0Gbw3WDCnr6k5xPaHm8HbqsPqOIHppGKo0XSTXUgdRmK7SR6hgHppct_CRWcd9Qw3M9hWSo4oedVIMhpHzSY_7c04ex1uklkm5zh2-6LwQdzvAQAa1BfsfraHUURhgG0DSoD4Wo6rFHIS3yBzX7-FbZFopvSPJa1Zm2UUc_DCz9M5vhPKA5JbtT4jirBXqv32c)
[Sign Up](https://alb.reddit.com/cr?za=PXIKpJkCUF5ivm-T0UHTTaiY8eAUc2eb_GIXo7BQZTRq_4cJ3XDH_sZaVURgs7y-SuHUOEiNx2gUld0iDih5RJyTStyzkJHAjXJCskjbwQTCvNuytCzLshyM3DBOa9gvd2fuWkfTqIhbgk7hRivyDHMXX1lCzd9hvoFgq7ximrbsbLPjgbVzgP7KPzk4q6vUvKZUHfI7n_pbwBr-nmYqzc-xaFshRng1u4jH-qPvGHtqGqkB3SdOK0zrFUXbDb27Cp1e5lqniKB6Wq9SUwp3YBwTCT3XqzVREgJexfckAMHuGo5k9o-aodbNoRJm-XZ7nM00g-Qw_n8oZsM5XZM2L4XtsB3UPCbEgFmUJzhq0w773CXEoNbp3YiCgZUrTVgGnfaONbZQWsirg622ufIKYWq0NKPqTVUwhCkj_Xcyi9ENeYC7uPSfXJ2-ZWeKnyEbo2szVWJNplflSEFLM7pAPG_5BgIwLG600JV2PLZ1ED6hU_NV-kB9jjxM4ku7Ck4v6uLQHPaCrHotmpyO_iuZo5vBxE1K1VIxxYw_Z-iWxAbEo_6TJij08VJ8Sij_NQlwkph1va02grcUzOegFKHM-K4TitU_RWc4Ns54k72FvMnWd_u0abgqbYFTDAjZNmF_rUhtYqIwLaqyZ_2bl0CCPFrMOGIFlqizeEVek8u2msXy0_K-tqecvVJ1tGgKWDu_iEe4fpvyvjUd8yQ7UnvA9T8mI_oPHgIr4Q&zp=ccfXnvXUtxwpqCpYoiz14WpNMHt2aoqjl0Ty5NyiOAJNc39g2cfJvTQF3919sOShIs2uDQSxMWCZTOtgnviL65R70ABdPG2fCooomQ1zDndoOmcdzxcO6vMytZsYro9Yp-CbkXISU4i5WOixsvkuAz80-yFIuogk1-C5km4sT4Iqp05R805KL_UIEYk2NJWv49pVgaTphS8fbFH9aM8udyQNhEM6ZDujcxSoTpN5kgnlxESMUkis3HuUmegKcelmfvlYzuRcjceEIynqKBwGjaj3j6lUlIqlXkcFZeudjK_LY-kfPdXExSfC2E-tZ7U8dE7GIlq_wxGKLCHu9zaPJwOQn_WIcBoteQPdXUmiTE95P4F93MYhEcRsdbyaIlLn8H8PQIbAqnCdZ4Brgkzxk0Gbw3WDCnr6k5xPaHm8HbqsPqOIHppGKo0XSTXUgdRmK7SR6hgHppct_CRWcd9Qw3M9hWSo4oedVIMhpHzSY_7c04ex1uklkm5zh2-6LwQdzvAQAa1BfsfraHUURhgG0DSoD4Wo6rFHIS3yBzX7-FbZFopvSPJa1Zm2UUc_DCz9M5vhPKA5JbtT4jirBXqv32c)
[chatgpt.com](https://alb.reddit.com/cr?za=PXIKpJkCUF5ivm-T0UHTTaiY8eAUc2eb_GIXo7BQZTRq_4cJ3XDH_sZaVURgs7y-SuHUOEiNx2gUld0iDih5RJyTStyzkJHAjXJCskjbwQTCvNuytCzLshyM3DBOa9gvd2fuWkfTqIhbgk7hRivyDHMXX1lCzd9hvoFgq7ximrbsbLPjgbVzgP7KPzk4q6vUvKZUHfI7n_pbwBr-nmYqzc-xaFshRng1u4jH-qPvGHtqGqkB3SdOK0zrFUXbDb27Cp1e5lqniKB6Wq9SUwp3YBwTCT3XqzVREgJexfckAMHuGo5k9o-aodbNoRJm-XZ7nM00g-Qw_n8oZsM5XZM2L4XtsB3UPCbEgFmUJzhq0w773CXEoNbp3YiCgZUrTVgGnfaONbZQWsirg622ufIKYWq0NKPqTVUwhCkj_Xcyi9ENeYC7uPSfXJ2-ZWeKnyEbo2szVWJNplflSEFLM7pAPG_5BgIwLG600JV2PLZ1ED6hU_NV-kB9jjxM4ku7Ck4v6uLQHPaCrHotmpyO_iuZo5vBxE1K1VIxxYw_Z-iWxAbEo_6TJij08VJ8Sij_NQlwkph1va02grcUzOegFKHM-K4TitU_RWc4Ns54k72FvMnWd_u0abgqbYFTDAjZNmF_rUhtYqIwLaqyZ_2bl0CCPFrMOGIFlqizeEVek8u2msXy0_K-tqecvVJ1tGgKWDu_iEe4fpvyvjUd8yQ7UnvA9T8mI_oPHgIr4Q&zp=ccfXnvXUtxwpqCpYoiz14WpNMHt2aoqjl0Ty5NyiOAJNc39g2cfJvTQF3919sOShIs2uDQSxMWCZTOtgnviL65R70ABdPG2fCooomQ1zDndoOmcdzxcO6vMytZsYro9Yp-CbkXISU4i5WOixsvkuAz80-yFIuogk1-C5km4sT4Iqp05R805KL_UIEYk2NJWv49pVgaTphS8fbFH9aM8udyQNhEM6ZDujcxSoTpN5kgnlxESMUkis3HuUmegKcelmfvlYzuRcjceEIynqKBwGjaj3j6lUlIqlXkcFZeudjK_LY-kfPdXExSfC2E-tZ7U8dE7GIlq_wxGKLCHu9zaPJwOQn_WIcBoteQPdXUmiTE95P4F93MYhEcRsdbyaIlLn8H8PQIbAqnCdZ4Brgkzxk0Gbw3WDCnr6k5xPaHm8HbqsPqOIHppGKo0XSTXUgdRmK7SR6hgHppct_CRWcd9Qw3M9hWSo4oedVIMhpHzSY_7c04ex1uklkm5zh2-6LwQdzvAQAa1BfsfraHUURhgG0DSoD4Wo6rFHIS3yBzX7-FbZFopvSPJa1Zm2UUc_DCz9M5vhPKA5JbtT4jirBXqv32c)
Collapse video player
0:00 / 0:00
[Virtual-Economy-2932](https://www.reddit.com/user/Virtual-Economy-2932/)
•[1h ago](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/comment/ozxskk3/)•Edited 1h ago
LLM channels I like (macOS focused):

* xCreate (https://www.youtube.com/@xcreate/videos)
   * entertaining reviews of new models.
   * he also makes a macOD harness app called Inferencer
* noplacelikelocalhost (https://www.youtube.com/@NoPlaceLikeLocalhost)
   * short no-nonsense tutorials, such as voice cloning
   * some model & tool evals, such as opencode

ReplyShare
[Monochrome21](https://www.reddit.com/user/Monochrome21/)
•[56m ago](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/comment/ozxzf5p/)
tef and lancypoo are great
they actually test the models capability by doing real world code tests building familiar things like video games instead of just hyping them up.
they seem pretty neutral and just interested in the tech
ReplyShare
[Jolly-Rip5973](https://www.reddit.com/user/Jolly-Rip5973/)
•[10h ago](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/comment/ozuo8qs/)
The based Ai channels are going to seem fairly negative about ai.
Here are actual good channels.
[https://www.youtube.com/@RodMillerAI](https://www.youtube.com/@RodMillerAI￼https://www.youtube.com/@elithecomputerguy￼https://www.youtube.com/@mreflow￼https://www.youtube.com/@STARTUPHAKK_sh￼https://www.youtube.com/@theAIsearch￼https://www.youtube.com/@AZisk￼https://www.youtube.com/@matthew_berman￼https://www.youtube.com/@houseofel-ai￼https://www.youtube.com/@atmoio)
[https://www.youtube.com/@elithecomputerguy](https://www.youtube.com/@RodMillerAI￼https://www.youtube.com/@elithecomputerguy￼https://www.youtube.com/@mreflow￼https://www.youtube.com/@STARTUPHAKK_sh￼https://www.youtube.com/@theAIsearch￼https://www.youtube.com/@AZisk￼https://www.youtube.com/@matthew_berman￼https://www.youtube.com/@houseofel-ai￼https://www.youtube.com/@atmoio)
[https://www.youtube.com/@mreflow](https://www.youtube.com/@RodMillerAI￼https://www.youtube.com/@elithecomputerguy￼https://www.youtube.com/@mreflow￼https://www.youtube.com/@STARTUPHAKK_sh￼https://www.youtube.com/@theAIsearch￼https://www.youtube.com/@AZisk￼https://www.youtube.com/@matthew_berman￼https://www.youtube.com/@houseofel-ai￼https://www.youtube.com/@atmoio)
[https://www.youtube.com/@STARTUPHAKK_sh](https://www.youtube.com/@RodMillerAI￼https://www.youtube.com/@elithecomputerguy￼https://www.youtube.com/@mreflow￼https://www.youtube.com/@STARTUPHAKK_sh￼https://www.youtube.com/@theAIsearch￼https://www.youtube.com/@AZisk￼https://www.youtube.com/@matthew_berman￼https://www.youtube.com/@houseofel-ai￼https://www.youtube.com/@atmoio)
[https://www.youtube.com/@theAIsearch](https://www.youtube.com/@RodMillerAI￼https://www.youtube.com/@elithecomputerguy￼https://www.youtube.com/@mreflow￼https://www.youtube.com/@STARTUPHAKK_sh￼https://www.youtube.com/@theAIsearch￼https://www.youtube.com/@AZisk￼https://www.youtube.com/@matthew_berman￼https://www.youtube.com/@houseofel-ai￼https://www.youtube.com/@atmoio)
[https://www.youtube.com/@AZisk](https://www.youtube.com/@RodMillerAI￼https://www.youtube.com/@elithecomputerguy￼https://www.youtube.com/@mreflow￼https://www.youtube.com/@STARTUPHAKK_sh￼https://www.youtube.com/@theAIsearch￼https://www.youtube.com/@AZisk￼https://www.youtube.com/@matthew_berman￼https://www.youtube.com/@houseofel-ai￼https://www.youtube.com/@atmoio)
[https://www.youtube.com/@matthew_berman](https://www.youtube.com/@RodMillerAI￼https://www.youtube.com/@elithecomputerguy￼https://www.youtube.com/@mreflow￼https://www.youtube.com/@STARTUPHAKK_sh￼https://www.youtube.com/@theAIsearch￼https://www.youtube.com/@AZisk￼https://www.youtube.com/@matthew_berman￼https://www.youtube.com/@houseofel-ai￼https://www.youtube.com/@atmoio)
[https://www.youtube.com/@houseofel-ai](https://www.youtube.com/@RodMillerAI￼https://www.youtube.com/@elithecomputerguy￼https://www.youtube.com/@mreflow￼https://www.youtube.com/@STARTUPHAKK_sh￼https://www.youtube.com/@theAIsearch￼https://www.youtube.com/@AZisk￼https://www.youtube.com/@matthew_berman￼https://www.youtube.com/@houseofel-ai￼https://www.youtube.com/@atmoio)
[https://www.youtube.com/@atmoio](https://www.youtube.com/@RodMillerAI￼https://www.youtube.com/@elithecomputerguy￼https://www.youtube.com/@mreflow￼https://www.youtube.com/@STARTUPHAKK_sh￼https://www.youtube.com/@theAIsearch￼https://www.youtube.com/@AZisk￼https://www.youtube.com/@matthew_berman￼https://www.youtube.com/@houseofel-ai￼https://www.youtube.com/@atmoio)
ReplyShare
Community Info Section
[r/LLMDevs](https://www.reddit.com/r/LLMDevs/)
Joined
LLMDevs
A space for Enthusiasts, Developers and Researchers to discuss LLMs and their applications.
Created Feb 17, 2023
Public
72KWeekly visitors
1.5KWeekly contributions
User flair
disorderaudio
Community Bookmarks
[Wiki](https://www.reddit.com/r/LLMDevs/wiki/index/)
r/LLMDevs Rules

* 1
Be respectful: No personal attacks or harassment.
* 2
Ask ethically: Disclose purpose of questions and surveys.
* 3
Stay accurate: Avoid false or misleading information.
* 4
Stay on topic: Related to LLM and NLP.
* 5
No commercial self-promotion: Share openly, not for profit.
* 6
No low-effort posts or spam: High-quality content only.
* 7
Provide sources and references: Cite sources for accuracy.
* 8
No NSFW content: Keep it professional.
* 9
Follow Reddit's rules: Follow Reddit's content policy and rules.
* 10
Be genuine: No disguised advertising or marketing

Moderators
[Message Mods](https://www.reddit.com/message/compose?to=r/LLMDevs)

* [u/m2845](https://www.reddit.com/user/m2845/)
* [u/Scipio_Afri](https://www.reddit.com/user/Scipio_Afri/)
* [u/h8mx](https://www.reddit.com/user/h8mx/)
* [u/robogame_dev](https://www.reddit.com/user/robogame_dev/)
robogame
* [u/purge-user](https://www.reddit.com/user/purge-user/)

[View all moderators](https://www.reddit.com/mod/LLMDevs/moderators/)
Installed Apps

* [Remove Macro](https://developers.reddit.com/apps/purge-user)

* [Reddit Rules](https://www.redditinc.com/policies/content-policy)
* [Privacy Policy](https://www.reddit.com/policies/privacy-policy)
* [User Agreement](https://www.redditinc.com/policies/user-agreement)
* [Your Privacy Choices](https://support.reddithelp.com/hc/articles/43980704794004)
* [Accessibility](https://support.reddithelp.com/hc/sections/38303584022676-Accessibility)
* [Reddit, Inc. © 2026. All rights reserved.](https://redditinc.com/)

Expand Navigation

## Assistant

Video section populated and pushed — **[survey/channels.md](https://github.com/ob6to8/elixir-mind/blob/claude/channels-document-sources-f2qjvu/survey/channels.md)**.

**16 entries from the thread.** I resolved every handle live against YouTube rather than trusting the paste — a fake-handle control returns 404, so the 200s are real channels — and wrote each characterization from the channel's *own* published description instead of inventing one.

Structured by strength of evidence, because the thread's recommendations are not equally weighted:

- **Individually vouched (5):** Codacus, xCreate, No place like localhost, Protorikis, SenTeGuard. Codacus is the standout — it's the only recommendation the asker acted on in-thread.
- **Bulk-listed (9):** Rod Miller, Eli the Computer Guy, Matt Wolfe, AI Search, Alex Ziskind, Matthew Berman, House of El, Mo Bitar, STARTUP HAKK — one comment, no per-channel reasoning.
- **Unresolved (2):** tef and lancypoo.

Three judgment calls worth surfacing:

**I didn't guess at the unresolved two.** `@tef` exists but is an unrelated clips channel; `lancypoo` has two near-matches (`@lancypoo`, untitled, and `@LanceyPooAi`, "AI. Learning. Technology.") with nothing in the thread to choose between them. They're recorded by name under an explicit heading — a wrong handle in a source register is worse than a missing one.

**I flagged the provenance problems.** SenTeGuard was posted by its own author (self-promotion). STARTUP HAKK is a bootcamp's marketing channel. And the bulk list mixes news-and-commentary channels in with technical ones, which sits loosely against the thread's own stated criterion — noted so the list gets sampled before it's trusted.

**I kept the criterion with the list.** The OP's test — independent testing of released models, not restating vendor claims, with "Opus 5 is AGI" as the disqualifier — is the standard these were nominated against, so the list is much less useful detached from it. The commenter heuristic (skip anything posting more than twice a week) and the dissent (top AI channels have no choice) are both recorded.

Reddit itself is registered as a `known` channel in Forums, linked to the seed thread, still not ingested as you asked.

Both gates green, all internal links resolve. Two commits on the branch, no PR opened — say the word if you want one.

## User

Lets remove all low-mid value channels

## Assistant

Cut 11 of 16 — pushed to **[survey/channels.md](https://github.com/ob6to8/elixir-mind/blob/claude/channels-document-sources-f2qjvu/survey/channels.md)**.

**I judged on output, not blurbs.** Before cutting I pulled each channel's recent uploads via its RSS feed. That mattered — self-descriptions turned out to be unreliable in both directions, and my previous entries (written from those blurbs) had two channels ranked wrong.

**Kept (5):**

| Channel | Why |
|---|---|
| **Codacus** | "Can a 3.5GB model replace my 35B daily driver?", fully-private local stacks, agent-patching llama.cpp. Also has a video on **OKF** — the format this brain runs on |
| **Protorikis** | The most rigorous of the set: MLX vs llama.cpp across 4 runtimes, NVFP4 vs Q4 on speed *and* quality, sustained-load thermal tests |
| **No place like localhost** | Performance tuning, multi-GPU, head-to-head model battles, spec-driven vs one-shot prompting |
| **Alex Ziskind** | "AMD says 2 Ryzen AI Halos run a 400B model… I tested it", cheap 192GB-VRAM builds |
| **xCreate** | Real coding-task model evals — kept with a caveat |

**Two corrections to what I told you last message.** Protorikis I'd described as a bare name-drop with generic maker content — its actual output is controlled benchmarking, the strongest methodology in the whole set, so it moves near the top. And Alex Ziskind was buried in the unannotated bulk list; he's the only one in that list doing first-hand measurement.

**Cut (11):** Rod Miller, Eli the Computer Guy, Matt Wolfe, AI Search, Matthew Berman, House of El, Mo Bitar (news/commentary, not testing); STARTUP HAKK and SenTeGuard (promotional); tef and lancypoo (unresolvable).

Two of those are worth naming specifically. **House of El** self-describes as "no hype, no jargon" but publishes "OpenAI's Collapse Has Finally Begun" and "Meta Is Creating AI's Chernobyl Moment." **Eli the Computer Guy** runs "NVIDIA is DEAD" / "OpenAI is DEAD" as a recurring headline formula — the literal disqualifier the thread named. That gap between blurb and output is exactly why I sampled uploads.

**Judgment calls you may want to reverse:**

- **xCreate is the weakest keep.** It does genuine independent evals on real coding tasks, but sells them as "GLM 5.2 Coding LoRA BEATS Kimi K3 & Claude?! 🤯" — the precise genre the thread was filtering against. I kept it for what it measures rather than how it's packaged, and flagged the caveat in the doc. One word and it goes.
- **The dropped 11 are listed with reasons rather than deleted**, so the same Reddit thread can't silently re-seed them later. Say the word if you'd rather the section were clean and the reasoning lived only in git history.
- **I only pruned `known` channels.** The blog/paper/docs entries are all `ingested` — each has produced filed documents in the brain, and removing one would break the source→document join and orphan real provenance. If you did mean a wider cull, tell me and I'll assess those on their filed output instead.

## User

fine with xCreate
yes drop, keep reasoning in git history, and do NOT intake the reddit thread
what are the "blog/paper/docs entries"?

## Assistant

Dropped and pushed. The reasoning lives in commit `85d712e`; the register now lists only the five worth watching, and the preamble still notes five survived of sixteen so the filtering ratio isn't lost.

The Reddit thread is **not** ingested and won't be — no bundle document, no `em:` id, nothing filed into the taxonomy. It appears only as a bare link in two places: the Video preamble (marked "deliberately not ingested") and the `r/LLMDevs` row under Forums, which is `known` with nothing filed from it.

**On your question — "blog/paper/docs entries" was my shorthand for the rest of the register**, i.e. everything outside the Video section. Poor wording on my part; those are just the other six sections. They hold **38 channels** that between them produced the **68 filed documents** in the brain:

| Section | Channels | Docs |
|---|---|---|
| Independent blogs & newsletters | 12 | 16 |
| Vendor engineering blogs & product docs | 14 | 21 |
| Papers & preprints | 3 | 15 |
| Reference works & standards | 5 | 9 |
| Code repositories | 1 | 6 |
| Forums & social | 3 | 1 |

Concretely: Simon Willison, matklad, Martin Alderson, Armin Ronacher, Geoffrey Huntley, Mike Zornek and other independent bloggers; Anthropic's engineering blog and Claude Code docs, OpenAI, LangChain, Chroma, Hugging Face, Manus and other vendor sources; arXiv, the *Artificial Intelligence* journal via DOI; Wikipedia, W3C, Pro Git, HexDocs; GitHub; LinkedIn.

The distinction that matters: those are all `ingested` — each has already produced filed documents, so the entry is a working index into the brain. Deleting one wouldn't just remove a recommendation, it would break the source→document join for real filed knowledge. That's why I left them alone when you said "remove low-mid value channels," and why a cull there would be a different kind of judgment: assessing filed documents rather than unwatched channels.

Branch has four commits, no PR opened.

## User

this has since been created - pull main, merge what was done here

## Assistant

Merged and pushed. This was a genuine collision, not a fast-forward: **PR #146 landed its own `survey/channels.md`** on main while this branch was building one at the same path.

<routes ref="em:9495ee survey/channels.md">
**They answered different questions.** Main's is forward-looking — *what should I monitor, and what does it cost to read?* (9 rows, Focus/Access/From, seeded from codesupreme.ai). Mine was backward-looking — *what has each source already produced?* (43 channels derived from filed documents, plus the vetted video set).

**I made main's shape win**, and not just because it landed first. It's ratified where mine was only proposed: the `channel` glossary concept (`em:9495ee`) defines a channel as a standing source with a focus line and an access note, and — the deciding factor — **`/research` scans this register as its first per-domain search step**, honoring the access note to decide what it may fetch. Restructuring around my medium-grouped `### heading` sections would have broken a live consumer.
</routes>

So main's table, columns, and nine rows are kept verbatim, and my work folds in as content:

- **33 more channels** from the resource URIs of every filed document, each given an access note to fit the ratified shape.
- **The five video channels**, with the selection standard stated above the table.
- **An `Ingested` column** — the one capability neither version had alone. It's the inverse of a document's `resource` field, and it makes the register self-auditing: a source with a long list has earned its place, a long-empty one is a candidate for removal.

51 rows total, grouped by medium under one uniform set of columns so `/research` still scans a single table. arXiv appears once, merging main's focus and access with my ten filed papers.

Two smaller reconciliations: `survey/index.md` conflicted and now carries main's "standing-sources" framing extended with the yield; the root `index.md` auto-merged and I aligned its gloss to match.

All gates green after the merge — `brain.verify`, `route_tags`, contract/registry/code-map freshness checks, compile, format. No broken links.

The Reddit thread is still just a link in the `From` column and the `r/LLMDevs` row — not ingested, as you've said twice.

One thing worth your call: **main's design statement says the register "only records where to look and what it costs to look there."** The `Ingested` column widens that scope. I think it earns its place — it's what you originally asked for, and it turns the register into a feedback loop rather than a static watchlist — but it is a scope change to a ratified document, so if you'd rather keep that boundary clean, say so and I'll pull the column and leave the join derivable from the documented `grep`.

## User

keep ingested, adjust design statement

## Assistant

Done — the `Ingested` column stays, and the design statement now claims it rather than leaving it unaccounted for.

<routes ref="em:9495ee survey/channels.md">
**In the register**, the scope statement is explicit about running in both directions: prospectively the focus line and access note (what `/research` reads before deciding what it may fetch), retrospectively the documents drawn from that source. The reason they belong in one row is stated too — the second is the evidence for the first. A channel earns continued attention by having yielded something, and a row that stays empty is a watchlist entry nobody has had to justify.
</routes>

I also wrote down what the column *isn't*: a join, not a record. Each document already names its source in `resource`; the column inverts that edge and is re-derivable from the documents, so nothing in it is authoritative over them.

**I updated the `channel` glossary concept (`em:9495ee`) to match.** That's the ratified definition of what a register row holds, and it still described the narrower scope — leaving it would have meant the definition and the artifact disagreeing about the same thing, with the definition being the one a fresh agent finds first.

One thing worth flagging: **the pre-commit hook caught a gate I hadn't run.** Editing the term's description staled `beliefs/glossary/index.md`, and `mix brain.glossary` failed on index sync. Regenerated with `--materialize` and it passes. Full suite is green — format, xref, contract/registry/code-map/lineage freshness, `brain.verify`, route tags, glossary, and 183 tests.

Branch is at `b7fa71c`, six commits, merged with current `main`. Still no PR — say the word and I'll open one, or run `/create-pull-request` if you want the session captured and glossaried into it first.
