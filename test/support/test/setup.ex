defmodule Sibilant.Test.Setup do
  @moduledoc false

  def setup_output_dir(_context) do
    {:ok, path} = Briefly.create()

    [output_path: path]
  end
end
