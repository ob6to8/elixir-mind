---
id: em:da9532
type: plan
title: "Dvorak vim — the drill engine"
description: Design for the practice half of the project — three escalating drill modes (isolated character, semantic recall, in-buffer execution) that train the isolated character-to-key association prose typing never exercises, scored on response latency rather than correctness because the reported failure is the stall and not the error.
status: proposed
tags: [projects, vim, neovim, dvorak, spaced-repetition, drills, lua, planning]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed project sketch session"
  why: "the drill system is one of the two components the operator named; its scoring model is the decision that distinguishes it from every generic vim trainer, so it is recorded before the build"
---

# Dvorak vim — the drill engine

The [project hub](/projects/dvorak-vim.md) diagnoses the missing skill as the
isolated character-to-key association: prose typing trains sequences as single
motor programs, so a fluent Dvorak typist has never practised retrieving one
character on its own. This plan is the machinery that practises it, and the
scoring rule that keeps the practice pointed at the actual deficit.

## The scoring rule, first

Everything else follows from it. **A drill is graded on response latency, in
bands, and a slow correct answer schedules exactly like a wrong one.**

| Band | Response | Treated as |
|---|---|---|
| fluent | under ~400 ms | pass |
| hesitant | ~400–1200 ms | weak pass, shortened interval |
| stalled | over ~1200 ms, or wrong | miss |

The operator's reported failure is not error — the answer is nearly always
eventually correct. It is the pause, and the flow break the pause causes. A
correctness-graded trainer scores that state as mastery and stops presenting
the very bindings that need presenting, which makes correctness grading worse
than no grading at all here. Latency also removes the self-report from the
loop, and self-assessed confidence is least reliable in precisely the
recovered-after-a-stall case this is built to catch.

The thresholds are starting values, not findings; the first real use is
expected to move them, and they live in one config table so it costs nothing.

## Current state

Nothing is built. The reference plan establishes what this consumes:

```
lua/dvorak-vim/
├── layout.lua      character → KeyPos
├── bindings.lua    Binding records
├── annotate.lua    keys × layout → "dw (h,)"
└── query.lua       returns data, renders nothing
```

## Desired state — three modes, escalating

```
1. locate    prompt: a bare character        d
             response: press the key
             trains: character → motor, the atom prose typing skips

2. recall    prompt: the semantics           "delete to end of line"
             response: type the command      D
             trains: semantics → character → motor

3. execute   prompt: a real buffer, cursor placed, target state shown
             response: any keystrokes reaching it
             trains: the composed skill; also scores keystroke count
                     against the optimal path
```

Mode 1 is the one a generic vim trainer has no reason to include and the one
this project exists for — it is the layout deficit isolated from vim entirely.
Mode 3 is ordinary vim practice, included because the association has to
survive being composed, and it is where a mode-1 gain either shows up or turns
out to have been drill-specific.

## Desired state — the loop

```
scheduler.due()  ──▶  present(item)  ──▶  capture(response, elapsed_ms)
      ▲                                          │
      │                                          ▼
      └────────  scheduler.record(item, band)  ◀── grade(elapsed_ms, correct)
```

Items are generated from `bindings.lua`, so the drillable set and the reference
set cannot drift: a binding added to one is present in the other with no second
edit.

## File tree

```
lua/dvorak-vim/drill/
├── init.lua         # NEW  :DvDrill entry, session loop, mode dispatch
├── item.lua         # NEW  Item records generated from bindings.lua
├── modes/
│   ├── locate.lua   # NEW  mode 1: isolated character
│   ├── recall.lua   # NEW  mode 2: semantics → command
│   └── execute.lua  # NEW  mode 3: scratch buffer, start and target states
├── grade.lua        # NEW  elapsed_ms × correct → band; the thresholds table
├── scheduler.lua    # NEW  interval scheduling over bands
└── store.lua        # NEW  per-item history, persisted to stdpath("data")
```

## Signatures

```lua
---@class Item
---@field id      string           -- stable: the Binding's keys plus the mode
---@field binding Binding
---@field mode    "locate"|"recall"|"execute"

---@class Review
---@field elapsed_ms integer
---@field correct    boolean
---@field band       "fluent"|"hesitant"|"stalled"

---@class ItemState
---@field ease      number
---@field interval  integer   -- in reviews, not days; sessions are irregular
---@field due_at    integer   -- review counter, not wall clock
---@field history   Review[]

---@param elapsed_ms integer
---@param correct    boolean
---@return "fluent"|"hesitant"|"stalled"
function grade.band(elapsed_ms, correct) end

---@param state ItemState
---@param band  string
---@return ItemState
function scheduler.record(state, band) end

---@param limit integer
---@return Item[]
function scheduler.due(limit) end

---Present one item and block until answered or abandoned.
---@param item Item
---@return Review
function modes.present(item) end
```

## Boundary decisions

- **`grade.lua` owns the thresholds and nothing else touches raw milliseconds.**
  Retuning the bands is one table.
- **`scheduler.lua` sees bands, never latencies.** It is a plain interval
  scheduler and could be swapped for a different algorithm without the drill
  modes noticing.
- **Modes own presentation and timing; they do not schedule.** Each returns a
  `Review` and stops there.
- **`item.lua` derives items from `bindings.lua`.** No second list of what is
  drillable exists to fall out of date.
- **Intervals count reviews, not days.** Practice sessions here are irregular
  and short, and a wall-clock scheduler spends the first minutes of every
  session on a backlog that irregularity manufactured.

## Decisions and open questions

| Decision | Choice | Rationale |
|---|---|---|
| Grading input | measured latency | the deficit is the stall; correctness grading certifies it as mastery |
| Self-report | excluded | confidence is least reliable exactly in the recovered-after-a-stall case |
| Mode 1 included | yes | it isolates the layout deficit from vim, which no general vim trainer does |
| Interval unit | reviews | sessions are irregular; day-based intervals manufacture a backlog |
| Item source | generated from `bindings.lua` | one list, so the reference and the drills cannot drift |

Open:

- **Latency thresholds.** The bands above are guesses. They need a baseline
  measurement — plausibly the operator's own timings on `a` and `m`, the two
  letters that did not move, as a personal floor to calibrate against.
- **Mode 3 material.** Synthetic buffers schedule cleanly and invite
  pattern-matching the drill instead of the binding; real files from the
  operator's work train the actual task and are harder to generate targets for.
- **Typing-hand confound.** In mode 1 a two-key command's latency includes
  transition cost, so a slow response may indict the pair rather than either
  character. Whether to drill only single characters in mode 1, or to model the
  pair as its own item, is unresolved.
- **Session shape.** Whether drills are a deliberate `:DvDrill` sitting or are
  interleaved into real editing — the latter measures the skill in situ and
  makes the flow break the drill was meant to remove.
- **Retirement.** Whether an item that bands fluent for long enough leaves the
  rotation entirely, or drops to a low-frequency check; leaving forever risks
  the practice becoming all-review and no-gain.
