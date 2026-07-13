---
id: sb:43244e
type: concept
title: argumentation framework (Dung)
description: Dung's abstract model of argument as a directed graph — a set of arguments and a binary attack relation — over which acceptability semantics compute which sets of arguments can rationally stand together.
provenance: "Agent-distilled glossary definition, pointer to the defining doc"
verified: false
tags: [glossary, argumentation, dung, conflict, semantics]
timestamp: 2026-07-11
---

# argumentation framework (Dung)

Dung's (1995) abstract model of argumentation: a pair ⟨A, R⟩ of a set of
arguments and a binary **attack** relation, viewed as a directed graph whose
node contents are ignored — only the attack topology matters. Acceptability
semantics ([grounded](/glossary/grounded-extension.md), preferred, stable,
complete extensions) compute which conflict-free, self-defending sets of
arguments can rationally coexist. Unlike support/derivation edges, the attack
relation is *not* acyclic — mutual attack is normal — which is why a belief
graph keeps conflict in a separate Dung-style relation rather than folding it
into the derivation DAG. Canonically covered in
[Dung's abstract argumentation frameworks](/knowledge-management/argumentation/dung-abstract-argumentation-frameworks.md).

*Seen in:* [Dung frameworks reference](/knowledge-management/argumentation/dung-abstract-argumentation-frameworks.md), [Dung 1995 capture](/knowledge-management/argumentation/dung-1995-acceptability-of-arguments.md), [belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md)
