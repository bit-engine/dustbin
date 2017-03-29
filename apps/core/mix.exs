defmodule Core.Mixfile do
  use Mix.Project

  def project do
    [app: :core,
     version: "0.2.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  def application do
    [applications: [:ecto, :postgrex, :timex, :logger],
     mod: {Core.Application, []}]
  end

  defp deps do
    [
      {:ecto, "~> 2.1"},
      {:postgrex, ">= 0.0.0"},
      {:ex_machina, "~> 1.0", only: :test},
      {:timex, "~> 3.0"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]


  defp aliases do
    [
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
