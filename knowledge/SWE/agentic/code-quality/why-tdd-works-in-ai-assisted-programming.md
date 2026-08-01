---
id: em:e7644d
type: reference
title: "Why TDD works so well in AI-assisted programming (Jason Gorman)"
description: Gorman's argument that TDD's small-steps discipline is precisely matched to LLM failure modes — effective context far below advertised limits, broken code polluting subsequent predictions, and examples beating descriptions as specification — so red-green-refactor becomes the control loop that keeps an agent close to working code.
resource: https://codemanship.wordpress.com/2026/01/09/why-does-test-driven-development-work-so-well-in-ai-assisted-programming/
provenance: "Distilled from Jason Gorman's (Codemanship) blog post, 2026-01-09"
tags: [tdd, testing, ai-assisted-development, agentic, feedback-loops, code-quality]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T17:56:08Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "seed source for the operator's stricter-development-methodology push — why TDD works with coding agents"
---

# Why TDD works so well in AI-assisted programming

Jason Gorman (Codemanship) argues that TDD's core disciplines — small steps,
continuous testing, continuous review, continuous refactoring, and
specification by example — map one-to-one onto the failure modes of LLM
coding assistants. The practices "elite" teams already used for reliable
delivery turn out to be the same ones that keep an AI assistant productive.

## The five reasons

1. **Context limits parallel human cognitive limits.** *"While vendors
   advertise very impressive maximum context sizes of hundreds of thousands of
   tokens, research – and experience – shows that they have effective context
   limits that are orders of magnitude smaller."* Working in small steps keeps
   each interaction inside the window where the model is actually accurate
   (the same degradation measured in
   [context rot](/knowledge/SWE/agentic/context-engineering/context-rot-chroma-research.md)).
2. **Continuous testing prevents cascading errors.** *"An LLM is more likely
   to generate breaking changes than a skilled programmer, so frequent testing
   is even more essential to keep us close to working code."* Broken code left
   in context misleads every subsequent prediction — the model *"cannot
   distinguish working from broken code"*; both are just context.
3. **Continuous code review catches degradation early.** Small, focused diffs
   let a reviewer catch duplication, complexity, and poor separation of
   concerns before they compound. Quality problems also compound token costs:
   *"If I duplicate the same logic 5x, and need to make a change to the common
   logic, that's 5x the code and 5x the tokens."*
4. **Continuous refactoring smooths the surface for the next step.**
   *"LLMs are very good at generating code they're pretty bad at modifying
   later."* Fixing smells immediately hands the next interaction cleaner
   context — the per-step antidote to the iterative quality slide measured in
   [SlopCodeBench](/knowledge/SWE/agentic/agentic-loop/slopcodebench-iterative-degradation.md).
5. **Examples clarify intent better than description.** *"TDD specifies what
   we want software to do using examples, in the form of tests."* Concrete
   input/output examples narrow the model's search space more than prose
   requirements do.

## The prescribed loop

Solve one problem at a time → test immediately after each change → review the
diff in small chunks → fix quality issues now, one smell at a time, retesting
after each → **commit on green, revert on red** (only working code ever enters
the model's context) → lean on static analysis/linting for the mechanical
layer.

## Caveats Gorman acknowledges

- TDD is a practiced discipline, not a switch — and many tutorials teach it
  badly.
- Stuffing guardrail rules into every prompt is self-defeating: context-filling
  rules exhaust the effective window and distract from the task. (His answer
  is process — the loop above — not longer instructions.)
- Separation of concerns still has to be watched by a human; model performance
  degrades sharply in poorly-modularized code.
- The closing stance: *"The key to being effective with 'AI' coding assistants
  is being effective without them."*

## Relation to filed testing knowledge

The argument is about the *loop*; it says nothing about what a good test
suite looks like. For that, matklad's
[test features, not code](/knowledge/SWE/testing/how-to-test-features-not-code.md)
and [purity and extent](/knowledge/SWE/testing/unit-vs-integration-purity-and-extent.md)
supply the test-architecture half, and
[State of AI Coding 2026](/knowledge/SWE/testing/state-of-ai-coding-2026.md)
supplies the data for why behavioral verification has to replace line-by-line
reading. [Guarding Against AI Drift](/knowledge/SWE/agentic/code-quality/guarding-against-ai-drift.md)
is the same continuous-review instinct built out as a solo-developer playbook.

# Citations

Jason Gorman (Codemanship), "Why Does Test-Driven Development Work So Well In
'AI'-assisted Programming?", 2026-01-09 —
<https://codemanship.wordpress.com/2026/01/09/why-does-test-driven-development-work-so-well-in-ai-assisted-programming/>
