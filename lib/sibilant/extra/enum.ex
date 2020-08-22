defmodule Sibilant.Extra.Enum do
  @moduledoc false

  def compact(list) when is_list(list),
    do: list |> Enum.reject(&is_nil/1)
end
