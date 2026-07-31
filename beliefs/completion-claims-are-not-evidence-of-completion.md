---
id: em:674c8f
type: belief
title: A completion claim is not evidence of completion
description: An agent's report that an action succeeded is a statement produced by the same context that made the action, so it carries no information about the resulting state — only a separate read against the system that holds the state does, which makes the write and the read-back two steps rather than one.
depends_on: [em:2ecdd2]
resource: "https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/your_agent_says_done_you_check_and_nothing/"
provenance: "r/AgentsOfAI discussion thread \"Your agent says 'done.' You check and nothing actually happened. Anyone else seeing this?\" (posted ~2026-07-26, OP username not captured), read from the operator's paste of the rendered page rather than fetched — Reddit returns HTTP 403 to unauthenticated reads over every route tried (WebFetch, direct curl to .json, third-party reader). The read-back formulation is commenter u/ocean_protocol's; the framing quotes are the OP's. One account (u/ApprehensiveCar6879) replies approvingly to nearly every top-level comment and solicits DMs, so the thread's apparent consensus is four independent practitioners, not eight"
tags: [belief, verification, agent-output, epistemics, observability, tooling, workflow]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "Claude Code agent, post-action-verification session"
  why: "operator supplied the quote with its source and directed committing it as a belief, to ground a plan for wiring read-back verification into this repo's development flow"
---

# A completion claim is not evidence of completion

An action and the report that it worked are produced by the same process. When
that process is wrong about the world — the call was accepted but the write was
rejected downstream, the tool returned before the state settled, the request went
somewhere other than where it was aimed — the report is wrong in exactly the same
way, and nothing in it flags the divergence. The prior: **treat a state-changing
action as unconfirmed until a separate read against the system holding that state
returns the expected value, and report the value that read returned rather than
what the action claimed.**

The practice, as u/ocean_protocol states it:

> "Post-action verification against the source of truth is the only thing that
> actually works, trace/eval/guardrails all check the agent's story, not reality.
> Concretely: after any state-changing action, do a read-back call to confirm the
> actual state (refund shows in billing, ticket status changed), not just 'did the
> call return 200.' Treat the write and the verify as two separate steps, never
> trust completion claims from the same context that made the claim"

## Why a clean run proves nothing

The thread's OP puts the core observation in one line — "**A clean run just means
it stopped running. that's all. it doesn't mean the work actually happened**" —
and then names the incentive that makes it structural:

> "'i did X' is basically free for a model to say. there's no penalty for being
> wrong, and it says it with the same confidence whether it worked or not."

A claim that costs nothing to make and is never scored carries no information.
Confidence, fluency, and internal coherence are all preserved when the write
silently no-ops, because none of them were ever coupled to the write.

## Why the observability layer does not substitute

Traces, evals, and guardrails all sit on the agent's side of the boundary. The OP
separates the three failures precisely:

> "observability is just the trace, which is the agent telling its own story. so
> if a write silently no-ops or it skips a step, the trace still looks fine. evals
> check if the output sounds right. guardrails run before the action anyway. none
> of them answer the only thing that really matters after the fact: did reality
> match what it claimed?"

Guardrails is the sharpest of the three: a pre-action check cannot in principle
answer a post-action question, however good it is. And commenter donk8r names the
category the other two fall into — "**the trace is testimony rather than
evidence. What's missing isn't observability, it's reconciliation**" — with
bithatchling's compressed version being that relying on the trace is
"trusting the agent's diary."

This is [review is not an oracle](/beliefs/review-is-not-an-oracle.md) with the
reviewed output being a *completion claim*: the independent thing that could
settle it is not a better reading of the transcript but the system of record,
which was never asked. What counts as such a system is a separate question with
its own answer — see
[only what the other side produced is evidence](/beliefs/only-what-the-other-side-produced-is-evidence.md).

## The two-step property is what makes it work

Folding the confirmation into the acting call — a write endpoint that returns the
new state, a tool result that echoes what it says it stored — reintroduces the
defect it was meant to remove: the echo is generated by the same code path, under
the same assumptions, in the same transaction that may not commit. A `200` is
evidence the request was *accepted*, which is a fact about the request. The
read-back has to be a different call, issued afterward, against the authority for
that state, and it has to be able to come back with the wrong answer. A
confirmation that cannot fail is not a confirmation.

donk8r's implementation collapses the distinction at the tool boundary rather than
leaving it to the agent's discretion —

> "making every write tool return a read-back instead of a status. Don't trust the
> 200, re-fetch the record and assert the field you expected to change, then let
> the tool result carry the fetched state rather than the model's summary of it.
> That's one extra call per write, and it collapses 'agent says it issued a
> refund' into 'billing says refund X exists for amount Y'."

— which is the corollary for reporting, enforced structurally: the number, status,
or identifier that reaches the reader is the one the read-back returned. Passing
along the action's own return value labels a claim as checked while leaving it
unchecked, which is worse than leaving it visibly unchecked — it spends the
reader's trust on nothing.

## The bound: read paths, and where they run out

The cost bound is what keeps this from becoming ceremony, and the thread draws it
in the same place this brain's tooling does:

> "If you're doing codegen, it's easier. rerun the test or check the diff and you
> know. but anything that touches real systems is where it breaks. issuing a
> refund in your billing system, updating a CRM field, provisioning something,
> moving a ticket, actually sending the email. there's no cheap retry to verify
> any of that."

So a read-back is owed where the state lives somewhere the acting context cannot
see, and where nothing downstream re-derives it. Where a later step already
recomputes the state from the authority — a re-run test, a regenerated artifact
compared byte-for-byte — that step *is* the read-back, and adding another is
duplicated work rather than added assurance.

Two classes escape inline verification entirely, and donk8r bounds them: "**Where
it stops working is async writes that aren't visible yet, and side effects with no
read path at all, email being the obvious one. Those need a delayed reconciliation
pass against the source of truth rather than inline verification.**" An action
whose effect is not yet visible, and an action that never happened at all, are
both invisible to a check that runs inside the acting session — the second most of
all, since a run that never starts cannot read itself back.

## The failure is silent, which is why it needs a rule

Nothing about a phantom success announces itself. The task list shows green, the
narrative is coherent, the next step proceeds on the assumption that the previous
one landed — and the discrepancy surfaces later, at a distance from its cause,
usually to someone who was not there, or in the OP's version, "three days later
from an angry customer." Held as a prior rather than a finding for the same reason
[an instrument without a control measures itself](/beliefs/an-instrument-without-a-control-measures-itself.md)
is: the moment an action returns success, the incentive to interrogate it
disappears, so the check has to be structural rather than triggered by suspicion.

The vocabulary the thread settles on is worth keeping, because it makes the
distinction hard to blur: manjit-johal's "**'task completed' and 'state changed'
are completely different signals**", and ticktockbent's design rule that a
completion must be anchored on a tool-use receipt — "anchor the agent's 'done' on
something that isn't vibes."
