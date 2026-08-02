---
type: matter
title: "dev-history recommit + regeneration fold-in"
description: Recommit the derived meta/dev-history.md and fold its regeneration into the /create-pull-request motion beside the other regenerate-before-commit artifacts, with an unshallow guard.
status: open
provenance: "Claude Fable 5, matter-register consumption session (matter-docs build 2)"
tags: [meta, matter, dev-history, tooling]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T08:32:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-register consumption session (matter-docs build 2)"
  why: "migrated from the matters register's row packet when the register thinned to the order-only pointer view"
  from: [/meta/matters.md, /meta/threads/2026-08-02-stand-up-meta-matters-and-thin-the-register.md]
---

# dev-history recommit + regeneration fold-in

Decision made (operator-approved): recommit the derived `meta/dev-history.md`
(currently gitignored, deploy-only — Pages is de-prioritized and a referenced
doc needs an in-repo home); fold regeneration into the `/create-pull-request`
motion beside the other regenerate-before-commit artifacts, per the
[staleness analysis](/meta/analysis/dev-history-staleness-and-ci-regeneration.md)'s
own recommendation; include an unshallow guard (the original drift came from
shallow clones —
[resolved issue](/meta/issues/dev-history-regeneration-silently-skipped-on-shallow-clones.md));
accept the one-PR self-referential lag; update the
[meta index](/meta/index.md)'s dev-history line.
