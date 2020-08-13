defmodule Sibilant.Parser.Liquid do
  @behaviour Sibilant.Parser

  @impl true
  def parse(content) do
    template = Liquid.Template.parse(content)

    Liquid.Template.render(template, %{})
    |> respond()
  end

  defp respond({:ok, text, _}), do: {:ok, text}
end
