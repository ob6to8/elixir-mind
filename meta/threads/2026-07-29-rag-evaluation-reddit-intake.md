---
type: reference
title: 2026-07-29-rag-evaluation-reddit-intake
description: Intake of an r/LLMDevs discussion on RAG evaluation — persisted verbatim and distilled into a methodology doc on splitting retrieval/generation eval and calibrating an LLM judge — then captured, glossaried, and PR'd with merge.
provenance: "Claude Code session (Sonnet 5), 2026-07-29; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, evals, rag, retrieval, llm-as-judge, intake]
timestamp: 2026-07-29
session: https://claude.ai/code/session_0149Nj4yfEJQkJ48TTxc23Ef
---

# 2026-07-29-rag-evaluation-reddit-intake

## Where this landed

The operator pasted a r/LLMDevs discussion thread on evaluating a RAG pipeline
and asked for it to be persisted verbatim, along with analysis. Two documents
were filed under `knowledge/SWE/evals/`: a verbatim `reference` capture of the
thread, and a `methodology` doc distilling the community's converged
technique — split retrieval evaluation (a small gold set scored by hit
rate/MRR) from generation evaluation (a groundedness/hallucination check
against the retrieved context), note where the groundedness check inherits
retrieval's blind spot, and calibrate any LLM-judge against a human-scored
anchor set using a different model family. A dedup gold-set row was harvested
from the post's own title, the baseline refreshed with no regression, and the
change committed and pushed. The session then closed with
`/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Intake of the r/LLMDevs RAG-evaluation thread, verbatim | closed | [r/LLMDevs — evaluation is so much harder than actually building the model wrapper](/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md) | - |
| Distilled methodology: splitting retrieval/generation eval, calibrating the judge | closed | [Split retrieval and generation evaluation for RAG](/knowledge/SWE/evals/split-retrieval-and-generation-evaluation-for-rag.md) | - |
| Dedup gold row harvest + baseline refresh | closed | [dedup-probe gold set](/meta/evals/dedup-probe.md) | - |

## User

/intake https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/evaluation_is_so_much_harder_than_actually/
persist verbatim, along with analysis

thread text:

[Go to LLMDevs](https://www.reddit.com/r/LLMDevs/)
[r/LLMDevs](https://www.reddit.com/r/LLMDevs/)•12h ago
[nighthawk2906](https://www.reddit.com/user/nighthawk2906/)
evaluation is so much harder than actually building the model wrapper
[Discussion](https://www.reddit.com/r/LLMDevs/?f=flair_name%3A%22Discussion%22)
spent the last few weeks building a RAG pipeline for a client. the retrieval part works fine, the llm integration works fine, the whole thing comes together nicely
but now i'm stuck on evaluation. how do i know if the answers are good? the client wants metrics but every metric i can think of feels kinda fake
like BLEU scores? useless for open-ended questions. ROUGE? same problem. even the more modern LLM-as-judge approaches feel shaky cause they're biased toward whatever model you're using as the judge
i've been manually reviewing like 50 responses every day and it's driving me crazy. my eyes start glazing over after the 20th based on the provided context answer lol . a friend mentioned he uses some automation tools to track his evaluation processes
what are you all using for evaluation? especially for RAG where the ground truth is kinda fuzzy
Upvote2Downvote12Go to comments[Repost](https://www.reddit.com/submit?source_id=t3_1v9m8d5&composer_entry=crosspost_post_action_bar)Share
[OpenAI](https://www.reddit.com/user/OpenAI/)•[Ad](https://www.reddit.com/user/OpenAI/)
[How to stop juggling terminal windows with Romain Huet — Head of DX, OpenAI](https://alb.reddit.com/cr?za=ILDpkUyI3zAU-D1ZN837KImOujolaLiRErQvAwQqXCmyh1zuk-bV1x53451yoIwiyEc5FElcfsfrl9FITtwAKAA8rSc5dKb08S6GzG3Y5IxJwkQtpkZrFvr_usZJ7BFaj878k7IaXToF2zYkRfzvPe6G3sjidN5GJa8UHcaJUfvUoqAJnD1MsthFO55ru4LDu4WcAFN44lE2SzVu8U09qtQo3jbTuONq-8WtozQc3V9Kr2gij4G16TY2NS-BSD-bpUlB-6xS2CsjodsxhvadKqgYZEW7vzW3-g-F-vXvTQ3RapE7dGsySVX_w5LK8O3Ecp_-91vr2Z15CsnF-gT00AiGsMcSJ4Zw6fw-pXkDyVscDKWtIlNTZtjhi7ieNKxloghsM6uus6691mjfQvrwr7wI5Oit8jCDdbvIyYzz94RvosypC0PwmA_IggtpYDpG_vn8s4yjSge_cCrHLp63q4msQ5pOn4qZ8tjuMYzzFiKQwR9ohNIZIVIYY4l__w6lj22-ZnclObTSWmhWrWnFOf2PFUbtgParEF4AuvnV4RAsbbAN77G8Tg-2-F4w5c471jcNOXqBx4Rx9uj15O3P0oTit9Wa1-Tvt8HefSxh-fbPBhooy6ogAleW8NPkYBVo5GOO2-3qjF2SoupkFd2Gy3st7XmA9d-RaaUG-Xod8azyc2QbOXC4h4Wh2vuZyG-MKgpQD7AqW5mht5HehpRQe7Y_f5Ghp0UBPQ&zp=to7TfRihLgRdwMRRhnP6wE7rvzdMpi6hdRvYHn5-qLJKHmQvEtfVle8TIEZKDIS_9PeE8Qis1tMpQLDr2B5lFI8v1nCARjWCQxt-zAbk9w_Tue04urTzdSp9xglyStzz2jSkdoHMCdlW9XERGqvzJRltyzMG1Ly8G60pCW-2a4RgiJR4anu0J4oXE_hRIE-oobwgEXl1u5_PBMLO4R9xTqVmKdBhwoxJ-PjCegBcYYTj8fyf0cz1khlVKwP5iU9kC2kp6XSMtILIKMcWbGfrDGnwLZbS0Nav6D9lQ4oC8tHm4icB9u8jH9tnBvv_s6MqC_caKyGr6yH7Nv9x_gJ0dOshCWy0C3NSgwgwJOoYQA2axuGzpjX5qnUdJ8oUvbElOY898ueWO5phQ7Q2681vNzNBp7tN0l7xmDNAyYKMOyatkCV1MctdWx49SOHZbunZhMTMB5UuY3vW_9H4UeSJ8QB3qICzALKSdb3IdTfgS19y0C99nIOpNQWjgGtWf5WJkEMJQ6Zy-OlxOuvMAbJEd0a1VibloBbaP2byB2AQ9kvxa-TNY05YrLGT8jhX-QaPd-QImm_AIwJwWQPtplg9_g)
[Sign Up](https://alb.reddit.com/cr?za=ILDpkUyI3zAU-D1ZN837KImOujolaLiRErQvAwQqXCmyh1zuk-bV1x53451yoIwiyEc5FElcfsfrl9FITtwAKAA8rSc5dKb08S6GzG3Y5IxJwkQtpkZrFvr_usZJ7BFaj878k7IaXToF2zYkRfzvPe6G3sjidN5GJa8UHcaJUfvUoqAJnD1MsthFO55ru4LDu4WcAFN44lE2SzVu8U09qtQo3jbTuONq-8WtozQc3V9Kr2gij4G16TY2NS-BSD-bpUlB-6xS2CsjodsxhvadKqgYZEW7vzW3-g-F-vXvTQ3RapE7dGsySVX_w5LK8O3Ecp_-91vr2Z15CsnF-gT00AiGsMcSJ4Zw6fw-pXkDyVscDKWtIlNTZtjhi7ieNKxloghsM6uus6691mjfQvrwr7wI5Oit8jCDdbvIyYzz94RvosypC0PwmA_IggtpYDpG_vn8s4yjSge_cCrHLp63q4msQ5pOn4qZ8tjuMYzzFiKQwR9ohNIZIVIYY4l__w6lj22-ZnclObTSWmhWrWnFOf2PFUbtgParEF4AuvnV4RAsbbAN77G8Tg-2-F4w5c471jcNOXqBx4Rx9uj15O3P0oTit9Wa1-Tvt8HefSxh-fbPBhooy6ogAleW8NPkYBVo5GOO2-3qjF2SoupkFd2Gy3st7XmA9d-RaaUG-Xod8azyc2QbOXC4h4Wh2vuZyG-MKgpQD7AqW5mht5HehpRQe7Y_f5Ghp0UBPQ&zp=to7TfRihLgRdwMRRhnP6wE7rvzdMpi6hdRvYHn5-qLJKHmQvEtfVle8TIEZKDIS_9PeE8Qis1tMpQLDr2B5lFI8v1nCARjWCQxt-zAbk9w_Tue04urTzdSp9xglyStzz2jSkdoHMCdlW9XERGqvzJRltyzMG1Ly8G60pCW-2a4RgiJR4anu0J4oXE_hRIE-oobwgEXl1u5_PBMLO4R9xTqVmKdBhwoxJ-PjCegBcYYTj8fyf0cz1khlVKwP5iU9kC2kp6XSMtILIKMcWbGfrDGnwLZbS0Nav6D9lQ4oC8tHm4icB9u8jH9tnBvv_s6MqC_caKyGr6yH7Nv9x_gJ0dOshCWy0C3NSgwgwJOoYQA2axuGzpjX5qnUdJ8oUvbElOY898ueWO5phQ7Q2681vNzNBp7tN0l7xmDNAyYKMOyatkCV1MctdWx49SOHZbunZhMTMB5UuY3vW_9H4UeSJ8QB3qICzALKSdb3IdTfgS19y0C99nIOpNQWjgGtWf5WJkEMJQ6Zy-OlxOuvMAbJEd0a1VibloBbaP2byB2AQ9kvxa-TNY05YrLGT8jhX-QaPd-QImm_AIwJwWQPtplg9_g)
[chatgpt.com](https://alb.reddit.com/cr?za=ILDpkUyI3zAU-D1ZN837KImOujolaLiRErQvAwQqXCmyh1zuk-bV1x53451yoIwiyEc5FElcfsfrl9FITtwAKAA8rSc5dKb08S6GzG3Y5IxJwkQtpkZrFvr_usZJ7BFaj878k7IaXToF2zYkRfzvPe6G3sjidN5GJa8UHcaJUfvUoqAJnD1MsthFO55ru4LDu4WcAFN44lE2SzVu8U09qtQo3jbTuONq-8WtozQc3V9Kr2gij4G16TY2NS-BSD-bpUlB-6xS2CsjodsxhvadKqgYZEW7vzW3-g-F-vXvTQ3RapE7dGsySVX_w5LK8O3Ecp_-91vr2Z15CsnF-gT00AiGsMcSJ4Zw6fw-pXkDyVscDKWtIlNTZtjhi7ieNKxloghsM6uus6691mjfQvrwr7wI5Oit8jCDdbvIyYzz94RvosypC0PwmA_IggtpYDpG_vn8s4yjSge_cCrHLp63q4msQ5pOn4qZ8tjuMYzzFiKQwR9ohNIZIVIYY4l__w6lj22-ZnclObTSWmhWrWnFOf2PFUbtgParEF4AuvnV4RAsbbAN77G8Tg-2-F4w5c471jcNOXqBx4Rx9uj15O3P0oTit9Wa1-Tvt8HefSxh-fbPBhooy6ogAleW8NPkYBVo5GOO2-3qjF2SoupkFd2Gy3st7XmA9d-RaaUG-Xod8azyc2QbOXC4h4Wh2vuZyG-MKgpQD7AqW5mht5HehpRQe7Y_f5Ghp0UBPQ&zp=to7TfRihLgRdwMRRhnP6wE7rvzdMpi6hdRvYHn5-qLJKHmQvEtfVle8TIEZKDIS_9PeE8Qis1tMpQLDr2B5lFI8v1nCARjWCQxt-zAbk9w_Tue04urTzdSp9xglyStzz2jSkdoHMCdlW9XERGqvzJRltyzMG1Ly8G60pCW-2a4RgiJR4anu0J4oXE_hRIE-oobwgEXl1u5_PBMLO4R9xTqVmKdBhwoxJ-PjCegBcYYTj8fyf0cz1khlVKwP5iU9kC2kp6XSMtILIKMcWbGfrDGnwLZbS0Nav6D9lQ4oC8tHm4icB9u8jH9tnBvv_s6MqC_caKyGr6yH7Nv9x_gJ0dOshCWy0C3NSgwgwJOoYQA2axuGzpjX5qnUdJ8oUvbElOY898ueWO5phQ7Q2681vNzNBp7tN0l7xmDNAyYKMOyatkCV1MctdWx49SOHZbunZhMTMB5UuY3vW_9H4UeSJ8QB3qICzALKSdb3IdTfgS19y0C99nIOpNQWjgGtWf5WJkEMJQ6Zy-OlxOuvMAbJEd0a1VibloBbaP2byB2AQ9kvxa-TNY05YrLGT8jhX-QaPd-QImm_AIwJwWQPtplg9_g)
Collapse video player
0:00 / 0:00
Sort by:Best
Search CommentsExpand comment search
Comments Section
[No_Holiday1810](https://www.reddit.com/user/No_Holiday1810/)
•[12h ago](https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/comment/p0etz5e/)
ah the eval rabbit hole, welcome. i started just building a tiny set of 20 questions where i the right answer should pull from a specific doc chunk, then checking if the retrieval actually grabbed that chunk. way less soul-crushing than staring at generated text all day
your friend is onto something with automating the tracking part, i log the chunk IDs and let a script flag the misses so i only look at the weird ones. manual review of 50 a day is a fast track to burning out your eyeballs
ReplyShare
[nighthawk2906](https://www.reddit.com/user/nighthawk2906/)
•[5h ago](https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/comment/p0g6djx/)
the chunk ID logging is a good starting point, hadn't thought about that either
the triage thing is real though. i'm in the same spot where not all misses feel equal but i can't tell which ones to ignore without just reading through everything anyway, which kind of defeats the purpose
did you land on a threshold that worked or was it more just tuning it over time
ReplyShare
[Positive-Buddy-1258](https://www.reddit.com/user/Positive-Buddy-1258/)
•[8h ago](https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/comment/p0fo0nw/)
Splitting retrieval eval and generation eval helps. Retrieval you can check mechanically: did the right chunks surface? Log chunk IDs, script the misses, only look at those. Generation is harder because "correct" is fuzzy, but you can narrow what you're actually checking. Instead of "is this a good answer", ask "did the answer use the retrieved context, and did it add anything that isn't in the context." The second question catches hallucinations without needing ground truth.
For annotation: what helped was a simple interface where a reviewer flags each output as correct/partial/wrong with one click, free-text only on the wrong ones. No writing something for every row. You get a labeled dataset useful for regression testing later, and the session takes 10 minutes instead of an hour.
ReplyShare
[nighthawk2906](https://www.reddit.com/user/nighthawk2906/)
•[5h ago](https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/comment/p0g70bj/)
The annotation flow you described is pretty much what we ended up with too, flags with freetext only on the bad ones. The part I keep running into is who actually does the reviewing when the subject matter is specialized enough that a general reviewer misses subtly wrong answers. The hallucination check you mentioned helps narrow it down, but if the retrieved context is slightly off, that check stops catching what it needs to catch.
ReplyShare
[Positive-Buddy-1258](https://www.reddit.com/user/Positive-Buddy-1258/)
•[1h ago](https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/comment/p0hlf35/)
The chunk visibility thing actually helps more with this specific failure mode than with general quality. If the reviewer sees what was retrieved alongside the answer, they're not judging correctness from scratch, they're just checking whether the answer matches the chunk. That's a much lower bar than domain expertise.
The catch is when the chunk itself is the problem, retrieval pulled something adjacent but not quite right. Then the answer looks consistent with context and the check passes. That's where it stops helping and you're back to needing someone who actually knows the domain.
ReplyShare
[Future_AGI](https://www.reddit.com/user/Future_AGI/)
•[6h ago](https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/comment/p0fywbt/)
The manual review does not scale and you do not need it for half the problem: retrieval eval is mechanical (log chunk ids, did the right one surface, script the misses) so you can automate that entirely and save your eyes for generation. For the judge bias, use a different model family than the one you are scoring and anchor it to ten answers you scored by hand, then spot-check the judge against those weekly, which is roughly the eval loop we build and it turns 50-a-day into a handful of disagreements to look at.
ReplyShare
[cmtape](https://www.reddit.com/user/cmtape/)
•[5h ago](https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/comment/p0gdzt2/)
Evaluating RAG with BLEU/ROUGE is like judging a chef by how many times they used the word 'salt' in a recipe. The metric is technically correct, but it tells you absolutely nothing about whether the food actually tastes good.
ReplyShare
[u/theatlantic](https://www.reddit.com/user/theatlantic/)•[Ad](https://www.reddit.com/user/theatlantic/)
[Here's an actual photo of just one fact-checked page of an 11,000-word article. High-quality journalism isn't cheap to make. But you can support this work, and enjoy access to all of it, for less than $2 a week.](https://alb.reddit.com/cr?za=QUsrcs99houJ4gTQarlc2akH0dl9n-B3dSLYjT46_pHx4MsGeBR0_egiixu96FKh8TsGDuoqbeFoBPFzWFolZe73UE5ruc4ugBnNj1_0E_uKUFFW9zKWSYX5TD3G7tz9aZuba-ccb-CWGaSstC92XHYeuhGlH9g-LeENYEC_-8bD77HhyZXMdLXB8LsHM5qyx9eGPEU0zrsjdhY1S6iHgKNgp3qfIBj2dmWDY4sqf71ZHFxCoZZ77mVnIe87DNLQbRvixjsDBjTzrK3V2qGSEEsgYalm3oOapfKbDPoI5hvsdMrsIm14Ia5QDaiDKsB7CqCJkQGI-BWFDsNOU7QhG9bdLq9cabiN7dlzwPylC_6X1GhZs_-BaJ_929xg1x0roVeHTSYQRFd7UoxK5Fnxv9HOFmwaA4YqS-WuFmylcMsEAN4I0BfaXEw315Sv7UlweB4iwSrWDROTRKqsp-8xLOlNWUNRQ0t9RCtT4_KvkyInqMsVez_YgsgynIdLorpt5pqMJvRrM4RRsy51haJivo0l5t8G-znhwFuRCoqLpV_04dqaVv8T1yGK_d5T5Nsumv27zgI95ykIZBYiNqtawysV-wzPjC7piqjwTPDFwSr4zdhHy1MrZqKH8ryhaKkYtT3neBGtIQDcN3yPHBxexENP3JcYhtbI30MY9Nt1eqWLD7phuIUcunTbSDm3ozxcIa2w3AnX3_XXorwrLp34K9Dfatg&zp=BY2VQBsymcuqJupf1QVPoEj6nvHtGZsosgAVlfnOhEz1eKTigHpKS-LfbEGfrlHHR9sZvFRnsOHog2TDWK4JgWlBsEzzlUrrOydTwYYMCcQ7uP6SLinwcooivvx6P2RAi3D5mAdPAXpGHr2pbYyjaAPNHwOR0ZjNhluTTqyBtZsY1AIzGprC9jitxsEu88f_7EJGL2tef-Ozyx4_0qXMIAKiW8kLhWNaaCwAx-hZG8lQCnfW0XspdHADbZPeoholta-SsP81ySgoEbr2Ibl2pDmE_mt1ueeCtkzkJ02FtbdDXvnO1NRtp1hl3fRxKY_uj4KcHBDDCfS0sn6sXKo9nTxRYn_VYP750SDpr3cqg69kvGoJbTEwVafDmqP_NQTkXWWqmu_462dn4FvBGp96qoi3V6cZdiZG45m6hkPindqWCaymWATWF_yQybQd41OE5OzMc3OvO3LavrT-g9qwlfr37wUZ9bvb)
[Learn More](https://alb.reddit.com/cr?za=QUsrcs99houJ4gTQarlc2akH0dl9n-B3dSLYjT46_pHx4MsGeBR0_egiixu96FKh8TsGDuoqbeFoBPFzWFolZe73UE5ruc4ugBnNj1_0E_uKUFFW9zKWSYX5TD3G7tz9aZuba-ccb-CWGaSstC92XHYeuhGlH9g-LeENYEC_-8bD77HhyZXMdLXB8LsHM5qyx9eGPEU0zrsjdhY1S6iHgKNgp3qfIBj2dmWDY4sqf71ZHFxCoZZ77mVnIe87DNLQbRvixjsDBjTzrK3V2qGSEEsgYalm3oOapfKbDPoI5hvsdMrsIm14Ia5QDaiDKsB7CqCJkQGI-BWFDsNOU7QhG9bdLq9cabiN7dlzwPylC_6X1GhZs_-BaJ_929xg1x0roVeHTSYQRFd7UoxK5Fnxv9HOFmwaA4YqS-WuFmylcMsEAN4I0BfaXEw315Sv7UlweB4iwSrWDROTRKqsp-8xLOlNWUNRQ0t9RCtT4_KvkyInqMsVez_YgsgynIdLorpt5pqMJvRrM4RRsy51haJivo0l5t8G-znhwFuRCoqLpV_04dqaVv8T1yGK_d5T5Nsumv27zgI95ykIZBYiNqtawysV-wzPjC7piqjwTPDFwSr4zdhHy1MrZqKH8ryhaKkYtT3neBGtIQDcN3yPHBxexENP3JcYhtbI30MY9Nt1eqWLD7phuIUcunTbSDm3ozxcIa2w3AnX3_XXorwrLp34K9Dfatg&zp=BY2VQBsymcuqJupf1QVPoEj6nvHtGZsosgAVlfnOhEz1eKTigHpKS-LfbEGfrlHHR9sZvFRnsOHog2TDWK4JgWlBsEzzlUrrOydTwYYMCcQ7uP6SLinwcooivvx6P2RAi3D5mAdPAXpGHr2pbYyjaAPNHwOR0ZjNhluTTqyBtZsY1AIzGprC9jitxsEu88f_7EJGL2tef-Ozyx4_0qXMIAKiW8kLhWNaaCwAx-hZG8lQCnfW0XspdHADbZPeoholta-SsP81ySgoEbr2Ibl2pDmE_mt1ueeCtkzkJ02FtbdDXvnO1NRtp1hl3fRxKY_uj4KcHBDDCfS0sn6sXKo9nTxRYn_VYP750SDpr3cqg69kvGoJbTEwVafDmqP_NQTkXWWqmu_462dn4FvBGp96qoi3V6cZdiZG45m6hkPindqWCaymWATWF_yQybQd41OE5OzMc3OvO3LavrT-g9qwlfr37wUZ9bvb)
[accounts.theatlantic.com](https://alb.reddit.com/cr?za=QUsrcs99houJ4gTQarlc2akH0dl9n-B3dSLYjT46_pHx4MsGeBR0_egiixu96FKh8TsGDuoqbeFoBPFzWFolZe73UE5ruc4ugBnNj1_0E_uKUFFW9zKWSYX5TD3G7tz9aZuba-ccb-CWGaSstC92XHYeuhGlH9g-LeENYEC_-8bD77HhyZXMdLXB8LsHM5qyx9eGPEU0zrsjdhY1S6iHgKNgp3qfIBj2dmWDY4sqf71ZHFxCoZZ77mVnIe87DNLQbRvixjsDBjTzrK3V2qGSEEsgYalm3oOapfKbDPoI5hvsdMrsIm14Ia5QDaiDKsB7CqCJkQGI-BWFDsNOU7QhG9bdLq9cabiN7dlzwPylC_6X1GhZs_-BaJ_929xg1x0roVeHTSYQRFd7UoxK5Fnxv9HOFmwaA4YqS-WuFmylcMsEAN4I0BfaXEw315Sv7UlweB4iwSrWDROTRKqsp-8xLOlNWUNRQ0t9RCtT4_KvkyInqMsVez_YgsgynIdLorpt5pqMJvRrM4RRsy51haJivo0l5t8G-znhwFuRCoqLpV_04dqaVv8T1yGK_d5T5Nsumv27zgI95ykIZBYiNqtawysV-wzPjC7piqjwTPDFwSr4zdhHy1MrZqKH8ryhaKkYtT3neBGtIQDcN3yPHBxexENP3JcYhtbI30MY9Nt1eqWLD7phuIUcunTbSDm3ozxcIa2w3AnX3_XXorwrLp34K9Dfatg&zp=BY2VQBsymcuqJupf1QVPoEj6nvHtGZsosgAVlfnOhEz1eKTigHpKS-LfbEGfrlHHR9sZvFRnsOHog2TDWK4JgWlBsEzzlUrrOydTwYYMCcQ7uP6SLinwcooivvx6P2RAi3D5mAdPAXpGHr2pbYyjaAPNHwOR0ZjNhluTTqyBtZsY1AIzGprC9jitxsEu88f_7EJGL2tef-Ozyx4_0qXMIAKiW8kLhWNaaCwAx-hZG8lQCnfW0XspdHADbZPeoholta-SsP81ySgoEbr2Ibl2pDmE_mt1ueeCtkzkJ02FtbdDXvnO1NRtp1hl3fRxKY_uj4KcHBDDCfS0sn6sXKo9nTxRYn_VYP750SDpr3cqg69kvGoJbTEwVafDmqP_NQTkXWWqmu_462dn4FvBGp96qoi3V6cZdiZG45m6hkPindqWCaymWATWF_yQybQd41OE5OzMc3OvO3LavrT-g9qwlfr37wUZ9bvb)
Collapse video player
0:00 / 0:00
[roger_ducky](https://www.reddit.com/user/roger_ducky/)
•[4h ago](https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/comment/p0gjm23/)
It's easier to evaluate all steps individually, IMO.
Ensure there's no drift in the harness. (Ie, it's pulling in the most recent info in the system)
Then have example "good" answers based on user feedback and use that to evaluate. Or, if the prompt expected specific information to be mentioned then check if that's true.
ReplyShare
[DancesWithWhales](https://www.reddit.com/user/DancesWithWhales/)
•[4h ago](https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/comment/p0gpxdf/)
Yeah, this is the hard part for sure! I think I've spent more time on eval than on my mcp itself.
I'm working on end to end evals now where I record a whole actual session, and then replay it with changes to the mcp, and measure the outcomes of the session rather than just measure the outcomes of the mcp.
It involves a "simulated human" run by another LLM to act as the user. Happy to share more if anyone's interested.
ReplyShare
[Key_Medicine_8284](https://www.reddit.com/user/Key_Medicine_8284/)
•[3h ago](https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/comment/p0gvcod/)
This is the part nobody warns you about. The retrieval works, the LLM integration works, and then you hit the eval wall.
You're right that BLEU and ROUGE are the wrong tool for open-ended QA. The approach that tends to hold up better in practice: separate retrieval eval from generation eval, because they fail for different reasons and need different metrics.
For retrieval, you can get ground truth relatively cheaply. Have someone (or another LLM) annotate a set of test questions with which chunks should have been retrieved. Then measure hit rate and MRR. That's not fake — if your retrieval isn't surfacing the right chunks, the generation step can't fix it.
For generation, LLM-as-judge is imperfect but not useless if you calibrate it carefully. The bias issue you named is real, so use a judge model different from your generator, define a rubric explicitly (groundedness, relevance, completeness separately), and have humans grade a random sample to check how well the judge tracks human preferences. That calibration step is what turns "kinda fake" into "good enough to catch regressions."
On tooling: MLflow's eval framework on Databricks lets you run reference-based and LLM-judge metrics in the same run, track them over time, and compare across pipeline versions. Worth trying if you want to stop manually computing this stuff in notebooks. Self-hosted MLflow works too if you're not on Databricks.
ReplyShare

## Assistant

<routes ref="em:1394b9 em:9baaad">
The Reddit thread on RAG evaluation is now filed in two documents under
`knowledge/SWE/evals/`, and the branch is pushed.

**What happened, in plain terms:** the thread argues that scoring a RAG
pipeline's answers with one blended metric (BLEU/ROUGE, or a single
LLM-judge score) hides which half is broken. The fix the commenters converge
on is to score retrieval and generation separately — retrieval against a
small hand-built answer key (hit rate/MRR), generation by whether it stuck
to the retrieved text (a hallucination check) — and to keep any LLM-judge
honest by testing it against answers a human already scored, using a
different model as the judge. I captured the raw thread verbatim, and wrote
a second document distilling that technique for reuse.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `reference` | [r/LLMDevs thread, verbatim](https://github.com/ob6to8/elixir-mind/blob/claude/rag-evaluation-metrics-zesc6s/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md) (`em:1394b9`) | External material captured per your instruction to persist it verbatim; `resource` holds the source URL |
| `methodology` | [Split retrieval/generation eval for RAG](https://github.com/ob6to8/elixir-mind/blob/claude/rag-evaluation-metrics-zesc6s/knowledge/SWE/evals/split-retrieval-and-generation-evaluation-for-rag.md) (`em:9baaad`) | A repeatable, prescriptive how-to distilled from the thread — the analysis half of the ask |

Both filed under the existing `knowledge/SWE/evals/` directory (no new
directory or type needed), cross-linked to each other and to existing
bundle concepts: [gold set](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/glossary/gold-set.md),
[test oracle](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/glossary/test-oracle.md),
[decompose-then-verify factuality](https://github.com/ob6to8/elixir-mind/blob/main/knowledge/SWE/evals/decompose-then-verify-factuality.md),
[an instrument without a control](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/an-instrument-without-a-control-measures-itself.md),
and [coverage and quality must be measured jointly](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/coverage-and-quality-must-be-measured-jointly.md).
</routes>

<routes ref="meta/evals/dedup-probe.md">
**Actions I have taken**

| Action | Result |
|---|---|
| Dedup search (RAG/eval/hit-rate/MRR/groundedness/LLM-judge phrasings) | No existing coverage found — both docs are new, not merges |
| `mix brain.id && mix brain.registry` | 2 ids minted, registry recompiled |
| Updated `knowledge/SWE/evals/index.md` | Both new docs listed |
| Harvested a dedup gold-set row (the post's own title → `em:9baaad`) | Recorded in `meta/evals/dedup-probe.md` |
| `mix brain.dedup_probe --update-baseline` | 7/20 plain — no regression vs. prior baseline |
| Full gate suite + commit + push | All green (format, xref, contract, registry, codemap, verify, route-tags, glossary, lineage, 188 tests); pushed to `claude/rag-evaluation-metrics-zesc6s` |
</routes>

Nothing is awaiting your ratification — no new directory or type was needed.
Per the contract, I haven't opened a pull request since that wasn't
explicitly requested; let me know if you'd like one.

## User

/create-pull-request merge

*(The session then ran `/create-pull-request` with the merge opt-in: this
capture, the glossary pass over its thread doc, the `attribution.from` stamp
on the dedup-probe gold set, and the PR that anchors this thread.)*
