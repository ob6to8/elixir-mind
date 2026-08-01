---
type: reference
title: 2026-07-31-evolutionary-search-explorable-and-visualization-type
description: Intake of a diffusion-alignment evolutionary-algorithms paper and Circles, Sines, and Signals, distilled into a reusable explorable-explanations method and tested against the paper's own equations; the operator's follow-up question about embedding interactive widgets in the Pages deploy led to a new visualization controlled type (a locally-launchable document pair), its verifier gate, and a Pages passthrough — all ratified, built, and merged in PR #211.
provenance: "Claude Code session (Claude Sonnet 5, Claude Opus 5), 2026-07-31; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, explorable-explanations, visualization, evolutionary-computation, diffusion-models, site-generator, type-vocabulary]
timestamp: 2026-07-31
session: https://claude.ai/code/session_0195tV13La6ZUshqSrULAQYG
---

# 2026-07-31-evolutionary-search-explorable-and-visualization-type

## Where this landed

The operator invoked `/intake` on an arXiv paper (evolutionary algorithms for
inference-time diffusion-model alignment) and Jack Schaedler's *Circles,
Sines, and Signals*, asking whether the paper's equations could be taught the
way that resource teaches the Fourier transform. Both were filed as
references, the teaching mechanism was distilled into a reusable
`explorable-explanations` methodology, and its worked sketch was tested
directly against the paper's own equations — five direct correspondences, not
approximate ones. At the operator's direction all five became one built,
launchable interactive page. A follow-up question about embedding such
widgets in the site's Pages deploy turned into a proposal for a new
`visualization` controlled type — a document pair (`.md` + a same-slug
sibling `.html`) launchable locally over `file://` with no build step. The
operator scoped it to local launch first, ratified the plan, and the session
built the type, its verifier gate, and the first visualization; building the
deferred Pages passthrough the same day surfaced and fixed a real same-slug
filename collision before it could ship silently. Everything landed in PR
#211, merged with a true merge commit. The operator switched models mid-session
(Sonnet 5 → Opus 5) partway through drafting the plan.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Inference-time diffusion-alignment paper — equations distilled in full | closed | [inference-time-diffusion-alignment-via-evolutionary-algorithms.md](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md) | - |
| Circles, Sines, and Signals — captured, its widgets cataloged | closed | [circles-sines-signals.md](/knowledge/knowledge-management/technical-communication/circles-sines-signals.md) | - |
| The teaching mechanism generalized into a method, tested against the paper's equations | closed | [explorable-explanations.md](/knowledge/knowledge-management/technical-communication/explorable-explanations.md) | - |
| Embedding interactive widgets in the Pages deploy — site-generator research | closed | [visualization-type-and-local-launch.md](/meta/plans/visualization-type-and-local-launch.md) | - |
| A `visualization` type: proposal, plan, ratification, and execution (type, verifier gate, Pages passthrough) | closed | [visualization-type-and-local-launch.md](/meta/plans/visualization-type-and-local-launch.md) | - |
| First visualization built and filed | closed | [evolutionary-search-in-latent-space.md](/knowledge/machine-learning/evolutionary-computation/evolutionary-search-in-latent-space.md) | - |
| PR #211 — intake, plan, and implementation, merged | closed | unrouted | - |
| Thread doc name for this session | closed | unrouted | - |

## User

/intake https://arxiv.org/pdf/2506.00299

then /intake
https://jackschaedler.github.io/circles-sines-signals/

the idea i have is this - can we use the circles-sines-signals interactive educational displays as a model to express the equations in the evolutionary algorithms paper? is it possible to express the nature of an equation in an interactive manner that develops an intuition, similar to how the cirlces-sines-signal resources has done?

## Assistant

<routes ref="em:da2ffb em:4956f3 em:e12137">
Filed and pushed. Here's the rundown.

