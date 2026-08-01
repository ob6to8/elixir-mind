---
type: analysis
title: "The agent-memory strategy read against this bundle: adopt the retrieval tier, decline auto-formation, build the sidecar"
description: Reads the 2026 agent-memory field (mex, SuperLocalMemory, Mem0/Zep/Letta, the files convergence) against this bundle's architecture — finds the field moved toward what this bundle already is on formation and governance, that the one genuine gap is the long-graded retrieval weakness whose tier-2 fix is specified but unbuilt, and that the Elixir-native port is advised in reframed form: a file-canonical recall sidecar built as its own project, not a port of either seed repo.
provenance: "Claude Fable 5, memory-system research spike session, 2026-08-01 — landscape and gap evidence gathered by two background research agents; bundle-side figures checked live against the working tree"
tags: [meta, analysis, agent-memory, retrieval, dedup, embeddings, landscape, elixir, projects, tier-2]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T21:34:00Z
  channel: agent-authored
  agent: "Claude Code agent, memory-system research spike session"
  why: "operator asked what this repo could gain from the mex/SuperLocalMemory strategy, at what tradeoff, and whether an Elixir-native port is advised, viable, and a market gap"
---

# The agent-memory strategy read against this bundle

**Question.** The operator pointed `/intake` at
[mex](/knowledge/SWE/agentic/code-context/mex.md) and
[SuperLocalMemory](/knowledge/SWE/agentic/agent-memory/superlocalmemory.md)
and asked three things past the intake itself: what could this repo gain
from that strategy and at what tradeoff; whether the concepts should be
ported to an Elixir-native solution if none exists; and, if that idea is
advised, viable, and a real gap, to open a plan.

**Bottom line.** The strategy decomposes into a **formation** half (a
system that decides what to remember and writes it for you) and a
**retrieval** half (hybrid lexical+semantic recall over what is stored).
On formation and governance, the 2026 field moved *toward* what this
bundle already is — git-versioned curated files with write-gating — so
adopting the formation half would trade away the differentiator to buy the
field's documented failure mode. The retrieval half is the opposite story:
it is this bundle's weakest graded dimension, its fix is already specified
as tier-2 of the
[vector-DB recall analysis](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md),
and the strategy transfers cleanly — as a **sidecar**, so this repo's
zero-dependency invariant survives. The Elixir-native port is advised in
that reframed form and the plan is filed:
[projects/elixir-agent-memory](/projects/elixir-agent-memory.md).

## 1. Where this bundle sits in the field's own terms

