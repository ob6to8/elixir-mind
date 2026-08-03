---
id: em:1b9998
type: concept
title: libcluster
description: The standard Elixir library for automatic BEAM cluster formation — pluggable discovery strategies (Kubernetes headless services, DNS polling, gossip multicast, EC2 tags) find peer nodes and connect them into distributed Erlang, so clustering survives dynamic infrastructure where a static node list can't.
provenance: "Agent-distilled glossary definition (Claude Fable 5)"
verified: false
tags: [glossary, libcluster, elixir, beam, clustering, deployment]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T20:45:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-08-02 fly/shellbox intake and elixir-deployment thread"
---

# libcluster

The choice of strategy is effectively the deployment-platform decision: a
platform is viable for clustered
[distributed Erlang](/beliefs/glossary/distributed-erlang.md) exactly when
some strategy can discover peers there — which is why private networking is
the one hard requirement the 2026-08-02 thread's Elixir-hosting landscape
turns on, and why platforms with no inter-instance networking (Heroku
standard dynos, AWS App Runner) fall out of the running entirely.

*Seen in:* [2026-08-02 fly/shellbox intake thread](/meta/threads/2026-08-02-fly-shellbox-intake-and-elixir-deployment-landscape.md)
