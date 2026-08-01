---
type: analysis
title: "Does terse-lang/terse's terse-brain app belong in this repo's methodology? A Tier-2 Karpathy-pattern port evaluated against the live bundle"
description: Evaluates terse-lang/terse's apps/terse-brain (a Karpathy llm-wiki port onto a purpose-built hierarchical state format, TERSE) against this bundle's own architecture; finds the format's computed-index and structured-query wins are real but land on ground this repo already holds by other means, while its two costs — a one-file store under positional @-path references fighting this repo's true-merge provenance model, and an attributes-first shape fighting its prose-and-policy governance layer — are disqualifying for adoption; recommends taking three ideas without the format (source hashing/drift detection, a frontmatter facet query, and gating index-listing coverage) and corrects two claims from the live-chat version of this evaluation against the actual code.
provenance: "Claude Code session (Claude Sonnet 5, after a model switch from Claude Opus 5 mid-session), 2026-08-01 — operator asked for a plainspeak evaluation of terse-lang/terse's apps/terse-brain against this repo's methodology; terse-lang/terse read from a public shallow clone at 637140a3a749f56a981cdb58d943f4fc1515c53b (2026-07-24, v0.4.1), since add_repo does not support cross-owner attaches in this session"
tags: [meta, analysis, second-brain, terse, karpathy, llm-wiki, comparison, tooling, index-coverage, source-provenance, retrieval]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, terse-brain-evaluation session"
  why: "operator asked to evaluate terse-lang/terse's terse-brain against this repo's own methodology and decide whether to adopt it or its ideas"
  from: [/meta/threads/2026-08-01-terse-brain-evaluation-and-index-coverage-gate.md]
---

# Does terse-brain belong in this repo's methodology?

