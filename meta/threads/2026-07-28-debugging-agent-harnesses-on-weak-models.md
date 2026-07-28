---
type: reference
title: 2026-07-28-debugging-agent-harnesses-on-weak-models
description: Intake of Archestra's weak-models-debugging blog post, its r/LLMDevs discussion thread, and the archestra-ai/archestra repo, filed as a methodology and a platform reference.
provenance: "Claude Code session (Claude Sonnet 5), 2026-07-28; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, evals, harness, agents, mcp, intake]
timestamp: 2026-07-28
pr: 166
session: https://claude.ai/code/session_01YAsMvueVmic6XgagaYZsRQ
---

# 2026-07-28-debugging-agent-harnesses-on-weak-models

## Where this landed

The operator pasted three links — the `archestra-ai/archestra` GitHub repo, Archestra's blog post on debugging their AI harness on weak models on purpose, and (since Reddit is unfetchable from this sandbox) the full text of the r/LLMDevs discussion thread the post spawned. Two documents were filed: [debugging-agent-harnesses-on-weak-models](/knowledge/SWE/evals/debugging-agent-harnesses-on-weak-models.md) (`em:7309de`, `type: methodology`) — the practice itself, plus the thread's contract-bug/model-ceiling/provider-quirk triage rule and the multi-weak-model defence against provider-specific overfitting — and [archestra-open-source-enterprise-ai-platform](/knowledge/SWE/agentic/frameworks/archestra-open-source-enterprise-ai-platform.md) (`em:1b6814`, `type: reference`), the product whose harness the practice was developed against. Both filed autonomously into existing directories. The dedup gold set grew by one row from the operator's pasted post title, and the recall baseline was refreshed with no regression.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Debugging an agent harness on weak models — the practice, its bug taxonomy, and the triage rule | closed | [debugging-agent-harnesses-on-weak-models](/knowledge/SWE/evals/debugging-agent-harnesses-on-weak-models.md) | - |
| Archestra — the platform the practice was developed against | closed | [archestra-open-source-enterprise-ai-platform](/knowledge/SWE/agentic/frameworks/archestra-open-source-enterprise-ai-platform.md) | - |

## User

/intake https://github.com/archestra-ai/archestra 
https://archestra.ai/blog/we-debug-our-ai-harness-on-weak-models-on-purpose
https://www.reddit.com/r/LLMDevs/comments/1v7zcob/debugging_on_weaker_models_is_more_informative/
(last one's text copied below given you can't fetch reddit)

