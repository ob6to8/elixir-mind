---
type: policy
title: "Resource links: Pages links in docs, GitHub links in agent threads"
description: Agent-delivered responses (chat, PR bodies, issue comments) cite brain resources by their GitHub blob URL via mix brain.url --thread, viewable at any merge state; document bodies keep bundle-absolute paths the site renders, and the Pages URL is the durable form for merged documents shared outside a session.
section: filing
order: 4
status: active
tags: [meta, governance, filing, links, responses]
timestamp: 2026-07-27
attribution:
  when: 2026-07-13T07:50:19+00:00
  channel: backfill
  agent: "reconstructed by mix brain.attribution --backfill, 2026-07-13"
  from: [/meta/threads/2026-07-13-response-resource-links-policy-and-site-config.md, /meta/threads/2026-07-22-qiju-thread-storage-and-fit-each-layer-doctrine.md, /meta/threads/2026-07-27-scar-tissue-drift-doctrine-and-link-policy.md]
---
**Pages links in docs, GitHub links in agent threads.** Two surfaces, two link
schemes (operator-ratified 2026-07-27):

- **Agent threads → GitHub links, always.** When an agent's **delivered
  response** (chat to the operator, a PR body, an issue comment — anything
  read outside a checkout) references a document in the brain, cite its
  GitHub **blob URL** — at `main` for a merged, unchanged document, at the
  session branch otherwise — never a bundle-absolute or relative repo path,
  and never a Pages URL. A blob URL is viewable at **any** merge state, which
  is exactly when the operator audits; a Pages URL is live only after merge
  and deploy. (A branch blob link dies when the merged branch is deleted;
  that is accepted — the thread's moment has passed, and the document's
  durable home is its Pages URL.)
- **Docs → Pages links.** Cross-links *inside* document bodies stay
  bundle-absolute markdown paths per
  [filenames-and-cross-linking](/meta/policy/filenames-and-cross-linking.md);
  the site rewrites them to relative `.html` at build time, so on the
  rendered site every doc link *is* a Pages link. Never hardcode live URLs
  into document bodies. The Pages URL is the **durable, canonical form for a
  merged document** cited outside a session (sharing, external references).

**Get the URL from the tool, never by hand.** `mix brain.url` prints the
right URL for each surface — always run it; hand-construction is exactly what
produces dead links:

- **`mix brain.url --thread <path>`** — the agent-thread form: the blob URL
  at the ref whose tree holds the current content (`main` when merged and
  unchanged, else the current branch).
- **`mix brain.url --pages <path>`** — the canonical Pages URL for durable
  external citation of merged docs (bundle path `P.md` →
  `{{site_base_url}}P.html`; a directory's `index.md` → `…/<dir>/index.html`;
  governance `meta/…` docs render too).
- **Bare `mix brain.url <path>`** — whichever resolves and shows the current
  content (Pages when live and unchanged vs `origin/main`, else blob).

**Mechanics.** The bundle is published to GitHub Pages at
**`{{site_base_url}}`** (`mix brain.site` → `pages.yml`, deploying **only from
the default branch** — the reason unmerged docs have no live page). The base
URL lives in config (`config/config.exs` →
`ElixirMind.SiteConfig.base_url/0`); it is the single source of truth, and
this contract's copy is compiled in from it. Resources under directories the
site excludes (`deprecated/`, `.claude/`, `lib/`, `test/`) have no page ever;
`mix brain.url` cites those by blob URL in every mode rather than fabricating
a Pages URL.
