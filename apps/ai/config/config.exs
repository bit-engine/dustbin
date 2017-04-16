use Mix.Config

config :ai, ecto_repos: []

config :xend,
  fb_page_access_token: System.get_env("FB_PAGE_ACCESS_TOKEN")

import_config "#{Mix.env}.exs"

