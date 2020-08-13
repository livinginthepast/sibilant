defmodule Sibilant.Compiler.Noop do
  @behaviour Sibilant.Compiler

  @impl true
  def compile(content), do: {:ok, content}
end
