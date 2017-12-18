use Mix.Config

config :logger, level: :info

config :data, Dustbin.Data.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "${DUSTBIN_DB_USERNAME}",
  password: "${DUSTBIN_DB_PASSWORD}",
  database: "${DUSTBIN_DB_NAME}",
  hostname: "${DUSTBIN_DB_HOST}",
  pool_size: 20
