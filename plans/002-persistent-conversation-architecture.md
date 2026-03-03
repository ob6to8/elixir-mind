# Plan 002: Persistent Conversation Architecture

## Problem

LLM conversations are ephemeral by default. The context window is treated as the source of truth, but it's actually a lossy viewport. Persistence is an afterthought — summaries written at session end, memories the user never inspects, context lost at boundaries.

## Goal

Architect a persistence-first conversation system where:
1. Every exchange (prompt + tool calls + response) is atomically persisted before the next turn
2. The context window is a cache, not the source of truth
3. Conversations are inspectable, searchable, and exportable
4. A fresh agent can reconstruct any conversation by loading from the store
5. Finished threads export to the second-brain as `conversations/*.md` notes

## Key Insight

Simon Willison's `llm` CLI already provides the storage primitive: every exchange is logged to SQLite. The missing piece is a **context loader** that replaces the context window's role as memory.

## Architecture

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│  User input  │────▶│ context-load │────▶│  llm call   │
└─────────────┘     │              │     │             │
                    │ 1. thread DB │     │ prompt +    │
                    │ 2. index.json│     │ loaded ctx  │
                    │ 3. relevance │     │             │
                    └──────────────┘     └──────┬──────┘
                                                │
                                         ┌──────▼──────┐
                                         │  SQLite log │ (automatic)
                                         └──────┬──────┘
                                                │
                                         ┌──────▼──────┐
                                         │  Response   │
                                         └─────────────┘
```

### Components

#### 1. `llm` as the exchange layer
- Install: `brew install llm` / `pipx install llm`
- Every prompt/response is atomically logged to `~/.local/share/io.datasette.llm/logs.db`
- Conversation threading via `llm -c` (continue) or explicit conversation IDs
- Model-agnostic — can use Claude, GPT, local models

#### 2. `scripts/context-load.sh` — the context assembler
Replaces the context window's role as memory. Before each exchange:
1. Query SQLite for the current thread's prior turns (last N, or by relevance)
2. Load `index.json` to find related second-brain notes
3. Optionally read referenced notes for deeper context
4. Format as a system prompt or context block
5. Output to stdout for piping into `llm -s`

#### 3. `scripts/thread.sh` — conversation wrapper
Wraps `llm` to enforce the persistence-first protocol:
```bash
# Start a new thread
./scripts/thread.sh new "Why is the context window the unit of work?"

# Continue a thread (loads context automatically)
./scripts/thread.sh continue <thread-id> "How would you architect this?"

# Export a finished thread to second-brain
./scripts/thread.sh export <thread-id>
```

#### 4. `scripts/export-conversation.sh` — thread → second-brain
Queries `llm logs` for a conversation, then either:
- Writes a source file to `sources/<kebab-title>.md` with `type: source`, `source_type: conversation`
- Or invokes `/conclude` logic to extract assertions from the thread directly into the DAG

The second path is more aligned with Plan 003's architecture — conversations are a means to assertions, not artifacts themselves.

### Context loading strategies

Start simple, evolve:

**v1 — Recency window**
Load the last N exchanges from the thread. Simple, predictable.

**v2 — Recency + related notes**
Last N exchanges + any second-brain notes whose tags overlap with the thread's topic.

**v3 — Embedding similarity** (future)
Use `llm embed` to find the most relevant prior turns and notes. Requires pgvector or similar.

## Dependencies

- `llm` — `pipx install llm` or `brew install llm`
- `llm-claude` plugin — `llm install llm-claude-3` (for Claude models via llm)
- `sqlite3` — already available on macOS
- Existing: `jq`, `yq`

## Execution Order

1. Install `llm` and configure with Claude API key
2. Write `scripts/context-load.sh` — SQLite query + index.json lookup
3. Write `scripts/thread.sh` — conversation wrapper
4. Write `scripts/export-conversation.sh` — thread → .md note
5. Test: run a multi-turn thread, export it, verify it appears in index.json
7. Shellcheck all scripts

## Open Questions

- **Tool call logging** — `llm` doesn't log intermediate tool calls. Do we need a wrapper that captures these, or is prompt+response sufficient for the archive?
- **Context budget** — how many prior turns to load? Fixed window? Token-counted? Configurable per thread?
- **Thread discovery** — how does the context loader know which second-brain notes are relevant? Tag matching? Full-text search? Embeddings?
- **Editing** — should exported conversations be editable? If so, do edits propagate back to SQLite or is the .md the final form?
- **Claude Code integration** — can this coexist with Claude Code sessions, or is it a parallel workflow? Plan 003's `/conclude` skill is the natural bridge — export triggers assertion extraction.

## Non-Goals (for now)

- Real-time streaming (batch is fine)
- Multi-user threads
- Web UI (CLI-first)
- Replacing Claude Code (complementing it)
