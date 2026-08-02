---
type: analysis
title: "Complete-spec prompting read against this brain's iterative delivery"
description: Evaluates the complete-spec prompt genre (one up-front artifact declaring objective, boundaries, invariants, and acceptance, executed long-horizon) against this repo's layered iterative methodology; finds the industry unsettled (spec-driven development at Radar "Assess", Anthropic's guidance carrying both modes with an explicit dial), the choice scenario-dependent along five named axes, and this repo already a hybrid that factors the mega-spec into layers with different lifetimes and enforcement — leaving one transferable residue: promote the ad-hoc Deliver/Verify/out-of-scope packet fields to the standard matter shape.
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02 — operator asked how submitting a complete-spec prompt compares, in philosophy and methodology, to this repo's iterative approach"
tags: [meta, analysis, methodology, specs, planning, matters, agents, industry, workflow]
timestamp: 2026-08-02T22:20:00Z
attribution:
  when: 2026-08-02T22:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, GitHub task session"
  why: "operator asked for an evaluation of complete-spec prompting against this repo's iterative methodology — pros and cons, industry standing, best practices of each, and what the genre's structure (declared boundaries and invariants) could fold into the workflow here"
---

# Complete-spec prompting read against this brain's iterative delivery

**Question.** The operator asked how submitting a **complete-spec prompt** — a
single up-front artifact stating what to build, with declared boundaries and
invariants — compares to the iterative approach this repo takes: whether either
approach dominates in the industry, what the best practices of each are,
whether the choice is scenario-dependent, and what the genre's structure could
be folded into the workflow here.

**The specific prompt's text did not arrive with the request.** Scope of that
finding: the task description as delivered ends at the question; the working
tree at session start was clean with no untracked file; the designated session
branch pointed at the same commit as `main` (`075dc82`); the repository had
zero open GitHub issues; and a grep for spec-prompt markers over `journal/`,
`inbox/`, and `survey/bookmarks.md` surfaced no pasted spec. The reading below
therefore addresses the **genre**, using the two features the operator named —
a complete spec, and an explicit declaration of boundaries and invariants —
and this analysis takes a prompt-specific addendum whenever the text is
supplied, per [update-in-place](/meta/policy/update-in-place.md).

**Bottom line.** Neither approach is dominant; the industry's spec-driven wave
is productized but unsettled (Thoughtworks Radar holds it at **Assess**, Nov
2025), and the practical guidance of the major vendors is converging on a
**hybrid**: spec artifacts at decision granularity, iterative execution under
machine verification, and human ratification at phase boundaries. This repo is
already that hybrid — it did not skip the complete spec so much as **factor it
into layers** with different lifetimes and different enforcement. The genre's
one transferable residue here is packet-level, not architectural: make
**Deliver / Verify / Out of scope** standard fields of the matter packet,
where today they appear ad hoc (measured 2026-08-02 by grep over
`meta/matters/*.md`: 8/40 docs carry a `**Deliver:**` field, 5/40 a
`**Verify:**` field, 3/40 any boundary/out-of-scope language).

## 1. The two methodologies, characterized

### The complete-spec prompt

One artifact, submitted at t=0, that attempts to carry everything the executor
needs: the objective, the scope and its boundaries (non-goals), the invariants
that must hold throughout, acceptance criteria, and often a phased task
breakdown. The agent then runs long-horizon; the human reviews at the end. The
2025 productizations of the pattern, each verified against its primary
surface:

