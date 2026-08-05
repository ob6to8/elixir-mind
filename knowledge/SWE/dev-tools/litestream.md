---
id: em:86f6df
type: reference
title: "Litestream — streaming SQLite replication"
description: A standalone process (by Ben Johnson) that streams SQLite's write-ahead log to cheap object storage with no code changes to the application, so a single-server app gets continuous, cheap disaster recovery without a multi-server database.
resource: https://litestream.io/
provenance: "Litestream project site (litestream.io), fetched 2026-08-05"
tags: [sqlite, database-replication, disaster-recovery, single-server-deployment, ben-johnson, fly-io]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing; the URL was already parked in the survey tier (bookmarks.md), so this intake promotes it"
---

# Litestream

Litestream is a standalone replication tool for SQLite, created by Ben
Johnson (maintained at `benbjohnson/litestream` on GitHub, currently at
v0.5.x). It runs as a separate process alongside the application — "no code
changes" required — and continuously streams SQLite's changes to a cloud
object store or local files.

## The problem it solves

Litestream lets an application "safely run your application on a single
server" instead of standing up a multi-server database for durability. If the
server dies, the application restores from "your most recent replicated
transaction" against the object store, giving single-server deployments
disaster recovery without the operational cost of running a distributed
database.

## Why it's cheap

Because it rides on ordinary object storage rather than a second database
server, Litestream is described as "dirt cheap" — on the order of pennies a
day for continuous, worry-free backup, with support for multiple storage
backends.

## Where this sits in the brain

Already referenced in passing in
[Fly.io](/knowledge/SWE/agentic/execution-environments/fly-io.md) as the
recommended pattern for a small BEAM app's durable state on a single VM:
"SQLite + Litestream replicating to object storage for small apps," and as
the open-source, Fly-independent substitute for Fly's managed LiteFS/volumes
in a roll-your-own deployment.

# Citations

- Source: <https://litestream.io/>
