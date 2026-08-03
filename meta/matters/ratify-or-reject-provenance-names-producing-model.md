---
type: matter
title: "Ratify or reject the thin attribution policy naming the producing model"
description: The three-level documentation doctrine proposed a thin attribution rule — that provenance names the model that produced a statement — and it has sat awaiting operator ratification since, while the commit trailer and attribution.agent have since taken over adjacent ground.
status: open
provenance: "Claude Code session (2026-07-13) — proposed inside the three-level documentation and model doctrine work"
tags: [meta, matter, attribution, provenance, policy, ratification]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from an untracked routing-ledger strand; a policy proposal awaiting ratification that has been overtaken in part and needs an explicit decision either way"
  from: [/meta/threads/2026-07-13-three-level-documentation-plan-and-model-doctrine.md, /meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md]
---

# Ratify or reject: provenance names the producing model

A thin attribution rule was proposed alongside the
[three-level documentation plan](/meta/plans/three-level-documentation.md): that a
document's `provenance` should name **which model** produced the statement, so a
later reader can weigh it accordingly.

**What has changed since.** Two mechanisms have taken adjacent ground:

- The **`Claude-Session:` git trailer** links a commit to its session, and
  [merge-strategy](/meta/policy/merge-strategy.md) states the model belongs in the
  commit trailer rather than the doc.
- **`attribution.agent`** records who acted, and
  [resource-attribution](/meta/policy/resource-attribution.md) is explicit that it
  names "the **pathway, not the model**".

So the contract now says twice, in two policies, that the model is *not* recorded
on the document. The proposal is either superseded by that, or it is a deliberate
exception for `provenance` specifically — which is a different field with a
different job (where the *content* came from, possibly predating the brain).

**Recommendation.** Reject and record the rejection. The trailer already carries
the model with better fidelity, it cannot go stale, and a third home for the same
fact is the shadow-copy pattern
[provenance-lives-in-metadata](/meta/policy/provenance-lives-in-metadata.md)
exists to prevent.

**Done when.** The proposal is ratified into a policy or rejected, with the reason
recorded so it stops reading as pending.
