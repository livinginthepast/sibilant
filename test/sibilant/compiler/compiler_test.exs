defmodule Sibilant.CompilerTest do
  use Sibilant.SimpleCase

  alias Sibilant.Compiler

  describe "stack" do
    test "makes a list of compilers based on the type" do
      :ok =
        Gestalt.replace_config(
          :sibilant,
          :file_types,
          [my_type: [compiler: :my_compiler]],
          self()
        )

      Compiler.stack(:my_type)
      |> assert_eq([
        :my_compiler,
        Sibilant.Compiler.Liquid
      ])
    end
  end
end
