defmodule Dustbin.MixProject do
  use Mix.Project

  def project do
    [
      app: :dustbin,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
    ]
  end

  def application do
    [
      mod: {Dustbin.Application, []},
      extra_applications: [:logger, :edeliver, :observer, :wx, :runtime_tools]
    ]
  end

  defp deps do
    [
      {:quantum, ">= 2.2.1"},
      {:timex, "~> 3.0"},
      {:jason, "~> 1.0"},
      {:oauther, "~> 1.1"},
      {:extwitter, "~> 0.8"},
      {:distillery, "~> 1.5", runtime: false},
      {:edeliver, "~> 1.4.5"}
    ]
  end
end
