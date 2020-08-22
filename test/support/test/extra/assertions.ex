defmodule Sibilant.Test.Extra.Assertions do
  @moduledoc """
  Assertions and helpers to fill out ExUnit.
  """
  import ExUnit.Assertions

  alias Sibilant.Exists

  def assert_eq(left, right, opts \\ [])

  def assert_eq(string, %Regex{} = regex, _opts) when is_binary(string) do
    unless string =~ regex do
      ExUnit.Assertions.flunk("""
        Expected string to match regex
        left (string): #{string}
        right (regex): #{regex |> inspect}
      """)
    end

    string
  end

  def assert_eq(left, right, opts) when is_struct(left),
    do: assert_eq(map!(left, opts), right, opts) && left

  def assert_eq(left, right, opts) when is_struct(right),
    do: assert_eq(left, map!(right, opts), opts) && left

  def assert_eq(left, right, _opts) when is_map(left) and is_map(right) do
    unless Map.equal?(left, right) do
      added = Map.keys(right) -- Map.keys(left)
      missing = Map.keys(left) -- Map.keys(right)

      # credo:disable-for-lines:7
      different =
        (Map.keys(left) -- added)
        |> Enum.reduce([], fn key, acc ->
          if Map.get(left, key) == Map.get(right, key),
            do: acc,
            else: acc ++ [key]
        end)

      added_msg = if added != [], do: "new keys : #{inspect(added)}"
      missing_msg = if missing != [], do: "missing keys : #{inspect(missing)}"
      diff_msg = if different != [], do: "different keys : #{inspect(different)}"

      [
        "Expected maps to match",
        "left: #{inspect(left)}",
        "right: #{inspect(right)}",
        added_msg,
        missing_msg,
        diff_msg
      ]
      |> Sibilant.Extra.Enum.compact()
      |> Enum.join("\n")
      |> ExUnit.Assertions.flunk()
    end

    left
  end

  def assert_eq(left, right, opts) when is_list(left) and is_list(right) do
    {left, right} =
      if Keyword.get(opts, :ignore_order, false) do
        {Enum.sort(left), Enum.sort(right)}
      else
        {left, right}
      end

    assert left == right
    left
  end

  def assert_eq(left, right, _opts) do
    assert left == right
    left
  end

  defp map!(struct, opts) when is_struct(struct), do: Map.from_struct(struct) |> map!(opts)

  defp map!(map, opts) when is_map(map) do
    only = Keyword.get(opts, :only)
    except = Keyword.get(opts, :except)

    cond do
      Exists.exists?(only) -> Map.take(map, only)
      Exists.exists?(except) -> Map.drop(map, except)
      true -> map
    end
  end
end
