defmodule Core.ReleaseTasks do

  @start_apps [
    :postgrex,
    :ecto
  ]

  @app :core

  @repo Core.Repo

  def create do
    IO.puts "Loading Dustbins Core"
    :ok = Application.load(@app)

    IO.puts "Starting dependencies"
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    @repo.__adapter__.config.storage_up(@repo.config)
    
    IO.puts "Database created successfully!"
    :init.stop()
  end
 
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
      IO.puts "Seeding the database"
      Code.eval_file(seed_script)
    end
    IO.puts "Seed script executed successfully!"
    :init.stop()
  end

  defp configure do
    IO.puts "Loading Dustbins Core"
    :ok = Application.load(@app)

    IO.puts "Starting dependencies"
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    IO.puts "Starting Dustbins Core Repo"
    @repo.start_link(pool_size: 1)
  end


  defp run_migrations_for(app) do
    IO.puts "Running migrations for #{app}"
    Ecto.Migrator.run(MyApp.Repo, migrations_path(app), :up, all: true)
  end

  def migrations_path(app), do: Path.join([priv_dir(app), "repo", "migrations"])

  def seed_path(app), do: Path.join([priv_dir(app), "repo", "seeds.exs"])

  def priv_dir(app), do: "#{:code.priv_dir(app)}"

end
