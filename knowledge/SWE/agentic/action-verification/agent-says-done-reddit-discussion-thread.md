---
id: em:b01e03
type: source
title: "Reddit thread — \"Your agent says 'done.' You check and nothing actually happened.\" (r/AgentsOfAI)"
description: Verbatim capture of the post and its full comment thread on r/AgentsOfAI — practitioners on silent agent no-ops, why traces/evals/guardrails cannot detect them, and the read-back, receipt, and reconciliation patterns proposed against them.
resource: https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/your_agent_says_done_you_check_and_nothing/
provenance: "Page text pasted by the operator, 2026-07-31; the page cannot be fetched from this sandbox — Reddit returns HTTP 403 to unauthenticated reads over every route tried (WebFetch, direct curl to the .json endpoint, and a third-party reader service), so this capture is the only reachable copy. OP username not present in the paste"
tags: [verification, read-back, reconciliation, agent-output, observability, silent-failure, discussion-thread, primary-source]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to intake the reddit link with the verbatim thread and cross-link it to the beliefs and plan authored from it in the same session"
---

# Reddit thread — "Your agent says 'done.' You check and nothing actually happened."

Verbatim capture of the post and all comments as pasted 2026-07-31 (post ~3 days
old at capture per its own relative timestamps; score line rendered as
`Upvote8Downvote16`). Stripped from the
paste: two interleaved advertisements (The Atlantic, Microsoft 365) with their
tracking URLs, one AutoModerator boilerplate comment, and Reddit page chrome
(flair link, sort controls, collapsed video-player rows, "Reply/Share" button
labels). Comment text, usernames, and relative timestamps are reproduced
verbatim.

**Read this alongside** the priors extracted from it, which carry the distilled
argument and are where the reasoning lives:

- [A completion claim is not evidence of completion](/beliefs/completion-claims-are-not-evidence-of-completion.md)
  (`em:674c8f`) — from u/ocean_protocol's read-back formulation and the OP's
  framing.
- [Only what the other side produced is evidence](/beliefs/only-what-the-other-side-produced-is-evidence.md)
  (`em:01abda`) — from u/Shape_Weird's account.
- [Post-action read-back: confirm state changes against the source of truth](/meta/plans/post-action-readback-in-the-development-flow.md) —
  the plan applying both to this repo's development flow.

Two related failure-mode captures sit nearby:
[scar-tissue behavioral drift](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md)
and, on the same subreddit and same week,
[the ISNAD thread](/knowledge/SWE/agentic/provenance/isnad-reddit-discussion-thread.md),
which opens on the same silent-failure observation and answers it at the claim
layer rather than the action layer.

## Post

> Your agent says "done." You check and nothing actually happened. Anyone else
> seeing this?
>
> Honestly what worries me about agents isn't a wrong answer, it's when they say
> they did something and didn't.
>
> Agent goes "done, refund issued." the run looks clean, no errors anywhere. then
> you check the system and there's nothing. no refund, ticket still open, but the
> session got marked resolved anyway.
>
> A clean run just means it stopped running. that's all. it doesn't mean the work
> actually happened. and "i did X" is basically free for a model to say. there's
> no penalty for being wrong, and it says it with the same confidence whether it
> worked or not.
>
> What's frustrating is the usual tools don't catch this. observability is just
> the trace, which is the agent telling its own story. so if a write silently
> no-ops or it skips a step, the trace still looks fine. evals check if the output
> sounds right. guardrails run before the action anyway. none of them answer the
> only thing that really matters after the fact: did reality match what it
> claimed?
>
> If you're doing codegen, it's easier. rerun the test or check the diff and you
> know. but anything that touches real systems is where it breaks. issuing a
> refund in your billing system, updating a CRM field, provisioning something,
> moving a ticket, actually sending the email. there's no cheap retry to verify
> any of that. you either reconcile it manually against the source of truth, or
> trust it and find out three days later from an angry customer.
>
> So curious how people are handling this in practice. if your agents are taking
> real actions across systems, how are you verifying they actually landed? manual
> checks, reconciliation scripts, or just trusting the trace?
>
> And has a silent fake "done" burned you before? agent completely sure it did the
> job, system of record saying otherwise.
>
> Asking partly because I'm building in this space, so yeah, I'm biased. but
> mostly trying to understand if this is as common as it feels, or if I'm just
> over-indexing on my own experience. would be great to compare notes with anyone
> dealing with this on real systems.

## Comments

**Few_Raisin_8981** · 3d ago

> Maybe it's just done with you?

**ocean_protocol** · 3d ago

> Post-action verification against the source of truth is the only thing that
> actually works, trace/eval/guardrails all check the agent's story, not reality.
> Concretely: after any state-changing action, do a read-back call to confirm the
> actual state (refund shows in billing, ticket status changed), not just "did the
> call return 200." Treat the write and the verify as two separate steps, never
> trust completion claims from the same context that made the claim

**ApprehensiveCar6879** · 2d ago (replying to ocean_protocol)

> "Write and verify as two separate steps, never trust the claim from the same
> context that made it." That's the whole game in one line.

**Mack-3rdShiftRnD** · 3d ago

