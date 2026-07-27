---
type: policy
title: "Resource links: Pages links in docs, GitHub links in agent threads"
description: In agent-delivered responses (chat, PR bodies, issue comments), link brain resources to their GitHub blob URL on the current branch so they are viewable at any merge state; document bodies keep bundle-absolute paths, which the deployed Pages site renders — the Pages URL is the durable citation for merged documents.
section: filing
order: 4
status: active
tags: [meta, governance, filing, links, responses]
timestamp: 2026-07-27
attribution:
  when: 2026-07-13T07:50:19+00:00
  channel: backfill
  agent: "reconstructed by mix brain.attribution --backfill, 2026-07-13"
  from: [/meta/threads/2026-07-13-response-resource-links-policy-and-site-config.md]
---
**Pages links in docs, GitHub links in agent threads.** Two surfaces, two link
schemes (operator-ratified 2026-07-27, replacing the original always-Pages
response rule after session-created docs produced dead links in chat — Pages
deploys from `main`, so an unmerged document has no page yet):

- **Agent threads → GitHub links.** When an agent's **delivered response**
  (chat to the operator, a PR body, an issue comment — anything read outside a
  checkout) references a document in the brain, cite the document's **GitHub
  blob URL**: on the **current session branch** while the work is unmerged, on
  **`main`** when citing already-merged documents. A blob link is viewable the
  moment it is pushed, at any merge state — which is exactly when the operator
  audits. (Branch links die when the merged branch is deleted; that is
  acceptable — the thread's moment has passed, and the document's durable home
  is its Pages URL.) Construct the URL from the repository remote:
  `<repo>/blob/<branch>/<bundle-path>`.
- **Docs → Pages links.** Cross-links *inside* document bodies stay
  bundle-absolute markdown paths per
  [filenames-and-cross-linking](/meta/policy/filenames-and-cross-linking.md);
  the site rewrites them to relative `.html` at build time, so on the rendered
  site every doc link *is* a Pages link. Never hardcode live URLs into
  document bodies. Where a durable public URL for a **merged** document is
  needed outside a session — sharing, external references — use the Pages URL.

Mechanics of the Pages side:

- **The site.** The bundle is published to GitHub Pages at
  **`{{site_base_url}}`** (`mix brain.site` → `pages.yml`, one page per document and
  per `index.md`). That base URL lives in config
  (`config/config.exs` → `ElixirMind.SiteConfig.base_url/0`); it is the single
  source of truth, and this contract's copy of it is compiled in from that config —
  a deploy move (e.g. a custom domain) is one config edit, not a doc rewrite.
- **The mapping.** Bundle path `P.md` → `{{site_base_url}}P.html`; a directory's
  `index.md` → `…/<dir>/index.html`. Governance docs (`meta/…`) are rendered too.
  `mix brain.url <path>` prints the mapped URL for a bundle path — the mechanical
  way to get it right.
- **Not rendered → no Pages URL ever.** Directories the site excludes
  (`deprecated/`, `.claude/`, `lib/`, `test/`) have no page at any merge state;
  cite those by GitHub link in threads, and by repo path inside docs — never
  fabricate a Pages URL.
