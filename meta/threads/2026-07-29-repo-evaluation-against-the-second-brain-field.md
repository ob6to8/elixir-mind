---
type: reference
title: 2026-07-29-repo-evaluation-against-the-second-brain-field
description: A graded evaluation of the repo against the 2026 second-brain field across fourteen dimensions, measured live against 8f0418d — landing an A-on-architecture/C+-on-contents verdict, a corrected link-integrity finding (zero hand-authored broken links, not twelve), a README refreshed to the present layout and gate suite, and the evaluation filed as an analysis that tests the 2026-07-10 comparison's prediction at 615 documents.
provenance: "Claude Code session (Claude Opus 5), 2026-07-29; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, evaluation, grading, second-brain, landscape, retrieval, corpus-composition, link-integrity, readme]
timestamp: 2026-07-29
session: https://claude.ai/code/session_01XGMF8Zw3DbevFk46hHvCBH
---

# 2026-07-29-repo-evaluation-against-the-second-brain-field

## Where this landed

The operator asked for the repo to be graded against the second-brain status quo,
by dimension. The evaluation was run by measuring the live bundle rather than
reading its self-description: the test suite, `brain.verify`, `brain.orphans`, and
`brain.dedup_probe` were run directly, corpus mass was counted per namespace, and a
link sweep was scripted for the session. The repo's own
[2026-07-10 field comparison](/meta/analysis/comparison-with-the-2026-second-brain-field.md)
was found early and used as the baseline to test rather than a survey to repeat —
its central prediction (that structural enforcement makes degradation bounded,
observable, and repairable past ~500 concepts) became the session's question, since
the corpus had since crossed that line at 615 bundle documents.

The verdict: fourteen graded dimensions, A-range on enforcement, identity,
portability, provenance, tooling, taxonomy, and self-instrumentation; C-range on
knowledge substance, verification practice, retrieval, and self-referentiality.
Two findings carried the weight — governance mass outweighs knowledge mass roughly
6:1 with 46% of the corpus being transcripts of the system's own construction, and
the field's front moved to retrieval (BM25/SQLite indexes, committed search DBs)
while the zero-dependency stance held this bundle at grep with 32% plain recall.

The operator picked the two follow-ups in order: fix the small stuff found in
passing, then file the evaluation. The first shrank on inspection — the twelve
"live-surface broken links" reported in the evaluation all resolved to generated
thread-excerpt lifts (fidelity-verified by `brain.route_tags`, so not
hand-correctable) or illustrative code spans, making the real count zero. That
correction was made in-session and carried into the filed analysis. What was
genuinely stale was `README.md`: it described a layout three namespaces out of date
and listed 8 of the 15 gates CI runs. The evaluation was then filed as a new
`analysis` rather than merged into the 2026-07-10 comparison, so the frozen
prediction being audited survives alongside its re-run, with forward and backward
pointers between them.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Graded evaluation of the repo against the 2026 second-brain field | closed | [second-brain-field-re-evaluation-at-615-documents](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md) | - |
| Testing the 2026-07-10 comparison's bounded/observable/repairable prediction at 615 docs | closed | [second-brain-field-re-evaluation-at-615-documents](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md) | - |
| Link-integrity measurement and its correction (12 → 0 live-surface breakages) | closed | [second-brain-field-re-evaluation-at-615-documents](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md) | - |
| README staleness: layout three namespaces behind, gate list 8 of 15 | closed | [README](/README.md) | - |
| Splitting plain vs. expanded dedup recall into separate CI trend lines | open | `unrouted` | Recommendation 3 of the analysis — the expanded figure moves with the synonym list, masking the tier-2 trigger condition; not yet filed as a todo |
| Duplicate governance artifacts and the unclimbed verification ladder as grade-capping gaps | paused | `unrouted` | Offered as option 4 at close; operator chose to file the analysis instead, so neither is tracked as its own issue |

## User

evaulate this repo against the status quo in knowledge bases/second brains. give it grades according to different dimensions of analysis

## Assistant

<routes ref="meta/analysis/second-brain-field-re-evaluation-at-615-documents.md">
## Orientation

Short version: this repo is two things stacked on each other, and they deserve very different grades. The machine that keeps the notes honest — the rules, the checks that run on every commit, the ID system that survives renames — is better than anything comparable I can find in public. The notes themselves are thin, narrow, and mostly about building the machine.