> build component
>
> "show me"
>
> \*adversarial red team and fixes, different agent\*
>
> back to original
>
> "what changed?"
>
> back to other agent
>
> "integrate this along spec'd seam"
>
> \*have spec'd seam\*

**manjit-johal** · 3d ago

> This has definitely burned us before. One thing we learned while building
> Kritmatta is that "task completed" and "state changed" are completely different
> signals. We now treat the agent's output as a claim that needs verification, not
> as evidence that the workflow actually succeeded.

**ApprehensiveCar6879** · 2d ago (replying to manjit-johal)

> This is the exact distinction most people skip, "completed" and "state changed"
> are not the same signal. Well put. Sent you a DM.

**ticktockbent** · 3d ago

> Build in acceptance criteria, require a tool use receipt for completion. I don't
> know how your system works but anchor the agent's "done" on something that isn't
> vibes

**ApprehensiveCar6879** · 2d ago (replying to ticktockbent)

> Anchoring "done" on a receipt instead of vibes, exactly right.

**bithatchling** · 3d ago

> This is such a common pain point. Relying on the trace is basically trusting the
> agent's diary. I've found that adding a mandatory 'verification' step—where the
> agent must call a read-only tool to confirm the state change—is the only way to
> stop those silent no-ops.

**ApprehensiveCar6879** · 2d ago (replying to bithatchling)

> "Trusting the agent's diary" is the best description of this problem I've seen.
> Stealing that.

**donk8r** · 3d ago

> You've named the category better than most tooling does. Everything you listed
> sits on the agent's side of the boundary, so the trace is testimony rather than
> evidence. What's missing isn't observability, it's reconciliation.
>
> The cheapest thing that actually works is making every write tool return a
> read-back instead of a status. Don't trust the 200, re-fetch the record and
> assert the field you expected to change, then let the tool result carry the
> fetched state rather than the model's summary of it. That's one extra call per
> write, and it collapses "agent says it issued a refund" into "billing says
> refund X exists for amount Y". Most silent no-ops die right there.
>
> Where it stops working is async writes that aren't visible yet, and side effects
> with no read path at all, email being the obvious one. Those need a delayed
> reconciliation pass against the source of truth rather than inline verification.
> More annoying to build, but at least it's a known shape.
>
> Worth saying we have the same gap on our side. Our session logs are append only
> and complete, and they're still only the agent's account of its own actions,
> which is precisely the thing you can't verify with. Reading back from the system
> of record is the only part of the loop that isn't self reported.

**ApprehensiveCar6879** · 2d ago (replying to donk8r)

> Clearest read in the thread, "reconciliation, not observability" is exactly it.
> And real respect for calling out your own logs, most people won't admit the
> append-only log is still the agent narrating itself. Sent you a DM.

**ApprehensiveCar6879** · 2d ago (replying to donk8r)

> Oops can't DM.

**donk8r** · 2d ago (replying to ApprehensiveCar6879)

> Nothing has landed in my inbox, so it may not have gone through. Happy to just
> carry on here, and honestly public is better for this one, someone else gets to
> tell us we are both wrong.

**Shape_Weird** · 2d ago

> the sharpest version of this i have hit is that the verification step can be
> testimony too, and it is very easy to build one that is.
>
> we submit job applications on the employer's real ATS, so there is no cheap
> retry and no source of truth we own. the first verifier i wrote matched a
> confirmation element in the DOM. it worked. then i found that on one platform
> the same node renders on a validation failure as well, because the "thanks, we
> got it" panel and the "fix these fields" panel are the same component in two
> states. so the check returned true exactly in the case where i most needed a
> false. that is worse than having no check, because it converts an unknown into a
> confident wrong answer.
>
> the rule i took out of it: evidence has to be something the other side produced
> that you could not have produced yourself. our own click is not evidence. our
> own rendering of their page is barely evidence. an id they minted, an email they
> sent, a network response they returned, those are evidence.
>
> the one that took me longest, and it is the exact inverse of your point: absence
> of error is not evidence either. we count how many POSTs actually left the
> browser during a run. when that count is zero it means no request ever reached
> them, which means no server ever refused anything, which means "no errors in
> this run" is describing a run in which nothing happened. for a long time that
> read as a clean run in our own logs. a clean run and a run where the network
> never fired look identical if the only thing you record is failures.
>
> so nothing in our system is allowed to say applied. it may say it clicked
> submit. applied requires confirmation we did not generate, and when we cannot
> get it the answer is pending, which is a state we return often and deliberately
> made easier to earn than applied. the number i watch is errors, because a tool
> that never reports one is not a tool that never fails.
>
> [disclosure: i build one of these, so this is my own scar tissue rather than a
> survey]

## Reading the thread as evidence

Four practitioners contribute substantive positions — the OP, u/donk8r,
u/Shape_Weird, and u/manjit-johal — with u/ocean_protocol, u/ticktockbent, and
u/bithatchling each adding one formulation. A single account
(u/ApprehensiveCar6879) replies approvingly to nearly every top-level comment and
solicits DMs twice, so the thread's apparent breadth of agreement is smaller than
its comment count suggests. Three of the substantive contributors disclose that
they build in the space; u/Shape_Weird marks the disclosure explicitly and frames
the account as "my own scar tissue rather than a survey."
