---
type: tutorial
title: "Reading an Elixir comprehension that builds a map"
description: A line-by-line beginner's walkthrough of `ElixirMind.Site.build_id_index/1` — a single-line `for` comprehension that turns a list of pages into an id-keyed lookup map — covering the three parts of a comprehension (generator, filter, `into:`), the pattern-match-in-the-generator idiom that silently skips non-matching elements, atom vs. string map keys, last-write-wins on duplicate keys, and the longhand `Enum` equivalent and when to prefer it.
provenance: "Claude Code session, 2026-07-29 — written from a beginner-level explanation of the function, then grounded against the live site.ex source"
tags: [meta, tutorial, elixir, comprehensions, pattern-matching, maps, site-generator, beginner]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, in-session authoring"
  why: "operator asked for a beginner explanation of build_id_index/1 to be kept as a durable tutorial, opening an Elixir-language subdirectory under meta/tutorials/"
  from: [/meta/threads/2026-07-29-elixir-comprehension-tutorial.md]
---

# Reading an Elixir comprehension that builds a map

Here is one of the smallest functions in the brain's tooling, from the static-site
generator at `lib/elixir_mind/site.ex:169`:

```elixir
defp build_id_index(pages) do
  for %{fm: %{"id" => id}} = p <- pages, is_binary(id), into: %{}, do: {id, p}
end
```

One line, and it packs in four separate Elixir ideas: private functions,
comprehensions, pattern matching used as a filter, and the `into:` option that
decides what shape comes out the other end. This tutorial unpacks each of them,
then shows the same function written the long way so the trade is visible.

## What it produces

`pages` is a list of maps — one per markdown file in the bundle, built by
`load_page/2` at `site.ex:103`. Each page map looks roughly like this:

```elixir
%{
  src: "beliefs/glossary/shacl.md",
  out: "beliefs/glossary/shacl.html",
  dir: "beliefs/glossary",
  fm: %{"id" => "em:4c9e1f", "type" => "concept", "title" => "SHACL", ...},
  body: "...",
  title: "SHACL",
  ...
}
```

The `:fm` key holds the document's parsed YAML frontmatter, and most bundle
documents carry an `em:` id in there. `build_id_index/1` turns the whole list into
a single map from id to page:

```elixir
%{
  "em:4c9e1f" => %{src: "beliefs/glossary/shacl.md", ...},
  "em:a96688" => %{src: "beliefs/plan-artifacts-compress-decisions-not-bodies.md", ...},
  ...
}
```

That map is the answer to one question the renderer needs to ask: *given an id,
which page is it?* Frontmatter records evidence edges as bare ids
(`verified_by: [em:a3d27b, em:f08c54]`), and to render those as clickable links the
generator has to resolve each id back to a page — which is exactly what
`edge_item/3` does at `site.ex:485`:

```elixir
defp edge_item(id, page, id_index) do
  case Map.get(id_index, id) do
    nil -> ~s(<li><code>#{esc(id)}</code></li>)
    target -> ~s(<li><a href="#{href(page, target)}">#{esc(target.title)}</a></li>)
  end
end
```

## `defp` — a private function

`def` defines a function other modules can call. `defp` defines one only this
module can call. `build_id_index/1` is an internal helper of `ElixirMind.Site`,
used once at `site.ex:51` and then passed down into rendering, so nothing outside
the module has any business calling it.

The `/1` in `build_id_index/1` is the **arity** — the number of arguments. Elixir
identifies functions by name *and* arity, so `foo/1` and `foo/2` are genuinely
different functions, and you'll see them written with the slash everywhere.

## The comprehension

```elixir
for <generator>, <filter>, into: <collectable>, do: <body>
```

A comprehension is Elixir's "for each thing in this collection, produce a thing".
It is one construct that does the work of a map plus a filter, and — thanks to
`into:` — decides the output container too. Everything between `for` and `do:` is
either a **generator** (has a `<-` in it) or a **filter** (anything else).

### 1. The generator: `%{fm: %{"id" => id}} = p <- pages`

The `<-` is the generator arrow: *take each element of `pages`, one at a time*. In
most beginner examples the left side is a plain variable — `for x <- pages` — but
here it is a **pattern**, and that changes what the line does.

```elixir
%{fm: %{"id" => id}} = p
```

Read this outside-in:

- `%{fm: %{"id" => id}}` says *this element must be a map containing an `:fm` key,
  whose value is itself a map containing an `"id"` key* — and when it is, bind that
  innermost value to the variable `id`. Elixir map patterns are **partial**: a
  pattern naming one key matches a map with a dozen keys. It asserts what must be
  there, not what must be the whole of it.
- `= p` binds the *entire* element to `p` as well. This is a match layered on a
  match: pull out the piece you want (`id`) and keep a handle on the whole thing
  (`p`) in one expression. Without it you'd have `id` but no way to name the page
  it came from.

**The part that surprises beginners:** in a comprehension generator, an element
that fails to match the pattern is **silently skipped**. A page whose frontmatter
has no `"id"` — an `index.md`, a thread doc, anything in the governance namespace —
simply never reaches the body. No error, no `nil` entry in the output.

That is specific to generators. The same pattern in a function head or a `case`
clause would raise a `MatchError` (or `FunctionClauseError`) on a non-matching
value. So the pattern is doing double duty here: it destructures *and* it filters,
and the filtering is the quiet half.

### 2. The filter: `is_binary(id)`

Any expression in the comprehension that isn't a generator is a filter: the
element survives only if the expression is truthy. `is_binary/1` asks *is this a
string?* — Elixir strings are UTF-8 binaries, so `is_binary/1` is the idiomatic
string check.