I ran the repo's own checks rather than reading its self-description: the test suite, the bundle verifier, the orphan check, the dedup probe, plus my own link-integrity sweep and a count of where the corpus mass actually sits. The repo already contains a field comparison (`comparison-with-the-2026-second-brain-field.md`, dated 2026-07-10, written when the corpus was 42 concepts). The interesting part is that its central open question — *does the enforcement bet hold past ~500 concepts?* — is now answerable, because the corpus crossed that line. So this evaluation is mostly an update against that prediction, not a re-run of it.

**Basis.** Every repo number below was measured this session at `8f0418d`. The field baseline is the repo's own dated survey, two web searches run today, and my training knowledge to May 2026 — I did not commission a fresh systematic survey of the landscape.

---

## Measured state

| Metric | Value |
|---|---|
| Age / activity | 20 days (first commit 2026-07-09), 686 commits, 132 merged PRs |
| Markdown docs (ex-`deprecated/`) | 1,028 |
| Bundle documents (`em:` ids) | 615 |
| Total corpus | ~840k words |
| Tooling | 21 modules, 17 `mix brain.*` tasks, 6,845 LOC lib / 3,085 LOC test |
| Tests | 188 passing, 0 failures |
| CI gates | 15 |
| Compiled contract | 41 policies → 103 KB `CLAUDE.md` |

**Where the mass actually sits** — this is the single most diagnostic number in the repo:

| Namespace | Docs | Avg words | Total | Share |
|---|---|---|---|---|
| `meta/threads/` (session transcripts) | 120 | 3,230 | 388k | **46%** |
| `knowledge/` (the actual knowledge) | 124 | 860 | 107k | **13%** |
| `beliefs/glossary/` | 473 | 218 | 103k | 12% |
| `meta/analysis/` | 45 | 1,695 | 76k | 9% |
| `meta/plans/` | 43 | 1,366 | 59k | 7% |

Health checks, run now: `mix brain.verify` passes; `mix brain.orphans` reports zero orphans; 188/188 tests pass; dedup probe scores 6/19 (32%) plain, 17/19 (89%) synonym-expanded. My link sweep over ~6,900 internal document links found 89 genuinely broken (excluding illustrative placeholders like `/kb/some-doc.md`) — **77 of which sit inside frozen thread records**, leaving ~12 on live surfaces, or 0.17%.

---

## Grades by dimension

| # | Dimension | Grade | One-line basis |
|---|---|---|---|
| 1 | Structural enforcement | **A+** | 15 CI gates; rules are build failures, not prompt prose |
| 2 | Identity & rename-survival | **A** | Opaque minted `em:` ids + compiled registry; 615 unique, zero collisions |
| 3 | Portability / lock-in resistance | **A+** | Plain markdown, zero runtime deps, git-native |
| 4 | Provenance & auditability | **A** | Machine-checked `attribution`, verbatim frozen threads, true-merge history |
| 5 | Tooling engineering quality | **A−** | 188 tests, warnings-as-errors, zero compile coupling, offline by doctrine |
| 6 | Taxonomy design | **A−** | Tree-is-taxonomy + ratification protocol; no orphans; index discipline holds |
| 7 | Self-instrumentation | **A** | Ships evals for its own weak spots — genuinely rare |
| 8 | Ingestion automation | **B** | `/intake`, `/research`, `/bookmarks` real; daily routine has a tracked failure |
| 9 | Scale evidence | **B−** | Crossed 500 nominally; failure-chain stages 2–3 are appearing (and being caught) |
| 10 | Knowledge substance | **C+** | 124 docs, 107k words, 70% concentrated in one subdomain |
| 11 | Epistemic rigor in practice | **C** | 5 docs `verified: true` vs 487 `verified: false` — the ladder is built, unclimbed |
| 12 | Retrieval | **C−** | grep + LLM-in-context; 32% plain recall; field has moved past this |
| 13 | Self-referentiality / overhead | **C−** | Governance mass ≈ 6× knowledge mass; 46% of corpus is transcripts of its own construction |
| 14 | Human usability | **C+** | 103 KB contract, 16 skills, 41 policies — steep for anyone but the author |

**Composite: A on architecture, C+ on contents.** Weighting them equally lands around **B**; weighting by what a knowledge base is *for* lands lower.

---

## The judgments behind the grades