- **GitHub Spec Kit** — "Define what to build before building it — with any
  AI coding agent" ([github.com/github/spec-kit](https://github.com/github/spec-kit)).
  Its pipeline is the genre's anatomy made into slash commands:
  `/speckit.constitution` ("Create or update project governing principles and
  dev guidelines"), then `specify` → `plan` → `tasks` → `implement`. Its claim
  for the approach: "Spec-Driven Development flips the script on traditional
  software development … specifications become executable, directly
  generating working implementations rather than just guiding them."
- **AWS Kiro** — "Feature Specs provide a structured approach to building new
  features, guiding you through requirements gathering, technical design, and
  implementation planning"
  ([kiro.dev/docs/specs](https://kiro.dev/docs/specs/feature-specs/)); "The
  `requirements.md` file uses EARS (Easy Approach to Requirements Syntax)
  notation to provide structured, testable requirements," beside a
  `design.md` that "documents technical architecture, sequence diagrams, and
  implementation considerations" and a task breakdown.
- **Tessl** — the maximal form, per the Radar: "takes a more radical approach
  in which the specification itself becomes the maintained artifact, rather
  than the code"
  ([Thoughtworks Radar](https://www.thoughtworks.com/radar/techniques/spec-driven-development)).
- **The loop-hardened extreme** is already captured in this bundle:
  [Ralph](/knowledge/SWE/agentic/agentic-loop/ralph-infinite-bash-loop-coding-agent.md)
  (`em:276c61`) pipes one fixed prompt into an agent forever, with spec
  documents "deterministically re-loaded each cycle as stable reference
  points against LLM non-determinism."

### This repo's methodology

Not the absence of a spec — a **decomposition of the mega-spec into four
layers**, each with its own lifetime and its own enforcement:

| Layer | Artifact | Lifetime | Enforcement |
|---|---|---|---|
| Standing invariants | the compiled contract (`CLAUDE.md` from `meta/policy/`) + the gate suite | permanent, ratification-mutable | **machine** where an oracle exists (`mix brain.verify`, warnings-as-errors, xref, CI), editorial elsewhere |
| Per-change design | [plans](/meta/plans/index.md) with [structured bodies](/meta/policy/structured-plan-bodies.md) | until executed or superseded | operator ratification; the refresh rule re-anchors against `HEAD` |
| Per-delivery packet | [matters](/meta/matters/index.md) — "one coherent intent a reviewer can approve or reject as a whole" | one PR | approval gate in `/matter`; [one matter per PR](/meta/policy/git-atomic-pull-requests.md) |
| The record | thread docs, true-merge commit graph | permanent | capture and merge policies |

The load-bearing directions behind the decomposition:
[verified increments](/meta/doctrine/verified-increments.md) ("generation is
cheap and review attention is the bottleneck, so work is shaped to fit
review, not batched to amortize it" —
[atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md)) and
[scoped units, corrected forward](/meta/doctrine/scoped-units-corrected-forward.md)
(one scoped unit per thread; imperfection in what landed is corrected by a
following unit, never by narrated mid-thread revision).

## 2. Pros and cons

### What the complete spec buys — and where it fails

**Pros.**

- **Decisions are made where changing them is cheapest.** A spec is text; the
  argument happens before any code exists. This is the same belief this repo
  already holds for plans: each structured artifact "is a decision you'd
  otherwise be making implicitly during code review — at the most expensive
  possible time to change your mind"
  ([em:6c7e85](/beliefs/plan-artifacts-surface-implicit-review-decisions.md)).
- **Autonomy and parallelism.** A self-contained spec is what lets a run
  proceed unattended, overnight, or fanned out across executors; the human
  round-trip is removed from the inner loop. Anthropic's guidance endorses
  exactly this at feature scale: interview → "write a complete spec to
  SPEC.md" → "Once the spec is complete, start a fresh session to execute
  it" ([best practices](https://code.claude.com/docs/en/best-practices)).
- **One auditable statement of intent.** Everything the executor was told is
  in one reviewable artifact — against a conversational transcript, whose
  instructions accrete and contradict silently.
- **Declared invariants and boundaries counter scope creep and drift** —
  provided something re-asserts them (Ralph's re-loaded spec files, Spec
  Kit's constitution "defining immutable principles that must always be
  followed").

**Cons.**

- **The waterfall failure mode, amplified.** Requirements fixed before
  contact with the implementation encode guesses; an agent then builds the
  wrong thing *fast and at volume*. The industry's own assessors lead with
  this: the Radar cautions "We may be relearning a bitter lesson — that
  handcrafting detailed rules for AI ultimately doesn't scale," and
  Thoughtworks' practice write-up concedes the resemblance — "I've heard some
  people claim this is a return to waterfall — not unreasonably — but I
  believe this time is different"
  ([Liu Shangqi](https://www.thoughtworks.com/en-us/insights/blog/agile-engineering-practices/spec-driven-development-unpacking-2025-new-engineering-practices)).
- **The spec-detail paradox.** Driving one-shot reliability up drives spec
  detail toward code: "a spec that is sufficiently detailed to generate code
  with a reliable degree of quality is roughly the same length and detail as
  the code itself" ([em:1eebdf](/beliefs/spec-detail-approaches-code-length.md))
  — at which point the artifact loses its review advantage ("so don't review
  those things" — [em:0c4913](/beliefs/dont-review-code-length-specs.md)).
  The complete-spec prompt lives inside this squeeze: too coarse and the
  agent decides silently; detailed enough to prevent that and it is code in
  a worse notation.
- **Ambiguity has no ratification channel.** Mid-run discoveries — an
  underspecified case, a wrong assumption — are resolved by the executor's
  interpretation, invisibly. The iterative loop's whole point is that these
  become blocking questions.
- **Review arrives end-loaded.** One long run yields one large diff, which is
  the delivery shape [verified increments](/meta/doctrine/verified-increments.md)
  exists to reject: review attention is the scarce resource, and a diff sized
  to the run rather than to the reviewer spends it worst.
- **Prompt-stated invariants are attention-enforced.** They hold only while
  the model keeps attending to them, and the vendor's own guidance names the
  degradation: "Claude's context window fills up fast, and performance
  degrades as it fills"
  ([best practices](https://code.claude.com/docs/en/best-practices)). An
  invariant that matters is a gate, not a sentence — this repo's
  [gate suite](/meta/tutorials/the-gate-suite-and-where-it-runs.md) versus a
  paragraph the run may forget.

### What the iterative layered approach buys — and what it costs

**Pros.**

- **Review-sized increments, each landing green** — the delivery half of
  [verified increments](/meta/doctrine/verified-increments.md), with the gate
  suite unconditional beneath every one.
- **Correction is forward and cheap** — a following scoped unit, not a
  mid-run steering attempt against a context already full of the wrong turn.
- **Invariants live in machinery.** The contract compiles into every session;
  everything oracle-checkable is a gate. Enforcement does not decay with
  context length.
- **The shape of the system evolves under ratification** — taxonomy, types,
  and policies change by proposal, so requirement discovery is a feature of
  the process rather than a spec defect.

**Cons.**

- **The operator is in the throughput path.** Approval gates, one matter per
  PR, and ratification of shape changes cap parallelism at what the operator
  can review — the deliberate inverse of the complete-spec run's autonomy.
- **Per-unit ceremony is real.** Matters, plans, register rows, captures —
  the [scoped-units doctrine](/meta/doctrine/scoped-units-corrected-forward.md)
  itself carries the reflexive clause that their number "is not, by itself,
  evidence of overhead," which is also an admission that the overhead
  question recurs.
- **Context transfer must be paid explicitly.** What the mega-spec carries in
  one artifact, this system carries in plans and packets that must be written
  well ([plan-vs-capture](/meta/policy/plan-vs-capture.md)'s discriminator is
  exactly this cost).
- **Large outcomes arrive with latency** — a multi-matter plan lands over
  days of sequential PRs, where a spec-run would have produced (something) in
  one pass.

## 3. Industry standing

**Neither approach is dominant; the field is explicitly unsettled.** The
spec-driven wave is productized by first-tier vendors (GitHub, AWS, Tessl),
yet its own assessors hold it at arm's length: the Radar places it in
**Assess** (Nov 2025) — defined as "Worth exploring with the goal of
understanding how it will affect your enterprise" — and describes it as "an
emerging approach to AI-assisted coding workflows" whose "definition is still
evolving"; Thoughtworks' companion write-up closes "Spec-driven development
remains an emerging practice as 2025 draws to a close; we're likely to see
even more change in 2026."

**The vendors' practical guidance is already hybrid.** Anthropic's best
practices carry both modes with an explicit dial: the default is iterative
("Explore first, then plan, then code," four phases ending in a commit;
"Course-correct early and often"; "The best results come from tight feedback
loops"), the escalation is a spec ("For larger features, have Claude
interview you first … then write a complete spec to SPEC.md," executed by a
fresh session), and the dial is stated in one sentence: **"If you could
describe the diff in one sentence, skip the plan."** The same page's first
principle — "Give Claude a check it can run: tests, a build, a screenshot to
compare. It's the difference between a session you watch and one you walk
away from" — is the verification half of both modes. Kiro's EARS notation
("structured, testable requirements") and Spec Kit's phase gates with a human
between them point the same direction from the spec-first side: the spec
camp is busy adding feedback loops and checkable acceptance, the iterative
camp is busy adding persistent artifacts. Thoughtworks states the synthesis
plainly: "It's not creating huge feedback loops like waterfall — it's
providing a mechanism for shorter and effective ones than would otherwise be
possible with pure vibe coding."

**Why the pendulum moved at all** (synthesis): agents lack the persistent
organizational context a human team carries, so the agent era pushed even
iterative practitioners toward more written specification than post-agile
humans kept — the spec substitutes for shared memory. This bundle is itself
evidence: an iterative shop whose standing written context (contract,
plans, packets) far exceeds what a human team would write down.

**Scenario-dependence, on five axes.** The industry treats "which is better"
as a dial rather than a verdict, and the axes that set it are stable across
sources:

1. **Requirement certainty** — known and stable favors spec; discovered
   favors iteration.
2. **Oracle availability** — machine-checkable acceptance (tests, EARS-style
   criteria, a reproducible check) is what makes a long unattended run safe;
   its absence forces short human-reviewed loops. (The repo-wide form of
   this axis is the
   [oracle-trust depth rule](/meta/analysis/depth-of-code-understanding.md).)
3. **Blast radius** — reversible, sandboxed work tolerates one-shot runs;
   outward-facing or hard-to-reverse work wants ratification points.
4. **Attendance** — a human at the keyboard makes course-correction cheap
   (iterate); overnight/fleet execution has no one to ask (spec harder, gate
   harder).
5. **Review capacity** — the binding constraint this repo optimizes for;
   end-loaded mega-diffs are unreviewable regardless of how good the spec
   was.

A one-shot complete spec is the *right* call at one corner of that space —
greenfield, well-oracled, sandboxed, unattended, low review budget per unit
of output — and the wrong call at this repo's corner, where the corpus is
the operator's own epistemic record and review sovereignty is the point.

## 4. Best practices of each

**Complete-spec prompting, done well** (from the verified sources plus the
genre's own structure):

- **Separate the constitution from the feature spec.** Standing invariants go
  in a durable, reusable artifact (Spec Kit's constitution); the per-feature
  spec carries only what is local to the feature. Mixing them makes every
  spec restate the world.
- **Make acceptance machine-checkable** — EARS-style conditions, named test
  cases, an executable check — and **"end with an end-to-end verification
  step that proves the feature works"**
  ([Anthropic](https://code.claude.com/docs/en/best-practices)).
- **State what is out of scope.** "The most useful specs are self-contained:
  they name the files and interfaces involved, state what is out of scope,
  and end with an end-to-end verification step" (ibid.) — the boundary
  declaration is what keeps a long run from wandering.
- **Gate between phases.** Spec Kit's specify → plan → tasks → implement with
  human review between phases is not one-shot at all; the pure one-shot is
  the degenerate case the Radar warns about.
- **Hold the spec at decision granularity** — interfaces, layout, order,
  acceptance — and stop, per the spec-detail bound
  ([em:1eebdf](/beliefs/spec-detail-approaches-code-length.md)); past it,
  write the code instead.
- **Execute in fresh context** ("start a fresh session to execute it") and
  re-assert the spec against drift (Ralph's re-load discipline).
- **Give the run an escalation clause** — what to do on ambiguity: stop and
  ask, or choose conservatively and log the choice. A spec silent on this
  has delegated its ambiguities to chance.

**Iterative delivery, done well** (this repo's practice, stated generally):

- **Ship review-sized increments, tests riding with the change**, every
  increment green ([verified increments](/meta/doctrine/verified-increments.md),
  [atomic PRs](/meta/policy/git-atomic-pull-requests.md)).
- **Persist decisions between sessions as artifacts** — plans at decision
  granularity, packets a fresh thread can deliver — never as chat memory
  ([persist-plans](/meta/policy/persist-plans.md),
  [deferred-work-is-filed](/meta/policy/deferred-work-is-filed.md)).
- **Compile standing rules into every context and machine-enforce what has
  an oracle** (the contract + gate suite pattern).
- **Ratify shape changes; act autonomously inside the established shape**
  ([taxonomy-evolution-protocol](/meta/policy/taxonomy-evolution-protocol.md)).
- **Correct forward through scoped units instead of steering mid-run**
  ([revision-enters-through-scoping](/meta/policy/revision-enters-through-scoping.md)).
- **Keep the loop's verification tight and cheap** — focused tests in play,
  full suite at the boundary
  ([agent development methodology](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md),
  `em:cab2c5`).

## 5. What the genre offers this repo

Mapping the complete-spec prompt's sections onto this repo's layers shows
most of them already present in a stronger form, and isolates the gaps:

| Spec-prompt section | Home in this repo today | State |
|---|---|---|
| Constitution / standing invariants | the compiled contract + gate suite | **stronger than the genre** — machine-enforced, ratification-mutable, in every session's context |
| Objective / intent | the matter packet ("the intent plus the decisions already made") | present |
| Task breakdown / phases | a plan's build order emitting ordered matters | present, and review-quantized — each phase is separately approvable |
| Executor assignment | `model:` stamps under [capability-matched selection](/meta/doctrine/capability-matched-model-selection.md) | **beyond the genre** |
| Acceptance criteria | ad hoc: `**Verify:**` in 5/40 matter docs; the gate suite implicitly | **gap** — not part of the standard packet shape |
| Boundaries / non-goals | plans close with alternatives-rejected in the decision list; matters: 3/40 carry any boundary language | **gap at the matter level** |
| Task-scoped invariants | contract covers global invariants only; per-unit "what must remain true" lives in chat when it exists | **gap** |

Three fold-in candidates follow, ordered by leverage. All three are packet
conventions — none changes the architecture, and each imports the genre's
*declaration discipline* without importing its one-shot delivery:

1. **Standardize `Deliver / Verify / Out of scope` as named fields of the
   matter packet** (in [`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md)
   §4 and mirrored in `/matter`'s consumption protocol). The practice
   already exists ad hoc (8/40, 5/40, 3/40 measured above); the change is
   promotion from habit to shape. `Verify` should prefer an executable
   check — the packet-level form of "Give Claude a check it can run," and
   the EARS instinct applied where this repo quantizes work. This extends
   [verified increments](/meta/doctrine/verified-increments.md) from the
   delivery (PR) down into the handoff artifact itself.
2. **Add an explicit out-of-scope line to the structured plan's decision
   list.** [structured-plan-bodies](/meta/policy/structured-plan-bodies.md)
   item 7 carries "recommended shape, alternatives rejected, open questions
   and assumptions"; alternatives-rejected is adjacent to but not the same
   as a scope boundary ("this plan deliberately does not touch X"). One
   added clause makes scope creep checkable at plan review.
3. **A task-scoped invariants line in the packet, for constraints no gate
   covers** — "no new dependencies," "the register's four-cell shape is
   untouched," "policy Y is out of bounds this delivery." Global invariants
   stay in the contract, where they are enforced; the packet line covers
   the per-unit remainder that today survives only as chat. The inverse
   lesson travels with it: where a gate already enforces an invariant, the
   packet does not restate it — a prompt-stated copy of a machine-enforced
   rule is the genre's weakness, not its gift.

These are offered as options for ratification, not adopted here: the first
edits a skill's prescribed shape and the second a policy — both shape
changes per [taxonomy-evolution-protocol](/meta/policy/taxonomy-evolution-protocol.md)'s
spirit, and policy edits in any case route through
[`/render-contract`](/.claude/skills/render-contract/SKILL.md).

## 6. Verdict

Scenario-dependent, with the axes in §3 setting the dial — and the industry's
own assessors say so by placing the strong form at Assess while their
practical guidance hybridizes. The pure one-shot complete spec and pure
undocumented iteration are both corner cases: the first collapses under the
spec-detail paradox and end-loaded review except where a strong oracle and a
sandbox make its autonomy cheap; the second cannot steer agents at all, which
is why even iterative practice now writes contracts, plans, and packets. This
repo already occupies the hybrid — a standing machine-enforced constitution,
decision-granularity plans, review-quantized delivery — tuned correctly for
its constraints (operator-sovereign corpus, review as the bottleneck). What
the complete-spec genre still teaches it is the declaration discipline at the
packet level: every unit of work stating, in its own artifact, how its
deliverer will know it is done and where its edges are.

# Citations

- Thoughtworks Technology Radar, "Spec-driven development" (Assess, Nov 2025) —
  <https://www.thoughtworks.com/radar/techniques/spec-driven-development>
- Liu Shangqi, "Spec-driven development: Unpacking one of 2025's key new
  AI-assisted engineering practices," Thoughtworks Insights —
  <https://www.thoughtworks.com/en-us/insights/blog/agile-engineering-practices/spec-driven-development-unpacking-2025-new-engineering-practices>
- GitHub Spec Kit — <https://github.com/github/spec-kit>
- AWS Kiro, Feature Specs documentation — <https://kiro.dev/docs/specs/feature-specs/>
- Anthropic, "Best practices for Claude Code" —
  <https://code.claude.com/docs/en/best-practices>
- In-bundle: the plan-granularity belief trio
  ([em:1eebdf](/beliefs/spec-detail-approaches-code-length.md),
  [em:0c4913](/beliefs/dont-review-code-length-specs.md),
  [em:6c7e85](/beliefs/plan-artifacts-surface-implicit-review-decisions.md),
  [em:a96688](/beliefs/plan-artifacts-compress-decisions-not-bodies.md)),
  [Ralph](/knowledge/SWE/agentic/agentic-loop/ralph-infinite-bash-loop-coding-agent.md)
  (`em:276c61`), the
  [agent development methodology](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md)
  (`em:cab2c5`), and the doctrines and policies linked throughout.
