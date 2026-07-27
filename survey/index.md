# Survey — the bookmark tier

A **staging tier** for links: worth keeping, not yet worth fully ingesting. The
operator drops URLs in bulk; [`/bookmarks`](/.claude/skills/bookmarks/SKILL.md) fetches
each, writes a one-line summary and topical tags, and parks it with `status: surveyed`.
A surveyed link is queryable by topic (its tags and summary are indexed) without the
full distill-file-cross-link cost of a filed
[`reference`](/knowledge/knowledge-management/open-knowledge-format.md).

Like [`inbox/`](/inbox/index.md) and `meta/`, this namespace sits **outside the OKF
bundle**: no `em:` ids, never verified. A bookmark earns a place in the taxonomy only
on **promotion** — `/bookmarks promote` runs [`/intake`](/.claude/skills/intake/SKILL.md)
to distill and file it, then records the graduation on the row.

## Registers

- [bookmarks](/survey/bookmarks.md) — the survey register: pending dropzone + surveyed
  entries. Shards by top-level domain (e.g. `survey/ai.md`) only if it grows large.