**Where it is genuinely ahead of the field (1–4, 7).** The repo's July-10 survey claimed the field's integrity model is advisory — an LLM promising to follow prose — while this bundle's is structural. Today's searches don't overturn that. The closest public equivalents remain claude-obsidian (CI validates the plugin, not the knowledge) and the gitagent-protocol, which validates *agent behavior* in CI rather than corpus invariants. Nothing I found compiles the agent's own constitution from ratified source documents and fails the build when it drifts. The statements-vs-captures verification split (`verified` rejected on anything carrying a `resource`) is a real epistemological distinction that PKM products encode as a freeform confidence field, if at all.

Dimension 7 deserves emphasis: the repo builds evals that can embarrass it. The dedup probe reports 32% plain lexical recall in CI on every run. Most systems in this space have no instrument that can return bad news about themselves.

**Where the scale bet now stands (9).** The July-10 analysis predicted an advisory system dies past ~500 concepts and asked whether structural enforcement changes that. The corpus is now 615 bundle documents — but 473 are 218-word glossary entries, so the threshold was crossed *nominally*, not substantively. The genuine concept count is 124.

The predicted failure chain is nonetheless visibly starting, in the governance namespace where the write volume is highest. Two open issues are stages 2 and 3 verbatim: parallel sessions filing duplicate governance artifacts with nothing detecting it (fragmentation), and policy index glosses drifting silently when a policy's rule changes (cross-reference drift). The architecture's claim was never immunity — it was that degradation would be *bounded, observable, and repairable*. That claim is holding: both were detected and filed rather than rotting invisibly. Grade B− rather than higher because detection came from human attention, not from a gate.

**Where it is behind, and the gap widened (12).** The field's fast-moving front since the repo's survey is exactly retrieval. Today's search surfaced Wuphf (markdown + git with a Bleve BM25/SQLite index), pkb (a search DB committed to git, synced in CI), and Graphyte/Graphify-style knowledge graphs folded into Obsidian for Claude Code. Each of those keeps plain-markdown ownership *and* adds an index. This repo has grep and whatever the agent holds in context, and its 32% plain-recall figure is its own measurement of that.

The zero-dependency doctrine is what buys grade 3's A+ and what caps grade 12 at C−. That's a coherent trade, but the vector-DB analysis already specified the graduation path (cached brute-force intake-time embeddings, no DB), and the probe was built explicitly as its trigger. The trigger condition — recall degrading — is partly obscured: synonym expansion lifted the measured number to 89%, which masks that the underlying lexical layer still finds 6 of 19.

**The finding I'd put weight on (10, 13).** 46% of the corpus is session transcripts of building the system; 13% is knowledge. Governance mass outweighs knowledge mass roughly 6:1. Of the 124 knowledge documents, 86 are under `SWE/` and 58 under `SWE/agentic/` — the brain's subject matter is largely AI agents, which is to say largely itself. `machine-learning/` holds 5 documents, `startups/` 2.

This is defensible for a 20-day-old system in its bootstrap phase, and the incubation namespace under `projects/` shows the intended widening. But a second brain's value is proportional to what it can tell you that you didn't already know, and right now the highest-value thing it can tell you is how it works. The verification ladder (grade 11) is the same shape: an elegant, machine-enforced evidence model with 5 statements actually grounded through it out of 492 that could be. The machinery is real; the usage is not yet.

**Sustainability (8, 14).** 29 open plans (17 proposed, 10 accepted, 2 in-progress) against 14 done — the design backlog grows faster than execution. 19 open todos, 8 open issues. A 103 KB contract loaded every session is a large standing context cost, and it grows with every ratified policy. Neither is failing yet; both are trending in the direction that eventually forces a prune.

---

## Bottom line

Against the 2026 status quo, this is the most rigorously engineered personal knowledge system I can point to, and it is not close on the enforcement axis. It is also, right now, mostly a system that documents its own construction. The architecture has earned the right to hold a serious corpus; the corpus hasn't arrived yet.

