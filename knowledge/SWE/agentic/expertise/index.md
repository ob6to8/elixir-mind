# Expertise

How AI-assisted development interacts with the human engineer's expertise —
the theory in the engineer's head as the primary artifact of programming,
expertise as the leverage and bottleneck in steering models, how skill forms
(or fails to form) under delegation, and what raising the floor does to the
ability distribution.

## Documents

- [Programming (with AI agents) as theory building (Sean Goedecke)](/knowledge/SWE/agentic/expertise/programming-with-ai-agents-as-theory-building.md) — Naur's thesis that the engineer's theory of the program is the primary artifact, read against agentic coding: agents demonstrably build theories in-session but cannot retain them, so the human's retained theory stays the durable output.
- [LLMs reward expertise (Sean Goedecke)](/knowledge/SWE/agentic/expertise/llms-reward-expertise.md) — domain expertise, not prompting technique, is what LLM use rewards: specifying the desired solution and judging what comes back is the bottleneck, illustrated by Terence Tao's expert-mode ChatGPT usage.
- [How does AI impact skill formation? (Sean Goedecke)](/knowledge/SWE/agentic/expertise/how-does-ai-impact-skill-formation.md) — the Anthropic Fellows study's no-speedup headline hides a retyping confound (AI users were 25% faster without it); reduced learning-per-task is real but engineers are paid to deliver, and task volume may offset it.
- [AI makes weak engineers less harmful (Sean Goedecke)](/knowledge/SWE/agentic/expertise/ai-makes-weak-engineers-less-harmful.md) — engineering ability is heavy-tailed and the weakest engineers were net-negative; frontier coding agents raise that floor to line-by-line-functional output, turning the weakest engineers into Claude intermediaries.
- [METR's AI Productivity Study is Really Good (Sean Goedecke)](/knowledge/SWE/agentic/expertise/metr-ai-productivity-study-is-really-good.md) — an RCT on experienced developers in familiar codebases found they predicted and believed a ~20% speedup from AI but measured 19% slower; expert-in-familiar-code may be close to the worst case for AI acceleration.
- [Analysis of vibecoded outputs (MostAwesomeDude)](/knowledge/SWE/agentic/expertise/vibecoded-outputs-analysis-mostawesomedude.md) — five AI-chatbot coding submissions examined for confabulation, hackiness, and overfitting; you cannot inherit someone else's Naur theory by reading their output, only by building your own.

## Related

- [adoption](/knowledge/SWE/agentic/adoption/index.md) — holds Williams's
  [hand-off argument](/knowledge/SWE/agentic/adoption/its-not-empowering-to-hand-off-the-details.md):
  expertise gates what is safe to delegate, and forms only through engaging
  with the details being delegated away
- [agent-memory](/knowledge/SWE/agentic/agent-memory/index.md) — the machinery
  aimed at the retention gap: agents rebuild their theory of the codebase from
  scratch every session
