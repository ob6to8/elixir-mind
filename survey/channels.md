---
type: reference
title: "Channels — standing sources register"
description: Standing sources — newsletters, blogs, author feeds, vendor docs, archives, video, forums — the brain monitors for new AI material; each entry carries a focus line, an access note (free, or login required and whether paid), the documents already ingested from it, and the origin of the recommendation.
provenance: "Operator-supplied source list seeded from https://www.codesupreme.ai/ and https://www.codesupreme.ai/the-edge/read; extended with the sources behind the bundle's filed documents and a vetted video set."
tags: [survey, channels]
timestamp: 2026-07-29
---

# Channels — standing sources register

The brain's **channel register**: recurring publications worth monitoring for new
material, as opposed to the one-off links parked in
[bookmarks](/survey/bookmarks.md). A channel is a *source* that keeps producing;
a bookmark is a *document* already produced. Individual pieces surfaced from a
channel still enter the brain the normal way — via the
[`/research`](/.claude/skills/research/SKILL.md) daily feed or
[`/intake`](/.claude/skills/intake/SKILL.md).

**The register holds both directions of a channel's relationship to the brain.**
Prospectively it records *where to look and what it costs to look there* — the
focus line and the access note `/research` reads before deciding what it may
fetch. Retrospectively it records *what the looking produced* — the filed
documents drawn from that source. The two belong in one row because the second
is the evidence for the first: a channel earns continued attention by having
yielded something, and a row that stays empty is a watchlist entry nobody has
had to justify. Keeping the yield beside the intent is what makes the register
a feedback loop rather than a list that only ever grows.

