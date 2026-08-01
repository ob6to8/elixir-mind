---
type: analysis
title: "Should bundle links be id-referenced with build-time path substitution?"
description: Evaluates replacing bundle-absolute markdown paths with `em:` id placeholders resolved by a build step; finds the machinery already largely built (a CI-checked id→path registry, a build-time id index, a single href-rewriting choke point) but the scheme structurally capped at ~49% of links — governance namespaces and `index.md` files never carry ids, and they are exactly where directory moves concentrate — while costing the GitHub blob view the audit policy depends on and adding registry indirection to the progressive-disclosure read path; recommends instead promoting link resolution from advisory warning to hard gate (free today at zero warnings) plus a `mix brain.refile` task that covers 100% of links.
provenance: "Claude Code session, 2026-08-01 — operator observed the repo-wide sed in a refile diff and asked whether id placeholders plus a build-time substitution step would be cleaner. Link and rename counts measured against the working tree at d7c2277; module and line anchors read from lib/ in the same session"
tags: [meta, analysis, links, stable-identity, tooling, build-step, site, verifier]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, architecture-docs-placement session"
  why: "operator asked for the pros/cons/feasibility judgment on id-referenced links to be recorded rather than left in the thread"
  from: [/meta/threads/2026-08-01-refile-architecture-paper-and-link-integrity.md]
---

# Should bundle links be id-referenced with build-time path substitution?

**Question.** Moving one document today required a repo-wide grep and `sed`
across five inbound links. Would it be cleaner to write links as stable-id
placeholders — `[label](em:7fa867)` — keep an id → path index, and have a build
step substitute the paths at publish time? The scheme trades away GitHub
rendering; does it buy enough knowledge-base health to be worth that?

**Thesis.** The build step is cheap and mostly already exists, but the scheme
cannot cover the links that actually break. Ids are a bundle-document property,
and roughly half of this repo's internal links point at targets that
structurally never carry one. Because bulk renames come from *directory* moves,
the uncovered half is precisely where the breakage concentrates. The failure
mode the proposal targets — a move that silently leaves a stale link — is better
closed by making the existing resolution check a gate and automating the move
itself.

## What already exists

The proposal's infrastructure is, to an unusual degree, built:

| Piece the scheme needs | Present today |
|---|---|
| An id → path index | [`meta/registry.md`](/meta/registry.md), generated from per-file frontmatter by `mix brain.registry` and CI-gated with `--check`. Derived, so it cannot drift |
| A build-time id → path map | `Site.build_id_index/1` (`lib/elixir_mind/site.ex:169`), already constructed on every site build and already consumed for `verified_by` evidence rows and the "Cited by" backlink panel |
| A single choke point for link rewriting | `Markdown.rewrite_href/2` (`lib/elixir_mind/markdown.ex:433`) — one `cond` already distinguishing external, `mailto:`, anchor, and internal targets, and already swapping `.md` → `.html` |
| A resolver for the verifier | `Links.resolve_target/2` (`lib/elixir_mind/links.ex:112`) |

An `em:` branch in `rewrite_href/2` plus the same in `resolve_target/2`, with
the id map threaded through the render context, is on the order of 100–150
lines and a migration pass. Feasibility is not the constraint.

## The coverage ceiling

Measured against the working tree:

| Quantity | Count |
|---|---|
| Internal `.md` links across the repo | 6,685 |
| → into `meta/`, `inbox/`, `survey/`, `journal/` | 3,217 (48%) |
| → at an `index.md` | 284 (partly overlapping the above) |
| Documents carrying an `em:` id | 661 of 1,306 |

Stable ids are minted for **bundle documents** only. Policies, plans, threads,
analyses, todos, issues, elaborations, digests, bookmark rows, journal entries,
and every reserved `index.md` sit outside the identity registry by
[stable-identity](/meta/policy/stable-identity.md) and the namespace rules the
governance and non-bundle tiers are built on. So an id-link scheme yields a
bundle in which **a link's syntax depends on the namespace of its target**, and
an author must classify the target before knowing how to address it.

The correlation runs against the proposal. A single document's move — today's
case — touches few links and is easy to fix by hand. Bulk renames come from
*directory* restructuring, and those break `index.md` links and governance
cross-links first. Those are the links ids cannot express.

## What the scheme costs

- **The GitHub blob view goes dark.**
  [response-resource-links](/meta/policy/response-resource-links.md) elevates
  the blob URL precisely because "A blob URL is viewable at **any** merge state,
  which is exactly when the operator audits". Under id placeholders, document
  bodies stop being navigable in the surface the operator reviews in, at the
  moment review happens.
- **Indirection lands on the hottest read path.** A fresh agent navigating by
  progressive disclosure from [`/index.md`](/index.md) downward currently
  follows a path by reading the file at it. Under ids it must consult a
  660-row registry to resolve any link — a per-read tax paid to avoid a cost
  incurred, across the repo's whole history, eleven times.
- **Authoring friction per link.** Writing a path means writing what you just
  read; writing an id means looking it up.
- **The bundle becomes a demanding producer.**
  [OKF conformance](/meta/policy/okf-conformance.md) asks a consumer to
  tolerate broken links; id placeholders hand a foreign consumer links it
  cannot resolve at all without this repo's build step.

Set against those: moves become free for the id-addressable minority, the Pages
build could resolve ids to canonical URLs, and grep sharpens — `grep -rn
"em:7fa867"` is exact where a slug substring can collide. The grep gain is real
and survives the recommendation below, since ids are already greppable in
frontmatter and route tags.

## The economics

Renames in this repo's history: **159 file renames across 11 commits** —
batched migrations, not a steady drip. Meanwhile `ElixirMind.Links.check/1`
currently returns **zero** unresolved-link warnings across all 6,685 links. The
mechanism is not failing; it is unguarded. The proposal spends a permanent
per-read and per-write cost to harden a path that empirically holds, and
hardens only half of it.

## Recommendation

Two moves, neither touching link syntax:

1. **Promote link resolution from advisory warning to hard gate.**
   `mix brain.verify` computes the check and deliberately declines to fail on
   it — "Warnings never fail the task — broken links are tolerated per OKF
   conformance" (`lib/mix/tasks/brain.verify.ex:11`). That clause governs being
   a tolerant *consumer of a foreign bundle*; it constrains nothing about how
   strict this repo's CI should be on content it authors. At zero current
   warnings the promotion is free, and it converts a missed rewrite from
   console noise into an un-mergeable change — the entire safety benefit of the
   id scheme, for one gate flip. Index coverage stays advisory: it is
   editorial, and the two families must be separated for this.

2. **Automate the move.** A `mix brain.refile` task performing the `git mv`,
   the inbound-link rewrite, both index updates, and the registry regeneration
   as one tested operation. Unlike the id scheme it covers **100%** of links,
   governance and `index.md` included, because it rewrites paths rather than
   requiring targets to be id-bearing.

Together these deliver structural link integrity with no syntax change, no
GitHub breakage, and no read-path indirection. The id scheme remains available
if moves ever become frequent enough to warrant it — and move #1 would by then
already be the migration's safety net.

Filed as the [structural link integrity plan](/meta/plans/structural-link-integrity.md).
