defmodule Sibilant.Compiler.Noop do
  @behaviour Sibilant.Compiler

  @impl true
  def compile(content, _opts), do: {:ok, content}
end
