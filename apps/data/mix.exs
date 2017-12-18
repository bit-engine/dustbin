defmodule Dustbin.Data.Mixfile do
  use Mix.Project

  def project do
    [app: :data,
     version: append_revision("0.2.1"),
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
    [applications: [:ecto, :postgrex, :timex, :logger, :seedex, :nimble_csv],
     mod: {Dustbin.Data.Application, []}]
  end

  defp deps do
    [
      {:ecto, "~> 2.1"},
      {:postgrex, ">= 0.0.0"},
      {:ex_machina, "~> 1.0", only: :test},
      {:seedex, "~> 0.1.2"},
      {:timex, "~> 3.0"},
      {:nimble_csv, "~> 0.1.0"}
    ]
  end

  defp append_revision(vsn) do
    "#{vsn}+#{revision()}"
  end

  defp revision do
    System.cmd("git", ["rev-parse", "--short", "HEAD"])
    |> elem(0)
    |> String.rstrip
  end


  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]


  defp aliases do
    [
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
