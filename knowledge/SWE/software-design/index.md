# software-design

Software design patterns, architectural styles, the trade-offs between them,
and the practice of the architect who reasons about those trade-offs.

## Contents

- [The architect as amplifier — Gregor Hohpe on architecture practice](/knowledge/SWE/software-design/the-architect-as-amplifier.md) — the architect's job as risk reduction and capability multiplication rather than decision authority: frame the solution space before arguing inside it, sketch to elicit, spend political capital on one thing, and judge architectures as suitable rather than good.
- [Entity Component Systems in Elixir (Yos Riady)](/knowledge/SWE/software-design/entity-component-systems-in-elixir.md) — Riady's 2016 walkthrough of the ECS pattern (composition over inheritance, taught through a class hierarchy breaking on a Killer Bunny) and a proof-of-concept Elixir implementation mapping components to Agents and systems to reducer modules.
- [You can't design software you don't work on (Sean Goedecke)](/knowledge/SWE/software-design/you-cant-design-software-you-dont-work-on.md) — good software design requires intimate knowledge of the system's concrete details: concrete factors dominate generic principles in real work, so real design happens among the engineers who work the code, and detached architects escape accountability.
- [Unified Modeling Language (UML) — introduction](/knowledge/SWE/software-design/unified-modeling-language-introduction.md) — an ISO-standardized visual notation for documenting design ahead of implementation, split into structural diagrams (static elements) and behavioral diagrams (interaction over time).
- [The One Ring Problem: Abstraction and Power (Ted Kaminski)](/knowledge/SWE/software-design/the-one-ring-problem-abstraction-and-power.md) — a trade-off law for abstraction design: power and properties move in opposite directions, and the common failure is adding power to fix a limitation without noticing the properties it costs.
- [We replaced our ledger with two functions (River)](/knowledge/SWE/software-design/we-replaced-our-ledger-with-two-functions.md) — an Elixir ledger rewrite collapsing a ~40-function imperative API into two functions backed by declarative per-event balance rules, database-enforced double-entry invariants, and a zero-downtime shadow-mode migration.
- [The Tower Keeps Rising (Armin Ronacher)](/knowledge/SWE/software-design/the-tower-keeps-rising.md) — AI coding agents remove the coordination friction that used to force engineers to share a mental model of a system, so a codebase can keep growing after that shared understanding has quietly collapsed.
