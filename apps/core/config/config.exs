use Mix.Config

# Logger
config :logger, level: :debug

# Repo
config :core, ecto_repos: [Core.Repo]

# Config
import_config "#{Mix.env}.exs"
