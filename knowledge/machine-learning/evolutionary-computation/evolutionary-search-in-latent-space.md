---
id: em:70f026
type: visualization
title: "Evolutionary search in a diffusion model's latent space"
description: "Five draggable widgets making the diffusion-alignment paper's equations falsifiable in real time — the Gaussian shell, why rotation is the safe transform, why crossover preserves the distribution, how selection pressure collapses a population, and reward as a dot product."
launch: evolutionary-search-in-latent-space.html
provenance: "Claude Code session, 2026-07-31 — model undisclosed (the session environment withholds the model identifier from committed artifacts)"
tags: [machine-learning, evolutionary-computation, diffusion-models, explorable-explanations, visualization, interactive-media, gaussian-annulus]
timestamp: 2026-07-31T00:00:00Z
attribution:
  when: 2026-07-31T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, explorable-explanations intake session"
  why: "the first visualization: builds the worked sketch in em:e12137 into a running artifact, so the transfer claim is demonstrated rather than asserted"
---

# Evolutionary search in a diffusion model's latent space

**[▶ Launch the visualization](./evolutionary-search-in-latent-space.html)** —
opens standalone in a browser; nothing to install, no server, no network.

Five widgets over the equations of
[Inference-Time Alignment of Diffusion Models via Evolutionary Algorithms](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md),
built by the method in
[explorable explanations](/knowledge/knowledge-management/technical-communication/explorable-explanations.md)
and modeled on
[Circles, Sines, and Signals](/knowledge/knowledge-management/technical-communication/circles-sines-signals.md).
Each states its equation in one line and then hands over a control, so the
claim is confirmed or broken by dragging rather than argued in prose.

## What each widget makes falsifiable

| # | The claim | The control | What breaks it |
|---|---|---|---|
| 1 | `‖z‖` concentrates near `√d` for `z ~ N(0,I_d)` — high-dimensional noise lives on a thin shell | dimension `d`, 2 → 200 | Nothing does. The spread-to-mean ratio only shrinks; the reader looking for a `d` where the histogram stays broad won't find one. |
| 2 | An orthonormal `Q(A)` preserves `‖z‖` at every angle | rotation angle θ, plus a rotation/arbitrary-map switch | Switching to the arbitrary linear map: the traced outline stops being a circle and the length readout moves. |
| 3 | Uniform crossover keeps the child `~ N(0,1)` for any `p` | inherit-probability `p`, 0 → 1 | Nothing does — the appendix's proof, made draggable. The bars keep hugging the fixed curve at every extreme. |
| 4 | GA diversity collapses under selection pressure; ES sustains it | GA tournament size `k`, 2 → 15 | Nothing does for ES, which is the point: the slider has no ES analog to move. |
| 5 | Scoring a candidate is a dot product with a preferred direction | drag the candidate vector | Nothing — but finding the most-negative and most-positive angles *is* the optimization problem the other four widgets serve. |

## Exact vs. illustrative

Stated on the page itself, and repeated here so a reader deciding whether to
cite it doesn't have to launch it first:

- **Widgets 1–3 compute the paper's actual equations** — fresh Gaussian
  samples, real rotations, real per-coordinate crossover. Nothing is
  pre-baked or faked.
- **Widget 4 is a toy 1-D landscape**, chosen to show the qualitative shape
  of the paper's Figure 4. It is not a reproduction of CoSyNE, PGPE, or SNES,
  and its numbers carry no quantitative claim.
- **Widget 5 substitutes a fixed linear direction** for what is really a
  learned, non-linear reward model.

## Self-containment

One file: inline CSS and JS behind a classic `<script>`, no `fetch`, no ES
modules, no external hosts (the only URLs are outbound citation links). This
is the constraint the `visualization` type requires rather than a stylistic
preference — over `file://`, module imports and `fetch` both fail CORS, so a
page that reached for either would not open from a checkout at all.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:70f026">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-31-evolutionary-search-explorable-and-visualization-type (2026-07-31)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:70f026`]**

Ratified and built. The `visualization` type exists, the gate enforces it, and the first one is filed — all on PR #211 as you asked.

---

**[`em:70f026`]**

Found a real bug before it shipped: the artifact and its own documentation page collide on the same output filename (`.md`→`.html` mapping produces the identical name as the sibling `.html`). My first pass let the raw artifact silently clobber the doc page. Fixing properly — the artifact needs a distinct on-site name, with the doc's own Launch link rewritten to match:
