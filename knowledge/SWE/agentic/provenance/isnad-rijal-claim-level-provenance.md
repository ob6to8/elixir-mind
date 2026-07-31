---
id: em:c880d8
type: reference
title: "ISNAD — an isnād–rijāl framework for claim-level provenance in multi-agent systems"
description: A Python framework (paper + library, Ali Zahid Raja, arXiv:2607.24117) adapting classical hadith transmission science to AI pipelines — per-claim transmission chains, graded transmitters, weakest-link chain grading, independence-checked corroboration, and content criticism routing claims to serve/review/quarantine.
resource: https://arxiv.org/abs/2607.24117
provenance: "Distilled from the arXiv abstract page, the GitHub README (alizahidraja/isnad), and the author's Reddit discussion thread, fetched 2026-07-29"
tags: [provenance, trust, multi-agent, verification, claim-level, hadith, corroboration, knowledge-systems]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T17:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "evaluate this compared to this repo"
---

# ISNAD — an isnād–rijāl framework for claim-level provenance in multi-agent systems

**Paper:** "Grading the Narrators: An Isnad-Rijal Framework for Claim-Level
Provenance in Multi-Agent Knowledge Systems" — Ali Zahid Raja, arXiv:2607.24117
(cs.AI, cs.MA), submitted 2026-07-27. **Code:** Apache-2.0 Python 3.12+ library
at [alizahidraja/isnad](https://github.com/alizahidraja/isnad) (v2.0.4, archived
at Zenodo doi:10.5281/zenodo.21216873).

## Plain-language summary

Multi-agent pipelines fail silently: an answer passes through scrapers,
extractors, several models, and a synthesizer, and when one link is unreliable
the final answer arrives fluent and confidently wrong, with nothing marking
which hop corrupted it. Existing trust work authenticates the *agent* —
identity, permissions, access — while the *claim* travels unexamined. The
author's framing, from the Reddit announcement: "Everyone's building to verify
the agent — identity, permissions, access. Barely anyone's verifying the
claim."

ISNAD transfers the machinery classical Islamic scholarship built for exactly
this problem — trusting statements transmitted through chains of fallible
people. Every claim carries its full chain of transmitters; every transmitter
is graded on reliability; a chain is only as strong as its weakest link;
independent chains corroborate each other; and even a perfect chain does not
excuse content that contradicts established knowledge. The repo's slogan:
"Grade the narrators, not just log them."

## Key terms

- **[isnād](/beliefs/glossary/isnad.md)** — the transmission chain itself: the
  ordered list of hops a claim took from origin to assertion. In the
  framework, an ordered, gap-checked sequence per claim; a gap (a hop that
  cannot be accounted for) demotes the chain.
- **[rijāl](/beliefs/glossary/rijal.md)** — transmitter criticism: grading
  each narrator on integrity and precision. Here, a registry of grades kept
  per *(narrator, domain)* pair — reliability is scoped to a domain, not
  global to the agent.
- **[matn criticism](/beliefs/glossary/matn-criticism.md)** — criticism of
  the *content* of a transmitted statement, independent of its chain: does it
  contradict better-established knowledge? Implemented as pluggable
  contradiction detectors (embedding-based, NLI, LLM).
- **mutābaʿāt (corroboration)** — independent chains carrying the same claim
  raise its confidence. Requires proving independence, not assuming it.
- **[madār](/beliefs/glossary/madar.md)** — the common node several
  apparently-independent chains route through; detecting one collapses their
  claimed independence.
- **grade tiers** — ṣaḥīḥ (sound) · ḥasan (good) · ḍaʿīf (weak) · mawḍūʿ
  (fabricated), with Bayesian transitions between tiers rather than hardcoded
  thresholds.

## Technical summary

The abstract (per the arXiv page) describes attaching "graded, per-domain
transmitter reliability to claim-level transmission chains" with completeness
semantics and content criticism. The library decomposes into:

