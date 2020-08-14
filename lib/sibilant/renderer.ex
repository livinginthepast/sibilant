defmodule Sibilant.Renderer do
  @moduledoc false

  def render(%{body: body, type: type}, opts) do
    compiler_stack(type: type)
    |> Enum.reduce({:ok, body}, fn
      compiler, {:ok, rendered_content} ->
        compiler.compile(rendered_content, opts)

      _compiler, {:error, error} ->
        {:error, error}

      _compiler, {:error, error, term} ->
        {:error, error, term}
    end)
  end

  defp compiler_stack(type: type), do: Sibilant.Compiler.stack(type)
end
