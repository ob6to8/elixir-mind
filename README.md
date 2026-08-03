# elixir-mind

A personal knowledge base — a second brain — written and maintained by AI
agents under a human operator's direction. The content is plain markdown with
YAML frontmatter, organized as an
[Open Knowledge Format](/knowledge/knowledge-management/open-knowledge-format.md)
(OKF v0.1) bundle, versioned in git, checked by CI, and published as a static
site at <https://ob6to8.github.io/elixir-mind/>.

## Premise

The repo is built on a division of labor: agents file, organize, verify, and
build; the operator sets direction and ratifies changes to the brain's shape —
its directory taxonomy, its document types, its rules. The starting position is
that the engineer's role is shifting from implementation to orchestration:
coordinating agents, evaluating their output, and deciding which problems to
work on. That position is recorded as the repo's
[founding doctrine](/meta/doctrine/engineer-as-orchestrator.md), and the repo
itself is the substrate the role needs — the externalized state that lets
judgment span more sessions and more matters than one head or one chat thread
can hold.

Externalization is a structural requirement, not a preference. Agent sessions
are stateless and conversations scroll off, so everything the work produces
lands in files under version control: knowledge distilled into documents,
decisions persisted as plans and policies, sessions frozen verbatim as thread
records, and the change narrative carried by the commit graph. The repo is the
memory; git is the provenance layer; work is resumed from the record rather
than from recall.

The other half of the premise is governance. Every agent operating here is
bound by an operating contract — [`CLAUDE.md`](/CLAUDE.md) — compiled from
policy documents the operator has ratified. Rules with a mechanical oracle are
enforced as CI gates; rules without one bind agent judgment and hold the line
in review. Agent work is accepted only once the operator understands it, and a
local fix becomes standing behavior only through ratification. The contract
binds agents, not the operator.

## Design

- **Documents.** A document is one markdown file: YAML frontmatter over a
  distilled prose body. Frontmatter carries a controlled `type`, a stable id
  (`em:` plus six hex characters, minted once, surviving renames and moves),
  and an `attribution` map recording how the document entered the brain.
  Typed references point at ids; prose links use paths.
- **The tree is the taxonomy.** Documents are classified by where they sit in
  a unix-like directory hierarchy, surfaced by an `index.md` at every level.
  The taxonomy is not imposed up front; it emerges as knowledge is filed.
  Agents file into existing directories autonomously and propose new top-level
  domains for the operator to ratify.
- **Intent is the source; artifacts are derived.** The ratified layer is
  doctrine and policy. The contract, the id registry, the code map, the flow
  lineage views, and the website are generated from it, and each generated
  artifact has a freshness check in CI, so a derived copy cannot drift from
  its source unnoticed.
- **Distill the knowledge, preserve the record.** The knowledge layer is
  optimized for concision and queryability: capture the point, cite the
  source. The record layer is optimized for fidelity: sessions are captured
  verbatim (minus tool noise) into `meta/threads/`, and route tags lift each
  thread's relevant passages into the documents they fed, so a document
  accretes the cross-session discussion behind it. There are no hand-kept
  logs; commit history is the change record, and every merge is a true merge
  so cited SHAs stay reachable.
- **Verification is explicit.** A statement marked `verified: true` must carry
  evidence edges (`verified_by`) pointing at captured primary sources;
  `mix brain.verify` enforces the grounding, along with id integrity and
  attribution shape.
- **Delivery is review-sized.** One matter — one coherent intent a reviewer
  can approve or reject as a whole — per pull request. A session closes by
  capturing itself and opening the PR that carries its work.

## Layout

