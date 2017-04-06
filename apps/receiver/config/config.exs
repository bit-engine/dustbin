# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :receiver, Receiver.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1hHjV3VT79d8jGn603/fHNeipVn43W6cX5v6dXJR0TaiC9RGsfnD0F2z7895pcQS",
  render_errors: [view: Receiver.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Receiver.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :receiver, fb_verify_token: System.get_env("FB_VERIFY_TOKEN")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
