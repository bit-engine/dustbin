# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :master_app,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"L?Ivc{t^yTQ1x$a%;[6HJjTZZzB_(ixbg{@~MDEHpT?B6P=Xd0PR_/zPeLR3S}l!"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"6OgkGjGN5X|X)KetmxRJ6k(UDqDze6WCeGu>(32Z4Q>DV06:1dcli0NE5k,Tg~Y7"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :master_app do
  set version: "0.1.0"
  set applications: [
    :master_app,
    :scheduler,
    :core,
    :receiver,
    :ai,
    :runtime_tools,
    :edeliver,
    oauther: :load, 
  ]
  set commands: [
    "migrate": "rel/commands/migrate.sh",
    "seed": "rel/commands/seed.sh",
    "create": "rel/commands/create.sh",
    "drop": "rel/commands/drop.sh"
  ]
  set :output_dir: "rel/master_app"
end

