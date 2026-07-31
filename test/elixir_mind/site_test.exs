defmodule ElixirMind.SiteTest do
  use ExUnit.Case, async: true

  alias ElixirMind.Site

  @moduletag :tmp_dir

  setup %{tmp_dir: dir} do
    bundle(dir)
    :ok
  end

  defp write(dir, rel, contents) do
    path = Path.join(dir, rel)
    File.mkdir_p!(Path.dirname(path))
    File.write!(path, contents)
  end

  defp bundle(dir) do
    write(dir, "index.md", """
    ---
    okf_version: "0.1"
    ---

    # Elixir Mind

    Root index with a [domain](/topic/index.md).
    """)

    write(dir, "topic/index.md", "# Topic\n\nA domain.\n")

    write(dir, "topic/a-claim.md", """
    ---
    id: em:aaaaaa
    type: concept
    title: A verified claim
    description: One-sentence summary.
    tags: [alpha, beta]
    verified: true
    verified_by: [em:bbbbbb]
    ---

    # A verified claim

    Body cites `code` and links to [the source](/topic/a-source.md).
    """)

    write(dir, "topic/a-source.md", """
    ---
    id: em:bbbbbb
    type: source
    title: A source capture
    resource: https://example.com/doc
    ---

    # A source capture

    > Verbatim quote.
    """)

    # excluded dirs must not be rendered
    write(dir, "deprecated/old.md", "---\ntype: note\n---\nold\n")
    write(dir, "lib/thing.md", "ignore me\n")
  end

  test "builds a page per included concept, skipping excluded dirs", %{tmp_dir: dir} do
    out = Path.join(dir, "_site")
    count = Site.build(dir, out)

    assert count == 4
    assert File.exists?(Path.join(out, "index.html"))
    assert File.exists?(Path.join(out, "topic/index.html"))
    assert File.exists?(Path.join(out, "topic/a-claim.html"))
    assert File.exists?(Path.join(out, "topic/a-source.html"))
    refute File.exists?(Path.join(out, "deprecated/old.html"))
    refute File.exists?(Path.join(out, "lib/thing.html"))
  end

  test "writes assets, search index, and .nojekyll", %{tmp_dir: dir} do
    out = Path.join(dir, "_site")
    Site.build(dir, out)

    assert File.exists?(Path.join(out, "assets/style.css"))
    assert File.exists?(Path.join(out, "assets/app.js"))
    assert File.exists?(Path.join(out, ".nojekyll"))

    index = File.read!(Path.join(out, "search-index.json"))
    assert index =~ "A verified claim"
    assert index =~ "\"alpha beta\""
  end

  test "concept page shows title, badge, tags and metadata", %{tmp_dir: dir} do
    out = Path.join(dir, "_site")
    Site.build(dir, out)
    html = File.read!(Path.join(out, "topic/a-claim.html"))

    assert html =~ ~s(<h1 class="page-title">A verified claim</h1>)
    assert html =~ ~s(<span class="badge type-concept">concept</span>)
    assert html =~ ~s(<p class="lede">One-sentence summary.</p>)
    assert html =~ ~s(data-tag="alpha")
    assert html =~ "✓ verified"
    assert html =~ "<code>em:aaaaaa</code>"
    # body H1 is not duplicated
    refute html =~ "<h1 id="
  end

  test "evidence edges and reverse backlinks resolve to page titles", %{tmp_dir: dir} do
    out = Path.join(dir, "_site")
    Site.build(dir, out)

    claim = File.read!(Path.join(out, "topic/a-claim.html"))
    assert claim =~ ~s(<a href="../topic/a-source.html">A source capture</a>)

    source = File.read!(Path.join(out, "topic/a-source.html"))
    assert source =~ "Cited by"
    assert source =~ ~s(<a href="../topic/a-claim.html">A verified claim</a>)
    # captures (with a resource) never show a verification row
    refute source =~ ~s(<dt>Verified</dt>)
    refute source =~ ~s(class="verified)
  end

  test "internal .md body links are rewritten to relative .html", %{tmp_dir: dir} do
    out = Path.join(dir, "_site")
    Site.build(dir, out)

    root = File.read!(Path.join(out, "index.html"))
    assert root =~ ~s(<a href="topic/index.html">domain</a>)

    claim = File.read!(Path.join(out, "topic/a-claim.html"))
    assert claim =~ ~s(<a href="../topic/a-source.html">the source</a>)
  end

  test "sidebar nav reflects the directory tree and marks the current page", %{tmp_dir: dir} do
    out = Path.join(dir, "_site")
    Site.build(dir, out)
    html = File.read!(Path.join(out, "topic/a-claim.html"))

    assert html =~ ~s(class="nav-dir-label")
    assert html =~ "Topic"
    assert html =~ ~s(class="nav-link active")
  end

  test "copies a visualization's launch artifact under a distinct on-site name", %{
    tmp_dir: dir
  } do
    write(dir, "topic/widget.md", """
    ---
    id: em:aaaaaa
    type: visualization
    title: Widget
    launch: widget.html
    ---

    [Launch it](./widget.html)
    """)

    write(dir, "topic/widget.html", "<title>Widget</title><script>1<2&&true</script>")

    out = Path.join(dir, "_site")
    Site.build(dir, out)

    # The doc's own rendered page keeps the plain slug — foo.md -> foo.html —
    # so every other page's cross-link to it still resolves.
    doc = File.read!(Path.join(out, "topic/widget.html"))
    assert doc =~ "nav-dir-label"
    refute doc =~ "1<2&&true"

    # The artifact lands under a distinct name, since the plain one is taken
    # by the doc page above — copied verbatim, never through render_page/4.
    assert File.exists?(Path.join(out, "topic/widget.embed.html"))
    refute File.exists?(Path.join(out, "topic/widget.html.embed.html"))

    copied = File.read!(Path.join(out, "topic/widget.embed.html"))
    original = File.read!(Path.join(dir, "topic/widget.html"))
    assert copied == original
    assert copied =~ "1<2&&true"
    refute copied =~ "nav-dir-label"

    # The doc's own Launch link is rewritten to the renamed on-site copy —
    # never left dangling at the plain name the doc page itself now owns.
    # Everything *else* pointing at this page (nav, breadcrumb, "active"
    # marker) still resolves to the doc, since the rewrite happens in the
    # markdown source before nav chrome is generated, not in the rendered
    # HTML where it could catch an unrelated href by substring accident.
    assert doc =~ ~s(<a href="../topic/widget.embed.html">Launch it</a>)
    assert doc =~ ~s(<a class="nav-link active" href="../topic/widget.html">)
  end

  test "a local file:// open still finds the plain sibling name, unrenamed", %{tmp_dir: dir} do
    write(dir, "topic/widget.md", """
    ---
    id: em:aaaaaa
    type: visualization
    title: Widget
    launch: widget.html
    ---

    [Launch it](./widget.html)
    """)

    write(dir, "topic/widget.html", "<title>Widget</title>")

    out = Path.join(dir, "_site")
    Site.build(dir, out)

    # The site build never touches the source tree — only _site/ is renamed.
    assert File.read!(Path.join(dir, "topic/widget.html")) == "<title>Widget</title>"
  end
end
