---
type: plan
title: "Neovim as the operator's direct editing surface: navigation config, link-scheme rationale, and the code-anchor churn probe"
description: "File the operator-tested includeexpr config that makes bundle-absolute links gf-navigable in Neovim, record the GitHub root-relative-links fact as the link-scheme's load-bearing rationale in policy, and run the churn probe over lib/'s history that the strand sweep named as the gate on the Model C (code-anchor) plan — with that plan held as the deferred phase."
status: proposed
provenance: "Claude Fable 5 — distilled from an operator-supplied handoff out of an uncaptured session; every carried claim re-verified against main, primary sources, or marked operator-tested"
tags: [meta, plan, neovim, navigation, links, route-tagging, anchoring, comprehension, mouseless]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T20:34:50Z
  channel: agent-authored
  agent: "Claude Code agent, handoff-evaluation session"
  why: "persists the surviving work from a prior session's handoff — nvim link navigation, the link-scheme rationale, and the churn probe gating the Model C plan — after cross-referencing it against the agent-pairing project and the strand-sweep dispositions"
  from: [/meta/analysis/localized-code-conversation-vs-linear-thread.md]
---

# Neovim as the operator's direct editing surface

## Problem

The operator works this repo almost entirely by instructing an agent through a
chat window, and is moving toward editing it directly in Neovim — mouseless,
deterministic, alongside the agent rather than only through it. The direction
is already fixed by
[comprehension-of-generated-code](/meta/doctrine/comprehension-of-generated-code.md)
and served from two other angles by the
[dvorak-vim](/projects/dvorak-vim.md) project (keybinding fluency) and the
[agent-pairing](/projects/agent-pairing.md) project (supervising the agent from
the editor). What this plan covers is the remaining, brain-side slice: making
the bundle *navigable* from Neovim, recording *why* its link scheme is shaped
the way it is, and unblocking the one empirical question that gates localized,
in-editor conversation over the bundle
([Model C](/meta/analysis/localized-code-conversation-vs-linear-thread.md)).

Three gaps, concretely:

1. Stock `gf` cannot follow this bundle's links: cross-links are
   bundle-absolute (`/knowledge/…`), which Neovim treats as
   filesystem-absolute. A nine-line `includeexpr` solves it — tested, working
   in the operator's live Neovim — but is recorded nowhere.
2. The load-bearing external justification for bundle-absolute links — GitHub
   resolves them against the repository root, so the scheme works in blob view
   at any merge state — appears nowhere in the corpus, including in the policy
   that mandates the scheme.
3. The code-anchor identity mechanism for Model C was dispositioned in the
   [strand sweep](/meta/plans/reconcile-dangling-ledger-strands.md) as
   "deferred to ratification after a churn probe" — and the probe has not run.

## Verified ground

Basis for every step below. Items marked *operator-tested* were verified
directly in the operator's live environment and need no re-test; everything
else was re-checked 2026-08-01 against `main` or the primary source.

- **`gf` + `includeexpr` resolves bundle-absolute links** in Neovim ≥ 0.10
  (`vim.fs.root` dependency). *Operator-tested.* Config in § Step 1.
- **mkdnflow.nvim fails structurally and is not to be retried**: its
  `path_resolution.primary = 'root'` governs only *relative* links; a leading
  `/` is treated as filesystem-absolute, and following a link crashed with
  `E739: Cannot create directory /knowledge: read-only file system` (it tried
  to create the parent of a would-be new note at the filesystem root).
  *Operator-tested.*
- **GitHub renders the scheme natively**: "Links starting with `/` will be
  relative to the repository root."
  ([GitHub docs, basic writing and formatting syntax](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax);
  re-verified 2026-08-01). The scheme is therefore not a Pages-only
  convention: blob view — the surface the operator audits pre-merge — resolves
  it too.
- **The verifiers key on internal path links.**
  `ElixirMind.Links.internal_targets/1` rejects any target containing `://`
  (`lib/elixir_mind/links.ex:118`), and `ElixirMind.Orphans` reuses that same
  extraction (`lib/elixir_mind/orphans.ex:54`) — so rewriting doc bodies to
  absolute URLs would silently disable link-resolution checking and collapse
  the inbound-link graph, reading every document as an orphan. Meanwhile
  `ElixirMind.Markdown.rewrite_href/2` passes `scheme://` hrefs through
  untouched and rewrites internal links to relative `.html`
  (`lib/elixir_mind/markdown.ex:433`), which is what makes the built site
  portable.
- **Corpus metrics** (measured 2026-08-01 at `HEAD`): 8,549 bundle-absolute
  `.md` links across 1,174 files; 1,521 of them inside frozen `meta/threads/`
  bodies; 34 relative links in the whole corpus (all but two inside frozen
  threads or generated files); 193 documents carry generated
  `## Thread excerpts` sections quoting frozen thread regions; `CLAUDE.md`
  carries 148 (regenerates freely).
