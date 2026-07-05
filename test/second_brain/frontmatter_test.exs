defmodule SecondBrain.FrontmatterTest do
  use ExUnit.Case, async: true

  alias SecondBrain.Frontmatter

  test "parses scalars, booleans, integers, and inline lists" do
    doc = """
    ---
    type: policy
    title: Example policy
    order: 3
    verified: false
    tags: [git, version-control, refs]
    ---
    Body line one.

    Body line two.
    """

    assert {:ok, %{frontmatter: fm, body: body}} = Frontmatter.parse(doc)
    assert fm["type"] == "policy"
    assert fm["title"] == "Example policy"
    assert fm["order"] == 3
    assert fm["verified"] == false
    assert fm["tags"] == ["git", "version-control", "refs"]
    assert String.starts_with?(body, "Body line one.")
  end

  test "strips surrounding quotes from scalar strings" do
    doc = ~s(---\nprovenance: "Claude Opus 4.8, chat thread"\n---\nbody\n)
    assert {:ok, %{frontmatter: fm}} = Frontmatter.parse(doc)
    assert fm["provenance"] == "Claude Opus 4.8, chat thread"
  end

  test "ignores blank lines and comments in frontmatter" do
    doc = "---\n# a comment\ntype: note\n\ntitle: X\n---\nbody\n"
    assert {:ok, %{frontmatter: fm}} = Frontmatter.parse(doc)
    assert fm == %{"type" => "note", "title" => "X"}
  end

  test "errors when frontmatter is missing" do
    assert {:error, :missing_frontmatter} = Frontmatter.parse("no frontmatter here\n")
  end
end
