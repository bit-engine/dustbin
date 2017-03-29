defmodule Scheduler.Mixfile do
  use Mix.Project

  def project do
    [app: :scheduler,
     version: "0.2.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:quantum, :timex, :core, :logger],
     mod: {Scheduler.Application, []}]
  end

  defp deps do
    [
      {:quantum, ">= 1.8.1"},
      {:timex, "~> 3.0"},
      {:core, in_umbrella: true}
    ]
  end
end