Both sources are in the brain now, and I used them together to actually test the idea instead of just speculating about it: I distilled the teaching *mechanism* Circles, Sines, and Signals uses into a reusable method, then ran the evolutionary-algorithms paper's own equations through it. They map directly — not approximately. The paper's real content (a rotation that keeps noise on a probability "shell," a population's diversity collapsing over generations, a reward function that's really a similarity measure) is exactly the kind of *relationship-in-motion* that resource's drag-a-slider approach is built for, not decoration bolted onto static notation.
</routes>

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `reference` | [Inference-time alignment of diffusion models via evolutionary algorithms](https://github.com/ob6to8/elixir-mind/blob/claude/interactive-evo-algo-viz-5mpijb/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md) | external paper, captured and summarized with full equation extraction |
| `reference` | [Circles, Sines, and Signals](https://github.com/ob6to8/elixir-mind/blob/claude/interactive-evo-algo-viz-5mpijb/knowledge/knowledge-management/technical-communication/circles-sines-signals.md) | external interactive resource, captured with a page-by-page account of its widgets |
| `methodology` | [Explorable explanations](https://github.com/ob6to8/elixir-mind/blob/claude/interactive-evo-algo-viz-5mpijb/knowledge/knowledge-management/technical-communication/explorable-explanations.md) | the reusable teaching technique distilled from the resource above, sitting beside the two existing exposition/elicitation playbooks |

**What I modified**

| File | Change |
|---|---|
| `knowledge/machine-learning/index.md` | listed the new `evolutionary-computation/` subdirectory |
| `knowledge/knowledge-management/technical-communication/index.md` | listed the two new docs |
| `meta/evals/dedup-probe.md` | harvested two gold rows from your own phrasing for each source |
| `meta/registry.md` | regenerated after minting the three new ids |

**Actions I have taken**

| Action | Result |
|---|---|
| Created `machine-learning/evolutionary-computation/` (new subdirectory under the established `machine-learning` domain) | Autonomous per the taxonomy protocol — no new top-level directory involved |
| Dedup pass (expanded phrasings: genetic algorithm, evolution strategy, diffusion model, explorable explanation, Bret Victor, latent space search, CMA-ES) | No existing coverage found |
| Minted ids, verified, committed, pushed | `4d13b62` on `claude/interactive-evo-algo-viz-5mpijb`; full gate suite green (188 tests, verify, route tags, glossary, contract, codemap) |
| Dedup baseline refresh | plain 8/28, unchanged — no regression |

<routes ref="em:e12137">
**On the actual idea** — the methodology doc's "Worked sketch" section has the detail, but the shape of the answer is: the source resource's trick is never "explain the equation," it's "state it in one line, then let the reader move one variable and watch a claim get confirmed or falsified live." That only works when an equation's content *is* a relationship, not a definition. This paper is unusually rich in exactly that kind of content — five direct correspondences turned up:

- The **Gaussian Annulus fact** (high-dimensional noise lives on a thin shell, not spread everywhere) → a dimension slider redrawing a live histogram of noise-vector lengths collapsing onto a spike, same shape as the source's sample-count slider sharpening frequency peaks.
- **Rotation preserves the shell** (why the paper searches orthonormal transforms) → a rotation-angle drag on a projected noise point, tracing a fixed-radius circle no matter the angle — a direct reskin of the source's Euler's-formula phasor widget.
- **GA population diversity collapsing under selection pressure** vs. **ES sustaining it** → a selection-pressure slider driving two live scatterplots side by side.
- **Uniform crossover provably preserving the Gaussian** → a per-coordinate coin-flip control redrawing a child-population histogram over many trials.
- **The reward function as a similarity measure** → literally the source's own drag-a-vector dot-product widget, reskinned as "fitness."

None of these are built — it's a design sketch, honestly labeled as such in the filed doc. If you want, I'd build one as a live interactive artifact (the Gaussian-shell one is the cleanest single demonstration and needs no ML dependencies, just noise sampling and a canvas) so you can judge the transfer on something real rather than a table.
</routes>

**Your options from here**

1. I build the Gaussian-shell widget as a working artifact — smallest, most self-contained proof of the transfer.
2. I build all five as one page, mirroring the source's page-by-page structure.
3. Leave it as the filed design sketch for now — nothing further needed.
4. Open a PR for the intake now that it's pushed (not done yet — `/intake` files, `/create-pull-request` is the separate step that opens one).

## User

2, then 4

## Assistant

PR opened: **[#211](https://github.com/ob6to8/elixir-mind/pull/211)**.

Both pieces of your ask are done — the artifact is built, and the intake is now a pull request:

| Item | Where |
|---|---|
| Interactive artifact (all 5 widgets, one page) | Published above — five draggable widgets, ordered like the source's page-by-page structure |
| Pull request | [#211](https://github.com/ob6to8/elixir-mind/pull/211): `claude/interactive-evo-algo-viz-5mpijb` → `main` |

A few notes on the artifact, so you know what you're looking at:

- **Widgets 1–3** (Gaussian shell, rotation-vs-shear, crossover-preserves-Gaussian) compute the paper's actual equations live — nothing faked.
- **Widget 4** (GA vs. ES diversity collapse) is an honestly-labeled toy 1-D landscape, not a reproduction of CoSyNE/PGPE/SNES — it's built to show the *qualitative* shape of the paper's Fig. 4 (GA collapses fast under selection pressure, ES doesn't, because ES has no tournament step to crank), and the caption says so.
- **Widget 5** (reward-as-dot-product) stands in a fixed linear direction for what's really a learned, nonlinear reward model — again labeled as a stand-in, not a reproduction.

I didn't add the artifact itself into the PR — it's a Claude-hosted page, not repo content, and the filed methodology doc's "Demonstrations in this bundle" section still accurately reads "none yet" (that line is scoped to demonstrations *in the bundle*, which this isn't). If you'd rather have the widget code committed to the repo too — e.g. as a static page under a `projects/` incubation, since it's a system that could eventually stand on its own — say so and I'll fold it in as a follow-up.

The PR is up and not merged — want me to watch it for CI/review activity, or is this good to leave with you?

## User

what would it look like to make the interactive widgets part of the pages deploy of the site?

## Assistant

Waiting on the research agent's findings before giving you a real answer — will follow up shortly.

Turns out this isn't a "just file the doc" situation — the site generator has two properties that get in the way.

**How the site actually works today:** `mix brain.site` is a hand-written, dependency-free generator. It walks every `.md` file, force-wraps each one in the same fixed page shell (topbar/sidebar/metadata panel), and its markdown renderer **escapes all raw HTML** in a doc body — there's no raw-HTML-passthrough block, so a pasted `<canvas><script>` would render as inert text, not a working widget. There's also no static-asset mechanism at all: the only JS/CSS on the live site are two strings hardcoded into the generator's own source (`ElixirMind.Site.Assets`), copied nowhere from disk. So an interactive page can't be filed as a document under the existing taxonomy — it needs the generator itself to change.

**Two ways to make that change:**
1. **Add a static-passthrough step.** Introduce a source directory (e.g. `static/` or `demos/`) that `mix brain.site` copies verbatim into `_site/`, unwrapped and unescaped, alongside the generated docs.
2. **Bake it in as another hardcoded asset**, the same way `style.css`/`app.js` exist today — a new string constant written unwrapped.

I'd recommend (1): it turns "publish an explorable" into "drop a file in a directory" instead of "hand-edit the site generator's source" every time, which matters if this becomes a recurring thing rather than a one-off for this paper. The tradeoff is it's a real change to the generator's contract — a new directory that's neither a knowledge document nor `meta/` governance, which under this repo's own rules means proposing a new top-level directory and getting it ratified before I build it, not something I'd just do autonomously.

Want me to draft that as a proper plan (the new directory, the generator change, where the widget page's source lives) for you to ratify, or is this more of a "good to know, not doing it now" answer?

Already answered — the research agent's findings came back and I gave you the full rundown (the generator escapes raw HTML and has no static-asset passthrough, so it'd need a small generator change plus a ratified new directory). Nothing new to add since then.

## User

I am leaning towards a new type of document in the knowledge base, "visualization", which would be a self contained locally launchable "anthropic artifact" style  visualization. So, someone navigatiing the knowledge base on github or locally in an editor could click a "launch visualization" link from a resource and the visualization would be loaded standalone into the browser. thoughts?

## Assistant

Sound instinct — it slots cleanly as its own type rather than overloading `reference` or `snippet` (neither fits: a reference *captures* someone else's material, a snippet is a reusable fragment, not a standalone launchable thing). A few things worth deciding before it's real:

- **GitHub itself won't execute it.** Clicking a `.html` file in GitHub's own repo browser shows source, not a running page — GitHub doesn't render arbitrary scripts for security reasons. "Launch from a resource on GitHub" in practice means launch via the **deployed Pages site**, which does serve real HTML/JS. That's the same generator gap I flagged earlier — it needs a passthrough step that copies a visualization's sibling `.html` file into `_site/` unwrapped, next to its markdown doc.
- **Local launching is free**, no new plumbing needed — a self-contained single-file HTML (inline CSS/JS, no ES modules, no external fetches — the widget I already built already qualifies) opens fine over `file://` from any editor's markdown-link click. So the local half of your ask is really just an authoring constraint on the visualization files themselves, not infrastructure.
- **Filing shape** I'd propose: the `.md` (frontmatter + a description of what it demonstrates + a "Launch" link) sits beside a same-slug sibling `.html`, mirroring the existing `projects/<slug>.md` + `projects/<slug>/` pattern but file-sibling instead of directory-sibling. `resource:` on the doc would then point at that local sibling file instead of an external URL — a deliberate stretch of what that field normally means, worth calling out rather than doing quietly.
- `mix brain.verify` would want a small new check (the sibling file exists) the same way it checks `verified_by` targets exist.

This is a new controlled type plus a real site-generator capability plus a verify rule — a genuine "genre change," not a one-file edit — so per this repo's own rules it's exactly the kind of thing that gets a `meta/plans/` document (frontmatter shape, the generator diff, the verify addition) before I touch any code, rather than built ad hoc in chat.

Want me to draft that plan?

## User

<command-name>/model</command-name>
            <command-message>model</command-message>
            <command-args>claude-opus-5</command-args>

ok lets just do local launch. agree filing shape
draft plan

## Assistant

Plan drafted, committed, and pushed: **[visualization-type-and-local-launch.md](https://github.com/ob6to8/elixir-mind/blob/claude/interactive-evo-algo-viz-5mpijb/meta/plans/visualization-type-and-local-launch.md)** — `status: proposed`, awaiting your ratification.

Scoping to local launch made this much smaller than I expected. I'd assumed the site generator would need teaching to leave a `.html` alone; it turns out both the document scanner and the site builder only ever look at `**/*.md`, so a sibling `.html` is already invisible to them. The generator goes untouched. The entire cost is one key on a struct, one verifier rule copied from the shape of an existing one, and a vocabulary entry.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `plan` | [visualization-type-and-local-launch.md](https://github.com/ob6to8/elixir-mind/blob/claude/interactive-evo-algo-viz-5mpijb/meta/plans/visualization-type-and-local-launch.md) | a proposed change whose design must be recorded before executing, per persist-plans |

**What I modified**

| File | Change |
|---|---|
| `meta/plans/index.md` | listed the new plan at the top of Proposed |

**Actions I have taken**

| Action | Result |
|---|---|
| Anchored the plan against `HEAD` rather than description | Confirmed `Registry.scan/1` + `Site.build/2` both glob `**/*.md`; confirmed `Markdown.inline/2` escapes markup unconditionally; read `Verifier` rule shape and `Registry.Entry` |
| Committed and pushed | `6230810`; full gate suite green (188 tests) |

**Two things you should weigh before ratifying**

1. **I revised the field name from what you agreed to.** You okayed the filing shape when I described `resource:` pointing at the sibling. Building it out, that misreads: `resource` denotes *the source asset a document captures*, but here the html is the document's own artifact, not its source — and `resource` sits in the middle of verifier rules 4–5, where its presence marks a doc as a capture. So the plan proposes a purpose-built `launch:` field instead, with `resource:` recorded as the rejected alternative. The file-sibling layout you agreed to is unchanged; only the field name moved. Decision #1 in the plan.

2. **The Launch link will 404 on the deployed site.** Local-only means the generator copies no `.html`, so the rendered page links to a file that was never built into `_site/`. Works in a checkout and an editor; dead on Pages. That's the direct cost of the scoping call, recorded in the plan as a decision rather than a surprise. The fix is genuinely small — the generator already writes unwrapped files, so it's a `File.cp!` in the walk it already does — and it's sitting in Deferred, ready whenever you want the explorables readable from the published site.

**Questions you need to answer**

| # | Question | My recommendation |
|---|---|---|
| 1 | Ratify the plan as drafted? | Yes — the type is well-motivated and the implementation cost is genuinely small |
| 2 | Commit the session-built five-widget page as-is, or re-derive it in-repo during execution? | Commit as-is; it already satisfies every self-containment constraint (inline CSS/JS, classic `<script>`, no fetch, no modules) |

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | Ratify and I execute now | ~7 steps in the build order; lands the type, the gate, and the first visualization |
| 2 | Split the plan onto its own branch/PR | PR #211 currently carries both the intake and this plan — I widened it. Say the word and I'll pull the plan commit onto a fresh branch so the intake merges clean |
| 3 | Un-defer the Pages passthrough into this plan | Adds one `File.cp!` step; kills the 404 and gets the explorables on the live site |
| 4 | Leave it proposed | The design record persists either way; nothing further happens until you ratify |

## User

ratify plan
commit as is
2 - fine to commit here same pr
3 - expand, what is this?

## Assistant

<routes ref="em:70f026">
Ratified and built. The `visualization` type exists, the gate enforces it, and the first one is filed — all on PR #211 as you asked.
</routes>

**Answering your question about option 3 — the Pages passthrough.** It's one addition to the site generator, and here's the concrete problem it solves. `mix brain.site` walks `**/*.md` and writes a `.html` for each into `_site/`, which is exactly the directory GitHub Pages publishes. Because it only ever looks at markdown, it copies nothing else — so the visualization's `evolutionary-search-in-latent-space.html` never lands in `_site/`, and the rendered page's Launch link points at a file that isn't there. Locally it works (both files sit side by side in the checkout); on the published site it's a 404.

The fix is to have that same walk also copy each visualization's sibling `.html` verbatim. The generator already writes unwrapped files this way — `assets/style.css`, `assets/app.js`, and `search-index.json` all go out untouched by the page-shell wrapper — so it's reusing an existing capability, not adding one. Roughly: find documents with a `launch` field, `File.cp!` the named sibling into the matching `_site/` path. Maybe fifteen lines and a test. It's deferred rather than blocked purely because you scoped this round to local launch.

Worth knowing what it buys beyond un-404ing a link: it's the difference between "clone the repo to use this" and "send someone a URL." Widget 1's histogram is a thing you'd want to link into a conversation.

**Actions I have taken**

| Action | Result |
|---|---|
| Added `visualization` + filing test to the type vocabulary, `launch` to the frontmatter schema, recompiled the contract | `CLAUDE.md` regenerated; the type binds every future session |
| Added `:launch` to `Registry.Entry`; verifier rule 9 (`launch_errors/2`) | Four failure modes covered: missing, dangling, non-sibling, wrong extension — plus `launch` on a type that has no artifact |
| Wrote three regression tests | 191 tests, 0 failures |
| **Confirmed the gate fires on the real bundle** | Removed the artifact → `mix brain.verify` failed with the dangling-launch error; restored → passed. Not just green in fixtures |
| Filed the first visualization (`em:70f026`) + cross-links | `em:e12137`'s "demonstrations" section now names a real one instead of "none yet" |
| Marked the plan `done`, moved it to the index's Done section | Committed `a15dbf3`, `c93f7a9`; pushed |

**One departure from the plan, and one process slip**

The committed `.html` gained a `<!doctype>`, `<html lang>`, and a `<head>` with `charset` and `viewport`. You said commit as-is, and the *content* is unchanged — but the artifact host had been supplying those tags, and without them a `file://` open runs in quirks mode with no declared encoding, which mangles the page's `‖z‖` / `√d` / `ψ` notation. Since local launch is the entire point of the type, I treated the wrapper as required for the property to hold rather than as a redesign. It's recorded in the plan's status note.

Separately: mid-commit I reused `ORIG_HEAD`'s message as a shortcut and it picked up an unrelated old merge commit's text and author. I caught it and amended — `HEAD` now carries the intended message, authored correctly — but the shortcut was careless and worth telling you rather than leaving in the reflog.

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | Add the Pages passthrough now | ~15 lines in `Site.build/2` + a test; kills the 404 and makes visualizations linkable |
| 2 | Merge PR #211 as-is | Three commits: the intake, the plan, the implementation |
| 3 | Build more visualizations | The type and gate are live; each is now just a `.md` + `.html` pair |
| 4 | Leave it here | Everything is committed and pushed; PR #211 is open and not merged |

## User

1 then 2

## Assistant

<routes ref="em:70f026">
Found a real bug before it shipped: the artifact and its own documentation page collide on the same output filename (`.md`→`.html` mapping produces the identical name as the sibling `.html`). My first pass let the raw artifact silently clobber the doc page. Fixing properly — the artifact needs a distinct on-site name, with the doc's own Launch link rewritten to match:
</routes>

CI's running on PR #211 (two `verify` checks, both `in_progress` as of this check) — I subscribed to the PR so I'll get notified the moment they resolve, rather than polling. I'll merge with the `merge` method (never squash/rebase, per this repo's own policy) as soon as they're green.

**Summary of where things stand:**

| Item | Status |
|---|---|
| `visualization` type + verifier gate | Built, tested, pushed |
| First visualization (`em:70f026`) | Filed, cross-linked |
| Pages passthrough | Built, fixed a same-slug collision bug in the process, confirmed end-to-end |
| Plan doc | Updated in place to record what actually shipped, including the collision and its fix |
| PR #211 | Open, CI running, watching for completion |

I'll report back once CI resolves and merge if it's green.

Confirmed — PR #211 is merged (`d8cb551`), and the head branch is already gone (GitHub's auto-delete-branches setting cleaned it up; not something I needed to do manually). The subscription is closed automatically now that it's merged.

**Final state:**

| Item | Status |
|---|---|
| Intake: EA/diffusion paper + explorable-explanations method | Merged to `main` |
| `visualization` type + verifier gate | Merged to `main` |
| First visualization (`em:70f026`) | Merged to `main`, live on Pages via the passthrough |
| Pages passthrough | Merged to `main`; Launch link resolves on the deployed site, not just locally |
| Branch cleanup | Automatic, confirmed |

Everything from this thread — the intake, the plan, and its execution including the mid-build fix — is on `main`. Nothing pending.

## User

what is thread doc name

## Assistant

There isn't one — none of those are this session. This session hasn't been captured yet: `/capture` (or `/create-pull-request`, which runs it) hasn't been invoked here, and I merged the PR directly through git/GitHub calls rather than that skill. No thread doc exists for this conversation.

If you want one, say the word and I'll run `/capture` — it'd land at something like `meta/threads/2026-07-31-evolutionary-search-explorable-and-visualization-type.md`, and since the work already merged, it'd need a follow-up commit/PR just to add that record (the `pr:` stamp would point at whatever new PR carries it, since #211 is already closed).

## User

/create-pull-request merge
