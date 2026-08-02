---
type: policy
title: Controlled type vocabulary
description: The bundle uses a controlled, deliberately-growing list of document `type` values; the operator ratifies additions.
section: type-vocabulary
order: 1
status: active
tags: [meta, governance, types, vocabulary]
timestamp: 2026-08-02
attribution:
  when: 2026-07-05T12:30:48+00:00
  channel: backfill
  agent: "reconstructed by mix brain.attribution --backfill, 2026-07-13"
  from: [/meta/threads/2026-07-05-greenfield-okf-bootstrap-and-verification-layer.md, /meta/threads/2026-07-13-resource-attribution-property-spec-and-build.md, /meta/threads/2026-07-26-structured-plan-bodies-and-belief-layer.md, /meta/threads/2026-07-27-secure-financial-agent-and-projects-namespace.md, /meta/threads/2026-08-02-matter-type-vocabulary-adoption.md]
---
OKF requires a `type` but registers no vocabulary. This bundle uses a **controlled
list** so the brain stays queryable. It **grows deliberately** — an agent may
propose a new type, but the operator ratifies additions (same as directories).

Seed vocabulary:

- `note` — a distilled idea, observation, or thought.
- `claim` — a statement **asserted but not independently verified** (track status with
  the `verified` field; may graduate to `concept` once confirmed).
- `concept` — a definition or mental model (established/accepted).
- `reference` — external material you have **captured and summarized** (article, doc,
  video, thread). A bare URL becomes a `reference` only once processed.
- `source` — a primary source citation (paper, book, dataset).
- `person` — a person.
- `project` — an active, goal-bounded effort. Used for a system built *outside*
  this repo that incubates here: the hub doc for its specs, research, and design
  decisions, carrying a `status` (`incubating`/`active`/`broken-out`/`dormant`/
  `abandoned`). Distinct from an `area` (ongoing, no end state) and a `plan` (one
  intended change, not a whole system) — a project is a *bounded effort with its
  own body of work* (lives at `projects/<slug>.md`, beside a `projects/<slug>/`
  directory; see the projects-namespace policy).
- `area` — an ongoing responsibility or domain (no end state).
- `snippet` — a reusable command, code fragment, or template.
- `methodology` — a repeatable, prescriptive procedure or playbook: the distilled
  *how-to* for carrying out a recurring task (distinct from a `note`, which merely
  records an idea, and a `concept`, which defines a mental model).
- `visualization` — a **self-contained interactive page** the reader launches to
  manipulate a model directly: an explorable explanation, a live diagram, a
  parameter sweep. Filed as a **document pair** — the `.md` carries the `em:` id,
  the prose, and a `launch` field naming its **same-slug sibling `.html`**, which
  holds the artifact itself (inline CSS and JS, classic `<script>`, no `fetch`, no
  ES modules, no external hosts, so it opens over `file://` with no build step or
  server). Distinct from a `snippet` (a fragment to paste elsewhere, not a page to
  open), a `methodology` (the *how-to* for building one — see
  [explorable-explanations](/knowledge/knowledge-management/technical-communication/explorable-explanations.md)),
  and a `reference` (a capture of *someone else's* material, whereas a
  visualization is authored here). Filing test: *if the reader manipulates it, it
  is a `visualization`; if they read about manipulating it, it is a
  `methodology` or `reference`.* Machine-checked — `mix brain.verify` rejects a
  missing `launch`, or one whose target is absent, non-sibling, or not `.html`.
- `policy` — a governance rule for how the brain operates; the source from which
  `CLAUDE.md` is compiled (lives under `meta/policy/`).
- `tutorial` — a long-form explanatory note meant to be read start to finish (the
  "why"/"how" behind the tooling or a topic); distinct from a terse `note` and from
  a `reference` capture of external material (lives under `meta/tutorials/`).
- `issue` — a tracked operational problem, defect, or open concern about how the
  brain or its tooling/automation behaves, recorded for future reference and
  follow-up. Carries a `status` (`open`/`resolved`/`wontfix`); distinct from a
  `policy` (a rule) and a `note` (a distilled idea) — an issue is a *problem to
  track* (lives under `meta/issues/`).
- `plan` — intended work on the brain or its tooling: a design/decision record for a
  proposed change, capturing motivation, the shape of the change, scope boundaries,
  and open questions, so a future session can execute it. Carries a `status`
  (`proposed`/`accepted`/`in-progress`/`done`/`superseded`); distinct from an `issue`
  (a *problem* to track) and a `methodology` (a *repeatable* how-to) — a plan is a
  *one-off intended change*. Addressed by what it governs: a plan for **this brain
  or its tooling** lives under `meta/plans/`; a plan for a system built **outside**
  this repo lives under `projects/<slug>/` (see the projects-namespace policy).
- `analysis` — a point-in-time evaluation or decision-support write-up: a question
  investigated against evidence (often the live bundle itself), yielding findings and
  a recommendation, filed so the reasoning and its conclusion persist. Distinct from a
  `plan` (intended *work* to execute), a `tutorial` (explanatory *how/why*), and a
  `note` (a distilled idea) — an analysis is a *reasoned judgment on a question*
  (lives under `meta/analysis/`).
- `matter` — the review-quantized unit of work: one coherent intent a
  reviewer can approve or reject as a whole (one matter per PR, per
  [atomic pull requests](/meta/policy/git-atomic-pull-requests.md)), filed
  as a self-contained handoff packet — the intent plus the decisions already
  made, with refs carrying the detail — so a fresh thread can deliver it.
  Spans the scale from a plain small task (a title, a sentence of packet)
  to a plan-emitted build step. Carries a `status`
  (`open`/`done`/`cancelled`); when a plan's build order
  emits it, also a `plan` (the bundle-absolute path of that plan) and an
  `order` (integer position in that plan's own sequence) — both keys omitted
  on a standalone matter. Queued-ness is register membership, never a
  status: an open matter listed in [the matter register](/meta/matters.md)
  is committed and globally ordered; an open matter outside it is **backlog**
  (filed, awaiting queueing or pickup). Distinct from a `plan` (a *decision
  record* whose build order emits matters — a matter is the delivery unit
  itself and needs no plan behind it), an `issue` (a tracked *problem* that
  may never become work; an issue spawns a matter when its fix is decided),
  and a `methodology` (a *repeatable* how-to — a matter is done once) — a
  matter is *work to deliver, shaped to fit review* (lives under
  `meta/matters/`, governance namespace, no `em:` id).
- `elaboration` — a persisted expansion of a technical **phrase or short passage**:
  the quoted target, definitions of the terms it uses, and a less technical overview
  of the concepts and actions it describes — produced by `/elaborate` and back-linked
  to its originating session via `attribution.from` once that session is
  captured (`/create-pull-request` stamps it). Distinct from a glossary `concept` (one
  *term*, source-independent) and a `tutorial` (long-form, standalone subject) — an
  elaboration unpacks *one specific mouthful in context* (lives under
  `meta/elaborations/`).
- `doctrine` — a persisted **intention statement**: a guiding principle or direction
  that shapes how the brain and its agents are designed and prioritized — the "why"
  that informs judgment without prescribing a specific enforceable action. Doctrine
  sits *above* policy: a `policy` implements doctrine as a concrete, machine- or
  operator-enforceable rule, and plans, analyses, and priority rankings may cite a
  doctrine as the direction they serve. Distinct from a `policy` (an enforceable
  *rule*), an `analysis` (a *reasoned judgment on a question*), and a `note` (a
  distilled *idea*) — a doctrine is a *standing direction* (lives under
  `meta/doctrine/`). Filing test: teleological (*what standing direction the brain
  serves*) files as `doctrine`; a value-laden prior about the world files as
  `belief`.
- `belief` — an operator-held, value-laden **decision prior**: a statement held
  *true enough to guide action* even where unverifiable, uncertain, or normative.
  Sits **parallel to `doctrine`**, not beneath it — a belief is
  epistemic-with-values ("I hold that the world works this way"), a doctrine is
  teleological (the brain's own standing direction). A `belief` stays **outside
  the verification ladder**: it never carries `verified`; one that turns out to be
  empirically checkable is refiled as a `claim` (and may then graduate) — the type
  boundary *is* the test. Distinct from a `claim` (on the verification ladder,
  expects evidence) and a `note` (not citable as a prior). Filing test:
  *epistemic (what is true) files as `claim`/`concept`; value-laden prior (what I
  act as if is true) files as `belief`; teleological (what standing direction)
  files as `doctrine`.* Beliefs are bundle documents with `em:` ids (live under
  `/beliefs/`).

If nothing fits, propose a new type rather than forcing a bad one.
