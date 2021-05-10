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

  @dialyzer {:nowarn_function, parse!: 1}

  @type t() :: {:ok, atom} | {:error, :unknown_extension}
  @type matcher() :: [compiler: module(), pattern: Regex.t()]

  @spec parse!(binary) :: atom | none()
  def parse!(filename) do
    filename
    |> parse()
    |> case do
      {:ok, type} when is_atom(type) -> type
      {:error, _error} -> raise(RuntimeError, "Unable to parse file extension")
    end
  end

  @spec parse(binary) :: t()
  def parse(filename) do
    filename
    |> file_extension()
    |> to_type()
  end

  @spec known_extensions() :: keyword(matcher())
  def known_extensions(), do: gestalt_config(:sibilant, :file_types, self())

  defp file_extension(filename), do: filename |> String.split(".") |> Enum.at(1)

  defp to_type(nil), do: {:error, :unknown_file_type}

  defp to_type(extension) do
    known_extensions()
    |> Enum.find(fn
      {type, config} when is_atom(type) ->
        extension =~ Keyword.get(config, :pattern, "")

      _ ->
        false
    end)
    |> case do
      {type, _} when is_atom(type) -> {:ok, type}
      _ -> {:error, :unknown_file_type}
    end
  end
end
