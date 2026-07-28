---
id: em:53f32a
type: reference
title: "Claude Code settings and permissions — the four-scope hierarchy and the merge rule"
description: Claude Code resolves settings across four scopes (managed, local, project, user) by priority, but permission rules are the exception — they merge across scopes rather than override, which is why a project allow rule cannot cancel a managed deny.
resource: https://code.claude.com/docs/en/settings
provenance: "Anthropic Claude Code documentation — Settings page"
tags: [anthropic, claude-code, settings, permissions, configuration, governance, cca]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "filling the Claude Code configuration pillar for the Claude Certified Architect study program; the settings hierarchy and permission merge rule are the enterprise-governance core of that pillar"
---

# Claude Code settings and permissions

## The four scopes

| Scope | Location | Shared |
|---|---|---|
| **Managed** (highest) | server, plist, registry, or `/etc/claude-code/managed-settings.json` | yes — deployed by IT |
| **Local** | `.claude/settings.local.json` | no — gitignored |
| **Project** | `.claude/settings.json` | yes — committed to git |
| **User** (lowest) | `~/.claude/settings.json` | no |

> "When the same setting appears in multiple scopes, Claude Code applies them in
> priority order: 1. Managed (highest); 2. Command line arguments; 3. Local;
> 4. Project; 5. User (lowest)."

Command-line arguments sit *below* managed and above local — so a flag overrides
a project setting but cannot escape an enterprise policy.

## The permission exception

The rule most worth internalizing, because it inverts the intuition built by the
precedence table:

> "Permission rules behave differently because they merge across scopes rather
> than override."

Rules come in three kinds — `allow`, `ask`, `deny` — and because they merge, a
`deny` written at the managed scope cannot be cancelled by an `allow` at the
project or user scope. Adding a permissive rule lower down **adds** to the set;
it does not replace what sits above. Managed settings can additionally enforce
`allowManagedPermissionRulesOnly` to prevent user and project overrides
entirely.

```json
{
  "permissions": {
    "allow": ["Bash(npm run lint)", "Bash(npm run test *)", "Read(~/.zshrc)"],
    "deny":  ["Bash(curl *)", "Read(./.env)", "Read(./.env.*)", "Read(./secrets/**)"]
  }
}
```

Rules are tool-scoped with an argument pattern — `Tool(pattern)` — which is what
makes `Bash(npm run test *)` safe to allow while `Bash(curl *)` stays denied.

## Settings worth knowing

| Key | Purpose |
|---|---|
| `model` | primary model; read at startup, so changing it mid-session needs `/model` |
| `availableModels` | restrict which models may be selected |
| `env` | environment variables applied to all sessions |
| `permissions` | the allow/ask/deny rules above |
| `autoMemoryEnabled` | enable or disable auto memory |
| `alwaysThinkingEnabled` | extended thinking on by default |
| `effortLevel` | persist an effort level across sessions |
| `fastMode` | enable fast mode |
| `editorMode` | vim or normal key bindings |
| `allowedMcpServers` | MCP server allowlist — **managed scope only** |
| `claudeMd` | organization-wide memory — **managed scope only** |

The two managed-only keys are the enterprise-governance levers: an organization
can pin which MCP servers are reachable and inject standing instructions that no
project file can remove.

## Reload behavior

> "Claude Code watches your settings files and reloads them when they change, so
> edits to most keys apply to the running session without a restart."

`model` and `outputStyle` are the exceptions, needing a restart or `/model`. Use
`/status` to see which sources actually loaded.

## Managed-settings validation is tolerant by design

> "When a managed configuration contains an entry that fails schema validation,
> Claude Code strips that entry, records a warning, and enforces every remaining
> valid policy."

`/doctor` lists what was stripped. This partial-enforcement tolerance applies
**only** to managed settings — user, project, and local files remain strict. The
rationale is availability: one malformed key in a centrally-deployed policy
should not void every other policy in it.

# Citations

- [Claude Code settings](https://code.claude.com/docs/en/settings)

# See also

- [Claude Agent SDK overview](/knowledge/SWE/agentic/anthropic/claude-code-sdk/claude-agent-sdk-overview.md)
- [Claude Code cloud (CCR) — environment and orchestration architecture](/knowledge/SWE/agentic/anthropic/claude-code/cloud-environment-architecture.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:53f32a">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-cca-study-program-and-the-primary-source-miss (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:53f32a`]**  (co-feeds: `em:121acc em:3b0352 em:b4a91a em:038169`)

That changes the picture materially. Re-keyed to Anthropic's own scope statement, the brain is far thinner than my earlier figure suggested — **that 42% was keyed to the third-party blueprint and to conceptual overlap, and it overstated readiness.** The real position:

| Anthropic-named pillar | Filed knowledge | Verdict |
|---|---|---|
| Claude Code | 8 docs in its dir (mostly cloud-env sources); ambient mentions everywhere | thin on configuration specifics |
| Claude Agent SDK | **0 docs** in its dir, 11 passing mentions | near-empty |
| Claude API | **~0** — no filed knowledge on the API surface | empty |
| MCP | no dedicated dir, 25 incidental mentions | near-empty |

The brain is strong on agentic *concepts* and near-empty on the four *product surfaces* the exam actually names. That makes your ordering (gaps first) clearly right. Rewriting the plan against primary-sourced structure:
