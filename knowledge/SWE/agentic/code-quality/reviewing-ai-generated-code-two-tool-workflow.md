---
id: em:009809
type: reference
title: "Lowering the cognitive burden of reviewing AI code (Michelle Tilley)"
description: A two-tool review workflow for AI-generated diffs — a chapter-organized overview pass (Stage) that orients the reviewer before a detail pass (Plannotator) that does traditional annotated diff review — aimed at reducing the cognitive load of reviewing code that is often correct but unfamiliar.
resource: https://michelletilley.net/notes/reviewing-ai-code/
provenance: "Michelle Tilley, michelletilley.net, fetched 2026-08-21"
tags: [code-review, agentic-coding, tooling, claude-code, cognitive-load]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Lowering the cognitive burden of reviewing AI code

Michelle Tilley's problem statement: reviewers struggle to understand
complex AI-generated code even when it is technically correct, and the
traditional back-and-forth of a human code review feels inefficient applied
to an agent that produced the whole diff at once. Her answer is a two-step
process pairing a high-level walkthrough with detailed, diff-level
annotation — not a single tool, but a sequence.

## Step 1 — overview, via Stage

[Stage (`stagereview`)](/knowledge/SWE/agentic/code-quality/stagereview-chapter-code-review.md)
has the authoring agent organize the changes into chapters before the
reviewer opens a single line: "The review itself is organized into chapters.
Each chapter corresponds to a particular logical slice of the code," each
carrying context on what changed and what deserves careful attention.
Practical notes from her workflow: ask the agent to save the chapter JSON to
a file for reliability, use a background task so the conversation can
continue while reviewing, work through chapters in order before dropping into
detail review, and track progress with checkboxes on flagged sections.

## Step 2 — detail, via Plannotator

Plannotator provides the traditional diff-based review surface — annotations
and suggested changes directly in a browser interface — once the reviewer
already has the chapter-level map from step 1 in hand. The overview pass
answers "what changed and why, at what should I look closely"; the detail
pass is where line-level correctness gets checked.

## The conclusion

"With these two tools, I find it much easier to review AI generated code,
even when it's solving complex problems." The load-bearing claim is
sequencing, not either tool alone: orientation before detail is what reduces
the cognitive burden, since a reviewer facing a flat diff has to reconstruct
the chapter structure themselves before they can evaluate anything in it.

## Reading against this bundle

This pairs directly with
[Reviewing code is a skill](/knowledge/SWE/agentic/code-quality/reviewing-code-is-a-skill.md),
which argues review competence — including the ability to orient quickly in
an unfamiliar diff — is learnable rather than innate; Tilley's workflow is a
tooling answer to exactly the orientation cost that piece treats as a skill
to build. It also sits beside
[Guarding against AI drift](/knowledge/SWE/agentic/code-quality/guarding-against-ai-drift.md)'s
layered-human-review stance: automation here does not replace the reviewer's
judgment, it removes the setup cost so the judgment pass can start sooner.

# Citations

- Michelle Tilley, "Lowering the Cognitive Burden of Reviewing AI Code",
  michelletilley.net — <https://michelletilley.net/notes/reviewing-ai-code/>
