---
id: em:144256
type: reference
title: "smevals — a small evaluation framework for LLMs (Prime Radiant)"
description: A Python CLI (smevals) for running YAML-defined eval suites — tasks, configs, runs, and separately-regradable graders — built to help pick which cheap model-and-harness combination is good enough for a given task as frontier models get pricier and small models proliferate.
resource: https://primeradiant.com/blog/2026/smevals.html
provenance: "Prime Radiant, primeradiant.com blog post and the project's GitHub README (prime-radiant-inc/smevals), fetched 2026-08-18"
tags: [evals, llm-evaluation, benchmarking, cli-tool, open-source, model-selection]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# smevals

Prime Radiant's **smevals** is a Python CLI tool that executes eval suites
defined as a directory of YAML configuration plus executable scripts. Its
stated motivation: frontier models keep improving and getting pricier while
the options for inexpensive models have never been more abundant — smevals
exists to answer, systematically, which cheap model-and-harness combination
is good enough for a given task category rather than defaulting to the
frontier model out of habit.

## Vocabulary and architecture

Five concepts compose the system:

- **Eval** — a collection of **Tasks** answering one specific capability
  question.
- **Config** — the model plus optional parameters (system prompt, tools) a
  Task is attempted with.
- **Run** — the immutable record of one Config executing one Task: output,
  timestamp, exit code. A non-zero exit is an infrastructure failure, not a
  model score.
- **Grader / Check** — a Grader applies a configured sequence of Checks to a
  Run to produce a Grade. Checks are individual assertions (built-in ones
  like `contains` or `xml-valid`, others custom executables — Checkers),
  which may score with a simple heuristic or by calling out to another model
  as judge.
- **Run and grade are separated** — results can be regraded later against
  the same logged Runs (`--regrade`), so a Grader can be revised without
  re-executing the (possibly expensive) model calls.

A typical eval directory: `eval.yaml` (name/description), `tasks/` (one YAML
per Task), `configs/`, `graders/`, `checkers/` (custom executables), a
`run-llm` runner script, and an auto-managed `runs/` directory. The runner
contract passes environment variables (`SMEVALS_MODEL`, `SMEVALS_PROMPT`,
`SMEVALS_RUN_DIR`); its stdout becomes `output.txt`. A Checker emits JSON
with `score` (0.0–1.0), `metrics`, open-vocabulary `tags`, and free-text
`notes`/`details`.

## Commands

`smevals run EVAL [-m MODEL]... [-c CONFIG] [-t TASK]... [-g [GRADER]]`,
`smevals grade EVAL [-g GRADER] [--regrade]`, `smevals report EVAL
[--by-task] [--json]`, and `smevals serve EVAL_OR_SUITE... [-p PORT]` for an
interactive dashboard. Install via `uv tool install smevals`, `pip install
smevals`, or run directly with `uvx smevals --help`. MIT licensed.

## Reading against this bundle's existing material

The run/grade separation and score+metrics+tags+notes Check output shape are
close in spirit to this bundle's own
[Reading a self-published benchmark](/knowledge/SWE/evals/reading-a-self-published-benchmark.md)
methodology (match every number to the suite it came from) and
[Split retrieval and generation evaluation for RAG](/knowledge/SWE/evals/split-retrieval-and-generation-evaluation-for-rag.md)
(mechanical checks plus a calibrated LLM judge) — smevals is a concrete tool
implementing that same mechanical-check-plus-model-judge pattern as a
general-purpose, config-driven harness rather than a bespoke pipeline.

# Citations

- <https://primeradiant.com/blog/2026/smevals.html> — Prime Radiant blog announcement
- <https://github.com/prime-radiant-inc/smevals/blob/main/README.md> — project README
