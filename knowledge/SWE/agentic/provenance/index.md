# Provenance

Trust and provenance layers for content and code that move through agentic
pipelines — tracking where a claim or a contribution came from, how much to
trust it by the time it's served, and what the record must carry to be
auditable afterward.

## Documents

- [Persisting prompts with pull requests — the 2026 landscape](/knowledge/SWE/agentic/provenance/prompt-persistence-and-pr-association.md) — research spike on whether prompts are saved, associated with pull requests, and committed to open-source repos: tool-identity disclosure converged on the `Assisted-by:` trailer, prompt persistence did not converge at all, every standard that touches prompts references them by URL rather than embedding them, and agent compliance rather than mechanism is the binding constraint.
- [ISNAD — an isnād–rijāl framework for claim-level provenance in multi-agent systems](/knowledge/SWE/agentic/provenance/isnad-rijal-claim-level-provenance.md) — a hadith-derived framework (paper + Python library) that grades transmitters, computes weakest-link chain trust, checks corroboration independence, and routes claims to serve/review/quarantine.
- [Reddit thread — "~1,400 years ago, scholars solved a problem multi-agent AI just re-invented"](/knowledge/SWE/agentic/provenance/isnad-reddit-discussion-thread.md) — verbatim capture of the ISNAD author's announcement and its discussion thread on r/AgentsOfAI, primary source for the rijāl-grading and chain-independence critiques.
