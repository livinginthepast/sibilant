defmodule Sibilant.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :sibilant,
      deps: deps(),
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      version: @version
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:earmark, "~> 1.4"},
      {:gestalt, "~> 1.0"},
      {:liquid, ">= 1.0.0-pre"},
      {:yaml_elixir, "~> 2.5"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
