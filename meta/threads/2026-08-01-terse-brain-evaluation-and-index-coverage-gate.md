---
type: reference
title: 2026-08-01-terse-brain-evaluation-and-index-coverage-gate
description: Evaluated terse-lang/terse's apps/terse-brain (a Karpathy llm-wiki port onto the TERSE state format) against this bundle's methodology, filed as an analysis recommending against adopting the format while taking three of its ideas — source-hash drift detection and a frontmatter facet query (both filed as plans) and gating index-listing coverage (built and merged in the same session, correcting two claims the live evaluation had gotten wrong against the actual enforcement code).
provenance: "Claude Code session (Claude Opus 5, then Claude Sonnet 5 after a mid-session model switch), 2026-08-01; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, terse, karpathy, llm-wiki, second-brain, comparison, index-coverage, verifier, gate]
timestamp: 2026-08-01
session: https://claude.ai/code/session_01QJ8BM94dFhX5NSf2i981uQ
pr: 216
---

# 2026-08-01-terse-brain-evaluation-and-index-coverage-gate

## Where this landed

The operator asked for a plainspeak evaluation of `terse-lang/terse`'s
`apps/terse-brain` — a Karpathy `llm-wiki` port built on TERSE, a purpose-built
hierarchical state/query/mutation format — against this bundle's own
methodology, and whether any of it was worth adopting. `add_repo` refused a
cross-owner attach mid-session, so the evaluation read a public shallow clone
at `637140a` (2026-07-24, v0.4.1) instead. The verdict delivered in chat: no
adoption of the format or the app — a one-file mutable store under positional
`@`-path references fights this bundle's true-merge provenance model, and an
attributes-first node shape fights its prose-and-policy governance layer —
but three ideas worth taking without the format: hashing captured sources and
detecting drift, a general frontmatter facet query, and gating index-listing
coverage (framed at the time as building a coverage check from scratch).

