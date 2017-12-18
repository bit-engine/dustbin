defmodule Scheduler.Mixfile do
  use Mix.Project

  def project do
    [app: :scheduler,
     version: append_revision("0.3.0"),
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
    [applications: [:quantum, :timex, :data, :logger, :extwitter],
     mod: {Scheduler.Application, []}]
  end

  defp append_revision(vsn) do
    "#{vsn}+#{revision()}"
  end

  defp revision do
    System.cmd("git", ["rev-parse", "--short", "HEAD"])
    |> elem(0)
    |> String.rstrip
  end


  defp deps do
    [
      {:quantum, ">= 1.8.1"},
      {:timex, "~> 3.0"},
      {:extwitter, "~> 0.8"},
      {:poison, "~> 3.0.0", override: true},
      {:data, in_umbrella: true}
    ]
  end
end