| Path | Contents |
|---|---|
| `index.md` | bundle-root index; navigation starts here |
| `CLAUDE.md` | the operating contract — generated from `meta/policy/`, never hand-edited |
| `knowledge/` | the knowledge taxonomy |
| `beliefs/` | operator-held decision priors, plus the glossary under `beliefs/glossary/` |
| `projects/` | systems built outside this repo that incubate here |
| `meta/` | governance: doctrine, policies, plans, analyses, issues, matters, tutorials, flows, evals, thread archives, and the generated registry and code map |
| `inbox/`, `survey/`, `journal/` | non-bundle namespaces: the daily research feed, the bookmark tier, the operator's dated journal |
| `.claude/skills/` | the skills agents operate through |
| `lib/`, `test/`, `mix.exs` | the Elixir toolchain behind the `mix brain.*` tasks |
| `deprecated/` | archived legacy content, read-only |

## Usage

The brain is operated from Claude Code sessions; skills are the operating
surface:

- `/intake` — distill pasted material into filed documents; the primary path
  by which knowledge enters.
- `/research` — generate the daily candidate feed under `inbox/` and
  auto-intake its featured items.
- `/bookmarks` — park links in the survey tier with a one-line summary and
  tags; promote a bookmark to a filed reference later.
- `/journal` — file the operator's dated journal entry.
- `/priorities`, `/issue`, `/plan`, `/matter` — appraise open work: tracked
  problems, active plans, and the matter queue.
- `/capture` — freeze the session as a thread doc under `meta/threads/`.
  `/create-pull-request` runs it, glossaries the thread, then commits, pushes,
  and opens the PR.

The full skills registry is in [`CLAUDE.md`](/CLAUDE.md).

## Integrity gates

CI runs the gate suite on every push and PR:

- **Build gates** — workflow lint (actionlint), compile and tests with
  warnings as errors, format check, and zero compile-time coupling between
  modules (`mix xref graph --label compile-connected --fail-above 0`).
- **Freshness gates** — the generated artifacts are current:
  `mix brain.contract --check`, `mix brain.registry --check`,
  `mix brain.codemap --check`, `mix brain.lineage --check`.
- **Bundle gates** — `mix brain.verify` (ids, evidence edges, grounding,
  attribution), `mix brain.route_tags` (tag wellformedness, ref resolution,
  excerpt-log fidelity), `mix brain.glossary` (descriptions, index sync, body
  dedup), and `mix brain.matters` (register ↔ doc agreement).
- **A site build**, plus a non-gating `mix brain.dedup_probe` recall report.

The toolchain has zero external dependencies and runs offline. An opt-in
pre-commit hook mirrors the suite locally
(`git config core.hooksPath .githooks`).

## Website

`mix brain.site` renders the bundle into a static HTML site: a sidebar
mirroring the directory taxonomy, per-document metadata panels (type, tags,
verification status, evidence edges and their backlinks), and client-side
search, with all links relative so the site works at any base path.

```sh
mix brain.site                     # build into _site/
python3 -m http.server -d _site    # serve locally so search can load its index
```

The site is not committed. [`pages.yml`](.github/workflows/pages.yml) builds
and deploys it to GitHub Pages on every push to `main`, re-running the
integrity checks first so only a verified bundle is published. The workflow
enables Pages on its first run; if the hosting organization restricts that,
set **Settings → Pages → Source** to **GitHub Actions** once by hand.

## Documentation

This README is the orientation layer. The depth lives in governed documents
inside the repo, rendered on the published site:

- [`CLAUDE.md`](/CLAUDE.md) — the full operating contract: frontmatter schema,
  type vocabulary, filing conventions, session capture, git workflow.
- [`meta/doctrine/`](/meta/doctrine/index.md) — the standing directions the
  design serves.
- [`meta/policy/`](/meta/policy/index.md) — the ratified rules the contract is
  compiled from.
- [`meta/tutorials/`](/meta/tutorials/index.md) — long-form explainers on the
  tooling and governance: the gate suite, the git workflow, the site
  generator, the bundle scanners.
- [`meta/flows/`](/meta/flows/index.md) — file-by-file walkthroughs of each
  canonical flow.
- [`meta/code-map.md`](/meta/code-map.md) — generated module/function intent
  glossary for `lib/`.
- [dev history](https://ob6to8.github.io/elixir-mind/meta/dev-history.html) —
  per-PR development record, derived from the merge graph at deploy time.