The operator selected all four follow-up options — file the evaluation, and
take all three ideas — then asked to close with `/create-pull-request merge`.
Executing the index-coverage idea required reading `ElixirMind.Links` first,
which surfaced that the check already existed as an advisory pass inside
`mix brain.verify`, deliberately non-binding by a documented "index coverage
is ultimately editorial" stance — and that a live run showed 13 outstanding
warnings, all in `evals/` (an imported eval-snapshot corpus already outside
the taxonomy), not the "zero gaps" a quicker `grep`-based pass had reported.
Both corrections were folded into the filed analysis rather than left in
chat. The actual work became narrower and more precise than first framed:
split `ElixirMind.Links` so a directory's *existing* `index.md` omitting a
filed doc or subdirectory is now a hard `mix brain.verify` failure (new rule
9), while a wholly absent index and broken links stay advisory per OKF
conformance, with `evals/` excluded from the hard check to match `Registry`'s
existing precedent. The change touched two tutorials whose "the verifier adds
no new files to look at" and "all three scanners share one exclusion filter"
claims stopped being true once rule 9 opened a second scan surface, both
corrected in the same pass rather than left stale. Four governance docs were
filed (one analysis, two plans, one `done` todo), the full local gate suite
ran green throughout — including against the new hard gate's effect on the
session's own new docs — and the close proceeded via `/create-pull-request
merge`.

CI passed but the merge itself failed on real conflicts: `main` had moved 6
PRs since the branch was cut, including one that independently relocated
`evals/` to `meta/evals/cb-eval-export/` and another that claimed rule 9 for
a new `visualization`-type check. Resolving meant renumbering the new rule to
10 past the concurrent one (both function bodies had already auto-merged
correctly; only the numbered moduledoc list conflicted), regenerating
`meta/code-map.md` instead of hand-merging it, and combining both sides'
additions to two index listings. The `evals/` relocation made the just-shipped
name-based exemption dead code — the directory it named no longer existed —
so it was dropped outright rather than repointed: the general rule already
clears the relocated import without any exemption, since its new parent index
mentions it by name and its own subdirectories still carry no `index.md`
(the advisory case). The analysis, the todo, and both tutorials were corrected
again in the same pass so the shipped description matches the merged code,
not the pre-merge snapshot.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Whether to adopt terse-brain or the TERSE format | closed | [terse-lang-terse-brain-evaluation](/meta/analysis/terse-lang-terse-brain-evaluation.md) | - |
| Source hashing and drift detection for `resource`-bearing docs | open | [source-hash-and-drift-detection](/meta/plans/source-hash-and-drift-detection.md) | Opt-in vs. mandatory capture, re-fetch cadence, and reconciliation with the deferred `mix brain.staleness` todo all await ratification |
| A general frontmatter facet query surface | open | [frontmatter-facet-query](/meta/plans/frontmatter-facet-query.md) | Output format, AND-only vs. composable filters, and whether `status` joins the queryable facet set all await ratification |
| Gating index-listing coverage | closed | [gate-index-listing-coverage](/meta/todos/gate-index-listing-coverage.md) | - |
| The read-back plan's "only what the other side produced is evidence" test, sharpened against terse-brain's "declarations are fire-and-forget" rule | paused | [post-action-readback-in-the-development-flow](/meta/plans/post-action-readback-in-the-development-flow.md) | Named as a useful cross-check in the filed analysis but not acted on; the plan's own scope is unchanged |

## User

evaluate https://github.com/terse-lang/terse/tree/main/apps/terse-brain as it might apply to this repo
as well the entire repo methodology and system
evaluate, analyze, and present a plainspeak overview of the tech itself
worth considering adoption, or incorporating some of its ideas here?

## Assistant

## Plainspeak orientation

TERSE is a file format. Instead of writing structured data as JSON or YAML, you write it as an indented outline that reads like notes — headings for nesting, plain lines for things, parentheses for their properties. Alongside the format comes a small query syntax (`? System.Models.*  [WHERE Its.cost > 2]`) and a patch syntax, so one file can be read, filtered, and edited surgically by a program without either side losing the plot.

`terse-brain` is a small Python app built on that format. It is an explicit, self-described 1:1 port of Andrej Karpathy's `llm-wiki` sketch — the same pattern the repo you're standing in was also influenced by. Its pitch: the bookkeeping a markdown wiki maintains by hand (the index, the log, the schema, the cross-reference checks) comes free once the file format itself is queryable. A CLI registers source files with hashes, an agent distills them into a `# Wiki` section over MCP, six lint checks catch drift, and an HTML graph renders it.

My read: **don't adopt it, and don't port the format.** The two systems make opposite bets, and for what this repo is doing yours is the better-supported one — TERSE's structural gains land on bookkeeping this repo already compiles, and its costs land squarely on git and on prose, which are this repo's two load-bearing substrates. But three of its ideas are worth taking, and one of them closes a gap this repo genuinely has (unhashed source material) while another lands on the exact dimension your last self-evaluation graded C−.

---

## What the tech actually is

Read from a shallow clone at `637140a`, dated 2026-07-24; version 0.4.1, one merged PR in its history. Its own README states: "Status: pre-release. APIs and spec details may change before 1.0."

**The format.** Containers (`#`/`##`/`###`) carry hierarchy; bare-name lines under them are objects; parentheses carry attributes in three flavors — bare *flags* (`online`), keyed *identifiers* (`cost_M_usd: 1.5`), and unkeyed *raws*. `@Path.To.Node` is a cross-reference the parser knows about. `"""…"""` blocks hold container text. A bracketed tail at end-of-line carries *directives* — what to do, as opposed to what a thing is.

The design ethos is stated plainly and it is a real position, not decoration:

> **Names carry meaning.** Intrinsic identity lives in the name, not a bag of attrs. Prefer `steel sword` over `item(type: sword; material: steel)`.

> **Silence preserves.** What you do not restate, you do not change.

**Queries.** `? Path` with a composable bracketed tail: `[DEPTH 2]`, `[WHERE Its.hp > 20]`, `[CONTAINS "answer"]`, `[WHEN 2026-12-23]`, `[LAST 5]`, `[CONTAINERS]`. Results come back as valid TERSE with ancestors preserved, so a result is re-parseable and self-locating.

