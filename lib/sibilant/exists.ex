defmodule Sibilant.Exists do
  def blank?(nil), do: true
  def blank?(s) when is_binary(s), do: String.length(s) == 0
  def blank?([]), do: true
  def blank?(list) when is_list(list), do: false
  def blank?(m) when is_map(m), do: map_size(m) == 0
  def blank?(_), do: false

  def exists?(value), do: !blank?(value)
end
