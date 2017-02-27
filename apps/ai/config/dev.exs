use Mix.Config

config :ai,
  wit_access_token: Path.join([__DIR__, "tokens.txt"]) |> File.read! |> String.trim
