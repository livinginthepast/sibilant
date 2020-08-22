defmodule Sibilant.Extra.Liquid.FileSystem do
  @moduledoc false
  use Gestalt

  @spec read_template_file(any(), binary(), any()) :: {:ok, binary()} | {:error, File.posix()}
  def read_template_file(_root, name, _context) do
    {__MODULE__, root} = gestalt_config(:liquid, :file_system, self())
    File.read(Path.join(root, name))
  end
end
