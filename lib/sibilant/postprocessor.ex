defmodule Sibilant.Postprocessor do
  def process(content) do
    content
    |> String.replace("\n\n", "\n")
    |> String.replace(~r">\n+([^<\s])", ">\\1")
    |> String.replace(~r"([\w\.])[\s\n]+</", "\\1</")
    |> respond()
  end

  def respond(content), do: {:ok, content}
end
