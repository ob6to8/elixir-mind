---
type: plan
title: "Policy-canonical skill guidance: decisions live in policy, skills carry marked duplicates"
description: Port every skill to the model where behavioral rules and decisions are encoded canonically as policy and each SKILL.md carries the operational procedure plus explicitly-marked duplicate statements of the rules it obeys, each with provenance to its canonical policy source.
status: accepted
provenance: "Claude Code session (claude-fable-5), 2026-07-26 — the operator's Q1 in the pseudocode-plans session ('intuitively it feels to me to be the latter'), agreed by the agent with the identity/rules distinction recorded here"
tags: [meta, plan, skills, policy, canonicalization, drift, provenance]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:51:55Z
  channel: agent-authored
  agent: "Claude Code agent, pseudocode-plans session"
  why: "operator directed authoring this plan after the agent agreed decisions belong in policy with skills carrying qualified duplicates"
---

# Policy-canonical skill guidance: decisions live in policy, skills carry marked duplicates

## Problem

Skills currently mix two kinds of content: the **operational procedure** (the
steps an agent executes) and **behavioral rules** — decisions about how the
brain works that happen to be enforced at skill-execution time. Where a rule
lives only in a `SKILL.md`, it is invisible to the contract compile, uncited by
other docs, and drifts silently when the policy landscape changes around it.
The operator's verdict (2026-07-26 session, Q1): guidance decisions should be
"encoded as policy, compiled or copied (with qualifications that they are
duplicate statements, along with provenance to the source) into the skill."

**The boundary this plan respects:** the
[compile-skills-registry plan](/meta/plans/compile-skills-registry-from-skill-frontmatter.md)
makes each skill's *identity* (`name` + `description` frontmatter) canonical in
`SKILL.md`, compiled *into* the contract. That direction is correct and
unchanged — identity and description are facts *about the skill*. This plan
covers the opposite flow for *rules*: decisions about the brain are canonical
in `meta/policy/`, quoted *into* skills. The two compiles run in opposite
directions over disjoint content, and together they eliminate both drift
classes.

## Target shape

```
meta/policy/<rule>.md                 # canonical: the decision + rationale
  │  (compiled into /CLAUDE.md by mix brain.contract, as today)
  └── quoted into .claude/skills/<name>/SKILL.md
        > "…the rule, verbatim…"
        > (duplicate statement — canonical: /meta/policy/<rule>.md)
```

Skill-side convention, per
[quote-primary-sources](/meta/policy/quote-primary-sources.md): the rule text
is reproduced **verbatim** in a blockquote, immediately followed by the
qualification marker naming its canonical policy path. A skill never
paraphrases a rule it obeys — paraphrase is where drift starts.

## The flow of a rule change, after the port

```
edit meta/policy/<rule>.md
├── mix brain.contract            # CLAUDE.md regenerated (existing gate)
├── grep skills for the rule's canonical marker
│     └── update each quoting skill's blockquote to the new verbatim text
└── commit source + artifact + quoting skills together
```

## File-tree diff

```diff
 .claude/skills/<each>/SKILL.md   # MODIFIED — rule prose replaced by verbatim
~                                 #   policy quotes + canonical markers;
                                  #   procedure steps unchanged
 meta/policy/
+├── <extracted-rule>.md          # NEW — only where a skill held a rule with
+│                                #   no existing policy home
~└── <existing>.md                # MODIFIED — absorb skill-held rule variants
                                  #   where a home already exists
 CLAUDE.md                        # REGENERATED
```

## Build order

1. **Audit pass** — for each of the ~15 skills, table its rule-bearing
   sentences against the policy corpus: already-policy (quote it), policy
   exists but diverged (reconcile — the divergence is a live drift bug, fix in
   policy first), or no policy home (extract a new policy doc; new policies
   are ratified per the contract, so batch these for one operator pass).
2. **Pilot on `/capture`** — the heaviest rule-carrier
   (retention/verbatim/dialog-box rules already mirrored in the
   session-capture policy); its port proves the marker convention.
3. **Sweep the remaining skills**, one commit per skill.
4. **Recompile the contract**; update the skills-registry policy only if the
   audit changes any skill's description.

## Decision list

- **Recommended:** manual quoted duplicates with canonical markers now; the
  marker format (`canonical: <path>`) is chosen to be mechanically greppable.
- **Alternatives rejected:** skills as canonical rule homes (invisible to the
  contract compile; the drift class this plan kills); pointer-only skills with
  no duplicated text (a skill must be executable from its own text without a
  second read — progressive disclosure); building a `mix brain.skills`
  include-compiler *now* (mechanism before evidence; the greppable marker
  makes a later compiler a mechanical upgrade).
- **Open questions:** whether the marker convention deserves a verifier warn
  (marker path must resolve — cheap, same class as `from` ref resolution);
  whether quoted rule blocks should carry the policy's `timestamp` to make
  staleness greppable; where the audit table itself is filed (`meta/analysis/`
  vs. an appendix on this plan).
