defmodule Sibilant.SimpleCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  using do
    quote do
      import ExUnit.Assertions
      import Sibilant.Test.Extra.Assertions
    end
  end
end
