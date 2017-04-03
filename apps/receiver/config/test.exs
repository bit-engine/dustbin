use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :receiver, Receiver.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :receiver, fb_verify_token: "DUMMY_TOKEN"
