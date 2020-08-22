defmodule Sibilant.Compiler do
  @moduledoc false
  use Gestalt

  @callback compile(content :: String.t(), opts :: map) ::
              {:ok, String.t()} | {:error, atom} | {:error, atom, term}

  @spec stack(atom()) :: list(module()) | none()
  def stack(type) do
    [
      compiler_for_type(type),
      Sibilant.Compiler.Liquid
    ]
  end

  defp compiler_for_type(type) do
    gestalt_config(:sibilant, :file_types, self())
    |> Keyword.get(type)
    |> case do
      nil -> raise("unable to find type=`#{inspect(type)} in sibilant :file_types config`")
      config -> Keyword.fetch!(config, :compiler)
    end
  end
end
