defmodule Sibilant.Compiler.NoopTest do
  use Sibilant.SimpleCase

  describe "compile" do
    import Sibilant.Compiler.Noop, only: [compile: 2]

    test "returns whatever is passed in" do
      """
      I have some text.

      * With stuff

      <div>And HTML</div>
      """
      |> compile(%{})
      |> assert_eq(
        {:ok,
         """
         I have some text.

         * With stuff

         <div>And HTML</div>
         """}
      )
    end
  end
end
