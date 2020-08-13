defmodule Sibilant do
  @moduledoc """
  Documentation for Sibilant.
  """

  use Application

  def start(_type, __args) do
    import Supervisor.Spec, warn: false

    children = []

    opts = [strategy: :one_for_one, name: Sibilant.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