- **The probe's corpus is thin and sandbox clones are shallow** (measured
  2026-08-01): `lib/` holds 38 `.ex` files and ~526 function definitions, and
  this session's clone is shallow (`git rev-parse --is-shallow-repository` →
  `true`, history window from 2026-07-13). Step 3 must `git fetch --unshallow`
  before measuring, and its analysis must name the history depth it actually
  saw.

## Step 1 — file the navigation snippet

Create `knowledge/SWE/editors/neovim/` (a new subdirectory under the
established domain — autonomous per the
[taxonomy-evolution protocol](/meta/policy/taxonomy-evolution-protocol.md),
with an `index.md` at each new level) and file a `type: snippet` document
carrying the config below verbatim, with the mkdnflow failure from § Verified
ground as its rationale section. The config belongs in the operator's personal
Neovim config (`~/.config/nvim/after/ftplugin/markdown.lua` or inline in
`init.lua`) — the repo documents it and does not install it.

```lua
_G.brain_link = function(fname)
  local root = vim.fs.root(0, '.git') or vim.fn.getcwd()
  fname = fname:gsub('#.*$', '')
  if fname:sub(1, 1) == '/' then return root .. fname end
  return fname
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function(ev)
    vim.bo[ev.buf].suffixesadd = '.md'
    vim.bo[ev.buf].includeexpr = 'v:lua.brain_link(v:fname)'
  end,
})
```

Two properties the snippet doc states: `includeexpr` fires only when the
literal path fails to resolve, so the rewrite coexists with any environment
where the literal path happens to work; and the navigation verbs that make
mouseless non-linear reading real are `gf` (follow), `<C-o>` (back), `<C-w>f`
(follow into a split), `<C-w>gf` (into a new tab).

## Step 2 — record the link-scheme rationale in policy

Amend [filenames-and-cross-linking](/meta/policy/filenames-and-cross-linking.md)
with one compact rationale bullet on the bundle-absolute rule, carrying (a) the
GitHub sentence quoted verbatim with its citation, and (b) the verifier
coupling — resolution checking and orphan detection parse exactly this link
form. Re-read the GitHub docs page for the verbatim span at edit time per
[quote-primary-sources](/meta/policy/quote-primary-sources.md), then recompile
the contract (`/render-contract`). This is a contract change and ships under
this plan's ratification.

## Step 3 — the churn probe

The empirical question, quoted from the
[analysis](/meta/analysis/localized-code-conversation-vs-linear-thread.md):
the anchor mechanism "depends on an empirical property of *this* operator's
generated code: whether its symbol boundaries are stable enough to anchor to."
The [strand sweep](/meta/plans/reconcile-dangling-ledger-strands.md) recorded
the matter "deferred to ratification after a churn probe"; this step is that
probe. It is independent of every editor decision and is the cheapest unblock
on the whole localized-conversation thread.

Method, at outline granularity:

1. `git fetch --unshallow` (see § Verified ground), then walk every commit
   touching `lib/`.
2. Per commit, extract the function inventory — `{module, name, arity}` — by
   regex over each `.ex` blob; no compilation, no dependencies.
3. Classify each function's transitions across its file's edits: survived
   intact · body edited in place (identity stable) · renamed · split/absorbed
   · deleted.
4. File the result as a `meta/analysis/` doc: the survival rates, the history
   depth and file count actually measured, and the anchor-mechanism
   recommendation the rates support — symbol-path anchors if identities are
   stable across rewrites, content-hash-with-fuzzy-relocation if they are not.

The probe runs as a scratch script; the analysis records the method and
numbers. "Insufficient history to decide — re-measure after N more months of
churn" is a legitimate verdict and must be stated at that scope rather than
rounded up, per
[negative-findings-name-their-scope](/meta/policy/negative-findings-name-their-scope.md).

## Deferred — the Model C plan

Authored only after step 3, since the probe's result decides the anchor
mechanism. A `meta/plans/` doc turning the analysis's recommendation —
"Model C: thread-primary source, location-primary presentation" — into
decisions and a build order, settling its three deferred questions: the
code-anchor identity mechanism ("the hard problem, deliberately unresolved
here", answered by the probe), sink aggregation/freeze semantics for code
anchors, and the capture-side contract against `/capture`'s freeze-then-tag
ordering.

Two reconciliations bind it:

- **Against agent-pairing.** The
  [architecture plan](/projects/agent-pairing/architecture-and-build-order.md)
  defers an extension — "Interjection capture and rule promotion. Persist
  operator corrections anchored to code and commit" — that needs the same
  sub-file anchor. One anchor mechanism, two consumers: the Model C plan owns
  storage and verification in this brain's route-tag machinery
  (`mix brain.route_tags` generalized to code sinks), and the editor
  projection is a client of the agent-pairing broker rather than a second
  delivery stack.
- **Address.** It files under `meta/plans/`, since route tags, `/capture`, and
  the verifier are this brain's tooling; only the projection surface belongs
  to the project namespace.

## Build order

1. **Steps 1 + 2 together, one small PR** — independent of everything else,
   and each other's natural companions (the snippet is the reader-side of the
   scheme the policy edit justifies).