**Mutations.** Declarative patches. You declare the shape you want and the deltas; anything unmentioned survives. Directives cover placement (`FIRST`/`LAST`/`BEFORE`/`AFTER`), rename (`WAS`), removal (`REMOVED`), attribute merge (`MERGED`), and modes (`NEW`/`FILL`/`MOVED`/`AS`). Ordering is treated as state, which is why placement needs directives at all.

**The stack.** `terse-py` — lexer, parser, AST, state tree, query evaluator, file lock, atomic writer — zero runtime dependencies, ~28.5k lines including tests. `terse-mcp` wraps it as an MCP server with two tools (`terse_command`, carrying `declarations` and `queries` channels; `terse_info`) over named namespaces, each mapped to a store file. `terse-brain` sits on top with four fixed containers — `# Schema`, `# Raw`, `# Wiki`, `# Log` — a CLI (`init`, `wire`, `doctor`, `register-source`, `lint`, `stats`, `diagram`), six lint checks `BRAIN-A`…`BRAIN-F`, and a force-directed HTML graph.

**The engineering is good.** Zero-dependency parser, content-addressed source mirroring, atomic writes with locking, lint findings that are themselves valid TERSE so the agent can ingest its own report, moduledocs that carry rationale rather than restating code. The skill file is unusually well-written. This is not a weekend toy.

---

## Where it stands against this repo

