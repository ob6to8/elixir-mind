---
id: em:9318af
type: source
title: "Reddit thread — \"~1,400 years ago, scholars solved a problem multi-agent AI just re-invented\" (r/AgentsOfAI)"
description: Verbatim capture of the ISNAD author's announcement post and its full comment thread on r/AgentsOfAI, 2026-07-29 — the primary source for the rijāl-grading and chain-independence critiques cited by the ISNAD reference.
resource: https://www.reddit.com/r/AgentsOfAI/comments/1v9qe4p/1400_years_ago_scholars_solved_a_problem/
provenance: "Page text pasted by the operator, 2026-07-29; author of the post is alizahidrajaa (Ali Zahid Raja)"
tags: [provenance, trust, multi-agent, isnad, discussion-thread, primary-source]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T17:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "persist the reddit thread verbatim"
---

# Reddit thread — "~1,400 years ago, scholars solved a problem multi-agent AI just re-invented"

Verbatim capture of the post and all comments as pasted 2026-07-29 (post ~8h
old at capture; score 29 upvotes / 14 downvotes). Stripped from the paste:
two interleaved advertisements (DIRECTV, Mozart Studio) with their tracking
URLs, and Reddit page chrome (sort controls, "Reply/Share" button labels).
Comment text, usernames, and relative timestamps are reproduced verbatim.
Supports the distilled capture in
[isnad-rijal-claim-level-provenance](/knowledge/SWE/agentic/provenance/isnad-rijal-claim-level-provenance.md).

## Post — by alizahidrajaa

> ~1,400 years ago, scholars solved a problem multi-agent AI just re-invented.
> I rebuilt their method and put it on arXiv.
>
> Author here. This one started as a weird idea and turned into a paper +
> open-source release, so I'm sharing the story.
>
> Modern agent pipelines have a silent-failure problem. An answer passes
> through a scraper, an extractor, several models, a synthesizer — and when
> one link is unreliable, the failure doesn't announce itself. You get a
> fluent, confident answer that's quietly wrong. Everyone's building to verify
> the agent — identity, permissions, access. Barely anyone's verifying the
> claim.
>
> The verification-of-transmitted-knowledge problem was rigorously solved a
> long time ago. Islamic scholars couldn't trust a statement just because it
> sounded right, so they built one of history's most demanding systems for it:
> every claim carries its full chain of transmitters (isnād), every
> transmitter is graded on integrity and precision (rijāl), the chain is only
> as strong as its weakest link, independent chains raise confidence, and even
> a flawless chain doesn't excuse a flawed message.
>
> The rigor belongs to twelve centuries of scholars. The transfer to AI is
> mine. I call it ISNAD — a claim-level trust layer for multi-agent systems.
> Everyone verifies the agent; ISNAD verifies the claim.
>
> I also wrote the failures into the paper — what's validated, what isn't yet,
> in detail. A trust framework that hides its weaknesses is a contradiction in
> terms.
>
> If it makes you think — agree or disagree — I want to hear it.

## Comments

**ZioniteSoldier** · 8h ago

> I love these projects that take old human concepts and make them an agentic
> system.
> Any way to show an example A/B comparison on non-verified vs your loop
> output? I'm curious on how it adjusts the trajectory.

**donk8r** · 6h ago

> The transfer is cleaner than most of these, but rijāl is the part I would
> worry about. Grading transmitters works because a transmitter is a
> persistent identity accumulating a track record over decades. In a pipeline
> the transmitter is a model call, and reliability there is not a property of
> the model, it is a property of the model plus the task type plus whatever
> was in context at the time. Grade at the model level and you get a number
> that is stable and says nothing.
>
> Corroboration has a harder version of the same problem. Independent chains
> raising confidence assumes independence you can establish. Two chains routed
> through the same base model are not independent even when the agents and
> prompts differ, so correlated error arrives looking exactly like agreement.
> The transmitters in the original system were actually separate people. Here
> separation has to be proven, and usually it is not there.
>
> Neither of those kills it. But the grading unit probably needs to be
> narrower than an agent, and corroboration needs a stated definition of what
> makes a chain independent, or weakest-link is the only half of the method
> that survives the transfer intact.

**Lonely_Drewbear** · 1h ago (replying to donk8r)

