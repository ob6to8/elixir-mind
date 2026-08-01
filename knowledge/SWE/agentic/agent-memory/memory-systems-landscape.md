---
id: em:dd64c2
type: reference
title: "Memory systems for coding agents — the 2026 landscape"
description: Survey of the agent-memory field as of 2026-08-01 — the formation-pipeline products (Mem0, Zep/Graphiti, Letta) versus the curated-files school the field converged toward in 2026, the LoCoMo benchmark wars, memory-injection security research, and an evidence-graded proven-vs-hype ledger.
provenance: "Compiled by Claude Fable 5 from a 2026-08-01 web sweep (two background research agents; verbatim spans carry their source URLs, secondary attributions marked)"
tags: [agent-memory, landscape, mem0, zep, graphiti, letta, memgpt, locomo, longmemeval, benchmarks, memory-injection, context-engineering, claude-code]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T21:34:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked for a research spike into alternatives, the landscape, learnings, and what is hype versus proven"
---

# Memory systems for coding agents — the 2026 landscape

Two schools structure the field. The **formation-pipeline school** treats
memory as a store the system writes for you: an LLM extracts salient facts
from interactions into a vector/graph database, and retrieval injects them
back (Mem0, Zep/Graphiti, Cognee, LangMem, and the academic cluster —
MemGPT, A-MEM, HippoRAG, MemOS, MIRIX). The **curated-files school** treats
memory as documents an agent (or human) deliberately maintains and searches
(CLAUDE.md and Claude Code auto memory, Cline's Memory Bank, Anthropic's
memory tool, [Manus's file-system-as-context](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md),
[mex](/knowledge/SWE/agentic/code-context/mex.md), basic-memory — and this
bundle itself). The prior captures
[when markdown files are all you need](/knowledge/SWE/agentic/context-engineering/ai-agent-memory-management-markdown-files.md)
and [the markdown-folder migration report](/knowledge/SWE/agentic/context-engineering/markdown-folder-beat-a-vector-db-as-agent-knowledge-base.md)
argued the second school's case; what 2026 added is the field's leaders
moving there.

## The 2026 convergence on files

- **Letta** — the MemGPT lineage company (~24k stars; "$10 million in seed
  funding led by Felicis at a $70 million post-money valuation",
  [TechCrunch](https://techcrunch.com/2024/09/23/letta-one-of-uc-berkeleys-most-anticipated-ai-startups-has-just-come-out-of-stealth)) —
  shipped **Context Repositories** (2026-02-12): "a rebuild of how memory
  works in Letta Code based on programmatic context management and
  git-based versioning", with agents managing "their own progressive
  disclosure by reorganizing the file hierarchy, updating frontmatter
  descriptions, and moving files in and out of `system/`", and concurrent
  subagents isolated in git worktrees
  ([letta.com/blog/context-repositories](https://www.letta.com/blog/context-repositories)).
  Synthesis: the inventor of database-style agent memory rebuilding its
  coding-agent memory on git-versioned files is the strongest single trend
  signal in the field.
- **LangChain** shipped OpenWiki ("OpenWiki is a CLI that writes and
  maintains agent documentation for your codebase" —
  [github.com/langchain-ai/openwiki](https://github.com/langchain-ai/openwiki))
  and OpenWiki Brains (2026-07-10): "OpenWiki can now create a
  general-purpose brain for your agents" — a local, auto-refreshed markdown
  wiki ([langchain.com blog](https://www.langchain.com/blog/introducing-openwiki-brains-general-purpose-wiki-memory-for-agents)).
- **First-party memory is file-shaped.** Anthropic's memory tool (GA on the
  Messages API): "The memory tool lets Claude store and retrieve information
  across conversations in a directory of memory files.", with the injected
  instruction "ASSUME INTERRUPTION: Your context window might be reset at
  any moment, so you risk losing any progress that is not recorded in your
  memory directory."
  ([platform.claude.com docs](https://platform.claude.com/docs/en/agents-and-tools/tool-use/memory-tool)).
  Claude Code: "Auto memory is on by default." — a per-repo `MEMORY.md`
  plus topic files, of which "The first 200 lines of MEMORY.md, or the
  first 25KB, whichever comes first, are loaded at the start of every
  conversation." ([code.claude.com/docs/en/memory](https://code.claude.com/docs/en/memory)).
- **Retrieval in the leading coding agent is agentic search, not RAG.**
  Boris Cherny (Claude Code's creator): "Early versions of Claude Code used
  RAG + a local vector db, but we found pretty quickly that agentic search
  generally works better. It is also simpler and doesn't have the same
  issues around security, privacy, staleness, and reliability."
  ([x.com/bcherny](https://x.com/bcherny/status/2017824286489383315));
  quoted across secondary sources from the Latent Space podcast as agentic
  search having "outperformed everything. By a lot." (secondary
  attribution). The counter-position exists and is vendor-shaped: Milvus,
  "Why I'm Against Claude Code's Grep-Only Retrieval? It Just Burns Too
  Many Tokens"
  ([milvus.io](https://milvus.io/blog/why-im-against-claude-codes-grep-only-retrieval-it-just-burns-too-many-tokens.md)).

## The formation-pipeline products

- **Mem0** — "Universal memory layer for AI Agents" (~62.3k stars); $24M
  raised; per TechCrunch's report of company figures: 186M API calls in
  Q3 2025 and AWS's Agent SDK using it as "exclusive memory provider";
  CEO: "Memory is becoming one of their key moats now that LLMs are
  getting commoditized."
  ([TechCrunch, 2025-10-28](https://techcrunch.com/2025/10/28/mem0-raises-24m-from-yc-peak-xv-and-basis-set-to-build-the-memory-layer-for-ai-apps/)).
  Architecture (synthesis): LLM extracts candidate memories, then
  ADD/UPDATE/DELETE/NOOP against a vector store; a graph variant adds
  "around 2% higher overall score than the base"
  ([paper](https://arxiv.org/abs/2504.19413)). Its 2026 README claims
  "92.5 on LoCoMo" and "94.4 on LongMemEval" for the platform, with the
  caveat "open-source users should expect directionally similar gains but
  not identical numbers." ([github.com/mem0ai/mem0](https://github.com/mem0ai/mem0));
  its "State of AI Agent Memory 2026" report (published 2026-08-01)
  introduces a self-authored scale benchmark, BEAM, on which it self-reports
  64.1 (1M tokens) degrading to 48.6 (10M)
  ([mem0.ai](https://mem0.ai/blog/state-of-ai-agent-memory-2026)).
- **Zep / Graphiti** — the temporal-knowledge-graph position: bi-temporal
  edges (event time and ingestion time; contradictions expire edges via
  validity intervals rather than deleting them — synthesis of the
  [paper](https://arxiv.org/abs/2501.13956), which claims DMR 94.8% vs
  MemGPT's 93.4% and LongMemEval "accuracy improvements up to 18.5%").
  Graphiti the OSS engine passed 20k stars (Zep blog) with a third-party
  2026 guide citing "over 45,000 GitHub stars"
  ([contextgraph.tech](https://www.contextgraph.tech/learn/open-source-context-graph-tools)).
  Its durable contribution regardless of product outcome: **temporal
  validity as a first-class memory property**.
- **Letta** — memory blocks + "sleep-time compute"
  ([arXiv:2504.13171](https://arxiv.org/abs/2504.13171)) before the 2026
  files pivot above.
- **LangMem** — LangChain's memory SDK (semantic/episodic/procedural,
  hot-path + background managers), "still pre-1.0 — latest release is
  0.0.30 from October 2025" per a third-party tracker (secondary); LangChain's
  2026 energy visibly moved to OpenWiki (synthesis).
- **Cognee, MemOS, MIRIX, A-MEM, HippoRAG** — the graph/OS-metaphor cluster;
  all carry vendor-run or paper-self-reported LoCoMo-family claims (MemOS:
  "159% improvement in temporal reasoning over OpenAI's global memory" per
  its [paper](https://arxiv.org/abs/2507.03724); MIRIX six memory types and
  "85.4%" LoCoMo; A-MEM the Zettelkasten variant, NeurIPS 2025; HippoRAG
  the hippocampal-indexing PPR retriever, NeurIPS 2024). None found with
  independent third-party evaluation in this sweep.

## The Claude Code ecosystem specifically

- **claude-mem** (thedotmack) — hook-driven session compression into
  SQLite+FTS5 with Chroma hybrid retrieval; the fastest-growing memory tool
  by stars (~89.3k on the 2026-08-01 page fetch) — against which: its HN
  submissions drew 1–2 points, and its tracker carries "Uses too much
  tokens" ([#618](https://github.com/thedotmack/claude-mem/issues/618)) and
  a plugin that "doesn't respect disabled state"
  ([#781](https://github.com/thedotmack/claude-mem/issues/781)). The
  star-count-to-scrutiny ratio is the anomaly; no evaluation of its recall
  quality was found in this sweep.
- **basic-memory** (3.5k stars, AGPL) — "Pick up right where you left off —
  in Claude, Codex, Cursor, ChatGPT, or anything that speaks MCP." — plain
  local markdown + wiki-links as the graph, bidirectionally editable,
  Obsidian-vault compatible
  ([github](https://github.com/basicmachines-co/basic-memory)).
- **Cline Memory Bank** — the documentation-as-memory pattern: a mandated
  file hierarchy (projectbrief, activeContext, progress, …) with the rule
  "Cline MUST read ALL memory bank files at the start of EVERY task"
  ([docs.cline.bot](https://docs.cline.bot/best-practices/memory-bank)).
- **Cursor Memories** (1.0, June 2025): "With Memories, Cursor can remember
  facts from conversations and reference them in the future"
  ([changelog](https://cursor.com/changelog/1-0)); a sidecar model proposes
  memories for approval (secondary sources). **Windsurf Cascade Memories**:
  auto-generated, workspace-scoped (secondary sources; primary docs not
  fetched in this sweep).
- **Beads** (Steve Yegge): "a magical 4-dimensional graph-based git-backed
  fairy-dusted issue-tracker database, designed to let coding agents track
  all your work and never get lost again"
  ([x.com/Steve_Yegge](https://x.com/Steve_Yegge/status/1977645937225822664)),
  ~18.7k stars per third-party trackers — and the counter-signal: "Show HN:
  I replaced Beads with a faster, simpler Markdown-based task tracker" drew
  84 points ([HN](https://news.ycombinator.com/item?id=46487580)).
- **First-party consumer memory diverges by vendor** (third-party teardown,
  [shloked.com](https://www.shloked.com/writing/claude-memory)): "Claude
  recalls by only referring to your raw conversation history. There are no
  AI-generated summaries or compressed profiles—just real-time searches
  through your actual past chats." — versus ChatGPT's synthesized,
  always-injected profile, whose 2026 "Dreaming V3" update consolidates
  asynchronously and silently self-revises memories (secondary coverage;
  OpenAI's own post returned 403 to fetch).

## The benchmark wars

LoCoMo (Snap Research, ACL 2024 lineage; 10 conversations, ~2k questions)
is the field's headline benchmark and its least trustworthy artifact:

- An independent benchmark archive counts "~99 incorrect golden answers" —
  "6.4% of 1,540 questions" — implying a hard ceiling near "93.57%", and
  concludes "headline numbers are frequently incomparable across systems
  due to metric confusion, dataset quality issues, and non-reproducible
  methodology"
  ([lhl/agentic-memory](https://github.com/lhl/agentic-memory/tree/main/benchmarks)).
- Zep on its fitness: "conversations in LoCoMo average around 16,000-26,000
  tokens. While seemingly long, this is easily within the context window
  capabilities of modern LLMs." and "Mem0's own results show their system
  being outperformed by a simple full-context baseline"
  ([blog.getzep.com](https://blog.getzep.com/lies-damn-lies-statistics-is-mem0-really-sota-in-agent-memory/)).
- **The Mem0↔Zep dispute, both sides.** Zep: "Mem0 recently published
  research claiming to be the State-of-the-Art in Agent Memory, besting
  Zep. In reality, Zep outperforms Mem0 by 10% on their chosen benchmark."
  — alleging misconfiguration ("Mem0 utilized a user graph structure
  designed for single user-assistant interactions but assigned the user
  role to both participants.") (same URL). Mem0's CTO counter-filed
  "Revisiting Zep's 84% LoCoMo Claim: Corrected Evaluation & 58.44%
  Accuracy", alleging Zep scored itself on the adversarial category
  "specifically designated for exclusion"
  ([getzep/zep-papers#5](https://github.com/getzep/zep-papers/issues/5)).
  Two vendors, one benchmark, mutually alleged misconfiguration, no
  neutral referee — synthesis: treat every vendor-run LoCoMo number,
  including [SuperLocalMemory](/knowledge/SWE/agentic/agent-memory/superlocalmemory.md)'s,
  as marketing surface.
- **The files baseline embarrasses the pipelines.** Letta measured "74.0%
  accuracy on LoCoMo by simply storing conversation histories in files"
  (agent with grep/open/search tools on gpt-4o-mini) versus "68.5%" for
  Mem0's top graph variant, while noting the deeper problem: "evaluating
  the effectiveness of these memory tools in isolation is extremely
  challenging" because scores track the agent harness
  ([letta.com/blog/benchmarking-ai-agent-memory](https://www.letta.com/blog/benchmarking-ai-agent-memory/)).
  ConvoMem (Nov 2025) argues the same from academia: "Why Your First 150
  Conversations Don't Need RAG"
  ([arXiv](https://arxiv.org/html/2511.10523v1)).
- **LongMemEval** (ICLR 2025, academic) is the more rigorous instrument:
  five abilities including knowledge updates and abstention, scalable
  histories, and a measured "30% accuracy drop" in commercial assistants
  across sustained interaction (search-summary figures;
  [github.com/xiaowu0162/LongMemEval](https://github.com/xiaowu0162/LongMemEval)).

## Memory as an attack surface

- **MINJA** (arXiv:2503.03704): memory injection "solely through
  interacting with the agent", with reported injection success above 95%
  (paper-reported figures via summaries).
- **SpAIware** (Rehberger): prompt injection persisting exfiltration
  instructions in ChatGPT memory (patched) and a Windsurf variant
  ([embracethered.com](https://embracethered.com/blog/posts/2025/windsurf-spaiware-exploit-persistent-prompt-injection/)).
- **MemGhost** (July 2026): stealth memory injection via one crafted email
  — "87.5% effectiveness in background mode against OpenClaw on GPT-5.4"
  and "71.4% against Claude Code SDK on Sonnet 4.6"; vendors responded by
  "weighing memory-write controls for external content, including
  provenance, audit logs, and confirmation prompts"
  ([thehackernews.com](https://thehackernews.com/2026/07/new-memghost-attack-plants-persistent.html)).
- Synthesis: the security literature is converging on write-gates,
  provenance, and audit trails for memory — governance properties, not
  retrieval properties.

## What is proven, what is hype

**Proven in production** (basis: first-party defaults and verifiable
third-party anchors): ChatGPT memory at consumer scale; CLAUDE.md + Claude
Code auto memory (default-on in the dominant coding agent); Anthropic's
memory tool (GA); Mem0's AWS Agent SDK slot and API volume (company figures
via TechCrunch). **Proven as practice**: curated files + agentic search +
compaction/note-taking (Anthropic's
[context-engineering guidance](/knowledge/SWE/agentic/agentic-loop/effective-context-engineering-for-agents.md)
productized in
[context editing and the memory tool](/knowledge/SWE/agentic/context-engineering/claude-context-editing-and-memory-tool.md);
Manus; the 2026 Letta/LangChain convergence above).

**Contested**: every vendor-run LoCoMo claim (the dispute above); graph
memory's premium over files for coding agents (Letta's own files baseline
and 2026 pivot); star counts as adoption signal (claude-mem's ~89k stars
against 1–2-point HN showings and open token-cost bugs).

**Recurring failure modes the community documents**: the junk drawer
("Most 'agent memory' tools auto-save everything. That feels good briefly,
then memory turns into a junk drawer and retrieval gets noisy." —
[Total Recall's write-gated pitch](https://news.ycombinator.com/item?id=46907183),
whose gate question is "Will this change future behavior?"); confabulated
memories ("ChatGPT put all kinds of nonsense into its memory. 'Cruffle is
trying to make bath bombs with baking soda...'" —
[HN](https://news.ycombinator.com/item?id=45684134)); the blunt community
verdict "any 'automated memory' is a failure over time" (same-thread
family, [HN](https://news.ycombinator.com/item?id=46907183)); and **context
collapse** — the ACE paper's finding that iterative LLM rewriting of
accumulated context "erodes details over time" (reported framing;
[arXiv:2510.04618](https://arxiv.org/abs/2510.04618)) — an argument for
append-only/delta memory designs over rewrite-in-place stores.

## Learnings that transfer (synthesis)

1. **Write-gating beats auto-capture** — the field's own corrective
   products (Total Recall, Cursor's approve/reject sidecar) re-invent
   deliberate curation.
2. **Files-canonical with derived indexes is the stable attractor** — every
   2026 leader move points there; databases survive as disposable
   projections.
3. **Temporal validity matters** — Graphiti's bi-temporal model and
   LongMemEval's knowledge-update/abstention categories name the property
   plain stores lack.
4. **Retrieval quality is the product; benchmarks are the marketing** —
   read benchmark code, prefer gold sets you own, distrust vendor-run
   headline numbers.
5. **Memory is an attack surface** — provenance, audit, and write
   confirmation are defenses the governance layer owns.

## The seed repos, positioned

[mex](/knowledge/SWE/agentic/code-context/mex.md) sits squarely in the
curated-files school with deterministic grounding — on-trend with the 2026
convergence, with LangChain's OpenWiki as the big-vendor competitor in its
lane. [SuperLocalMemory](/knowledge/SWE/agentic/agent-memory/superlocalmemory.md)
is the formation-pipeline school taken to its maximal solo form, with
vendor-run LoCoMo numbers on the contested benchmark above and near-zero
community scrutiny found (a 1-point Show HN;
[HN](https://news.ycombinator.com/item?id=46926968)).

# Citations

Primary and secondary sources are linked inline throughout; the sweep ran
2026-08-01 via two background research agents (web search + direct fetches;
star counts from same-day GitHub page fetches; figures marked "secondary"
or "search-summary" where the primary page was not fetched directly).
