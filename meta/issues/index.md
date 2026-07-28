# Issues

Tracked operational problems, defects, and open concerns about how the brain or its
tooling and automation behave — recorded for future reference and follow-up. A
separate namespace from `policy` (the rules that compile into the contract) and
`tutorials` (the "why" explainers).

Each issue is a `type: issue` doc carrying a `status` (`open` · `resolved` ·
`wontfix`). Resolved issues stay filed as a record of what happened and how it was
fixed. Entries within each section are ordered by `timestamp`, most recent first
(see the [collection-view-by-date plan](/meta/plans/collection-view-by-date.md)).

## Open

- [Dev-history regeneration silently no-ops for a whole session when its clone is shallow](/meta/issues/dev-history-regeneration-silently-skipped-on-shallow-clones.md) — both `mix brain.dev_history` and its `--check` exit zero on a shallow clone, which is what web sessions get, so the regeneration never runs and the gate meant to catch the drift is blind in the same environment and the same run. Measured across the 18 PRs since step 4 existed, the outcome **clusters perfectly by session, not by PR** (one branch 5/5 misses, two others 3/3 and 2/2 hits), and the single session that changed behavior mid-flight did so exactly when it ran `git fetch --unshallow` — which rules out sporadic agent-skip as the dominant cause. Still accumulating: #161 and #163 both missed after the file was brought current. Three candidate fixes weighed (loud skip / unshallow in step 4 / regenerate outside the session), none chosen. `status: open`.
- [Generated/shared artifacts are recurring merge-conflict magnets across parallel sessions](/meta/issues/generated-artifact-merge-conflicts.md) — worktree isolation prevents working-tree collisions but not merge-level ones; parallel sessions that each regenerate `CLAUDE.md`, [`registry.md`](/meta/registry.md), `code-map.md`, or a derived `index.md` 3-way-conflict at merge time (PRs #97/#98). Fix is rebuild-on-merge (a merge driver or a post-merge regeneration step) plus laning by domain, not hand-merging re-derivations. Surfaced by the [version-control audit](/meta/analysis/version-control-workflow-vs-trunk-based-reference.md). `status: open`.
- [Orphaned remote branches: 15 merged undeleted, 6 unmerged untriaged](/meta/issues/orphaned-remote-branches-cleanup.md) — merged-branch deletion **executed by the operator 2026-07-13** (zero merged `claude/*` remain); unmerged-branch dispositions audited into the [triage todo](/meta/todos/triage-the-six-kept-unmerged-claude-branches.md) (four small ports + one big transplant, two false orphans to ratify deleting); resolves once the auto-delete setting is confirmed on. `status: open`.
- [Daily /research Routine: automated runs not landing on `main`](/meta/issues/daily-news-routine-runs-not-landing.md) — the scheduled Routine's fresh-session runs produce no commit/push; an environment-wide tool-approval gate is the suspected cause. Workaround: run `/research` manually. `status: open`.
- [Policy index glosses drift silently when a policy's rule changes](/meta/issues/policy-index-glosses-drift-on-policy-edits.md) — a policy edit that changes the rule leaves its one-line gloss in [`meta/policy/index.md`](/meta/policy/index.md) advertising the superseded version; [maintain-reserved-files](/meta/policy/maintain-reserved-files.md) covers only *filing* a new doc, and every freshness gate targets a *generated* artifact, so the hand-kept policy index sits outside all of them. Observed in-session on the branch-deletion policy. Three candidate fixes weighed (state the rule / add a check / generate the gloss). `status: open`.
- [The stop hook flags every unsigned commit reachable from the branch](/meta/issues/merge-commits-show-unverified-and-trip-the-git-hook.md) — merge-button commits *and* ordinary agent commits, including other sessions' work already on `main`, since the harness signs nothing and the hook reports reachable-from rather than added-by; it proposes amending them, which would rewrite the provenance [merge-strategy](/meta/policy/merge-strategy.md) protects, on a condition that policy already classifies as expected. Three firings observed, one on a clean tree zero commits ahead. `status: open`.

## Resolved

- [route_tags: materialize cannot remove orphaned excerpt blocks](/meta/issues/route-tags-materialize-leaves-orphan-blocks.md) — `materialize/1` now projects the tags in both directions, removing an unfed sink's log section unconditionally (hardening plan P1); pinned by two scenario tests. `status: resolved`.
