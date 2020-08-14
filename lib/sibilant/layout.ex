defmodule Sibilant.Layout do
  use Gestalt

  alias Sibilant.FileExtension
  alias Sibilant.Renderer

  defstruct ~w{
    body
    type
  }a

  def new(attrs), do: __struct__(attrs)

  def path(filename), do: dirname() |> Path.join(filename)

  def read(filename) do
    content = dirname() |> Path.join(filename) |> File.read!()
    {:ok, new(body: content, type: FileExtension.parse!(filename))}
  end

  def render(%__MODULE__{} = layout, content: content) do
    Renderer.render(layout, %{"content" => content})
  end

  defp dirname(), do: root() |> Path.join("layout")
  defp root(), do: gestalt_config(:sibilant, :root, self())
end
