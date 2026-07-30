---
type: reference
title: 2026-07-30-human-writing-attribution
description: The operator proposed a provenance system for human-authored writing — publish each piece with its declared sources and LLM threads plus a quotation-vs-synthesis overlap report; the session assessed the idea, filed the underlying belief (em:2bd5a1), incubated the human-writing-attribution project hub (em:763ec8), and persisted the overlap-tool design plan (em:fe5ca6) before closing.
provenance: "Claude Code session, 2026-07-30; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, writing, attribution, provenance, ai-authorship, projects]
timestamp: 2026-07-30
session: https://claude.ai/code/session_01SchH1sXAKaGV8jn28EhBJX
---

# 2026-07-30-human-writing-attribution

## Where this landed

The operator proposed reframing the repo's attribution machinery as the seed of
a provenance system for human-authored writing: publish every original piece
with its declared inputs (third-party sources and LLM threads) plus a
mechanical analysis marking literal quotation versus the author's own
synthesis. The agent's assessment sharpened the attested unit from
sentence-level originality to ownership of the judgment, and framed the trust
model as converting stylometric inference into falsifiable claims. The operator
ratified filing both artifacts ("Both"): the prior landed as the belief
[the value of writing is the human synthesis behind it](/beliefs/value-of-writing-is-human-synthesis.md)
(`em:2bd5a1`) and the system as the
[human-writing-attribution project hub](/projects/human-writing-attribution.md)
(`em:763ec8`), committed and pushed. The operator then directed a plan for the
first design record and the close: the
[overlap-tool plan](/projects/human-writing-attribution/overlap-tool.md)
(`em:fe5ca6`, `status: proposed`) fixes the shape of the quotation-vs-synthesis
report generator, and the session closed via `/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| The human-synthesis prior (artifact vs process; reputation-staked judgment) | closed | [value-of-writing-is-human-synthesis](/beliefs/value-of-writing-is-human-synthesis.md) | - |
| The human-writing-attribution system (trust model, disclosure frame, open questions) | open | [human-writing-attribution](/projects/human-writing-attribution.md) | publication format, thread redaction, and source scope stay open on the hub |
| The overlap tool (quotation-vs-synthesis report generator) | paused | [overlap-tool plan](/projects/human-writing-attribution/overlap-tool.md) | build deferred; threshold default and JSON export open in the plan |

## User

<routes ref="em:2bd5a1 em:763ec8">
Consider this idea that this repo is really about attribution when it comes to writing. It's intended to be a system of provenance for human authored content. One of the biggest issues right now in the wild is evaluating the source of anything written on the web. There's almost a default assumption at this point that AI is writing it. whatever it is. there is the new habit of looking for LLM tells and then immediately discounting everything that follows. what about this for a proposed System of human written attribution. you include with every bit of original writing your sources. These sources are third party sources and or LLM threads. Then you run an analysis on your own writing to find out where there may be literal quotations and what is uniquely written by you. the human operator. The idea is complete transparency. Being transparent that AI was used as a research assistant and in brainstorming and formulating opinion, but the result was a human authored synthesis that cites its sources and references. The problem is we have conflated the artifact, which is a written presentation of ideas, with its role in the brainstorming process. The value is in actual human synthesis. That's what people are attracted to. How did you, as a human, synthesize and come to an opinion that you are prepared to stand your reputation behind? If you're regurgitating LLM outputs, you may have creatively massaged the context to result in a clever output, but the value is certainly not the same. thoughts?
</routes>

## Assistant

This lands on something the repo already half-implements, so let me give you a real assessment rather than just enthusiasm.

<routes ref="em:2bd5a1">
**The strongest part is the reframing, not the disclosure.** The current discourse treats "did AI write this" as a binary property of the *text*, which is why everyone is stuck doing stylometric vibes ("LLM tells") — an unwinnable detection arms race, since the tells are one fine-tune away from gone. Your framing moves the question from the text to the *process*: the artifact is a presentation layer, and what readers actually want to evaluate is whose judgment stands behind it. That's the right unit. Which leads to my main refinement:

**"Uniquely written by you" is the wrong claim to attest — it's both unverifiable and not the thing of value.** After heavy LLM brainstorming, your "own words" are shaped by the thread anyway; a sentence-level originality report can't recover a clean human/machine boundary, and paraphrase detection is mushy enough that any such report overclaims. What *is* attestable, and what your reputation-staking point actually rests on, is ownership of the judgment: "here are my sources, here are the LLM threads I worked in, here is the synthesis, and I stand behind its claims." The overlap analysis you describe is still valuable — but as a *disclosure of quotation*, not a *proof of originality*. Literal-overlap detection against your own declared sources is mechanically easy (it's plagiarism detection inverted: surfacing overlap instead of hiding it); certifying the residue as "purely human" is where the system would start lying.
</routes>

<routes ref="em:763ec8">
**The real move is converting unverifiable inference into falsifiable claims.** Nothing stops someone from stamping "human synthesis" on machine output — the attestation is self-issued, and that's the standard objection. But it misses what changes: today a skeptical reader has only stylistic guesswork; under your system, an author who cites their LLM threads has made a *checkable* claim. If the "synthesis" is a light paraphrase of the thread, the disclosed thread convicts them. The system doesn't prove honesty — it makes dishonesty auditable, and it makes the reputational stake concrete because there's now a specific record to be caught against. That's the same trust model as signed commits: the signature doesn't prove the code is good, it establishes who answers for it. The known failure mode to design against is C2PA's — provenance as detachable metadata gets stripped or ignored. Here the disclosure has to be part of the published work's frame (the citation graph *is* content), not a sidecar credential.

**Why this repo is a natural substrate:** the contract already enforces the inward-facing half of exactly this discipline, just pointed the other direction. `provenance`/`attribution` metadata, the quote-primary-sources rule (verbatim spans marked, everything outside quotes is declared synthesis, "a reader must never have to wonder whether a phrase is the source's claim or the agent's"), thread docs as the frozen full-fidelity process record with `session:` URLs as the raw-transcript escape hatch, `verified_by` evidence edges, commit trailers naming which session authored what — all of it exists so the *human can audit the machine's* contributions. Your proposal is the mirror image: the same machinery, published outward, so *readers can audit the human's*. The journal namespace is even the prototype of the voice boundary — operator prose kept inviolable, agent voice fenced below a marked heading, never interleaved.
</routes>

<routes ref="em:fe5ca6 em:763ec8">
The delta to actually prototype it here is small: a document layer for operator-authored synthesis that declares its inputs (thread docs + `source` captures), plus a `mix brain.*`-style task that computes literal-overlap spans between the piece and its declared inputs and emits the quotation/synthesis report. The thread docs you're already capturing are the expensive-to-fabricate part of the disclosure, and you already have them.
</routes>

<routes ref="em:763ec8">
One caution: watch for the badge failure. If "transparent human synthesis" becomes a credential people want, the credential gets gamed, and the ecosystem devolves into transparency theater. The defense is exactly what makes your version costly — publishing the actual process record (threads, sources, overlap report) rather than a self-assessed label. Anyone can claim the label; few will fabricate a convincing corpus.
</routes>

If you want to take this further, the natural next steps are filing it as a `belief` or `doctrine` (the "value is in human synthesis, attested by process disclosure" prior), or incubating it as a `projects/` hub if you're imagining a system that outlives this repo. Happy to do either — say the word.

## User

Both

## Assistant

Both artifacts are filed and pushed on the session branch. The belief captures the prior itself — that a piece of writing is a presentation layer and the value sits in the human judgment behind it — quoting your statement verbatim so the extraction stays auditable. The project hub holds the system: the premise, the trust model (disclosure converts stylometric guessing into falsifiable claims), a shape diagram, the decisions from our exchange, and the open questions. Each cross-links the other, and the hub records the refinement we settled on — the attested unit is ownership of the judgment, with the overlap report disclosing quotation rather than certifying originality.

**What I created**

| type | doc | why this type |
|---|---|---|
| `belief` | [The value of writing is the human synthesis behind it](https://github.com/ob6to8/elixir-mind/blob/claude/human-attribution-writing-h6yap7/beliefs/value-of-writing-is-human-synthesis.md) (`em:2bd5a1`) | value-laden decision prior — normative, held true enough to act on, outside the verification ladder |
| `project` | [Human writing attribution](https://github.com/ob6to8/elixir-mind/blob/claude/human-attribution-writing-h6yap7/projects/human-writing-attribution.md) (`em:763ec8`) | a system that would live outside this repo, incubating here per the projects-namespace policy |
| index | `projects/human-writing-attribution/index.md` | reserved listing for the project directory (no design records yet) |

**What I modified**

| file | thrust of the change |
|---|---|
| `beliefs/index.md` | added the new belief's entry |
| `projects/index.md` | added the new project under Active |
| `meta/registry.md` | regenerated after minting the two ids |

**Actions I have taken**

| action | result |
|---|---|
| `mix brain.id` / `brain.registry` / `brain.verify` / `brain.route_tags` | ids minted; all gates pass (the one route-tag warning is pre-existing, on a 2026-07-13 thread) |
| commit + push | `c4b06bf` on `claude/human-attribution-writing-h6yap7`; full pre-commit gate suite green, 188 tests passing |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | `/create-pull-request` | captures this thread, glossaries it, stamps `attribution.from`, and opens the PR — the thread capture is also what backfills the belief's origin trace |
| 2 | Start the first design record | the overlap tool is the most concrete open question — a spec for literal-span matching of a piece against its declared inputs would file under `projects/human-writing-attribution/` |

## User

Create a plan for 2, then run 1 and merge

## User

Proceed
