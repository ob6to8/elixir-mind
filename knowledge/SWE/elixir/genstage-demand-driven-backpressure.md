---
id: em:ef34f0
type: reference
title: "GenStage's demand-driven backpressure (a visual explainer)"
description: GenStage's producer/consumer protocol expresses backpressure as a count, not a rate — a consumer tells a producer how many events it may send, never how fast — with :max_demand and :min_demand as the two knobs governing when it re-asks and how much work stays in flight.
resource: https://andrealeopardi.com/posts/genstage-demand-visualized/
provenance: "Andrea Leopardi's blog (andrealeopardi.com), posted 2026-08-07; discussed on r/elixir"
tags: [elixir, genstage, backpressure, otp, beam, concurrency, flow-control, broadway]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# GenStage's demand-driven backpressure

GenStage solves one problem: a producer that can emit data faster than a
consumer can absorb it. A pipeline with a fast producer and a fixed-rate
consumer either grows an unbounded queue until memory gives out, or drops
work — if work enters a system faster than it leaves for long enough,
something inside the system must keep growing, reject work, or slow the
input.

## Demand is a count, not a rate

GenStage's fix: the producer may send only what the consumer asks for. That
ask is *demand* — a plain integer. Demand of six means the consumer wants six
events. Critically, the consumer does not say "send n events per second," it
says "you may send n more events." This decouples the protocol from timing
entirely — a slow consumer naturally throttles a fast producer because it
simply asks less often, with no rate negotiation involved.

## `:max_demand` and `:min_demand`

A consumer subscribes to a producer with two subscription options:

- **`:max_demand`** — the maximum events in flight for the subscription, and
  the size of the first request.
- **`:min_demand`** — the remaining-demand threshold that triggers the next
  request.

Worked example: `[max_demand: 6, min_demand: 2]`. The consumer starts with an
outstanding request for 6. As it processes events, remaining demand counts
down; the moment it hits 2 (4 events consumed), the consumer issues a new
request for 4 more (`max_demand - min_demand`), refilling toward 6. The
producer never inspects "is the consumer almost ready" — it purely tracks
this number.

Because producer and consumer are separate BEAM processes, the producer can
fetch the next batch while the consumer is still working through the tail of
the current one — the refill request fires early enough that new events
arrive exactly when needed, with zero idle time on either side.

## The three roles

- **producer** — implements `handle_demand/2`; receives an integer, returns
  up to that many events.
- **consumer** — implements `handle_events/3`; sends demand, receives events.
- **producer-consumer** — both; sits mid-pipeline and mostly forwards demand
  upstream.

```elixir
defmodule Counter do
  use GenStage

  def start_link(initial), do: GenStage.start_link(__MODULE__, initial, name: __MODULE__)

  @impl true
  def init(counter), do: {:producer, counter}

  @impl true
  def handle_demand(demand, counter) when demand > 0 do
    events = Enum.to_list(counter..(counter + demand - 1))
    {:noreply, events, counter + demand}
  end
end

defmodule Printer do
  use GenStage

  @impl true
  def init(:ok) do
    opts = [subscribe_to: [{Counter, max_demand: 6, min_demand: 2}]]
    {:consumer, :ok, opts}
  end

  @impl true
  def handle_events(events, _from, state) do
    Enum.each(events, &IO.inspect/1)
    {:noreply, [], state}
  end
end
```

## Demand and concurrency are separate knobs

GenStage supports many-to-many subscriptions. Each consumer tracks its own
demand independently, and the producer's dispatcher tracks demand
per-subscription — the default `DemandDispatcher` routes each event to
whichever subscribed consumer currently holds the highest outstanding
demand. This is not round-robin: three consumers with identical
`max_demand`/`min_demand` but different processing speeds each ask again at
their own pace, so a faster consumer naturally receives more work without
any central load-balancing logic.

## Limits

Demand only governs flow inside a GenStage pipeline — it cannot slow an
external source (SQS, Kafka, a socket) that keeps delivering regardless. The
producer's job is to decide when it fetches from that source, letting
unconsumed data sit in the external system's own storage until the pipeline
is ready. GenStage also does not guarantee a producer emits exactly current
demand — it may over-return and buffer the excess internally, so a hard
memory bound still requires deliberately choosing a buffer size and overflow
policy.

