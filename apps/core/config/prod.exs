use Mix.Config

config :logger, level: :info

config :core, Core.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DUSTBIN_DB_USERNAME"),
  password: System.get_env("DUSTBIN_DB_PASSWORD"),
  database: System.get_env("DUSTBIN_DB_NAME"),
  hostname: System.get_env("DUSTBIN_DB_HOSTNAME"),
  pool_size: 20
