---
id: em:c55c81
type: reference
title: "Claude Code model selection and delegation — where a skill's model comes from"
description: The mechanics of which model runs which work in Claude Code — the session model, the turn-scoped `model`/`effort` skill frontmatter, the four-step subagent resolution order, forked-skill delegation, and Anthropic's own two-question heuristic for choosing a model versus an effort level.
resource: https://code.claude.com/docs/en/model-config
provenance: "Official Claude Code documentation (model-config, skills, sub-agents) and the Anthropic blog post 'Choosing a Claude model and effort level in Claude Code' (2026-07-07), fetched and distilled 2026-07-31; model undisclosed"
tags: [claude-code, anthropic, model-selection, effort, subagents, skills, delegation, orchestration, harness]
timestamp: 2026-07-31T00:00:00Z
attribution:
  when: 2026-07-31T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator question on skill model selection"
  why: "operator asked how a skill's model is determined and how to delegate; no single reference covered the mechanics, so the primary sources were distilled into one"
---

# Claude Code model selection and delegation

A skill does **not** carry a model unless it says so. By default a skill's
instructions execute on whatever model the session is already running — so a
skill that usually does clerical work but occasionally hits something hard
(a conflicted merge, an ambiguous review) runs that hard step at whatever tier
happened to be selected when the operator typed the slash command. Every lever
below exists to break that coupling: pin the skill's tier, raise its effort, or
hand the hard step to a subagent chosen for it.

This is the mechanism half of
[capability-matched model selection](/meta/doctrine/capability-matched-model-selection.md),
which holds the principle (match the tier to the epistemic weight of the motion)
and deliberately binds no model names.

## The four places a model is decided

| Surface | Scope | How |
|---|---|---|
| **Session** | The whole conversation | `/model <alias\|name>`, `claude --model`, `ANTHROPIC_MODEL`, or the `model` setting |
| **Skill** | The rest of the invoking turn | `model:` and `effort:` in `SKILL.md` frontmatter |
| **Subagent** | One delegated task | `model:`/`effort:` in `.claude/agents/<name>.md`, or a per-invocation `model` parameter |
| **Forked skill** | One delegated task | `context: fork` + `agent:` — the agent type supplies the execution environment |

### Skill frontmatter — a turn-scoped override

The skills reference documents `model` as the

> "Model to use when this skill is active. The override applies for the rest of
> the current turn and is not saved to settings; the session model resumes on
> your next prompt. Accepts the same values as `/model`, or `inherit` to keep
> the active model."

