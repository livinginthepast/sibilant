defmodule Sibilant.Parser do
  @callback parse(content :: String.t()) ::
              {:ok, String.t()} | {:error, atom} | {:error, atom, term}
end
