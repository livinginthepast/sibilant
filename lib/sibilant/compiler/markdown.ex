defmodule Sibilant.Compiler.Markdown do
  @behaviour Sibilant.Compiler

  use Gestalt

  @impl true
  def compile(content) do
    content
    |> Earmark.as_html(earmark_config())
    |> respond()
  end

  def earmark_config() do
    case gestalt_config(:sibilant, :earmark, self()) do
      %Earmark.Options{} = opts -> opts
      %{} = opts -> Kernel.struct!(Earmark.Options, opts)
      opts when is_list(opts) -> Kernel.struct!(Earmark.Options, Enum.into(opts, %{}))
      _ -> %Earmark.Options{}
    end
  end

  defp respond({:ok, html, _}), do: {:ok, html}
  defp respond({:error, _, errors}), do: {:error, :markdown_error, errors}
end
