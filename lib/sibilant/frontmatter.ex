defmodule Sibilant.Frontmatter do
  @moduledoc false

  defstruct ~w{
    extra
    layout
    title
  }a

  def new(attrs), do: __struct__(attrs)

  def parse(yaml) do
    YamlElixir.read_from_string(yaml)
    |> into_frontmatter()
  end

  defp into_frontmatter({:ok, map}) do
    {matched, extra} = map |> Map.split(~w{layout title})
    {:ok, new(layout: layout(matched), title: matched["title"], extra: extra)}
  end

  defp layout(%{"layout" => layout}), do: String.to_atom(layout)
  defp layout(_), do: :default
end
