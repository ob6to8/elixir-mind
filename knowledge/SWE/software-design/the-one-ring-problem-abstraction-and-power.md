---
id: em:b9158a
type: reference
title: "The One Ring Problem: Abstraction and Power (Ted Kaminski)"
description: "Kaminski's trade-off law for abstraction design — power and properties move in opposite directions, and the common design failure is adding power to fix a limitation without noticing the properties it costs."
resource: https://www.tedinski.com/2018/01/30/the-one-ring-problem-abstraction-and-power.html
provenance: "Ted Kaminski, tedinski.com essay, published 2018-01-30"
tags: [abstraction, language-design, software-design, trade-offs, api-design]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# The One Ring Problem: Abstraction and Power

Ted Kaminski's essay states a trade-off law for abstraction design, prompted by
reading old Extensible Languages Symposium proceedings and noticing a
recurring pattern: "Quite a lot of papers would come up with something they
wanted to do, show that existing designs were incapable of doing it, then
design some more powerful system where they could." He names this "a common
failing among programmers."

## The law

"You cannot make an abstraction more powerful without sacrificing some
properties that you used to know about it. Necessarily." And the converse:
"You cannot require a new property be true about an abstraction without
sacrificing some of its power and flexibility. Always." An abstraction has an
inside and an outside: "You cannot create an abstraction without saying two
things: what it is, and what it is not." Push power up and guarantees fall;
push guarantees up and power falls. "The design spectrum: an all-powerful
abstraction is a meaningless one (you've just got a new word for 'thing'),
while a tightly constrained abstraction could only be a few things. Design is
figuring out how to find a point in the middle."

He demonstrates the trade with a Haskell function signature: `inc :: Integer
-> Integer` generalized to `inc :: Num a => a -> a` gains the power to work
over any numeric type, but "now properties about x go away: we don't know for
a fact it's an integer, so now this function probably has a less efficient
implementation" — while gaining a narrower property in exchange (no longer
free to do arbitrary integer-specific things, only what `Num` supports).

## The failure mode

"Nearly always, this error happens in one direction. To look on a design, see
what cannot be done with it, and attempt to 'fix' it. To make it more
powerful, and forget that it necessarily becomes more meaningless." Macro
systems are his cautionary example — a C macro that silently renames an
identifier defeats any attempt at automated refactoring: "We've made things
more powerful, but we've lost really important properties that may well be
much more useful. But more importantly, I think this decision is routinely
made without understanding these consequences." Plugin systems invert the
picture: once an ecosystem of plugins exists, "you can't possibly make
changes that would break plugins" — the application, not the plugin, becomes
the constrained party, which is why Python 2 outlived Python 3's release and
why long-lived editors resist changing their extension-facing internals.

The essay's title alludes to Tolkien without explaining itself — a section
headed "The one ring to rule them all" surveys languages (C++, Scala) and
DSLs that crept toward Turing-completeness by repeatedly choosing power over
declarative guarantees, "generally, to their detriment." A single
maximally-powerful abstraction, like a ring built to bind every lesser ring,
buys unconstrained flexibility at the cost of every specific guarantee a
narrower design would have let you rely on.

## The corrective

"The most important point is simply to recognize properties as being a valid
(and arguably most important) part of abstraction design. We commonly, and I
believe mistakenly, focus instead on power." Kaminski frames this as needing
active resistance to a psychological default, not just design know-how: "we
have to actively work against our worst impulses" — the way the scientific
method exists to counteract, rather than assume away, the human tendency to
believe convenient things.

# Citations

- Source: <https://www.tedinski.com/2018/01/30/the-one-ring-problem-abstraction-and-power.html>
- Discussion thread (fetch-blocked by Reddit's anti-bot protection; not captured):
  <https://www.reddit.com/r/programming/comments/7u2bfo/the_one_ring_problem_abstraction_and_our_quest/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:b9158a">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-21-reading-list-batch-intake-65-links (2026-08-21)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:b9158a`]**  (co-feeds: `em:f38c06 em:aa3f68 em:8be1fe`)

All four batches are running in the background. While those work, here's where things stand and what still needs your input.

**A batch of ~65 unique links, four are running now:**
- Batch A — agent memory, MCP dedup, AI code-review tooling, Cursor's agent-orchestration posts → `knowledge/SWE/agentic/*`
- Batch B — benchmarks and papers (lilybench, livebench, SYCON-Bench, arxiv/alphaxiv) → `knowledge/SWE/evals/`, `ai-industry/`, `machine-learning/`
- Batch C — the Rust cluster (rust-analyzer/cargo-xtask, matklad essays, zinit/bottom/zoxide, rustlings, bash guide) → new `knowledge/SWE/rust/` + `dev-tools/`
- Batch D — general SWE essays (abstraction, reasoning, testing, AI-era practice) → `software-design/`, `testing/`, `agentic/expertise/`

---

**[`em:b9158a`]**  (co-feeds: `em:f38c06 em:aa3f68 em:8be1fe em:0a7cd9`)

The full batch is filed, verified, committed, and pushed. Here's where it landed.

You pasted a reading list of roughly 65 distinct links (after dedup). I split fetching and distillation across four parallel research passes by topic, each writing into its own directories to avoid collisions, then filed the handful of items none of them owned myself, minted ids and rebuilt the registry in one pass at the end, and ran the full gate suite (format, compile, `mix brain.verify`, route-tags, glossary, matters, lineage, 211 tests) before committing. Everything passed clean. The branch (`claude/research-intake-links-kqwhod`) is pushed; no PR was opened since you didn't ask for one.

**What I created**

| Area | Docs | Notes |
|---|---|---|
| Agentic tooling, agent-memory, code-review, Cursor orchestration posts | 13 | `knowledge/SWE/agentic/*` |
| Benchmarks & papers (LilyBench, LiveBench, SYCON-Bench, alphaxiv/arxiv) | 9 | `knowledge/SWE/evals/`, `machine-learning/ai-and-mathematics/` |
| Rust ecosystem | 12 | new `knowledge/SWE/rust/` + 4 in `dev-tools/` |
| SWE essays (abstraction, reasoning, testing, AI-era practice) | 11 | `software-design/`, `testing/`, `llm-engineering/`, `agentic/governance/`, new `cognitive-science/sensemaking/` |
| Items no batch owned, filed by me directly | 6 | why-steering-works, follow-md-links.nvim, claudish-to-english+Vomit (merged), Cursor's "Git at any scale", "HTML can do that", "Sol loves to cheat" |