Debugging on weaker models is more informative; top models cover your harness bugs
[Resource](https://www.reddit.com/r/LLMDevs/?f=flair_name%3A%22Resource%22)
[archestra.aiOpen](https://archestra.ai/blog/we-debug-our-ai-harness-on-weak-models-on-purpose)
Frontier models bulldoze past broken plumbing (malformed tool calls, weird error strings, a missing tools) and still finish the task despite poor harness ergonomics.
Running the same suite on the cheapest models on our roster surfaced a dozen bugs that Opus learned to work around.
Upvote37Downvote14Go to comments[Repost](https://www.reddit.com/submit?source_id=t3_1v7zcob&composer_entry=crosspost_post_action_bar)Share
[azure](https://www.reddit.com/user/azure/)•[Promoted](https://www.reddit.com/user/azure/)
[Stop playing detective with your own stack. 🕵️ Azure brings everything into one view—so you know where your tools are. ](https://alb.reddit.com/cr?za=GQNDtQHDIkxXh8MfbJBUs4Q9xagKTxMcrsBjyKKdPKXaJ4v1yKtZzI8YhKqk7vyMunicI8V4LsjL-GNAKBV0eu498Ae4rgjzpiI5JT0ct7cgKO5SJ1gmX5rCog-aYNOCXX-WIaocSbSwX8iN2q6TRoPlq5y4cQphYeSDdZO8qTuOUDPYIVNmksP9ojvJIac-eS1m2UEyz2xcXeRwDOMWX9hz5DxG-KZjKNDmayoWoBuxJ0Ohom5sFiccrTSGsMikaJRziKPMO1LCbolOSX_OsPduBrc7I0h7ZiCeS3JbsI142LvqnCYOi_JtCwwP6b6TH9o-bEsZXb91aoK_nZl8sK4FNAzE3r0F6zHC6cbVwM-GtzA8S8G7n5NBcCHWmcyc1dqjAyCbN7kzmV-Dnvwf4tE0wT5rfP_dzqQoqHAjw3hRh5uEIT_M3XcQYv5PALNAPtTju8Hv9akq3KadtIg_L-eHesXa9k7IdNRuiKpJm-V-7M6tCfSaucZ68aXd2bVYK03XMysv7zgEterVB6G0aoR6epU1xkz9eDDGVr-RrlNa1g41lw2DKcaWcyagu_01nknuTm1jM9mte8V_e5EFGUVnLJ6FN_fpP2xfcvwjK10bvHWbWRW4lIS73C2RLtUx_7WtUifSauwr-3YaUCqBELZXS4xcx1tpmc1Xl3VfRMQP7GDunIOYkgHPdv5tCKYEBvKePEimkGka48aFCpjO4TvLmBKKkYwLDQ&zp=AF5fEZOn8hgVnJXgKT1mLgbCRgH4wxrxpxZTQpOBabM6NliFmh65ElQ4V0INz3lH56hVJ_cqdoabbSBVCmcmsh3WJohvq6Tc_PQIYqdNTIEHr1xjmdJNi00xBrycfZGC3b8jViD3G8W629JbHlQddgsXun5tLTaTykcD9k_nR_CusDMvQZtBKy9IcdAqW8S1PSPtvi_AsIlWTpnigKBIZJepmPaEFAijxKllBUyxvYza-l8UQvN1nJcD7fqgJvsggZd-AC1bKjNJAPARnIoxEV3f9Kuz7qFV2iQbTwDwG7ANHIM4fK83VgaxDBRBrCSivGPJdgdhP_1_MIcJvqPAcSBuEe_kY6tmKsqhwXLrCRyjkLihDfxf5J1qzWbSacs6J-CvXjJ2sLRIrtpuO4mQprweG3u2l1vL243LwZtTxp9VXxrmovEOt6Heb5NLVkb2KqtStzjZ5SI2Gg9H2G5Q-DtK1c-mTPuo3nLtOh63B4JrNbULWmHUL9Y)

* 
* 
* 

[azure.microsoft.com](https://alb.reddit.com/cr?za=GQNDtQHDIkxXh8MfbJBUs4Q9xagKTxMcrsBjyKKdPKXaJ4v1yKtZzI8YhKqk7vyMunicI8V4LsjL-GNAKBV0eu498Ae4rgjzpiI5JT0ct7cgKO5SJ1gmX5rCog-aYNOCXX-WIaocSbSwX8iN2q6TRoPlq5y4cQphYeSDdZO8qTuOUDPYIVNmksP9ojvJIac-eS1m2UEyz2xcXeRwDOMWX9hz5DxG-KZjKNDmayoWoBuxJ0Ohom5sFiccrTSGsMikaJRziKPMO1LCbolOSX_OsPduBrc7I0h7ZiCeS3JbsI142LvqnCYOi_JtCwwP6b6TH9o-bEsZXb91aoK_nZl8sK4FNAzE3r0F6zHC6cbVwM-GtzA8S8G7n5NBcCHWmcyc1dqjAyCbN7kzmV-Dnvwf4tE0wT5rfP_dzqQoqHAjw3hRh5uEIT_M3XcQYv5PALNAPtTju8Hv9akq3KadtIg_L-eHesXa9k7IdNRuiKpJm-V-7M6tCfSaucZ68aXd2bVYK03XMysv7zgEterVB6G0aoR6epU1xkz9eDDGVr-RrlNa1g41lw2DKcaWcyagu_01nknuTm1jM9mte8V_e5EFGUVnLJ6FN_fpP2xfcvwjK10bvHWbWRW4lIS73C2RLtUx_7WtUifSauwr-3YaUCqBELZXS4xcx1tpmc1Xl3VfRMQP7GDunIOYkgHPdv5tCKYEBvKePEimkGka48aFCpjO4TvLmBKKkYwLDQ&zp=AF5fEZOn8hgVnJXgKT1mLgbCRgH4wxrxpxZTQpOBabM6NliFmh65ElQ4V0INz3lH56hVJ_cqdoabbSBVCmcmsh3WJohvq6Tc_PQIYqdNTIEHr1xjmdJNi00xBrycfZGC3b8jViD3G8W629JbHlQddgsXun5tLTaTykcD9k_nR_CusDMvQZtBKy9IcdAqW8S1PSPtvi_AsIlWTpnigKBIZJepmPaEFAijxKllBUyxvYza-l8UQvN1nJcD7fqgJvsggZd-AC1bKjNJAPARnIoxEV3f9Kuz7qFV2iQbTwDwG7ANHIM4fK83VgaxDBRBrCSivGPJdgdhP_1_MIcJvqPAcSBuEe_kY6tmKsqhwXLrCRyjkLihDfxf5J1qzWbSacs6J-CvXjJ2sLRIrtpuO4mQprweG3u2l1vL243LwZtTxp9VXxrmovEOt6Heb5NLVkb2KqtStzjZ5SI2Gg9H2G5Q-DtK1c-mTPuo3nLtOh63B4JrNbULWmHUL9Y)
[Sign Up](https://alb.reddit.com/cr?za=GQNDtQHDIkxXh8MfbJBUs4Q9xagKTxMcrsBjyKKdPKXaJ4v1yKtZzI8YhKqk7vyMunicI8V4LsjL-GNAKBV0eu498Ae4rgjzpiI5JT0ct7cgKO5SJ1gmX5rCog-aYNOCXX-WIaocSbSwX8iN2q6TRoPlq5y4cQphYeSDdZO8qTuOUDPYIVNmksP9ojvJIac-eS1m2UEyz2xcXeRwDOMWX9hz5DxG-KZjKNDmayoWoBuxJ0Ohom5sFiccrTSGsMikaJRziKPMO1LCbolOSX_OsPduBrc7I0h7ZiCeS3JbsI142LvqnCYOi_JtCwwP6b6TH9o-bEsZXb91aoK_nZl8sK4FNAzE3r0F6zHC6cbVwM-GtzA8S8G7n5NBcCHWmcyc1dqjAyCbN7kzmV-Dnvwf4tE0wT5rfP_dzqQoqHAjw3hRh5uEIT_M3XcQYv5PALNAPtTju8Hv9akq3KadtIg_L-eHesXa9k7IdNRuiKpJm-V-7M6tCfSaucZ68aXd2bVYK03XMysv7zgEterVB6G0aoR6epU1xkz9eDDGVr-RrlNa1g41lw2DKcaWcyagu_01nknuTm1jM9mte8V_e5EFGUVnLJ6FN_fpP2xfcvwjK10bvHWbWRW4lIS73C2RLtUx_7WtUifSauwr-3YaUCqBELZXS4xcx1tpmc1Xl3VfRMQP7GDunIOYkgHPdv5tCKYEBvKePEimkGka48aFCpjO4TvLmBKKkYwLDQ&zp=AF5fEZOn8hgVnJXgKT1mLgbCRgH4wxrxpxZTQpOBabM6NliFmh65ElQ4V0INz3lH56hVJ_cqdoabbSBVCmcmsh3WJohvq6Tc_PQIYqdNTIEHr1xjmdJNi00xBrycfZGC3b8jViD3G8W629JbHlQddgsXun5tLTaTykcD9k_nR_CusDMvQZtBKy9IcdAqW8S1PSPtvi_AsIlWTpnigKBIZJepmPaEFAijxKllBUyxvYza-l8UQvN1nJcD7fqgJvsggZd-AC1bKjNJAPARnIoxEV3f9Kuz7qFV2iQbTwDwG7ANHIM4fK83VgaxDBRBrCSivGPJdgdhP_1_MIcJvqPAcSBuEe_kY6tmKsqhwXLrCRyjkLihDfxf5J1qzWbSacs6J-CvXjJ2sLRIrtpuO4mQprweG3u2l1vL243LwZtTxp9VXxrmovEOt6Heb5NLVkb2KqtStzjZ5SI2Gg9H2G5Q-DtK1c-mTPuo3nLtOh63B4JrNbULWmHUL9Y)
Sort by:Best
Search CommentsExpand comment search
Comments Section
[donk8r](https://www.reddit.com/user/donk8r/)
•[19h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p01x81c/)
Matches what we see building a harness. A strong model silently repairs your contract violations, so the actual quality of your tool interface stays invisible until something weaker runs it. Same reason you test against a strict parser instead of a forgiving one.
The classes that only weak models surfaced for us: tool descriptions that are ambiguous but get rescued by the tool name, params documented as optional that are really required, error strings that say what went wrong without saying what to do next, and pairs of tools similar enough that choosing between them takes judgement.
The trap is over fitting to it. Some weak model failures are genuine model ceilings rather than harness bugs, and if you fix every one you end up writing baby proof prompts that cost everybody tokens. The rule we settled on is whether the fix makes a contract explicit or explains a concept. Explicit contract means it was our bug. Explaining the concept means it was the model's limit and the fix belongs in model selection instead.
ReplyShare
[arsenyinfo](https://www.reddit.com/user/arsenyinfo/)
•[18h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p029jzw/)
100% agree on overfitting, that's why 1) having few weaker models in the loop helps, 2) it can't be fully automatic self-improvement loop without a human filter. After few iterations of polishing, my reflection agent started offering weird "fixes" for exact failures of exact openrouter providers, non-generalizable at all
ReplyShare
[donk8r](https://www.reddit.com/user/donk8r/)
•[18h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p029v5l/)
The provider specific thing is a good catch and it's a third category I hadn't accounted for. Explicit contract, model ceiling, and provider quirk, where the same model behind two endpoints behaves differently and the fix generalizes to neither. Those are the worst ones to let a reflection loop near, because the fix looks local and reasonable right up until you move providers.
Running several weak models in the loop is probably the cheapest defence against exactly that, since a provider quirk shows up on one and a real contract bug shows up on all of them. That's differential testing with extra steps, which is a good sign rather than a bad one.
ReplyShare
[rusl1](https://www.reddit.com/user/rusl1/)
•[15h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p03afnu/)
100% agrees with this. Indeed I found Qwen 35b to be quite good at debugging and reviewing code because makes no assumptions and fail fast
ReplyShare
[TheLexoPlexx](https://www.reddit.com/user/TheLexoPlexx/)
•[19h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p01zbei/)
This led me down a rabbithole into almost applying at that place, damn.
ReplyShare
[Training_Isopod3722](https://www.reddit.com/user/Training_Isopod3722/)
•[15h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p03fnk5/)
yeah this is a real test. if gemma or a small qwen can't recover from one malformed tool result, the harness is probably relying on the model being unusually forgiving. i'd keep a cheap-model run in CI just for tool-call and error-path coverage.
ReplyShare
[Smallpaul](https://www.reddit.com/user/Smallpaul/)
•[18h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p02bamq/)
A lot of your issues that you found using small models could have been caught with observability. Your tool call failures could be logged and you could count them. But I will try your technique.
ReplyShare
[arsenyinfo](https://www.reddit.com/user/arsenyinfo/)
•[17h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p02o26v/)
Can't agree o11y is a silver bullet here. E.g. tool call failure is not just true or false: we have a sandbox concept in the platform, and agents an run bash commands there. Smart agent runs a command, gets exit code 1, finds a better solution. Stupid model tries to run it over and over again. And in both cases those are not even a tool call failures: tool succeeded, just wrapped legit inner error.
Another problem is that we don't provide a managed service at this point. We're a team behind open core platform, so we have our own deployment (constantly used by our small team) and few large enterprise deployments with their own quirks that are hard to guess and reproduce. So we need to be proactive here, and detect the fragile parts before they're deployed live.
ReplyShare
[Smallpaul](https://www.reddit.com/user/Smallpaul/)
•[16h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p03098g/)
I didn't say it's a silver bullet and I said I'd try your technique to find some problems. But many of the problems you listed should have been found with o11y.
ReplyShare
[arsenyinfo](https://www.reddit.com/user/arsenyinfo/)
•[15h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p03kywl/)
yeah, sorry, not the best choice of words by me
ReplyShare
[u/cohesiveOS](https://www.reddit.com/user/cohesiveOS/)•[Promoted](https://www.reddit.com/user/cohesiveOS/)
[The Multiplayer AI workspace for teams that outgrew chat.](https://alb.reddit.com/cr?za=plu8BLCG7HqyFwgv91_Fu4dk-cbk0BiWyCf3WyOjv4DIgWYZXg8ED3RLk8vrTdHem-V8k5gBN-IjquULwJ-5pZvhPqCKCV0L3HB_s2oesMzJl1ABXH3VmkfGg2KJwSx-G38plJgIKhCy8nlSAvkrD0lqBVQMMWQgD_hDVmsdPG5RID_N99DvqRgVfCU-DaMWt8WqPFLYhiML5FfcJh6yO6A8Q2Rpe2cEfgdX-vGGBLy4thWOXB5c66n0WL8U6vKUWaysHPvAtht_vUJmoJZ3_ZFJNjQJ68rUzf_6R4YI8hIFhKhBbsVGoOzdX3uc4WOxsOF5KKACeOQRY-Gc-WDVGf0i6yZ24ANBP9HIdtO0j1qBGcecFV8RPMOuNhzX1erM63cfJpjMGrr0wpUCGaMcPONaqxS8bhPf_kO8oAo7nYT2UAhF5Y-yA4gSN_EWaGxd-FY0l-O8A0pMKubeaflErTbXJ7jZKgfO-GLZVdD0GWD91QTRAxURu5pSU1yU-cOiqwke312wspnw1fWaksh_lWUGZviMKOmhYllhJ5dCJUjSt_6sDlBUAj4XwrEZfvjErngAHPFkADxvjytSj9jS872Ud_B8g92yBwEqi1sQD7pjaPPHpBEFY4qb9bxBzYnDDzJyXF9OqfhS0pdruvbaOH8eMBvBq526wphUk1Ke1Zg58jaGAfCn9j5oDnwpOMyABNJw7rRG0a7KKdsC6_cnDfF0RTKtt8fY7Q&zp=spdpsMVJaSyYDElHQwqWE5jIzk9snhClCyfNDIlUBTMD7nVYZZNH57csYy_7wyyflU-YJAP6UH-Ih2AYMR7S61yr29ysBGN-1NVufX5F3jip3BKRfSux0VsOk3RPzcN9EZ1jfQswmvAsVMuSGGn_MSWNC_xacHWjssyp2z0rePTQmwry17bHvGzRkSO5sl9QbtFQCNEyNNC9Cbv3hISWmCMT6_-DDvR9ZwARZbJRoakTxCsABKuEUiSpLIR19pmNK2YNprMffDxfiAeXm2GyjDT1q3tX6HxB7uiNd4ZCkuqJfrfjGJMXuxyUxUdTL7pw0zi3)

* 
* 
* 

[cohesive.ai](https://alb.reddit.com/cr?za=plu8BLCG7HqyFwgv91_Fu4dk-cbk0BiWyCf3WyOjv4DIgWYZXg8ED3RLk8vrTdHem-V8k5gBN-IjquULwJ-5pZvhPqCKCV0L3HB_s2oesMzJl1ABXH3VmkfGg2KJwSx-G38plJgIKhCy8nlSAvkrD0lqBVQMMWQgD_hDVmsdPG5RID_N99DvqRgVfCU-DaMWt8WqPFLYhiML5FfcJh6yO6A8Q2Rpe2cEfgdX-vGGBLy4thWOXB5c66n0WL8U6vKUWaysHPvAtht_vUJmoJZ3_ZFJNjQJ68rUzf_6R4YI8hIFhKhBbsVGoOzdX3uc4WOxsOF5KKACeOQRY-Gc-WDVGf0i6yZ24ANBP9HIdtO0j1qBGcecFV8RPMOuNhzX1erM63cfJpjMGrr0wpUCGaMcPONaqxS8bhPf_kO8oAo7nYT2UAhF5Y-yA4gSN_EWaGxd-FY0l-O8A0pMKubeaflErTbXJ7jZKgfO-GLZVdD0GWD91QTRAxURu5pSU1yU-cOiqwke312wspnw1fWaksh_lWUGZviMKOmhYllhJ5dCJUjSt_6sDlBUAj4XwrEZfvjErngAHPFkADxvjytSj9jS872Ud_B8g92yBwEqi1sQD7pjaPPHpBEFY4qb9bxBzYnDDzJyXF9OqfhS0pdruvbaOH8eMBvBq526wphUk1Ke1Zg58jaGAfCn9j5oDnwpOMyABNJw7rRG0a7KKdsC6_cnDfF0RTKtt8fY7Q&zp=spdpsMVJaSyYDElHQwqWE5jIzk9snhClCyfNDIlUBTMD7nVYZZNH57csYy_7wyyflU-YJAP6UH-Ih2AYMR7S61yr29ysBGN-1NVufX5F3jip3BKRfSux0VsOk3RPzcN9EZ1jfQswmvAsVMuSGGn_MSWNC_xacHWjssyp2z0rePTQmwry17bHvGzRkSO5sl9QbtFQCNEyNNC9Cbv3hISWmCMT6_-DDvR9ZwARZbJRoakTxCsABKuEUiSpLIR19pmNK2YNprMffDxfiAeXm2GyjDT1q3tX6HxB7uiNd4ZCkuqJfrfjGJMXuxyUxUdTL7pw0zi3)
[Learn More](https://alb.reddit.com/cr?za=plu8BLCG7HqyFwgv91_Fu4dk-cbk0BiWyCf3WyOjv4DIgWYZXg8ED3RLk8vrTdHem-V8k5gBN-IjquULwJ-5pZvhPqCKCV0L3HB_s2oesMzJl1ABXH3VmkfGg2KJwSx-G38plJgIKhCy8nlSAvkrD0lqBVQMMWQgD_hDVmsdPG5RID_N99DvqRgVfCU-DaMWt8WqPFLYhiML5FfcJh6yO6A8Q2Rpe2cEfgdX-vGGBLy4thWOXB5c66n0WL8U6vKUWaysHPvAtht_vUJmoJZ3_ZFJNjQJ68rUzf_6R4YI8hIFhKhBbsVGoOzdX3uc4WOxsOF5KKACeOQRY-Gc-WDVGf0i6yZ24ANBP9HIdtO0j1qBGcecFV8RPMOuNhzX1erM63cfJpjMGrr0wpUCGaMcPONaqxS8bhPf_kO8oAo7nYT2UAhF5Y-yA4gSN_EWaGxd-FY0l-O8A0pMKubeaflErTbXJ7jZKgfO-GLZVdD0GWD91QTRAxURu5pSU1yU-cOiqwke312wspnw1fWaksh_lWUGZviMKOmhYllhJ5dCJUjSt_6sDlBUAj4XwrEZfvjErngAHPFkADxvjytSj9jS872Ud_B8g92yBwEqi1sQD7pjaPPHpBEFY4qb9bxBzYnDDzJyXF9OqfhS0pdruvbaOH8eMBvBq526wphUk1Ke1Zg58jaGAfCn9j5oDnwpOMyABNJw7rRG0a7KKdsC6_cnDfF0RTKtt8fY7Q&zp=spdpsMVJaSyYDElHQwqWE5jIzk9snhClCyfNDIlUBTMD7nVYZZNH57csYy_7wyyflU-YJAP6UH-Ih2AYMR7S61yr29ysBGN-1NVufX5F3jip3BKRfSux0VsOk3RPzcN9EZ1jfQswmvAsVMuSGGn_MSWNC_xacHWjssyp2z0rePTQmwry17bHvGzRkSO5sl9QbtFQCNEyNNC9Cbv3hISWmCMT6_-DDvR9ZwARZbJRoakTxCsABKuEUiSpLIR19pmNK2YNprMffDxfiAeXm2GyjDT1q3tX6HxB7uiNd4ZCkuqJfrfjGJMXuxyUxUdTL7pw0zi3)
[rockstarRobin](https://www.reddit.com/user/rockstarRobin/)
•[17h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p02psee/)
This is why i think reproducibility matters so much. if the behavior changes significantly across models, it's easy to chase the wrong root cause.
ReplyShare
[MissJoannaTooU](https://www.reddit.com/user/MissJoannaTooU/)
•[10h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p05ejl1/)
Absolutely agree.
ReplyShare
[Snoo_27681](https://www.reddit.com/user/Snoo_27681/)
•[4h ago](https://www.reddit.com/r/LLMDevs/comments/1v7zcob/comment/p072py6/)
Great article that puts words to what I've been doing with small models.
Working with small models has become especially important for me as I make new libraries. Natural language tool calling, function signature alignment, semantic sentinels, etc..
Opus won't show you weaknesses in your API, but Qwen3.6-27 will very quickly show you where you can do better.
ReplyShare
Community Info Section
[r/LLMDevs](https://www.reddit.com/r/LLMDevs/)
Joined
LLMDevs
A space for Enthusiasts, Developers and Researchers to discuss LLMs and their applications.
Created Feb 17, 2023
Public
71KWeekly visitors
1.4KWeekly contributions
User flair
disorderaudio
Community Bookmarks
[Wiki](https://www.reddit.com/r/LLMDevs/wiki/index/)

## Assistant

## User

/model claude-sonnet-5

/create-pull-request merge

## Assistant

<routes ref="em:7309de">
Filed [debugging-agent-harnesses-on-weak-models](/knowledge/SWE/evals/debugging-agent-harnesses-on-weak-models.md) (`em:7309de`, `type: methodology`) under `knowledge/SWE/evals/` — the practice of running an agent product's eval suite against the cheapest models on the roster because a frontier model silently works around harness defects that a weak model fails on immediately, distilling the article's found-and-fixed bug table (file handling, sandbox tooling, provider schemas, agent runtime), the r/LLMDevs thread's contract-bug/model-ceiling/provider-quirk triage rule, and the multi-weak-model defence against provider-specific overfitting.
</routes>
<routes ref="em:1b6814">
Filed [archestra-open-source-enterprise-ai-platform](/knowledge/SWE/agentic/frameworks/archestra-open-source-enterprise-ai-platform.md) (`em:1b6814`, `type: reference`) under `knowledge/SWE/agentic/frameworks/` — the self-hosted MCP/agent platform whose harness the practice was developed against: an LLM gateway, an MCP gateway with OAuth on-behalf-of, a sandboxed agent runtime, and deterministic Dual-LLM/Lethal-Trifecta guardrails.
</routes>

Both filed autonomously into existing directories — no new taxonomy needed. Dedup: searched synonym-expanded terms (harness bug, weak model, tool ergonomics, differential testing, sandbox, agent runtime, open-source platform, enterprise AI platform) — nothing existing covers either, so both are new files.

Gold-set: harvested one row (the operator's pasted post title as the natural phrasing) mapping to `em:7309de`; baseline refreshed at plain 6/18, expanded 16/18 — no regression.

<routes ref="em:768cc8">
Glossaried [lethal trifecta](/beliefs/glossary/lethal-trifecta.md) (`em:768cc8`) — Simon Willison's term for the conjunction of private-data access, untrusted-content exposure, and an exfiltration channel that Archestra names as a guardrail category.
</routes>
<routes ref="em:e1a8ee">
Glossaried [dual-LLM pattern](/beliefs/glossary/dual-llm-pattern.md) (`em:e1a8ee`) — the companion mitigation architecture, a privileged model that never sees untrusted content directing a quarantined model that does.
</routes>
<routes ref="em:6e1259">
Glossaried [on-behalf-of delegation](/beliefs/glossary/on-behalf-of-delegation.md) (`em:6e1259`) — the OAuth token-exchange pattern that lets Archestra's MCP gateway present the end user's identity downstream instead of a shared service credential.
</routes>

No new terms merged into existing entries; [differential testing](/beliefs/glossary/differential-testing.md), [MCP](/beliefs/glossary/model-context-protocol.md), and [test oracle](/beliefs/glossary/test-oracle.md) were cross-linked but already covered.
