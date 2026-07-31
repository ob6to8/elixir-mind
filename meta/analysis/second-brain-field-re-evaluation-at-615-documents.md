---
type: analysis
title: "Re-evaluated at 615 documents: the enforcement architecture is holding, the corpus is still bootstrapping"
description: A graded re-evaluation of the bundle against the 2026 second-brain field, run 19 days and 573 documents after the first comparison, testing its central prediction — that structural enforcement bounds the 500+ concept failure chain — and finding the architecture past the public frontier on fourteen measured dimensions while governance mass outweighs knowledge mass roughly six to one.
provenance: "Claude Code session (claude-opus-5), 2026-07-29 — repo checks run directly against 8f0418d; field baseline from the 2026-07-10 survey plus two web searches run the same day"
tags: [meta, analysis, second-brain, landscape, evaluation, grading, scale, retrieval, corpus-composition]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, repo-knowledge-base-eval session"
  why: "operator asked for a graded evaluation against the second-brain status quo; filed so the measured baseline and the rubric persist as the comparison point for the next re-run"
  from: [/meta/threads/2026-07-29-repo-evaluation-against-the-second-brain-field.md]
---

# Re-evaluated at 615 documents

**Question.** How does this bundle grade against the 2026 second-brain field, on
each dimension separately — and does the central prediction of the
[2026-07-10 comparison](/meta/analysis/comparison-with-the-2026-second-brain-field.md)
survive contact with a corpus an order of magnitude larger?

**Bottom line.** The architecture grades A-range on every structural dimension and
remains past the public frontier; the contents grade C-range. Governance mass
outweighs knowledge mass roughly 6:1, and 46% of the corpus is transcripts of the
system's own construction. The prior analysis's prediction holds in the form it was
actually stated — degradation here is bounded, observable, and repairable — with two
early stages of its failure chain now visibly manifesting in the governance
namespace and both caught and filed rather than rotting silently. The gap that
widened is retrieval, where the field's front moved while this bundle's
zero-dependency stance held it at grep.

## Measured state (8f0418d, 2026-07-29)

| Metric | Value |
|---|---|
| Age / activity | 20 days (first commit 2026-07-09), 686 commits, 132 merged PRs |
| Markdown docs (ex-`deprecated/`) | 1,028 |
| Bundle documents (`em:` ids) | 615 unique, zero collisions |
| Total corpus | ~840k words |
| Tooling | 21 modules, 17 `mix brain.*` tasks, 6,845 LOC lib / 3,085 LOC test |
| Tests | 188 passing, 0 failures |
| CI gates | 15 |
| Compiled contract | 41 policies → 103 KB `CLAUDE.md` |

**Corpus mass by namespace** — the most diagnostic measurement in the bundle:

| Namespace | Docs | Avg words | Total | Share |
|---|---|---|---|---|
| `meta/threads/` | 120 | 3,230 | 388k | **46%** |
| `knowledge/` | 124 | 860 | 107k | **13%** |
| `beliefs/glossary/` | 473 | 218 | 103k | 12% |
| `meta/analysis/` | 45 | 1,695 | 76k | 9% |
| `meta/plans/` | 43 | 1,366 | 59k | 7% |

**Health checks, run against the working tree:** `mix brain.verify` passes;
`mix brain.orphans` reports zero orphans; 188/188 tests pass; `mix brain.dedup_probe`
scores 6/19 (32%) plain, 17/19 (89%) synonym-expanded.

**Link integrity.** A sweep over ~6,900 internal bundle-absolute document links
found **zero hand-authored broken links on live surfaces**. Every apparent hit
resolved to one of two exempt categories: text inside a generated
`## Thread excerpts — route-tagged log` block (verbatim lifts of frozen thread
regions, which `mix brain.route_tags` verifies for fidelity and which therefore
must not be hand-corrected), or an illustrative path inside a code span
(`` `[x](/SWE/index.md)` ``, `[<tracker>](/meta/todos/x.md)`). 77 further broken
links sit inside `meta/threads/` bodies, which are frozen by
[session-capture](/meta/policy/session-capture.md) and correctly left alone.
A first pass of this measurement reported ~12 live-surface breakages before the
excerpt-block and code-span exemptions were applied; the corrected figure is zero.

## The grading rubric

| # | Dimension | Grade | Basis |
|---|---|---|---|
| 1 | Structural enforcement | A+ | 15 CI gates; rules are build failures, not prompt prose |
| 2 | Identity & rename-survival | A | Opaque minted `em:` ids + compiled registry; 615 unique |
| 3 | Portability / lock-in resistance | A+ | Plain markdown, zero runtime deps, git-native |
| 4 | Provenance & auditability | A | Machine-checked `attribution`, frozen threads, true-merge history |
| 5 | Tooling engineering quality | A− | 188 tests, warnings-as-errors, zero compile coupling, offline |
| 6 | Taxonomy design | A− | Tree-is-taxonomy + ratification; no orphans; index discipline holds |
| 7 | Self-instrumentation | A | Ships evals that can return bad news about itself |
| 8 | Ingestion automation | B | `/intake`, `/research`, `/bookmarks` real; daily routine has a tracked failure |
| 9 | Scale evidence | B− | 500 crossed nominally; failure-chain stages 2–3 appearing, and caught |
| 10 | Knowledge substance | C+ | 124 docs, 107k words, 70% in one subdomain |
| 11 | Epistemic rigor in practice | C | 5 docs `verified: true` vs 487 `verified: false` |
| 12 | Retrieval | C− | grep + LLM-in-context; 32% plain recall; field has moved past this |
| 13 | Self-referentiality / overhead | C− | Governance mass ≈ 6× knowledge mass |
| 14 | Human usability | C+ | 103 KB contract, 16 skills, 41 policies — steep for anyone but the author |

