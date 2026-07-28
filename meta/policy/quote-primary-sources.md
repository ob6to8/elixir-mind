---
type: policy
title: Quote primary sources verbatim
description: When a response or document leans on a source, reproduce the load-bearing phrase verbatim and immediately cite the artifact it came from, so a reader never has to wonder whether a phrase is quotation or the agent's synthesis.
section: communication
order: 3
status: active
tags: [meta, governance, quotation, provenance, citation, writing]
timestamp: 2026-07-28
attribution:
  when: 2026-07-26T21:51:55Z
  channel: agent-authored
  agent: "Claude Code agent, pseudocode-plans session"
  why: "operator ratified making verbatim-quotation-with-citation a standing rule after flagging an exemplary instance in a delivered response"
  from: [/meta/threads/2026-07-26-structured-plan-bodies-and-belief-layer.md, /meta/threads/2026-07-28-kimi-k3-weight-release-implications.md]
---
**Quote primary sources verbatim; mark the boundary between quotation and
synthesis.** When a delivered response or a document body leans on what a
source says — a policy, a doctrine, an external article or post, a code
comment, an operator message — reproduce the load-bearing phrase **verbatim**,
in quotation marks or a blockquote, and follow it immediately with a citation
of the artifact it was quoted from. A reader must never have to wonder whether
a phrase is the source's claim or the agent's synthesis: quoted text is the
source's, everything outside the quotes is the agent's, and the citation makes
the boundary checkable.

- **Citation form follows the surface.** Inside document bodies, cite by
  bundle-absolute markdown link (per
  [filenames-and-cross-linking](/meta/policy/filenames-and-cross-linking.md));
  in delivered responses, link per
  [response-resource-links](/meta/policy/response-resource-links.md) (live URL
  via `mix brain.url`, never a bare repo path); external sources cite their
  URL.
- **Never blend.** Do not paraphrase inside quotation marks, splice two
  passages into one quote, or silently normalize wording. An elision is marked
  (`…`); an insertion is bracketed. If only a paraphrase will fit, drop the
  quotation marks and let it stand as synthesis — attributed, but visibly not
  verbatim.
- **Take the quote from the source's own text, never from a summary of it.** A
  fetch that answers a question in prose can interpolate a comparison the source
  never made, and the interpolation is indistinguishable from a quotation once
  it is in your notes. Before a figure is quoted, or is used to back
  `verified: true`, re-read the source demanding the **verbatim span**; a span
  that cannot be produced does not get quotation marks. Whether the demand
  actually changes what a fetch returns is measured by the
  [fetch fidelity probe](/meta/evals/fetch-fidelity-probe.md).
- **Quote at the phrase, not the page.** The rule serves precision, not bulk:
  lift the shortest span that carries the claim. Wholesale copying stays
  governed by [capture-knowledge-cite-the-source](/meta/policy/capture-knowledge-cite-the-source.md).
- **Beliefs and claims extracted from sources** always retain the verbatim
  source phrase in their body alongside the citation (see the seed beliefs
  under [`/beliefs/`](/beliefs/index.md) for the pattern), so the extraction
  remains auditable against its origin.
