defmodule Sibilant.Extra.EnumTest do
  use Sibilant.SimpleCase, async: true

  alias Sibilant.Extra

  describe "compact" do
    test "removes nil values from a list" do
      [nil, nil, 1, "a", 2, nil, 3, nil, "b"]
      |> Extra.Enum.compact()
      |> assert_eq([1, "a", 2, 3, "b"])
    end
  end
end