The pattern already guaranteed an `"id"` key exists; this guards against its value
being the wrong type. YAML happily parses `id: 12345` as an integer, and an integer
key here would never match the string ids that `verified_by` lists — so it's
excluded up front rather than producing a silently unreachable entry.

### 3. `into: %{}` and the body

`do: {id, p}` is the comprehension's body: for each surviving page, produce the
two-element tuple `{id, p}`.

`into: %{}` says where to put those results. **Without it**, a comprehension
collects into a list, and you'd get:

```elixir
[{"em:4c9e1f", page}, {"em:a96688", page}, ...]
```

**With it**, the results are poured into an empty map. Maps implement Elixir's
`Collectable` protocol in the obvious way: absorbing a `{key, value}` tuple inserts
that key. So each tuple becomes one map entry and you get a real map out.

The reason to want a map here is *shape*, not speed. With a list of tuples,
resolving an id means `Enum.find/2` and unwrapping the result; with a map, the
whole operation is the single `Map.get(id_index, id)` seen in `edge_item/3` above,
returning `nil` when the id doesn't resolve — which is precisely the branch that
function needs. (Constant-time lookup is a genuine property of maps, but at this
bundle's scale it is not what earns the `into:` — a full site build performs a
handful of these lookups, one per evidence edge.)

### One consequence: duplicate keys

Maps cannot hold the same key twice, so if two pages carried the same id, the one
appearing later in `pages` would silently overwrite the earlier one. The function
does not check for this, and it doesn't need to: `mix brain.verify` fails the build
on duplicate ids long before the site generator runs, so uniqueness is guaranteed
upstream. Worth knowing as a general property of `into: %{}` — **last write wins,
quietly** — because in code without an upstream guarantee that is a real bug
waiting to happen.

## Atom keys and string keys are different keys

`%{fm: %{"id" => id}}` mixes the two map-key syntaxes in one pattern, and the
mixture is deliberate:

| In the pattern | Key type | Why |
|---|---|---|
| `fm:` | atom `:fm` | The page map is constructed in Elixir at `site.ex:103`, where atom keys are idiomatic. |
| `"id" =>` | string `"id"` | The frontmatter map comes from parsing YAML, so its keys arrive as strings and stay strings. |

`%{fm: ...}` is shorthand for `%{:fm => ...}`. The two are not interchangeable:
`%{"fm" => x}` would not match this page, and `%{id: id}` would not match the
frontmatter. A frequent beginner bug is reaching for `page.fm.id` — that requires
an atom key and raises here; the string key needs bracket access, `page.fm["id"]`.

Parsed external data keeps string keys on purpose. Atoms are not garbage-collected,
so converting arbitrary input to atoms is a memory-exhaustion risk; the standard
practice is to leave untrusted or externally-sourced keys as strings, which is why
frontmatter never becomes atom-keyed on the way in.

## The longhand version

If the comprehension still reads as magic, here is the same function written with
`Enum` — which is what most people write before comprehensions click:

```elixir
defp build_id_index(pages) do
  pages
  |> Enum.filter(fn page -> is_binary(page.fm["id"]) end)
  |> Enum.map(fn page -> {page.fm["id"], page} end)
  |> Enum.into(%{})
end
```

Identical result. The differences:

- **Three passes over the list instead of one.** Each `Enum` call in a pipeline
  builds a full intermediate collection; the comprehension makes one pass. (At this
  size the difference is invisible; on a large list it isn't.)
- **`page.fm["id"]` is written twice** — once to test it, once to use it. The
  comprehension binds `id` in the pattern and reuses it, so the extraction has one
  home.
- **The longhand doesn't handle a missing `:fm` key.** `page.fm` raises if the key
  is absent, where the comprehension's pattern would skip the element. Matching
  that behavior means more code, not less.

The comprehension is idiomatic Elixir precisely because it collapses *what to take*,
*what to keep*, and *what to build* into one expression whose parts are still named
and separable.

## When not to reach for a comprehension

The very next function in the file, `build_backlinks/1` at `site.ex:174`, builds a
similar index and deliberately does not use one:

```elixir
defp build_backlinks(pages) do
  pages
  |> Enum.flat_map(fn p ->
    p.fm["verified_by"] |> List.wrap() |> Enum.map(&{&1, p})
  end)
  |> Enum.group_by(fn {id, _} -> id end, fn {_, p} -> p end)
end
```

It maps id to a **list** of pages — every page citing that id as evidence — and
grouping is not something `into:` can express: pouring `{id, page}` tuples into a
map overwrites, it does not accumulate. `Enum.group_by/3` is the tool for that, so
the pipeline is the honest shape.

The dividing line: a comprehension is the right choice when each input yields at
most one output and the output container just absorbs entries. Once the result
depends on *combining* entries — grouping, summing, deduplicating — an explicit
`Enum.reduce/3` or `Enum.group_by/3` says what is happening far better than an
`into:` ever could.

## The takeaways

1. `for x <- list, do: ...` is map-and-filter in one construct; `into:` chooses the
   output container, defaulting to a list.
2. A **pattern** on the left of `<-` destructures and filters at once, and skips
   non-matching elements **silently** — the one comprehension behavior that differs
   sharply from patterns everywhere else in the language.
3. `pattern = var` keeps the whole value while pulling a piece out of it.
4. Atom keys and string keys are different keys; parsed external data keeps strings.
5. `into: %{}` means **last write wins** on duplicate keys, without a warning.
