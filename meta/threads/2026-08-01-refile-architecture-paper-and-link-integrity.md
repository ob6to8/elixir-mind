---
type: reference
title: 2026-08-01-refile-architecture-paper-and-link-integrity
description: Operator questioned the filing of em:7fa867 under knowledge-management/design-rationale and proposed knowledge/development/architecture; agreed on the mis-filing but redirected to knowledge/SWE/agentic/architecture (development would duplicate the established SWE domain), executed the refile, then — prompted by the repo-wide sed the move required — evaluated id-referenced links with build-time path substitution and filed the judgment as an analysis plus a path-preserving plan.
provenance: "Claude Code session (Claude Opus 5), 2026-08-01; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, taxonomy, refile, links, stable-identity, tooling, verifier]
timestamp: 2026-08-01
session: https://claude.ai/code/session_018hjdRdzF1PRXk1cz5vnxVh
---

# 2026-08-01-refile-architecture-paper-and-link-integrity

## Where this landed

Two connected matters, the second falling out of the first. The operator
questioned where the *Architecture Without Architects* paper (`em:7fa867`) was
filed and proposed `knowledge/development/architecture`. The mis-filing was
real — the paper's subject is agent-shaped architecture, and it had been filed
beside three ADR-generation papers because its *remedy* section mentions
decision records — but `development` would have been a second name for the
established `knowledge/SWE/` domain, so the agreed destination became
`knowledge/SWE/agentic/architecture/`, the direct sibling of
`agentic/code-quality/`. The refile landed with all five inbound links, both
parent indexes, and the registry updated; one *Seen in* sentence in
`design-rationale.md` that asserted co-location ("captured beside this
concept") was recast, since a path rewrite leaves that class of prose false
while the link still resolves.

That repo-wide `sed` prompted the second matter: would `em:` id placeholders
with a build-time substitution step be cleaner? The judgment is no, and the
decisive finding is a coverage ceiling — 3,217 of the repo's 6,685 internal
links point into governance and non-bundle namespaces that never carry an id,
plus 284 at `index.md` files, capping the scheme near 49%, and directory
restructuring (the real source of bulk renames) breaks exactly the uncovered
half. The recommendation is two path-preserving moves instead: promote link
resolution from advisory warning to hard gate (free at today's zero warnings),
and add `mix brain.refile`. Both filed — the reasoning as an analysis, the
executable shape as a `status: proposed` plan.

A short exchange on whether "gloss" abbreviates "glossary" is recorded below;
it does not, and the term is contract-native for an `index.md` entry's
one-line description.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Where `em:7fa867` belongs; `development` vs. the established `SWE` domain | closed | [architecture-without-architects](/knowledge/SWE/agentic/architecture/architecture-without-architects.md) | - |
| Prose that asserts co-location breaks silently on a refile | closed | [structural link integrity](/meta/plans/structural-link-integrity.md) | - |
| Id-referenced links vs. path links: pros, cons, feasibility | closed | [id-referenced links vs. path links](/meta/analysis/id-referenced-links-vs-path-links.md) | - |
| Gating link resolution + `mix brain.refile` | open | [structural link integrity](/meta/plans/structural-link-integrity.md) | Plan is `status: proposed` — execution not ratified; directory-mode refile (`--dir`) left open, and it is where most of the bulk-rename value sits |
| "gloss" vs. "glossary" | closed | `unrouted` | - |

## User

see em:7fa867
i am thinking that this should live in knowledge/development/architecture. thoughts?

## Assistant

Read the doc, its four-paper cluster, and every inbound link. Short version: I agree it's mis-filed, but I'd push back on the proposed path — `development` would be a second name for a domain the tree already has, and the better home is one level deeper inside it.

### The naming problem with `knowledge/development/`

`knowledge/SWE/` is the established software-engineering domain (7 subdirectories, ~40 documents). `development` denotes the same thing. Creating it gives the tree two front doors to one domain — which is exactly the ambiguity [tree-is-the-taxonomy](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/tree-is-the-taxonomy.md) and [prefer-established-terminology](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/prefer-established-terminology.md) exist to prevent, and a future agent filing an architecture note would have to guess which. So: same instinct, but under `SWE/`.

### Where it actually belongs

<routes ref="em:7fa867">
Your instinct that it's mis-filed is right. Look at what the document *is*, not what it was cited for. Its substance is five mechanisms by which agents shape architecture and six prompt–architecture coupling patterns — "prompt wording alone produces structurally different systems for the same task". Only the *remedy* section (decision records, review tooling) touches design rationale, and that's what got it filed next to the three ADR-generation papers.
</routes>

Two candidates under `SWE`:

| Path | Case for | Case against |
|---|---|---|
| **`knowledge/SWE/agentic/architecture/`** | The subject is agent-shaped architecture. `agentic/`'s gloss is "AI agents, their runtimes, vendors, and **the practices they change**". Direct precedent sibling: `agentic/code-quality/` — "maintaining code quality and craft under AI-assisted development". This is that, for architecture. | New directory (autonomous per the taxonomy protocol — it's under an established top-level domain) |
| `knowledge/SWE/software-design/` | Exists; gloss covers "architectural styles" | Generic architecture, agent-agnostic — currently one ECS-pattern doc. Filing this there loses the *agentic* thing that makes it interesting |

I recommend `knowledge/SWE/agentic/architecture/`. It reads as the natural sibling of `code-quality`, and it's where the next paper on agent-driven architecture would land without anyone having to think about it.

### What moving costs

Cheap, and the `em:7fa867` id is unaffected — that's the whole point of stable identity. Five inbound path links to rewrite (`beliefs/glossary/vibe-architecting.md`, `survey/channels.md`, `meta/analysis/decision-records-as-history-abstraction.md`, `design-rationale/design-rationale.md`, plus the two `index.md` files), then regenerate `meta/registry.md`. The route-tag log inside the document travels with it and re-derives clean.

The cluster it leaves behind gets *more* coherent, not less: `design-rationale/`'s gloss is "the current research on automating decision-record capture with LLMs and agents", and the remaining three papers are all exactly that. This one was the outlier.

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Move to `knowledge/SWE/agentic/architecture/` (recommended) | Create the dir + `index.md`, `git mv` the doc, rewrite 5 inbound links and 2 indexes, regenerate the registry, run the gates |
| 2 | Move to `knowledge/SWE/software-design/` | Same mechanics, no new directory; drops the agentic framing from the address |
| 3 | Create `knowledge/development/architecture` as you proposed | Needs your ratification as a shape change, and I'd want to hear how it should relate to `SWE/` — if `development` is meant to eventually *replace* `SWE`, that's a different and much larger conversation worth having on its own |
| 4 | Leave it | The decision-records analysis cites it in place; nothing is broken, just imprecisely addressed |

Say the word and I'll execute whichever — the move itself is a single-session mechanical task, so no plan doc needed.

## User

is "gloss" short for "glossary"?

## Assistant

No — related word, different thing.

A **gloss** is a brief explanatory note attached to something else: a short definition or paraphrase set beside a term or passage. Historically, marginal or interlinear annotations in manuscripts. A **glossary** is a *collection* of glosses — both from Greek *glōssa* (tongue/language), so they share a root, but "gloss" isn't an abbreviation of "glossary".

In this repo I was using it in the contract's own sense: the one-line description that follows a link in an `index.md`. From [`knowledge/SWE/index.md`](https://github.com/ob6to8/elixir-mind/blob/main/knowledge/SWE/index.md):

```
- [agentic](/knowledge/SWE/agentic/index.md) — AI agents, their runtimes, vendors, and the practices they change
```

Everything after the em dash is the gloss. The term is contract-native, not something I improvised — [provenance-lives-in-metadata](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/provenance-lives-in-metadata.md) binds "the `index.md` gloss that lists the doc", and [negate-only-explicit-cases](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/negate-only-explicit-cases.md) scopes itself to "document bodies, index glosses, and agent responses alike".

So "the cluster it leaves behind" argument above was reading the `design-rationale/index.md` header prose, and "`agentic/`'s gloss" meant its one-line entry in the parent index — not anything to do with `/beliefs/glossary/`.

## User

agree, option 1

## Assistant

Done and pushed. The document now lives at [`knowledge/SWE/agentic/architecture/architecture-without-architects.md`](https://github.com/ob6to8/elixir-mind/blob/claude/architecture-docs-placement-1snwiq/knowledge/SWE/agentic/architecture/architecture-without-architects.md), as the sibling of `agentic/code-quality/`. Full gate suite is green (188 tests, all `mix brain.*` checks pass; the two warnings shown are pre-existing and unrelated — a 2026-07-13 thread's ledger cross-check and the standing glossary-repetition list).

### What I created

| type | doc | why this type |
|---|---|---|
| reserved | [`knowledge/SWE/agentic/architecture/index.md`](https://github.com/ob6to8/elixir-mind/blob/claude/architecture-docs-placement-1snwiq/knowledge/SWE/agentic/architecture/index.md) | required listing for a new directory |

### What I modified

| file | thrust of the change |
|---|---|
| `knowledge/SWE/agentic/architecture/architecture-without-architects.md` | `git mv` from `knowledge-management/design-rationale/` — content and `em:7fa867` untouched |
| [`knowledge/SWE/agentic/index.md`](https://github.com/ob6to8/elixir-mind/blob/claude/architecture-docs-placement-1snwiq/knowledge/SWE/agentic/index.md) | new `architecture` subdirectory entry |
| [`design-rationale/index.md`](https://github.com/ob6to8/elixir-mind/blob/claude/architecture-docs-placement-1snwiq/knowledge/knowledge-management/design-rationale/index.md) | dropped the entry; added a `## Related` pointer to the new home |
| [`design-rationale.md`](https://github.com/ob6to8/elixir-mind/blob/claude/architecture-docs-placement-1snwiq/knowledge/knowledge-management/design-rationale/design-rationale.md) | its *Seen in* list said all four papers were "captured beside this concept" — split the moved one out with a clause on why it sits elsewhere |
| `beliefs/glossary/vibe-architecting.md`, `survey/channels.md`, `meta/analysis/decision-records-as-history-abstraction.md` | path rewrites |
| `meta/registry.md` | regenerated |

One thing that turned out to matter more than the mechanics: the `design-rationale.md` sentence was quietly asserting co-location as part of its meaning, so the move made it false rather than just stale. That's the class of breakage a path rewrite doesn't catch — the link resolved fine, the prose around it didn't. Worth watching for on any future refile.

The four papers still form one cluster by `verified_by` and route-tag co-feeds; only the address changed, which is exactly what the stable-id design buys.

**Options from here:** the branch is pushed with no PR — say the word and I'll open one (`/create-pull-request`), or leave it sitting if you want to batch more taxonomy work onto it first.

## User

see something like:

"[architecture-without-architects](/knowledge/knowledge-management/design-rationale/architecture-without-architects.md),
[architecture-without-architects](/knowledge/SWE/agentic/architecture/architecture-without-architects.md)," in the diff

every time a url is changed for a resource, the entire knowledge base must be grepped for instances of links, and the urls changed there. would it be cleaner to have the id of the resource, maintain an index which maps resources to urls, and then have a build step which automates the substitution of the placeholder ids for the urls? this would break linking in github, but could allow for better knowledge base health in the pages deploy. pros/cons/feasibility?

## Assistant

What you're seeing is the unified diff's `-`/`+` pair — one line removed, one added. The file itself carries a single link. But the concern behind it is real: I did run a repo-wide `sed`, and nothing structurally forced me to get it right.

So: the proposal is more buildable than you'd expect — most of the machinery already exists — but it can only protect about half the links in the repo, and it breaks the surface where you actually audit. I'd recommend two cheaper moves that solve the failure mode you're pointing at without changing link syntax at all.

### Feasibility: high

Almost every piece already exists:

| Piece the proposal needs | Status today |
|---|---|
| An id → path index | [`meta/registry.md`](https://github.com/ob6to8/elixir-mind/blob/main/meta/registry.md) — generated from per-file frontmatter, CI-checked with `--check`. Can't drift by construction |
| A build-time id → path map | `Site.build_id_index/1` (`lib/elixir_mind/site.ex:169`) — already built every run, already used for `verified_by` evidence rows and "Cited by" backlinks |
| A single choke point for link rewriting | `Markdown.rewrite_href/2` (`lib/elixir_mind/markdown.ex:433`) — already a `cond` that rewrites `.md` → `.html` and resolves relative paths. An `em:` branch is one clause |
| A resolver for the verifier | `Links.resolve_target/2` (`lib/elixir_mind/links.ex:112`) |

Call it 100–150 lines plus a migration pass. The build step is genuinely small.

### The problem: the scheme tops out at ~half the links

| Measured | Count |
|---|---|
| Internal `.md` links across the repo | 6,685 |
| → into `meta/` `inbox/` `survey/` `journal/` — namespaces that **never** carry an `em:` id | 3,217 (48%) |
| → at `index.md` files — reserved, no id, ever | 284 (partly overlapping) |
| Docs carrying an `em:` id | 661 of 1,306 |

Ids are a *bundle-document* property. Policies, plans, threads, analyses, todos, digests, bookmarks, journal entries and every `index.md` are structurally outside the identity registry — that's a deliberate contract decision, not an oversight. So you'd get a bundle where a link's **syntax depends on which namespace it points at**, and an author has to know the target's namespace before knowing how to write the link.

Worse, the correlation runs the wrong way. Bulk renames come from *directory* moves — and directory moves hit `index.md` links and governance cross-links hardest. Those are precisely the links ids cannot protect. Today's move is the atypical case: a single bundle doc with five inbound links.

### Pros / cons

**Pros**
- Moves become free for the ~49% of links that are id-addressable
- Link integrity becomes *structural* rather than procedural for those
- Grep gets sharper, not duller — `grep -rn "em:7fa867"` is exact, where today I grep a slug substring that can collide
- The Pages site could resolve ids to canonical URLs, and dead-link risk on the published site drops

**Cons**
- **~51% coverage gap** — mixed syntax, namespace-dependent, and the gap sits exactly where bulk renames concentrate
- **Breaks the GitHub blob view**, which [response-resource-links](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/response-resource-links.md) elevates specifically because "A blob URL is viewable at **any** merge state, which is exactly when the operator audits". Doc bodies become non-navigable at review time — the one moment they must be
- **Adds indirection to the brain's hottest read path.** A fresh sandboxed agent doing progressive disclosure from `/index.md` currently follows a path by reading that file. Under ids it must load a 660-row registry to resolve any link. That's a tax on every read, paid to save a cost incurred 11 times in the repo's history
- **Authoring friction on every link** — you must look up an id instead of writing the path you just read
- **Makes the bundle a demanding producer.** [OKF conformance](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/okf-conformance.md) asks consumers to tolerate broken links; a foreign consumer of this bundle would get links it cannot resolve at all without our build step

### The economics

159 renames, across **11 commits** in the repo's entire history — batched migrations, not a steady drip. And the current state is clean: `ElixirMind.Links.check()` returns **0 warnings** over all 6,685 links right now. The mechanism you're worried about is not currently failing; it's just unguarded.

### What I'd do instead

Two moves, both small, that address the actual failure mode — *a move that silently leaves a stale link*:

**1. Promote link resolution from warning to gate.** `mix brain.verify` already computes this and prints it as advisory ("Warnings never fail the task — broken links are tolerated per OKF conformance", `lib/mix/tasks/brain.verify.ex:11`). But that OKF clause governs being a tolerant *consumer of a foreign bundle*; it says nothing about how strict CI should be on our own. The warning count is zero today, so promoting it costs nothing and makes a missed rewrite un-mergeable rather than a line of console noise. This is the whole safety benefit of the id scheme, for one gate flip.

**2. Add `mix brain.refile <id-or-path> <new-path>`.** One command that does the `git mv`, rewrites every inbound link, updates both parent indexes, and regenerates the registry — with tests. That converts today's manual grep-and-sed into a verified operation, and unlike the id scheme it covers **100%** of links, governance and `index.md` included.

Together those give you structural link health with no syntax change, no GitHub breakage, and no read-path indirection. If moves ever became frequent enough that #2 felt insufficient, the id scheme would still be available — and #1 would already have paid for the migration's safety net.

| # | Option | What it entails |
|---|---|---|
| 1 | Both moves above (recommended) | Gate flip is ~10 lines; `brain.refile` is a new mix task, maybe half a day with tests |
| 2 | Gate flip only | Free today; leaves the manual dance but makes a miss impossible to merge |
| 3 | Build the id-link scheme | ~150 lines + migration; accept ~51% coverage and the GitHub/read-path costs |
| 4 | File this as an `analysis` first | The judgment is standalone and will recur; [governance-artifact-routing](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/governance-artifact-routing.md) would type it `analysis`. Worth it if you want the reasoning queryable rather than only in this thread |

I'd take 1, and 4 alongside it if you want the "why not ids" recorded — the question is likely to be asked again.

## User

file in an analysis, and plan if appropriate

## Assistant

Both filed and pushed. Gates green (188 tests, all `brain.*` checks; the two warnings are the expected missing `attribution.from`, which `/create-pull-request` stamps once the thread doc exists).

### What I created

| type | doc | why this type |
|---|---|---|
| `analysis` | [id-referenced-links-vs-path-links](https://github.com/ob6to8/elixir-mind/blob/claude/architecture-docs-placement-1snwiq/meta/analysis/id-referenced-links-vs-path-links.md) | a reasoned judgment on a question, against evidence — the measurements are the argument |
| `plan` | [structural-link-integrity](https://github.com/ob6to8/elixir-mind/blob/claude/architecture-docs-placement-1snwiq/meta/plans/structural-link-integrity.md) | `status: proposed`. Deferred work needing a cold-context handoff, which is the [plan-vs-capture](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/plan-vs-capture.md) trigger — this session won't build it, so the decisions have to survive it |

### What I modified

| file | thrust of the change |
|---|---|
| `meta/analysis/index.md`, `meta/plans/index.md` | listed both, with the analysis→plan graduation link in each direction |

The plan body follows [structured-plan-bodies](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/structured-plan-bodies.md): current/desired-state trees for the verify flow, a file-tree diff, `@spec` signatures, boundary decisions, the test topology, and anchors segregated at the end with the refresh instruction.

Two things surfaced while writing it that weren't in my earlier answer:

**The frozen set is per-construct, not per-file.** A refile task must *not* rewrite prose links inside `meta/threads/` — those are frozen history, which is why `Links` already exempts them — but it *must* rewrite `<routes ref="path">` back-links in those same files, because `mix brain.route_tags` verifies all 149 of them. Getting that backwards would either corrupt the record layer or break a gate.

**`plan/3` pure, `apply/2` effectful** is what makes the thing testable. It also means `--dry-run` is the same code path as the real run, rather than a parallel implementation that drifts.

The one genuinely open question I left in the plan: single-document refile is the testable first cut, but the bulk-rename pain is *directory* moves — so a `--dir` mode is where most of the value actually sits. I deferred it rather than guessing, since it inherits all the single-doc machinery anyway.

**Options from here:** the branch has two commits and no PR. Say the word for `/create-pull-request` (which will also stamp `attribution.from` on both new docs), or leave it open if you want to ratify the plan's status first — it's `proposed`, and move #1 is small enough to just build if you'd rather have it than plan it.
