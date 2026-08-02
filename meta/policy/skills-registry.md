---
type: policy
title: Skills registry
description: The available skills and where new skills are added.
section: skills
order: 1
status: active
tags: [meta, governance, skills]
timestamp: 2026-07-28
attribution:
  when: 2026-07-05T12:30:48+00:00
  channel: backfill
  agent: "reconstructed by mix brain.attribution --backfill, 2026-07-13"
  from: [/meta/threads/2026-07-05-greenfield-okf-bootstrap-and-verification-layer.md, /meta/threads/2026-07-13-resource-attribution-property-spec-and-build.md, /meta/threads/2026-07-14-create-pull-request-merge-opt-in.md, /meta/threads/2026-07-22-survey-tier-and-bookmarks-register.md, /meta/threads/2026-07-25-journal-skill-and-first-entry.md, /meta/threads/2026-07-26-living-text-present-tense-policy.md, /meta/threads/2026-07-28-communication-guidance-and-banned-phrases.md, /meta/threads/2026-07-28-operator-methodology-shift-and-comprehension-audit.md]
---
- **`/intake`** — process pasted content into one or more filed documents. See
  `.claude/skills/intake/SKILL.md`. This is the primary way knowledge enters the
  brain.
- **`/render-contract`** — recompile `CLAUDE.md` from `meta/policy/*.md` after editing
  any policy. See `.claude/skills/render-contract/SKILL.md`. `CLAUDE.md` is a
  generated artifact — never hand-edit it.
- **`/capture`** — persist the current session as a **distilled** thread doc under
  `meta/threads/`: substantive exchanges only (tool calls, reasoning, and short
  pre-tool narration stripped), then a routing ledger and route tags over the frozen
  body. This is the session-persistence skill. See `.claude/skills/capture/SKILL.md`.
- **`/summarize-technical`** — produce a three-part layered breakdown of a technical
  paper/article/spec: a plain-language summary, a glossary of its key technical terms,
  then an integrated technical summary reusing those terms. See
  `.claude/skills/summarize-technical/SKILL.md`.
- **`/elaborate`** — unpack a technical **phrase or short passage** (from the
  conversation, a doc, a commit message, or pasted text): define the terms it uses and
  give a less technical overview of the concepts and actions it describes, delivered
  in chat **and persisted** as a `type: elaboration` doc under
  [`meta/elaborations/`](/meta/elaborations/index.md) (governance namespace, no `em:`
  id; link glossary terms that already exist; hand off to `/add-to-glossary` to
  persist new ones per-term). The doc's `attribution.from` back-link to its
  originating session is set later by `/create-pull-request`, never by this skill.
  The phrase-scale sibling of `/summarize-technical`. See
  `.claude/skills/elaborate/SKILL.md`.
- **`/add-to-glossary`** — scan a persisted thread (`meta/threads/`), a paper, a post,
  or a filed document; extract the technical terms it actually uses; and merge distilled
  definitions into the glossary — **one `concept` document per term** under
  [`/beliefs/glossary/`](/beliefs/glossary/index.md) (hub: [`/beliefs/glossary.md`](/beliefs/glossary.md)), each with
  its own `em:` id and *Seen in:* citations, so any response or document can cite a
  term by link (pointer entries defer to filed documents instead of duplicating them).
  Also invoked automatically by `/create-pull-request` on the thread doc its
  `/capture` step writes. See `.claude/skills/add-to-glossary/SKILL.md`.
- **`/research`** — generate today's **inbox**: a daily candidate feed of research, articles,
  papers, and resources matched against the brain's taxonomy, grouped by category and
  reason-tagged (`recent`/`impactful`/`influential`/`groundbreaking`/`buzz`) — then
  **auto-intake the featured items** into the bundle via `/intake`. The digest is the
  dated record in the non-bundle `inbox/` namespace (no `em:` ids); its featured items
  graduate into filed documents in the same run, bounded to the known tree (items needing
  a new top-level domain are deferred for operator ratification) and attributed
  `channel: auto-intake` for the operator's post-intake editorial pass. See
  `.claude/skills/research/SKILL.md`.
- **`/bookmarks`** — process the **survey tier**: links the operator wants kept but not
  yet fully ingested. The operator drops raw URLs under **Pending** in the register
  (`survey/bookmarks.md`); a bare `/bookmarks` fetches each, writes a one-line summary
  and topical tags, and moves it to **Surveyed** (`status: surveyed`) — a non-bundle
  namespace (no `em:` ids) like `inbox/`. `/bookmarks list [surveyed|promoted|all]`
  reviews the register; `/bookmarks promote <url>` runs `/intake` to distill and file
  the link as a bundle `reference`, then records the graduation on the row. The
  lower-effort staging sibling of `/intake` (see the
  [link-processing](/meta/policy/link-processing.md) survey-tier carve-out). See
  `.claude/skills/bookmarks/SKILL.md`.