`effort` is its sibling: the "[e]ffort level when this skill is active.
Overrides the session effort level. Default: inherits from session. Options:
`low`, `medium`, `high`, `xhigh`, `max`; available levels depend on the model."
([skills reference](https://code.claude.com/docs/en/skills))

Two consequences follow: the override lasts the **turn**, not the skill —
work the operator prompts for afterwards is back on the session model — and a
value excluded by an organization's `availableModels` allowlist is silently
skipped, leaving the session's current model in place.

`ultrathink` anywhere in the skill body is the cheaper, coarser lever: it
requests deeper reasoning for that run without touching model or effort.

### Subagent resolution order

For a subagent, the docs give an explicit precedence chain — highest first:

1. the `CLAUDE_CODE_SUBAGENT_MODEL` environment variable, when set to a model alias or model ID
2. the per-invocation `model` parameter
3. the subagent definition's `model` frontmatter
4. the main conversation's model

([sub-agents reference](https://code.claude.com/docs/en/sub-agents)) The
frontmatter field accepts an alias (`sonnet`, `opus`, `haiku`, `fable`), a full
model ID (`claude-opus-5`), or `inherit`; omitted, it **defaults to `inherit`**.
So a `.claude/agents/` file with no `model:` line is not neutral configuration —
it is an explicit inheritance of whatever the parent chose.

Subagents inherit the session's extended-thinking setting and have no per-agent
thinking control; `effort:` is the per-agent knob.

The built-in `Explore` agent is the one capped tier: it "inherits from the main
conversation, capped at Opus on the Claude API, so Explore never runs on a more
expensive model than the one you already chose for the session". A user or
project subagent named `Explore` overrides the built-in and keeps its own
`model` field — `model: haiku` is the documented way to hold exploration at a
low-cost tier.

### Delegating a step out of a skill

Two directions, and they load different things:

| Approach | System prompt | Task | Also loads |
|---|---|---|---|
| Skill with `context: fork` | From agent type | `SKILL.md` content | CLAUDE.md, except when the agent is `Explore` or `Plan` |
| Subagent with `skills` field | Subagent's markdown body | Claude's delegation message | Preloaded skills + CLAUDE.md |

With `context: fork`, the skill body *becomes* the subagent's prompt and the
`agent:` field "determines the execution environment (model, tools, and
permissions)" — which is exactly how a skill pins a tier for its own work
without pinning the session. The fork gets no conversation history, runs in the
background by default (`background: false` to wait in-turn), and a backgrounded
fork runs with the narrower background-subagent tool set.

The warning that comes with it: `context: fork` "only makes sense for skills
with explicit instructions" — a guidelines-style skill forked into a subagent
returns nothing useful, because the subagent receives conventions and no task.

**A whole skill is the wrong unit to fork when only one step is hard.** For a
skill that is mostly deterministic with one judgment-heavy branch, the finer
tool is a subagent spawned *at* that branch (with `model` set on the
invocation), leaving the clerical steps on the session model.

## Aliases, versions, and effort levels

Aliases track the recommended version and move over time; pin a full model name
(`claude-opus-5`) when the version itself matters.

| Alias | Behavior |
|---|---|
| `best` | Fable 5 where the organization has access, otherwise the latest Opus |
| `fable` | Claude Fable 5, "for your hardest and longest-running tasks" |
| `opus` | latest Opus, "for complex reasoning tasks" |
| `sonnet` | latest Sonnet, "for daily coding tasks" |
| `haiku` | "fast and efficient Haiku model for simple tasks" |
| `opusplan` | Opus during plan mode, then Sonnet for execution |
| `sonnet[1m]` / `opus[1m]` | 1M-token context window for long sessions |
| `default` | clears any override; reverts to the account-type or organization default |

On the Anthropic API, `opus` resolves to Opus 5 and `sonnet` to Sonnet 5;
other providers lag (Microsoft Foundry: Opus 4.6 / Sonnet 4.5).

Effort is the orthogonal axis — adaptive-reasoning depth, not capability:

| Model | Levels |
|---|---|
| Fable 5 | `low`, `medium`, `high`, `xhigh`, `max` |
| Opus 5, Sonnet 5, Opus 4.8, Opus 4.7 | `low`, `medium`, `high`, `xhigh`, `max` |
| Opus 4.6, Sonnet 4.6 | `low`, `medium`, `high`, `max` |

The default is `high` on every model that supports effort, except Opus 4.7
(`xhigh`). An unsupported level degrades to the highest supported level at or
below it, so `xhigh` runs as `high` on Opus 4.6 rather than erroring. `max` is
session-scoped; the other levels persist across sessions.

## Which model for which motion

Anthropic's own guidance is a **failure-driven heuristic, not a task-to-model
table**. From
[Choosing a Claude model and effort level in Claude Code](https://claude.com/blog/claude-model-and-effort-level-in-claude-code)
(2026-07-07):

- Smaller models (Sonnet) suit "edits you can describe precisely, mechanical
  changes, or questions about code".
- Larger models (Fable/Opus) suit "problems like subtle bugs, unfamiliar
  domains, or architecture decisions".
- "for most tasks you should use the model's default effort level".
- When output is wrong, the diagnostic question is "did it not try hard enough,
  or did it not know enough?" — not trying hard enough means raise effort
  ("Pick a higher effort level if Claude got it wrong by skipping a file, not
  running the tests, or not double-checking its work"); not knowing enough means
  a larger model ("If Claude has all the pertinent context and clearly tried and
  still got it wrong, that's a signal to pick a larger model").
- The upstream check: "If you're increasing effort on a task that shouldn't
  need it, the fix is often upstream, in your context, your CLAUDE.md, or how
  the task is scoped."

That last point is why a per-skill override is a deliberate act rather than a
default: reaching for a bigger model to compensate for a thin prompt buys the
symptom, not the cause.

# Citations

- [Model configuration](https://code.claude.com/docs/en/model-config) — aliases, provider resolution, effort levels, `availableModels`, `opusplan`.
- [Extend Claude with skills](https://code.claude.com/docs/en/skills) — frontmatter reference (`model`, `effort`, `context`, `agent`, `background`), forked-skill semantics.
- [Create custom subagents](https://code.claude.com/docs/en/sub-agents) — subagent frontmatter, model resolution order, built-in agent tiers.
- [Choosing a Claude model and effort level in Claude Code](https://claude.com/blog/claude-model-and-effort-level-in-claude-code) — Anthropic blog, 2026-07-07.