The retrospective half is a **join, not a record of its own**. Each document
already names its source in `resource` frontmatter; this column inverts that
edge, which is the one thing a per-document field cannot express. Nothing here
is authoritative — the documents are, and the column is re-derivable from them
(see [Maintenance](#maintenance)).

Like the rest of [`survey/`](/survey/index.md), this namespace sits outside the
OKF bundle: no `em:` ids, never verified.

## Columns

- **Channel** — the source, linked to where it publishes.
- **Focus** — what it covers, and why it is worth the attention.
- **Access** — **free** (readable without an account) · **freemium** (some content
  free, the rest behind a login) · **paid** (a paid subscription is required).
  [`/research`](/.claude/skills/research/SKILL.md) respects this: a free channel is
  fetched directly, a login/paid one is surfaced only from what is publicly
  readable.
- **Ingested** — the filed documents sourced from this channel, or `—` where the
  channel is monitored but nothing has been drawn from it yet. This is the inverse
  of a document's own `resource` field: that answers *where did this come from*,
  this answers *what has this channel given us*. A channel with a long list has
  earned its place; a long-empty one is a candidate for removal.
- **From** — where the recommendation came from, so rows added later from other
  origins stay distinguishable.

## Newsletters & aggregators

| Channel | Focus | Access | Ingested | From |
|---------|-------|--------|----------|------|
| [Lenny's Newsletter — AI](https://www.lennysnewsletter.com/t/ai) | Product management and growth (Substack); the AI topic feed — practical guides, frameworks, and case studies on AI in product work | Freemium — some posts free; full posts require login + **paid** Substack subscription | — | [codesupreme.ai](https://www.codesupreme.ai/) · [The Edge](https://www.codesupreme.ai/the-edge/read) (2026-07-27) |
| [The Information — The Briefing](https://www.theinformation.com/newsletters/the-briefing) | Daily executive briefing on tech, media, and finance (Martin Peers, Jessica Lessin & team; 5×/week) | **Paid** — login + subscription to The Information required | — | [codesupreme.ai](https://www.codesupreme.ai/) · [The Edge](https://www.codesupreme.ai/the-edge/read) (2026-07-27) |
| [The Batch (DeepLearning.AI)](https://www.deeplearning.ai/the-batch) | Weekly AI news and insights from DeepLearning.AI — research, business applications, hardware, careers | Free — no login; optional email subscription | — | [codesupreme.ai](https://www.codesupreme.ai/) · [The Edge](https://www.codesupreme.ai/the-edge/read) (2026-07-27) |
| [One Useful Thing](https://www.oneusefulthing.org/) | Ethan Mollick (Substack) on the implications of AI for work, education, and life | Free — no login to read; optional paid supporter tier | — | [codesupreme.ai](https://www.codesupreme.ai/) · [The Edge](https://www.codesupreme.ai/the-edge/read) (2026-07-27) |
| [Import AI](https://jack-clark.net/) | Jack Clark's weekly newsletter on AI research, capabilities, safety, and policy | Free — no login | — | [codesupreme.ai](https://www.codesupreme.ai/) · [The Edge](https://www.codesupreme.ai/the-edge/read) (2026-07-27) |
| [Frank Coyle, PhD (Medium)](https://medium.com/@coyle_41098) | Berkeley AI lecturer & neuroscientist; agentic systems and how minds — biological and artificial — work (CAG vs RAG, context engineering, AI hardware) | Medium metered — member-only stories require login + **paid** Medium membership | — | [codesupreme.ai](https://www.codesupreme.ai/) · [The Edge](https://www.codesupreme.ai/the-edge/read) (2026-07-27) |
| [Dickson Lukose (Medium)](https://medium.com/@dickson.lukose) | Gen-AI, LLMs, prompt engineering, knowledge graphs, ontology modeling, GraphRAG, guardrails | Medium metered — member-only stories require login + **paid** Medium membership | — | [codesupreme.ai](https://www.codesupreme.ai/) · [The Edge](https://www.codesupreme.ai/the-edge/read) (2026-07-27) |
| [Towards Data Science (Medium archive)](https://towardsdatascience.medium.com/) | Data science, ML, and AI publication archive on Medium; new TDS content publishes at [towardsdatascience.com](https://towardsdatascience.com/) (free) | Medium metered — some archive stories member-only, requiring login + **paid** Medium membership | — | [codesupreme.ai](https://www.codesupreme.ai/) · [The Edge](https://www.codesupreme.ai/the-edge/read) (2026-07-27) |
| [Victor Dibia — newsletter](https://newsletter.victordibia.com/) | Agent architecture and multi-agent systems, written from research practice | Free | [The agent execution loop](/knowledge/SWE/agentic/agentic-loop/the-agent-execution-loop.md) | filed documents (2026-07-26) |
| [Apollo — Daily Spark](https://www.apollo.com/wealth/insights-news/insights/daily-spark) | Torsten Slok's daily macro commentary; the non-technical read on AI capex and returns | Free | [The AI ROI runway could be long outside the tech sector](/knowledge/ai-industry/ai-roi-runway-outside-tech-sector.md) | filed documents (2026-07-26) |

## Independent blogs

| Channel | Focus | Access | Ingested | From |
|---------|-------|--------|----------|------|
| [Simon Willison's Weblog](https://simonwillison.net/) | Daily independent writing on LLM tooling and agent practice; the densest single feed behind the agentic-loop material | Free | [Designing agentic loops](/knowledge/SWE/agentic/agentic-loop/designing-agentic-loops.md) · [How coding agents work](/knowledge/SWE/agentic/agentic-loop/how-coding-agents-work.md) · [StrongDM's software factory](/knowledge/SWE/agentic/adoption/strongdm-software-factory.md) | filed documents (2026-07-26) |
| [matklad](https://matklad.github.io/) | Alex Kladov on testing methodology and language tooling; the source of the brain's testing vocabulary | Free | [Test features, not code](/knowledge/SWE/testing/how-to-test-features-not-code.md) · [Unit vs. integration: purity and extent](/knowledge/SWE/testing/unit-vs-integration-purity-and-extent.md) | filed documents (2026-07-26) |
| [Martin Alderson](https://martinalderson.com/) | Inference economics and serving internals, from KV-cache mechanics up to margin structure | Free | [KV cache compression history](/knowledge/SWE/llm-engineering/kv-cache-compression-history.md) · [GLM-5.2 and the AI margin collapse](/knowledge/ai-industry/ai-margin-collapse-glm-5-2.md) | filed documents (2026-07-26) |
| [Armin Ronacher — lucumr.pocoo.org](https://lucumr.pocoo.org/) | Harness and runtime design, read from long systems experience | Free | [The coming loop](/knowledge/SWE/agentic/agentic-loop/the-coming-loop.md) | filed documents (2026-07-26) |
| [Geoffrey Huntley](https://ghuntley.com/) | Autonomous coding-agent experiments run to their logical extreme | Free | [Ralph — a coding agent in an infinite bash loop](/knowledge/SWE/agentic/agentic-loop/ralph-infinite-bash-loop-coding-agent.md) | filed documents (2026-07-26) |
| [Mike Zornek](https://mikezornek.com/) | Elixir practice under AI assistance; the origin of this repo's anti-drift coding-standards stance | Free | [Guarding Against AI Drift](/knowledge/SWE/agentic/code-quality/guarding-against-ai-drift.md) | filed documents (2026-07-26) |
| [Steve Kinney](https://stevekinney.com/) | Agent-loop mechanics and where reliability actually comes from | Free | [The agent loop is a while-loop](/knowledge/SWE/agentic/agentic-loop/agent-loop-as-a-while-loop.md) | filed documents (2026-07-26) |
| [Sébastien Dubois](https://www.dsebastien.net/) | Knowledge work and AI-assisted development practice | Free | [Loop engineering went mainstream](/knowledge/SWE/agentic/agentic-loop/loop-engineering-went-mainstream.md) | filed documents (2026-07-26) |
| [The AI Digest](https://theaidigest.org/) | Capability forecasting and measurement, including METR's time-horizon work | Free | [Agent task time horizons](/knowledge/SWE/agentic/agentic-loop/agent-task-time-horizons.md) | filed documents (2026-07-26) |
| [claudefa.st](https://claudefa.st/) | Community reverse-engineering of undocumented Claude Code behavior — useful, unofficial, and to be treated as such | Free | [Observer subagent pattern](/knowledge/SWE/agentic/anthropic/claude-code/observer-subagent-pattern.md) | filed documents (2026-07-26) |
| [Yos Riady](https://yos.io/) | Elixir and functional software design | Free | [Entity Component Systems in Elixir](/knowledge/SWE/software-design/entity-component-systems-in-elixir.md) | filed documents (2026-07-26) |
| [Mitchell Hashimoto](https://mitchellh.com/) | HashiCorp cofounder and Ghostty creator writing on terminal tooling, developer infrastructure, and building software as a craft | Free | [Superlogical](/knowledge/SWE/dev-tools/superlogical.md) | operator (2026-07-29) |
| [David Nicholas Williams](https://davidnicholaswilliams.com/#open-source) | Software building and startup practice from a YC/a16z-backed-company engineer; blog essays on engineering and product plus an open-source contributions log (React Frontload, VS Code, Dropwizard) | Free | [It's not empowering to hand off the details](/knowledge/SWE/agentic/adoption/its-not-empowering-to-hand-off-the-details.md) | operator-supplied (2026-07-29) |
| [Karl Bode](https://karlbode.com/) | Critical analysis of AI industry economics, hype, and implications for workers and regulation; the structural critique complement to technical AI writing | Free | — | operator (2026-07-31) |
| [Where's Your Ed At — Edward Niedermeyer](https://www.wheresyoured.at/author/edward/) | Edward Niedermeyer's series on AI productivity stalls, energy costs, misaligned incentives, and the gap between hype and measured results | Free | — | operator (2026-07-31) |

## Vendor engineering blogs & product docs

| Channel | Focus | Access | Ingested | From |
|---------|-------|--------|----------|------|
| [Anthropic — engineering blog](https://www.anthropic.com/engineering) | First-party guidance on agent and context design; the reference point independent agentic-loop writing is read against | Free | [Building effective agents](/knowledge/SWE/agentic/agentic-loop/building-effective-agents.md) · [Effective context engineering](/knowledge/SWE/agentic/agentic-loop/effective-context-engineering-for-agents.md) | filed documents (2026-07-26) |
| [Anthropic — Claude Code docs](https://code.claude.com/docs/) | The authoritative source for Claude Code behavior; the brain's cloud-environment `source` captures are all quoted from here | Free | [Agent teams](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md) · [environment caching](/knowledge/SWE/agentic/anthropic/claude-code/sources/cloud-web-environment-caching.md) · [reclaimed on inactivity](/knowledge/SWE/agentic/anthropic/claude-code/sources/cloud-web-environment-reclaimed-on-inactivity.md) · [credentials outside the sandbox](/knowledge/SWE/agentic/anthropic/claude-code/sources/cloud-web-credentials-outside-sandbox.md) · [user settings don't carry](/knowledge/SWE/agentic/anthropic/claude-code/sources/cloud-web-user-settings-dont-carry-to-cloud.md) · [environments carry config](/knowledge/SWE/agentic/anthropic/claude-code/sources/cloud-web-environments-carry-config.md) | filed documents (2026-07-26) |
| [Anthropic — Claude blog](https://claude.com/blog) | Product-side announcements on context management and Claude capabilities | Free | [Context editing and the memory tool](/knowledge/SWE/agentic/context-engineering/claude-context-editing-and-memory-tool.md) | filed documents (2026-07-26) |
| Anthropic — published playbooks (PDF) | Long-form PDFs published off the main site, CDN-hosted rather than at a stable path | Free | [The Founder's Playbook](/knowledge/startups/founders-playbook-ai-native-startup.md) | filed documents (2026-07-26) |
| [OpenAI — guides and resources](https://openai.com/business/guides-and-resources/) | First-party agent-building guidance | Free | [A practical guide to building agents](/knowledge/SWE/agentic/agentic-loop/openai-practical-guide-to-building-agents.md) | filed documents (2026-07-26) |
| [LangChain blog](https://www.langchain.com/blog) | Framework-side agent patterns and loop design | Free | [The art of loop engineering](/knowledge/SWE/agentic/agentic-loop/the-art-of-loop-engineering.md) | filed documents (2026-07-26) |
| [Chroma](https://www.trychroma.com/) | Retrieval infrastructure plus a research arm; the source of the context-rot result the brain leans on | Free | [Chroma — embedding/search database](/knowledge/SWE/llm-engineering/chroma-vector-database.md) · [Context rot](/knowledge/SWE/agentic/context-engineering/context-rot-chroma-research.md) | filed documents (2026-07-26) |
| [Hugging Face blog](https://huggingface.co/blog) | Open-source model and agent tooling | Free | [smolagents — the agent loop as code-writing ReAct](/knowledge/SWE/agentic/agentic-loop/smolagents-agent-loop-as-code.md) | filed documents (2026-07-26) |
| [Manus blog](https://manus.im/blog) | Context engineering lessons from running a production agent | Free | [Context engineering lessons from Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md) | filed documents (2026-07-26) |
| [Kapa.ai blog](https://www.kapa.ai/blog) | Applied RAG and retrieval engineering | Free | [Pruning RAG context with a small LLM](/knowledge/SWE/llm-engineering/rag-context-pruning-with-a-small-llm.md) | filed documents (2026-07-26) |
| [Amp — ampcode.com](https://ampcode.com/) | Agent internals explained by building one from scratch | Free | [How to build an agent](/knowledge/SWE/agentic/agentic-loop/how-to-build-an-agent.md) | filed documents (2026-07-26) |
| [Oracle developers blog](https://blogs.oracle.com/developers/) | Enterprise-side agent architecture write-ups | Free | [The agent loop decoded — three levels](/knowledge/SWE/agentic/agentic-loop/the-agent-loop-decoded-three-levels.md) | filed documents (2026-07-26) |
| [New Relic blog](https://newrelic.com/blog) | Industry survey data on AI coding and reliability | Free | [State of AI Coding 2026](/knowledge/SWE/testing/state-of-ai-coding-2026.md) | filed documents (2026-07-26) |

## Papers & archives

| Channel | Focus | Access | Ingested | From |
|---------|-------|--------|----------|------|
| [arXiv](https://arxiv.org/) | Open-access preprint archive — CS, math, physics, stats; the primary-source layer under most AI news, and the brain's densest research feed | Free — open access, no login | [ReAct](/knowledge/SWE/agentic/agentic-loop/react-reasoning-and-acting.md) · [PARC](/knowledge/SWE/agentic/agentic-loop/parc-self-reflective-long-horizon-agent.md) · [EXG experience graphs](/knowledge/SWE/agentic/agent-memory/experience-graphs-exg.md) · [Conversation Tree Architecture](/knowledge/SWE/agentic/context-engineering/conversation-tree-architecture.md) · [Granularity-aware evaluation](/knowledge/SWE/agentic/context-engineering/granularity-aware-evaluation-for-dialogue-topic-segmentation.md) · [VeriCache](/knowledge/SWE/llm-engineering/vericache-lossless-kv-cache.md) · [LLMs recovering design rationale](/knowledge/knowledge-management/design-rationale/llms-recovering-design-rationale.md) · [AgenticAKM](/knowledge/knowledge-management/design-rationale/agentic-architecture-knowledge-management.md) · [Context strategies for ADR generation](/knowledge/knowledge-management/design-rationale/context-strategies-for-adr-generation.md) · [Architecture Without Architects](/knowledge/SWE/agentic/architecture/architecture-without-architects.md) | [codesupreme.ai](https://www.codesupreme.ai/) · [The Edge](https://www.codesupreme.ai/the-edge/read) (2026-07-27); filed documents (2026-07-26) |
| *Artificial Intelligence* (Elsevier, via DOI) | The foundational AI-journal literature behind the brain's belief and argumentation vocabulary | **Paid** — abstracts free; full text requires a ScienceDirect subscription | [Doyle (1979), A Truth Maintenance System](/knowledge/knowledge-management/knowledge-representation/doyle-1979-a-truth-maintenance-system.md) · [de Kleer (1986), An Assumption-based TMS](/knowledge/knowledge-management/knowledge-representation/de-kleer-1986-an-assumption-based-tms.md) · [Dung (1995), On the acceptability of arguments](/knowledge/knowledge-management/argumentation/dung-1995-acceptability-of-arguments.md) · [Dung's abstract argumentation frameworks](/knowledge/knowledge-management/argumentation/dung-abstract-argumentation-frameworks.md) | filed documents (2026-07-26) |
| Author preprint pages (university-hosted) | Papers served from an author's own faculty page rather than a repository | Free | [Deep belief network](/knowledge/machine-learning/deep-learning/deep-belief-networks.md) (Hinton, Toronto) | filed documents (2026-07-26) |

## Reference works, standards & repositories

| Channel | Focus | Access | Ingested | From |
|---------|-------|--------|----------|------|
| [GitHub](https://github.com/) | Repositories read as primary sources — a spec, a README, or a standards file, distilled the same way an article is | Free | [Open Knowledge Format](/knowledge/knowledge-management/open-knowledge-format.md) · [Own your control flow — 12-Factor Agents](/knowledge/SWE/agentic/agentic-loop/own-your-control-flow-12-factor.md) · [Codebase-Memory MCP](/knowledge/SWE/agentic/code-context/codebase-memory-mcp.md) · [GitNexus](/knowledge/SWE/agentic/code-context/gitnexus.md) · [Elixir snapshot libraries](/knowledge/SWE/testing/elixir-snapshot-libraries-require-a-dependency.md) · [Elixir coding conventions (LocalCents)](/knowledge/SWE/agentic/code-quality/elixir-coding-conventions-localcents.md) | filed documents (2026-07-26) |
| [Wikipedia](https://en.wikipedia.org/) | Orientation-level entry points; used to frame a topic before the primary sources are captured, never as terminal evidence | Free | [Truth maintenance systems](/knowledge/knowledge-management/knowledge-representation/truth-maintenance-systems.md) · [The Toulmin model](/knowledge/knowledge-management/argumentation/toulmin-model-of-argument.md) · [Assurance cases and GSN](/knowledge/knowledge-management/argumentation/assurance-cases-and-gsn.md) | filed documents (2026-07-26) |
| [Pro Git & git-scm docs](https://git-scm.com/) | The primary source for git semantics | Free | [Remote-tracking branches](/knowledge/SWE/version-control/git/sources/pro-git-remote-tracking-branches.md) · [gitglossary — branch head](/knowledge/SWE/version-control/git/sources/gitglossary-branch-and-remote-tracking-branch.md) | filed documents (2026-07-26) |
| [HexDocs & Hex.pm](https://hexdocs.pm/) | Elixir's package registry and API documentation — the primary source for claims about the language's built-in tooling | Free | [ExUnit's dependency-free fixtures and diffs](/knowledge/SWE/testing/exunit-dependency-free-fixtures-and-diffs.md) · [sagents](/knowledge/SWE/agentic/frameworks/sagents-elixir-agent-orchestration.md) | filed documents (2026-07-26) |
| [W3C standards](https://www.w3.org/TR/) | Formal knowledge-representation standards | Free | [FOL and OWL](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md) | filed documents (2026-07-26) |
| [Safety-Critical Systems Club](https://scsc.uk/) | Assurance-case and GSN standards | Free | [GSN Community Standard](/knowledge/knowledge-management/argumentation/gsn-community-standard.md) | filed documents (2026-07-26) |

## Video

Nothing has been filed from a video channel yet. These five were selected against a
stated standard: a channel qualifies if it does or reports **independent testing of
released models** rather than restating vendor launch claims. Each was judged on its
**recent uploads**, read from its RSS feed, rather than on its self-description — the
two disagree often enough that a channel's own blurb is not evidence.

| Channel | Focus | Access | Ingested | From |
|---------|-------|--------|----------|------|
| [Codacus](https://www.youtube.com/@Codacus) | Local AI on hardware you already own, positioned against sponsored tool reviews: whether a 3.5GB model can displace a 35B daily driver, fully private local stacks, agent-patching llama.cpp. One recent video covers OKF — the format this brain is built on | Free | — | [r/LLMDevs](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/recommended_nonbs_youtube_channels/) (2026-07-26) |
| [Protorikis](https://www.youtube.com/@Protorikis) | The most methodologically rigorous of the set — runtime and quantization benchmarking with stated conditions: MLX against llama.cpp across four runtimes, NVFP4 against Q4 on speed *and* quality, sustained-load thermal tests | Free | — | [r/LLMDevs](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/recommended_nonbs_youtube_channels/) (2026-07-26) |
| [No place like localhost](https://www.youtube.com/@NoPlaceLikeLocalhost) | Standing up and tuning LLMs on local hardware: performance tuning, multi-GPU setups, head-to-head model comparisons, spec-driven development against one-shot prompting | Free | — | [r/LLMDevs](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/recommended_nonbs_youtube_channels/) (2026-07-26) |
| [Alex Ziskind](https://www.youtube.com/@AZisk) | Hardware-side testing of local inference — vendor capability claims checked against measurement, cheap high-VRAM builds, laptop and Apple-silicon inference limits | Free | — | [r/LLMDevs](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/recommended_nonbs_youtube_channels/) (2026-07-26) |
| [xCreate](https://www.youtube.com/@xcreate) | Independent reviews of newly released open-weight models scored on real coding tasks; the author also builds Inferencer, a macOS inference harness. **Caveat:** the substance meets the standard, the packaging does not — superlative-and-emoji titles claiming one model "destroys" another | Free | — | [r/LLMDevs](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/recommended_nonbs_youtube_channels/) (2026-07-26) |
| [Tom D. Aorist](https://www.youtube.com/@tom_d_aorist) | (metadata unavailable; content to be evaluated on future uploads) | Free | — | operator (2026-07-31) |

## Forums & social

| Channel | Focus | Access | Ingested | From |
|---------|-------|--------|----------|------|
| [Reddit — r/LLMDevs](https://www.reddit.com/r/LLMDevs/) | Practitioner discussion on building with LLMs; surfaces channel and tool names at a granularity no article supplies, but recommendations need checking against actual output — its video thread yielded five keepers out of sixteen nominations | Free to read; Reddit blocks automated fetches, so treat it as a manual-visit channel | — | [r/LLMDevs](https://www.reddit.com/r/LLMDevs/comments/1v6zxz3/recommended_nonbs_youtube_channels/) (2026-07-26) |
| [LinkedIn](https://www.linkedin.com/) | Practitioner posts that exist nowhere else; captured verbatim because the platform is a poor archive | Freemium — public posts readable, login prompted for more | [Steps of AI Adoption (Boris Cherny)](/knowledge/SWE/agentic/adoption/steps-of-ai-adoption.md) | filed documents (2026-07-26) |
| Shared chat transcripts | Shared ChatGPT/Claude conversation links, kept as a channel because their content is otherwise unarchivable | Free — link-scoped | — (one queued: [Second brain distinctions](/meta/todos/intake-second-brain-distinctions-chatgpt-conversation.md)) | filed documents (2026-07-26) |

## Related registers

- [bookmarks](/survey/bookmarks.md) — the link-level survey tier: individual URLs
  fetched, summarized, and tagged, awaiting promotion to a filed `reference`.
- [inbox](/inbox/index.md) — the dated candidate feed generated by
  [`/research`](/.claude/skills/research/SKILL.md), which scans this register first.

## Maintenance

Hand-maintained, not generated. Add a channel when a new source produces a filed
document or is recommended as worth monitoring, and extend an existing row rather
than opening a second entry for the same source. The **Ingested** column is
re-derivable from the bundle at any time —

```sh
grep -rh --include="*.md" '^resource:' . --exclude-dir=deprecated --exclude-dir=_build
```

— so suspected drift can be checked against the documents rather than trusted.
