---
type: plan
title: "A `visualization` type: self-contained explorables, launchable locally"
description: Add a visualization type to the controlled vocabulary for self-contained interactive pages that a reader launches from the document beside them — a bundle .md carrying an em: id and a launch field, paired with a same-slug sibling .html that opens over file:// with no build step, no server, and no network.
status: done
provenance: "Claude Code session, 2026-07-31 — model undisclosed (the session environment withholds the model identifier from committed artifacts)"
attribution:
  when: 2026-07-31T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, explorable-explanations intake session"
  why: "adding a type to the controlled vocabulary is a shape change the operator ratifies; this records the design so that decision is made against a concrete artifact rather than a chat sketch"
tags: [meta, plan, type-vocabulary, visualization, explorable-explanations, site, verifier]
timestamp: 2026-07-31
---

# A `visualization` type: self-contained explorables, launchable locally

## Status

**Done — ratified and executed 2026-07-31.** The operator ratified the plan as
drafted, including decision 1 (`launch:` over `resource:`) and decision 4
(accept the deployed-site 404 under the local-only scope), and directed the
session-built page be committed as-authored. Executed the same day per the build
order: the `visualization` entry and its filing test added to
[controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md), the
`launch` field to [frontmatter-schema](/meta/policy/frontmatter-schema.md),
contract recompiled; `:launch` added to `Registry.Entry` and `load_entry/2`;
verifier rule 9 (`launch_errors/2`) with three regression tests; and the first
visualization filed as `em:70f026`, cross-linked from `em:da2ffb` and
`em:e12137`. The gate was confirmed live against the real bundle, not only its
fixtures — removing the artifact fails `mix brain.verify` with the dangling-launch
error, restoring it passes.

One departure from the plan as written: the committed `.html` gained a
`<!doctype>`, `<html lang>`, and a `<head>` carrying `charset` and `viewport`.
The session-built page had relied on the artifact host to supply them; without
them a `file://` open renders in quirks mode with an undeclared encoding, which
would mangle the page's `‖z‖`/`√d`/`ψ` notation — so the wrapper is what makes
the local-launch property actually hold.

**The Pages passthrough (deferred below) was un-deferred and built the same
day**, and building it surfaced a defect the deferred note didn't anticipate:
a same-slug pair `foo.md` + `foo.html` both map to `foo.html` once the doc
side goes through the site's usual `.md` → `.html` rename, so a plain
`File.cp!` of the sibling — exactly what the deferred note proposed — would
silently overwrite the visualization's own rendered documentation page,
whichever write ran last. Caught by building the real site and reading the
output, not by the unit tests alone (which happened to pass without the
overwrite having a check to catch it). The fix, reflected in `Site.build/2`'s
moduledoc and this plan's shape section: the copied artifact is written under
an `.embed.html` suffix (`launch_site_name/1`), and the visualization's own
`./launch` markdown link is rewritten to that suffix **in the source text,
before rendering** — not in the rendered HTML, which would also have caught
the sidebar/breadcrumb "current page" self-link (anything else ending in the
same filename) in the same regex sweep. The source tree's sibling keeps its
plain name throughout; only the in-memory build copy of the body text and the
`_site/` output are affected. Confirmed end-to-end against a real build: the
doc page keeps its content, the Launch link resolves to the renamed copy, the
copy is byte-identical to the source sibling, and the source tree is
untouched. Original design record below, unedited except where the shape
section is updated in place to match what shipped.

**Original status: Proposed** — not ratified. Adding to the controlled `type`
vocabulary is a change to the shape of the brain
([taxonomy-evolution-protocol](/meta/policy/taxonomy-evolution-protocol.md)), so
this plan exists for the operator to ratify against something concrete.

## Problem

The brain can now *describe* an interactive explanation but cannot *hold* one.
[Explorable explanations](/knowledge/knowledge-management/technical-communication/explorable-explanations.md)
(`em:e12137`) filed the method, and its worked sketch maps five widgets onto
[the diffusion-alignment paper](/knowledge/machine-learning/evolutionary-computation/inference-time-diffusion-alignment-via-evolutionary-algorithms.md)
(`em:da2ffb`) — but the widgets themselves live outside the repo, on a hosted
artifact page. The knowledge accrues; the artifact does not.

Three things block filing one today, and the third is the one that matters:

1. **A markdown body cannot carry it.** `ElixirMind.Markdown.inline/2` escapes
   `<`, `>`, `&`, `"` unconditionally — there is no raw-HTML passthrough block in
   the hand-written parser — so a pasted `<canvas>`/`<script>` renders as inert
   text.
2. **A bare sibling `.html` is invisible to the toolchain.** Both
   `Registry.scan/1` and `Site.build/2` glob `**/*.md`. An unaccompanied `.html`
   gets no `em:` id, no index entry, no verify coverage, and no link discipline —
   it is a file in a directory, not a document in a bundle.
