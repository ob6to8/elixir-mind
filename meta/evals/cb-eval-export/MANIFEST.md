# eval-export — MANIFEST

A self-contained duplicate of the files belonging to **the belief-graph grounding
eval**: the conceptual prototype that surfaced the composition gap (apples /
fruit / reproduction) and the empirical run it motivated (prose context vs
assertion-DAG context).

Every file here is a **byte-identical copy** of a file under `docs/sort/`, at the
same relative path. Nothing was edited, renamed, or reorganized; this file is the
only addition. The originals remain in place — `docs/sort/` is the append-only
archive and stays the source of truth. Verified with `diff -r` / `cmp` at export
time.

## What this eval is

1. **`conceptual-prototype/`** (originally `test_1/`) — the origin. Six
   primitives about apples, fruit, colors, and seeds composed into `basic`,
   `complex`, and `recombined` claims with explicit `deps.json`. The
   "recombined" claim — *"Visible fruit contains reproductive structures"* — was
   factually true but **not logically entailed by its declared dependencies**
   (nothing connected visibility to fruit; the bridge primitive p6 "Apples are
   often red" was excluded). The DAG surfaced a deduction gap that is invisible
   in prose. See `METHODOLOGY.md` § "Origin: test_1".

2. **`purity-test/`** — the empirical eval that finding motivated: can the same
   structure *prevent* those gaps by guiding LLM output? Same knowledge
   (matklad's test purity/extent principles) as prose (`context_a/`) vs an
   assertion DAG with compounds and deps (`context_b/`), N=3 each, on a bash
   test-generation task.

   | | prose (A) | DAG (B) |
   |---|---|---|
   | primitives | 10/18 (56%) | 17/18 (94%) |
   | compounds | 2/9 (22%) | 9/9 (100%) |
   | variance | high (2,0,0) | none (3,3,3) |

   All three DAG runs independently invented a pure wrapper function to test
   parsing via stdin; none of the prose runs did. An earlier attempt using flat
   primitives *without* compounds showed no difference from prose — composition,
   not decomposition, is the active ingredient.

## Contents

### The evals (45 files)

| Path | Files | What |
|---|---|---|
| `conceptual-prototype/` | 18 | `primitives/p1..p6`, `claims/{basic,complex,recombined}` with `deps.json`, `verdict.md`, `diagram.txt` |
| `purity-test/` | 27 | `primitives/`, `compounds/` + deps, `context_a/prompt.md`, `context_b/prompt.md`, `task.md`, `run.sh`, `score.sh`, `run_tests.sh`, `tests/`, `results/{a,b}/run_{1,2,3}.txt`, `results/summary.txt` |

### Analysis and reporting (10 files)

| File | Why it's here |
|---|---|
| `METHODOLOGY.md` | The primary report: origin finding, hypothesis, materials, scores, qualitative analysis, failed approaches, threats to validity |
| `SESSION_SUMMARY.md` | Chronology from prototype review through the empirical run |
| `IMPLICATIONS.md` | What the result implies; open questions (incl. "who validates the DAG itself?") |
| `LIKELIHOOD_ANALYSIS.md` | Where the effect plausibly comes from |
| `NEXT_EXPERIMENT.md` | Proposed follow-up isolating structure from information content |
| `CONFLATION.md` | Hallucination-as-conflation reframing, drawn from failures during this eval |
| `ASSERTION_DAGS_THESIS_SECTION.md` | Thesis write-up of the result |
| `CONNECTION_TO_ITSJUSTSHELL.md` | How belief inspectability extends the action-inspectability thesis |
| `README.md` | The suite index the two evals sit in — retained verbatim, so it also lists evals **not** exported (see below) |
| `LICENSE` | License covering the copied material |

## Deliberately not included

These are separate evals or unrelated material, not part of this one:

- `docs/sort/boundary-blindness/` — a distinct eval (C0–C4 conditions, 3 models,
  N=10) with its own preregistration and report
- `docs/sort/2026-06-01-eval-design-depth-non-optional.md` — the design doc that
  drives `boundary-blindness`, not this eval
- `docs/sort/its-just-shell-reasoning-test/` — designed, never run
- `docs/sort/knowledge-domains/` — a template, no runs
- `docs/sort/blog/` — post drafts (design sketches, not results)
- `threads/`, `CLAUDE.md` — repo-level decision record for the downstream Elixir
  harness, not eval material

`README.md` in this folder is the full-suite index and therefore mentions the
excluded evals. Its links to those directories will not resolve inside
`eval-export/`; consult `docs/sort/` for them.

## Caveats carried over from the source

N=3 on a single task with a single model. Context B carries strictly more
information than context A, so "structured composition" is not cleanly separated
from "more detailed instructions." `README.md` characterizes the suite as "proof
of concept, not a validated result." Full list in `METHODOLOGY.md` § "Threats to
Validity".
