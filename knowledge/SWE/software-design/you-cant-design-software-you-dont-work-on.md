---
id: em:ccee99
type: reference
title: "You can't design software you don't work on (Sean Goedecke)"
description: "Good software design requires intimate knowledge of the system's concrete details — in real work concrete factors dominate generic principles, so real design happens among the engineers who work the code, and detached architects escape accountability for their designs."
resource: https://www.seangoedecke.com/you-cant-design-software-you-dont-work-on/
provenance: "Sean Goedecke, seangoedecke.com essay, published 2025-12-27"
tags: [software-design, architecture, architect-role, concrete-vs-generic, accountability]
timestamp: 2026-08-04T07:05:00Z
attribution:
  when: 2026-08-04T07:05:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted five seangoedecke.com essays on AI and engineering expertise for filing"
---

# You can't design software you don't work on

Sean Goedecke's claim: "you cannot do good software design without an intimate
understanding of the concrete details of the system." Books and blogs teach
generic design — patterns, principles, domain modeling — but "When you're
doing real work, concrete factors dominate generic factors." In an established
codebase, consistency with what exists outweighs abstract ideals, and the
interdependencies of the existing structure constrain the viable options far
more than any principle does. The design conversations that matter are the
arcane, concrete ones — could this behavior live in subsystem A? no,
because… — held between engineers who know the system intimately.

## Where generic design advice is legitimate

Three carve-outs, verbatim:

- "Generic software design advice is useful for building brand-new projects."
- "Generic software design advice is useful for tie-breaking concrete design
  decisions."
- "Generic software design principles can also guide company-wide
  architectural decisions."

## The accountability critique

The detached architect — designing systems others must implement — sits in an
unfalsifiable position: "architects can both claim credit for successes (after
all, it was their design) and disclaim failures (if only those fools had
followed my design!)" Goedecke's remedy is designer accountability: whoever
designs a system bears responsibility for its outcomes, which forces designs
through the filter of shipping reality and ensures "the _real_ software
designers — the ones that have to take into account all the rough edges and
warts of the codebase — get credit for the difficult design work they do."

The claim that design knowledge lives in those who work the code is Naur's
theory-building thesis applied to design — see
[programming (with AI agents) as theory building](/knowledge/SWE/agentic/expertise/programming-with-ai-agents-as-theory-building.md).
[Hohpe's architect-as-amplifier](/knowledge/SWE/software-design/the-architect-as-amplifier.md)
model is the practice-side complement: an architect role justified by lowering
risk and framing the solution space rather than by holding design authority
over code they don't touch.

# Citations

- Source: <https://www.seangoedecke.com/you-cant-design-software-you-dont-work-on/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:ccee99">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-04-goedecke-expertise-essays-intake (2026-08-04)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:ccee99`]**  (co-feeds: `em:3d9101 em:69cd30 em:457a88 em:abdca2 knowledge/SWE/agentic/expertise/index.md`)

All quotes are now verified with exact spans. Now for the filing decision — articles 1, 2, 3, and 5 form a coherent cluster on how AI-assisted development interacts with the human engineer's expertise (its leverage, formation, retention, and distribution); no existing `agentic/` subdirectory covers that, so I'll create `knowledge/SWE/agentic/expertise/` (a subdirectory under an established domain — autonomous per the taxonomy protocol). Article 4 is a pure software-design essay and files into the existing `software-design/`. Let me check the id-minting task, then write.

---

**[`em:ccee99`]**  (co-feeds: `em:3d9101 em:69cd30 em:457a88 em:abdca2`)

Your five links were all new to the brain — none were already filed or parked in the survey tier. Four of them turned out to be one coherent subject: how AI-assisted development interacts with the human engineer's expertise — where it stays the leverage point, how it forms, whether agents can hold it, and what happens to the ability distribution. No existing directory covered that, so I created a new subdirectory for it under the established agentic domain, [`knowledge/SWE/agentic/expertise/`](https://github.com/ob6to8/elixir-mind/blob/claude/ai-software-engineering-expertise-tat4rl/knowledge/SWE/agentic/expertise/index.md) — a within-domain subdirectory, so created autonomously per the taxonomy protocol rather than held for ratification. The fifth essay is a pure software-design piece and filed into the existing `software-design/` directory. Every quote in the filed docs was verified verbatim against the source in a second fetch pass before being quoted; the commit passed the full gate suite and is pushed to the session branch. No PR was opened — that stays with `/create-pull-request`.