**Question.** [terse-lang/terse](https://github.com/terse-lang/terse)'s
`apps/terse-brain` is an explicit 1:1 port of Andrej Karpathy's `llm-wiki` gist
onto TERSE, a purpose-built hierarchical state format with a query/mutation
syntax. Does it — or its underlying format — belong in this repo, and does its
critique of hand-kept markdown wikis land on this bundle?

**Bottom line.** No adoption, on either the app or the format. `terse-brain`
is a strong, well-engineered Tier-2 entrant in the same Karpathy-pattern genre
this bundle's own [2026-07-10 field comparison](/meta/analysis/comparison-with-the-2026-second-brain-field.md)
already surveyed, but its two structural bets — one mutable store file under
positional `@Path` references, and attributes-first nodes over prose bodies —
run directly against this bundle's two load-bearing substrates: the true-merge
commit graph as the single provenance layer, and distilled prose as the
knowledge unit. Its computed-index and structured-query wins are real but
already held here by other, cheaper means (a compiled registry; frontmatter
already carrying every field a facet query would filter on). Three of its
ideas transfer without the format — source hashing and drift detection,
frontmatter-facet query, and gating index-listing coverage — and the third is
already built and merged as part of this evaluation.

## What was read

A public shallow clone of `terse-lang/terse` at
[`637140a`](https://github.com/terse-lang/terse/tree/637140a3a749f56a981cdb58d943f4fc1515c53b)
(2026-07-24, tagged `v0.4.1`, one merged PR in the repo's history — `add_repo`
does not support attaching a second owner into a session already scoped to
`ob6to8`, so the evaluation reads a public clone rather than an attached
source). In scope: the top-level
[README](https://github.com/terse-lang/terse/blob/637140a3a749f56a981cdb58d943f4fc1515c53b/README.md),
the format guide
([`terse-spec/TERSE.md`](https://github.com/terse-lang/terse/blob/637140a3a749f56a981cdb58d943f4fc1515c53b/terse-spec/TERSE.md)),
and the whole of `apps/terse-brain` — its
[README](https://github.com/terse-lang/terse/blob/637140a3a749f56a981cdb58d943f4fc1515c53b/apps/terse-brain/README.md),
the `using-terse-brain` skill, the `# Schema` seed, and the Python modules
implementing `store`/`ingest`/`lint`. Not read line-by-line: `terse-py`'s
~28.5k-line parser/lexer/AST implementation (its public contract was taken on
the README's word) and `terse-mcp`'s namespace-mapping internals.

## What terse-brain is

Four fixed top-level containers in one `.terse` store file — `# Schema`
(node kinds, required attributes, status vocabulary, all queryable), `# Raw`
(provenance only: sha256, size, kind, origin — full bytes mirrored into a
`raw/` directory on disk), `# Wiki` (LLM-owned `Entities`/`Concepts`/`Claims`/
`Synthesis`), `# Log` (append-only, typed entries). A CLI
(`init`/`wire`/`doctor`/`register-source`/`lint`/`stats`/`diagram`) plus an MCP
server expose it to an agent, which reads via bracketed-tail queries
(`? Wiki.Claims.* [WHERE Its HAS disputed]`) and writes via declarative
patches applied by `terse-py`'s atomic, file-locked writer. Six lint checks
(`BRAIN-A` dangling-ref … `BRAIN-F` unsourced-claim) catch drift, each
findable and fixable in the same TERSE the store is written in. The engineering
is genuinely good: a zero-runtime-dependency parser (`terse-py`'s own
`pyproject.toml` declares `dependencies = []`), content-addressed source
mirroring, atomic writes with a file lock, lint output that is itself
re-ingestable TERSE.

The project states its own design ethos plainly:

> "Names carry meaning. Intrinsic identity lives in the name, not a bag of
> attrs." … "Silence preserves. What you do not restate, you do not change."
> — [`terse-spec/TERSE.md`](https://github.com/terse-lang/terse/blob/637140a3a749f56a981cdb58d943f4fc1515c53b/terse-spec/TERSE.md)

## Where it stands against this bundle

`terse-brain` is a new entrant in the same Tier 2 this bundle's field survey
already named — the "serious agent-native repos" building on Karpathy's
`llm-wiki` sketch, distinct from the Tier-1 Obsidian/PARA influencer wave and
the Tier-3 commercial PKM products. Against the dimensions that comparison
already scored:

| Dimension | terse-brain | This bundle |
|---|---|---|
| Identity | Positional `@Wiki.Concepts.attention` (a normalized display name) | Opaque minted `em:` id, rename-proof, compiled registry ([`meta/registry.md`](/meta/registry.md)) |
| Storage unit | One store file, whole-tree | One markdown file per document |
| Version control | Unaddressed in the spec or the app | The substrate: true merges, session trailers, cited SHAs |
| Verification | `source:` must resolve to a `# Raw` entry; `confidence:` a self-reported float | `verified` restricted to statement types, rejected on captures, requires resolvable `verified_by` edges |
| Source provenance | sha256 + size + kind + origin, bytes mirrored, hash-drift detected | `resource`/`provenance`/`attribution` — no hashing, no byte mirroring, no drift detection *(closed by this session — see below)* |
| Index | Computed (`? [DEPTH 2; CONTAINERS]`) | `CLAUDE.md`/`meta/registry.md`/`meta/code-map.md` compiled with `--check`; per-directory `index.md` listings hand-maintained, now gated for coverage *(closed by this session — see below)* |
| Query | Structured tree filters (`WHERE`/`CONTAINS`/`DEPTH`) | grep + narrow `mix brain.*` slices |
| Governance | One `# Schema` container, six lint codes | 41 compiled policies, 15 CI gates, propose-then-ratify vocabulary |
| Maturity | v0.4.1, pre-release ("APIs and spec details may change before 1.0"), one merged PR | 686+ commits, 189 tests, 15 CI gates |

## The two disqualifying incompatibilities

**1. Git.** One store file means every write touches the same file, and TERSE
treats sibling order as state — placement directives (`FIRST`/`LAST`/`BEFORE`/
`AFTER`) exist precisely because reordering is a semantic change, not a
formatting one. Two branches that each ingest something independently produce
adjacent diff hunks whose *order* carries meaning, which a textual three-way
merge cannot resolve correctly. This bundle's entire provenance layer rests on
the opposite property — the [merge-strategy policy](/meta/policy/merge-strategy.md)
requires true merges specifically so cited SHAs and `git blame` answers stay
valid, and that only works because each document is its own file with its own
independent history. Neither `terse-spec/TERSE.md`, the specification, nor the
`terse-brain` README treats version control or merge semantics anywhere in
the reviewed tree, and the project's own repository has exercised the question
exactly once (one merged PR).

**2. Prose.** TERSE's atomic-attribute rule and container-only-text rule push
against prose by design — a `terse-brain` claim node is a fact with a
citation (`## attention is quadratic(source: @Raw.transformers-paper;
confidence: 0.95; born: 2026-07-19)` plus one sentence), not a distilled
document. That is a genuinely useful artifact and a different product from
this bundle's unit of knowledge. This repo's filing conventions
([capture-knowledge-cite-the-source](/meta/policy/capture-knowledge-cite-the-source.md)),
its plainspeak-orientation and banned-phrases rules, and its three-level
documentation direction all govern *prose bodies* — porting to TERSE would
make most of that machinery inapplicable rather than satisfied, not because
TERSE is worse, but because it is answering a different brief.

A third, smaller cost: `@Path.To.Node` references are positional. The
2026-07-10 field survey already recorded the same failure in vault-ld, the
only other spec-grade identity effort found, where "IRIs derive from paths, so
identity dies on rename." `terse-brain` detects the resulting breakage
(`BRAIN-A dangling-ref`, and a `WAS` rename directive exists) but whether
inbound `@` references are rewritten on rename was not verified from the code
read for this evaluation — either way, `BRAIN-A`'s existence implies breakage
is possible, which trades this bundle's A-grade identity dimension for
terse-brain's detected-but-not-prevented one.

## Two corrections against the code

An earlier, live-chat version of this evaluation made two claims from a quick
`grep`-based measurement rather than reading the enforcement code directly.
Both were wrong in the same direction — understating what this bundle already
checks — and are corrected here before either becomes a filed claim.

**"Index coverage has no gate."** Wrong. `ElixirMind.Links.check/1` already
ran an index-coverage pass as part of `mix brain.verify`'s output before this
session — it was advisory (`mix brain.verify` stayed green regardless), by an
explicit, documented design stance: "index coverage is ultimately editorial."
Running `mix brain.verify` against the tree at the start of this session
showed the check was live and non-trivial: 13 outstanding warnings, all
`holds docs but has no index.md`, concentrated in `evals/` — an imported
eval-snapshot corpus with its own `README`/`LICENSE`/`MANIFEST`, already
outside the taxonomy (`ElixirMind.Registry` already excludes it from the
stable-identity scan). A prior pass with a plain `grep` over existing
`index.md` files reported zero gaps, which was true only because it never
checked for directories missing an index entirely — exactly the case the real
check catches.

**"Gate index coverage" as a build-from-scratch idea.** Also wrong, in the
same direction — the mechanism already existed. What this evaluation actually
recommends, and what this session built, is *promoting* the half of the
existing check that was silently non-binding: a directory whose `index.md`
*already exists* but omits a doc or subdirectory filed beside it is now a
hard `mix brain.verify` failure (`ElixirMind.Verifier` rule 9,
`ElixirMind.Links.unlisted_errors/1`). A directory with *no* `index.md` at
all stays advisory, matching the [OKF-conformance policy](/meta/policy/okf-conformance.md)'s
explicit tolerance for an absent index; `evals/` is excluded from the hard
check for the same reason `Registry` already excludes it. `mix brain.verify`
exits `0` on the current tree under the new rule — the 13 live warnings are
all in the still-advisory "no index at all" class, and the previously-live
"subdirectory `evals/` is not listed" warning is now out of scope rather than
silently tolerated.

## What TERSE gets right that this bundle doesn't yet have

**Source hashing and drift detection — the real gap.** `register-source`
computes a sha256, records size/kind/origin, mirrors the bytes into
content-addressed storage, and flags `BRAIN-C raw-drift` when a source's hash
or origin path stops matching. This bundle records a `resource` URI and calls
it provenance, but nothing detects a captured page being silently edited or
taken down after intake — the verification ladder is stricter than
terse-brain's at the *statement* layer (`verified_by` at least guarantees the
cited evidence document still exists) and weaker at the *evidence* layer
(nothing guarantees the evidence still says what it said at capture time).
This is the one idea worth a design pass rather than a direct port — see the
companion plan filed alongside this analysis.

**Faceted query over typed attributes.** `? Wiki.Claims.* [WHERE Its HAS
disputed]` is a query shape this bundle's own
[615-document re-evaluation](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md)
graded C− on (32% plain-text recall). TERSE does not fix the *hard* half of
that gap — `CONTAINS` is substring matching, with no ranking or expansion, so
it is no better than grep at "what do I know about attention?" — but it is
better at *structured* questions: every unverified claim, every doc
attributed to a given channel, every belief with no inbound link. This
bundle's frontmatter already carries every field such a query would filter
on; the existing one-off slices (`brain.evidence`, `brain.orphans`,
`brain.lineage`) are instances of exactly this shape without a general query
surface over them. Worth a plan, scoped explicitly against — not instead
of — the deferred tier-2 BM25/embedding retrieval decision the 615-document
analysis already flagged as separately owed.

## One direct tension worth naming, not resolving here

The `using-terse-brain` skill states an "iron rule":

> "A TERSE declaration always succeeds when it parses. There are no partial
> application mysteries and no need to re-query 'to confirm' what you just
> wrote." … "Use queries only for discovery … never for write verification."
> — [`terse_brain/skills/using-terse-brain/SKILL.md`](https://github.com/terse-lang/terse/blob/637140a3a749f56a981cdb58d943f4fc1515c53b/apps/terse-brain/terse_brain/skills/using-terse-brain/SKILL.md)

That reads as a direct counter to this bundle's
[proposed post-action read-back plan](/meta/plans/post-action-readback-in-the-development-flow.md),
currently `status: proposed`. The two converge more than they collide: that
plan already declines in-tree read-back on the grounds that this bundle's gate
suite *is* the batch read-back, and terse-brain's rule is the same argument
made from parser totality (a declaration that parses cannot partially apply)
rather than from a gate suite. Where they would genuinely differ is the
boundary the plan actually draws: terse-brain's rule holds because the writer
and the state live in the same process, exactly the condition under which the
plan's grounding belief — "only what the other side produced is evidence"
(`em:01abda`) — does not apply, since there is no other side. The rule is
correct for terse-brain's system and would be wrong transplanted whole onto
this bundle's git/GitHub tail, where the calling session and the state genuinely
are different parties. Left as an unresolved note rather than a
recommendation — it sharpens *why* the read-back plan draws its boundary where
it does, without changing the plan's proposed scope.

## Recommendation

Do not adopt `terse-brain`, `terse-mcp`, or the TERSE format, in whole or as a
storage layer, for any part of this bundle. Take three ideas without the
format:

1. **Source hashing and drift detection** — filed as a companion `plan`.
2. **A frontmatter facet-query surface** (`mix brain.query`) — filed as a
   companion `plan`, scoped against the deferred BM25/embedding decision.
3. **Gate index-listing coverage** — done in this session (see corrections
   above); filed as a `done` `todo` for the record.
