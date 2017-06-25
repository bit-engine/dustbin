use Mix.Config

# Ecto - No repos
config :scheduler, ecto_repos: []

# Logger
config :logger, level: :debug

import_config "#{Mix.env}.exs"