3. **There is no `type` for it.** `reference` captures *someone else's* material;
   `snippet` is a reusable fragment, not a standalone launchable thing;
   `methodology` is the how-to, which is exactly what `em:e12137` already is. A
   built explorable is a fourth thing, and forcing it into any of the three
   loses the distinction the taxonomy exists to keep.

## Current state

What happens to an interactive page authored today:

```
interactive page authored
└── nowhere to file it
    ├── pasted into a bundle .md   → Markdown.inline/2 escapes all markup → inert text
    ├── dropped beside it as .html → invisible to Registry.scan/1 and Site.build/2
    │                                 (both glob **/*.md) → no id, no index, no gate
    └── left as a hosted artifact  → outside the repo: unversioned, unnavigable,
                                      dies with its host
```

## Desired state

```
visualization filed as a document pair, same directory, same slug
├── <slug>.md      type: visualization, em: id, attribution, launch: <slug>.html
│   └── body: what it demonstrates · which claim each widget makes falsifiable
│             · what is exact vs. illustrative · a "Launch" link → ./<slug>.html
└── <slug>.html    self-contained: inline CSS + JS, classic <script>, no fetch,
                   no ES modules, no external hosts
                   → opens over file:// from an editor's markdown-link click

gate: ElixirMind.Verifier rule 9 — a visualization carries `launch:`; the target
      resolves on disk, sits in the same directory, and ends in .html
```

**The self-containment rule is what makes local launch work**, and it is a real
constraint, not a style note: over `file://`, ES module imports and `fetch()` both
fail CORS. A visualization is therefore one file with inlined CSS and JS behind a
classic `<script>` tag, reading nothing from the network. The five-widget page
already built in this session satisfies this as written.

## File-tree diff

As shipped (two differences from the original proposal, both because the
passthrough was un-deferred and built the same day: `site.ex` is touched, and
the verifier tests landed in the existing `registry_test.exs`, which already
holds every other `Verifier.run/2` case, rather than a new file):

```
meta/policy/controlled-type-vocabulary.md          # MODIFIED — the `visualization` entry + filing test
meta/policy/frontmatter-schema.md                  # MODIFIED — the `launch` field (visualization only)
CLAUDE.md                                          # MODIFIED — regenerated; never hand-edited
lib/elixir_mind/registry.ex                        # MODIFIED — Entry gains :launch; load_entry/2 reads fm["launch"]
lib/elixir_mind/verifier.ex                        # MODIFIED — rule 9 + launch_errors/2, mirroring sense_errors/1
lib/elixir_mind/site.ex                            # MODIFIED — copy_visualization_artifacts/3, launch_site_name/1,
                                                    #   rewrite_launch_link/2 (pre-render, in load_page/2)
test/elixir_mind/registry_test.exs                 # MODIFIED — rule-9 cases (missing / dangling / wrong-dir / wrong-ext / ok)
test/elixir_mind/site_test.exs                     # MODIFIED — artifact copy + on-site rename + source-untouched cases
knowledge/machine-learning/evolutionary-computation/
  evolutionary-search-in-latent-space.md           # NEW — the first visualization document
  evolutionary-search-in-latent-space.html         # NEW — the artifact already built this session
  index.md                                         # MODIFIED — list the pair
```

## Verifier shape