- **`/create-pull-request`** — run `/capture` to completion, run `/add-to-glossary`
  over the captured thread doc, **stamp the thread into `attribution.from`** (append
  the just-captured thread's path to the `from` list of every governance doc the
  session created or substantively revised — the append-only carve-out of the
  resource-attribution policy), then commit the current working changes, push the
  branch, and open a pull request — so the frozen thread doc, the glossary updates it
  feeds, and each governance doc's trace back to its session all ship in the same
  PR. Invoking the skill **is** the authorization to open the PR (no separate
  confirmation gate); PR-template detection and the GitHub MCP tools handle the
  rest. **Merging is opt-in, off by default:** a bare invocation ends with the PR
  open and handed back to the operator; passing a `merge` argument
  (`/create-pull-request merge`) has the skill drive CI to green and true-merge it.
  See `.claude/skills/create-pull-request/SKILL.md`.
- **`/sync-branch-with-main`** — fetch `origin/main` and merge it into the current
  working branch, keeping a feature branch current so its diff reflects only its own
  changes and a later PR merges cleanly. Refuses to run on `main`; surfaces conflicts
  rather than blindly resolving them; retries only on network errors. See
  `.claude/skills/sync-branch-with-main/SKILL.md`.
- **`/priorities`** — list the brain's open work as a prioritized appraisal: runs
  `mix brain.session_init` (open issues, open matters, active plans, dangling ledger
  strands) and closes with a heuristic top-3 the agent refines with judgment — the
  on-demand appraisal of open work, produced when asked rather than injected at
  session start. Read-only. See `.claude/skills/priorities/SKILL.md`.
- **`/issue`** — list `type: issue` tracked problems under `meta/issues/`, grouped by
  `status` (default `open`). The issues-only slice of `/priorities`; read-only
  (filing an issue stays inline per the contract). See `.claude/skills/issue/SKILL.md`.
- **`/plan`** — list `type: plan` design/decision records under `meta/plans/`, grouped
  by `status` (default `active` = proposed/accepted/in-progress). The plans-only slice
  of `/priorities`; read-only (persisting a plan stays inline per the persist-plans
  policy). See `.claude/skills/plan/SKILL.md`.
- **`/journal`** — file the operator's daily journal entry: everything following the
  invocation is the entry body, transcribed faithfully (only dictation noise cleaned —
  the operator's voice is inviolable) into a dated `type: note` doc at
  `journal/YYYY-MM-DD.md` (one file per day; same-day additions append). `journal/` is
  a **non-bundle namespace** like `inbox/` and `survey/`: no `em:` ids, no
  `attribution` (machine-enforced exempt), anchored by date rather than inbound
  links, outside the taxonomy — the operator's synthesis practice, on the record
  layer. `/journal list` reviews recent entries; every filed entry receives a
  two-part response by default — an editorial read, then a substantive follow-up
  (the operator opts out per entry: "file only") — delivered in chat and persisted
  verbatim below the entry under a marked `## Response` heading — operator voice
  above, agent voice below, never interleaved. See `.claude/skills/journal/SKILL.md`.
- **`/ban-phrase`** — add an operator-flagged word or phrase to the
  [banned-phrases register](/meta/policy/banned-phrases.md) (verbatim phrase,
  generalized pattern, the reasoning from the flagging exchange, and a recast),
  dedup against existing patterns, and recompile the contract so the entry binds
  every future session; the operator's invocation is the ratification.
  `/ban-phrase list` renders the register read-only. See
  `.claude/skills/ban-phrase/SKILL.md`.
- **`/review-pr`** — render an ask-vs-delivered audit of the current session as two
  tables: every request the operator made (with a done/partial/not-done/declined/
  superseded status), and what the agent actually did, with the files touched and
  whether each landed in a commit or is still in the working tree. **Both columns
  rest on artifacts, never on recall**: the asks are enumerated from the session
  transcript (`~/.claude/projects/…/<session-id>.jsonl`) and the delivered work
  from `git log`/`git diff` against `origin/main` — an asks column built from a
  context-compaction summary drops the asks made before the boundary, silently,
  which is the failure the skill exists to catch — so the audit is evidence
  rather than the session's own testimony
  (see [normative records vs. descriptive
  traces](/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md));
  gaps in either direction are reported in prose beneath. Read-only — it opens,
  merges, and modifies nothing, and is meant to precede the operator's own PR
  review. See `.claude/skills/review-pr/SKILL.md`.

New skills are added under `.claude/skills/<name>/SKILL.md`.
