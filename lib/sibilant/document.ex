defmodule Sibilant.Document do
  @moduledoc false
  alias Sibilant.Frontmatter
  alias Sibilant.Renderer

  @enforce_keys ~w{body frontmatter type}a
  defstruct ~w{
    body
    frontmatter
    type
  }a

  def new(attrs), do: __struct__(attrs)

  def parse(content, type: type) do
    [front | [body]] = String.split(content, "\n---\n")
    {:ok, frontmatter} = Frontmatter.parse(front)
    {:ok, new(body: String.trim(body), frontmatter: frontmatter, type: type)}
  end

  def render(%__MODULE__{} = document) do
    Renderer.render(document, %{})
  end
end
