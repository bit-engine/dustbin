use Mix.Config

config :data, Dustbin.Data.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  database: "dustbin_#{Mix.env}",
  hostname: "localhost"
