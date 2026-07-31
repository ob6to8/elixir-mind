---
type: reference
title: 2026-07-29-post-action-readback-belief-and-plan
description: Operator supplies a post-action-verification quote; two beliefs are extracted (completion claims aren't evidence; only what the other side produced is evidence, discovered mid-session and disqualifying one of the plan's own proposed checks), a plan applies them to this repo's git/GitHub tail, the source thread is intook verbatim, and a same-session dating error — an immutable attribution.when field overwritten, then correctly reverted — is caught and fixed before capture.
provenance: "Claude Code session (Claude Opus 5), 2026-07-29 to 2026-07-31; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, verification, read-back, belief, plan, intake, evidence, dating-error]
timestamp: 2026-07-31
session: https://claude.ai/code/session_01DVYRTueTVHEGm2q2RuhhTf
---

# 2026-07-29-post-action-readback-belief-and-plan

## Where this landed

The operator supplied a Reddit-comment quote on post-action verification and asked
for two things: a plan for how this repo's development flow could incorporate the
practice, and the quote committed as a belief. The first pass filed
[`em:674c8f`](/beliefs/completion-claims-are-not-evidence-of-completion.md) from
the excerpt alone and a plan scoping read-backs to the git/GitHub tail (the one
boundary the gate suite doesn't already cover). The operator then supplied the
full source thread — twice, the first attempt arriving empty — which reshaped both
artifacts: the OP's own framing sharpened the belief's argument, and a second
commenter's rule (only what the other side produced is evidence) supplied a test
that **disqualified one of the plan's own proposed read-backs** — a `/capture`
fidelity check that could only ever read material the same session had written.
That became a second belief, [`em:01abda`](/beliefs/only-what-the-other-side-produced-is-evidence.md).
The operator then asked for the thread intook verbatim and cross-linked, filed as
[`em:b01e03`](/knowledge/SWE/agentic/action-verification/agent-says-done-reddit-discussion-thread.md)
under a new `knowledge/SWE/agentic/action-verification/` directory. Closing out the
session, a self-check against the actual session log (rather than the injected
"today" context) found every document from this session dated two days wrong
(2026-07-29 instead of 2026-07-31) — and the first fix over-corrected, rewriting
an immutable `attribution.when` field the resource-attribution policy requires
stay write-once. Both errors are corrected on the branch; the plan stays
`status: proposed`, pending the operator's ratification of P1.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Post-action read-back as a belief | closed | [em:674c8f](/beliefs/completion-claims-are-not-evidence-of-completion.md) | - |
| What counts as evidence for a read-back | closed | [em:01abda](/beliefs/only-what-the-other-side-produced-is-evidence.md) | - |
| Wiring read-back verification into this repo's flow | paused | [meta/plans/post-action-readback-in-the-development-flow.md](/meta/plans/post-action-readback-in-the-development-flow.md) | plan is `status: proposed`; P1 (the policy) awaits operator ratification |
| Verbatim source capture of the Reddit thread | closed | [em:b01e03](/knowledge/SWE/agentic/action-verification/agent-says-done-reddit-discussion-thread.md) | - |
| Same-session dating error and its correction | closed | unrouted | - |

## User

consider this quote:

"Post-action verification against the source of truth is the only thing that actually works, trace/eval/guardrails all check the agent's story, not reality. Concretely: after any state-changing action, do a read-back call to confirm the actual state (refund shows in billing, ticket status changed), not just "did the call return 200." Treat the write and the verify as two separate steps, never trust completion claims from the same context that made the claim"

analyze this repo, and create a plan that presents how the development flow of this repo could incorporate this 

also - commit this quote as a proto-belief, per this source: https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/your_agent_says_done_you_check_and_nothing/

## Assistant

<routes ref="em:674c8f">
The quote says: don't believe an agent when it says it did something — go look at the thing it claims to have changed. I filed that as a belief, then looked at where this repo is actually exposed to it.
</routes>

<routes ref="/meta/plans/post-action-readback-in-the-development-flow.md">
The answer is narrower than I expected, and that turned out to be the interesting part. This repo already does exactly what the quote asks — everywhere inside the checkout. Every generated file is written by one command and confirmed by a second one that rebuilds it from scratch and compares byte-for-byte. That's the "two separate steps" property, implemented about ten times over. So the plan doesn't propose spreading read-backs everywhere; it proposes them only where the state lives somewhere the session can't see — the remote, the pull request, the merge — and explicitly rules out re-reading files after every edit as ceremony.
</routes>

## Where the gap actually is

<routes ref="/meta/plans/post-action-readback-in-the-development-flow.md">
The [create-pull-request flow doc](https://github.com/ob6to8/elixir-mind/blob/main/meta/flows/create-pull-request.md) already concedes it in one line:

> "the git/GitHub tail (commit, push, PR) is external state with no in-repo oracle — CI on the pushed branch is its check."

Green CI proves *a* commit reached the remote and passes the suite. It does not prove the PR's head is that commit, that the `pr:` stamp shipped inside the PR, that the merge landed, or that the head branch was deleted. Five distinct facts, one partial oracle presented as covering all of them.

And the repo has the failure already on file. The [`/research` Routine issue](https://github.com/ob6to8/elixir-mind/blob/main/meta/issues/daily-news-routine-runs-not-landing.md) is the quote's scenario verbatim — a scheduled run whose pipeline ends "commit & push" and produces no commit, found by the operator polling `origin/main` two hours later. The issue even records why it couldn't be caught from inside: *"it was not possible to distinguish 'fired and failed' from 'never fired', because the query tool itself is gated."* That's the read-back's absence stated as a diagnosis.
</routes>

## The scoping rule, which is the load-bearing decision

<routes ref="em:674c8f /meta/plans/post-action-readback-in-the-development-flow.md">
**A read-back is owed where the state is outside the working tree, or where nothing downstream re-derives it. Where a later step already recomputes the state from the authority, that step *is* the read-back.**

That partitions the flow cleanly — seven categories of state are already covered by the gate suite, five are taken on the acting call's word. All the work is in the second group, which is why the proposal is one policy plus three skill edits, **no new gate and no new module**. A gate can't cover this anyway: the state is external, which fails the toolchain's offline admission rule, and a gate runs *before* the action it would need to follow.

One piece of prior art already exists and generalizes cleanly — step 9 of `/create-pull-request` says a check-run can report `in_progress` for a finished job, so consult the job itself because *"its `status`/`conclusion` and per-step timings are authoritative."* That's a read-back against a more authoritative source, written to fix a stale-read failure.

I dogfooded it on this change: after pushing, I read the ref back off the remote rather than trusting the push's exit code. Local HEAD and remote ref both `78b9699`.
</routes>

### What I created

| type | doc | why this type |
|---|---|---|
| `belief` | [A completion claim is not evidence of completion](https://github.com/ob6to8/elixir-mind/blob/claude/post-action-verification-plan-pl9vqy/beliefs/completion-claims-are-not-evidence-of-completion.md) — `em:674c8f` | value-laden decision prior, unfalsifiable as stated ("the only thing that actually works"), held to guide action. Carries `depends_on: [em:2ecdd2]` — it's the action-side instance of *review is not an oracle* |
| `plan` | [Post-action read-back: confirm state changes against the source of truth](https://github.com/ob6to8/elixir-mind/blob/claude/post-action-verification-plan-pl9vqy/meta/plans/post-action-readback-in-the-development-flow.md) — `status: proposed` | a proposed change whose decisions must be recorded before executing; the policy text it proposes is yours to ratify, so it isn't executed in-session |

### What I modified

| file | thrust |
|---|---|
| `beliefs/index.md` | gloss for `em:674c8f` |
| `meta/plans/index.md` | gloss under Proposed |
| `meta/registry.md` | regenerated (`mix brain.registry`) for the new id |

### Actions I have taken

| action | result |
|---|---|
| Fetch the Reddit source | **failed** — WebFetch refuses `www.reddit.com` and `old.reddit.com`. The quote is filed as you supplied it, with the failure recorded in `provenance` and the attribution to the thread rather than a named author |
| `mix brain.id` | minted `em:674c8f` |
| Gate subset + pre-commit hook (full suite, 188 tests) | green; two pre-existing editorial warnings unrelated to this change, plus the expected `attribution` lacks `from` on the new plan — that's stamped by `/create-pull-request` at capture |
| Commit + push | `78b9699` on `claude/post-action-verification-plan-pl9vqy`; **read back** against `git ls-remote` — remote ref matches local HEAD |

No PR opened — you didn't ask for one.

### Questions you need to answer

| # | question | my recommendation |
|---|---|---|
| 1 | The quote is compound — four claims in one sentence. File as one belief now, or decompose into atomic beliefs? | **One now.** [`/extract-into-belief`](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/extract-into-belief-skill.md) is `accepted` but unbuilt; hand-splitting would pre-empt the decomposition protocol it exists to enforce. Filed as open question 3 in the plan |
| 2 | "Proto-belief" collides with an existing repo term — [`em:573229` *proto-belief document*](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/glossary/proto-belief-document.md) means something else entirely (a per-topic sink doc, from Composable Beliefs). I read your "proto-belief" as ordinary staging language and filed a full `type: belief`. Correct? | **Yes, as filed.** Your invocation is the ratification, same motion that seeded the existing beliefs. If you meant the scratch tier instead, it moves to `beliefs/future-beliefs.md` and the `em:` id retires |

### Your options from here

| # | option | what it entails |
|---|---|---|
| 1 | Ratify and execute P1 | write `meta/policy/post-action-readback.md`, `/render-contract`, index gloss. Binds every session including ad-hoc ones — most of the value, no code |
| 2 | Ratify P1 + P2 | adds the read-back steps to `/create-pull-request`, `/capture`, `/research`, and supersedes the flow doc's "no in-repo oracle" line |
| 3 | Leave `proposed` | the plan stands as the design record; nothing binds until you ratify |
| 4 | `/create-pull-request` | captures the session and opens the PR for what's already pushed |

## User

here is the source from reddit - incorporate into your analysis and documents

## Assistant

<routes ref="em:674c8f">
Three independent routes all refuse: WebFetch (blocked at the proxy), direct `curl` (HTTP 403), and a third-party reader service (HTTP 403, relayed body: *"You've been blocked by network security. To continue, log in to your Reddit account or use your developer token"*). Reddit is refusing unauthenticated reads of that thread, so this is not a sandbox quirk — no retry from here will succeed. It needs your paste.

That makes the provenance line I filed misleading in a way that matters: it blames WebFetch, which would invite a future session to retry from a different environment. Corrected to name the actual cause.
</routes>

## Assistant

I can't incorporate the source — the paste didn't arrive. Your message came through as the sentence alone, with no attached text or file (checked the working tree and the scratchpad; both empty of new content).

Please paste the thread text and I'll work it in. What it would change, concretely:

- **The belief's quote block.** Right now it carries only the passage you gave me in your first message. If that passage is a comment on the thread rather than the post body, the attribution changes, and any additional load-bearing phrasing gets quoted at the phrase level alongside it.
- **`provenance` and `resource`.** A named author and a date replace the deliberately vague "attributed to the thread." The unfetched-source caveat comes out entirely if the paste is the full page.
- **The plan's problem section.** If the thread contains concrete failure cases — the ones that motivated the practice — those are better evidence than my reconstruction, and at least one may map onto a boundary I didn't enumerate.

### Actions I have taken

| action | result |
|---|---|
| Fetch the source, three routes | all refused: WebFetch blocked at the proxy; `curl` to `/.json` → HTTP 403; third-party reader → HTTP 403 relaying *"blocked by network security … log in or use your developer token"*. Reddit is refusing unauthenticated reads of this thread — a different sandbox won't help |
| Corrected the belief's `provenance` | it blamed WebFetch, which read as a local limitation and would have invited a wasted retry. Now names the 403 and enumerates the three routes tried |
| Commit + push | `8793fcb`; read back against `git ls-remote` — remote ref matches local HEAD |

### Questions you need to answer

| # | question | my recommendation |
|---|---|---|
| 1 | Re-send the source text? | **Yes** — paste it directly into chat. Nothing else here can retrieve it, and I won't reconstruct thread content I haven't seen |

The two blocking questions from my previous message are still open (whether to decompose the belief into atomic beliefs, and whether "proto-belief" meant the full `type: belief` I filed or the scratch tier) — but neither blocks the paste.

## User

Your agent says “done.” You check and nothing actually happened. Anyone else seeing this?
[Discussion](https://www.reddit.com/r/AgentsOfAI/?f=flair_name%3A%22Discussion%22)
Honestly what worries me about agents isn’t a wrong answer, it’s when they say they did something and didn’t.
Agent goes “done, refund issued.” the run looks clean, no errors anywhere. then you check the system and there’s nothing. no refund, ticket still open, but the session got marked resolved anyway.
A clean run just means it stopped running. that’s all. it doesn’t mean the work actually happened. and “i did X” is basically free for a model to say. there’s no penalty for being wrong, and it says it with the same confidence whether it worked or not.
What’s frustrating is the usual tools don’t catch this. observability is just the trace, which is the agent telling its own story. so if a write silently no-ops or it skips a step, the trace still looks fine. evals check if the output sounds right. guardrails run before the action anyway. none of them answer the only thing that really matters after the fact: did reality match what it claimed?
If you’re doing codegen, it’s easier. rerun the test or check the diff and you know. but anything that touches real systems is where it breaks. issuing a refund in your billing system, updating a CRM field, provisioning something, moving a ticket, actually sending the email. there’s no cheap retry to verify any of that. you either reconcile it manually against the source of truth, or trust it and find out three days later from an angry customer.
So curious how people are handling this in practice. if your agents are taking real actions across systems, how are you verifying they actually landed? manual checks, reconciliation scripts, or just trusting the trace?
And has a silent fake “done” burned you before? agent completely sure it did the job, system of record saying otherwise.
Asking partly because I’m building in this space, so yeah, I’m biased. but mostly trying to understand if this is as common as it feels, or if I’m just over-indexing on my own experience. would be great to compare notes with anyone dealing with this on real systems.
Upvote8Downvote16Go to commentsRepostShare
[theatlantic](https://www.reddit.com/user/theatlantic/)•[Ad](https://www.reddit.com/user/theatlantic/)
[Summer days have a way of slowing us down. Savor all of The Atlantic—starting at less than $2 a week.](https://alb.reddit.com/cr?za=cszbJmSVAw_Jg8SIkRgzN2AbUzPSC9FDrzWqNTjV9KubCcVXWxFSN3RpV34ub_3m1fSmb8-hu74aeMAfpno-MlSjFcZXvkdWt2tROkqSOier0sXDsgus2dNbGn68fIhHrqlTBYzHAGvUyAU2LlwbWy24MTMtvpgVUBHAsVQ0MWiw6dlJBEzcc7gSgENF5DDfXOBil5C6AiJmCyj5sqmO_f82qDvcZ1oK7pF6suEyHdGLZMIxOkkbhB-4IE0p2ee7_Bv7HkfeIGzhDmWlirsZ_c0x3fpdLeej6ulHUt-v3Zzl3Uzihu9916_3N0b4eENNuKKZeMKzBeSJhQD7-A2FQE9plPrvt3NHdTm_CfvxVSIyMRzdlLGyDRioK-ZZnnwzhO-XazTP4IUQLNLaoGHlZzEJrdZLi_RYqIZaZK_B4_OREhCHYdy-jsOKHiSmIGCD5fG4zHheEl0cU0rGHaO_ynLIPWjeOPhadpCzia6s9ml4QuacojQRhXcoKBAGz4SZePElwZAQF-iks09JIL9JyYKcQ9RInXEvcI3ygBGOpj35J8WiG46AiqTwOm7VWr3lFORXHqj6IFBbU7aL_je3Z-PAaz64LJGbp2J1UlkmtPCri-puiMax-hNeJU8r0gRV10CW9MHmLChnALNodzooAOUTOFAy6PKUqNFdYN23xw34j-ZAFw1zn3BsLPKd-LLLbKocUo9fj-PPV-FJIoNLxhfx2JVQVHXfkY4F98Ct0XHr4hRSV6OJ8N065R7pVw&zp=d-QDnbLaoyIa67ZnYp2uw5OdjvCtbxhT8ezdOEXPg8m7qhJZZPjxUiCZmIxOeH5BPTikWlPGNEK7O05EnhDcm3WiSLGuJIrOU4VsIjtt80lALQdV4iYuw0L8lRIsgSeDICQZLSbXpVCbMgl9mx-1lgHrDEiulWy5q877mnFXzrxXXsb7Lpxr9kV7PVXge9Qq_emalolfNBoXy5IB1PEDtbIttzQc5m36YHcYJFuqZ3LEnhNAUH_ey1mWR8p6BKFsKEfe2f0gkgma_R9kHEcy0cxpDA-Icgo1XUuWrweeRlX9Sosh0iz0H2mzJnknaULh7Nq4smhagoDxxBpdLJD59EoeBwOrM7oxP3BqGHuYioZzqTnD6W-drbbY_gftohnM9p9sHum2l-TBm4CuLakaQ3hrS1Az8PPFM0J-Yf0LhafT1UAOgSjhRJx3Oyn3MbLkW6TfwUTPLmNKmQEqRvPy-fIeRWZ02CgJSkKteFL96JHBE3W1IrDTERAov7tHx1v5Hlt_4dFxNF6e5PXKmlQtrXenO3MHFXhHrDjwxJOD03fShj4)
[Subscribe](https://alb.reddit.com/cr?za=cszbJmSVAw_Jg8SIkRgzN2AbUzPSC9FDrzWqNTjV9KubCcVXWxFSN3RpV34ub_3m1fSmb8-hu74aeMAfpno-MlSjFcZXvkdWt2tROkqSOier0sXDsgus2dNbGn68fIhHrqlTBYzHAGvUyAU2LlwbWy24MTMtvpgVUBHAsVQ0MWiw6dlJBEzcc7gSgENF5DDfXOBil5C6AiJmCyj5sqmO_f82qDvcZ1oK7pF6suEyHdGLZMIxOkkbhB-4IE0p2ee7_Bv7HkfeIGzhDmWlirsZ_c0x3fpdLeej6ulHUt-v3Zzl3Uzihu9916_3N0b4eENNuKKZeMKzBeSJhQD7-A2FQE9plPrvt3NHdTm_CfvxVSIyMRzdlLGyDRioK-ZZnnwzhO-XazTP4IUQLNLaoGHlZzEJrdZLi_RYqIZaZK_B4_OREhCHYdy-jsOKHiSmIGCD5fG4zHheEl0cU0rGHaO_ynLIPWjeOPhadpCzia6s9ml4QuacojQRhXcoKBAGz4SZePElwZAQF-iks09JIL9JyYKcQ9RInXEvcI3ygBGOpj35J8WiG46AiqTwOm7VWr3lFORXHqj6IFBbU7aL_je3Z-PAaz64LJGbp2J1UlkmtPCri-puiMax-hNeJU8r0gRV10CW9MHmLChnALNodzooAOUTOFAy6PKUqNFdYN23xw34j-ZAFw1zn3BsLPKd-LLLbKocUo9fj-PPV-FJIoNLxhfx2JVQVHXfkY4F98Ct0XHr4hRSV6OJ8N065R7pVw&zp=d-QDnbLaoyIa67ZnYp2uw5OdjvCtbxhT8ezdOEXPg8m7qhJZZPjxUiCZmIxOeH5BPTikWlPGNEK7O05EnhDcm3WiSLGuJIrOU4VsIjtt80lALQdV4iYuw0L8lRIsgSeDICQZLSbXpVCbMgl9mx-1lgHrDEiulWy5q877mnFXzrxXXsb7Lpxr9kV7PVXge9Qq_emalolfNBoXy5IB1PEDtbIttzQc5m36YHcYJFuqZ3LEnhNAUH_ey1mWR8p6BKFsKEfe2f0gkgma_R9kHEcy0cxpDA-Icgo1XUuWrweeRlX9Sosh0iz0H2mzJnknaULh7Nq4smhagoDxxBpdLJD59EoeBwOrM7oxP3BqGHuYioZzqTnD6W-drbbY_gftohnM9p9sHum2l-TBm4CuLakaQ3hrS1Az8PPFM0J-Yf0LhafT1UAOgSjhRJx3Oyn3MbLkW6TfwUTPLmNKmQEqRvPy-fIeRWZ02CgJSkKteFL96JHBE3W1IrDTERAov7tHx1v5Hlt_4dFxNF6e5PXKmlQtrXenO3MHFXhHrDjwxJOD03fShj4)
[accounts.theatlantic.com](https://alb.reddit.com/cr?za=cszbJmSVAw_Jg8SIkRgzN2AbUzPSC9FDrzWqNTjV9KubCcVXWxFSN3RpV34ub_3m1fSmb8-hu74aeMAfpno-MlSjFcZXvkdWt2tROkqSOier0sXDsgus2dNbGn68fIhHrqlTBYzHAGvUyAU2LlwbWy24MTMtvpgVUBHAsVQ0MWiw6dlJBEzcc7gSgENF5DDfXOBil5C6AiJmCyj5sqmO_f82qDvcZ1oK7pF6suEyHdGLZMIxOkkbhB-4IE0p2ee7_Bv7HkfeIGzhDmWlirsZ_c0x3fpdLeej6ulHUt-v3Zzl3Uzihu9916_3N0b4eENNuKKZeMKzBeSJhQD7-A2FQE9plPrvt3NHdTm_CfvxVSIyMRzdlLGyDRioK-ZZnnwzhO-XazTP4IUQLNLaoGHlZzEJrdZLi_RYqIZaZK_B4_OREhCHYdy-jsOKHiSmIGCD5fG4zHheEl0cU0rGHaO_ynLIPWjeOPhadpCzia6s9ml4QuacojQRhXcoKBAGz4SZePElwZAQF-iks09JIL9JyYKcQ9RInXEvcI3ygBGOpj35J8WiG46AiqTwOm7VWr3lFORXHqj6IFBbU7aL_je3Z-PAaz64LJGbp2J1UlkmtPCri-puiMax-hNeJU8r0gRV10CW9MHmLChnALNodzooAOUTOFAy6PKUqNFdYN23xw34j-ZAFw1zn3BsLPKd-LLLbKocUo9fj-PPV-FJIoNLxhfx2JVQVHXfkY4F98Ct0XHr4hRSV6OJ8N065R7pVw&zp=d-QDnbLaoyIa67ZnYp2uw5OdjvCtbxhT8ezdOEXPg8m7qhJZZPjxUiCZmIxOeH5BPTikWlPGNEK7O05EnhDcm3WiSLGuJIrOU4VsIjtt80lALQdV4iYuw0L8lRIsgSeDICQZLSbXpVCbMgl9mx-1lgHrDEiulWy5q877mnFXzrxXXsb7Lpxr9kV7PVXge9Qq_emalolfNBoXy5IB1PEDtbIttzQc5m36YHcYJFuqZ3LEnhNAUH_ey1mWR8p6BKFsKEfe2f0gkgma_R9kHEcy0cxpDA-Icgo1XUuWrweeRlX9Sosh0iz0H2mzJnknaULh7Nq4smhagoDxxBpdLJD59EoeBwOrM7oxP3BqGHuYioZzqTnD6W-drbbY_gftohnM9p9sHum2l-TBm4CuLakaQ3hrS1Az8PPFM0J-Yf0LhafT1UAOgSjhRJx3Oyn3MbLkW6TfwUTPLmNKmQEqRvPy-fIeRWZ02CgJSkKteFL96JHBE3W1IrDTERAov7tHx1v5Hlt_4dFxNF6e5PXKmlQtrXenO3MHFXhHrDjwxJOD03fShj4)
Collapse video player
0:00 / 0:00
Sort by:Top (Default)
Search CommentsExpand comment search
Comments Section
[Few_Raisin_8981](https://www.reddit.com/user/Few_Raisin_8981/)
•[3d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p057vks/)
Maybe it's just done with you?
ReplyShare
[ocean_protocol](https://www.reddit.com/user/ocean_protocol/)
•[3d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p08c3hp/)
Post-action verification against the source of truth is the only thing that actually works, trace/eval/guardrails all check the agent's story, not reality. Concretely: after any state-changing action, do a read-back call to confirm the actual state (refund shows in billing, ticket status changed), not just "did the call return 200." Treat the write and the verify as two separate steps, never trust completion claims from the same context that made the claim
ReplyShare
[ApprehensiveCar6879](https://www.reddit.com/user/ApprehensiveCar6879/)
•[2d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p0avj29/)
"Write and verify as two separate steps, never trust the claim from the same context that made it." That's the whole game in one line.
ReplyShare
[Mack-3rdShiftRnD](https://www.reddit.com/user/Mack-3rdShiftRnD/)
•[3d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p0aly40/)
build component
"show me"
*adversarial red team and fixes, different agent*
back to original
"what changed?"
back to other agent
"integrate this along spec'd seam"
*have spec'd seam*
ReplyShare
[AutoModerator](https://www.reddit.com/user/AutoModerator/)
•[3d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p03qoas/)
Thank you for your submission! To keep our community healthy, please ensure you've followed our rules.

* New to the sub? Check out our [Wiki](https://www.reddit.com/r/AgentsOfAI/wiki/index) (We are actively adding resources).
* Join the Discord: [Click here to join our Discord](https://discord.gg/NHBSGxqxjn)
* Join X community: [Click here to join our X Community](https://x.com/i/communities/1995275708885799256)

I am a bot, and this action was performed automatically. Please [contact the moderators of this subreddit](https://www.reddit.com/message/compose/?to=/r/AgentsOfAI) if you have any questions or concerns.
ReplyShare
[manjit-johal](https://www.reddit.com/user/manjit-johal/)
•[3d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p0871rr/)
This has definitely burned us before. One thing we learned while building Kritmatta is that "task completed" and "state changed" are completely different signals. We now treat the agent's output as a claim that needs verification, not as evidence that the workflow actually succeeded.
ReplyShare
[ApprehensiveCar6879](https://www.reddit.com/user/ApprehensiveCar6879/)
•[2d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p0av4q6/)
This is the exact distinction most people skip, "completed" and "state changed" are not the same signal. Well put. Sent you a DM.
ReplyShare
[u/microsoft365](https://www.reddit.com/user/microsoft365/)•[Ad](https://www.reddit.com/user/microsoft365/)
[Get insights in an instant with Copilot in Excel. Try Copilot in the apps you know.](https://alb.reddit.com/cr?za=BRQqflaly0kpEXIky6nRNHuRACgpyeYoXJdE5SFl7_aV60yhfFZjOs4kkeKdWKaBqmYEpRHtG4EQIlnFasqLET0E314ZGBLR58nDjjRTSV8eswE3871g_DEjIvv6Pm4_sH5A_be87u0syxdU23GnayYn-PtnQ4wRC6jJYUFHAkltNva_Eaqn8P7NMuEOpZ9GqSCYl57CbPpEqynCSFSAdABM-XsYFOQAP_zKn7ge-I1fHB4J3qvIYYg6r3vGD8s8SD9HA2824Y1y9qLjg-KwiwM9ssN50-HSfjq5tTUnbwAyrclYs26jIQCiIrvpcSBjX9EMx4Ftn6EX57s6hUFIxe4ye7HMPam7masZdQOjbyJ8PZRT-Sldk9AAi-DsbS-yRducVuR25o9I_aOJ7ldkDORGN0O5kk6ru3B2EO-kyQx89kNJvvF0MKMes2buCpVp4mxAtem0kV9UVYwqc5AnopmjEOHvpDPXu3sre8WmrTOBqHkqczA3yktax9GzG0UW9qHgGI1CLAdScDFUzsyBm8fCbxSXNOBGxla55faAtb6GIIFqzdtgwRlUeP2kh67pN5jniPokY7p6CVkjJHx9xfWpkdP5oPWFvKqKRw3iOgtI2pry3HkPhW3yta45EdwVyI_prbJchxjrdBErgzJSSAfzMaIRi9oTJ-OuqY-70luUW2eXFjqwY0PHpD8q11_mCGh7vUigzBUKLBEu7u27tiJOml2AE4WpvSjhOg3OpoL-3IB-tg_xhrEvOdSHB6gAbloY&zp=rMy3jR1PpLPUdMdc6dIPE5tPU3SkUPHz80zVDm-txy5lpif-H3yHwA8_MHn8oGfF59J-KWADFDQlYUZDuKbLhyc4BQ6dcQ4T-sB_JS3LOGGVs618hGWl4S82BLjG50fCFsMP3NEqXqPQrdtUoexPrwKALQUMc5j1MmW9cJVehIKQDDPwLLySUvtHQCTvlBuf-4yEOGuoVA6in5uaJl2dNK7ao7IR-2aVZ1_M2-GMeZpI0RB_hR4bILUUQucEmm0cCM_7AaEaW1As7pRIxj4IWOYxu8O3bbrhFI2GZcGe6aBB7EFZD_g5g4-32YmZokgkGQV8q_R18ilp7eOXg4nz_gO_54L4Q8VT8eZ7MwhOE3C-_cLdQPDN9KRXACx30ODm2xj8eqWLwkjnBy0nu6FVbSUE_TF7hdtWhEu-qW0fGI33vtTAT-cPjOQfDVpoLFTXFQci3sLUgdBP2uWKglM6_7n0pFaaznYkR7ULxXFoSvpu5hA)
[Learn More](https://alb.reddit.com/cr?za=BRQqflaly0kpEXIky6nRNHuRACgpyeYoXJdE5SFl7_aV60yhfFZjOs4kkeKdWKaBqmYEpRHtG4EQIlnFasqLET0E314ZGBLR58nDjjRTSV8eswE3871g_DEjIvv6Pm4_sH5A_be87u0syxdU23GnayYn-PtnQ4wRC6jJYUFHAkltNva_Eaqn8P7NMuEOpZ9GqSCYl57CbPpEqynCSFSAdABM-XsYFOQAP_zKn7ge-I1fHB4J3qvIYYg6r3vGD8s8SD9HA2824Y1y9qLjg-KwiwM9ssN50-HSfjq5tTUnbwAyrclYs26jIQCiIrvpcSBjX9EMx4Ftn6EX57s6hUFIxe4ye7HMPam7masZdQOjbyJ8PZRT-Sldk9AAi-DsbS-yRducVuR25o9I_aOJ7ldkDORGN0O5kk6ru3B2EO-kyQx89kNJvvF0MKMes2buCpVp4mxAtem0kV9UVYwqc5AnopmjEOHvpDPXu3sre8WmrTOBqHkqczA3yktax9GzG0UW9qHgGI1CLAdScDFUzsyBm8fCbxSXNOBGxla55faAtb6GIIFqzdtgwRlUeP2kh67pN5jniPokY7p6CVkjJHx9xfWpkdP5oPWFvKqKRw3iOgtI2pry3HkPhW3yta45EdwVyI_prbJchxjrdBErgzJSSAfzMaIRi9oTJ-OuqY-70luUW2eXFjqwY0PHpD8q11_mCGh7vUigzBUKLBEu7u27tiJOml2AE4WpvSjhOg3OpoL-3IB-tg_xhrEvOdSHB6gAbloY&zp=rMy3jR1PpLPUdMdc6dIPE5tPU3SkUPHz80zVDm-txy5lpif-H3yHwA8_MHn8oGfF59J-KWADFDQlYUZDuKbLhyc4BQ6dcQ4T-sB_JS3LOGGVs618hGWl4S82BLjG50fCFsMP3NEqXqPQrdtUoexPrwKALQUMc5j1MmW9cJVehIKQDDPwLLySUvtHQCTvlBuf-4yEOGuoVA6in5uaJl2dNK7ao7IR-2aVZ1_M2-GMeZpI0RB_hR4bILUUQucEmm0cCM_7AaEaW1As7pRIxj4IWOYxu8O3bbrhFI2GZcGe6aBB7EFZD_g5g4-32YmZokgkGQV8q_R18ilp7eOXg4nz_gO_54L4Q8VT8eZ7MwhOE3C-_cLdQPDN9KRXACx30ODm2xj8eqWLwkjnBy0nu6FVbSUE_TF7hdtWhEu-qW0fGI33vtTAT-cPjOQfDVpoLFTXFQci3sLUgdBP2uWKglM6_7n0pFaaznYkR7ULxXFoSvpu5hA)
[m365copilot.com](https://alb.reddit.com/cr?za=BRQqflaly0kpEXIky6nRNHuRACgpyeYoXJdE5SFl7_aV60yhfFZjOs4kkeKdWKaBqmYEpRHtG4EQIlnFasqLET0E314ZGBLR58nDjjRTSV8eswE3871g_DEjIvv6Pm4_sH5A_be87u0syxdU23GnayYn-PtnQ4wRC6jJYUFHAkltNva_Eaqn8P7NMuEOpZ9GqSCYl57CbPpEqynCSFSAdABM-XsYFOQAP_zKn7ge-I1fHB4J3qvIYYg6r3vGD8s8SD9HA2824Y1y9qLjg-KwiwM9ssN50-HSfjq5tTUnbwAyrclYs26jIQCiIrvpcSBjX9EMx4Ftn6EX57s6hUFIxe4ye7HMPam7masZdQOjbyJ8PZRT-Sldk9AAi-DsbS-yRducVuR25o9I_aOJ7ldkDORGN0O5kk6ru3B2EO-kyQx89kNJvvF0MKMes2buCpVp4mxAtem0kV9UVYwqc5AnopmjEOHvpDPXu3sre8WmrTOBqHkqczA3yktax9GzG0UW9qHgGI1CLAdScDFUzsyBm8fCbxSXNOBGxla55faAtb6GIIFqzdtgwRlUeP2kh67pN5jniPokY7p6CVkjJHx9xfWpkdP5oPWFvKqKRw3iOgtI2pry3HkPhW3yta45EdwVyI_prbJchxjrdBErgzJSSAfzMaIRi9oTJ-OuqY-70luUW2eXFjqwY0PHpD8q11_mCGh7vUigzBUKLBEu7u27tiJOml2AE4WpvSjhOg3OpoL-3IB-tg_xhrEvOdSHB6gAbloY&zp=rMy3jR1PpLPUdMdc6dIPE5tPU3SkUPHz80zVDm-txy5lpif-H3yHwA8_MHn8oGfF59J-KWADFDQlYUZDuKbLhyc4BQ6dcQ4T-sB_JS3LOGGVs618hGWl4S82BLjG50fCFsMP3NEqXqPQrdtUoexPrwKALQUMc5j1MmW9cJVehIKQDDPwLLySUvtHQCTvlBuf-4yEOGuoVA6in5uaJl2dNK7ao7IR-2aVZ1_M2-GMeZpI0RB_hR4bILUUQucEmm0cCM_7AaEaW1As7pRIxj4IWOYxu8O3bbrhFI2GZcGe6aBB7EFZD_g5g4-32YmZokgkGQV8q_R18ilp7eOXg4nz_gO_54L4Q8VT8eZ7MwhOE3C-_cLdQPDN9KRXACx30ODm2xj8eqWLwkjnBy0nu6FVbSUE_TF7hdtWhEu-qW0fGI33vtTAT-cPjOQfDVpoLFTXFQci3sLUgdBP2uWKglM6_7n0pFaaznYkR7ULxXFoSvpu5hA)
Collapse video player
0:00 / 0:00
[ticktockbent](https://www.reddit.com/user/ticktockbent/)
•[3d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p08eo1z/)
Build in acceptance criteria, require a tool use receipt for completion. I don't know how your system works but anchor the agent's "done" on something that isn't vibes
ReplyShare
[ApprehensiveCar6879](https://www.reddit.com/user/ApprehensiveCar6879/)
•[2d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p0b1kji/)
Anchoring "done" on a receipt instead of vibes, exactly right.
ReplyShare
[bithatchling](https://www.reddit.com/user/bithatchling/)
•[3d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p09qws6/)
This is such a common pain point. Relying on the trace is basically trusting the agent's diary. I've found that adding a mandatory 'verification' step—where the agent must call a read-only tool to confirm the state change—is the only way to stop those silent no-ops.
ReplyShare
[ApprehensiveCar6879](https://www.reddit.com/user/ApprehensiveCar6879/)
•[2d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p0awylp/)
"Trusting the agent's diary" is the best description of this problem I've seen. Stealing that.
ReplyShare
[donk8r](https://www.reddit.com/user/donk8r/)
•[3d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p03xe49/)
You've named the category better than most tooling does. Everything you listed sits on the agent's side of the boundary, so the trace is testimony rather than evidence. What's missing isn't observability, it's reconciliation.
The cheapest thing that actually works is making every write tool return a read-back instead of a status. Don't trust the 200, re-fetch the record and assert the field you expected to change, then let the tool result carry the fetched state rather than the model's summary of it. That's one extra call per write, and it collapses "agent says it issued a refund" into "billing says refund X exists for amount Y". Most silent no-ops die right there.
Where it stops working is async writes that aren't visible yet, and side effects with no read path at all, email being the obvious one. Those need a delayed reconciliation pass against the source of truth rather than inline verification. More annoying to build, but at least it's a known shape.
Worth saying we have the same gap on our side. Our session logs are append only and complete, and they're still only the agent's account of its own actions, which is precisely the thing you can't verify with. Reading back from the system of record is the only part of the loop that isn't self reported.
ReplyShare
[ApprehensiveCar6879](https://www.reddit.com/user/ApprehensiveCar6879/)
•[2d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p0aw0z7/)
Clearest read in the thread, "reconciliation, not observability" is exactly it. And real respect for calling out your own logs, most people won't admit the append-only log is still the agent narrating itself. Sent you a DM.
ReplyShare
[ApprehensiveCar6879](https://www.reddit.com/user/ApprehensiveCar6879/)
•[2d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p0awi8e/)
Oops can't DM.
ReplyShare
[donk8r](https://www.reddit.com/user/donk8r/)
•[2d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p0azult/)
Nothing has landed in my inbox, so it may not have gone through. Happy to just carry on here, and honestly public is better for this one, someone else gets to tell us we are both wrong.
ReplyShare
[Shape_Weird](https://www.reddit.com/user/Shape_Weird/)
•[2d ago](https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/comment/p0bsrhg/)
the sharpest version of this i have hit is that the verification step can be testimony too, and it is very easy to build one that is.
we submit job applications on the employer's real ATS, so there is no cheap retry and no source of truth we own. the first verifier i wrote matched a confirmation element in the DOM. it worked. then i found that on one platform the same node renders on a validation failure as well, because the "thanks, we got it" panel and the "fix these fields" panel are the same component in two states. so the check returned true exactly in the case where i most needed a false. that is worse than having no check, because it converts an unknown into a confident wrong answer.
the rule i took out of it: evidence has to be something the other side produced that you could not have produced yourself. our own click is not evidence. our own rendering of their page is barely evidence. an id they minted, an email they sent, a network response they returned, those are evidence.
the one that took me longest, and it is the exact inverse of your point: absence of error is not evidence either. we count how many POSTs actually left the browser during a run. when that count is zero it means no request ever reached them, which means no server ever refused anything, which means "no errors in this run" is describing a run in which nothing happened. for a long time that read as a clean run in our own logs. a clean run and a run where the network never fired look identical if the only thing you record is failures.
so nothing in our system is allowed to say applied. it may say it clicked submit. applied requires confirmation we did not generate, and when we cannot get it the answer is pending, which is a state we return often and deliberately made easier to earn than applied. the number i watch is errors, because a tool that never reports one is not a tool that never fails.
[disclosure: i build one of these, so this is my own scar tissue rather than a survey]
ReplyShare

## Assistant

<routes ref="em:01abda">
The full thread carried something the excerpt didn't, and it made the plan smaller rather than bigger: it supplied a test that one of my own proposed checks fails.

The excerpt was one commenter's (u/ocean_protocol) prescription. A different commenter, u/Shape_Weird, gives the rule that constrains it — **evidence has to be something the other side produced that you could not have produced yourself**, learned from a verifier that matched a confirmation element in a page, until it turned out the same component renders for "thanks, we got it" and "fix these fields": *"the check returned true exactly in the case where i most needed a false. that is worse than having no check, because it converts an unknown into a confident wrong answer."*
</routes>

<routes ref="em:01abda /meta/plans/post-action-readback-in-the-development-flow.md">
Run that test over my six proposed read-backs and five pass — a remote ref advertisement, a PR record, a GitHub-minted merge SHA, a branch list, a runner's job conclusion are all things the other side produced. The sixth fails. I had proposed that `/capture` re-read the thread doc it just wrote and compare the tail against the session's last delivered block. But the thread doc is a file this session wrote from its own context, so the check cannot fail in the case it exists for — a capture that silently dropped exchanges is absent from both the render *and* the reader. u/donk8r says the same thing about his own product in the thread, and it lands directly on this brain's record layer:

> "Our session logs are append only and complete, and they're still only the agent's account of its own actions, which is precisely the thing you can't verify with."

So capture fidelity has no available oracle here — the transcript is the only authority and the contract already notes the `session:` URL is *"unreadable by agents"*. The plan now proposes vocabulary instead of a check: report the thread doc as **written**, never as **faithful**, and say which is meant. That settles an open question I'd left on cost grounds, on principle instead.
</routes>

<routes ref="/meta/plans/post-action-readback-in-the-development-flow.md">
Two more things the thread changed:

**A run that never fires cannot read itself back.** donk8r bounds the pattern — *"side effects with no read path at all… need a delayed reconciliation pass"* — and that's precisely the `/research` Routine's observed failure. My in-run check would catch fire-and-fail; it structurally cannot catch never-fire. So the plan pairs it with an out-of-run line in `session_init`, and asks a *positive* question ("is today's digest on `origin/main`?") rather than an error-absence one. Shape_Weird's zero-POST case is why: *"a clean run and a run where the network never fired look identical if the only thing you record is failures."*

**The third outcome.** Their system is never allowed to say *applied* — it may say *clicked submit*; unconfirmed is *pending*, "deliberately made easier to earn than applied." That maps onto the work-report ledger's result column, and the reason it must be *easy* to reach is the interesting half: a grudging middle value collapses back to two.
</routes>

<routes ref="em:01abda">
One caveat on the thread as evidence: u/ApprehensiveCar6879 replies approvingly to nearly every top-level comment and solicits DMs, so the apparent consensus is four practitioners, not eight. That's in the belief's provenance.
</routes>

### What I created

| type | doc | why this type |
|---|---|---|
| `belief` | [Only what the other side produced is evidence](https://github.com/ob6to8/elixir-mind/blob/claude/post-action-verification-plan-pl9vqy/beliefs/only-what-the-other-side-produced-is-evidence.md) — `em:01abda` | a different author's different rule, not a conjunct of `em:674c8f` — so filed separately rather than folded in. Carries `depends_on: [em:674c8f]` |

### What I modified

| file | thrust |
|---|---|
| `beliefs/completion-claims-…md` (`em:674c8f`) | attribution corrected to u/ocean_protocol's comment; OP's framing quoted where sharper ("a clean run just means it stopped running"; guardrails run *before* the action and so cannot answer a post-action question); donk8r's tool-boundary implementation and read-path limits added |
| `meta/plans/post-action-readback-…md` | evidence test applied as a table; `/capture` check removed and demoted to vocabulary; no-read-path section added; `session_init` reconciliation line folded into P2; open question 2 struck as settled |
| `beliefs/index.md`, `meta/plans/index.md`, `meta/registry.md` | glosses and regenerated registry |

### Actions I have taken

| action | result |
|---|---|
| Gate subset + pre-commit hook (full suite, 188 tests) | green; same two pre-existing editorial warnings, plus the expected `from` warning on the new plan |
| Commit + push | `fed5dba`; read back against `git ls-remote` — remote ref matches local HEAD |

### Questions you need to answer

| # | question | my recommendation |
|---|---|---|
| 1 | Two beliefs where you asked for one. `em:01abda` is a separate author's separate rule and it changed the plan's output, but it's still a mint I made without asking. Keep both, or fold it into `em:674c8f`? | **Keep both.** Folding would make `em:674c8f` a four-conjunct compound, which is what [`/extract-into-belief`](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/extract-into-belief-skill.md) exists to undo |
| 2 | Does the third state (`unverified — <reason>`) belong in the new policy, or as an amendment to [response-work-report-format](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/response-work-report-format.md)? | **The work-report policy.** It's a column value in a table that policy owns; putting it in the read-back policy splits the ledger's spec across two files |

Still open from earlier: whether "proto-belief" meant the full `type: belief` I filed (the existing glossary term `em:573229` means something unrelated — a per-topic sink doc).

## User

1 - keep both
2 - agree
yes full type belieef

/intake the reddit link and include the verbatim thread per my paste. cross link to the documents that were authored here

## Assistant

<routes ref="em:b01e03">
Filed. The thread now lives in the bundle as a verbatim `type: source` capture, following the pattern the ISNAD thread set one directory over — post and comments reproduced as pasted, usernames and relative timestamps intact, with a note on what was stripped.

Keeping the full text is load-bearing here rather than a default indulgence. Reddit returns 403 to unauthenticated reads over every route tried, so a reader following the `resource` URL hits a login wall — this capture is the only reachable copy, which is precisely the case [link-processing](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/link-processing.md) carves out for persisting the text alongside the link.

**Directory call.** I created `knowledge/SWE/agentic/action-verification/`. Confirming an agent's actions landed is a different question from [provenance](https://github.com/ob6to8/elixir-mind/blob/main/knowledge/SWE/agentic/provenance/index.md) (grading *claims* moving through a pipeline) and from evals (scoring output quality) — and the thread's own argument is that the eval layer structurally cannot answer it. Subdirectories under an established top-level are autonomous under the taxonomy protocol, so I made the call rather than blocking; the naming is reversible if you'd rather it sat in `agentic-loop/`.

**Cross-links go both ways.** The capture points forward to `em:674c8f`, `em:01abda`, and the plan, naming which commenter each prior came from; those three, plus the new directory index, point back. It also notes the sibling ISNAD thread — same subreddit, same week, opening on the same silent-failure observation but answering it at the claim layer rather than the action layer.

The capture closes with a short reading note on the thread as evidence: four practitioners contribute substantive positions, three of whom disclose building in the space, and one account replies approvingly to nearly every top-level comment while soliciting DMs — so the apparent breadth of agreement is smaller than the comment count.
</routes>

### What I created

| type | doc | why this type |
|---|---|---|
| `source` | [Reddit thread — "Your agent says 'done.'…"](https://github.com/ob6to8/elixir-mind/blob/claude/post-action-verification-plan-pl9vqy/knowledge/SWE/agentic/action-verification/agent-says-done-reddit-discussion-thread.md) — `em:b01e03` | primary-source citation held verbatim; the distillation already exists as the two beliefs, so no separate `reference` — that would fragment one matter across two docs |
| — | `knowledge/SWE/agentic/action-verification/index.md` | reserved listing for the new directory |

### What I modified

| file | thrust |
|---|---|
| `knowledge/SWE/agentic/index.md` | subdirectory gloss |
| `meta/evals/dedup-probe.md` | gold row harvested from your phrasing + refreshed baseline |
| `meta/registry.md` | regenerated for `em:b01e03` |

### Actions I have taken

| action | result |
|---|---|
| Dedup search before writing (8 synonym-expanded phrasings across `knowledge/`, `survey/`, `inbox/`) | no existing doc — created new rather than merged |
| Dedup probe, first run | **the new gold row missed both modes.** Its variants were sentence-length where every other row uses short noun phrases — miscalibrated as *input*, not as difficulty. Reshaped to `silent no-op; read-back; post-action verification; agent's story not reality` |
| Dedup probe, after reshape | expanded **20/23**, plain **8/23**. Plain hit count unchanged → no regression. The row still misses plain, correctly: the natural full-sentence query doesn't substring-match a title carrying `'done.'` in quotes — that gap is the signal the probe exists to measure |
| Gate subset + pre-commit hook (188 tests) | green; same two pre-existing editorial warnings, plus the expected `from` warning on the new plan |
| Commit + push | `78ba027`; read back against `git ls-remote` — remote ref matches local HEAD |

Nothing is blocking. The branch now carries the two beliefs, the plan, and the source capture; the plan itself stays `proposed` until you ratify P1.

## User

<command-message>create-pull-request</command-message>
<command-name>/create-pull-request</command-name>
<command-args>merge</command-args>

## Assistant

I caught something before running `/capture`: every document I filed this session is dated **2026-07-29**, but the actual date — confirmed by `date -u` and by every commit's real git timestamp — is **2026-07-31**. I mis-set `timestamp`/`attribution.when` at the start of the session and carried the error through four files and a dedup gold row. Fixing it now, before capture freezes it into the thread doc and the commit history.

## Assistant

Real bug found: my "date fix" over-corrected. `attribution.when` is write-once by policy — it must record the original filing event, not the latest edit. The session log proves `em:674c8f` and the plan were genuinely first committed **2026-07-29T20:24:35Z**; only `em:01abda` and the source capture were genuinely minted on 07-31. My blanket fix wrongly rewrote two immutable `attribution.when` fields. Reverting those precisely.
