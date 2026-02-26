# Second Brain

Markdown-based personal knowledge base. Obsidian-compatible vault.

## Status
**Bootstrapping** — plan written at `plans/001-second-brain-init.md`, not yet executed.

## What This Will Be
- Ingest web content (articles, YouTube, papers) via URL
- Extract text, generate YAML frontmatter (summary, tags, metadata)
- Organize into topic-based directories
- Maintain `index.json` catalog of all frontmatter for scanning
- Valid Obsidian vault (open repo root in Obsidian)

## Next Step
Execute `plans/001-second-brain-init.md`:
1. Create templates (article, video, paper)
2. Write ingestion script (`scripts/ingest.sh`)
3. Write index generator (`scripts/build-index.sh`)
4. Set up directory structure
5. Test with first URL

## Conventions (once built)
- Filenames: kebab-case from title
- Tags: lowercase, hyphenated
- Frontmatter summaries: 2-3 sentences max
- Wikilinks: `[[filename]]` (no path prefix)
- Load `index.json` first to scan the brain, only read full files when needed
