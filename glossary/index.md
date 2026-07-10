# Glossary

One concept file per technical term, alphabetical, maintained by
[`/add-to-glossary`](/.claude/skills/add-to-glossary/SKILL.md). Each definition
is individually linkable — cite a term in any response as a bundle-absolute
link (e.g. `[route tag](/glossary/route-tag.md)`) and the link lands on its
definition. See the [glossary hub](/glossary.md) for how the system works.

## Terms

- [concept (OKF)](/glossary/concept-okf.md) — the unit of knowledge in this bundle: a markdown file with YAML frontmatter, id = path minus `.md`
- [graduation](/glossary/graduation.md) — a term outgrowing the glossary relocates into the domain taxonomy, id travelling with it, a pointer stub left behind
- [pointer entry](/glossary/pointer-entry.md) — an entry for a term canonically defined elsewhere: one-line gloss + link, never a duplicate definition
- [route tag](/glossary/route-tag.md) — inline `<routes ref="…">` region marking which concept(s) a paragraph of a frozen thread feeds
- [stable id (`sb:` id)](/glossary/stable-id.md) — the opaque, immutable `sb:` + 6-hex identifier every bundle concept carries
- [thread doc](/glossary/thread-doc.md) — the frozen, verbatim session record `/capture` writes under `meta/threads/`
- [verified_by](/glossary/verified-by.md) — the frontmatter field holding a statement's evidence edges (inline list of stable ids)
