---
type: analysis
title: "Content quality, sampled: strong individual documents, three corpus-level erosions"
description: A 30-document graded sample across every knowledge domain plus index, duplication, and projects-split checks — individual distillation quality is high (18 A / 5 A- / 7 B+), while excerpt logs now make up a fifth of knowledge-corpus text, verbatim external captures have three inconsistent filings, and corrections do not propagate between sibling documents.
provenance: "Claude Fable 5, Claude Code session — delegated 30-doc reading pass; the sharpest claims (retracted-figure non-propagation, excerpt-log share, type misfits) re-verified directly; excerpt share re-measured independently"
tags: [meta, analysis, content, quality, distillation, review]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T10:35:00Z
  channel: agent-authored
  agent: "Claude Code agent, comprehensive-review session"
  why: "the content third of the operator-commissioned comprehensive repo review — sampled this session, full sweep scoped in the review-program plan"
---

# Content quality, sampled

**Method and scope.** A delegated pass read ~30 documents in full across all
seven knowledge domains plus `projects/` and `beliefs/` (excluding the
569-file glossary), graded each on distillation, type fit, description
accuracy, and self-containedness, then ran duplication, index-integrity
(5 directories), and projects-split checks. The three sharpest claims were
re-verified directly against the files; the excerpt-log share was
re-measured independently. **Not covered**: the glossary corpus, ~20 of the
knowledge indexes, and 131 of the 161 knowledge docs — the full sweep is
scoped in the
[review-program plan](/meta/plans/comprehensive-repo-review-program.md).

## Inventory

161 documents under `knowledge/` (reference 106, source 22, concept 15,
methodology 8, note 4, snippet 3, claim 3, visualization 1). SWE/agentic
alone holds 83 — **51% of the knowledge corpus** — with `agentic-loop` (25
docs) outweighing every non-SWE domain; `human-computer-interaction` and
`startups` hold one document each. The corpus's subject is, to first
order, the field its own construction lives in.

## Grades

Of 30 graded documents: **18 A, 5 A-, 7 B+, no grade below B+.** The A
documents are genuinely good — layered summaries with marked quotes, honest
`verified: false` basis-marking on training-recalled content
([ffmpeg-frame-accurate-assembly](/knowledge/media-production/video-editing/ffmpeg-frame-accurate-assembly.md)
is exemplary), scoped negatives, and capture/statement layering used as
designed. The B+ defects cluster in three families below rather than in
bad individual writing. Five sampled bodies carry provenance prose or a
banned-pattern phrase ("Section ordering follows the operator's ask",
"Intake'd at the operator's prompt…") that
[provenance-lives-in-metadata](/meta/policy/provenance-lives-in-metadata.md)
and the banned-phrases register already prohibit.

## The three corpus-level erosions

**1 — Excerpt logs are eroding "distill hard" at corpus scale.** 110 of 161
knowledge docs carry a `## Thread excerpts — route-tagged log` section;
measured across `knowledge/`, those sections are **3,865 of 19,271 lines —
20.1% of the corpus's text** (measured 2026-08-01, this session). In
sampled docs the log exceeds the authored body
([first-order-logic-and-owl](/knowledge/knowledge-management/knowledge-representation/first-order-logic-and-owl.md):
157 lines of log under 136 of body). Because a multi-ref region is lifted
whole into *every* sink it names, identical ~60-line blocks recur verbatim
across documents; one tagged operator paste re-embedded an entire raw
Reddit thread inside a distilled reference
([isnad-rijal-claim-level-provenance](/knowledge/SWE/agentic/provenance/isnad-rijal-claim-level-provenance.md));
and process noise ("No PDF matching this is present…") is welded into
[founders-playbook](/knowledge/startups/founders-playbook-ai-native-startup.md).
The machinery is contract-sanctioned and its freshness is gated — the weak
joint is *selection*: what gets tagged, and that whole-region lifting has
no size discipline. (The
[fence-dropping defect](/meta/issues/route-tag-regions-lose-fenced-code.md)
compounds this: the lifted fifth of the corpus is also silently missing
its code blocks.)

**2 — The same artifact class files three ways.** A verbatim external
thread/post appears as a sibling `type: source` doc (ISNAD,
agent-says-done), as a `type: reference` capture
([rag-evaluation-is-harder…](/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md)),
and as a verbatim block inside the distilled reference itself
(steps-of-ai-adoption, markdown-folder). An external playbook is typed
`methodology`
([founders-playbook](/knowledge/startups/founders-playbook-ai-native-startup.md))
where the vocabulary's authored-here/captured-elsewhere distinction reads
`reference`. Type-scoped queries over the corpus are accordingly less
trustworthy than the controlled vocabulary implies.

**3 — Corrections do not propagate between siblings.** The concrete case,
re-verified this session:
[open-weights-stopped-being-a-price-weapon](/knowledge/ai-industry/open-weights-stopped-being-a-price-weapon.md)'s
recorded grounding pass retracted two figures ("~2.5× Fable 5's
wall-clock", the 83-vs-67-turn comparison) as unsupported — "neither
survived re-reading the article for verbatim text … Both are now gone" —
while [kimi-k3](/knowledge/machine-learning/kimi-k3.md) still asserts both,
unqualified, in its authored body. Same family: the
[open-knowledge-format](/knowledge/knowledge-management/open-knowledge-format.md)
capture still lists "`log.md` for history" among what this brain uses,
surviving the retire-hand-kept-logs migration.
[update-in-place](/meta/policy/update-in-place.md) works within a document;
nothing sweeps a corrected fact's other homes.

## Indexes, duplication, projects

Five sampled indexes (agentic-loop, ai-industry, argumentation,
audio-synthesis, llm-engineering): complete in both directions, glosses
accurate, two cosmetic defects (one gloss missing its `em:` id; annotation
format drifts across index generations). No hard duplicates found in the
ten most-likely pairs; the bundle's capture+distillation layering explains
most apparent duplication. One growth pattern to watch: the BEAM/Jido
analysis cluster (six documents) grows by satellite — a new analysis to
expand "two caveats the earlier analyses name in passing" — rather than by
update-in-place. The projects split rule is followed with unusual
discipline (attributions record the split reasoning); two borderline
cases: a generally-true SuperCollider how-to typed `tutorial` living in
`projects/code-driven-av-production/`, and the repo-specific
[elixir-mind-testing-methodology](/knowledge/SWE/testing/elixir-mind-testing-methodology.md)
sitting in the general taxonomy.

## Judgment and recommendations

Individual documents are the best part of this corpus — the distillation
policy is being followed, and followed well. The erosions are all
*between* documents: a record-layer mechanism outgrowing the knowledge
layer it feeds (20% and rising with every capture), a filing convention
that never got ratified into one shape, and a missing propagation step for
corrections. Recommended:

1. **Give excerpt-lifting a discipline**: either a selection rule (tag the
   paragraph that *feeds the sink's matter*, not the surrounding run), a
   per-sink size cap with link-instead-of-lift overflow, or a
   render-collapsed convention on the site. Decide once, as policy — the
   ratio only grows.
2. **Ratify one filing pattern for verbatim external captures** (the
   sibling-`source` pattern is the strongest of the three in use) and
   retype the strays.
3. **Add a propagation step to grounding passes**: when a figure is
   retracted, grep the corpus for its other homes before closing — the
   kimi-k3 case shows the cost of skipping it, and the fix is one search.
4. **Fix the two live content defects** (kimi-k3's retracted figures; the
   OKF capture's `log.md` line) in the next editing session.
