defmodule Dustbin.Data.ReleaseTasks do
  @moduledoc"""
  This file defines all the tasks that will be available for the current release. 
  Once the release is ready, they will be available as:
    
    bin/dustbin [seed|migrate]
  """

  @start_apps [
    :postgrex,
    :ecto,
    :seedex
  ]

  @repo Dustbin.Data.Repo

  def app, do: :data

  def repos, do: Application.get_env(app(), :ecto_repos, [])

  def migrate do
    prepare()
    Enum.each(repos(), &run_migrations_for/1)
    IO.puts "Migration completed."
  end

  def seed do
    migrate()
    Enum.each(repos(), &run_seeds_for/1)
    IO.puts "Seed completed."
    :init.stop()
  end 

  defp run_migrations_for(repo) do
    IO.puts "Running migrations for #{repo}..."
    Ecto.Migrator.run(repo, migrations_path(repo), :up, all: true)
  end

  defp run_seeds_for(repo) do
    seed = seeds_path(repo)
    if File.exists?(seed) do
      IO.puts "Seeding..."
      Code.eval(seed)
    end
  end

  defp prepare do
    IO.puts "Loading #{app()}..."
    :ok = Application.load(app())
    IO.puts "Starting dependencies..."

    Enum.each(@start_apps, fn dep ->
      IO.puts "Starting: #{dep}"
      case Application.ensure_all_started(dep) do
        {:ok, _} -> "Dependency #{dep} started"
        {:error, e} -> "Could not start dependency #{dep}: #{e}"
      end
    end)

    IO.puts "Starting #{app()} repos..."
    Enum.each(repos(), &(&1.start_link(pool_size: 1)))
  end


  def migrations_path(repo), do: priv_path_for(repo, "migrations")
  def seeds_path(repo), do: priv_path_for(repo, "seeds.exs")

  def priv_dir(app), do: "#{:code.priv_dir(app)}"

  def priv_path_for(repo, filename) do
    app = Keyword.get(repo.config, :otp_app)
    underscore =
      repo
      |> Module.split
      |> List.last
      |> Macro.underscore
    Path.join(priv_dir(app), underscore, filename)
  end
end
