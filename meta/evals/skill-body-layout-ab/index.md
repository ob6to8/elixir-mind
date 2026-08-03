# skill-body-layout-ab — instrument artifacts

The pinned inputs and recorded outputs of the
[skill body layout A/B](/meta/evals/skill-body-layout-ab.md) eval, kept so the
2026-08-02 execution can be audited and the instrument re-run against a later
corpus or a different model tier. The eval doc beside this directory carries the
question, method, results, and findings.

## Contents

- `variant-a.skill.txt` — treatment A, the skill body as it stood at `075dc82`:
  prose lede, `## Dispatch`, six numbered top-level steps, `## Guardrails`. Kept
  as `.txt` because its frontmatter is skill frontmatter, not OKF frontmatter,
  and a `.md` here would be an unconformant bundle document.
- `variant-b.skill.txt` — treatment B, the same rule-set under labeled sections
  (`INSTRUCTION` · `ARGUMENTS` · `DISPATCH` · `DELIVERABLES` · `ARTIFACTS` ·
  `PROCEDURE` · `REMEMBER`), frontmatter byte-identical to A's.
- `grade.py` — the scorer. Reads `iteration-<N>/<eval>/<variant>/{run.json,outputs/}`
  beside itself, checks each assertion against the copied output files where a
  file can show the fact and against the run's self-report only where it cannot,
  and writes `grading.json`.
- `runs.json` — the eight runs' `run.json` records and timing, verbatim, from the
  2026-08-02 execution. Token and duration figures arrive only in a subagent's
  completion notification and are recoverable from nowhere else.
- `grading.json` — that execution's assertion-level results: 71/71 for both
  variants.
