defmodule Sibilant.SimpleCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import ExUnit.Assertions
      import Sibilant.Test.Extra.Assertions
    end
  end
end