The [landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md)
splits the field into formation-pipeline products and the curated-files
school. This bundle is the curated-files school with structural
enforcement — and 2026 was the year the field's leaders arrived where it
already stands: Letta rebuilt its coding-agent memory as "programmatic
context management and git-based versioning" (Context Repositories,
2026-02); LangChain shipped a markdown-wiki brain (OpenWiki, 2026-07);
Anthropic's memory tool is a file directory; write-gating products
(Total Recall, Cursor's approve/reject sidecar) re-invent deliberate
curation against the "junk drawer" failure their users report. The
[2026-07-10 field comparison](/meta/analysis/comparison-with-the-2026-second-brain-field.md)
found this bundle "past the public frontier" on enforcement; the memory
field's 2026 trajectory strengthens that finding rather than eroding it.

The security literature lands the same way from the adversarial side:
MINJA and MemGhost make memory a demonstrated injection surface, and the
defenses vendors are "weighing" — "provenance, audit logs, and
confirmation prompts" (per the landscape's MemGhost coverage) — are the
attribution, commit-graph, and ratification machinery this bundle already
runs. Auto-formation would open exactly the surface this architecture
closes.

**Where the field is ahead is retrieval, and the gap is measured, not
anecdotal.** The [615-document re-evaluation](/meta/analysis/second-brain-field-re-evaluation-at-615-documents.md)
graded retrieval C− ("grep + LLM-in-context; 32% plain recall; field has
moved past this"). Checked live against the working tree today: the
[dedup probe](/meta/evals/dedup-probe.md) scores plain 8/28 with expanded
23/28 — tier-1 synonym expansion holds recall at ~82%, and the formal
tier-2 trigger (plain recall regressing between runs) has **not** fired.
The subsidy argument still stands: the expanded mode works because the
model in the loop compensates, and that subsidy thins as the corpus grows
(164 knowledge docs now, up from 124 on 2026-07-29). The curated-files
school's own scaling story — the grep → BM25 → hybrid
[search progression](/knowledge/SWE/agentic/context-engineering/ai-agent-memory-management-markdown-files.md)
— places a corpus of this size at the BM25 step, which this bundle has
not taken: there is ranked-lexical headroom before embeddings are even
in question.

## 2. What the strategy offers this bundle, itemized

1. **Ranked lexical recall (BM25) — free of ML, unclaimed headroom.** The
   probe's cluster-saturation misses (queries surfacing 8–9
   undifferentiated files) are a ranking problem the recall analysis
   already attributed to lexical tooling, not semantics. This is tier L of
   the sidecar plan.
2. **Semantic dedup candidates (tier-2) — specified, unbuilt.** The
   contract exists verbatim in the recall analysis (embed
   title+description, brute-force cosine over a content-hash-keyed cache,
   surface top-5). What was missing was an implementation that doesn't
   break `deps: []`; the sidecar shape resolves that — the engine lives in
   its own repo, `/intake` consults it only when installed, and adoption
   is gated on a side-by-side measurement against the live gold set
   (build-order step 5 of the
   [plan](/projects/elixir-agent-memory/design-and-build-order.md)).
3. **Temporal validity — raises an existing plan's priority, files
   nothing new.** Graphiti's bi-temporal edges and LongMemEval's
   knowledge-update/abstention categories name the property this bundle
   lacks structurally: supersession. That is precisely the
   [epistemic overlay plan](/meta/plans/epistemic-overlay.md)'s territory
   (the probe's quarantine row already waits on it). The landscape is
   independent evidence that plan addresses a field-recognized gap.
4. **Task-aware routing at session start — a deferred borrow.** mex's
   router (load only task-relevant pages) is the one mex mechanism this
   bundle lacks an analog for; it lands as a deferred item in the sidecar
   plan, cheap once recall exists.
5. **Confirmation of the drift-detection direction.** mex's
   `check`/`sync` works because code gives the wiki a greppable ground
   truth to diff against; this bundle's knowledge layer has no such
   oracle, which is why its gates verify form, not semantics (the field
   comparison's standing caveat). The transferable piece — source hashing
   to detect when a captured source changed — is already a filed plan
   idea from the terse-brain evaluation, not new work discovered here.

## 3. What not to adopt, and why

**Auto-formation (hooks that write memories for you).** Three independent
evidence streams in the landscape converge against it: the community's
documented junk-drawer/confabulation failures and the corrective
write-gated products; ACE's context-collapse finding against
rewrite-in-place stores; and the injection-attack literature. Adopting it
here would additionally collide with ratified policy on every axis —
capture is deliberate ([session-capture](/meta/policy/session-capture.md)),
attribution is immutable, filing is dedup-gated, shape changes are
ratified. The failure chain the field comparison modeled names
agent-write-throughput as the accelerant; auto-formation is that
accelerant installed deliberately.

**Benchmark-culture objectives.** LoCoMo — the metric both seed repos'
genre optimizes — has ~6.4% wrong gold answers and a two-vendor
misconfiguration war over it; the files baseline (74.0%) beat the leading
pipeline's graph variant (68.5%) on it. This bundle's instrument —
recall@k over a versioned gold set of real operator phrasings — is the
methodologically honest version of what that benchmark pretends to
measure. Keep the instrument; ignore the leaderboard.

**A five-channel retrieval stack.** SuperLocalMemory's dense + BM25 +
temporal + Hopfield + spreading-activation fusion is the maximalist menu;
nothing in this bundle's measured failure modes (vocabulary mismatch,
cluster saturation) requires more than ranked lexical + one dense channel.
Channels beyond evidence are surface area, not recall.

## 4. The Elixir-native question

**Gap — real, but not empty; the search space is named.** The gap sweep
enumerated hex.pm API searches (~35 terms including memory/mcp/rag/
embedding/vector/mem0/zep/letta), GitHub repository and code searches,
Elixir Forum, awesome-elixir, and awesome-mcp-servers. Found: ~15
single-author Elixir memory experiments, all created Jan–Jun 2026, none
above 30 stars or ~1.5k downloads — jido_memory (Jido-official, 1.0.0),
mnemosyne, jiyi (pgvector + anubis_mcp service), recollect (the closest
technical cousin), graphonomous (deepest MCP server), spectre_mnemonic,
plus the gralkor family embedding Python Graphiti via PythonX. Absent
from that space: any Mem0 port, any mex/SuperLocalMemory port, any Elixir
entry in awesome-mcp-servers' memory category, any official MCP-org
Elixir SDK, and — the load-bearing absence — **any file-canonical,
eval-first entrant**: every one found is a store-canonical memory
database in the Mem0 mold.

**Viable — the blocks are present and current.** anubis_mcp 1.14.0 (the
de-facto Elixir MCP SDK, ~307k downloads, hermes-mcp's continuation);
Bumblebee 0.7.1 text-embedding serving (all-MiniLM/bge-class models run
in-BEAM); exqlite with FTS5 compiled in (verbatim in its Makefile:
"CFLAGS += -DSQLITE_ENABLE_FTS5=1"); pgvector-elixir at ~1M downloads;
hnswlib under elixir-nx if ANN is ever warranted. Demand is visible
(forum threads naming the memory-layer gap; seven independent authors
building into it within five months) while consolidation is absent.

**Advised — with the reframing and the risks stated.** Porting *either
seed repo* is not advised: mex's lane already has a big-vendor competitor
(LangChain OpenWiki) and its substance is code-graph tooling this bundle
files under code-context; SuperLocalMemory is the maximalist shape the
evidence argues against. What is advised is the position neither they nor
the Elixir crop occupies: the **file-canonical recall sidecar** — derived
disposable indexes over a curated markdown bundle, recall@k as the only
published number — with this brain as first customer (tier-2), the
two-tier fleet architecture as second (the
[librarian broker](/beliefs/glossary/librarian-write-broker.md)'s read
side), and the ecosystem slot as third. Risks, stated: the niche is
crowding fast (fifteen entrants in six months — the slot may not stay
open long); it is one more solo-maintained artifact; EXLA's compile
weight may deter small installs (the plan carries the ONNX alternative).
The recommendation would reverse if a file-canonical, eval-first Elixir
engine appears before build starts — the plan's refresh rule re-checks
the incumbent map at execution time.

## 5. Recommendation

1. **Formation stays as-is** — deliberate intake, capture, ratification;
   no hook-driven memory. The field's 2026 movement is evidence for this
   posture, not against it.
2. **Raise the epistemic-overlay plan's priority** — supersession/temporal
   validity is the one field-named property this bundle lacks
   structurally.
3. **Build the sidecar per the filed plan** — tier L (FTS5/BM25) and the
   eval harness first; embeddings only after, measured against the gold
   set.
4. **Adoption into `/intake` is a measurement decision** — the side-by-side
   probe (plain vs expanded vs engine@k) goes to the operator; nothing in
   this repo's gates ever depends on the engine.
5. **Re-read the landscape at the next field re-evaluation** — the
   convergence claim and the incumbent map both date quickly in this
   space.
