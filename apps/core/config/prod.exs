use Mix.Config

config :logger, level: :info

config :core, Core.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "${DUSTBIN_DB_USERNAME}"
  password: "${DUSTBIN_DB_PASSWORD}"
  database: "${DUSTBIN_DB_NAME}"
  pool_size: 20
