---
id: em:0bfe41
type: concept
title: continuous deployment
description: Shipping every change that passes the gates straight to production automatically, with no batching or manual release step — the trunk's green state and the deployed state are the same thing.
provenance: "Agent-distilled glossary definition, surfaced characterizing this repo's main = production deploy model"
verified: false
tags: [glossary, deployment, ci, workflow]
sense: common
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "names the deploy model the version-control audit found this repo runs (main = production, per-merge Pages deploy)"
---

# continuous deployment

Distinguished from *continuous delivery*, which keeps the trunk **releasable** but
leaves the release itself a human decision. Under continuous deployment there is no
promotion step: a green merge is a production deploy. The tradeoff is that the
pre-merge gate becomes the *only* gate, so anything it misses ships — which is why
a heavier pre-deploy gate or a rollback path matters more
here, not less. This repo deploys the bundle to its Pages site on every merge to
`main`, with the deploy job
[re-running the integrity checks itself](/meta/tutorials/gating-the-pages-deploy-on-a-verified-bundle.md).

*Seen in:* [2026-07-26 version-control-audit thread](/meta/threads/2026-07-26-version-control-audit-and-response-format-policies.md)
