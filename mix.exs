defmodule Sibilant.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :sibilant,
      deps: deps(),
      description: description(),
      dialyzer: dialyzer(),
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      preferred_cli_env: [credo: :test, dialyzer: :test],
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
      {:briefly, "~> 0.3", only: :test},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, ">= 1.0.0", only: [:dev, :test], runtime: false},
      {:earmark, "~> 1.4"},
      {:gestalt, "~> 1.0"},
      {:liquid, github: "bettyblocks/liquid-elixir"},
      {:yaml_elixir, "~> 2.5"}
    ]
  end

  defp description() do
    """
    A static website generator.
    """
  end

  defp dialyzer do
    [
      plt_add_apps: [:ex_unit],
      plt_add_deps: :app_tree,
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package() do
    [
      licenses: ["MIT"],
      maintainers: ["Eric Saxby"],
      links: %{"GitHub" => "https://github.com/livinginthepast/sibilant"}
    ]
  end
end
