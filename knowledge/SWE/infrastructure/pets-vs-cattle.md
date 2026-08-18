---
id: em:732198
type: reference
title: "The history of 'pets vs. cattle' — origin and correct usage"
description: Randy Bias's 2011-2012 cloud-computing adaptation of Bill Baker's scale-up vs. scale-out analogy — servers as either irreplaceable "pets" or disposable, automatically-replaced "cattle" — with Bias's own account of the metaphor's origin and a pushback on later dilutions of it.
resource: https://cloudscaling.com/blog/cloud-computing/the-history-of-pets-vs-cattle/
provenance: "Randy Bias, Cloudscaling blog, 2016 retrospective, fetched 2026-08-18"
tags: [cloud-computing, infrastructure, immutable-infrastructure, devops, terminology]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# The history of "pets vs. cattle"

## Origin

Randy Bias adapted the analogy around 2011-2012 while struggling to explain
to customers how cloud-native infrastructure differed fundamentally from
what came before. He found it in Bill Baker's presentation on scaling SQL
Server, where Baker used pets-vs-herd to contrast scale-up and scale-out
architectures generally (not cloud specifically). Bias's own contribution was
recasting it for cloud and centering the key axis on disposability, not scale
direction: if you view a server as inherently something that can be
destroyed and replaced at any time, it's a member of the herd; if you view a
server as indispensable, it's a pet.

His canonical elevator pitch:

> "In the old way of doing things, we treat our servers like pets, for
> example Bob the mail server. If Bob goes down, it's all hands on deck…
> In the new way, servers are numbered, like cattle in a herd. For example,
> www001 to www100. When one server goes down, it's taken out back, shot, and
> replaced on the line."

The framing spread after Tim Bell at CERN and others picked it up, and it
became the standard shorthand for explaining the shift to cloud to IT
managers and executives.

## Definitions

- **Pets** — indispensable or unique systems that can never be down,
  typically manually built, managed, and hand-fed. Examples: mainframes,
  solitary servers, HA active/active or active/passive load-balancer/firewall
  pairs, master/slave database pairs.
- **Cattle** — arrays of 3+ servers built by automated tooling and designed
  for failure, where no individual server (or small number of them) is
  irreplaceable and no human intervention is needed on failure — routing
  around it via restart or replication (triple replication, erasure coding).
  Examples: web server arrays, multi-master Cassandra clusters.

The real distinction is not redundancy — a classic HA pair is still two
"pets" — but whether the system as a whole assumes individual-component
failure is normal and self-healing.

## Bias's pushback on dilution

Bias specifically pushes back on the Kubernetes team's 2016 "Pet Sets"
naming, arguing the workloads it targeted (Cassandra, Kafka, MongoDB) are
already cattle-architected data stores by his own definition — reusing "pet"
language for them muddies the metaphor's actual point, which he holds is
disposability, not "needs special handling." (Kubernetes later renamed these
to StatefulSets.)

# Citations

- Source: <https://cloudscaling.com/blog/cloud-computing/the-history-of-pets-vs-cattle/>
