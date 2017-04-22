defmodule AI.Mixfile do
  use Mix.Project

  def project do
    [app: :ai,
     version: "0.3.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  def application do
    [applications: [:logger, :elixir_wit, :core],
     mod: {AI.Application, []}]
  end

  defp deps do
    [
      {:elixir_wit, "~> 1.0.0"},
      {:ecto, "~> 2.1"},
      {:postgrex, ">= 0.0.0"},
      {:core, in_umbrella: true},
      {:poison, "~> 3.0.0", override: true},
      {:xend, "~> 0.6.0"}
    ]
  end

  # When running tests from the root of an umbrella,
  # test --no-start doesn't work, at this point the application
  # has already been started, so the best approach is to stop it 
  # and pass the --no-start option after
  defp aliases do
    [
      "test": [fn _ -> Application.stop(:ai) end, "test --no-start"]
    ]
  end
end