Composite: **A on architecture, C+ on contents.**

## Testing the 2026-07-10 prediction

The prior analysis set the terms of its own test:

> The refined claim is therefore *not* "this system won't degrade at 500+"; it is
> that degradation here is **bounded** (mechanical invariants can't rot),
> **observable** (probes and frozen records make it measurable), and **repairable**
> (identity survives the cleanup)

— [comparison-with-the-2026-second-brain-field](/meta/analysis/comparison-with-the-2026-second-brain-field.md)

**The threshold was crossed nominally, not substantively.** 615 bundle documents
sits past the ~500 line the failure chain was pinned to, but 473 of those are
218-word glossary entries under a one-term-one-file rule with its own dedup
verifier. The genuine concept count in `knowledge/` is 124. The chain was modelled
on a corpus of full concepts; this is a softer test than the one it described.

**Stages 2 and 3 are manifesting, in the governance namespace.** Two open issues
are the predicted failure modes verbatim: parallel sessions filing duplicate
governance artifacts for the same matter with nothing detecting it (stage 2,
fragmentation), and policy index glosses drifting silently when a policy's rule
changes (stage 3, cross-reference drift). Both appeared where write volume is
highest — `meta/`, not `knowledge/`.

**The claim survives in the form stated.** Both were detected, filed, and are
tracked; neither corrupted an invariant. What detected them was operator and agent
attention rather than a gate, which is the honest limit: the prior analysis's
"CI here verifies form, not semantics" is unchanged, and duplicate-artifact
detection remains outside every gate.

## What moved in the field since the survey

The 2026-07-10 survey found the field's integrity model near-universally advisory.
Two searches run 2026-07-29 do not overturn that: the closest public equivalents
still validate tooling or agent behavior rather than corpus invariants —
[claude-obsidian](https://github.com/AgriciDaniel/claude-obsidian) tests its plugin,
and the [gitagent-protocol](https://github.com/open-gitagent/gitagent-protocol)
validates agent behavior in CI. No public system found compiles the agent's own
constitution from ratified sources and fails the build on drift.

**The front moved to retrieval, and that is where this bundle is weakest.**
[Wuphf](https://www.theagenticdigest.com/issues/git-llm-agent-wiki) pairs
markdown-in-git with a Bleve BM25 plus SQLite index; [pkb](https://github.com/dlants/pkb)
commits a search database to the repo and syncs it in CI; Graphyte/Graphify-class
tooling folds knowledge graphs into Obsidian vaults for Claude Code. Each keeps the
plain-markdown ownership this bundle grades A+ on **and** adds an index. The
zero-dependency doctrine buys dimension 3 and caps dimension 12; the graduation
path is already specified in the
[vector-DB recall analysis](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md)
(cached brute-force intake-time embeddings, no standalone DB).

**The trigger signal is partly masked.** `mix brain.dedup_probe` reports 89%
expanded recall alongside 32% plain. Synonym expansion is a real tier-1 win, but the
headline number now moves with the expansion list rather than with the underlying
lexical layer, so "recall dropping" — the stated condition for firing tier 2 — is
harder to read off the reported figure than when the probe was designed.

## The composition finding

`meta/threads/` holds 388k words against `knowledge/`'s 107k. Counting all
governance namespaces against the knowledge taxonomy, the ratio is roughly 6:1. Of
124 knowledge documents, 86 sit under `SWE/` and 58 under `SWE/agentic/`;
`machine-learning/` holds 5 and `startups/` 2.

For a 20-day-old system this is what bootstrap looks like, and the `projects/`
namespace exists precisely to widen it. The consequence to name is that a knowledge
base's value is proportional to what it can tell its operator that they did not
already know, and the subject this bundle currently knows best is itself.

Dimension 11 has the same shape at the document level: an evidence model with
`verified`/`verified_by` machine-enforced, exercised by 5 statements out of the 492
carrying the field. The ladder is built and unclimbed.

## Sustainability signals

29 open plans (17 proposed, 10 accepted, 2 in-progress) against 14 done — the design
backlog grows faster than execution. 19 open todos, 8 open issues. The compiled
contract stands at 103 KB and grows with every ratified policy, as standing context
cost on every session. Each is directional rather than failing.

## Recommendation

1. **Shift the write ratio toward `knowledge/`.** Dimension 10 is the cheapest large
   grade gain available and is a usage decision, not an engineering one.
2. **Fire the tier-2 retrieval trigger.** 32% plain recall is the signal the probe
   was built to produce; the field is now shipping the answer without giving up the
   portability stance.
3. **Report plain and expanded recall as separate trend lines** so the tier-2
   condition stays readable off the CI output.
4. **Leave the architecture alone.** Dimensions 1–7 are the bundle's differentiator
   and need no work; effort spent there now compounds the dimension-13 problem.

## Source notes

Repo measurements were run directly against the working tree at `8f0418d` on
2026-07-29 (`mix test`, `mix brain.verify`, `mix brain.orphans`,
`mix brain.dedup_probe`, plus a link sweep and word counts scripted for this
analysis). The field baseline is the 2026-07-10 survey recorded in the prior
analysis plus two web searches run 2026-07-29; **no fresh systematic survey of the
landscape was commissioned**, so claims that no public system does X are scoped to
those two searches and the prior survey's enumeration, not to the field at large.