> Could you grade using the model's benchmark score for a certain task type or
> tool use?  I feel like a tiny classifier model could be easily fine tuned to
> do this cheaply.

**donk8r** · 45m ago (replying to Lonely_Drewbear)

> per-task-type beats a flat model grade, yeah. what it still won't tell you
> is anything about this particular transmission. 85% on a task type means the
> chain has no idea whether it's sitting in the 85 or the 15, and the original
> system was grading individuals on observed instances rather than on a prior.
>
> a fine tuned classifier has the same shape, another model predicting from
> roughly the same distribution, so it agrees with the thing it's supposed to
> be checking more often than it should.
>
> closer thing would be scoring a transmitter on how often its claims survived
> independent checking inside your own pipeline. slow to accumulate but at
> least it's about them.

**alizahidrajaa** (author) · 8h ago

> Code: https://github.com/alizahidraja/isnad
> Paper: https://arxiv.org/abs/2607.24117

**LumpyWelds** · 6h ago

> This is like a combo of Chain-of-Custody/Blockchain with PGP's trust
> ratings. I like it.
>
> But for me the most interesting part was:
>
> "A case study in which a prototype self-maintaining knowledge base surfaced
> 19 genuine cross-framework contradictions in undergraduate physics texts,
> demonstrating the matn-criticism substrate"
>
> Once I read that, I realized how useful this is and what your project can
> do.

**philip_laureano** · 5h ago

> In theory, this sounds good, but without an actual controlled A/B test,
> it'll remain theoretical.
>
> Have you asked Fable 5 or GPT 5.6 Sol to write you an eval for it yet?
>
> Once you have a running version of it, you can have them do all the A/B
> testing for you. It's amazing to watch

**AutoModerator** · 8h ago

> Thank you for your submission! To keep our community healthy, please ensure
> you've followed our rules.
>
> * New to the sub? Check out our Wiki (We are actively adding resources).
> * Join the Discord: Click here to join our Discord
> * Join X community: Click here to join our X Community
>
> I am a bot, and this action was performed automatically. Please contact the
> moderators of this subreddit if you have any questions or concerns.

**TheRaiff1982JH** · 7h ago

> I agree — an A/B test is the clearest way to demonstrate the effect. In the
> unverified baseline, a single weak agent can propagate error downstream; in
> the verified pipeline, claim-level checks expose unsupported transitions and
> force the synthesis step to revise or discard them.
>
> So the improvement isn't only accuracy, it's trajectory control and error
> containment, I love how ideas are finally converging to the same things,
> just in different ways they're explained. check it out
> https://doi.org/10.21203/rs.3.rs-9362560/v1
> https://github.com/Raiff1982/Codette-Reasoning they're complementary in
> incredible ways

**ocean_protocol** · 6h ago

> Genuinely good analogy, isnad maps onto claim provenance almost too cleanly
> (weakest-link-in-the-chain, corroboration via independent chains, grading
> transmitters on reliability). That last part is the one people usually miss
> when they build "trust layers" for agent pipelines: they check the agent's
> permissions/identity, not the actual claim's lineage through the pipeline
>
> Curious how you're handling the equivalent of rijal grading in practice, in
> hadith science that's built on centuries of biographical scholarship on
> individual transmitters. What's the AI-pipeline equivalent of a
> transmitter's track record? Per-model reliability score based on past claim
> accuracy, or something else?

**NimaraVentures** · 6h ago

> solid point, ngl. everyone's locked in on agent-level trust and nobody's
> asking if the claim itself is even true after it bounces through five
> different scrapers and summarizers. isnad thing checks out too, weakest link
> in the chain breaks the whole chain, same deal with pipelines.
>
> only thing I'd ask: humans built trust in a narrator over years. how you
> score that for a model that can act different depending on context or just
> gets updated overnight. does the paper touch on that or is that one of the
> gaps you flagged. either way props for putting the failure modes out front,
> most of these trust papers act like nothing can go wrong.

**hypnotizedent** · 5h ago

> Peace and blessings. I was working on a similar project for preserving
> knowledge. Thank you for sharing.

**rand3289** · 1h ago (edited 32m ago)

> There is not enough information in the post to understand what your system
> does.

**sixwax** · 13m ago

> Another modern analog is references/sources in academic papers, fwiw.
>
> Use case matters. Are we talking about factual claims or "whether the agent
> did its job"
