defmodule Sibilant.Parser.LiquidTest do
  use Sibilant.SimpleCase

  describe "parse" do
    import Sibilant.Parser.Liquid, only: [parse: 1]

    test "parses text with default liquid syntax" do
      """
      {% assign a='b' %}{{ a }}

      With static text.
      """
      |> parse()
      |> assert_eq({
        :ok,
        """
        b

        With static text.
        """
      })
    end

    test "is an exception with invalid liquid" do
      assert_raise RuntimeError, fn ->
        """
        {% do_something %}

        With static text.
        """
        |> parse()
      end
    end
  end
end
