defmodule Sibilant.Page do
  use Gestalt

  alias Sibilant.Document
  alias Sibilant.FileExtension

  def ls() do
    dirname()
    |> File.ls!()
  end

  def read(filename) do
    path = dirname() |> Path.join(filename)
    content = File.read!(path)
    Document.parse(content, type: FileExtension.parse!(filename))
  end

  defp dirname(), do: root() |> Path.join("pages")
  defp root(), do: gestalt_config(:sibilant, :root, self())
end
