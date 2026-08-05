# Governance

Enforcement mechanisms for agent-produced work: typed models as the binding
layer between prose and code, checking properties at the abstraction level
where they're legible, and definitions of done for agent-dispatched work.

## Documents

- [Instruction conflict across composed context sources has no mechanical oracle](/knowledge/SWE/agentic/governance/instruction-conflict-has-no-mechanical-oracle.md) — contradictions between system prompt, skills, memory files, and the user request raise no error, so the class is caught by reading transcripts rather than by validation; `/doctor` audits structure and context cost, never semantic agreement, and four properties (no error surface, an ephemeral composed set, semantic rather than syntactic clash, and unencoded override intent) make the check genuinely resistant. Separates the two layers the phrase "layered configuration" conflates — settings merge deterministically in code, instructions merge not at all — so reliability is bought by moving a rule to the enforcing layer, never by wording it more emphatically. `em:ed8315` _(claim)_
- [Models and the semantic gap (MAGE, ch. 2.2)](/knowledge/SWE/agentic/governance/models-and-the-semantic-gap.md) — typed models as the compact, checkable binding layer between prose and code, valid only when authored independently of the code as a spec (not derived from it as a mirror); governance checks must fire where a property becomes legible, not below it. `em:e4d9cf` _(reference)_
