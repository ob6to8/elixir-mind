---
type: reference
title: "Channels — source register"
description: The register of channels the brain draws from — blogs, papers, vendor docs, repositories, video, forums — each with the documents ingested from it, so a source can be traced forward to what it produced.
provenance: "Compiled from the resource URIs of the bundle's filed documents; the video section is seeded from an r/LLMDevs recommendation thread."
tags: [survey, channels, sources, provenance]
timestamp: 2026-07-26
---

# Channels — source register

The brain's **source-side view**. Where the [bookmarks register](/survey/bookmarks.md)
tracks *individual links* awaiting intake, this register tracks the **channels** those
links come from — a blog, a paper repository, a YouTube channel, a subreddit, a vendor's
docs — and lists the documents already ingested from each.

Every filed document records *its own* source in `resource` frontmatter. That answers
"where did this document come from?". This register answers the inverse: **"what has
this channel given us, and which channels are we watching but haven't drawn from yet?"**
It is the join that a per-document field cannot express.

Like [`inbox/`](/inbox/index.md) and [`survey/bookmarks.md`](/survey/bookmarks.md), this
sits **outside the OKF bundle**: no `em:` ids, never verified, outside the taxonomy.

## Row shape

Each channel carries a medium, a status, tags, a one-line characterization, and its
ingested documents:

- **Medium** — `blog` · `newsletter` · `papers` · `docs` · `repo` · `video` · `forum` ·
  `reference-work` · `pdf`
- **Status** — `ingested (N)` when N filed documents cite it · `known` when the channel
  is worth watching but nothing has been drawn from it yet
- **Ingested** — bundle-absolute links to the documents sourced from that channel

---

## Video

No video channel has produced a filed document yet. The entries below are `known`
candidates, kept here so the medium is represented rather than silently absent.

### r/LLMDevs — "Recommended non-BS YouTube channels"
- **Medium:** forum · **Status:** known · **Tags:** `llm` `recommendations` `video` `seed`
- The [recommendation thread](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/recommended_nonbs_youtube_channels/)
  this register's video section is meant to be seeded from. Recorded as a pointer only —
  deliberately **not ingested** as a bundle `reference`.
- **Pending:** the thread's channel list is not yet transcribed here. Reddit refuses
  automated fetches from this environment (HTTP 403 to direct, JSON, and mirror
  endpoints), so the recommendations must be supplied by the operator rather than
  guessed at.

---

## Independent blogs & newsletters

### [Simon Willison's Weblog](https://simonwillison.net/)
- **Medium:** blog · **Status:** ingested (3) · **Tags:** `agentic-loop` `coding-agents` `llm-tooling`
- Daily independent writing on LLM tooling and agent practice; the single densest feed behind the agentic-loop material.
- **Ingested:** [Designing agentic loops](/knowledge/SWE/agentic/agentic-loop/designing-agentic-loops.md) · [How coding agents work](/knowledge/SWE/agentic/agentic-loop/how-coding-agents-work.md) · [StrongDM's software factory](/knowledge/SWE/agentic/adoption/strongdm-software-factory.md)

### [matklad](https://matklad.github.io/)
- **Medium:** blog · **Status:** ingested (2) · **Tags:** `testing` `software-design`
- Alex Kladov on testing methodology and language tooling; the source of the brain's testing vocabulary.
- **Ingested:** [How to test: test features, not code](/knowledge/SWE/testing/how-to-test-features-not-code.md) · [Unit vs. integration: purity and extent](/knowledge/SWE/testing/unit-vs-integration-purity-and-extent.md)

### [Martin Alderson](https://martinalderson.com/)
- **Medium:** blog · **Status:** ingested (2) · **Tags:** `llm-engineering` `ai-economics` `kv-cache`
- Inference economics and serving internals, from KV-cache mechanics up to margin structure.
- **Ingested:** [A brief history of KV cache compression](/knowledge/SWE/llm-engineering/kv-cache-compression-history.md) · [GLM-5.2 and the coming AI margin collapse](/knowledge/ai-industry/ai-margin-collapse-glm-5-2.md)

### [Armin Ronacher — lucumr.pocoo.org](https://lucumr.pocoo.org/)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `agentic-loop` `harness-design`
- **Ingested:** [The coming loop](/knowledge/SWE/agentic/agentic-loop/the-coming-loop.md)

### [Geoffrey Huntley](https://ghuntley.com/)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `agentic-loop` `autonomous-coding`
- **Ingested:** [Ralph — a coding agent in an infinite bash loop](/knowledge/SWE/agentic/agentic-loop/ralph-infinite-bash-loop-coding-agent.md)

### [Mike Zornek](https://mikezornek.com/)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `elixir` `code-quality` `ai-drift`
- Elixir practice under AI assistance; the origin of this repo's anti-drift coding-standards stance.
- **Ingested:** [Guarding Against AI Drift](/knowledge/SWE/agentic/code-quality/guarding-against-ai-drift.md)

### [Steve Kinney](https://stevekinney.com/)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `agentic-loop` `reliability`
- **Ingested:** [The agent loop is a while-loop](/knowledge/SWE/agentic/agentic-loop/agent-loop-as-a-while-loop.md)

### [Sébastien Dubois](https://www.dsebastien.net/)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `agentic-loop` `adoption`
- **Ingested:** [Loop engineering went mainstream](/knowledge/SWE/agentic/agentic-loop/loop-engineering-went-mainstream.md)

### [Victor Dibia — newsletter](https://newsletter.victordibia.com/)
- **Medium:** newsletter · **Status:** ingested (1) · **Tags:** `agentic-loop` `multi-agent`
- **Ingested:** [The agent execution loop](/knowledge/SWE/agentic/agentic-loop/the-agent-execution-loop.md)

### [claudefa.st](https://claudefa.st/)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `claude-code` `community-reverse-engineering`
- Community reverse-engineering of undocumented Claude Code behavior — useful, unofficial, and treated as such.
- **Ingested:** [Observer subagent pattern](/knowledge/SWE/agentic/anthropic/claude-code/observer-subagent-pattern.md)

### [The AI Digest](https://theaidigest.org/)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `agent-capability` `forecasting` `metr`
- **Ingested:** [Agent task time horizons](/knowledge/SWE/agentic/agentic-loop/agent-task-time-horizons.md)

### [Yos Riady](https://yos.io/)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `elixir` `software-design` `ecs`
- **Ingested:** [Entity Component Systems in Elixir](/knowledge/SWE/software-design/entity-component-systems-in-elixir.md)

---

## Vendor engineering blogs & product docs

### [Anthropic — engineering blog](https://www.anthropic.com/engineering)
- **Medium:** blog · **Status:** ingested (2) · **Tags:** `agents` `context-engineering` `anthropic`
- First-party guidance on agent and context design; the reference point the independent agentic-loop writing is read against.
- **Ingested:** [Building effective agents](/knowledge/SWE/agentic/agentic-loop/building-effective-agents.md) · [Effective context engineering for AI agents](/knowledge/SWE/agentic/agentic-loop/effective-context-engineering-for-agents.md)

### [Anthropic — Claude blog](https://claude.com/blog)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `claude` `context-management` `product`
- **Ingested:** [Context editing and the memory tool](/knowledge/SWE/agentic/context-engineering/claude-context-editing-and-memory-tool.md)

### [Anthropic — Claude Code documentation](https://code.claude.com/docs/)
- **Medium:** docs · **Status:** ingested (6) · **Tags:** `claude-code` `primary-source` `cloud-sandbox`
- The authoritative source for Claude Code behavior; the brain's `source` captures of the cloud-environment semantics are all quoted from here.
- **Ingested:** [Claude Code agent teams](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md) · [environment caching](/knowledge/SWE/agentic/anthropic/claude-code/sources/cloud-web-environment-caching.md) · [environments reclaimed on inactivity](/knowledge/SWE/agentic/anthropic/claude-code/sources/cloud-web-environment-reclaimed-on-inactivity.md) · [credentials outside the sandbox](/knowledge/SWE/agentic/anthropic/claude-code/sources/cloud-web-credentials-outside-sandbox.md) · [user settings don't carry to cloud](/knowledge/SWE/agentic/anthropic/claude-code/sources/cloud-web-user-settings-dont-carry-to-cloud.md) · [environments carry config](/knowledge/SWE/agentic/anthropic/claude-code/sources/cloud-web-environments-carry-config.md)

### Anthropic — published playbooks (PDF)
- **Medium:** pdf · **Status:** ingested (1) · **Tags:** `startups` `ai-native` `methodology`
- Long-form PDFs published off the main site; kept as a distinct channel because the assets are hosted on a CDN rather than at a stable anthropic.com path.
- **Ingested:** [The Founder's Playbook: Building an AI-Native Startup](/knowledge/startups/founders-playbook-ai-native-startup.md)

### [OpenAI — guides and resources](https://openai.com/business/guides-and-resources/)
- **Medium:** docs · **Status:** ingested (1) · **Tags:** `agents` `primary-source`
- **Ingested:** [A practical guide to building agents](/knowledge/SWE/agentic/agentic-loop/openai-practical-guide-to-building-agents.md)

### [LangChain blog](https://www.langchain.com/blog)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `agentic-loop` `frameworks`
- **Ingested:** [The art of loop engineering](/knowledge/SWE/agentic/agentic-loop/the-art-of-loop-engineering.md)

### [Chroma](https://www.trychroma.com/)
- **Medium:** blog · **Status:** ingested (2) · **Tags:** `retrieval` `context-rot` `vector-db`
- Vendor site plus its research arm; the source of the context-rot result the brain leans on.
- **Ingested:** [Chroma — embedding/search database](/knowledge/SWE/llm-engineering/chroma-vector-database.md) · [Context rot](/knowledge/SWE/agentic/context-engineering/context-rot-chroma-research.md)

### [Hugging Face blog](https://huggingface.co/blog)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `agents` `open-source`
- **Ingested:** [smolagents — the agent loop as code-writing ReAct](/knowledge/SWE/agentic/agentic-loop/smolagents-agent-loop-as-code.md)

### [Manus blog](https://manus.im/blog)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `context-engineering` `production-agents`
- **Ingested:** [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md)

### [Kapa.ai blog](https://www.kapa.ai/blog)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `rag` `retrieval` `context-pruning`
- **Ingested:** [Pruning RAG context with a small LLM](/knowledge/SWE/llm-engineering/rag-context-pruning-with-a-small-llm.md)

### [Amp — ampcode.com](https://ampcode.com/)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `agentic-loop` `from-scratch`
- **Ingested:** [How to build an agent](/knowledge/SWE/agentic/agentic-loop/how-to-build-an-agent.md)

### [Oracle developers blog](https://blogs.oracle.com/developers/)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `agentic-loop` `enterprise`
- **Ingested:** [The agent loop decoded — three levels](/knowledge/SWE/agentic/agentic-loop/the-agent-loop-decoded-three-levels.md)

### [New Relic blog](https://newrelic.com/blog)
- **Medium:** blog · **Status:** ingested (1) · **Tags:** `ai-coding` `industry-survey` `reliability`
- **Ingested:** [State of AI Coding 2026](/knowledge/SWE/testing/state-of-ai-coding-2026.md)

### [Apollo — Daily Spark](https://www.apollo.com/wealth/insights-news/insights/daily-spark)
- **Medium:** newsletter · **Status:** ingested (1) · **Tags:** `ai-industry` `macro` `roi`
- Torsten Slok's macro commentary; the brain's non-technical read on AI capex and returns.
- **Ingested:** [The AI ROI runway could be long outside the tech sector](/knowledge/ai-industry/ai-roi-runway-outside-tech-sector.md)

---

## Papers & preprints

### [arXiv](https://arxiv.org/)
- **Medium:** papers · **Status:** ingested (10) · **Tags:** `research` `preprints` `agents` `context-engineering`
- The primary research feed, reaching the brain mostly through [`/research`](/.claude/skills/research/SKILL.md) and the bookmarks register.
- **Ingested:** [ReAct](/knowledge/SWE/agentic/agentic-loop/react-reasoning-and-acting.md) · [PARC](/knowledge/SWE/agentic/agentic-loop/parc-self-reflective-long-horizon-agent.md) · [EXG: experience graphs](/knowledge/SWE/agentic/agent-memory/experience-graphs-exg.md) · [Conversation Tree Architecture](/knowledge/SWE/agentic/context-engineering/conversation-tree-architecture.md) · [Granularity-aware evaluation for dialogue topic segmentation](/knowledge/SWE/agentic/context-engineering/granularity-aware-evaluation-for-dialogue-topic-segmentation.md) · [VeriCache](/knowledge/SWE/llm-engineering/vericache-lossless-kv-cache.md) · [LLMs recovering design rationale](/knowledge/knowledge-management/design-rationale/llms-recovering-design-rationale.md) · [AgenticAKM](/knowledge/knowledge-management/design-rationale/agentic-architecture-knowledge-management.md) · [Context strategies for ADR generation](/knowledge/knowledge-management/design-rationale/context-strategies-for-adr-generation.md) · [Architecture Without Architects](/knowledge/knowledge-management/design-rationale/architecture-without-architects.md)

### *Artificial Intelligence* (Elsevier, via DOI)
- **Medium:** papers · **Status:** ingested (4) · **Tags:** `knowledge-representation` `argumentation` `foundational`
- The foundational AI-journal literature behind the brain's belief and argumentation vocabulary — cited by DOI, quoted as `source` captures.
- **Ingested:** [Doyle (1979), A Truth Maintenance System](/knowledge/knowledge-management/knowledge-representation/doyle-1979-a-truth-maintenance-system.md) · [de Kleer (1986), An Assumption-based TMS](/knowledge/knowledge-management/knowledge-representation/de-kleer-1986-an-assumption-based-tms.md) · [Dung (1995), On the acceptability of arguments](/knowledge/knowledge-management/argumentation/dung-1995-acceptability-of-arguments.md) · [Dung's abstract argumentation frameworks](/knowledge/knowledge-management/argumentation/dung-abstract-argumentation-frameworks.md)

### Author preprint pages (university-hosted)
- **Medium:** papers · **Status:** ingested (1) · **Tags:** `deep-learning` `historical`
- Papers served from an author's own faculty page rather than a repository.
- **Ingested:** [Deep belief network](/knowledge/machine-learning/deep-learning/deep-belief-networks.md) (Hinton, University of Toronto)

---

## Reference works & standards

### [Wikipedia](https://en.wikipedia.org/)
- **Medium:** reference-work · **Status:** ingested (3) · **Tags:** `orientation` `knowledge-representation` `argumentation`
- Orientation-level entry points; used to frame a topic before the primary sources are captured, never as terminal evidence.
- **Ingested:** [Truth maintenance systems](/knowledge/knowledge-management/knowledge-representation/truth-maintenance-systems.md) · [The Toulmin model of argument](/knowledge/knowledge-management/argumentation/toulmin-model-of-argument.md) · [Assurance cases and GSN](/knowledge/knowledge-management/argumentation/assurance-cases-and-gsn.md)

### [Pro Git & git-scm documentation](https://git-scm.com/)
- **Medium:** docs · **Status:** ingested (2) · **Tags:** `git` `primary-source`
- **Ingested:** [Pro Git — remote-tracking branches](/knowledge/SWE/version-control/git/sources/pro-git-remote-tracking-branches.md) · [gitglossary — branch head and remote-tracking branch](/knowledge/SWE/version-control/git/sources/gitglossary-branch-and-remote-tracking-branch.md)

### [W3C standards](https://www.w3.org/TR/)
- **Medium:** reference-work · **Status:** ingested (1) · **Tags:** `semantic-web` `owl` `formal-kr`
- **Ingested:** [FOL and OWL: fully formal knowledge representation](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md)

### [Safety-Critical Systems Club (SCSC)](https://scsc.uk/)
- **Medium:** reference-work · **Status:** ingested (1) · **Tags:** `assurance-cases` `gsn` `standards`
- **Ingested:** [GSN Community Standard](/knowledge/knowledge-management/argumentation/gsn-community-standard.md)

### [HexDocs & Hex.pm](https://hexdocs.pm/)
- **Medium:** docs · **Status:** ingested (2) · **Tags:** `elixir` `primary-source` `packages`
- Elixir's package registry and API documentation — the primary source for claims about the language's built-in tooling.
- **Ingested:** [ExUnit ships dependency-free fixtures and diffs](/knowledge/SWE/testing/exunit-dependency-free-fixtures-and-diffs.md) · [sagents — agent orchestration for Elixir](/knowledge/SWE/agentic/frameworks/sagents-elixir-agent-orchestration.md)

---

## Code repositories

### [GitHub](https://github.com/)
- **Medium:** repo · **Status:** ingested (6) · **Tags:** `source-code` `specs` `tooling`
- Repositories read as primary sources — a spec, a README, or a standards file, distilled the same way an article is.
- **Ingested:** [Open Knowledge Format (OKF)](/knowledge/knowledge-management/open-knowledge-format.md) · [Own your control flow — 12-Factor Agents](/knowledge/SWE/agentic/agentic-loop/own-your-control-flow-12-factor.md) · [Codebase-Memory MCP](/knowledge/SWE/agentic/code-context/codebase-memory-mcp.md) · [GitNexus](/knowledge/SWE/agentic/code-context/gitnexus.md) · [Elixir snapshot libraries require a dependency](/knowledge/SWE/testing/elixir-snapshot-libraries-require-a-dependency.md) · [Elixir coding conventions (LocalCents)](/knowledge/SWE/agentic/code-quality/elixir-coding-conventions-localcents.md)

---

## Forums & social

### [LinkedIn](https://www.linkedin.com/)
- **Medium:** forum · **Status:** ingested (1) · **Tags:** `practitioner-posts` `adoption`
- Practitioner posts that exist nowhere else; captured verbatim because the platform is a poor archive.
- **Ingested:** [Steps of AI Adoption (Boris Cherny)](/knowledge/SWE/agentic/adoption/steps-of-ai-adoption.md)

### [Reddit — r/LLMDevs](https://www.reddit.com/r/LLMDevs/)
- **Medium:** forum · **Status:** known · **Tags:** `llm` `practitioner-discussion` `recommendations`
- Practitioner discussion on building with LLMs. Nothing filed from it yet; it is the channel behind the video-section seed thread above.

### Shared chat transcripts
- **Medium:** forum · **Status:** known · **Tags:** `conversation` `staging`
- Shared ChatGPT/Claude conversation links, kept as a channel because their content is otherwise unarchivable. One is queued: [intake the "Second brain distinctions" conversation](/meta/todos/intake-second-brain-distinctions-chatgpt-conversation.md).

---

## Related registers

- [bookmarks](/survey/bookmarks.md) — the link-level survey tier: individual URLs
  fetched, summarized, and tagged, awaiting promotion to a filed `reference`.
- [inbox](/inbox/index.md) — the dated candidate feed generated by
  [`/research`](/.claude/skills/research/SKILL.md); many of the channels above first
  appeared there.

## Maintenance

This register is **hand-maintained**, not generated: add a channel when a new source
produces a filed document, and extend the channel's *Ingested* line rather than opening
a second entry for the same source. The ingested set is re-derivable at any time from
the bundle itself —

```sh
grep -rh --include="*.md" '^resource:' . --exclude-dir=deprecated --exclude-dir=_build
```

— so a suspected drift can be checked against the documents rather than trusted.