- **Chain** — ordered, gap-checked transmission sequences per claim;
  completeness (ittiṣāl) is epistemic, and a gap demotes the chain to ḍaʿīf.
- **Registry** — the rijāl store: a grade per (narrator, domain) with a
  Bayesian state machine driving tier transitions.
- **Grading** — refined weakest-link: a chain's grade is the refined minimum
  across its narrators.
- **Corroboration** — independent-chain validation via semantic embedding
  matching, with madār detection to establish genuine independence; upgrades
  cap at ḥasan (corroboration can rescue a weak chain but never mint a sound
  one); contributions are weighted by chain quality.
- **Decision matrix** — 4×2 routing of (chain grade × content verdict) to
  actions: ṣaḥīḥ + consistent → SERVE; ṣaḥīḥ + contradiction → REVIEW (the
  highest-value signal — a strong chain carrying contradicting content is
  where something interesting is wrong); ḍaʿīf + contradiction → QUARANTINE;
  weak-but-clean chains trigger a corroboration search.
- **Integration** — FastAPI service with Prometheus metrics, SQLAlchemy
  persistence, a LangChain `IsnadTracer` callback, CLI. Every strategy layer
  (grading, transitions, corroboration, correlation, critics) is pluggable.

**Validation status** (the paper foregrounds its own gaps): validated —
Bayesian grading, weakest-link quarantine, corroboration on 707 test pairs
(zero false positives on Wikipedia and physics-textbook matches), embedding
content criticism, the LangChain integration; evaluation ran on ~20,000
physics-textbook claims. Partial — narrator discovery works but good narrators
need seed grades, and seed bootstrapping only lifts coverage from ~5% to ~10%.
Not validated — self-confidence scoring as a defect predictor; and the
grade-recovery loop showed a "partial failure" in detecting the highest-fault
narrator. The paper's case study: a prototype self-maintaining knowledge base
"surfaced 19 genuine cross-framework contradictions in undergraduate physics
texts, demonstrating the matn-criticism substrate" (as quoted in the
[discussion thread](/knowledge/SWE/agentic/provenance/isnad-reddit-discussion-thread.md)).

## Critiques from the discussion thread

The sharpest critique (commenter donk8r, verbatim spans from the
[captured thread](/knowledge/SWE/agentic/provenance/isnad-reddit-discussion-thread.md))
targets the two halves of the transfer that lean on properties AI pipelines
lack:

- **Rijāl assumes a persistent identity accumulating a track record.** In a
  pipeline "the transmitter is a model call, and reliability there is not a
  property of the model, it is a property of the model plus the task type plus
  whatever was in context at the time. Grade at the model level and you get a
  number that is stable and says nothing." Per-task-type grades and benchmark
  priors don't fix it: a prior "has no idea whether it's sitting in the 85 or
  the 15," where the original system graded individuals on observed instances.
  The workable substitute: "scoring a transmitter on how often its claims
  survived independent checking inside your own pipeline."
- **Corroboration assumes provable independence.** "Two chains routed through
  the same base model are not independent even when the agents and prompts
  differ, so correlated error arrives looking exactly like agreement." ISNAD's
  madār detection is a partial answer; the critique is that in practice the
  independence usually is not there to detect.
- The concession: "weakest-link is the only half of the method that survives
  the transfer intact" — unless the grading unit narrows below the agent and
  independence gets a stated definition.

Multiple commenters converged on the missing empirical piece: no controlled
A/B comparison of verified vs. unverified pipeline output yet exists.

## Relation to this bundle

The evaluation of ISNAD against this brain's own verification ladder is a
project-relative judgment and lives in
[the ISNAD-vs-elixir-mind analysis](/meta/analysis/isnad-vs-elixir-mind-verification.md).
The shared vocabulary is real: claim-level (not agent-level) trust,
[provenance](/beliefs/glossary/provenance.md) as chain-of-custody, evidence
that must exist before a claim upgrades, and content the operator ratifies
rather than trusts on fluency.

# Citations

- Paper — <https://arxiv.org/abs/2607.24117> (CC BY 4.0)
- Code — <https://github.com/alizahidraja/isnad> (Apache 2.0; Zenodo
  doi:10.5281/zenodo.21216873)
- Announcement + discussion — captured verbatim in
  [isnad-reddit-discussion-thread](/knowledge/SWE/agentic/provenance/isnad-reddit-discussion-thread.md)
  (<https://www.reddit.com/r/AgentsOfAI/comments/1v9qe4p/1400_years_ago_scholars_solved_a_problem/>)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:c880d8">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-29-isnad-claim-verification-intake (2026-07-29)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:c880d8`]**  (co-feeds: `em:9318af`)

- evaluate this compared to this repo
https://www.reddit.com/r/AgentsOfAI/comments/1v9qe4p/1400_years_ago_scholars_solved_a_problem/
https://github.com/alizahidraja/isnad
https://arxiv.org/abs/2607.24117

and here is the text from the reddit thread:

~1,400 years ago, scholars solved a problem multi-agent AI just re-invented. I rebuilt their method and put it on arXiv.
[Discussion](https://www.reddit.com/r/AgentsOfAI/?f=flair_name%3A%22Discussion%22)
Author here. This one started as a weird idea and turned into a paper + open-source release, so I'm sharing the story.
Modern agent pipelines have a silent-failure problem. An answer passes through a scraper, an extractor, several models, a synthesizer — and when one link is unreliable, the failure doesn't announce itself. You get a fluent, confident answer that's quietly wrong. Everyone's building to verify the agent — identity, permissions, access. Barely anyone's verifying the claim.
The verification-of-transmitted-knowledge problem was rigorously solved a long time ago. Islamic scholars couldn't trust a statement just because it sounded right, so they built one of history's most demanding systems for it: every claim carries its full chain of transmitters (isnād), every transmitter is graded on integrity and precision (rijāl), the chain is only as strong as its weakest link, independent chains raise confidence, and even a flawless chain doesn't excuse a flawed message.
The rigor belongs to twelve centuries of scholars. The transfer to AI is mine. I call it ISNAD — a claim-level trust layer for multi-agent systems. Everyone verifies the agent; ISNAD verifies the claim.
I also wrote the failures into the paper — what's validated, what isn't yet, in detail. A trust framework that hides its weaknesses is a contradiction in terms.
If it makes you think — agree or disagree — I want to hear it.
Upvote29Downvote14Go to comments[Repost](https://www.reddit.com/submit?source_id=t3_1v9qe4p&composer_entry=crosspost_post_action_bar)Share

Comments Section

[ZioniteSoldier](https://www.reddit.com/user/ZioniteSoldier/)
•8h ago
I love these projects that take old human concepts and make them an agentic system.
Any way to show an example A/B comparison on non-verified vs your loop output? I'm curious on how it adjusts the trajectory.
ReplyShare

[donk8r](https://www.reddit.com/user/donk8r/)
•6h ago
The transfer is cleaner than most of these, but rijāl is the part I would worry about. Grading transmitters works because a transmitter is a persistent identity accumulating a track record over decades. In a pipeline the transmitter is a model call, and reliability there is not a property of the model, it is a property of the model plus the task type plus whatever was in context at the time. Grade at the model level and you get a number that is stable and says nothing.
Corroboration has a harder version of the same problem. Independent chains raising confidence assumes independence you can establish. Two chains routed through the same base model are not independent even when the agents and prompts differ, so correlated error arrives looking exactly like agreement. The transmitters in the original system were actually separate people. Here separation has to be proven, and usually it is not there.
Neither of those kills it. But the grading unit probably needs to be narrower than an agent, and corroboration needs a stated definition of what makes a chain independent, or weakest-link is the only half of the method that survives the transfer intact.
ReplyShare

[Lonely_Drewbear](https://www.reddit.com/user/Lonely_Drewbear/)
•1h ago
Could you grade using the model's benchmark score for a certain task type or tool use?  I feel like a tiny classifier model could be easily fine tuned to do this cheaply.
ReplyShare

[donk8r](https://www.reddit.com/user/donk8r/)
•45m ago
per-task-type beats a flat model grade, yeah. what it still won't tell you is anything about this particular transmission. 85% on a task type means the chain has no idea whether it's sitting in the 85 or the 15, and the original system was grading individuals on observed instances rather than on a prior.
a fine tuned classifier has the same shape, another model predicting from roughly the same distribution, so it agrees with the thing it's supposed to be checking more often than it should.
closer thing would be scoring a transmitter on how often its claims survived independent checking inside your own pipeline. slow to accumulate but at least it's about them.
ReplyShare

[alizahidrajaa](https://www.reddit.com/user/alizahidrajaa/)
•8h ago
Code: https://github.com/alizahidraja/isnad
Paper: https://arxiv.org/abs/2607.24117
ReplyShare

[LumpyWelds](https://www.reddit.com/user/LumpyWelds/)
•6h ago
This is like a combo of Chain-of-Custody/Blockchain with PGP's trust ratings. I like it.
But for me the most interesting part was:
"A case study in which a prototype self-maintaining knowledge base surfaced 19 genuine cross-framework contradictions in undergraduate physics texts, demonstrating the matn-criticism substrate"
Once I read that, I realized how useful this is and what your project can do.
ReplyShare

[philip_laureano](https://www.reddit.com/user/philip_laureano/)
•5h ago
In theory, this sounds good, but without an actual controlled A/B test, it'll remain theoretical.
Have you asked Fable 5 or GPT 5.6 Sol to write you an eval for it yet?
Once you have a running version of it, you can have them do all the A/B testing for you. It's amazing to watch
ReplyShare

[AutoModerator](https://www.reddit.com/user/AutoModerator/)
•8h ago
Thank you for your submission! To keep our community healthy, please ensure you've followed our rules.

* New to the sub? Check out our Wiki (We are actively adding resources).
* Join the Discord: Click here to join our Discord
* Join X community: Click here to join our X Community

I am a bot, and this action was performed automatically. Please contact the moderators of this subreddit if you have any questions or concerns.
ReplyShare

[TheRaiff1982JH](https://www.reddit.com/user/TheRaiff1982JH/)
•7h ago
I agree — an A/B test is the clearest way to demonstrate the effect. In the unverified baseline, a single weak agent can propagate error downstream; in the verified pipeline, claim-level checks expose unsupported transitions and force the synthesis step to revise or discard them.
So the improvement isn't only accuracy, it's trajectory control and error containment, I love how ideas are finally converging to the same things, just in different ways they're explained. check it out https://doi.org/10.21203/rs.3.rs-9362560/v1 https://github.com/Raiff1982/Codette-Reasoning they're complementary in incredible ways
ReplyShare

[ocean_protocol](https://www.reddit.com/user/ocean_protocol/)
•6h ago
Genuinely good analogy, isnad maps onto claim provenance almost too cleanly (weakest-link-in-the-chain, corroboration via independent chains, grading transmitters on reliability). That last part is the one people usually miss when they build "trust layers" for agent pipelines: they check the agent's permissions/identity, not the actual claim's lineage through the pipeline
Curious how you're handling the equivalent of rijal grading in practice, in hadith science that's built on centuries of biographical scholarship on individual transmitters. What's the AI-pipeline equivalent of a transmitter's track record? Per-model reliability score based on past claim accuracy, or something else?
ReplyShare

[NimaraVentures](https://www.reddit.com/user/NimaraVentures/)
•6h ago
solid point, ngl. everyone's locked in on agent-level trust and nobody's asking if the claim itself is even true after it bounces through five different scrapers and summarizers. isnad thing checks out too, weakest link in the chain breaks the whole chain, same deal with pipelines.
only thing I'd ask: humans built trust in a narrator over years. how you score that for a model that can act different depending on context or just gets updated overnight. does the paper touch on that or is that one of the gaps you flagged. either way props for putting the failure modes out front, most of these trust papers act like nothing can go wrong.
ReplyShare

[hypnotizedent](https://www.reddit.com/user/hypnotizedent/)
•5h ago
Peace and blessings. I was working on a similar project for preserving knowledge. Thank you for sharing.
ReplyShare

[rand3289](https://www.reddit.com/user/rand3289/)
•1h ago (Edited 32m ago)
There is not enough information in the post to understand what your system does.
ReplyShare

[sixwax](https://www.reddit.com/user/sixwax/)
•13m ago
Another modern analog is references/sources in academic papers, fwiw.
Use case matters. Are we talking about factual claims or "whether the agent did its job"
ReplyShare

---

**[`em:c880d8`]**  (co-feeds: `em:9318af /meta/analysis/isnad-vs-elixir-mind-verification.md /meta/evals/dedup-probe.md`)

All filed and verified. Here's where things stand.

**What happened:** I fetched the ISNAD paper (arXiv:2607.24117), its GitHub repo (`alizahidraja/isnad`), and captured the Reddit discussion verbatim (per your mid-turn request), then filed three documents and wrote the comparison you asked for. The bundle passes `mix brain.verify` and `mix brain.route_tags` clean.

| I created | Type | Where |
|---|---|---|
| ISNAD reference (`em:c880d8`) | `reference` | `knowledge/SWE/agentic/provenance/isnad-rijal-claim-level-provenance.md` |
| Reddit thread capture (`em:9318af`) | `source` | `knowledge/SWE/agentic/provenance/isnad-reddit-discussion-thread.md` |
| Comparison analysis | `analysis` | `meta/analysis/isnad-vs-elixir-mind-verification.md` |

A new `provenance/` subdirectory was created under the already-established `knowledge/SWE/agentic/` domain — per the taxonomy protocol this is autonomous (no new top-level directory), so I filed it without waiting for ratification; both index.md files are updated.

**The evaluation, in short:** ISNAD and this bundle solve different halves of the trust problem. ISNAD computes an automatic trust *score* for a claim from a graded chain of the agents that touched it (weakest-link grading, corroboration with independence checks, content-contradiction detection, and an automatic SERVE/REVIEW/QUARANTINE decision). This bundle never lets a machine decide that — `verified`/`verified_by` records evidence *links* for a human to judge, and `mix brain.verify` checks shape, never truth, by design.

The most useful part of the Reddit thread — donk8r's critique — turns out to land squarely on ground this bundle has already surveyed for itself, not just for ISNAD: grading a "narrator" that's really a model call (not a persistent person) produces "a number that is stable and says nothing," and two chains through the same base model aren't independent even with different prompts. Both problems are exactly what a future elixir-mind agent swarm (per the already-filed `agents-as-genservers` analysis) would hit too, and this bundle doesn't have a fix for either yet. I filed two open questions rather than conclusions: automated contradiction-detection (a real gap this bundle has no version of) and a survival-based per-agent trust score (matching what the bundle's own tier-3/4 escape-rate gap already wants) — full reasoning and citations in the analysis doc.

**Housekeeping:** I harvested two dedup gold-set rows for this intake and refreshed the baseline — recall held at 6/21 plain, no regression. One pre-existing advisory warning surfaced (the analysis doc's `attribution` lacks `from` — expected, since that gets stamped later by `/create-pull-request` once a thread doc exists) and is not something to act on now.

Nothing here is committed or pushed yet — say the word (or `/create-pull-request`) when you want this opened as a PR.