Rule 9 mirrors the existing `sense_errors/1` exactly — a path/type-keyed private
clause with a catch-all, folded into the `run/2` pipeline. It needs `root` (the
others don't) because it stats a file:

```elixir
# lib/elixir_mind/registry.ex — Entry.defstruct gains one key
defstruct [:id, :concept_id, :path, :type, :title, :verified,
           :resource, :sense, :launch, :attribution, verified_by: []]

# lib/elixir_mind/verifier.ex — folded into run/2 beside sense_errors(e)
defp launch_errors(%{type: "visualization", launch: launch, path: path}, root)
defp launch_errors(_, _), do: []
```

Four failure modes, one message each: `launch` missing; target does not exist on
disk; target is not a sibling (any `/` in the value); target does not end `.html`.

**Test topology.** The verifier's existing tests build a bundle in a `tmp_dir`
and call `Verifier.run/2` — rule 9 needs no new seam, since the sibling file is
just another file written into that fixture directory.

## Boundary decisions

- **The `.md` owns identity; the `.html` owns behavior.** The id, attribution,
  tags, index entry, and prose all live on the markdown side. The html side is a
  pure artifact — no frontmatter, never scanned, never id'd.
- **The verifier owns the pairing**, not the site generator and not the author's
  discipline. A dangling `launch` is a build failure, the same class of error as
  a dangling `verified_by`.
- **The rename is site-build-only, computed, never stored.** `launch_site_name/1`
  (`String.replace_suffix(launch, ".html", ".embed.html")`) is applied at build
  time to the copy's output path and, in the source markdown text in memory, to
  the visualization's own `./launch` link target — never written back to the
  `.md` or `.html` on disk. The pairing a reader sees in a checkout is exactly
  the plain-named pair the type promises.
- **The link swap happens in markdown source, not rendered HTML.** The first
  implementation rewrote the launch `href` in the already-rendered page instead,
  matched by trailing filename — and it also matched the sidebar's own
  "current page" self-link and the breadcrumb link to the same page, since both
  legitimately end in the same filename. Rewriting the source text in
  `load_page/2`, before the page shell (sidebar, breadcrumbs) is generated,
  makes that class of collision structurally impossible rather than something
  a narrower regex has to keep dodging.

## Consequence of the local-only scope — resolved same day

**Originally: on the deployed site, the Launch link would 404.** `Site.build/2`
copied no `.html` from the source tree, so the rendered `<slug>.html` page would
carry a relative link to a file never copied into `_site/`. Recorded here as an
accepted consequence of scoping to local launch, with the fix sized and slotted
into *Deferred* below — then un-deferred at the operator's direction the same
day. See *Status* above for what building it actually took (a same-slug
filename collision the original one-line description didn't anticipate) and
*Boundary decisions* above for the shape that resulted.

## Scope boundaries (explicitly out)

- **No raw-HTML passthrough in the markdown parser.** Wider blast radius (every
  document body becomes a script vector) for no gain the file-sibling shape
  doesn't already give.
- **No JS dependencies, bundler, or build step.** Self-containment is the type's
  defining constraint; a build step would negate the "clone and open it" property
  and break the zero-dependency toolchain stance in
  [elixir-coding-standards](/meta/policy/elixir-coding-standards.md).
- **No `/visualize` skill.** Authoring stays inline until there are enough
  visualizations to show a repeatable procedure worth capturing.

## Build order

1. Ratify this plan (operator).
2. Add the `visualization` entry and filing test to
   [controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md); add
   `launch` to [frontmatter-schema](/meta/policy/frontmatter-schema.md); run
   `mix brain.contract` (`/render-contract`).
3. Add `:launch` to `Registry.Entry` and `load_entry/2`.
4. Add verifier rule 9 (`launch_errors/2`) + moduledoc entry + tests.
5. File the first visualization: the five-widget explorable built this session,
   as `evolutionary-search-in-latent-space.{md,html}` beside `em:da2ffb`; mint
   the id, update the directory `index.md`.
6. Cross-link from `em:da2ffb` and `em:e12137` — and replace
   `em:e12137`'s "Demonstrations in this bundle: none yet" with the real one.
7. Full gate suite; commit.
8. **Un-deferred the same day:** the Pages passthrough (see *Deferred*'s first
   item, and *Status* above for what it actually took). `Site.build/2` gained
   `copy_visualization_artifacts/3`, `launch_site_name/1`, and a pre-render
   `rewrite_launch_link/2` in `load_page/2`; two tests added
   (`test/elixir_mind/site_test.exs`); confirmed against a real build (not only
   the fixtures) that the doc page, the renamed copy, and the untouched source
   tree all come out correct.

## Deferred

- **A `visualizes:` typed edge** (id-keyed, from the visualization to the
  document whose claims it demonstrates), mirroring `verified_by`. Prose
  cross-links carry it adequately at n=1; revisit if visualizations accumulate.

## Decisions and open questions

| # | Decision | Recommendation | Alternative rejected |
|---|---|---|---|
| 1 | Which frontmatter field points at the sibling? | **A new `launch:` field.** Purpose-built, unambiguous, mechanically checkable; extra keys are already sanctioned by the frontmatter schema. | **Reusing `resource:`** — floated earlier in this session. On inspection it misreads: `resource` denotes the *source asset a document captures*, and here the html is the document's own artifact, not its source. It also sits in the middle of verifier rules 4–5, where a `resource` marks a doc as a capture — semantics a visualization should not inherit. |
| 2 | Is `visualization` a bundle type (gets an `em:` id) or governance? | **Bundle type.** It is knowledge content sitting beside the reference it illustrates, and the id is what survives a later move — the same argument the project-namespace policy makes for its hubs. | Filing under `meta/` — it is not governance of the brain. |
| 3 | Does the type name follow the established-terminology rule? | **`visualization` is the established term** and reads correctly cold. | `explorable` — accurate to the genre, but bespoke enough to need glossing at every use; `demo` — too loose (implies a product walkthrough). |
| 4 | Accept the dead Launch link on the deployed site? | **Superseded** — the operator un-deferred the passthrough same-day; the link resolves on Pages too now (see *Status*). | — |
| 5 | Same-slug output collision (surfaced building decision 4's fix, not anticipated at ratification) | **`.embed.html` on-site rename, rewritten pre-render in the markdown source.** Keeps the source-tree pair plain-named (local launch untouched) and makes the sidebar/breadcrumb self-link collision structurally impossible rather than regex-avoided. | Rewriting the rendered HTML's `href` by trailing-filename match — caught the doc's own nav self-link and breadcrumb link in the same sweep, since both legitimately end in the same filename; discarded once the real build surfaced it. |

**Resolved:** the first visualization's `.html` was committed as-authored, per
the operator's direction — it satisfied every self-containment constraint as
written, and review (the real end-to-end build, not just fixtures) caught the
one thing that needed fixing, which was the passthrough's collision, not the
artifact itself.
