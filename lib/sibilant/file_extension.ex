defmodule Sibilant.FileExtension do
  @moduledoc """
  Matches the file extension of a filename to a known render type. Given a filename,
  the second part of the file is used. For example, `about.html` would check using `html`,
  while `about.md.html` would check using `md`.

  Known types can be configured in an application using the `:sibilant, :extensions` key.

      config :sibilant, :extensions,
        html: ~r"htm",
        markdown: ~r"(md|markdown)",
        custom: ~r"custom"
  """

  use Gestalt

  @spec parse!(binary) :: atom
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

  def file_extension(filename), do: filename |> String.split(".") |> Enum.at(1)
  def known_extensions(), do: gestalt_config(:sibilant, :extensions, self())

  def to_type(extension) do
    known_extensions()
    |> Enum.find(fn {_type, pattern} ->
      extension =~ pattern
    end)
    |> case do
      {type, _} -> {:ok, type}
      _ -> {:error, :unknown_extension}
    end
  end
end
