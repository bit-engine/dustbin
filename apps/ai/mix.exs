defmodule AI.Mixfile do
  use Mix.Project

  def project do
    [app: :ai,
     version: "0.1.0",
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
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {AI.Application, []}]
  end

  defp deps do
    [
      {:elixir_wit, "~> 1.0.0"},
    ]
  end

  # Hacky workaround here; when running `mix test` from
  # umbrella, the alias apparently gets ignored, so I have to explicitly
  # stop the application and execute it again.
  defp aliases do
    [
      "test": [fn _ -> Application.stop(:ai) end, "test --no-start"]
    ]
  end
end
