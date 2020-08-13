defmodule Sibilant.Frontmatter do
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
    {:ok, new(layout: matched["layout"], title: matched["title"], extra: extra)}
  end
end
