---
type: plan
title: "Spec→code traceability: each brain.* task names the policy it enforces"
description: Wire a checkable edge from every mix brain.* verification task back to the policy document it enforces, and generate the policy→enforcement view from it, so a policy with no enforcement and a task enforcing nothing both become visible instead of being discovered by accident.
status: proposed
provenance: "Claude Code session (2026-07-20) — raised during the intent-as-source and dark-factory pricing discussion, and left unfiled"
tags: [meta, plan, tooling, policy, traceability, gates]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from an untracked routing-ledger strand whose approach needed deciding rather than only doing, so it files as a plan rather than a todo"
  from: [/meta/threads/2026-07-20-intent-as-source-and-dark-factory-pricing.md, /meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md]
---

# Spec→code traceability

## Problem

The contract states rules; `mix brain.*` tasks enforce some of them. Which rules
map to which tasks is knowledge that exists only in a reader's head.

Two failure modes follow, and neither is currently detectable:

- **A policy with no enforcement** looks identical to an enforced one. The
  contract is loaded in full every session, so an agent reads a rule and assumes
  it is checked — the strongest form of this brain's own
  [invisible degradation](/beliefs/glossary/invisible-degradation.md).
- **A task enforcing nothing** — or enforcing a rule the policy no longer states —
  survives a policy rewrite silently. The gate stays green while the thing it was
  built to protect has moved.

[elixir-coding-standards](/meta/policy/elixir-coding-standards.md) already draws
the line this plan makes legible: "every standard with a **mechanical oracle** is
a gate; standards without one are written here." That split is real and correct.
What is missing is any way to *see* it — to ask which side of the line a given
policy sits on without reading `ci.yml` and every task's source.

## The shape of the change

**Current state — the edge exists only in prose:**

```
meta/policy/route-tagging.md      (states the rule)
        ⋮  (no machine-readable link)
lib/elixir_mind/route_tags.ex     (enforces some of it)
        ↑
.github/workflows/ci.yml          (runs it)
```

**Desired state — the edge is declared on the enforcing module:**

```
meta/policy/route-tagging.md  ←──┐  @enforces "meta/policy/route-tagging.md"
lib/elixir_mind/route_tags.ex ───┘
        ↑
.github/workflows/ci.yml
        ↓
meta/enforcement-map.md          # NEW, generated: policy → task → gate status
```

**File-tree diff:**

```
+ lib/elixir_mind/enforcement.ex        # NEW  collect @enforces attrs, resolve, render
+ lib/mix/tasks/brain.enforcement.ex    # NEW  mix brain.enforcement [--check]
+ meta/enforcement-map.md               # NEW  generated view
~ lib/elixir_mind/*.ex                  # MODIFIED  add @enforces to enforcing modules
~ .github/workflows/ci.yml              # MODIFIED  add the freshness gate
```

**Signatures:**

```elixir
@spec map(root :: String.t()) :: [entry()]
@spec render(entries :: [entry()]) :: String.t()
@spec unenforced(root :: String.t()) :: [policy_path :: String.t()]
```

**Boundary decisions:**

- The **module** declares what it enforces — the claim belongs next to the code
  making it true, not in a registry that drifts.
- The **generator** resolves and renders; it never edits policies.
- The **gate** checks freshness of the generated view only, matching every other
  generated artifact here (`--check` in CI, generate locally, never hand-edit).

**Anchors.** Follow `ElixirMind.CodeMap`, which already compiles
[`meta/code-map.md`](/meta/code-map.md) from moduledocs — same collect-resolve-render
shape, same `--check` freshness gate, same never-hand-edit discipline. The
enforcing modules today are `Verifier`, `RouteTags`, `Glossary`, `Links`,
`Contract`, `Registry`, `CodeMap`, `Lineage`, `DevHistory`. Tests go through the
mix-task boundary per the testing methodology.

## Decisions

**Recommended shape: a module attribute, resolved at compile time.** `@enforces`
sits beside the code, cannot be forgotten in a separate file, and is collectable
without parsing prose.

**Rejected — frontmatter on the policy naming its enforcer.** It inverts the
dependency: a policy is a statement of intent and should not know which code
happens to check it, and a policy outliving its enforcer is exactly the case that
must stay visible rather than becoming a broken reference.

**Rejected — policy-derived conformance tests** (generating property tests from
policy text). This was the second half of the original strand. It needs the policy
corpus to be machine-readable in a way it is deliberately not — the policies are
prose for agents to read, and making them a formal source would trade the thing
that makes them work for a checkable form. Recorded as considered and declined.

**Open questions.**

- Does a partially-enforced policy declare the edge? Most gates check *part* of a
  rule. Proposal: declare it, and let the view carry a `partial` marker rather
  than pretending coverage is binary.
- Should an unenforced policy warn? It is a legitimate state — most policies have
  no oracle. Proposal: report the count, never warn, or the noise trains agents to
  ignore it.
- Does this clear the [admission rule](/meta/policy/elixir-coding-standards.md)?
  It is offline and dependency-free, so the second half holds. Whether its signal
  beats its upkeep at nine modules is the real question, and is the thing to
  settle before building.
