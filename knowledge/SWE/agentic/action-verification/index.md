# Action verification

Confirming that an agent's **state-changing actions actually landed** in the
systems they targeted. The concern is distinct from evaluating an agent's output
or observing its run: a trace, an eval, and a guardrail all read material the
agent produced, so none of them can detect a write that silently no-opped. What
answers the question is a separate read against the system of record — the
read-back — and the discipline of treating that read's provenance as seriously as
its result.

Distinct from [provenance](/knowledge/SWE/agentic/provenance/index.md), which
grades *claims* moving through a pipeline, and from
[evals](/knowledge/SWE/evals/index.md), which score output quality. This
directory is about the gap after the action.

The priors extracted from this material live in the belief layer —
[a completion claim is not evidence of completion](/beliefs/completion-claims-are-not-evidence-of-completion.md)
and
[only what the other side produced is evidence](/beliefs/only-what-the-other-side-produced-is-evidence.md) —
and their application to this repo is the
[post-action read-back plan](/meta/plans/post-action-readback-in-the-development-flow.md).

## Documents

- [Reddit thread — "Your agent says 'done.' You check and nothing actually happened." (r/AgentsOfAI)](/knowledge/SWE/agentic/action-verification/agent-says-done-reddit-discussion-thread.md) — verbatim capture of the post and its comment thread: silent no-ops, why the observability layer is testimony rather than evidence, and the read-back, receipt, and delayed-reconciliation patterns proposed against them. The only reachable copy — the page itself refuses unauthenticated reads.
