---
type: reference
title: 2026-07-27-channels-register-and-research-wiring
description: Created the channels register (survey/channels.md) — nine operator-supplied AI sources with fetch-verified access notes and per-row provenance back to codesupreme.ai — and wired it into /research §2 as the first per-domain search step.
provenance: "Claude Code session (Claude Fable 5), 2026-07-27; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, survey, channels, research]
timestamp: 2026-07-27
session: https://claude.ai/code/session_01X7U6kdqGtfcXBCYFs1ErNe
pr: 146
---

# 2026-07-27-channels-register-and-research-wiring

## Where this landed

The operator supplied nine recurring AI sources (newsletters, Medium authors,
arXiv) with instructions to add them to "the channels list" and mark login/paid
status, citing codesupreme.ai as where the list came from. No channels list
existed anywhere in the repo, so the session created one:
[`survey/channels.md`](/survey/channels.md), a standing-sources register beside
the bookmarks register in the non-bundle `survey/` namespace — each row carrying
a focus line and an access note verified by fetching the source, not recalled
from memory. A follow-up question ("are you linking the provenance to the
channel?") landed a per-row **From** column linking each recommendation to its
origin, and the operator's "proceed" on option 1 wired the register into
[`/research`](/.claude/skills/research/SKILL.md) §2 as the first per-domain
search step, with an access-note rule: free channels are fetched directly,
login/paid channels are surfaced only from publicly readable content. Both
commits (`fe10eb6`, `3f7683a`) pushed to the session branch with the full gate
suite green.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Channels register — nine AI standing sources with verified access notes | closed | [channels](/survey/channels.md) | - |
| Per-row provenance (From column linking codesupreme.ai / The Edge) | closed | [channels](/survey/channels.md) | - |
| /research §2 draws on the channels register, respecting access notes | closed | [/research SKILL.md](/.claude/skills/research/SKILL.md) | - |

## User

add these sources to the channels list (if they require login, mark if it is paid or not):

https://www.lennysnewsletter.com/t/ai
https://www.theinformation.com/newsletters/the-briefing
https://medium.com/@coyle_41098
https://medium.com/@dickson.lukose
https://www.deeplearning.ai/the-batch
https://www.oneusefulthing.org/
https://jack-clark.net/
https://towardsdatascience.medium.com/
https://arxiv.org/

provenance was from here: https://www.codesupreme.ai/ and https://www.codesupreme.ai/the-edge/read

## Assistant

<routes ref="survey/channels.md">
Done — all nine sources are filed in a new **channels register**, committed and pushed to `claude/add-ai-sources-channels-5ugs24`.

One judgment call to flag: no channels list existed anywhere in the repo, so I created one at [`survey/channels.md`](https://github.com/ob6to8/elixir-mind/blob/claude/add-ai-sources-channels-5ugs24/survey/channels.md) — a standing-sources register beside the bookmarks register in the non-bundle `survey/` namespace (recurring *sources* vs. one-off *links*; no new top-level directory, so no ratification needed). The codesupreme.ai origin you gave is recorded in the doc's `provenance` frontmatter.

I fetched every source to verify its access model rather than guessing:

| Channel | Access |
|---|---|
| Lenny's Newsletter — AI | Freemium — full posts need login + **paid** Substack sub |
| The Information — The Briefing | **Paid** — login + subscription required |
| Frank Coyle, PhD (Medium) | Member-only stories need login + **paid** Medium membership |
| Dickson Lukose (Medium) | Member-only stories need login + **paid** Medium membership |
| The Batch (DeepLearning.AI) | Free, no login |
| One Useful Thing (Ethan Mollick) | Free to read; optional paid supporter tier |
| Import AI (Jack Clark) | Free, no login |
| Towards Data Science (Medium archive) | Some archive stories **paid** (Medium); new TDS content is free at towardsdatascience.com |
| arXiv | Free, open access |

**What I created**

| type | doc | why this type |
|---|---|---|
| `reference` (non-bundle register) | `survey/channels.md` | Mirrors the bookmarks register's shape — a register row set, not a taxonomy document; no `em:` id |

**What I modified**

| file | thrust |
|---|---|
| [`survey/index.md`](https://github.com/ob6to8/elixir-mind/blob/claude/add-ai-sources-channels-5ugs24/survey/index.md) | Listed the new register and noted the namespace now holds two registers |

**Actions I have taken**

| action | result |
|---|---|
| Fetched all 9 sources to determine login/paid status | Access column verified, not from memory |
| Ran gate suite (`brain.verify`, route tags, registry, full pre-commit incl. 183 tests) | All green; two pre-existing editorial warnings only |
| Committed and pushed to `claude/add-ai-sources-channels-5ugs24` | `fe10eb6` on origin |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Wire the register into `/research` | Add a "scan the channels register" step to the skill's §2 search procedure, so the daily feed draws on these sources deliberately |
| 2 | Relocate the register | If you'd rather channels live elsewhere (e.g. under `inbox/`), say where and I'll move it |
| 3 | `/create-pull-request` | Capture the session and open the PR when you're ready to land it |
</routes>

## User

are you linking the provenance to the channel?

1. proceed

## Assistant

<routes ref="survey/channels.md .claude/skills/research/SKILL.md">
Both done, committed and pushed (`3f7683a`), full gate suite green.

To answer the question directly: the provenance was only in the document's frontmatter before — now it's also linked on every channel row. Each row in [`survey/channels.md`](https://github.com/ob6to8/elixir-mind/blob/claude/add-ai-sources-channels-5ugs24/survey/channels.md) carries a **From** column linking [codesupreme.ai](https://www.codesupreme.ai/) and [The Edge](https://www.codesupreme.ai/the-edge/read) with the date added, so channels recommended by other origins later stay distinguishable per-row.

**What I modified**

| file | thrust |
|---|---|
| `survey/channels.md` | Added the **From** column (per-row recommendation origin, dated) and a legend line explaining it |
| `.claude/skills/research/SKILL.md` | §2 now opens with "start from the channels register": scan standing sources per domain, fetching free channels directly and surfacing login/paid channels only from publicly readable content — never synthesizing a synopsis for content that couldn't be read |

**Actions I have taken**

| action | result |
|---|---|
| Ran gates, committed, pushed | `3f7683a` on `claude/add-ai-sources-channels-5ugs24`; 183 tests pass, contract check confirms no recompile needed (the skill's registry description is unchanged) |

The next `/research` run will pick up the register automatically. When you're ready to land the branch, `/create-pull-request` will capture the session and open the PR.
</routes>
