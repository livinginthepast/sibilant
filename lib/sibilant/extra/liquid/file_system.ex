defmodule Sibilant.Extra.Liquid.FileSystem do
  use Gestalt

  def read_template_file(_root, name, _context) do
    {__MODULE__, root} = gestalt_config(:liquid, :file_system, self())
    File.read(Path.join(root, name))
  end
end
