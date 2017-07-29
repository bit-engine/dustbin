defmodule Dustbin.Mixfile do
  use Mix.Project

  def project do
    [app: :dustbin,
     version: append_revision("0.1.0"),
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {Dustbin.Application, []}]
  end

  defp append_revision(vsn) do
    "#{vsn}+#{revision()}"
  end

  defp revision do
    System.cmd("git", ["rev-parse", "--short", "HEAD"])
    |> elem(0)
    |> String.rstrip
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:core, in_umbrella: true},
      {:ai, in_umbrella: true},
      {:scheduler, in_umbrella: true},
      {:receiver, in_umbrella: true}
    ]
  end
end
