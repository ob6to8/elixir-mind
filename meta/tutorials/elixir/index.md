# Elixir

Tutorials about the **Elixir language itself** — syntax, idioms, and standard-library
shapes — taught through the brain's own source in `lib/`, so each explanation is
anchored to code that actually runs here rather than to an invented example.
Distinct from the tutorials one level up, which explain how the tooling and
governance *work*; these explain how the code is *written*.

## Contents

- [Reading an Elixir comprehension that builds a map](/meta/tutorials/elixir/comprehensions-that-build-maps.md) — a line-by-line walkthrough of `ElixirMind.Site.build_id_index/1`: the three parts of a `for` comprehension (generator, filter, `into:`), the pattern-in-the-generator idiom that destructures and silently skips in one move, why the page map has atom keys and the frontmatter map has string ones, last-write-wins on duplicate keys, the longhand `Enum` equivalent, and where the neighbouring `build_backlinks/1` shows the case a comprehension can't express.
