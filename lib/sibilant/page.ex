defmodule Sibilant.Page do
  use Gestalt

  alias Sibilant.Document
  alias Sibilant.FileExtension

  def ls() do
    dirname()
    |> File.ls!()
  end

  def path(filename), do: dirname() |> Path.join(filename)

  def read(filename) do
    content = dirname() |> Path.join(filename) |> File.read!()
    Document.parse(content, type: FileExtension.parse!(filename))
  end

  defp dirname(), do: root() |> Path.join("pages")
  defp root(), do: gestalt_config(:sibilant, :root, self())
end