The two moves that would change the grades most: **shift the write ratio toward `knowledge/`** (grade 10 is the cheapest large gain available, and it's a usage decision, not an engineering one), and **fire the tier-2 retrieval trigger** the repo already specified — the 32% plain figure is the signal, and the field is now shipping the answer with the portability stance intact.

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | File this as a `type: analysis` under `meta/analysis/` | Gives it an id and a durable home; updates the July-10 comparison rather than duplicating it (per update-in-place) |
| 2 | Nothing — leave it in chat | Evaluation is delivered; it scrolls off with the session |
| 3 | Drill into one dimension | E.g. a full retrieval-gap workup with the tier-2 decision made, or a knowledge-vs-governance rebalance plan |
| 4 | Fix the small stuff found in passing | ~12 live-surface broken links (mostly stale `/glossary/…` from the relocation) and a stale `glossary/` bullet in `README.md` |

Sources: The Agentic Digest — Git-based LLM wikis, dlants/pkb, SamurAIGPT/llm-wiki-agent, open-gitagent/gitagent-protocol, AgriciDaniel/claude-obsidian, lucasrosati/claude-code-memory-setup, kondens.me — Graphyte + Obsidian.
</routes>

## User

4, then 1

## Assistant

<routes ref="meta/analysis/second-brain-field-re-evaluation-at-615-documents.md">
Confirmed — every one of those twelve sits inside a `## Thread excerpts` block (generated verbatim from frozen threads) or an illustrative code span. My earlier figure was wrong in kind: hand-authored broken links on live surfaces is **zero**, not twelve. Let me check the README, which is a real live surface.
</routes>

## Orientation

Option 4 turned out smaller than advertised and option 1 is filed. The twelve "broken links" I reported last turn were not broken links — every one sits inside a generated block that quotes frozen session transcripts verbatim, or inside a code-formatted example. The repo's real count of hand-authored dead links on live pages is **zero**. That's a better result than I gave it, and it moves the link-hygiene evidence behind dimension 6.

What *was* stale is the README — the repo's front door described a layout three namespaces out of date and listed 8 of the 15 checks CI runs. I fixed that instead. The evaluation is now filed as an analysis with its measured baseline, so the next re-run has something to diff against.

### What I created

| Type | Doc | Why this type |
|---|---|---|
| `analysis` | `second-brain-field-re-evaluation-at-615-documents.md` | A reasoned judgment on a question, against evidence — not intended work (`plan`) or a defect (`issue`). Filed new rather than merged into the 2026-07-10 comparison, because that doc's value is the frozen prediction this one tests; overwriting it would destroy the thing being audited. |

### What I modified

| File | Thrust |
|---|---|
| `README.md` | Layout now lists `knowledge/`, `beliefs/` (with glossary at its real path), `projects/`, and the three non-bundle namespaces; gates paragraph rewritten to the actual 15; usage mentions `/research`, `/bookmarks`, `/journal`, `/create-pull-request` |
| `meta/analysis/comparison-with-the-2026-second-brain-field.md` | Forward pointer to the re-evaluation; its 2026-07-10 judgment untouched |
| `meta/analysis/index.md` | Gloss for the new analysis |

### Actions I have taken

| Action | Result |
|---|---|
| Link sweep across ~6,900 internal links, with excerpt-block and code-span exemptions applied | 0 hand-authored broken links on live surfaces; 77 inside frozen threads, correctly left alone |
| Full gate suite (verify, route_tags, glossary, contract/registry/codemap/lineage `--check`, format, xref, site) | All pass; 1,013 pages build |
| `mix test` | 188 passing, 0 failures |
| Commit `78150b9`, pushed to `claude/repo-knowledge-base-eval-jmd5q9` | Branch tracking origin |

Two things about how this landed. I widened option 4 past the single stale bullet you named, because the bullet and the missing `knowledge/` entry were the same defect — the README describing a layout that no longer exists — and fixing one while leaving the other would have been an odd place to stop. And the new analysis carries an advisory warning from `brain.verify`: `attribution.from` is unset. That's the designed sequence rather than a miss — `/create-pull-request` stamps it from the thread doc after `/capture` runs. It stays unset until you close the session that way.

No PR was opened; you didn't ask for one.

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | `/create-pull-request` | Captures the session, glossaries it, stamps `attribution.from`, opens the PR |
| 2 | Act on recommendation 3 from the analysis | Split plain vs. expanded recall into separate CI trend lines so the tier-2 trigger stays readable — small, and it unblocks reading dimension 12 honestly |
| 3 | Work dimension 10 | The knowledge-vs-governance ratio is the lowest-cost large grade gain, and it's a usage change rather than an engineering one |
| 4 | File the two grade-capping gaps as issues | Duplicate-artifact detection sits outside every gate; the verification ladder has 5 of 492 rungs climbed |

## User

1