Your own [2026-07-10 field comparison](https://github.com/ob6to8/elixir-mind/blob/main/meta/analysis/comparison-with-the-2026-second-brain-field.md) already surveyed this genre and placed Karpathy-pattern implementations in Tier 2. `terse-brain` is a new Tier-2 entrant and a strong one — it is the only implementation I've seen that ports the pattern onto a *purpose-built format* rather than onto Obsidian. It does not change that analysis's conclusion.

| Dimension | terse-brain | This repo |
|---|---|---|
| Identity | Positional — `@Wiki.Concepts.attention`, a normalized display name | Opaque minted `em:` ids, rename-proof, compiled registry |
| Storage unit | One store file, whole-tree | One markdown file per document |
| Version control | Unaddressed | The substrate: true merges, session trailers, cited SHAs, `git blame` |
| Knowledge body | Attributes + short text under a node | Distilled prose document with frontmatter |
| Verification | `source:` must resolve to a `# Raw` entry (BRAIN-F); `confidence:` is a self-reported float | `verified` restricted to statement types, rejected on captures, requires resolving `verified_by` edges |
| Source provenance | sha256 + size + kind + origin, bytes mirrored into `raw/`, hash-drift detected | `resource`/`provenance`/`attribution` — **no hashing, no byte mirroring** |
| Index | Computed (`? [DEPTH 2; CONTAINERS]`) | Hand-maintained `index.md` per directory |
| Query | Structured tree filters (`WHERE`/`CONTAINS`/`DEPTH`) | grep + `mix brain.*` slices |
| Governance | Schema container, six lint codes | 41 compiled policies, 15 CI gates, ratification protocol |
| Session record | Append-only typed `# Log` entries | Verbatim thread docs + routing ledger + route tags |
| Maturity | 0.4.1, pre-release, ~1 week since last commit | 686 commits, 188 tests |

### The three places adoption would actively cost you

**1. Git.** A one-file store means every write touches one file, and TERSE treats sibling order as semantically meaningful state. Two branches that each ingest something produce a conflict that a textual three-way merge cannot resolve correctly, because the diff hunks are adjacent lines whose *order* carries meaning. Your entire provenance layer is the merge commit graph — `Claude-Session:` trailers, docs citing commits by SHA, `git blame` as the answer to "which session changed this and why". I grepped `TERSE.md`, the full specification, and the `terse-brain` README for any treatment of version control or merging and found none; the project's own repo has a single merged PR, so the model has not been stressed. This is the disqualifying incompatibility, and it isn't a detail — it's the layer your merge-strategy policy is built on.

**2. Prose.** TERSE's rules push against prose by design. Attributes must be atomic; only containers hold multi-line text; the ethos favors telegraphic names over descriptive bodies. A `terse-brain` knowledge node looks like `## attention is quadratic(source: @Raw.transformers-paper; confidence: 0.95; born: 2026-07-19)` plus one sentence. That is a **fact table with citations** — a genuinely useful artifact, and a different product from a corpus of distilled documents. Your filing conventions, your plainspeak-orientation policy, your banned-phrases register, your three-level documentation plan — all of that machinery exists to govern *prose bodies*. Porting to TERSE would make most of it inapplicable rather than satisfied.

**3. Identity regression.** `@Path.To.Node` references are positional. The 07-10 survey already recorded the same failure in the one other spec-grade effort found — vault-ld, where "IRIs derive from paths, so identity dies on rename". `terse-brain` has a `WAS` rename directive and a `BRAIN-A dangling-ref` check, so breakage is *detected*; I did not verify whether inbound `@` refs are rewritten on rename, and the existence of BRAIN-A implies breakage can occur. Either way this trades an A-grade dimension for a C-grade one.

<routes ref="lib/elixir_mind/registry.ex lib/elixir_mind/links.ex">
### Where its critique lands on you

The README makes one pointed claim, and it is fair:

> The index is **computed**. Markdown needs a hand-written catalog because it can't enumerate itself; TERSE can. No stale index to forget to update.

Against raw markdown this is true; against this repo it is *half* true. `CLAUDE.md` and `meta/registry.md` are compiled with `--check` in CI — you are already past the criticism there. But `index.md` listings are hand-maintained by agents on every filing, with no coverage gate: `ElixirMind.Registry` excludes `index.md` from the scan entirely, and no verifier rule asserts that a directory's index lists its siblings.

I measured it: **0 documents missing from their directory index, across 76 index files.** Coverage is currently perfect — and entirely procedural. It's the one remaining hand-kept catalog in a repo whose whole thesis is converting procedural correctness into structural correctness, and drift there is silent until someone counts.
</routes>

### The claim I could not substantiate

"Token-Efficient" is the first word of the acronym and the project's headline promise. I searched the entire cloned tree for benchmark files, token counts, or measured comparisons and found none — the only relevant hits are the `terse-brain` README listing "Micro-benchmarks (planned as `terse-bench`)" under out-of-scope, and `terse-memory/LANDSCAPE.md` noting a competitor's "~90% token savings vs full-context — self-reported." So the flagship claim is unmeasured in its own repository. It's directionally plausible against JSON, which taxes every key with quotes and braces. Against *markdown with YAML frontmatter* — the actual comparison for you — I'd expect the difference to be small, since prose inside `"""` blocks costs the same either way.

---

## The three ideas worth taking

**1. Hash and mirror your sources. (The real gap.)** `register-source` computes sha256, records size/kind/origin, copies the bytes into `raw/` under a content-addressed name, and `BRAIN-C raw-drift` fires when a registered source's hash changes or its origin vanishes. This repo records a `resource` URI and calls it provenance — but a captured article can be silently rewritten or deleted and nothing here detects it. Your verification model is stricter than theirs at the *statement* layer and weaker at the *evidence* layer: `verified_by` guarantees the evidence document exists, never that the evidence still says what it said. Given that `source` captures are the foundation the whole verification ladder rests on, that's the asymmetry worth closing. A `mix brain.source_drift` that hashes fetched content at intake and re-checks it would be a genuine gate, and it fits the zero-dependency stance.

**2. Gate index coverage.** Cheap, mechanical, and it converts the last hand-kept catalog into a checked one. Coverage is clean today, which is exactly when to add the gate — you're locking in a passing state, not paying down debt.

**3. Faceted query over frontmatter — without the format.** `? Wiki.Claims.* [WHERE Its HAS disputed]` is the shape your retrieval story is missing. The [615-document re-evaluation](https://github.com/ob6to8/elixir-mind/blob/main/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md) graded retrieval C− at 32% plain recall. TERSE does *not* fix the hard half of that — `CONTAINS` is substring matching, with no ranking, stemming, or expansion, so it's no better than grep at "what do I know about attention?". What it is better at is **structured** questions: every unverified claim of a given type, every doc attributed to a channel, every belief with no inbound link. Your frontmatter already holds every field such a query would filter on, and `brain.evidence`/`brain.orphans`/`brain.lineage` are one-off slices of exactly this. A general `mix brain.query` over the registry would give you TERSE's actual query win at a fraction of the cost, and leaves the BM25 question — the one that moves the C− — untouched and separately decidable.

### One tension worth your attention

The `using-terse-brain` skill contains a rule stated as strongly as anything in your contract:

> **Iron rule: declarations are fire-and-forget** … A TERSE **declaration always succeeds** when it parses. There are no partial application mysteries and no need to re-query "to confirm" what you just wrote. … Use **`queries` only for discovery**.

That is a direct counter-position to the [post-action read-back plan](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/post-action-readback-in-the-development-flow.md) currently sitting at `proposed`. The two actually converge more than they collide: your plan already declines in-tree read-back on the grounds that the gate suite *is* the batch read-back, and terse-brain's rule is the same argument made from parser totality instead of from a gate suite. Where they genuinely differ is the boundary that matters — terse-brain's rule holds because the writer and the state are the same process, which is precisely the condition your `only what the other side produced is evidence` belief says does *not* obtain at the git/GitHub tail. The rule is right for its system and would be wrong transplanted whole. It's a useful sharpening of *why* your plan draws the line where it does.

---

## Actions I have taken

| Action | Result |
|---|---|
| Cloned `terse-lang/terse` (add_repo refused a cross-owner add; used a public shallow clone into the scratchpad) | `637140a`, 2026-07-24, v0.4.1 |
| Read `terse-brain` in full — README, skill, schema, `store.py`, `ingest.py`, `lint.py`, plus the TERSE written-form guide | Basis for everything above |
| Searched the cloned tree for benchmarks, git/merge handling, and dependency surface | No benchmarks; no version-control story; `terse-py` zero-dep, `terse-mcp`/`terse-brain` depend on `mcp` |
| Measured `index.md` coverage across this repo | 0 missing entries, 76 index files, no gate enforcing it |
| Checked prior art before writing | 07-10 field comparison, 07-29 re-evaluation, ontology-guardrails analysis — this evaluation extends them rather than repeating |

## Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | File this as a `type: analysis` under `meta/analysis/` | Follows the precedent of both prior field evaluations; adds forward pointers from the 07-10 and 07-29 analyses so the Tier-2 survey stays current |
| 2 | Take idea 1 — source hashing and drift detection | A plan or todo for `mix brain.source_drift`; the largest genuine gap this evaluation found |
| 3 | Take idea 2 — index coverage gate | Small enough to be a todo and execute directly; a verifier rule plus a CI line |
| 4 | Take idea 3 — `mix brain.query` over frontmatter facets | Worth a plan; overlaps the deferred tier-2 retrieval decision and should be scoped against it, not instead of it |
| 5 | Bookmark the repo and move on | `/bookmarks` the URL; no filing, no follow-up work |

I'd take 1 plus 2. Idea 2 is the finding with the most durable value and the one nothing else in the brain currently covers; idea 3 is the most tempting and the least urgent, since it improves questions you can already answer rather than the ones you can't.

## User

<local-command-caveat>Caveat: The messages below were generated by the user while running local commands. DO NOT respond to these messages or otherwise consider them in your response unless the user explicitly asks you to.</local-command-caveat>

1 2 3 4
then /create-pull-request merge

## Assistant

Got it — filing all four (analysis, source-drift plan, index-coverage gate as todo+implementation, and the `brain.query` plan), then closing with `/create-pull-request merge`. Let me look at the existing patterns before writing anything.

*(The rest of this turn was execution — reading existing plan/todo/analysis conventions and the relevant `lib/elixir_mind/` modules, implementing and testing the index-coverage change, writing the four governance docs, and re-running the full gate suite — carried out as tool calls with only short pre-tool narration between them, which this capture's drop rule strips. The outcome is recorded in the working diff and commit for this PR, in the four filed documents linked from the routing ledger above, and in the "What shipped" section of*
[gate-index-listing-coverage](/meta/todos/gate-index-listing-coverage.md)*.)*
