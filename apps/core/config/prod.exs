use Mix.Config

config :logger, level: :info

config :core, Core.Repo,
  adapter: Ecto.Adapter.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
  ssl: true
