# Log

Chronological history of the knowledge base. Newest entries first. Dates are ISO 8601.

## 2026-07-05

- Introduced the `meta/` governance namespace and made `CLAUDE.md` a **compiled
  artifact**: the operating contract was backfilled into 14 `type: policy` documents
  under `meta/policy/`, and an Elixir compiler (`mix brain.contract`) now renders
  `CLAUDE.md` from `meta/preamble.md` + those policies, with a trace link per rule.
  Added the `/render-contract` skill, the `policy` type, and the mix project
  (`mix.exs`, `lib/`, `test/`). See [meta/log.md](/meta/log.md).
- Dropped the `link` type: a web resource enters the brain only once processed into a
  `reference`; bare URLs are not filed. Removed the `link`/`reference` distinction.
- Policy update to the operating contract: create the natural directory path even for a
  single concept; new top-level dirs still ratified, subdirs autonomous. Added `claim`
  and `link` types and `provenance` / `verified` frontmatter fields.
- First `/intake`: filed `SWE/version-control/git/git-local-branches-dont-auto-advance-on-fetch.md`
  (type `claim`, `verified: false`, provenance Claude Opus 4.8). Created operator-ratified
  top-level `SWE/` domain with the `version-control/git/` subtree and their `index.md` files.
- Initialized the Open Knowledge Format (OKF v0.1) bundle: bundle-root `index.md`,
  this `log.md`, the operating contract (`CLAUDE.md`), and the `/intake` skill.
- Taxonomy starts blank; directories are created collaboratively as content arrives.
- Prior tooling and content archived under `deprecated/` (read-only).
