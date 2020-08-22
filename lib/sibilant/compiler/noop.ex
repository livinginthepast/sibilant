defmodule Sibilant.Compiler.Noop do
  @moduledoc false
  @behaviour Sibilant.Compiler

  @impl true
  def compile(content, _opts), do: {:ok, content}
end
