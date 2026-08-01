---
id: em:e12137
type: methodology
title: "Explorable explanations"
description: "A presentation playbook for teaching an equation by handing the reader a live control over one of its variables and letting the output move continuously in response, distilled from Jack Schaedler's Circles, Sines, and Signals: state the equation once, briefly, beside the widget that makes its claim falsifiable in real time."
provenance: "Distilled by a Claude Code agent from the interactive-teaching pattern of Jack Schaedler's Circles, Sines, and Signals, at the operator's request, 2026-07-31"
tags: [technical-communication, explorable-explanations, visualization, pedagogy, interactive-media, methodology, mathematics-education]
timestamp: 2026-07-31T00:00:00Z
attribution:
  when: 2026-07-31T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked whether an equation's nature can be taught interactively the way Circles, Sines, and Signals teaches the DFT, and specifically whether that technique transfers to the evolutionary-algorithms diffusion-alignment paper"
---

# Explorable explanations

**Explorable explanation** is the established term (the genre Bret Victor
named, that Schaedler's resource explicitly situates itself within) for
documents that teach through direct manipulation of a live model rather than
through prose and static notation alone. The method below is that genre's
mechanism, distilled into repeatable steps from
[Circles, Sines, and Signals](/knowledge/knowledge-management/technical-communication/circles-sines-signals.md),
which builds toward the Discrete Fourier Transform entirely this way.

## The principles

1. **State the equation once, briefly — then hand over a control.** The
   widget carries the insight, not the prose. `dotproduct.html` states
   `Σa[n]b[n]` in one line and immediately gives the reader a draggable
   vector; the surrounding text never argues the claim the widget is about
   to demonstrate.
2. **The output must move continuously and immediately with the control.**
   A button that recomputes on click teaches "this can be computed"; a
   slider the reader drags while watching the number or curve move live
   teaches the *relationship*. Every widget fetched from the source
   (dot-product angle, phase/frequency sliders, the input-length slider)
   updates on drag, not on submit.
3. **Pick the one variable whose motion reveals the paper's actual claim,
   not an arbitrary free parameter.** `sine_wave_properties.html` doesn't
   expose every coefficient — it exposes exactly phase and frequency,
   because the claim being taught ("orthogonal regardless of phase, only
   frequency matters") lives precisely in what changes and what doesn't
   when those two move.
4. **Reuse one visual metaphor across the whole sequence.** The rotating
   arrow appears as a phasor in `euler.html`, again as a linked-phasor chain
   in `dft_frequency.html`, and again as the DFT's own frequency-domain
   representation — a reader who's internalized "a phasor is an arrow that
   spins" pays that cost once and reuses it at every later page.
5. **Order pages so each widget is the direct consequence of the one
   before it, not an independent demo.** `coordinates` (representations) →
   `dotproduct` (similarity) → `euler` (rotation) → `dft_frequency`
   (rotation applied at every harmonic) is a chain where each page's
   manipulable object is built from the previous page's, escalating
   representation the way
   [escalating-example exposition](/knowledge/knowledge-management/technical-communication/escalating-example-exposition.md)
   escalates a narrative example — the interactive-media analogue of the
   same move.
6. **Make the claim falsifiable within one manipulation, not just
   illustrated.** The orthogonality widget doesn't show a single worked
   example of a zero dot product — it lets the reader try to find a
   counterexample by dragging the sliders, and fail. A reader who forms a
   wrong prediction discovers it's wrong themselves, in real time.
7. **Keep connective prose minimal; let the widget do the "aha."** Every
   fetched page states its equation and claim in one or two sentences and
   then gets out of the way — the explanation is the manipulation, not a
   caption for it.

## When to use

Fits an equation whose real content is a **relationship, geometric
structure, or dynamic behavior between quantities** — a trade-off, an
invariance, a convergence, a similarity measure — where seeing the
relationship *move* teaches something a static derivation can't. It's a
poor fit for equations whose content is purely definitional or notational
(a naming convention, an index shorthand), where there is no relationship to
manipulate and a widget would only add motion without insight.

## Checklist for a widget

- Does moving the control change the output continuously and immediately?
- Is the control the specific variable that reveals the equation's actual
  claim, not just any parameter that happens to be free?
- Does the visual metaphor reuse one already established earlier in the
  sequence, rather than introducing a new one?
- Could a reader's wrong prediction be falsified within one manipulation?
- Is the equation itself stated once, briefly, beside the widget — never
  argued in prose before the widget exists?

## Worked sketch: does this transfer to the diffusion-alignment paper?

Applying the checklist to
[the evolutionary-algorithms diffusion-alignment paper](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md)
turns up direct, not approximate, correspondences — the paper's central
claims are geometric and dynamical in exactly the sense the method wants:

| Paper's claim | Candidate widget | Direct analog in the source |
|---|---|---|
| High-dimensional Gaussian noise concentrates on a thin shell at radius `≈√d` (the Gaussian Annulus) | A dimension slider (`d = 2, 10, 100, …`) redrawing a live histogram of `‖z‖` for freshly sampled `z ~ N(0,I)`, watching the spread collapse onto a spike as `d` grows | `dft_frequency.html`'s input-length slider, which sharpens two frequency peaks from indistinguishable to separated |
| An orthonormal rotation `Q(A)` preserves the shell regardless of angle | A rotation-angle control dragging a projected noise point around a fixed-radius circle, radius frozen no matter where the reader drags | `euler.html`'s phasor tracing the unit circle as `φ` varies |
| Uniform crossover preserves the parent Gaussian's marginal distribution | A per-coordinate "which parent" coin-flip control for a low-dimension vector pair, re-drawing the child's histogram over many trials and showing it stays bell-shaped | The resolution widget's live-recompute-and-watch-the-aggregate pattern |
| GA population diversity collapses fast under selection pressure; ES sustains it longer | A selection-pressure (tournament size) slider driving a live scatter of population reward spread over generations, for GA vs. ES side by side | `sine_wave_properties.html`'s phase/frequency sliders recomputing a dot product live |
| The reward function scores how well a candidate points toward a high-reward direction | A draggable vector whose dot product with a fixed (later revealed) target direction is read out live, re-skinning `dotproduct.html`'s exact widget as "fitness" | `dotproduct.html` itself |

Every row satisfies the checklist: each has a real relationship to
manipulate (not decoration), a control that is the paper's actual variable
of interest, a metaphor reusable across rows (the shell/circle recurs three
times, mirroring the source's phasor reuse), and a falsifiable prediction
(a reader who expects the rotated point to leave the circle, or the child's
histogram to skew, is shown wrong within one drag). This is a design sketch,
not a built demonstration — no widget above has been implemented.

## Demonstrations in this bundle

- [Evolutionary search in a diffusion model's latent space](/knowledge/machine-learning/evolutionary-computation/evolutionary-search-in-latent-space.md)
  — the sketch above, built: all five widgets as one launchable
  `type: visualization` page. Widgets 1–3 compute the paper's equations
  directly; widgets 4–5 are labeled stand-ins on the page itself.

# Citations

- [Circles, Sines, and Signals](/knowledge/knowledge-management/technical-communication/circles-sines-signals.md)
  — the exemplar this method is distilled from; original at
  <https://jackschaedler.github.io/circles-sines-signals/>.
