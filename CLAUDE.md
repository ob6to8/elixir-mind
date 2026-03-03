# Second Brain

Assertion DAG knowledge base. Markdown files, shell scripts, optional Claude Code skills.

## Architecture

```
Layer 0: Files on disk (markdown, json, shell scripts)
Layer 1: Shell scripts (ingest, build-index, query, deps, orphans, contested)
Layer 2: Claude Code skills (/search, /conclude — thin wrappers over Layer 1)
Layer 3: Natural language conversation (research, reasoning)
```

## Content Types

Two types of files, distinguished by `type` field in frontmatter:

- **source** — external content (articles, videos, papers, conversations). Evidence for assertions. Lives in `sources/`.
- **assertion** — atomic claims. Primitives are backed by evidence, compounds compose primitives with explicit deps. Lives in `assertions/`.

See `schema/` for full file specs: `schema/source.md`, `schema/assertion.md`, `schema/conventions.md`, `schema/index.md`.

## Directory Structure

```
sources/        # External content (flat, no subdirectories)
assertions/     # Primitives and compounds (flat)
schema/         # File specs and conventions
templates/      # Frontmatter templates (source.md, assertion.md)
scripts/        # Shell tooling
plans/          # Architecture plans (historical)
intake/         # Staging area
.claude/skills/ # Claude Code skills
```

## Ingestion Workflow (sources)

1. User provides a URL
2. Detect content type (article, YouTube video, paper)
3. Fetch content: `./scripts/ingest.sh <url>` for raw text, or WebFetch for articles
4. Generate frontmatter from `templates/source.md` — must include `type: source` and `source_type`
5. Create file in `sources/<kebab-name>.md`
6. Run `./scripts/build-index.sh` to update `index.json`
7. Commit

## Assertion Workflow

1. Research or conversation produces findings
2. Decompose into atomic claims (primitives)
3. For each claim: check `index.json` for existing assertions that overlap
4. Create/update primitive assertion files in `assertions/` with evidence links to sources
5. Identify compositions — where multiple primitives imply a compound
6. Create compound assertions with explicit `deps` and `implication`
7. Run `./scripts/build-index.sh`
8. Commit

## Reading the Brain

1. Load `index.json` first — it has sources, assertions, and edges (the DAG)
2. Only read full `.md` files when the user asks about a specific topic
3. Use `./scripts/query.sh` for programmatic searches

## Scripts

- `scripts/ingest.sh <url>` — fetch raw content, print to stdout. Detects: YouTube (yt-dlp), Reddit (.json API), arxiv, generic article (curl + pandoc)
- `scripts/build-index.sh` — regenerate `index.json` from `sources/` and `assertions/` frontmatter
- `scripts/query.sh` — search by tag, claim text, type, tier, confidence, or full-text
- `scripts/deps.sh <id>` — walk assertion DAG upward, show dependency tree
- `scripts/orphans.sh` — find unconnected nodes (assertions nothing depends on, sources nothing cites)
- `scripts/contested.sh` — find contested/low-confidence assertions and potential contradictions

## Ingestion Notes

- **Reddit:** `ingest.sh` appends `.json` to URLs — bypasses JS rendering, extracts post + top 15 comments via jq
- **X/Twitter:** cannot be auto-fetched (JS wall). User must paste content manually.
- **YouTube:** auto-generated transcripts have mangled names — clean up in the structured note
- **Generic articles:** WebFetch often works better than `ingest.sh` for non-JS-rendered pages

## Conventions

See `schema/conventions.md` for full rules. Key points:
- Filenames: kebab-case, no path prefix in wikilinks
- Tags: lowercase, hyphenated
- IDs: filename without extension
- Flat directories — tags handle taxonomy, not folders

## Dependencies

- `yt-dlp` — YouTube transcript extraction
- `jq` — JSON processing
- `yq` — YAML frontmatter parsing