[Broadway](https://hexdocs.pm/broadway) is declarative GenStage — a packaged
abstraction over the same protocol with ready-made queue connectors.

# Citations

- Source: <https://andrealeopardi.com/posts/genstage-demand-visualized/>
- Discussion: <https://www.reddit.com/r/elixir/comments/1vhxagp/elixirs_genstage_demand_a_visual_explainer/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:ef34f0">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-18-reading-list-batch-intake-63-links (2026-08-18)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:ef34f0`]**  (co-feeds: `em:3a1493 em:7b6928 em:9673c2 em:464bf7 em:144256 em:9a3434 em:edcaa2 em:0ecaed em:f13f81 em:a082f1 em:8f8a6b em:c06647 em:d138ff em:738593 em:eb9f29 em:b2676a em:333fce em:871b41 em:0512fe em:1d214a em:2357ce em:732198 em:87b2dd em:2afa02 em:3da9e6 em:69cd30 em:414eec em:6d4051 em:f988c6 em:bc60f3 em:7cdaf6 em:a77fb7 em:e4e835 em:25aa97 em:e307c9 em:805f4d survey/bookmarks.md`)

All 8 research batches (covering all ~63 URLs) are launched in the background — dev-tools/terminal tooling, version control, Sean Goedecke's AI-expertise essays, MCP/security/evals, ML models, media-production/audio, Elixir/misc SWE, and the 9 bare HN links (which needed resolving before I could even group them). I'll wait for these to complete before drafting and filing the actual documents, since dedup and directory placement decisions depend on their findings.

The 8 research agents are running in the background. I'll wait for their results before drafting and filing the actual documents — I'll pick this back up as notifications arrive.

Batch 2 is filed. Now waiting for the remaining 7 background research batches to continue with the rest of the intake.

All 8 research batches are complete. I found some cross-batch duplication (the HN batch independently surfaced the same Qwen 3.8, Piffer, and Wolfram-boids links that batch 5 already covered) — I'll consolidate those into single documents rather than filing twice. Let me check the remaining target directories before writing this large next wave of files.

All ~63 links have been processed. Bundle verifies clean, 5 commits on the branch, nothing pushed/PR'd since that wasn't requested. Here's the summary.

**What happened**

I ran this as an `/intake` pass over a large batch of ~63 pasted links spanning developer tooling, AI/agentic security and evals, Elixir, media-production/audio, and AI-and-mathematics topics. Because the batch was so large, I split it into 8 parallel research passes (grouped by topic) to fetch and draft each document, then filed everything myself sequentially — checking for existing coverage first, since several links turned out to duplicate documents this brain already had (herdr, the LLM CLI tool, the MCP spec post, the MAGE book, several Sean Goedecke essays, the UML intro, and the Circles/Sines/Signals explainer were all already filed from earlier sessions). Two links independently resurfaced the same underlying release from two different angles (Qwen 3.8 27B, and the Wolfram boids post) — I merged those into one document each rather than filing twice. 32 new documents got filed across 6 new subdirectories, all created autonomously since each sits under an already-established top-level domain (`SWE`, `machine-learning`, `version-control`). Three links couldn't be resolved (two X/Twitter posts blocked by fetch, one Reddit thread blocked entirely) — details below. Everything is committed to this branch (`claude/research-intake-links-soavsl`); no PR has been opened since that wasn't requested.

**What I created (32 documents, 6 new subdirectories)**

| Doc | Type | Directory |
|---|---|---|
| Jujutsu (jj) | reference | `version-control/jujutsu/` (new) |
| doyo | reference | `SWE/agentic/code-context/` |
| 9 dev-tools docs (SSH-terminal writeup, cheatsheet.nvim, chezmoi, Rousseau's dotfiles, Catppuccin, Starship, Atuin, zsh guide, OpenTUI) | reference | `SWE/dev-tools/` |
| Three real-world AI cybersecurity incidents | reference | `SWE/security/` |
| smevals | reference | `SWE/evals/` |
| GenStage demand-driven backpressure | reference | `SWE/elixir/` (new) |
| ISO 704:2022 | reference | `knowledge-management/knowledge-representation/` |
| Actual Budget self-hosting | reference | `SWE/self-hosting/` (new) |
| Pets vs. cattle history | reference | `SWE/infrastructure/` (new) |
| Architecting Awareness (diffusion-transformer proposal) | reference | `machine-learning/deep-learning/` |
| feedpaper (RSS→e-ink) | reference | `SWE/dev-tools/` |
| Going Dark (AI bug-hunting & backdoors) | reference | `SWE/security/` |
| AI financial-advice prompt specificity | reference | `SWE/agentic/prompt-design/` |
| Indie-developer decade (Jeff Johnson) | reference | `startups/` |
| Programming as Theory Building (Naur, 1985) | **source** | `SWE/agentic/expertise/` |
| Numerology (generative MIDI) | reference | `media-production/sequencing/` |
| loopmaster/groovemaster, rust-audio ecosystem, serum2gen | reference | `media-production/audio-synthesis/` |
| Qwen 3.8 27B, DeepSeek V4 Flash (**source**), AI-and-mathematics ×2, boids swarm | reference/source | `machine-learning/` (+2 new subdirs) |

**What I modified**

| File | Change |
|---|---|
| `doma.md` | sibling link now points to the new doyo doc |
| `herdr.md` | added a Usage section from its quick-start docs |
| `normalization-of-deviance-in-ai.md` | cross-linked the new cybersecurity-incidents doc |
| `programming-with-ai-agents-as-theory-building.md`, glossary `theory-building.md` | Naur citation now a bundle link instead of a bare URL |
| `survey/bookmarks.md` | Naur row flipped to `promoted`; Underpass added (see below) |
| 13 `index.md` files | new/updated entries for everything above |

**Not filed**

- **Underpass** (Jeff Johnson's P2P file-transfer app) — thin product page, parked in `survey/bookmarks.md` and cross-linked from his indie-developer retrospective rather than fully filed.
- **@GithubProjects tweet** — fetch blocked (HTTP 402) on every route tried; the account itself turned out to be an unofficial fan account, not GitHub's.
- **@mitchellh tweet** — resolved (a multi-model Fable+GPT-5.5 cost workflow, explicitly framed by him as untested/provisional); too thin and ephemeral to warrant filing.
- **r/LLMDevs "if AI writes the code in 2 days..."** — Reddit unreachable through every fetch path tried (direct, proxy, JSON API).

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | Open a PR now | `/create-pull-request` — captures this session as a thread doc, glossaries new terms, and opens the PR for the 5 commits already on this branch |
| 2 | Revisit the 3 unresolved links | Paste the tweet/thread content directly and I'll draft proper documents from it |
| 3 | Leave as-is | Commits stay on the branch for later review |

---

**[`em:ef34f0`]**  (co-feeds: `em:3a1493 em:7b6928 em:9673c2 em:464bf7 em:144256 em:9a3434 em:edcaa2 em:0ecaed em:f13f81 em:a082f1 em:8f8a6b em:c06647 em:d138ff em:738593 em:eb9f29 em:333fce em:871b41 em:0512fe em:1d214a em:2357ce em:732198 em:87b2dd em:2afa02 em:3da9e6 em:6d4051 em:f988c6 em:bc60f3 em:7cdaf6 em:a77fb7 em:e4e835 em:25aa97 em:e307c9 em:805f4d`)

Good catch — the gap is real and accounted for, not a dropped batch. Here's the reconciliation:

| Category | Links | Notes |
|---|---|---|
| **Filed as new documents** | 42 | Several links merged into one doc each (see below) |
| **Already covered by earlier intake sessions** | 16 | Confirmed by dedup search — same `resource` URL or same essay already filed; a few got a cross-link update, no new doc |
| **Unresolved / not filed** | 4 | Reddit thread (blocked), @GithubProjects tweet (blocked, turned out unofficial anyway), @mitchellh tweet (thin/ephemeral, reviewed not filed), Underpass (thin product page, parked in bookmarks instead) |
| **Update-in-place, not a new doc** | 1 | herdr's quick-start page added a Usage section to the *existing* herdr.md |
| **Total** | **63** | |

The 42→32 gap is 9 cases where multiple links were the same underlying thing, filed once:

| Merged into | From links |
|---|---|
| Qwen 3.8 27B | direct Willison link + HN link to the same post + HN link to the HF model card (3 links) |
| GenStage backpressure | the blog post + the Reddit thread discussing it |
| Sebastien Rousseau's dotfiles | the repo + its companion design post |
| smevals | the blog post + the project's own README |
| Catppuccin | the nvim port + the tmux port (one theming project, two ports) |
| rust.audio ecosystem | rust.audio + awesome-audio-dsp (the former just points at the latter) |
| Atuin | atuin.sh + the atuinsh/atuin GitHub repo (same tool) |
| Boids swarm post | the direct Wolfram link + an HN link to the same post |
| Piffer's AI-and-math essay | the direct link + an HN link to the same essay |

So: 42 links → 32 docs (9 merges saving 10), 16 links were dedup no-ops, 4 were dead ends, 1 was an edit rather than a new file. 42 + 16 + 4 + 1 = 63.

Pushed. The branch `claude/research-intake-links-soavsl` is now up to date on the remote with all 5 commits — no PR opened yet, since that wasn't requested. Let me know if you'd like me to open one (`/create-pull-request`).
