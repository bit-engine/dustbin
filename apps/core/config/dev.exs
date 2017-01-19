use Mix.Config

config :core, Core.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "dustbin_#{Mix.env}",
  hostname: "localhost"
