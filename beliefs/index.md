# beliefs

The brain's **belief layer**: operator-held, value-laden decision priors —
statements held *true enough to guide action* even where unverifiable, uncertain,
or normative. Each belief is a `type: belief` bundle document with its own `em:`
id, citable by plans, analyses, and priority rankings the way doctrine is. Where
a [doctrine](/meta/doctrine/index.md) is the brain's own standing direction
(governance-scoped), a belief is about how the *world* works. Beliefs sit outside
the verification ladder — one that turns out to be empirically checkable is
refiled as a `claim`. The layer was ratified from the
[belief-layer plan](/meta/plans/belief-type-and-beliefs-namespace.md); atomic
beliefs are extracted from compound statements per the
[/extract-into-belief skill plan](/meta/plans/extract-into-belief-skill.md).
Where this layer sits relative to the descriptive types and to doctrine — and
why a *value-laden* belief type escapes the collision that ruled out a
*descriptive* one — is worked out in the
[is-to-ought analysis](/meta/analysis/is-to-ought-belief-grounds-doctrine.md).

## Beliefs

- [A spec detailed enough to reliably generate quality code is roughly as long as the code](/beliefs/spec-detail-approaches-code-length.md) —
  Dex Horthy's thesis bounding how detailed a plan or spec should get before it
  stops paying for itself. `em:1eebdf`
- [Don't review code-length specs](/beliefs/dont-review-code-length-specs.md) —
  the prescriptive consequence: an artifact as detailed as the code is reviewed
  *as* code, once, not twice. Depends on the spec-length belief. `em:0c4913`
- [Plan artifacts surface decisions otherwise made implicitly at code review](/beliefs/plan-artifacts-surface-implicit-review-decisions.md) —
  each program-design artifact (call-stack tree, file-tree diff, type signatures)
  is a decision relocated from the most expensive point to the cheapest. `em:6c7e85`
- [Plan artifacts compress the decisions and leave the bodies to the agent](/beliefs/plan-artifacts-compress-decisions-not-bodies.md) —
  structured plan artifacts encode interfaces, layout, and call order exactly,
  while leaving function bodies to implementation. `em:a96688`
- [Coverage and quality must be measured jointly, or degradation hides behind availability](/beliefs/coverage-and-quality-must-be-measured-jointly.md) —
  an evaluation scoring only whether a system answered cannot see a system whose
  answers got worse; multiply the quality factor in and let unusable output score
  zero. `em:06de36`
- [Review is not an oracle](/beliefs/review-is-not-an-oracle.md) — inspecting
  generated output cannot establish correctness however often it is repeated;
  only a check independent of the output settles it. Governs *what counts as
  checked*, where the coverage belief governs *what to measure*. `em:2ecdd2`
- [An instrument without a control measures itself](/beliefs/an-instrument-without-a-control-measures-itself.md) —
  a harness never run against a known-answer case cannot tell a finding from a
  defect in itself, because a broken instrument returns plausible results rather
  than obviously wrong ones. The review-is-not-an-oracle prior turned on the
  measuring apparatus. `em:763494`
- [The scar-tissue lens is the right frame for reasoning about agent failure modes](/beliefs/scar-tissue-lens-for-agent-failure.md) —
  the operator's adopted working frame: agent failure as trauma-like accumulation
  of adaptive local fixes, chosen over rival frames that fit the same facts;
  the bound-adaptation doctrine is its governance-side consequence. `em:f35b8f`
- [A surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md) —
  the prior behind preferring generation over discipline: an obligation to update
  a hand-kept surface is carried by memory, which fails silently, while a derived
  surface cannot fall out of date because nothing is being remembered. Depends on
  [freshness gate](/beliefs/glossary/freshness-gate.md).

## Vocabulary & scratch

- [glossary](/beliefs/glossary/index.md) — running glossary of technical terms used
  across the brain: one concept file per term, individually linkable, with
  citations back to the threads, papers, and posts each was seen in; accreted by
  [`/add-to-glossary`](/.claude/skills/add-to-glossary/SKILL.md)
  (hub: [glossary.md](/beliefs/glossary.md))
- [Future beliefs](/beliefs/future-beliefs.md) — a running scratch list of facts
  and observations about the brain's tooling and governance worth formalizing
  later (into a tutorial, policy, or concept). `em:1b3c79` _(note)_
