---
type: reference
title: 2026-08-03-mast-multi-agent-failure-taxonomy-intake
description: "/intake of the Berkeley MAST paper (arXiv 2503.13657, \"Why Do Multi-Agent LLM Systems Fail?\") as a reference under knowledge/SWE/evals/, a dedup gold-set harvest, and the close via /create-pull-request merge."
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-03; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped; parsed from the host session log"
tags: [meta, thread, intake, evals, multi-agent, mast, berkeley, agentic]
timestamp: 2026-08-03
session: https://claude.ai/code/session_012vz3HdRemY4cEYi1D7eTkf
pr: 241
---

# 2026-08-03-mast-multi-agent-failure-taxonomy-intake

## Where this landed

The operator ran `/intake` asking the agent to find "the Berkeley
multi-agent-failure taxonomy paper (evals)." The agent located arXiv
2503.13657, "Why Do Multi-Agent LLM Systems Fail?" (Cemri et al., NeurIPS
2025) — the MAST paper, building a 14-mode/3-category failure taxonomy for
multi-agent LLM systems from 1,600+ annotated execution traces — fetched
its abstract, HTML body (partially degenerating into repetitive noise past
the taxonomy table, but yielding the full 14 failure-mode names), and a
clean secondary abstract source, then deduped against the bundle (no
existing coverage) and filed it as a `reference` at
[`knowledge/SWE/evals/mast-multi-agent-system-failure-taxonomy.md`](/knowledge/SWE/evals/mast-multi-agent-system-failure-taxonomy.md)
(`em:ec728d`), following the same three-part layered-breakdown pattern as
the directory's existing FActScore/SAFE capture. A dedup gold-set row was
harvested for the operator's phrasing and the baseline refreshed (27% plain
recall, no regression). The change was committed and pushed to the session
branch. The operator then invoked `/create-pull-request merge` to close the
session out.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| MAST paper intake — 14-mode/3-category multi-agent failure taxonomy | closed | [MAST reference](/knowledge/SWE/evals/mast-multi-agent-system-failure-taxonomy.md) | - |
| Dedup gold-set harvest for this intake | closed | [dedup-probe gold set](/meta/evals/dedup-probe.md) | - |
| Commit, push, open and merge the PR | open | `unrouted` | PR not yet opened at capture time |

## User

<command-message>intake</command-message>
<command-name>/intake</command-name>
<command-args>
<routes ref="em:ec728d">
the Berkeley multi-agent-failure taxonomy paper (evals), see if you can find
</routes>
</command-args>

## Assistant

<routes ref="em:ec728d /meta/evals/dedup-probe.md">
Found and filed the paper the operator asked about. Here's the ledger:

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `reference` | [`knowledge/SWE/evals/mast-multi-agent-system-failure-taxonomy.md`](https://github.com/ob6to8/elixir-mind/blob/claude/berkeley-multi-agent-failure-taxonomy-xsdaai/knowledge/SWE/evals/mast-multi-agent-system-failure-taxonomy.md) (`em:ec728d`) | Captured/summarized external paper, following the same pattern as the existing FActScore/SAFE capture in the same directory |

**What I modified**

| File | Change |
|---|---|
| `knowledge/SWE/evals/index.md` | Added the new reference under `## References` |
| `meta/evals/dedup-probe.md` | Harvested one gold-set row (`the berkeley multi-agent-failure taxonomy paper` → `em:ec728d`) and refreshed the baseline |
| `meta/registry.md` | Regenerated after minting the new id |

**Actions I have taken**

| Action | Result |
|---|---|
| Located the paper | arXiv 2503.13657, "Why Do Multi-Agent LLM Systems Fail?" (Cemri et al., UC Berkeley + collaborators, NeurIPS 2025) — builds MAST, a 14-mode/3-category failure taxonomy from 1,600+ annotated multi-agent traces |
| Deduped | No existing bundle doc covers this specific paper or taxonomy (searched "multi-agent", "failure mode/taxonomy", "MAST", "agent eval") |
| Ran the gate suite | `mix brain.verify`, `brain.route_tags`, `brain.glossary`, `brain.matters`, `mix test` all pass (pre-commit hook ran them) |
| Dedup recall check | Plain recall held at 27% (8/30) — no regression, so no escalation needed |
| Committed and pushed | Branch `claude/berkeley-multi-agent-failure-taxonomy-xsdaai`, commit `acba4a0` |

The paper: UC Berkeley researchers found multi-agent LLM systems fail 41–86.7% of the time on benchmarks, and built a 14-failure-mode taxonomy across three categories (system design issues, inter-agent misalignment, task verification) from over 1,600 annotated execution traces. Their case studies show that fixing the *architecture* based on which failure mode dominates gains 9–16 points using the *same* underlying model — the ceiling is organizational, not raw capability. I cross-linked it in the doc to this brain's own material on the observer-subagent pattern, agent teams, scar-tissue drift, and the verification-grounding/gate-suite policies, since several of MAST's named modes map directly onto concerns already tracked here.

No new directory or type was needed — it fit cleanly into the existing `knowledge/SWE/evals/` reference collection. I have not opened a pull request since none was requested; the branch is pushed and ready if you want one.
</routes>

## User

<command-message>create-pull-request</command-message>
<command-name>/create-pull-request</command-name>
<command-args>merge</command-args>

*(Session continues past this point — the rest of the `/create-pull-request merge`
flow, run per its own skill, is recorded by the commit graph and the PR it opens
rather than in this render.)*
