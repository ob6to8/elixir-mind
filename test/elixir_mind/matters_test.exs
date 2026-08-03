defmodule ElixirMind.MattersTest do
  use ExUnit.Case, async: true

  alias ElixirMind.Matters

  @moduletag :tmp_dir

  defp write_doc(dir, rel_path, fields, body \\ "Body.") do
    path = Path.join(dir, rel_path)
    File.mkdir_p!(Path.dirname(path))
    fm = Enum.map_join(fields, "\n", fn {k, v} -> "#{k}: #{v}" end)
    File.write!(path, "---\n#{fm}\n---\n#{body}\n")
  end

  defp write_register(dir, rows) do
    table =
      [
        "| # | Matter | Type | Order |",
        "|---|---|---|---|"
        | rows
      ]
      |> Enum.join("\n")

    File.write!(Path.join(dir, "meta/matters.md"), "# Matters\n\nProse.\n\n#{table}\n")
  end

  defp matter(dir, slug, fields),
    do: write_doc(dir, "meta/matters/#{slug}.md", [type: "matter", title: slug] ++ fields)

  defp plan(dir, slug),
    do: write_doc(dir, "meta/plans/#{slug}.md", type: "plan", title: slug, status: "in-progress")

  defp result(results, name) do
    {^name, status, detail} = List.keyfind(results, name, 0)
    {status, detail}
  end

  defp assert_all_ok(results) do
    for {name, status, detail} <- results do
      assert status == :ok, "#{name}: expected :ok, got #{status} — #{detail}"
    end
  end

  test "a consistent register and doc set passes every check", %{tmp_dir: dir} do
    File.mkdir_p!(Path.join(dir, "meta/matters"))
    plan(dir, "big-plan")
    matter(dir, "step-one", status: "open", plan: "/meta/plans/big-plan.md", order: 1)
    matter(dir, "step-two", status: "open", plan: "/meta/plans/big-plan.md", order: 2)
    matter(dir, "loose-end", status: "open")
    matter(dir, "shipped", status: "done", pr: 42)
    matter(dir, "dropped", status: "cancelled")

    write_register(dir, [
      "| 1 | [Step one](/meta/matters/step-one.md) | [planned](/meta/plans/big-plan.md) | 1 |",
      "| 2 | [Loose end](/meta/matters/loose-end.md) | independent | - |",
      "| 3 | [Step two](/meta/matters/step-two.md) | [planned](/meta/plans/big-plan.md) | 2 |"
    ])

    assert_all_ok(Matters.run_checks(dir))
  end

  test "a missing register passes vacuously; doc-side shape still checks", %{tmp_dir: dir} do
    matter(dir, "backlog-only", status: "open")
    assert_all_ok(Matters.run_checks(dir))

    matter(dir, "bad-status", status: "wip")
    {status, detail} = result(Matters.run_checks(dir), "ref resolution + doc shape")
    assert status == :fail
    assert detail =~ "bad-status.md: status is \"wip\""
  end

  test "register-shape failures: numbering, link form, cell forms, duplicates", %{tmp_dir: dir} do
    matter(dir, "real", status: "open")

    write_register(dir, [
      "| 1 | [Real](/meta/matters/real.md) | independent | - |",
      "| 3 | [Real](/meta/matters/real.md) | independent | - |",
      "| 4 | plain text, no link | independent | - |",
      "| 5 | [Elsewhere](/meta/plans/not-a-matter.md) | neither-form | x |"
    ])

    {status, detail} = result(Matters.run_checks(dir), "register shape")
    assert status == :fail
    assert detail =~ "`#` cells read [1, 3, 4, 5]"
    assert detail =~ "queued 2 times"
    assert detail =~ "not a markdown link"
    assert detail =~ "not a /meta/matters/*.md doc"
    assert detail =~ "Type cell must be `independent` or a `[planned](…)` link"
    assert detail =~ "Order cell must be `-` or an integer"
  end

  test "a queue row pointing at a missing doc fails ref resolution", %{tmp_dir: dir} do
    File.mkdir_p!(Path.join(dir, "meta/matters"))
    write_register(dir, ["| 1 | [Ghost](/meta/matters/ghost.md) | independent | - |"])

    {status, detail} = result(Matters.run_checks(dir), "ref resolution + doc shape")
    assert status == :fail
    assert detail =~ "missing doc: /meta/matters/ghost.md"
  end

  test "doc-shape failures: type, plan/order pairing, dangling plan, pr form", %{tmp_dir: dir} do
    matter(dir, "half-planned", status: "open", order: 2)
    matter(dir, "dangling-plan", status: "open", plan: "/meta/plans/nowhere.md", order: 1)
    matter(dir, "bad-pr", status: "done", pr: "\"#42\"")
    write_doc(dir, "meta/matters/not-a-matter.md", type: "note", title: "stray", status: "open")

    {status, detail} = result(Matters.run_checks(dir), "ref resolution + doc shape")
    assert status == :fail
    assert detail =~ "half-planned.md: `order` without `plan`"
    assert detail =~ "dangling-plan.md: `plan` does not resolve: /meta/plans/nowhere.md"
    assert detail =~ "bad-pr.md: `pr` is \"#42\""
    assert detail =~ "not-a-matter.md: type is \"note\""
  end

  test "row↔doc disagreement: status, plan link, and order cell", %{tmp_dir: dir} do
    plan(dir, "big-plan")
    matter(dir, "already-done", status: "done", pr: 7)
    matter(dir, "secretly-planned", status: "open", plan: "/meta/plans/big-plan.md", order: 1)
    matter(dir, "order-drift", status: "open", plan: "/meta/plans/big-plan.md", order: 2)

    write_register(dir, [
      "| 1 | [Done one](/meta/matters/already-done.md) | independent | - |",
      "| 2 | [Planned one](/meta/matters/secretly-planned.md) | independent | - |",
      "| 3 | [Drifted](/meta/matters/order-drift.md) | [planned](/meta/plans/big-plan.md) | 5 |"
    ])

    {status, detail} = result(Matters.run_checks(dir), "row↔doc agreement")
    assert status == :fail
    assert detail =~ "already-done.md: queued but status is \"done\""
    assert detail =~ "secretly-planned.md: row says independent but doc has plan"
    assert detail =~ "order-drift.md: row Order is 5 but doc has 2"
  end

  test "the queue may not invert a plan's internal order", %{tmp_dir: dir} do
    plan(dir, "big-plan")
    matter(dir, "step-one", status: "open", plan: "/meta/plans/big-plan.md", order: 1)
    matter(dir, "step-two", status: "open", plan: "/meta/plans/big-plan.md", order: 2)

    write_register(dir, [
      "| 1 | [Step two](/meta/matters/step-two.md) | [planned](/meta/plans/big-plan.md) | 2 |",
      "| 2 | [Step one](/meta/matters/step-one.md) | [planned](/meta/plans/big-plan.md) | 1 |"
    ])

    {status, detail} = result(Matters.run_checks(dir), "plan-order inversion")
    assert status == :fail
    assert detail =~ "step-two.md (order 2) is queued above /meta/matters/step-one.md (order 1)"
  end

  test "a done doc without pr: warns and never fails", %{tmp_dir: dir} do
    matter(dir, "unstamped", status: "done")

    results = Matters.run_checks(dir)
    {status, detail} = result(results, "landing metadata")
    assert status == :warn
    assert detail =~ "unstamped.md: done without a landing `pr:`"
    refute Enum.any?(results, fn {_, s, _} -> s == :fail end)
  end

  test "queue_positions maps doc paths to rows, skipping malformed ones", %{tmp_dir: dir} do
    matter(dir, "real", status: "open")

    write_register(dir, [
      "| 1 | [Real](/meta/matters/real.md) | independent | - |",
      "| not-a-pos | [Ghost](/meta/matters/ghost.md) | independent | - |",
      "| 2026-08-01 | [Datelike](/meta/matters/datelike.md) | independent | - |"
    ])

    assert Matters.queue_positions(dir) == %{"/meta/matters/real.md" => 1}
    assert Matters.queue_positions(Path.join(dir, "nonexistent")) == %{}
  end
end
