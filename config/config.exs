# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dustbin,
  ecto_repos: [Dustbin.Repo]

# Configures the endpoint
config :dustbin, Dustbin.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FQvF6uZtIZElQo8VCLo1lQYP4SG/MJS4Wf/3GS5dW/6AEkahoLLnLX7m/b9VpMzU",
  render_errors: [view: Dustbin.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dustbin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