2. **Step 3** — the probe and its analysis doc.
3. **The deferred phase graduates** — the Model C plan is written against the
   probe's verdict, at which point the strand-sweep row's matter has a live
   tracker.

## Scope boundaries (explicitly out)

- **No link rewrites.** Cross-links stay bundle-absolute; the Pages-URL and
  relative-link alternatives are rejected in the decision list.
- **No markdown-link plugin.** mkdnflow is a tested failure, and no plugin is
  adopted without a specific capability the `includeexpr` approach lacks.
- **Warp is out.** The Warp Markdown-viewer thread — and the
  symlink-top-level-domains-at-`/` closure that existed only to serve it — is
  dropped with it; re-open only if Warp returns as an operator surface.
- **The operator's Neovim config never lands in this repo's tooling** — the
  repo documents it as a snippet.
- **No Model C implementation here.** Route-tag code is untouched until the
  Model C plan is ratified.
- **The broker, tiers, and supervision build** belong to
  [agent-pairing](/projects/agent-pairing/architecture-and-build-order.md);
  keybinding fluency belongs to [dvorak-vim](/projects/dvorak-vim.md).

## File-tree diff

```
knowledge/SWE/editors/                          # NEW  directory + index.md
  neovim/                                       # NEW  directory + index.md
    root-relative-link-navigation.md            # NEW  type: snippet — the includeexpr config, verbs, mkdnflow rationale
meta/policy/filenames-and-cross-linking.md      # MODIFIED  one rationale bullet (GitHub quote + verifier coupling)
CLAUDE.md                                       # REGENERATED  contract recompile after the policy edit
meta/analysis/<lib-churn-probe-result>.md       # NEW (step 3)  method, rates, anchor recommendation
meta/plans/<model-c-code-anchors>.md            # NEW (deferred) authored after the probe
```

## Anchors

- `lib/elixir_mind/links.ex:118` — the `://` rejection in `internal_targets/1`
- `lib/elixir_mind/orphans.ex:54` — orphan detection reusing that extraction
- `lib/elixir_mind/markdown.ex:433` — `rewrite_href/2` scheme passthrough
- [`meta/policy/filenames-and-cross-linking.md`](/meta/policy/filenames-and-cross-linking.md) — step 2's target
- [`meta/plans/reconcile-dangling-ledger-strands.md`](/meta/plans/reconcile-dangling-ledger-strands.md) — the sweep appendix row this plan gives a tracker
- [`meta/analysis/localized-code-conversation-vs-linear-thread.md`](/meta/analysis/localized-code-conversation-vs-linear-thread.md) — Model C and its three deferred questions
- [`meta/analysis/agent-drivable-apps-shared-state-dual-interfaces.md`](/meta/analysis/agent-drivable-apps-shared-state-dual-interfaces.md) — the control/presentation mechanism Model C's delivery converges with
- [`projects/agent-pairing/architecture-and-build-order.md`](/projects/agent-pairing/architecture-and-build-order.md) — the interjection-capture extension sharing the anchor mechanism

## Decisions, alternatives, open questions

**Recommended shape:** the three steps plus the deferred phase, in the build
order above.

**Rejected — rewriting cross-links to deployed Pages URLs.** Disables both
verifiers (§ Verified ground), leaves every new document's links dead until
merge + deploy, breaks agent navigation in a checkout, and defeats the site's
relative-link portability.

**Rejected — converting cross-links to relative paths.** Buys only the
deletion of nine config lines; strands the 1,521 bundle-absolute links inside
frozen thread bodies as a permanent mixed scheme; inverts move-fragility
against a taxonomy designed to evolve (a moved document breaks every relative
inbound link at a different depth); destroys the property that a grep for
`"/beliefs/glossary/x.md"` finds every inbound reference; and forces depth
arithmetic on every agent-authored link.

**Rejected — mkdnflow.nvim, or another markdown-link plugin.** Tested failure
(§ Verified ground); the nine-line `includeexpr` covers the need.

**Rejected — closing Warp via root-level symlinks.** Cut with the Warp scope:
the sole surface it served is no longer a target, and the macOS path
(`/etc/synthetic.conf` + reboot; SIP blocks direct entries at `/`) was never
verified.

**Rejected — filing the snippet under `knowledge/SWE/dev-tools/`.** That
directory's charter is products "read as primary sources rather than used"; a
config how-to contradicts it. `editors/` is the natural sibling.

**Rejected — committing the probe as a `mix brain.churn` task.** One-shot
decision support, and a check earns a gate only when its signal beats its
upkeep per the [coding standards](/meta/policy/elixir-coding-standards.md);
the analysis doc preserves the method if it ever needs re-running.

**Open question:** whether `lib/` alone can power the probe. It is one month
old and ~526 functions; if the measured churn is too sparse to discriminate
between anchor mechanisms, the choices are to wait and re-measure, or to widen
the corpus to other operator repositories of agent-generated code — which
would need the operator to name them.
