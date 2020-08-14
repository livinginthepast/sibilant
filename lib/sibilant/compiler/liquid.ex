defmodule Sibilant.Compiler.Liquid do
  @behaviour Sibilant.Compiler

  @impl true
  def compile(content, opts) do
    template = Liquid.Template.parse(content)

    Liquid.Template.render(template, opts)
    |> respond()
  end

  defp respond({:ok, text, _}), do: {:ok, text}
end
