use Mix.Config

# Logger
config :logger, level: :debug

# Repo
config :data, ecto_repos: [Dustbin.Data.Repo]

# Config
import_config "#{Mix.env}.exs"
