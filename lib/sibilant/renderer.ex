defmodule Sibilant.Renderer do
  @moduledoc false

  def render(%{body: body, type: type}, opts) do
    Sibilant.Compiler.stack(type)
    |> Enum.reduce({:ok, body}, fn
      compiler, {:ok, rendered_content} ->
        compiler.compile(rendered_content, opts)

      _compiler, {:error, error} ->
        {:error, error}

      _compiler, {:error, error, term} ->
        {:error, error, term}
    end)
    |> postprocess()
  end

  defp postprocess({:error, _, _} = error), do: error
  defp postprocess({:error, _} = error), do: error
  defp postprocess({:ok, html}), do: Sibilant.Postprocessor.process(html)
end
