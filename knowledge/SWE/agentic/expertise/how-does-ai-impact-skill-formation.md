---
id: em:457a88
type: reference
title: "How does AI impact skill formation? (Sean Goedecke)"
description: "Goedecke's reading of the Anthropic Fellows skill-formation study — the no-speedup headline hides a retyping confound (AI users were 25% faster without it), reduced learning-per-task is real but engineers are paid to deliver rather than to learn, and higher task volume may offset it."
resource: https://www.seangoedecke.com/how-does-ai-impact-skill-formation/
provenance: "Sean Goedecke, seangoedecke.com essay, published 2026-01-31"
tags: [skill-formation, learning, deskilling, ai-assisted-development, developer-productivity, anthropic-research]
timestamp: 2026-08-04T07:05:00Z
attribution:
  when: 2026-08-04T07:05:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted five seangoedecke.com essays on AI and engineering expertise for filing"
---

# How does AI impact skill formation?

Sean Goedecke's commentary on the Anthropic Fellows study *How AI Impacts
Skill Formation*, pushing back on the popular reading that it proves AI makes
developers slower and dumber.

## The speed finding hides a confound

The study's headline is that AI users were not faster overall. Goedecke's
objection: some participants manually retyped AI-generated code instead of
pasting it, and "If you ignore the people who spent most of their time
retyping, the AI-users were 25% faster." Since retyping is not how anyone
works, the aggregate masks a real speedup.

## Learning less per task is real — and priced in

He grants the study's core: "Nobody seriously believes that typing 'build me a
todo app' into Claude Code means you'll learn as much as if you built it by
hand." Two counterpoints follow:

- **Delivery is the job.** "software engineers are not paid to learn about the
  codebase" — "We are paid to deliver business value (typically by delivering
  working code)." Professions that require ongoing study budget dedicated time
  for it, outside task delivery. The opposing view — that the pre-delegation
  grind is exactly where the expertise that makes delegation safe comes from —
  is [Williams's hand-off argument](/knowledge/SWE/agentic/adoption/its-not-empowering-to-hand-off-the-details.md);
  what the thinned-out per-task learning erodes is the engineer's
  [theory of the program](/knowledge/SWE/agentic/expertise/programming-with-ai-agents-as-theory-building.md).
- **Volume may compensate.** Less learning per task times more tasks — across
  more systems — can still net out to more learning in breadth.

He also questions the study's model choice: it used GPT-4o, though "This study
was funded by Anthropic, who have much better models."

## What would settle it

Long-term studies of whether reduced learning-per-task is offset by increased
completion rates: "It's probably too early to answer these questions — strong
coding agents have only been around for a handful of months — but the answers
may determine what it's like to be a software engineer for the next decade."

# Citations

- Source: <https://www.seangoedecke.com/how-does-ai-impact-skill-formation/>
- The study under discussion: Anthropic Fellows, "How AI Impacts Skill
  Formation" — <https://www.anthropic.com/research/AI-assistance-coding-skills>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:457a88">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-04-goedecke-expertise-essays-intake (2026-08-04)

4 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:457a88`]**  (co-feeds: `survey/bookmarks.md`)

None of the five URLs are filed or bookmarked — all five are new documents. The survey tier does hold the Anthropic skill-formation paper Goedecke's third article analyzes, so I'll cite it rather than treat this as its promotion. Let me check two more related docs for cross-linking, then verify my key quotes against the sources.

---

**[`em:457a88`]**  (co-feeds: `em:3d9101 em:69cd30 em:abdca2 em:ccee99 knowledge/SWE/agentic/expertise/index.md`)

All quotes are now verified with exact spans. Now for the filing decision — articles 1, 2, 3, and 5 form a coherent cluster on how AI-assisted development interacts with the human engineer's expertise (its leverage, formation, retention, and distribution); no existing `agentic/` subdirectory covers that, so I'll create `knowledge/SWE/agentic/expertise/` (a subdirectory under an established domain — autonomous per the taxonomy protocol). Article 4 is a pure software-design essay and files into the existing `software-design/`. Let me check the id-minting task, then write.

---

**[`em:457a88`]**  (co-feeds: `em:3d9101 em:69cd30 em:abdca2 em:ccee99`)

Your five links were all new to the brain — none were already filed or parked in the survey tier. Four of them turned out to be one coherent subject: how AI-assisted development interacts with the human engineer's expertise — where it stays the leverage point, how it forms, whether agents can hold it, and what happens to the ability distribution. No existing directory covered that, so I created a new subdirectory for it under the established agentic domain, [`knowledge/SWE/agentic/expertise/`](https://github.com/ob6to8/elixir-mind/blob/claude/ai-software-engineering-expertise-tat4rl/knowledge/SWE/agentic/expertise/index.md) — a within-domain subdirectory, so created autonomously per the taxonomy protocol rather than held for ratification. The fifth essay is a pure software-design piece and filed into the existing `software-design/` directory. Every quote in the filed docs was verified verbatim against the source in a second fetch pass before being quoted; the commit passed the full gate suite and is pushed to the session branch. No PR was opened — that stays with `/create-pull-request`.

---

**[`em:457a88`]**  (co-feeds: `survey/bookmarks.md`)

One connection into the survey tier: the Anthropic Fellows skill-formation study that the third essay analyzes is already a surveyed bookmark in `survey/bookmarks.md`. The filed doc cites the paper's URL directly; the bookmark row stays `surveyed` since this intake captured Goedecke's commentary, not the paper itself — promoting the paper into its own `reference` remains available if you want the primary source filed too.
