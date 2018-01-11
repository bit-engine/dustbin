# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  namespace: Dustbin.API

config :api, ecto_repos: []

config :api, Dustbin.APIWeb.Gettext,
  default_locale: "en"

# Configures the endpoint
config :api, Dustbin.APIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v0Iua6r5A3TE+toVLBmL7alZ1VRknlYi5f6YGkahkAsN810pnQ5x/WJcFCk0y0ib",
  render_errors: [view: Dustbin.APIWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dustbin.API.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
