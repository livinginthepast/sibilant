defmodule Sibilant.FileExtension do
  @moduledoc """
  Matches the file extension of a filename to a known render type. Given a filename,
  the second part of the file is used. For example, `about.html` would check using `html`,
  while `about.md.html` would check using `md`.

  Known types can be configured in an application using the `:sibilant, :file_types` key.

      config :sibilant, :file_types,
        html: [compiler: Sibilant.Compiler.Noop, pattern: ~r"htm"],
        markdown: [compiler: Sibilant.Compiler.Markdown, pattern: ~r"(md|markdown)"],
        custom: [compiler: MyCustomCompiler, pattern: ~r"custom"]
  """

  use Gestalt

  @spec parse!(binary) :: atom | none()
  def parse!(filename) do
    filename
    |> parse()
    |> case do
      {:ok, type} -> type
      {:error, error} -> raise(error)
    end
  end

  @spec parse(binary) :: {:ok, atom} | {:error, :unknown_extension}
  def parse(filename) do
    filename
    |> file_extension
    |> to_type()
  end

  defp file_extension(filename), do: filename |> String.split(".") |> Enum.at(1)
  defp known_extensions(), do: gestalt_config(:sibilant, :file_types, self())

  defp to_type(extension) do
    known_extensions()
    |> Enum.find(fn {_type, config} ->
      extension =~ Keyword.get(config, :pattern)
    end)
    |> case do
      {type, _} -> {:ok, type}
      _ -> {:error, :unknown_file_type}
    end
  end
end
