defmodule ElixirMind.ThreadTailTest do
  use ExUnit.Case, async: true

  alias ElixirMind.ThreadTail

  @doc_body """
  # 2026-07-27-some-session

  ## Where this landed

  Narrative prose, which is not a rendered exchange.

  ## Routing

  | Topic | State | Routed to | Dangling |
  |---|---|---|---|
  | something | closed | `unrouted` | - |

  ## User

  first operator message

  ## Assistant

  <routes ref="em:abc123">
  first agent reply
  </routes>

  ## User

  the last thing said
  """

  test "returns the role and text of the final rendered exchange" do
    assert {:ok, {"User", "the last thing said"}} = ThreadTail.last_block(@doc_body)
  end

  test "strips route-tag markup so the text can match the session log" do
    body = """
    ## Assistant

    <routes ref="em:abc123 em:def456">
    tagged text that must match the log verbatim
    </routes>
    """

    assert {:ok, {"Assistant", "tagged text that must match the log verbatim"}} =
             ThreadTail.last_block(body)
  end

  test "narrative headings before the render are not mistaken for exchanges" do
    body = """
    ## Where this landed

    prose

    ## Routing

    a table

    ## User

    the only exchange
    """

    assert {:ok, {"User", "the only exchange"}} = ThreadTail.last_block(body)
  end

  test "a multi-paragraph final block is returned whole" do
    body = """
    ## Assistant

    first paragraph

    second paragraph
    """

    assert {:ok, {"Assistant", text}} = ThreadTail.last_block(body)
    assert text == "first paragraph\n\nsecond paragraph"
  end

  test "an unrendered doc reports the absence rather than guessing a boundary" do
    assert {:error, reason} = ThreadTail.last_block("# Title\n\nno exchanges here\n")
    assert reason =~ "no `## User` or `## Assistant` heading"
  end
end
