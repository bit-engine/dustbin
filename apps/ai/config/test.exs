use Mix.Config

config :ai,
  wit_access_token: System.get_env("WIT_ACCESS_TOKEN")

config :ai,
  wit_api: AI.WitSandbox


config :xend,
  fb_page_access_token: System.get_env("FB_PAGE_ACCESS_TOKEN")
