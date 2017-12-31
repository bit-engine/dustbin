use Mix.Config

config :data, Dustbin.Data.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "dustbin",
  database: "dustbin_#{Mix.env}",
  hostname: "localhost"
