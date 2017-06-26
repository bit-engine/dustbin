defmodule Core.ReleaseTasks do

  @start_apps [
    :postgrex,
    :ecto
  ]

  @app :core

  @repo Core.Repo

  def migrate do
    configure()
    run_migrations_for(@app)

    IO.puts "Migration completed successfully!"
    :init.stop()
  end

  def seed do
    configure()
    seed_script = seed_path(@app)
    if File.exists?(seed_script) do
      IO.puts "Seeding the database..."
      Code.eval_file(seed_script)
    end
    IO.puts "Seed script executed successfully!"
    :init.stop()
  end

  defp configure do
    IO.puts "Loading #{@app}..."
    :ok = Application.load(@app)

    IO.puts "Starting dependencies..."
    Enum.each(@start_apps, fn dep ->
      case Application.ensure_all_started(dep) do
        {:ok, _} -> "Dependency #{dep} started"
        {:error, e} -> "Could not start dependency #{dep}: #{e}"
      end
    end)

    IO.puts "Starting #{@app} repo..."
    @repo.start_link(pool_size: 1)
  end


  defp run_migrations_for(app) do
    IO.puts "Running migrations for #{app}..."
    Ecto.Migrator.run(@repo, migrations_path(app), :up, all: true)
  end

  def migrations_path(app), do: Path.join([priv_dir(app), "repo", "migrations"])

  def seed_path(app), do: Path.join([priv_dir(app), "repo", "seeds.exs"])

  def priv_dir(app), do: "#{:code.priv_dir(app)}"

end
