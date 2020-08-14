defmodule Sibilant.Compiler.LiquidTest do
  use Sibilant.SimpleCase

  describe "parse" do
    import Sibilant.Compiler.Liquid, only: [compile: 2]

    test "compiles text with default liquid syntax" do
      """
      {% assign a='b' %}{{ a }}

      With static text.
      """
      |> compile(%{})
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
        |> compile(%{})
      end
    end

    test "injects variables" do
      """
      I have a {{ fruit }}.
      """
      |> compile(%{"fruit" => "banana"})
      |> assert_eq(
        {:ok,
         """
         I have a banana.
         """}
      )
    end
  end
end
