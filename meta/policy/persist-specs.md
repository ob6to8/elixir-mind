---
type: policy
title: Persist specs and plans
description: Any design spec or implementation plan the agent produces and the operator approves must be persisted as a type:spec doc under meta/specs/, not left in chat or the scratchpad.
section: filing
order: 6
status: active
tags: [meta, governance, specs, plans, persistence]
timestamp: 2026-07-09
---
**Persist specs and plans; don't leave them in the conversation.** A design spec
or implementation plan is a durable record of *decisions and their rationale* —
the shape of a change, the alternatives weighed, and the build order. That record
must survive the session that produced it. Chat scrolls off and the agent
scratchpad is session-isolated and reclaimed, so a plan that lives only there is
lost the moment the session ends.

- **When.** Whenever the operator approves a spec or plan of any substance — a new
  subsystem, a genre or policy change, a multi-step build — persist it before
  acting on it. A throwaway one-liner is not a spec; a design worth a review pass
  is.
- **Where.** As a `type: spec` document under [`meta/specs/`](/meta/specs/index.md)
  (governance namespace — no `sb:` id, outside the identity registry, like
  `tutorials` and `threads`). Filename is a kebab-case slug of the title.
- **What it holds.** The problem, the decisions and their reasoning, the artifact
  shape, and the build order — plus any commissioned design review (e.g. a
  research spike) recorded with its verdict, so the *why-it's-shaped-this-way*
  travels with the plan. Deferred phases (things spec'd but not yet built) stay in
  the same doc under an explicit "deferred" heading until they graduate into their
  own spec when built.
- **Lifecycle.** A spec carries a `status` (`draft` · `approved` · `superseded`).
  Superseded specs are kept, not deleted — the decision history is the point.
- **Reserved files.** After adding or updating a spec, update
  [`meta/specs/index.md`](/meta/specs/index.md) and append a dated entry to the
  nearest `log.md`, same as any filed document.
