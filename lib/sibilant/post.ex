defmodule Sibilant.Post do
  alias Sibilant.Frontmatter

  defstruct ~w{
    body
    frontmatter
  }a

  def new(attrs), do: __struct__(attrs)

  def parse(content) do
    [front | [body]] = String.split(content, "\n---\n")
    {:ok, frontmatter} = Frontmatter.parse(front)
    new(body: body, frontmatter: frontmatter)
  end
end
