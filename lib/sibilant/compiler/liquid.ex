defmodule Sibilant.Compiler.Liquid do
  @behaviour Sibilant.Compiler

  @impl true
  def compile(content) do
    template = Liquid.Template.parse(content)

    Liquid.Template.render(template, %{})
    |> respond()
  end

  defp respond({:ok, text, _}), do: {:ok, text}
end
