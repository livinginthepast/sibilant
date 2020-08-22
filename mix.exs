defmodule Sibilant.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :sibilant,
      deps: deps(),
      dialyzer: dialyzer(),
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
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, ">= 1.0.0", only: [:dev, :test], runtime: false},
      {:earmark, "~> 1.4"},
      {:gestalt, "~> 1.0"},
      {:liquid, github: "bettyblocks/liquid-elixir"},
      {:yaml_elixir, "~> 2.5"}
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:ex_unit],
      plt_add_deps: :app_tree,
      plt_file: {:no_warn, "priv/plts/gestalt.plt"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
